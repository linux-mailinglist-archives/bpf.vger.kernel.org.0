Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F8C42ACD2
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 21:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhJLTCi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 15:02:38 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:38455 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhJLTCh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Oct 2021 15:02:37 -0400
Received: by mail-ed1-f50.google.com with SMTP id d9so217519edh.5;
        Tue, 12 Oct 2021 12:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9V95ffgMHOrwfuXJ84tWAtoIxZvT01AdMuAmxrjOHyQ=;
        b=kKgoa/4vrsR4TAnA8GNr/YUn5DK7xDRAtZz2B712nkqp9AfNEo4gaquBijaKOApJWT
         3dF6ZhIGwEEFCBqURm3djJw/DJP+xikFqm5HyACVGtnSbWmlVlpjmFXZkESoeOKvVmjJ
         twu/A6GPO8u39xNOzwVK6EIPVO4IQPsuHsT1LBxV7T6u3fQpmrMCxbN3MI6QlqznhaS/
         SSa2ednpKor1DNqGe/QT5LAD8v6aE2+RDp4CBhvh4Y5VBigEVq1qLeubTBDofs2JG1KJ
         TLFaTCdkj3fFDQH0YZB1CwK4GMxnAr+9LjzpBqC+Uq7F4j/Jbc6GwYl36KoNE3jqq9Ip
         qncQ==
X-Gm-Message-State: AOAM532X+uPIqXyz876uADeWyzRZEQY7Led7HAX1KxG1+wSsKx+KrydQ
        D3pFmUmLJs58327L7DMNHXQZgIHfpEc=
X-Google-Smtp-Source: ABdhPJwiTnh1yK4QurNIEHyHNRO03t7Ms6yoNvw0Y0VymPlJoBbklx43TDRYVtlVGC7mpOwq5cU2RA==
X-Received: by 2002:a17:906:c2ca:: with SMTP id ch10mr35844811ejb.311.1634065234016;
        Tue, 12 Oct 2021 12:00:34 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-2-34-36-22.cust.vodafonedsl.it. [2.34.36.22])
        by smtp.gmail.com with ESMTPSA id g7sm4802965edu.48.2021.10.12.12.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 12:00:33 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Luca Boccassi <bluca@debian.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFC bpf-next 1/2] bpf: add signature to eBPF instructions
Date:   Tue, 12 Oct 2021 21:00:27 +0200
Message-Id: <20211012190028.54828-2-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012190028.54828-1-mcroce@linux.microsoft.com>
References: <20211012190028.54828-1-mcroce@linux.microsoft.com>
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

