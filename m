Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF6E2A8154
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 15:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbgKEOsC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 09:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731006AbgKEOsA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 09:48:00 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3DEC0613D3
        for <bpf@vger.kernel.org>; Thu,  5 Nov 2020 06:48:00 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id cw8so3004218ejb.8
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 06:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7NO+usjNmZBvJhP1wAAzDEKxGoFFIuwRbvjSAV2ok+Q=;
        b=YN2nTDbLV+u/KLKLVDkF74f4LwSJRKl48CgXnA3ZLXv5QmpPfDqhQF+0D8oOSms+9T
         ZFBDFDML0YZoZWVi7zfgPY5Ddz9COkwwEU0xgnySrngvzyqmInP2kFemva96FbPvo5rb
         CzhnzN1Zd337f69VHF+EZK9zy7xQqnX5qrt+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7NO+usjNmZBvJhP1wAAzDEKxGoFFIuwRbvjSAV2ok+Q=;
        b=NYzkZaFMH67FkOOjxzJO/Yz5YrZ2tOt2+MQBVMmN+Uoo5i0ROLVJ/wbBOZ9iDW8YzU
         m8LcXPL85JBp4IG1RwbvrIELmy2AVQfDKLEqM47yyUDm7rBy8QhV/k45fuBNsW1GJibI
         DFK8b7L9mIz9YT/j9ke4IYIGE5XjDGKdKDBXHcapeVyft8mZf6+wnqAup0LDdwgunBHS
         7UfluAPYh9124snujpY9yPuez/K9/KXP3k7nZlbR8ATZtmPXY3K0nDlpjPNnGzMPH+Tb
         M2g53B2D/q13xEylatM1LBqZ3MqUJvmAx4sSF1Y2ym3CJJHzMtN/z7epzmfaaoAnanFE
         ot/w==
X-Gm-Message-State: AOAM5329ivMz5DCw+1pV2lNiZQqB9nxj9ccnDZKsNJwhtGPb8Rt506G5
        B1z8hMifQopOui0rBVvCVgiG9K9NwapZF8mo
X-Google-Smtp-Source: ABdhPJxObOsTx3qb3uOrSoCLgiHu1aS+SMzkHt0p1VB4Fd1lZjqOYaAe0RfpKr5y7C556BsyinOTOg==
X-Received: by 2002:a17:906:2490:: with SMTP id e16mr2586864ejb.17.1604587679248;
        Thu, 05 Nov 2020 06:47:59 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id z13sm1075870ejp.30.2020.11.05.06.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:47:58 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v4 1/9] bpf: Allow LSM programs to use bpf spin locks
Date:   Thu,  5 Nov 2020 15:47:47 +0100
Message-Id: <20201105144755.214341-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201105144755.214341-1-kpsingh@chromium.org>
References: <20201105144755.214341-1-kpsingh@chromium.org>
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

