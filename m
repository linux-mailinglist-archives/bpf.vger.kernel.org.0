Return-Path: <bpf+bounces-66441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F222B34B04
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 21:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8345117C872
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 19:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D75287250;
	Mon, 25 Aug 2025 19:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IryV4uIs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EFE285C8A;
	Mon, 25 Aug 2025 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756150767; cv=none; b=XlHQIiA/+P2u24O39jeJntX6JY4t5l5r9URb8metU006RFHuIQ3lny7JxA5OCm+q+bLb4jQ6Hvd5MFd1A9d4/pCAJKVmKl3IuFaeWxCJohGm11fuM6gzYLjBThK5RSSv37fn1f0SAHxTJ2X7N0eFuGFRANQI6ZgRZ7u1c2y6RwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756150767; c=relaxed/simple;
	bh=3tV2X4fe06M/e2lh38AA/Ijrr/C4DFAZt9h6+wi1/7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6XT3t/uDcbLLOi2lmGKGkAKSHanpHhT1lXPKhg+b2Ej9n3zmUDHqT+o9H9Q00IVq6/ehDB2Kievq/LbUzloUbx9DL+BNtgKbLHPFUP2txs7j7ewbEO6LzVBRG95twbwuzBqvIa2Cwz6eRYCfSLLv+1KgQ2hsyhVos0dFfr74nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IryV4uIs; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2e89e89fso6361884b3a.1;
        Mon, 25 Aug 2025 12:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756150765; x=1756755565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdNOODv0wHpZQI55O4R2DVqRONn5BAonH3tbXsVNpOA=;
        b=IryV4uIsQKPJ+94FAZJzcXxJUsV3KL9D3Bz63WkMX4Y8kS1MOSgpflKCfAJu+6JU2P
         tn62A0WElUo/meplH3ayB5gb7iXm35msCAEmuEAm75Eh4r7gBupDODrTN+wrlpmkHFP3
         qwtElWk8I133zLTPRVUFT5MlpGkCx3rbp1m1NDMfi2aA8D+qXrsJyPa4dcr6+3gRxc9+
         7d0qdBzEjA2kWfYlNph6lA0lV7m70cgK5em9HZtY30v/3Cy9vxo2d8IxFVgaUzopvlF7
         BCwFJI86DyQhEc5c0zrv70B1vDu8fRi8ybT88mG5ZMY/c3jZSnyU1B7VpliaYMGeFsd/
         lcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756150765; x=1756755565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdNOODv0wHpZQI55O4R2DVqRONn5BAonH3tbXsVNpOA=;
        b=w+SkxelSn9rI800tnwEaBtoND28oB/GeEOq0JSXXeU0iP2U1aPpDPDk5GVzOCr6atk
         Q/tVquvDA5rV13xWAEMPITdWIFPpzFSwHDe/gXTuvm6KZHu5dHGodVzZ52CGbePRZv8e
         PT2GqgdsxkZ7Bu0HKLR1hgeBaZabNtrzBtRKx/q0yg1ildC+isjn8XzKEGA9r5Oxd/q/
         VdBhotOHu8b9VLG67a1OGkG78DD91bZSxS0W4lTHDZVloOquEDUytTa4g4L5cJAXA7gr
         Zks4Ix4R6Yt71MBTFOqLsArX5ejGvEAToSChqnxX07Kx1qkWQBXiA28cakNi0HeugeaA
         ZVmA==
X-Gm-Message-State: AOJu0YwVuf0wHHm6LQaBwbjP1I/f9u4SNSRA1AdulGZVL7WZ3sE4zmUZ
	c9c92DrXdgH/3zOhdO5BlQwWe9VYioA+TRhJjfdi42RfCJrS0hg7YN2YvcFSpA==
X-Gm-Gg: ASbGnctC+rnO2pWg/9ARWgUVD3LE7N8nimt52ceneCr0OiCYGkNEMTuRySo1aztaX2+
	dCAJsMifKBcF2o7HlonXmexPbNJ8B/exeqiOCwck1Jc7CHgAmLJ4ulCCJakElx4uYZ+Dz0Cv6Du
	F8ApIjjy8X5e5+tDGl5R1Sc6kpjtJ5FEkFib/UZaTYtKM52R8Dqq9lsrHdnybumlf+CpcjQZSLY
	QBN3OQnJVSA6zUziuuGjs5RuChHEYcYqRwfMkBwOxNwrqXxjel/fgWl5QSwBYQYKItFFOo0sTnX
	axlXc6Yqj+BlHoOScSfjB59VHmLF94orDacxcUZSJZ3Q9izCHRcYzbX25N3gvnKMKyJnOqtmJGI
	y0MZll5RU5sADEQ==
X-Google-Smtp-Source: AGHT+IG5lxEtI8q6eYUdnI+o3n08SRrDR/PM6lGmMvJK6f5s/SOAelACYoD4YHaqJkSEoLXF1/tuCg==
X-Received: by 2002:a17:902:fc46:b0:246:c0a2:3bc8 with SMTP id d9443c01a7336-246c0a2421emr61856205ad.23.1756150765152;
        Mon, 25 Aug 2025 12:39:25 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:11::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466877a02bsm75893515ad.2.2025.08.25.12.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 12:39:24 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kuba@kernel.org,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [RFC bpf-next v1 4/7] bpf: Clear packet pointers after changing packet data in kfuncs
Date: Mon, 25 Aug 2025 12:39:15 -0700
Message-ID: <20250825193918.3445531-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250825193918.3445531-1-ameryhung@gmail.com>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_xdp_pull_data() may change packet data and therefore packet pointers
need to be invalidated. Add bpf_xdp_pull_data() to the special kfunc
list instead of introducing a new KF_ flag until there are more kfuncs
changing packet data.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4e47992361ea..80c64b42596c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12235,6 +12235,7 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_from_skb,
 	KF_bpf_dynptr_from_xdp,
 	KF_bpf_dynptr_from_skb_meta,
+	KF_bpf_xdp_pull_data,
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
 	KF_bpf_dynptr_clone,
@@ -12285,10 +12286,12 @@ BTF_ID(func, bpf_rbtree_right)
 BTF_ID(func, bpf_dynptr_from_skb)
 BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_from_skb_meta)
+BTF_ID(func, bpf_xdp_pull_data)
 #else
 BTF_ID_UNUSED
 BTF_ID_UNUSED
 BTF_ID_UNUSED
+BTF_ID_UNUSED
 #endif
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
@@ -12358,6 +12361,11 @@ static bool is_kfunc_bpf_preempt_enable(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->func_id == special_kfunc_list[KF_bpf_preempt_enable];
 }
 
+static bool is_kfunc_pkt_changing(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data];
+}
+
 static enum kfunc_ptr_arg_type
 get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 		       struct bpf_kfunc_call_arg_meta *meta,
@@ -14077,6 +14085,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (is_kfunc_pkt_changing(&meta))
+		clear_all_pkt_pointers(env);
+
 	nargs = btf_type_vlen(meta.func_proto);
 	args = (const struct btf_param *)(meta.func_proto + 1);
 	for (i = 0; i < nargs; i++) {
@@ -17794,6 +17805,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 */
 			if (ret == 0 && is_kfunc_sleepable(&meta))
 				mark_subprog_might_sleep(env, t);
+			if (ret == 0 && is_kfunc_pkt_changing(&meta))
+				mark_subprog_changes_pkt_data(env, t);
 		}
 		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
 
-- 
2.47.3


