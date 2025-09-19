Return-Path: <bpf+bounces-68959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0656B8AE56
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37311CC4970
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3024D2765ED;
	Fri, 19 Sep 2025 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9s2aAoZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BE725B31D
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 18:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306067; cv=none; b=m2mChyokOPuPA7R6rQibtE7ewRxRaKyGQqeCtJBPXOWcN42U/+7c3sb0QriLSnPv3jFY/2lptfuD/rqk/el26kAvF7EX3FcKnn/yZPtESAvBGen32eseaBPT/DdcN6OUJxawXFFvRYOjZO5vXNNaNph1w0xf3TPAWA7qvNGt4Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306067; c=relaxed/simple;
	bh=pcXardvoZJ5x13AoTWxdTEydJ2BB1/tUU6LaU849Aws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIrQxeS3xHnQvcUHtX9hhAMWbTT+/r9mxbUX0RmgtFfE5ubPEc3B89X5RCC7hADBvCdeYhPNFHwPm/WNKPEA7uNVXrjuENB1j/P54zaXEfB6E39oKfU+dcnpOUHK1gu7QpmGNwAhUPU5tDF1Jj6E8UWR7MScAV+clLZsLur6+HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9s2aAoZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445826fd9dso29212905ad.3
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 11:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758306065; x=1758910865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/eWmQdzp2gJMKzDrupQRH1sPNWHwWwHav7oa7B7Mo0=;
        b=R9s2aAoZz6B+BOExwbGJMmFELjT6kD2PNlcnCl0Wg/Smvhpxr/P4j+Id3PnuZoxVmS
         qNqldnz8tPb+4iNo4OcSEjGIpcnPWLKrKDHz3duKpulSjgeI4/hUZuvLw71tp14rngKR
         dD2dxDWl3fbw7QqomFHqd+OdyoPckIpnStKHMrxeEJ2WdG5onFHrihTnFEotG/r17Tlb
         PMCzWv7/XOSXkbeNZjDiMh4D76ka0FMa3iKM07XE0iOXH5QjQ+5xWJkymK8RUx3fZ6K7
         d3+HtMqm/MQTZBGlNkVd+BzSrtItwLKnR01JKw05qVjBjotKJuYzjXX7Gy/XEvisDEoq
         Q59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306065; x=1758910865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/eWmQdzp2gJMKzDrupQRH1sPNWHwWwHav7oa7B7Mo0=;
        b=Mbso0YZX0qXOc7vPnAzanIrRaVbR/DEyCMbUAmnpgO10Et3GWpgas2trqQWflHUeqF
         hMg8KhK8Zgk2NXdtWJ/eIZZLXZPy1qLP4cNbQ2E3rWXvqIacqJLocJQHWG/XyB8R5Ll1
         HLVFkIZQKUltsDL5mou7dISCzM7PvUiC5DHsKuvK8KD5J8fnjVtpWvSrOpKxWfQ/brvX
         asKrCQGZbVLRw24b1OkB5p1PkXIxih0HivxiYeKQBHa8PHGqidcS8fbqZYstM9DscJqZ
         DePWQxcBT+XuUaGWvGL7f6cCuYise6WqgmfZQ5b7UqBHNcNAh77tv69AGvSx7FvC41Fl
         wwrA==
X-Gm-Message-State: AOJu0YwCcVlYdWqnAe+h3w8aP7o3v/9dCknSliXshpdOsc56xEyKermh
	AYn0zm8qrEQVo6tQkxmOZCUpN/KHI92xxSsOz3SDjQHjTHyTOwzbTO90EScXOg==
X-Gm-Gg: ASbGncvKFjpeMSyzG7Lx/41j2n/RtZ+OflvNJr9/UWyw4ZB7U3qwRMkP9UzeL+A8el8
	B37twqubSWCid4GXp1gIxB4KRLo+e8yqJHgdN2ifSZl40WdO74E2KPdDGqPaRk1C5m6VKWgGbL+
	VVB7p6p9jDLU9RVtNBFM03DB/Jq7PnIqYZkXoO7sgkMnd3wPmVZGKx1v5F8wUoDbNVlggQ4ywEY
	twvSWIZthTlh5oldpF3RIRI2wyTKSmuUiGAGy9RrIaztwJJrz7MWRKl8gUopO/JnfezNKoNdXJf
	2vTAsg9kaUL9Uiizjhg4Xn4Ub08gMbIfr5Hz9HdwCrV1TMtiiyAWS3I82Ru5mC84wr1Q9M40cUw
	4eZe6AYwqwE+MAtomLvtVUkcA
X-Google-Smtp-Source: AGHT+IGDEzHNxeaNCMMOqaV/NOXp99+BMlsQ+gQrtm2EDuoL9mYQ/K3r8LxHsw1L6fb258WNS8+OFA==
X-Received: by 2002:a17:902:fc46:b0:24c:92b5:2175 with SMTP id d9443c01a7336-269ba480055mr61965685ad.24.1758306065464;
        Fri, 19 Sep 2025 11:21:05 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:53::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698034168csm59864235ad.135.2025.09.19.11.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:21:05 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 4/7] bpf: Clear packet pointers after changing packet data in kfuncs
Date: Fri, 19 Sep 2025 11:20:57 -0700
Message-ID: <20250919182100.1925352-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919182100.1925352-1-ameryhung@gmail.com>
References: <20250919182100.1925352-1-ameryhung@gmail.com>
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


