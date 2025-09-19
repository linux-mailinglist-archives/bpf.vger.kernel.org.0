Return-Path: <bpf+bounces-69012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 563D7B8B9C1
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4EF1CC3AA8
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61012D9492;
	Fri, 19 Sep 2025 23:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WALifacZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFD82D77EF
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323399; cv=none; b=Z9vafDi4EOZv6aJVaQ04R6e8q4I/ARDx306R6CIEztv64xx/fOuJeoJB3VKArnuRBqFrwMnJ2oXLU5Bi/G3HV4MccUlC0t3D/1bgynk9alyNWjqiBdI9ZmK/20mtFVwZXnV1s7SPLXD0OLdUuo2HZOZ/SGuOSc4F0p0HwE1rqs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323399; c=relaxed/simple;
	bh=pcXardvoZJ5x13AoTWxdTEydJ2BB1/tUU6LaU849Aws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmjrKL99K7aTodSeNrr1xlZHUF6Bn2NNh29Ajkvyck2c7iBrWGFa79VXuDLmQxJCFyHTfC52eRfB/ej/8Ue7z+TgBoQJrLRPgZIB8XlpGMZTyqG2C/H57aLmmsLdEpluo2Ua5GIkxa4y8bdVDIJBJnXve43d+ITpduLO548qzjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WALifacZ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b54c86f3fdfso2757484a12.1
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 16:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758323397; x=1758928197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/eWmQdzp2gJMKzDrupQRH1sPNWHwWwHav7oa7B7Mo0=;
        b=WALifacZWN+iIzhBkABObhUV3iG5yV3uX916LFirjENTn5ZY3v9l+40fTxAVpxx14R
         gGZb8zTVQsRqK8dfCkieG8r7m/tBhYaA3hf2Sd5+A5bI2UKyFHRNBGO9VdWF+A6hGMGv
         4hSU1vLR3nbDZyXVo03cBXJlVDaRQevxSyFKN9DJ13BoQCDXx1gwXFu0WlGaEepsOkPX
         zjZxN3CLwsUkRij5l5ovKvpss6XMmKJ0UIffX+XbhRi1Ce4/6rGgO6kEX9gKg01mCp7z
         wggdhzV7Uv+N0zkaaFjKlEtWBOb5hNnwgqz7NYds+lsbuxP3DZNDAv2ng/N+7CFpC6Fz
         2+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758323397; x=1758928197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/eWmQdzp2gJMKzDrupQRH1sPNWHwWwHav7oa7B7Mo0=;
        b=sFuinoEzteb/ACLQmC13gDNEi1PiajFYFOCDywHWiGH8ekUr6wMQET3OQM8WUT5fiw
         k6xh+HBz1mn7h9QBkmCtTbmOrqBBfH0KkU43ATtnCsvmOprEEhSh6GZ+Yi1mO//flOhI
         YFpa0216uisSH9lHsZlLvEuH+Vyg3uRatMoM8S1b/maZDEYgWlmKIKsOvsERjjAYRlFQ
         WNG0jd0DJQh5wKQBcLGoqoffU3ZNeVsA3RheMOE5Yarsfnk3qsGCIwnJLmz0wPTClsIo
         ZoExyuwhT+JORm29yi22a0+aKRkvBbKaAx8GJcVk8G3HDJ+U9XCwj/T3C/xEFPJVMHv2
         54Qw==
X-Gm-Message-State: AOJu0Yy83rkRNWJQNFtX9LWdzc9XzSH8hWa1NEB0fGWHWwIbTMM/Mn+w
	Ml8d1Yf+T2phNJk5tWVehT9Nl8qY+RlyUBSq5zF3PGN8ejzU4/vBTvBwrYC4XQ==
X-Gm-Gg: ASbGncvXViuDlWFZdTiqCeykiYnntqwTXRWOWuCNgNKbp8NM/dtaer5g9Q0IserZlm7
	jl+Cbjzdgr5OnUAxqsMbqNTzk1/OAjs3FIrJwIDMrq/Xp0zUAfKggsgfso3otOK5Y5IU3tQOubX
	IPma1PjnhjmR84ZxRfspyivZpsZxTwHQ/KR5DT82ocfemdTEV5uUyLDJkyufl/b9vyKpheLFN9p
	WMnPI4xnJ1ntoEBNRBMK4p1WzI+kLi2zYP4D7pT74lN8t/x88Q6AKTbgUyoekwYPoiEpEO9Jx4C
	VAk3xTEvsv9ygia9mDmYTD+Kst3N26B1+Il6HUfJFYHJhF25rJ0ifKSiiUtjy7DLJatLqbLo2a0
	+vWF3I31A0epH
X-Google-Smtp-Source: AGHT+IFKBoAz/1ZlBrmFlvmD/RbL1fmSB/1HRKI+iKPRaOGmfLXSkOks6N1F81vSNPT989o7TcuSnA==
X-Received: by 2002:a17:90a:db0a:b0:32d:a37c:4e31 with SMTP id 98e67ed59e1d1-3305c70eec4mr9248642a91.17.1758323397052;
        Fri, 19 Sep 2025 16:09:57 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed276d2f8sm9348164a91.24.2025.09.19.16.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 16:09:56 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 4/7] bpf: Clear packet pointers after changing packet data in kfuncs
Date: Fri, 19 Sep 2025 16:09:49 -0700
Message-ID: <20250919230952.3628709-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919230952.3628709-1-ameryhung@gmail.com>
References: <20250919230952.3628709-1-ameryhung@gmail.com>
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


