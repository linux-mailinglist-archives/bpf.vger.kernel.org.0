Return-Path: <bpf+bounces-68448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AF2B587CD
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 00:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4074A1B25AC7
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 22:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FDE2DC330;
	Mon, 15 Sep 2025 22:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1JI6lUP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1702DAFA5
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 22:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976487; cv=none; b=gd5B2+9ny572r84DmZoiRQMcc0GVMWbyp9kvA7QK6uwxSETo8sw9/RTCIlGDU+NJym2FIqjt6Pub17eix4qohTTfG+SVDnuVa6yJNMiLUMb6PFjE8kWM8J5R1jUIUYP9mVJpUqg8/GjXHoQSoM0/qnEfcD+OsaERh/HrryXnPa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976487; c=relaxed/simple;
	bh=pcXardvoZJ5x13AoTWxdTEydJ2BB1/tUU6LaU849Aws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGLrQusHf6Q2zbcGXx51+ACm1mwIwMVoXXI3eid1BCRscY31CfPi+ujzCh1cB5NhXQX+STgtyN+FDW/C58FXagviwpPhEL6/x+Amq5Wd+M4mu/wQ+5EU1VrmJXG/UGa5Vet9dVbfHit057GoyKLZHDm1eR+ZR+6r3/Z04AatfmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1JI6lUP; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-772301f8a4cso6073566b3a.3
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 15:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757976485; x=1758581285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/eWmQdzp2gJMKzDrupQRH1sPNWHwWwHav7oa7B7Mo0=;
        b=V1JI6lUPhpAjGA4MjPtD0hsWPxyh4roiP0/2Y1UQ7xwxrQpG3jbilTAqIPiLzlTuQY
         ZZ8G0JD/W8IJvU7ISEwplgT11bZfcVP15rsE+neahAGmKrngWHD4XPOGF45rtJNna9F1
         vT/Vt0Hb6tVrQSB1VE98s586DNId38ezMZMzC57oFW52KQZeIfC2STr3X3HSFDKT/Rt+
         Nm2x9p+HGJXLUFRRV4aoDMmhhMtnHTwVwG8nTLKe+Vywwj+oulDzPbC+fPpeTw5QtCJA
         0joJ90VXe4GyFAHWfKMLlrUNOPPhdcEpfKGHlPuHP8x7HO8Q94LCOwOBFiZ5j/zDsJuA
         VVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757976485; x=1758581285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/eWmQdzp2gJMKzDrupQRH1sPNWHwWwHav7oa7B7Mo0=;
        b=UpFlrqbODc9NmZ1U+XfR1KyU/t7Xh73ZEv0F2XWMVUrxPkS4DkikAkKr7m6aQoS2hB
         vxZCFx9lVIrvOJiF0BHQmjAgjLejgbou8s2JgRn7w3HxX+6F6tg8SgJrr0DRH5Ua5d54
         zbUQmuoIlf2FMiTzpllFnGmRfhsixLiVMfWrgcXIiJK+TG9JEzmjFrh0p6s3yXQq9j/p
         +/FnTimZaHwMf5XhHAmnmM5+A4rSid9p4o+aHyTrR8VIERCjmH2mv+LWx1qkN8ycA7eh
         dWsJgdDNpn4f8Y540WstsJqjTI2s4Ewn4jrME12mLNFBMAdKlMRzQP5QMUpuWJFNAv5k
         yzYQ==
X-Gm-Message-State: AOJu0YxIIoTWu9y8zYwuyjwxJZIZwSosIUWEz7mkzNXrJ32GHW7JKIat
	9WgY3/jOTXrwJ4Y1I7GAhpPxIIqZfoTWTN72wzpuuh2hyaP0yShBiv3xjywgYw==
X-Gm-Gg: ASbGncvcRO4p9mbhtm2EveXAz6LbULIcuPMZtTGeA5xT4PNJW+qJ0kc81J0ZN5spQxZ
	qQ6/LA2y+OQqDMK/KnN1//UJlJSqmAeV7i9kwzrvEUnGEIg9Pi7MZ2v/Ug4REqww/vctMgTV2Vg
	PKk9UHR/hmaz+V56ir27QiRThygQpLcRzBwsVJ8NQJFUIQyirGRBJgFtn34hDoYuc993iSCASMy
	nWbz7Qv4ubImRZinGOYQfDLMnXLyZ4cePFurrHAuV+sSVTpLNn+tDa1Sofp6ZtTGtLcm0j8NHOH
	eokn9lcE/TiCe3jRCU5vem0JEoOOrNCwqfBn+CPqCtaMFoGBxwpNIlqrbB10OATiJNTBdjwj32B
	AQt3wl95Da+mZFHJHyj/AkZpt
X-Google-Smtp-Source: AGHT+IEKCsxm0YwlLD70k+o40GTuihVxbnLkLKUgt0XCzaWMimDypFsKmEJpj+KEyKRixYt3ST+4Vw==
X-Received: by 2002:a05:6a00:7099:b0:771:e4c6:10cc with SMTP id d2e1a72fcca58-77612064affmr16300734b3a.6.1757976485287;
        Mon, 15 Sep 2025 15:48:05 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:47::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-776075fdd83sm14367628b3a.0.2025.09.15.15.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:48:05 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 3/6] bpf: Clear packet pointers after changing packet data in kfuncs
Date: Mon, 15 Sep 2025 15:47:58 -0700
Message-ID: <20250915224801.2961360-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915224801.2961360-1-ameryhung@gmail.com>
References: <20250915224801.2961360-1-ameryhung@gmail.com>
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


