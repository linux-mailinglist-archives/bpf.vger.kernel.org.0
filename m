Return-Path: <bpf+bounces-68951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1673B8ADEA
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8065A7B4372
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559DB26B2B0;
	Fri, 19 Sep 2025 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHwbsVlW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7EF25D540
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305372; cv=none; b=uY8W9cxLqp1uUcTjNUJNK8zi1xpJqJ7UI6f3h1WQqvq+UnbqRsloxz8N9/JaoUwsx10gDDvyKOVvy8vSHVgWPNfYNLxGSVtkn2CQfF45gCdPruln9XpoakBmHYWFwYfh4+gxmX+WCmdoSlCQhHICFbPrxd02iTj0Lj5OZvgUEYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305372; c=relaxed/simple;
	bh=pcXardvoZJ5x13AoTWxdTEydJ2BB1/tUU6LaU849Aws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOZLTcfiLLPx97VmcyruiMxaKJSPjwLtlKV8dVls/B3BjAc7QK1dq2EqQMo1p6oA5C2sO3Wm4lUHbvNSSmOR5//zfsLeKZIdX4kcp1MMQ/Iecp7ai8W/qEhnMjcudEVzJvIlGXhYi/DVkKMXysqqfS17ohxgbiuLz8JGXw3p3aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHwbsVlW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2570bf605b1so32513845ad.2
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 11:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758305370; x=1758910170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/eWmQdzp2gJMKzDrupQRH1sPNWHwWwHav7oa7B7Mo0=;
        b=nHwbsVlWerJpSvm2HIObQdxAPnglA1nv+bHEtfmM3GZcT2xM2RebGHGpc9SDyy9AhR
         ySaxrv+8pQxf/XmmkhLBEkjb906aPRLmaahGBP24MwLilA2exLzp1+5rQN5yvgVWXpmk
         GEWNMqDB7yMzSlvmexPwlOgPAhY86qGIoX9qyHYpp4KfAuG277ocB7qQKDfjfaM6N7Wa
         e2ZO8vydlyvucgXat2x0qmygPPB+O8P4KHS7QkqT+tc33VpS/Qp8fkQeG16uVdIcQorT
         OY/yRjaR4luYJkw/hKPWEETZ6hPv7Wx9oFYlaZ2ruSFQ1o4kgMKrDXR3X2Wdby71urSF
         qd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305370; x=1758910170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/eWmQdzp2gJMKzDrupQRH1sPNWHwWwHav7oa7B7Mo0=;
        b=d5bobYoh9awxXAXRuz1opIgWkYuuUbCVueCnSSouAQ+/2pZbLyTHQ2rcmRaFDfjig1
         80z7rSA5RG2aueDz662WzlcdjxpYNAaO9fEL4YZTzUBWi0gPSxptnHR2LXgEjV1gWKBm
         uVoXbs5vNze0tEMBHLpYWxc4oFjrdiuBhj8T8WY2z1bUY3Z/XofSgElwGkPoKvAx054J
         VCKkhpDWlqFJ2vR8QDngQzhN0KgJLZndFjM8GA+4bHfmibNOh/Ugz4H6wrmw731j4isM
         s57c7iU5VaPgKNdfqKoTwnXQShgFyXa8P40nOxxuavvruciVxUhimrK2Ex0z2C1Aym8N
         Erng==
X-Gm-Message-State: AOJu0Yy5nSDAEQz67q/QejsqD+jEZEXkNJRQubwTALpdV7LNLoOPAhs0
	lDJY5jTklb9QYpvcvtbyNMkWmEBUH6ZUGc1+MUtsS1VFVE8+k1O1b1+8lbCmYg==
X-Gm-Gg: ASbGncsBhTAKCqagybKw3n9f8DZGd1smN6eRHBeTKS0cugVtZTToPspBFGHiZvV3wzK
	cxM/fmlQ0zvtcxbv5vToLJgTmgmnlpxqJJTl9GRUk8PK0dzYyVpmClGRNVgT1ZwBiaHWRorpwhp
	PyEPjBBYDOq14Y9lPEQWi+OT5Y1PM4NVd+tKiNw+nCexQDHR2jUsi5lTNHshxn/M+NQV7vQLWzD
	XhGVPYlXN+vL/kd5Dxwo44HBuuE5Xrk0I7CtCTC10wDQZqhX8sTCe+wTEUa3VYISBXmY7UgE63n
	xdASz5r9hG+6YYmG2icdImds2ePFVXQkBpfiZLWfzTM8ng2v/ghJF4B05eHM53h7p8UuStjP2hi
	RY0/mKGmxN21w
X-Google-Smtp-Source: AGHT+IFA7/GHo0B3XgdZ40R3eCi1RIrkIlkQAPq1FBhgfmXRTNGxydxZ02dZcF0j8+tadtcg24tGaw==
X-Received: by 2002:a17:903:144e:b0:260:b4c7:986d with SMTP id d9443c01a7336-269ba513a36mr57420105ad.36.1758305370641;
        Fri, 19 Sep 2025 11:09:30 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033a3e5sm61410115ad.126.2025.09.19.11.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:09:30 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	paul.chaignon@gmail.com,
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
Subject: [PATCH bpf-next v4 3/6] bpf: Clear packet pointers after changing packet data in kfuncs
Date: Fri, 19 Sep 2025 11:09:23 -0700
Message-ID: <20250919180926.1760403-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919180926.1760403-1-ameryhung@gmail.com>
References: <20250919180926.1760403-1-ameryhung@gmail.com>
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
index 1029380f84db..ed493d1dd2e3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12239,6 +12239,7 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_from_skb,
 	KF_bpf_dynptr_from_xdp,
 	KF_bpf_dynptr_from_skb_meta,
+	KF_bpf_xdp_pull_data,
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
 	KF_bpf_dynptr_clone,
@@ -12289,10 +12290,12 @@ BTF_ID(func, bpf_rbtree_right)
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
@@ -12362,6 +12365,11 @@ static bool is_kfunc_bpf_preempt_enable(struct bpf_kfunc_call_arg_meta *meta)
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
@@ -14081,6 +14089,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (is_kfunc_pkt_changing(&meta))
+		clear_all_pkt_pointers(env);
+
 	nargs = btf_type_vlen(meta.func_proto);
 	args = (const struct btf_param *)(meta.func_proto + 1);
 	for (i = 0; i < nargs; i++) {
@@ -17802,6 +17813,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 */
 			if (ret == 0 && is_kfunc_sleepable(&meta))
 				mark_subprog_might_sleep(env, t);
+			if (ret == 0 && is_kfunc_pkt_changing(&meta))
+				mark_subprog_changes_pkt_data(env, t);
 		}
 		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
 
-- 
2.47.3


