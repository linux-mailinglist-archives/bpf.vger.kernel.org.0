Return-Path: <bpf+bounces-11777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C2B7BF095
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 04:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20BC281ADB
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 02:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF4715A4;
	Tue, 10 Oct 2023 02:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkNA4XiJ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC561364
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 02:02:30 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C9FC4;
	Mon,  9 Oct 2023 19:02:28 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68bed2c786eso3754521b3a.0;
        Mon, 09 Oct 2023 19:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696903347; x=1697508147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MoH5lgYSa4yL07ZT7yepVJBaBTQBgOgS38SCCkBf/E=;
        b=VkNA4XiJCcYgdEC+Ky7EqMyfww1g5Sblz3/KxOvRVW+/HCI7n8YcHO2bLqF7O2lAvn
         sV7/UBqJZ5Ds/z6RQAiGIfIQ9V2Gwbzkg9Pmu36eZLl6bMxlWd50EhQLSiTamSyu9jZe
         YF8Fs6Z0G3lwKvncVe7l7NhdhenkpK2mK2p3n/N6k0A25uRokp0uGseUFjKZnB8Mc6Ud
         aGLwPWQTYlLThMNqDru89H7Cscbyjpz/g25JSsYgXKLdMZIcZTu2ixjxClJvCq8L6gkm
         52QYmn8fC7SYwb+bdw2aRbXpqWwwFuddFEV9wel1gAzWrG9KMxwJ9SEZ4l0AOnj9T9s1
         hnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696903347; x=1697508147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MoH5lgYSa4yL07ZT7yepVJBaBTQBgOgS38SCCkBf/E=;
        b=CpvTlZxNxjxZvOeOxjNOAz9nwv0sHEWBumxri9DbgMKvMPlTYgpQGx/xT9rpouMlJY
         QWS8X5Mo6rcnnz6OeWUBbyV02a1Dv2SomhXznAo9yUkzroNS8sXfg3JRur8+TcfM988I
         F3S04I8B0UOnVf9XbzwtEWtriwC6zMQOOT9WHJZUelrNbKn669/Ywv7VvrMEr3gpEu0s
         Zp7ndTHXa6pnWI0GviPHz/kpZ8XHLrRB4i0zHlqaymxGDw+xswjd7+H5c9GXsm2UxRV1
         f2gtIYoMMO0OHPgpLwwzAecOLHMgJL5dNH5nxyGJroXANqu2DzJu0F+KbRer09O4K32N
         H5ug==
X-Gm-Message-State: AOJu0YyP/EbMAvDV1V4InvfBBUyC9XYO5uFcJHpnY28Kcigd0o+7yKbc
	mrKHRArq1jqo80Z4LK37dE23XJU+xE0a1g==
X-Google-Smtp-Source: AGHT+IFZ/JOWKfabCyPw57Q82PGBI8uzT/7hVs4Jv5zX/5FelL9FcdkRQfpTCRDGQbYAeU81PTl/SA==
X-Received: by 2002:a05:6a20:cea8:b0:171:878f:8f9b with SMTP id if40-20020a056a20cea800b00171878f8f9bmr1060823pzb.26.1696903347428;
        Mon, 09 Oct 2023 19:02:27 -0700 (PDT)
Received: from ubuntu.. ([43.132.98.112])
        by smtp.googlemail.com with ESMTPSA id t28-20020aa7939c000000b0068a46cd4120sm7044809pfe.199.2023.10.09.19.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 19:02:27 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: keescook@chromium.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	alexyonghe@tencent.com,
	hengqi.chen@gmail.com
Subject: [PATCH 2/4] seccomp, bpf: Introduce SECCOMP_LOAD_FILTER operation
Date: Mon,  9 Oct 2023 12:40:44 +0000
Message-Id: <20231009124046.74710-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009124046.74710-1-hengqi.chen@gmail.com>
References: <20231009124046.74710-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds a new operation named SECCOMP_LOAD_FILTER.
It accepts the same arguments as SECCOMP_SET_MODE_FILTER
but only performs the loading process. If succeed, return a
new fd associated with the JITed BPF program (the filter).
The filter can then be pinned to bpffs using the returned
fd and reused for different processes. To distinguish the
filter from other BPF progs, BPF_PROG_TYPE_SECCOMP is added.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 include/uapi/linux/bpf.h     |  1 +
 include/uapi/linux/seccomp.h |  1 +
 kernel/seccomp.c             | 40 ++++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 70bfa997e896..8890fb776bbb 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -995,6 +995,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	BPF_PROG_TYPE_SECCOMP,
 };
 
 enum bpf_attach_type {
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
index 37490497f687..3ae43db3b642 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2028,12 +2028,47 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	seccomp_filter_free(prepared);
 	return ret;
 }
+
+static long seccomp_load_filter(const char __user *filter)
+{
+	struct sock_fprog fprog;
+	struct bpf_prog *prog;
+	int ret;
+
+	ret = seccomp_copy_user_filter(filter, &fprog);
+	if (ret)
+		return ret;
+
+	ret = seccomp_prepare_prog(&prog, &fprog);
+	if (ret)
+		return ret;
+
+	ret = security_bpf_prog_alloc(prog->aux);
+	if (ret) {
+		bpf_prog_free(prog);
+		return ret;
+	}
+
+	prog->aux->user = get_current_user();
+	atomic64_set(&prog->aux->refcnt, 1);
+	prog->type = BPF_PROG_TYPE_SECCOMP;
+
+	ret = bpf_prog_new_fd(prog);
+	if (ret < 0)
+		bpf_prog_put(prog);
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
@@ -2095,6 +2130,11 @@ static long do_seccomp(unsigned int op, unsigned int flags,
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


