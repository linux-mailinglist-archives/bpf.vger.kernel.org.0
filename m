Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F93467E0B
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 20:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbhLCTWm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 14:22:42 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:38640 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343740AbhLCTWk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 14:22:40 -0500
Received: by mail-wr1-f49.google.com with SMTP id q3so7725765wru.5;
        Fri, 03 Dec 2021 11:19:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1PVIMSPAm7GEVscdrwf8dIryOUX0/IKNiUF+lLBrVvA=;
        b=ZLUtmTNMXflrjYzKJhOmKA0hunpTByNzEVfDrsRrGfL3uqsQWxLtr40UPveksPFAhR
         7f0CBseqpm0VCZyRrKxdJ8eg3iwLmno+Lvo/Jbq4XE+FQkMtCIgtRrTZ/CUQ/Fm2hcAv
         1u0DtxUwaMmgOOdvtfL7WkzHvWOGuicpJEfHhEdm+h5emsy0IV+epuQhEtrAecCoZdTt
         O4qoGf/z3iK4Y02ElwsJoaDQPPnzk6cLi0G22BHB6FMNODm8CpRNdX3+GlgGku2Nk8/w
         xr7PI5zqM2vmtG1A81CFNR1Wdhknvi10j1s+YFJQ1rG7k4FDW8i3vRecZ/sl+3r+NZ8Y
         LlIQ==
X-Gm-Message-State: AOAM531npCYZ39xvkxZhU4E26Eozed7flJE+RLvEFYWqWupoM/VUuTnc
        tw5Y+qUDWEp3V3JA1UtUGgQD3H0DD7veww==
X-Google-Smtp-Source: ABdhPJyzyDCIXrNaQiKVIEeh3U5ag8Sm78CN7ymSJ5QadWDMsN7YjLzRy7YciMRL6qs1mn+YY4Fypw==
X-Received: by 2002:a5d:6111:: with SMTP id v17mr24289293wrt.512.1638559155082;
        Fri, 03 Dec 2021 11:19:15 -0800 (PST)
Received: from t490s.teknoraver.net (net-37-117-189-149.cust.vodafonedsl.it. [37.117.189.149])
        by smtp.gmail.com with ESMTPSA id z14sm3472374wrp.70.2021.12.03.11.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 11:19:14 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        Luca Boccassi <bluca@debian.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH bpf-next 2/3] bpf: add option to require BPF signature
Date:   Fri,  3 Dec 2021 20:18:43 +0100
Message-Id: <20211203191844.69709-3-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211203191844.69709-1-mcroce@linux.microsoft.com>
References: <20211203191844.69709-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Add a compile time option which makes the BPF signature mandatory,
i.e. all programs without signature or with an invalid one are rejected.

CO-RE programs load a program of type BPF_PROG_TYPE_SYSCALL, which then
uses the bpf() syscall to load the final program. This one won't have any
signature, so never enforce signature for programs coming from the kernel.

This happens when loading a program with a missing signature:

    # ip link set lo xdp object xdp.o
    [ 8677.652546] Rejecting BPF '' with no signature

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 kernel/bpf/Kconfig   | 6 ++++++
 kernel/bpf/syscall.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index 735979bb8672..fe6e84abe84c 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -87,6 +87,12 @@ config BPF_SIG
 	  Check BPF programs for valid signatures upon load: the signature
 	  is passed via the bpf() syscall together with the instructions.
 
+config BPF_SIG_FORCE
+	bool "Require BPF to be validly signed"
+	depends on BPF_SIG
+	help
+	  Reject unsigned BPF or signed BPF for which we don't have a key.
+
 source "kernel/bpf/preload/Kconfig"
 
 config BPF_LSM
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5aaa74a72b46..9e36614719fd 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2340,6 +2340,10 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 				prog->aux->name, ERR_PTR(err));
 			goto free_prog_sec;
 		}
+	} else if (IS_ENABLED(CONFIG_BPF_SIG_FORCE) && !uattr.is_kernel) {
+		pr_warn("Rejecting BPF '%s' with no signature\n", prog->aux->name);
+		err = -EKEYREJECTED;
+		goto free_prog_sec;
 	}
 #endif
 
-- 
2.33.1

