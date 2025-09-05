Return-Path: <bpf+bounces-67593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9144AB46041
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 19:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F87A1BC8CFD
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 17:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26294374288;
	Fri,  5 Sep 2025 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbON+4Dp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3714937289C;
	Fri,  5 Sep 2025 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093639; cv=none; b=gYGNgHfA/LNb9Ky6oSmwtnY39HxG+/LriXOpehaCCzSORMg5SPF6IxeyE4Zm2tUK23xX6oi8WS/L+W7ScnsOqbwQ/Gs9WzruS3CvZgFb8budp992QCzQzopjo/hViIUOSLUiy1dZhh0d77fN11t8Tc6PIXEDAQljydzNQgfgiJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093639; c=relaxed/simple;
	bh=LNIb/iWR40KlamiLjEQxp7sTBu2QVHwBk/34ZVbDy4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNyaykF4+GcM9wNN9JPhK7yABZVyrBdVkOulSK9FiLH8DLb9NXt6h0p4mjIi2WCfWMpIQDxfW2ny/cm/VxcavUi3UFYm/DGTB+VtkoFeRegSOGgsp07oDOLDZ5b5y9fzmy9qBD6likutS+LqpuC8gW8uCTb9VG6S0kYKJOfjRnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbON+4Dp; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77256200f1bso2452745b3a.3;
        Fri, 05 Sep 2025 10:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757093637; x=1757698437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOL8OMMRDF0SjoBWSi2hmKd9RleuR2MLCUhyRRyGDXw=;
        b=RbON+4Dpr+o1SHCCHcyaxxB7KxLBOsmFndcGs6uoZO1w7L0bnv926l/FXTdEeBlHnR
         3g6Ux+dlbg5C4xpm+PRIxeyz23zUv5dtcvz0S6G79HGNC0HJdYTtD8alyOseCcX2Hknf
         n/oAEJMz5RF+4zFYzZ94irDreGsLacLzeHO/GiWF6MdtFk9/iLw5su/NLpd+Y6Wmzh98
         A+44i9/bJLtGvZnatW6t1Ek5pHDxqaubYezyZJ+H/iw3IJjFuAslvak1+NoObewrWKs2
         y7leOMQ+Cbwk5QPUHkhhPpC3ka7PY6l3Y7umIBb3HD8BxIVDB2lsoI4yQekwXFpjVgDQ
         9/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757093637; x=1757698437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOL8OMMRDF0SjoBWSi2hmKd9RleuR2MLCUhyRRyGDXw=;
        b=f7PWZ43s0gJs0SYBXLkEKB+nFMRX3z9m9ZrHURoZO4KymbCk5qOIUSscdP147c26ug
         y6jOo6oSep9nc16ImkeJ8qqOiJFpN9IOKs4XHIb//uvDD9QC92HgHPUawNFhGo6MwZIA
         arEgzDAGe1FU7fcp0RjDNPv5aUNiHQbyrrK+V9m4Fhdx9xaB5jWzMe0KICv1IeA3KBYg
         VAFNQ6RDjJjPpSg6AeaQMC7EjoypeN4dFUCkKJKrVcxNnwmebX1lAJxh8zrG0EiiQ14d
         xCYBUO/4lXsDx8FU7iUQzl3kOSjip04eWFvYZlfPVIHX4kLvVTnEjViHZugFr8WqpnSP
         sMyA==
X-Gm-Message-State: AOJu0Yznt9ZRCY6WxEV/dgBO9ESTlNUR29VLHDyrdtP6DGSGda7roevA
	En7aB2Mx9wvrWGrxTke6sQOnpT40tk/BrZCd8+mU3zkT0/TGq+VF+h7QAV8lKA==
X-Gm-Gg: ASbGncvBpki+hJap3bhENSJ8enz+NPffnz+JdiIa1/145wP8hR4AqNJsjSvY2fRNGjJ
	sRx8nkXvWMcOJkSFDvDb4/B1Cyp4AfH4ETRUroT2qVKIh0hbhUhYX9TPH9ybUaZRzYxR/1E2Mq6
	B7ltOeA5yu9tvmhtnbGbpY6Qn6dd8IT/ISVmYRFvnUWwy/cZknfcuaMoM60fw8J0dEVAcFC3kJH
	rPUeUQ3vkrkGxFCJ3wa0FSpvUJ/UOLeeN1scgKDwWeQhgmyFTHKZMU4CiNiMoGsMVuWqGnfnnJM
	USX0SZe9b9eZdTjl4OE3v3159aA5Cgu250SQnTCcBtGT3h5wj3nWKS5jAJvuTy1XcO9PCjB5k4O
	P1e9SoX5o21Bd
X-Google-Smtp-Source: AGHT+IHr/bTx+ANegyDXF0yXncO8mINAJ5Jveo63NTmYVelRXIpbD56BgefuUgCv4y2oCcTyonkffg==
X-Received: by 2002:a17:903:32c3:b0:249:c76:76db with SMTP id d9443c01a7336-24944a64ae0mr334409965ad.21.1757093637395;
        Fri, 05 Sep 2025 10:33:57 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da3c38sm218546235ad.91.2025.09.05.10.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:33:57 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kuba@kernel.org,
	stfomichev@gmail.com,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	noren@nvidia.com,
	dtatulea@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 4/7] bpf: Clear packet pointers after changing packet data in kfuncs
Date: Fri,  5 Sep 2025 10:33:48 -0700
Message-ID: <20250905173352.3759457-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250905173352.3759457-1-ameryhung@gmail.com>
References: <20250905173352.3759457-1-ameryhung@gmail.com>
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
index b9394f8fac0e..2355f2999773 100644
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
@@ -17798,6 +17809,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 */
 			if (ret == 0 && is_kfunc_sleepable(&meta))
 				mark_subprog_might_sleep(env, t);
+			if (ret == 0 && is_kfunc_pkt_changing(&meta))
+				mark_subprog_changes_pkt_data(env, t);
 		}
 		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
 
-- 
2.47.3


