Return-Path: <bpf+bounces-58902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B083AC3112
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 21:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2423217BAA9
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 19:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175331F1301;
	Sat, 24 May 2025 19:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXg9PPDo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4E51E98F8
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 19:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748114398; cv=none; b=FfkffGjM6RVeeCtyXixcLS3qckTxmvbebQ1ElShwFJG/0zjJHbDHOAXHg9EJ7EVndKlbBeidEAAnJO3d5EtyJdYNQe+69iXxXNKXp3fZFatOY8RWQWMiB5pUGKipmXV0HD3+7b11Gc86R3BGxynJtPYrQ3vxp7a4xyT8ON/Frts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748114398; c=relaxed/simple;
	bh=HSDGKiNN9oCpbP6Tahvq5XD9OFuNs1mDALqFnFAlbrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xb6sU/Kou9KKC5qh8CZIDxmjDZ96qWArw1PjstlxUNR6O/MIVq7b2+jsIPnDotsz7UqVMtiuUnkO27GOfYQC1rYWcvfy79xmrI5H7F4u2QoDU4+u3XahDxFQZRDHmYH+Su6UFIZOKyStBoC1uW5gtE1i1QfKiPZa2O6dS3X+WA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXg9PPDo; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7370a2d1981so615203b3a.2
        for <bpf@vger.kernel.org>; Sat, 24 May 2025 12:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748114396; x=1748719196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqP/oYNfOhbwlMns6xpck+rtXivJa4QIFVI10f9a82w=;
        b=DXg9PPDodkgmx28PElN5GNy5lO64oSVtBh5/yWp04R44Ki0Mx4PUSOaRAnQ/gHC8/Q
         /cuefyu5ebwsKEgVBuS3TK3nHZJBr4heI5dZOUr4E3hBM+P9QrP3ePb2o2DjO6XCeH+U
         +Er55VhP3VlOj2zKN8nR2euBk9cCX6bZDvIZontm+WQ0P1uI5g57FiTogUyWDUFWxKoZ
         YNdRv7Vj74DJaPa1lMpMwaIajWqamRGcqJ8/4XHShJiNPU32kuNu1UlP//YmgM9VNvp3
         Xb2dYoseY8q5slgI8CSqW9ybESnVkCIt7Gmy6ddSsb+1vAv72FuByXLpv7wnL6IKC6L8
         h5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748114396; x=1748719196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqP/oYNfOhbwlMns6xpck+rtXivJa4QIFVI10f9a82w=;
        b=hHm1YCSWp/alYn2Ozr9X4sZJN4Pt1ylWHyF6ykpcmq7WkUYoNMXmCN7Cphozt3t4j2
         2R+6Z+Q6XBhdFkEUGcPLxwhSDWYXTfRLUBjesEZQG80cWzKbue+CwToSMUpnZV4jb/du
         UQ4kf5hBq3tc4z4Z2Ov1ug0B0nzm80b5jvMDw2xUya71fg7QHxO4yYpFFBnIbWeDXr9J
         xvCHdpXO2dZZ2m7bVqXYFkXvUUPBHFbVsdZSIxVyZ1oDzaRrc1B8pN87SWG2f8EbAPXz
         GTPl+BADZVwugYe1lyizEtUdmmD6q3ilvNSmcRzDoxoYSIIb78/VO8TkM01XUfcrSegA
         Lj7Q==
X-Gm-Message-State: AOJu0YxFoOhMdgGj+1T+3dMLtW4HBgnvx+B32E1YrVlQcuj63GOIQS9C
	rOgg9pSRBD0AHPEjs+RKy/Pkfq0JNNtF1oziJD9fsZ5n0n/8pN7ahfa+mL+UjcFS
X-Gm-Gg: ASbGncvtJDspFWYV4iJtAsb70GmUSVL2h8YyvJxL0s/jQXPHRDuabWeO+ht47tbc2fM
	5laf2/q2ajb+a3Dwmce4WgDYKMdrAbU0W9lD4hyyIv2ldSuMbF5kjLVzWxzrvZGihkmEFoKT7EU
	AZ1nH4h9iYBSplU2cbGz3qOqU8FysBWzF+IaMS2ht+ozaZuyw0hYdGAJFFekPG/B5fA0+clTZun
	Afup1Cisq2Ccrh+mtSJ28MmFGIPUABhT/DFP0o3Msc6an7TAosJ6ujDzvJUPMG66PapCYVWVOmb
	6/+tZ4SgLIZrWYlv0LmIuYLaBr9ocd+wqUS3rlc4WpXftwM=
X-Google-Smtp-Source: AGHT+IEqSAtt/6L9PmEYNP2zykK04OPOChzhwOWTqDMYB9oqUs0hoM0JIE2RNAo0nV+atYkXoTRYaw==
X-Received: by 2002:a05:6a00:3d15:b0:736:5725:59b4 with SMTP id d2e1a72fcca58-745fde794b4mr6322706b3a.3.1748114396377;
        Sat, 24 May 2025 12:19:56 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a986b38bsm14558298b3a.129.2025.05.24.12.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 12:19:55 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 10/11] bpf: include backedges in peak_states stat
Date: Sat, 24 May 2025 12:19:31 -0700
Message-ID: <20250524191932.389444-11-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250524191932.389444-1-eddyz87@gmail.com>
References: <20250524191932.389444-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Count states accumulated in bpf_scc_visit->backedges in
env->peak_states.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 2 ++
 kernel/bpf/verifier.c        | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7b6440d4e29a..73c3d77bb80f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -728,6 +728,7 @@ struct bpf_scc_visit {
 	 */
 	struct bpf_verifier_state *entry_state;
 	struct bpf_scc_backedge *backedges; /* list of backedges */
+	u32 num_backedges;
 };
 
 /* An array of bpf_scc_visit structs sharing tht same bpf_scc_callchain->scc
@@ -817,6 +818,7 @@ struct bpf_verifier_env {
 	u32 longest_mark_read_walk;
 	u32 free_list_size;
 	u32 explored_states_size;
+	u32 num_backedges;
 	bpfptr_t fd_array;
 
 	/* bit mask to keep track of whether a register has been accessed
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e9254b3b9cb8..6284d7cdc61b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1647,7 +1647,7 @@ static void update_peak_states(struct bpf_verifier_env *env)
 {
 	u32 cur_states;
 
-	cur_states = env->explored_states_size + env->free_list_size;
+	cur_states = env->explored_states_size + env->free_list_size + env->num_backedges;
 	env->peak_states = max(env->peak_states, cur_states);
 }
 
@@ -1948,6 +1948,9 @@ static int maybe_exit_scc(struct bpf_verifier_env *env, struct bpf_verifier_stat
 	if (env->log.level & BPF_LOG_LEVEL2)
 		verbose(env, "SCC exit %s\n", format_callchain(env, &callchain));
 	visit->entry_state = NULL;
+	env->num_backedges -= visit->num_backedges;
+	visit->num_backedges = 0;
+	update_peak_states(env);
 	return propagate_backedges(env, visit);
 }
 
@@ -1976,6 +1979,9 @@ static int add_scc_backedge(struct bpf_verifier_env *env,
 		verbose(env, "SCC backedge %s\n", format_callchain(env, &callchain));
 	backedge->next = visit->backedges;
 	visit->backedges = backedge;
+	visit->num_backedges++;
+	env->num_backedges++;
+	update_peak_states(env);
 	return 0;
 }
 
-- 
2.48.1


