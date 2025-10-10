Return-Path: <bpf+bounces-70762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F072CBCE273
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 19:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A5A19A30D4
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 17:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556402EDD6B;
	Fri, 10 Oct 2025 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nigfRl+4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F1226E714
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118597; cv=none; b=XZ81iLKBXMJqEcmQEsCwmqI+dsLJwHhvI3nQ+RD3vUAuYYg58lnnRAXfZZ4ZUglzmRuwuUkdH64/u4VJ/g7h3z/ERjcZLOmQnjLPQoJ/2pYSvbNNEALW4pkZLTwp5sUD1VPBdazNqNLTDiqZ1hruUXC3q/hDXSUtSdpSa/+oQh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118597; c=relaxed/simple;
	bh=CiBKe+AvUQTsf9EhXpiQYEs065TKMDh3mcEBwOn11Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9WSWF6PZTIEK7X4wKEsjkdCrEeudBQePBWnyfSwWPjTPNwrjo5dFS90Wo4Vol49swQOFwlNjPaKIqiGfsyJXvOxc1HOY1OkHTCpBikZghyNs40pBvDomFO2t/AuDuUKuqAUPZcd65PLHTcm/Hd5SvFRyJgmN9JhGkHZbfowO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nigfRl+4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-267facf9b58so14360245ad.2
        for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 10:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760118595; x=1760723395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4B+tzNT5NhDoH2Dss90mOBlmT6SkItqLl2BUgfg+oU=;
        b=nigfRl+4IAye3raFlJbeKFMmHxHJTz969EP16V5IEz+7eGY40HycAX7E89+mbn9yeT
         xuck4fjDJCXQi++rwXPLfzqh6l3ywbjhkiTaV5Gu17jfC0Tc0po+Pi6GtL09vkB2w3R0
         GH37nKGZ9WTaFyEYA1yPWilI01b8Dvq6Do+R/vKdnYHfKb7vPlo0HP3yvSohYNwN9Wk6
         QNFPPYBemug7i5CRxC9Pl3O4pT4kWyBPHUPuuTSjl/tp3snSwby5XSZlCOAmg2fo2uPn
         cdIbHRdUso/nWZRUlNklXKRQTL3MIW2+ay3716Pg8egEw9dZIBnKroUO9qbLlgKEeDn9
         MX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760118595; x=1760723395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4B+tzNT5NhDoH2Dss90mOBlmT6SkItqLl2BUgfg+oU=;
        b=FvufYDjA67hvyZsWig95OEpAjYqk1J0izeVnP2vZGBCcCIjdv0zfxtf+9YFDTTfVwu
         OmiQxtFrU9my0k7ppZNmIDSiSYU8WM+/mKf5EdOVotxG9EOZ+LVXCbSk5Sz3H7E7IDxG
         BekxbO5g34cNrNPRD8UP2eawVJFBNyu9H+37gG63M+CVHHiDtv/w7QhgM6hm236fz+fV
         DlqEtheYFeCcEsWyXFWkAbiCKaeJ8y95XikZao2uY3cVz+dF2SmsXpB3xS/gloKzxSCk
         vsgHtpg2sSvpk6K9KQOiepGvBwHVBmcjIa+ob9aODlBP+lfxE8KC3IKe7nrQ6vVAZbN2
         AvQQ==
X-Gm-Message-State: AOJu0YyRhAjkJehSvFiVFV8ndygHdEVeeX1qf4zhTkQR7je4xWYdsqg+
	iwSMDez/grflni4HOZuLFYXxEh7bv8b8p1aRAKGlsgHeDNwMCAtqMaE6dOjpFA==
X-Gm-Gg: ASbGncvI67DZBNAojrCF0Ghe/0dwoD3vpO8vdfOceEuY6Z6xz+0yoy+hoVpBzp0ks2W
	CATKgtppFDMY90Oxg6wwT2KKC1UnuEmp7ZElrxTpTrPjpe48/SMFmnZ6fYza4WH82Z02V6JFlVV
	ByZfbfnpQ09AZLRBBmWrhpGtJfDC009Na6df1p2tcpYobUjvrm8kqRknzzh/vV3Cu4OqtOhCMh2
	8aNxzOE+xK7IcMCMAMSCRGGPeRA5alKCVRJIm5OtIAYU+WsinlLNmnS3N8HmM+l9cBfg1NNMvQ6
	W3n1/aPIhNB6Zv0oMAFOtLFVDf/SBnXLPn3QpN1eZdylnd4kgM/oaq30pXTbVLMtwHprsjJ6Yyi
	1PK3kLFuqrU/1pZDUIIL0hn7EM5c4M8bv
X-Google-Smtp-Source: AGHT+IG4X5EGQ5aFHhMfdN5wXR//lKNlshcBPy1rznOK1OzPcR94VDd12NEK5vlzV0npTURByzRefA==
X-Received: by 2002:a17:903:faf:b0:25c:ae94:f49e with SMTP id d9443c01a7336-290273ef0ccmr136286705ad.37.1760118595187;
        Fri, 10 Oct 2025 10:49:55 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f082b7sm62016845ad.59.2025.10.10.10.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 10:49:54 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH v1 bpf-next 1/4] bpf: Allow verifier to fixup kernel module kfuncs
Date: Fri, 10 Oct 2025 10:49:50 -0700
Message-ID: <20251010174953.2884682-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251010174953.2884682-1-ameryhung@gmail.com>
References: <20251010174953.2884682-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow verifier to fixup kfuncs in kernel module to support kfuncs with
__prog arguments. Currently, special kfuncs and kfuncs with __prog
arguments are kernel kfuncs. As there is no safety reason that prevents
a kernel module kfunc from accessing prog->aux, allow it by removing the
kernel BTF check.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e892df386eed..d5f1046d08b7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21889,8 +21889,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (!bpf_jit_supports_far_kfunc_call())
 		insn->imm = BPF_CALL_IMM(desc->addr);
-	if (insn->off)
-		return 0;
+
 	if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl] ||
 	    desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
 		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
-- 
2.47.3


