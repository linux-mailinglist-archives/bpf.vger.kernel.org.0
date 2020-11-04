Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C802A6A1F
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 17:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbgKDQpI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 11:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731043AbgKDQpH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Nov 2020 11:45:07 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A84C0613D4
        for <bpf@vger.kernel.org>; Wed,  4 Nov 2020 08:45:04 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id o18so23181822edq.4
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2020 08:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I8ORd8n0GCz8/VWFP7UNDAGd9bETQoD24YnGd+L6HAY=;
        b=BQG4P0yDQ9bEl7tatLujuorpRwbF4nTOYDgXLQ080yzjV4GYX9pD7kjED2wP9QHsvC
         Y60SVAn3+uQtttaFSJWo3AgfsSntobmHVd0LAJxnOLngez0ti0hJQ6JkvkhfM2kqT7tB
         SVVOEcnSzBUcCBnDDRUoZlspEjaRviA6zLREg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I8ORd8n0GCz8/VWFP7UNDAGd9bETQoD24YnGd+L6HAY=;
        b=QXO5G+fj/Zbr4Frl+XCBfSOry42NyFsIx5kCToYCsIH072lnSbmNHMcOTzqMioyf69
         j5qnBdJxI5WBpmDuWmr8HWAlXrbsNrcGKeQSXIaXm9My+K3ZYkT1oEYBdnnaISaatrb0
         jWANXojB7kgrNReG2hxFVMDye2jKC3ReclK6JQPDitZVSfqU3inc9Nn+PgGnjB4SPBB1
         SDLFCbnDMjygefHyL7pOhaLUqUMvegzRw4eOOOdnsQyQmKN5Wt8I96Vn/uBMlYIzx1lE
         QisM5m/hgsA7R/uprsV9ij0yQu22riykjMzx92kJs5r6cswBMPNa128PQzJPr4ntasYs
         QTgw==
X-Gm-Message-State: AOAM531fj3ey32xY4uFu8nzYivwny/scw4V1yoaNINIYUUTYNZOY9Ev0
        rVh3w3fFGR6QiZYENeL4VNnMrJ9E9LwylonH
X-Google-Smtp-Source: ABdhPJxhJoQpHdvUX2O7wcQWK8aB0gPPbWkP7wnVNoM1mJeOApvGM4gqsuiFd9tMm4ITlXMrqxy8dw==
X-Received: by 2002:aa7:d615:: with SMTP id c21mr13456325edr.23.1604508302920;
        Wed, 04 Nov 2020 08:45:02 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id g20sm1283551ejz.88.2020.11.04.08.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:45:02 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v3 5/9] bpf: Allow LSM programs to use bpf spin locks
Date:   Wed,  4 Nov 2020 17:44:49 +0100
Message-Id: <20201104164453.74390-6-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201104164453.74390-1-kpsingh@chromium.org>
References: <20201104164453.74390-1-kpsingh@chromium.org>
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
 kernel/bpf/verifier.c | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 61f8cc52fd5b..93383df2140b 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -63,6 +63,10 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_task_storage_get_proto;
 	case BPF_FUNC_task_storage_delete:
 		return &bpf_task_storage_delete_proto;
+	case BPF_FUNC_spin_lock:
+		return &bpf_spin_lock_proto;
+	case BPF_FUNC_spin_unlock:
+		return &bpf_spin_unlock_proto;
 	default:
 		return tracing_prog_func_proto(func_id, prog);
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 314018e8fc12..7c6c246077cf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9739,6 +9739,23 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 
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
+	}
+
 	if ((bpf_prog_is_dev_bound(prog->aux) || bpf_map_is_dev_bound(map)) &&
 	    !bpf_offload_prog_map_match(prog, map)) {
 		verbose(env, "offload device mismatch between prog and map\n");
-- 
2.29.1.341.ge80a0c044ae-goog

