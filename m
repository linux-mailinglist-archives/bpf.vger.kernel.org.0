Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3695E2A9484
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 11:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgKFKhx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Nov 2020 05:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgKFKhw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Nov 2020 05:37:52 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC385C0613CF
        for <bpf@vger.kernel.org>; Fri,  6 Nov 2020 02:37:51 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id d142so882165wmd.4
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2020 02:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Qkos45I7JBc99J3NgQI9X1LqhcBblXueuCbnD5Pdqg=;
        b=i0Ong8IPvb2lWGPR7stBTKuuaNzBSmz7c+VJwEiIuvMVKc5ieonaEh04yJykNDiwDP
         fuhQvGEr9S5vLD+qxMOhTcKM37SiikdhHgJ0eV8XFtPsmrvjmBC8BbjtMXAwh5nc03q5
         80BQ0bFS23QTZUFGSSW21Gy2oM2pRZIT3U2tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Qkos45I7JBc99J3NgQI9X1LqhcBblXueuCbnD5Pdqg=;
        b=Bm31wd7ETq4kXQOvRrNhT2v6dAVWyP9c/0a3z5kogWwc5nJsrN7728Km0/bq9PhC2Z
         mJIturHwsAe12O5CYLvA3XZ1XDmpUpHZeg5M8Un/dZrzvgjR3MULIvCRQsFQW6IOTqqE
         MTnoVOgSAKNU/AhVqANNoKwES4fHfyzVfBUxebTkfXW1SUKWn1/SLDD4m2qfsEbQVA9u
         qsei3QYB+BnsTJ0PB93gSRWJtu3vtjOaD0LDeV2Vpt8kjk9swOLO6vR1bC1R2sGJQnnF
         TsxmpiNe0AsQ7/7UJZG1CyS5jFhObhXDD4swMRJRjmmMZ5gaj7WaHj2kFY6qfbFmnxQ9
         CeaA==
X-Gm-Message-State: AOAM532Zb2J9ZupuFF0Zit1dhreuMboAz5quSm6czY1868jlko9Xd5Up
        mLpAjoEE3EflKILCgdFw4X7mUA==
X-Google-Smtp-Source: ABdhPJxDBHCb2W1AA8RRfOQBWh7em5W3zZS6RGu9a+0dDvdK6kWYOCLFGjVwLiNStdc8DWgm4GDT9Q==
X-Received: by 2002:a7b:c0d7:: with SMTP id s23mr1851735wmh.54.1604659070531;
        Fri, 06 Nov 2020 02:37:50 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id t1sm1537639wrs.48.2020.11.06.02.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 02:37:49 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v6 1/9] bpf: Allow LSM programs to use bpf spin locks
Date:   Fri,  6 Nov 2020 10:37:39 +0000
Message-Id: <20201106103747.2780972-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106103747.2780972-1-kpsingh@chromium.org>
References: <20201106103747.2780972-1-kpsingh@chromium.org>
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

