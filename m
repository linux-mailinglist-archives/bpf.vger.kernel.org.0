Return-Path: <bpf+bounces-36642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7482894B3EA
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 01:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329FE283388
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 23:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCC4156C5E;
	Wed,  7 Aug 2024 23:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PB8kEQZL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C243E145FF5
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 23:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723075095; cv=none; b=L2h5x16P0dXhH6Hyitf0LJ6CAYNf/Ctqe0A+7cfYri2/NYOvStm0kLvtxCuCCz/ehOT9aG4vXCAJZSHka/Fuv2aCVJTx1VUFIY6J6ktiOaHd4UbzF/UFnH8z5gmSY91EnGqQBBAOYVrOfYXK9fpYdEpwUyLM3TxIBRo2konbi+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723075095; c=relaxed/simple;
	bh=xaPpeOYLyKCfuhJqZU1oGPD7LCzpB9XY4XCYXBEt7cE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I9mexDYFjc64BrHTqdC6i9jWI3IaRqPwhCDmnXMG8u8sT9QlNXUKF1eMi29FLraJLIzN9g5Z1MVig5SEa+r7SB1j81NxZ1NNek2wPIO7Z/GnTrT6dsu/khsnMs1N+6kXOfN4pdyaxO9tMr0+bz6YJ0Mxxua4JZv+S8tjy1+67ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PB8kEQZL; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6659e81bc68so4379277b3.0
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2024 16:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723075092; x=1723679892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1PiYJcXm7HnHhy2OJM+gjp5dIY0EsUp0P/UTAN/dMw=;
        b=PB8kEQZLx12H0hGlUmJLvcWqQY1FcpjidE3/3gAKqL3JRfy4CBhXXBhxUgn9LlgP04
         iyAzwYzCPt84vXdS4aAhwhuAzQGngn7AvyaGAmLI/YeShClyO3LRf48xM1Sxxqayqnfy
         eAKpil5Rc/SpwmzdnzDvXokgjSv+IIGmE4t0IVSB98KcY5xXCq+uBsc+y2DXNtpBw9Bb
         0Nn5NTCoTv7hBvfrFHB913h2NcCL6xboDjp+DWoYrVpFBCovETEVPCdnggW9XwFKu9LS
         A3Duni4RXCVXYCOCYPd6ZJBzQN1IdIBCEG/+W++tvnsR8QTauG+koc+Y/xCDdTOOavJU
         aJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723075092; x=1723679892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1PiYJcXm7HnHhy2OJM+gjp5dIY0EsUp0P/UTAN/dMw=;
        b=U/bWHfzQj5kM1LUzBDVHxCDOcSviulj9vI8D8MFUPFFVSWd8umr2Wig2BuPjLR6kKK
         pvmg4WHkIJuSK5HbpMJ/6pKYkHpi0nePEIjYU/hoIP0LDOF8eF86quwNib4fC2VcvRVU
         Yd6gDXqYc6ppPDjF7q4cgpofE5LKuFH3YWhg45BwavqkEe2wDGqV3KzQE0L9qsCWdKS9
         6NnCZSL3+bCP9n4Dn5ss0NIf4WQRBgnt54jHN2O3Dmmri85akbppEh2qnPzUhtftQHzV
         nsZzIETb5FMqoYxItC70ZdO0MRuWvgC6jTwsaZMCwqXR1+PCVR6H5kDdp2W3tYoWeeO7
         KACQ==
X-Gm-Message-State: AOJu0YyRwIEWPxCom7z+EGdZ/XktrQCCfyY4gF86SQXiu6Lyh6ZcaniE
	3lDMxLvpqVZ/lyPOsQuwxO8EF7V+8Y8htehexaSbH+KvApGOTh+kcA5rWmGl
X-Google-Smtp-Source: AGHT+IEtojsf0UoQUsY7MfhRqNfonfZ8FVhMfwDZD8VihmvKktyRtuTU27a6tv2TBsMnaYBqjOEiYg==
X-Received: by 2002:a05:690c:2d07:b0:63b:ce21:da7f with SMTP id 00721157ae682-69bf8a91e54mr1013367b3.21.1723075092521;
        Wed, 07 Aug 2024 16:58:12 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:fb5f:452b:3dfd:192])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a0f419358sm21092477b3.26.2024.08.07.16.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 16:58:12 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next 2/5] bpf: Handle BPF_KPTR_USER in verifier.
Date: Wed,  7 Aug 2024 16:57:52 -0700
Message-Id: <20240807235755.1435806-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807235755.1435806-1-thinker.li@gmail.com>
References: <20240807235755.1435806-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Give PTR_MAYBE_NULL | PTR_UNTRUSTED | MEM_ALLOC | NON_OWN_REF to kptr_user
to the memory pointed by it readable and writable.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/verifier.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index df3be12096cf..84647e599595 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5340,6 +5340,10 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 	int perm_flags;
 	const char *reg_name = "";
 
+	if (kptr_field->type == BPF_KPTR_USER)
+		/* BPF programs should not change any user kptr */
+		return -EACCES;
+
 	if (btf_is_kernel(reg->btf)) {
 		perm_flags = PTR_MAYBE_NULL | PTR_TRUSTED | MEM_RCU;
 
@@ -5483,6 +5487,12 @@ static u32 btf_ld_kptr_type(struct bpf_verifier_env *env, struct btf_field *kptr
 			ret |= NON_OWN_REF;
 	} else {
 		ret |= PTR_UNTRUSTED;
+		if (kptr_field->type == BPF_KPTR_USER)
+			/* In oder to access directly from bpf
+			 * programs. NON_OWN_REF make the memory
+			 * writable. Check check_ptr_to_btf_access().
+			 */
+			ret |= MEM_ALLOC | NON_OWN_REF;
 	}
 
 	return ret;
@@ -5576,6 +5586,7 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 			case BPF_KPTR_UNREF:
 			case BPF_KPTR_REF:
 			case BPF_KPTR_PERCPU:
+			case BPF_KPTR_USER:
 				if (src != ACCESS_DIRECT) {
 					verbose(env, "kptr cannot be accessed indirectly by helper\n");
 					return -EACCES;
-- 
2.34.1


