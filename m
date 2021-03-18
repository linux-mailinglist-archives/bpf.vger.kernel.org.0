Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF7D340E45
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 20:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhCRTbf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 15:31:35 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:37469 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbhCRTbZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Mar 2021 15:31:25 -0400
Received: by mail-qk1-f178.google.com with SMTP id g15so429536qkl.4
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 12:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vvpNRJKAVW57zXV7q+4Xfj7x19d8NVclr/wTI6p5fZU=;
        b=ngc5j+IBE0M9Kb/O9QcphqIIcjQawJVRTNTgEnc2f+XsfgdwSwPG5xaxmAKMGjNexs
         z12EwGzqk9SByLnAtMfAjwE/UOZpvuMnJZZZHIolYrXlSrEaX3RBn01R3XOWOQFRzPIz
         rx91u60E5paL7SQUaQADEXVScsp1VblgIKr1ZGRAvdGK7tuBzCGZXC6yML1zEhpY1NOr
         zqT2iMSCAeMbClNmEsAW/7H7CMLYUgYgFAXQynzihLEqYbA3ShKsxtT60IoqN7WM0ost
         pOG4g5EYAFZK01d7re12fmzxBnZxvkcF0X8PrVdAnsJ/SBoR/+aPNktFxkh+stgN0Oo3
         OG6Q==
X-Gm-Message-State: AOAM531I+FFZX5PmAYl216jGr7hpBU2n+RrNlDRrq0l9ztDwx/QoEnba
        aCyuJvo7MW+R4DdZkDSlAg==
X-Google-Smtp-Source: ABdhPJzf9VjPAAx2mr1CKAksVeAJEXmCNp1XmLSyeKh47khIAIgiEw6TmakRgfZhK7eB3JZwInnsDQ==
X-Received: by 2002:a05:620a:16b1:: with SMTP id s17mr5855452qkj.302.1616095884818;
        Thu, 18 Mar 2021 12:31:24 -0700 (PDT)
Received: from fujitsu.celeiro.cu ([138.204.26.16])
        by smtp.gmail.com with ESMTPSA id 73sm2468687qkk.131.2021.03.18.12.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 12:31:24 -0700 (PDT)
From:   Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
To:     rafaeldtinoco@ubuntu.com
Cc:     andrii.nakryiko@gmail.com, bpf@vger.kernel.org
Subject: [PATCH] libbpf: allow bpf object kern_version to be overridden
Date:   Thu, 18 Mar 2021 16:31:21 -0300
Message-Id: <20210318193121.370561-1-rafaeldtinoco@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318062520.3838605-1-rafaeldtinoco@ubuntu.com>
References: <20210318062520.3838605-1-rafaeldtinoco@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Unfortunately some distros don't have their accurate kernel version
defined correctly in version.h due to long term support decisions. This
makes LINUX_VERSION_CODE to be defined as the original upstream version
in header, while the running in-kernel version is different.

Older kernels might still check kern_version during bpf_prog_load(),
making it impossible to load a program that could still be portable.
This patch allows one to override bpf objects kern_version attributes,
so program can bypass this in-kernel check during load.

Example:

A kernel 4.15.0-129.132, for example, might have 4.15.18 version defined
in its headers, which is the kernel it is based on, but have a 4.15.0
version defined within the kernel due to other factors.

$ export LIBBPF_KERN_VERSION=4.15.18
$ sudo -E ./portablebpf -v
...
libbpf: bpf object: kernel_version enforced by env variable: 266002
...

This will also help portable binaries within similar older kernels, as
long as they have their BTF data converted from DWARVES (for example).

Signed-off-by: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
---
 src/libbpf.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/src/libbpf.c b/src/libbpf.c
index 4dc09d3..cbc6e61 100644
--- a/src/libbpf.c
+++ b/src/libbpf.c
@@ -708,13 +708,19 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
 
 static __u32 get_kernel_version(void)
 {
-	__u32 major, minor, patch;
 	struct utsname info;
+	__u32 major, minor, patch, ver;
+	char *ptr, *e = getenv("LIBBPF_KERN_VERSION");
 
 	uname(&info);
-	if (sscanf(info.release, "%u.%u.%u", &major, &minor, &patch) != 3)
+	ptr = (e != NULL) ? e : (char *) &info.release;
+	if (sscanf(ptr, "%u.%u.%u", &major, &minor, &patch) != 3)
 		return 0;
-	return KERNEL_VERSION(major, minor, patch);
+	ver = KERNEL_VERSION(major, minor, patch);
+	if (e)
+		pr_debug("bpf object: kernel_version enforced by env variable: %u\n", ver);
+
+	return ver;
 }
 
 static const struct btf_member *
-- 
2.17.1

