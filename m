Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B2B42ACCA
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 20:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhJLTBE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 15:01:04 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:37601 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbhJLTBE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Oct 2021 15:01:04 -0400
Received: by mail-ed1-f42.google.com with SMTP id y12so217450eda.4;
        Tue, 12 Oct 2021 11:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9V95ffgMHOrwfuXJ84tWAtoIxZvT01AdMuAmxrjOHyQ=;
        b=DWA3eLRXwnqXB1sQASCYiWVqbuy+VxFHbAX2y3UqNf9HWFTeBBqU6xiec7l2GFPPFq
         9UnX1LyJMBPzNgnfZ1Er+37AvNWSaKfrFbbZEIWvh/mmwv49d6bLnAWu1eW0wUgDhflo
         W+nyDs3aC5rkoJ+hsTzGdoGGXuzdbd6eykbZgbpyWXgr6LSwDu0rVZPQ9jeiGLASJnyW
         9GNMwmAro8WvuOsfYSVe2ae0MT7nVqQrSl74dpYuoagff7khDWEYfaFL5KYt/oyJDfM8
         2t8xFDq8Dssu5kbMV9ujZ6ysUibjin4jDtSz39mHqsQ3hO7L7jnAR4BywULAuFCUtIg3
         s40g==
X-Gm-Message-State: AOAM530cKgVj5KFosYgMsfCQmU0HUZxmlcpla3wmyzsHXm7xGYu4Lcm4
        V7YbdsJZBNuU3YTc0rRp49sDsrnKyc4=
X-Google-Smtp-Source: ABdhPJwBE6sVmTHFIZCXTDV+udxpa6tXe+gwau88hp1itQJYNnaOLo3l4vIpRCFhjtTlQllg08bjPw==
X-Received: by 2002:a17:906:f184:: with SMTP id gs4mr35776616ejb.116.1634065141015;
        Tue, 12 Oct 2021 11:59:01 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-2-34-36-22.cust.vodafonedsl.it. [2.34.36.22])
        by smtp.gmail.com with ESMTPSA id w18sm6169701edc.4.2021.10.12.11.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:59:00 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Luca Boccassi <bluca@debian.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFC bpf-next 1/2] bpf: add signature to eBPF instructions
Date:   Tue, 12 Oct 2021 20:58:58 +0200
Message-Id: <20211012185858.54637-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

When loading a BPF program, pass a signature which is used to validate
the instructions.
The signature type is the same used to validate the kernel modules.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 include/uapi/linux/bpf.h |  2 ++
 kernel/bpf/syscall.c     | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c2b8857b8a1c..b9d259f26e92 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1336,6 +1336,8 @@ union bpf_attr {
 		};
 		__u32		:32;		/* pad */
 		__aligned_u64	fd_array;	/* array of FDs */
+		__aligned_u64	signature;	/* instruction's signature */
+		__u32		sig_len;	/* signature size */
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3c349b244a28..5589f655033d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -31,6 +31,8 @@
 #include <linux/bpf-netns.h>
 #include <linux/rcupdate_trace.h>
 #include <linux/memcontrol.h>
+#include <linux/verification.h>
+#include <linux/module_signature.h>
 
 #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
 			  (map)->map_type == BPF_MAP_TYPE_CGROUP_ARRAY || \
@@ -2156,7 +2158,7 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 }
 
 /* last field in 'union bpf_attr' used by this command */
-#define	BPF_PROG_LOAD_LAST_FIELD fd_array
+#define	BPF_PROG_LOAD_LAST_FIELD sig_len
 
 static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 {
@@ -2274,6 +2276,35 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 			     bpf_prog_insn_size(prog)) != 0)
 		goto free_prog_sec;
 
+	if (attr->sig_len) {
+		char *signature;
+
+		signature = kmalloc(attr->sig_len, GFP_USER);
+		if (!signature) {
+			err = -ENOMEM;
+			goto free_prog_sec;
+		}
+
+		if (copy_from_user(signature, (char *)attr->signature, attr->sig_len)) {
+			err = -EFAULT;
+			kfree(signature);
+			goto free_prog_sec;
+		}
+
+		err = verify_pkcs7_signature(prog->insns,
+					     prog->len * sizeof(struct bpf_insn),
+					     signature, attr->sig_len,
+					     VERIFY_USE_SECONDARY_KEYRING,
+					     VERIFYING_MODULE_SIGNATURE,
+					     NULL, NULL);
+		kfree(signature);
+
+		if (err) {
+			printk("verify_pkcs7_signature(): %pe\n", (void*)(uintptr_t)err);
+			goto free_prog_sec;
+		}
+	}
+
 	prog->orig_prog = NULL;
 	prog->jited = 0;
 
-- 
2.33.0

