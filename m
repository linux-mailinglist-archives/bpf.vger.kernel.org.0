Return-Path: <bpf+bounces-11251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3017B648E
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 10:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 906A21C208E1
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 08:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DEBDDB1;
	Tue,  3 Oct 2023 08:44:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04553FC2
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 08:44:26 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C046FAD;
	Tue,  3 Oct 2023 01:44:23 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c724577e1fso4927895ad.0;
        Tue, 03 Oct 2023 01:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696322663; x=1696927463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9i4lTlGpn05Zib6O3CFGJDGsZ1WXq3wp2jJyI4hXGQ=;
        b=ItklvqAOlbJyF2yYnQ4uGMLpl9Mb5wguTz5ECBBDTQ26hfJbbA6Uvq9SGgM89T71CU
         1pMfhdLscLouaAuPyDHiG59hR0cxsz82isV8WuXUZXbu2nv2tGXLsodPh4TkZ4K5iU9m
         q+Hrp0b6EWWwjzRz29cihBReZpruwRNIXMdGGuAPuRhIjZn+CKZ43VhpDUiB0vVq7yng
         ZY+fCZnoURNUQD6f8LhTCkmYgKv9PdzGMp0CtlkpPTCesE5ZBhnYaNaHgbUtFu+olUtz
         CST1YKl8PLRh32KYaL2wT+mSSlMmCY0mjPxB0lylWvNu1JAEQ6b0nNxvQVLviRMT2ncj
         T8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696322663; x=1696927463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9i4lTlGpn05Zib6O3CFGJDGsZ1WXq3wp2jJyI4hXGQ=;
        b=XO9aNCV9lGUfFYN8Jcn1sp3KHmxDnaaSxypFpOpHS9/n8UfHor6MVtUMa4RNx8IClS
         ujnX1CwFGJEnQ0tuJyT8cw65hSN6RtbeL8sB8huECsSPqPo7OQIEisuEpzVcSNd45b6C
         rOd37GV1dnBujMtXRL14r2y/sFoLPHQ09Ev0jKa3k8+e2YI+Z3VgaEPvnXrjNvcUz3xC
         44Fr/VbxP89wuxlpsBNcelwjEUOw1OMnXDjKUtsVfr9zJJyuLaL7ibtLVTo6kqATv3yS
         qBdfWj/TF60Uo/Ex/QArifnggrkAaRTpcY2CdxmRG7UOXel48g/EvEqmXC9s2P/Pu8Vw
         meVA==
X-Gm-Message-State: AOJu0Yz9sxTzPUdH6hxB/HhJGc75bap7iGzvqbZTrtUSc9nvF5AoOGsc
	MVtPKo/QqnJd77yYQux8cClVUrDf49e3eV+o
X-Google-Smtp-Source: AGHT+IGYvwpPhBOWnPj3E+B8p+EGfawGgwVnieJzaZ/afbFpwUE5/JQlTnYl0C5IuSUheZhFKv2d2w==
X-Received: by 2002:a17:903:2348:b0:1c7:2661:91e1 with SMTP id c8-20020a170903234800b001c7266191e1mr16827636plh.15.1696322662929;
        Tue, 03 Oct 2023 01:44:22 -0700 (PDT)
Received: from ubuntu.. ([113.64.184.44])
        by smtp.googlemail.com with ESMTPSA id y16-20020a17090322d000b001bc445e249asm902876plg.124.2023.10.03.01.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 01:44:22 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: keescook@chromium.org,
	luto@amacapital.net,
	wad@chromium.org,
	alexyonghe@tencent.com,
	hengqi.chen@gmail.com
Subject: [RFC PATCH 1/2] seccomp: Introduce SECCOMP_LOAD_FILTER operation
Date: Tue,  3 Oct 2023 08:38:35 +0000
Message-Id: <20231003083836.100706-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003083836.100706-1-hengqi.chen@gmail.com>
References: <20231003083836.100706-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds a new operation named SECCOMP_LOAD_FILTER.
It accepts the same arguments as SECCOMP_SET_MODE_FILTER
but only performs the loading process. If succeed, return a
new fd associated with the JITed BPF program (the filter).
The filter can then be pinned to bpffs using the returned
fd and reused for different processes.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 include/uapi/linux/seccomp.h |  1 +
 kernel/seccomp.c             | 64 ++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index dbfc9b37fcae..ee2c83697810 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -16,6 +16,7 @@
 #define SECCOMP_SET_MODE_FILTER		1
 #define SECCOMP_GET_ACTION_AVAIL	2
 #define SECCOMP_GET_NOTIF_SIZES		3
+#define SECCOMP_LOAD_FILTER		4
 
 /* Valid flags for SECCOMP_SET_MODE_FILTER */
 #define SECCOMP_FILTER_FLAG_TSYNC		(1UL << 0)
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 255999ba9190..7aff22f56a91 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1996,12 +1996,71 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	seccomp_filter_free(prepared);
 	return ret;
 }
+
+static long seccomp_load_filter(const char __user *filter)
+{
+	struct sock_fprog fprog;
+	struct bpf_prog *prog;
+	int ret = -EFAULT;
+	const bool save_orig =
+#if defined(CONFIG_CHECKPOINT_RESTORE) || defined(SECCOMP_ARCH_NATIVE)
+		true;
+#else
+		false;
+#endif
+
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall()) {
+		struct compat_sock_fprog fprog32;
+		if (copy_from_user(&fprog32, filter, sizeof(fprog32)))
+			goto out;
+		fprog.len = fprog32.len;
+		fprog.filter = compat_ptr(fprog32.filter);
+	} else /* falls through to the if below. */
+#endif
+	if (copy_from_user(&fprog, filter, sizeof(fprog)))
+		goto out;
+
+	ret = -EINVAL;
+	if (fprog.len == 0 || fprog.len > BPF_MAXINSNS)
+		goto out;
+
+	BUG_ON(INT_MAX / fprog.len < sizeof(struct sock_filter));
+
+	ret = bpf_prog_create_from_user(&prog, &fprog, seccomp_check_filter, save_orig);
+	if (ret < 0)
+		goto out;
+
+	ret = security_bpf_prog_alloc(prog->aux);
+	if (ret) {
+		ret = -EINVAL;
+		goto prog_free;
+	}
+
+	prog->aux->user = get_current_user();
+	atomic64_set(&prog->aux->refcnt, 1);
+
+	ret = bpf_prog_new_fd(prog);
+	if (ret < 0)
+		bpf_prog_put(prog);
+	return ret;
+
+prog_free:
+	bpf_prog_free(prog);
+out:
+	return ret;
+}
 #else
 static inline long seccomp_set_mode_filter(unsigned int flags,
 					   const char __user *filter)
 {
 	return -EINVAL;
 }
+
+static inline long seccomp_load_filter(const char __user *filter)
+{
+	return -EINVAL;
+}
 #endif
 
 static long seccomp_get_action_avail(const char __user *uaction)
@@ -2063,6 +2122,11 @@ static long do_seccomp(unsigned int op, unsigned int flags,
 			return -EINVAL;
 
 		return seccomp_get_notif_sizes(uargs);
+	case SECCOMP_LOAD_FILTER:
+		if (flags != 0)
+			return -EINVAL;
+
+		return seccomp_load_filter(uargs);
 	default:
 		return -EINVAL;
 	}
-- 
2.34.1


