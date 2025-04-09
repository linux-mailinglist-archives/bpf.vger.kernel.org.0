Return-Path: <bpf+bounces-55588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B30FA83393
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 23:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318B28A36F3
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 21:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926DB218EBE;
	Wed,  9 Apr 2025 21:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AD7cRpIF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C081C215770;
	Wed,  9 Apr 2025 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744235172; cv=none; b=qKHP5AeJrOm13fCza/auHlRIqrQAYgjV7Yovq2j9kig2TD1Aa4mQzWOOJ/244kbiRUAvUKnm3RL3D0E52b0D03/YNvCoOD8DzOCEAQaTFpBGOyQ3swvL07TCqZXdWP4bDX061W7pdU64loe0eEHvwWRP7SgfWmeYvYniIWxZvfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744235172; c=relaxed/simple;
	bh=XSbRnttX/KcYg8l0AZtJWsUqNyHQ4xOm4PvhH+mcXuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImS/gE7y8//BDBqi+NzffwDQ+QS/3L5I0KjbDCxGvhjxm7F+pT64hoVQ/crTPY2Br1oJlhEEVcBT1/RRTtPODoY93y9n8rvv1dYSrv9dQ5UAV/5JrBm0qJD2laPEpKJAXyXMS4pc50TVpWNu5Cu2XoOSh6HDj9Jnx27VLMTLl2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AD7cRpIF; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3011737dda0so107401a91.1;
        Wed, 09 Apr 2025 14:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744235169; x=1744839969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/XzEuFM38WQwlUK+PuUklPR/mgK7p6feARVLP0ZnVE=;
        b=AD7cRpIF+26SBdC+mDenEfdz9L4RGNB5LXt2LKj6mhVTgjt9j/GfSICVzKVIboVZ6S
         acG6XnQZsgqmt9ScmRss0qfbSDtjgQOP2LmrCEUQyTmvJPTXhGIedgV8fsupxW4NZyp/
         4+LBMcnIt14b3w1WGHbrP5rG/4UsODd50fvpU6fvGN08zZ6rHtsRfKEQEpp2KNOpM7kM
         2GIExIWFtmkfIb3QZ/vk182jh0dgiNIc6e0/1V8lgpXvLZTCtUHOkD3yPaa2f/3EDzCG
         1V1DUVY5bjx6epuyQsF8KAdKMr2f+CdkwijZnHg3AktkkAe702OOITMTuP8GXn/ZUo1f
         Y72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744235169; x=1744839969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/XzEuFM38WQwlUK+PuUklPR/mgK7p6feARVLP0ZnVE=;
        b=JDUYc0MZW+xFTjA+T55QjycTNAxbZKJj+5wsbZOK9o3sVVSpu8FJMIhORYBNtze0wD
         Mw7I/eVLGSDCz/Kq+FB6UwQRHF4xAddP1/yuUwdwq8AMcaa6N+sJFBIcr+lGptsdUmcK
         P7Z0Ge3926KKEcsSalvyfn0ALIMjLzEy4eigcg9qUYhWKshNz8lahH/jZ/kV/bRgs875
         XX6twwQtQoHSAYCnCWsyslptD8KTysHPfCLOlAZ6o6p6otbe/KO8KlIyeNfY9H3dsgQS
         BEgrbO8S1VMPB3ibr2MXnKXyOifITSeA4yBjauhbiTSd3Tr7+jFHWFCKQcE54sS4k3Zm
         PeZg==
X-Gm-Message-State: AOJu0YxT9ulLahsOJQoJSEQh3bPV2bodszvPdQKueDqL5xcG/DW1lf7N
	45Ugt2ciYfTNADCgTll4j54xjezOqcd2UzPsVleprQDnLMbphjXzlRJIBjzR
X-Gm-Gg: ASbGnctv3nn10EVYJidmpCDQ5H2cYLR5UtaqTCm3KO5PXhyl6haemEHh+Y3BGko+SoA
	ZHWh+19fhKRVXT5jBT7OPP7XWKX+Ai+HTESgAGoF10vpapWtmy1ArIgHmExo4+enVrFVIB/1jTE
	e3vsokziyXfIG4SRQ6X8GJEHOHeLy8+DE5yzh3FjwlGXtLQ0V0tHywyBSch8svN3/dmivlVwYVe
	5nKWE36aF7xbG0km6ps9EzBT6h8BRH87/fnpGugWTZtBvtUaPk0sozbbRlAI3tXK3sC9AUqXtcB
	aLdl1ygV0fLR3bjAsuZQDzxgumC8
X-Google-Smtp-Source: AGHT+IEWyiigshfqMJNZMdY6R6VHmaV7U7ZWsjAu2YwBivNDDMKkuqqtWAlWN74IhsR+MgM/5Nh0Jg==
X-Received: by 2002:a17:90b:4f8a:b0:2ff:52e1:c4b4 with SMTP id 98e67ed59e1d1-3072ba2265dmr581435a91.32.1744235168760;
        Wed, 09 Apr 2025 14:46:08 -0700 (PDT)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8b7f7sm17198785ad.89.2025.04.09.14.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 14:46:08 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	edumazet@google.com,
	kuba@kernel.org,
	xiyou.wangcong@gmail.com,
	jhs@mojatatu.com,
	martin.lau@kernel.org,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	toke@redhat.com,
	sinquersw@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 01/10] bpf: Prepare to reuse get_ctx_arg_idx
Date: Wed,  9 Apr 2025 14:45:57 -0700
Message-ID: <20250409214606.2000194-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250409214606.2000194-1-ameryhung@gmail.com>
References: <20250409214606.2000194-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rename get_ctx_arg_idx to bpf_ctx_arg_idx, and allow others to call it.
No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/btf.h | 1 +
 kernel/bpf/btf.c    | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index ebc0c0c9b944..b2983706292f 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -522,6 +522,7 @@ bool btf_param_match_suffix(const struct btf *btf,
 			    const char *suffix);
 int btf_ctx_arg_offset(const struct btf *btf, const struct btf_type *func_proto,
 		       u32 arg_no);
+u32 btf_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto, int off);
 
 struct bpf_verifier_log;
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 16ba36f34dfa..ac6c8ed08de3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6391,8 +6391,8 @@ static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
 	return btf_type_is_int(t);
 }
 
-static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
-			   int off)
+u32 btf_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
+		    int off)
 {
 	const struct btf_param *args;
 	const struct btf_type *t;
@@ -6671,7 +6671,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			tname, off);
 		return false;
 	}
-	arg = get_ctx_arg_idx(btf, t, off);
+	arg = btf_ctx_arg_idx(btf, t, off);
 	args = (const struct btf_param *)(t + 1);
 	/* if (t == NULL) Fall back to default BPF prog with
 	 * MAX_BPF_FUNC_REG_ARGS u64 arguments.
-- 
2.47.1


