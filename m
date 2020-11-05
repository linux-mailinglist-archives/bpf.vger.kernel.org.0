Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51B32A8A39
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 23:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732200AbgKEW6d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 17:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731899AbgKEW6d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 17:58:33 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA165C0613D3
        for <bpf@vger.kernel.org>; Thu,  5 Nov 2020 14:58:32 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id n18so3609396wrs.5
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 14:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Qkos45I7JBc99J3NgQI9X1LqhcBblXueuCbnD5Pdqg=;
        b=k+zEluKdNybMDZtlS4A6ctNGgTFjuhkY2YgtaboNnhKRvt13Remia9aEaiMPknMPsG
         L/j1Sr7skQplkNWmyAhvsR5wp0J1sEdVaHJSxWzT8OApd/ADMOX+BTfA1oG07wDSJbLt
         ZtA3KDB03hAcPe0c1Q3k8sI0sr4h/lAbzoB5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Qkos45I7JBc99J3NgQI9X1LqhcBblXueuCbnD5Pdqg=;
        b=RiLjpvAH8elVcDzGs1oKA8KFcqkDtzDgafEYvtIbvropkO3DPECx3byfoztXkBG7bh
         MBzLPm3HGpW6wvDNX4wvieknSZNtt5a/ROHjeGQfUwQ9j/ZROxgMC+5wOm33OuwSeoy8
         b3Rvk8kW9+kgIpWiiQH5zqrHLt0FiSOBjhCrbkytOgnvErNbx6j9IhivDU7IIJ4FhvvZ
         GyAYaQrp26YkBTolHKksZaWHo8Bk0cZ9XYlnpjASR72qB43tlgtGUmPWagZ08inFXG7S
         CdAqxjMPKdVYudfWVM8QXVC6h6slo1FDSgdvOI3bwm4+WMCV391oN0xwn2uq2pMz3WR4
         7UAg==
X-Gm-Message-State: AOAM533XrD1uvaV2xXLn16x2RWEut8pYg6TgmsLBq/EITw1qQBe9PtBp
        ONyLS5CfBfcXdpjx9KAoYweQbXRE/tGjVJg1
X-Google-Smtp-Source: ABdhPJxJFa5cjZi4YJ9R9pFeSs06ZU/ffoGxkCQa1v29df5UT1LUcNNpHyavQye7D0uH3eRpDFseyA==
X-Received: by 2002:a5d:4e10:: with SMTP id p16mr5635129wrt.191.1604617111379;
        Thu, 05 Nov 2020 14:58:31 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id f19sm3977366wml.21.2020.11.05.14.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 14:58:30 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v5 1/9] bpf: Allow LSM programs to use bpf spin locks
Date:   Thu,  5 Nov 2020 22:58:19 +0000
Message-Id: <20201105225827.2619773-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201105225827.2619773-1-kpsingh@chromium.org>
References: <20201105225827.2619773-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Usage of spin locks was not allowed for tracing programs due to
insufficient preemption checks. The verifier does not currently prevent
LSM programs from using spin locks, but the helpers are not exposed
via bpf_lsm_func_proto.

Based on the discussion in [1], non-sleepable LSM programs should be
able to use bpf_spin_{lock, unlock}.

Sleepable LSM programs can be preempted which means that allowng spin
locks will need more work (disabling preemption and the verifier
ensuring that no sleepable helpers are called when a spin lock is held).

[1]: https://lore.kernel.org/bpf/20201103153132.2717326-1-kpsingh@chromium.org/T/#md601a053229287659071600d3483523f752cd2fb

Acked-by: Song Liu <songliubraving@fb.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 kernel/bpf/bpf_lsm.c  |  4 ++++
 kernel/bpf/verifier.c | 20 +++++++++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 78ea8a7bd27f..cd8a617f2109 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -59,6 +59,10 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_storage_get_proto;
 	case BPF_FUNC_sk_storage_delete:
 		return &bpf_sk_storage_delete_proto;
+	case BPF_FUNC_spin_lock:
+		return &bpf_spin_lock_proto;
+	case BPF_FUNC_spin_unlock:
+		return &bpf_spin_unlock_proto;
 	default:
 		return tracing_prog_func_proto(func_id, prog);
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6200519582a6..f863aa84d0a2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9719,11 +9719,21 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		verbose(env, "trace type programs with run-time allocated hash maps are unsafe. Switch to preallocated hash maps.\n");
 	}
 
-	if ((is_tracing_prog_type(prog_type) ||
-	     prog_type == BPF_PROG_TYPE_SOCKET_FILTER) &&
-	    map_value_has_spin_lock(map)) {
-		verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
-		return -EINVAL;
+	if (map_value_has_spin_lock(map)) {
+		if (prog_type == BPF_PROG_TYPE_SOCKET_FILTER) {
+			verbose(env, "socket filter progs cannot use bpf_spin_lock yet\n");
+			return -EINVAL;
+		}
+
+		if (is_tracing_prog_type(prog_type)) {
+			verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
+			return -EINVAL;
+		}
+
+		if (prog->aux->sleepable) {
+			verbose(env, "sleepable progs cannot use bpf_spin_lock yet\n");
+			return -EINVAL;
+		}
 	}
 
 	if ((bpf_prog_is_dev_bound(prog->aux) || bpf_map_is_dev_bound(map)) &&
-- 
2.29.1.341.ge80a0c044ae-goog

