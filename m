Return-Path: <bpf+bounces-69009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2559CB8B9B2
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BACD31CC2B44
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE792D5C7A;
	Fri, 19 Sep 2025 23:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvGK1B2w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1AF245022
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 23:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323396; cv=none; b=pznk9ryIzK1mGUHkk6PK11H1tlSDldfPMuwkiDndP7qF4q4ZzP4KycByl8ExwQ34EUGN3NpmJG905vw7UPXIU/pOaXtxKhwl2LfejVng9gpleGqj9sC6bsL2MB3KH9U7KvYEKcUryFOtYYBSv7yTQBzTVm0F/K7ytzfDeT4g41E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323396; c=relaxed/simple;
	bh=5Wh1I62F1f9o/ydZ0qw8dXoBNDdZQT9dEqo+DcjIuWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1cH5uAd1zJ3ct7Tu38tte1sHOshC6cyhcZ5neLP/qfZJXx21qf63q2MrwHwjqlcKNQcmmq2hAOpc0Bu74DNrnKSOyHnEsze107VrOZMP0CRNCcVGP4WiDue4E3/9CPManqIU6ZHlsQAA1NrTFC3lb9oKcAgaUyLNxEAVMOj8K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvGK1B2w; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24c8ef94e5dso22980945ad.1
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 16:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758323394; x=1758928194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bfJUnC1N1J8Qx74Y/0YQX4REZwiozdtUFZdSXz1p/o=;
        b=KvGK1B2wLkX3jggfXCvauEdFJa60UVj0Lg4RSj/1X2SBArSS2hzdurrD9hjSAQJFPm
         kM6eLYhemthnr3CfyQ/OoIx9klcbT2m9S2vjL073xFLSiiOfZGkf578ajyMYYpu08kEp
         tA+nJupFJKeq9r+o57EHGQSWrAFGy+RYUBmPoNHgI8HIFjDPl5utfm2EJ64n7htUVEk1
         aP/GqNOPgxOR7YyiLFS3URJomMog4W+aKGBD+7RaKuYvLUfwBQh5gFUBGhE4t8OpL9we
         MhOVj6pe8owAcMV0AUlk/yeCBglTsI9I8vjngADkeIGhk+9A+9h72VYorpB1ix6FkCCQ
         OW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758323394; x=1758928194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bfJUnC1N1J8Qx74Y/0YQX4REZwiozdtUFZdSXz1p/o=;
        b=V5xDOAY/PPwbtiWUrcMZsBEWd8kiBzMkIusxdsf60qzRR7PpEPBVL102TKUw7Cb96Y
         RnmVcpJMERRtscOb4QxpYBCMcwQ0OKFyc9WJ4QbeM1Cuot/88RQKMDPgYqsnq4aP8qJM
         IwnaHhoQSXRadjyyb/vvnkLypN+zV2oSH8r7/GpNf3Wd/G4NknolMtZBSnvMPewkVqms
         lHPD6DPUnmzD4QR+MXqLxmjXBqkmZg0y4fj+iW9FHM6PTha8/c7JaUCTLeBk/dDOPlFt
         TvuzCosQEKbWYrwdCi8PTeVGezbeJmD4n4qz0Z/r+8bvXRaymTA1vdXf2FeqwL+MJBum
         1npA==
X-Gm-Message-State: AOJu0YzSpUb2pnKyFcFdJcmcmxelubGjbUrDGZx2C9qnlW38X3MnPvRU
	+aYwZSd9YRrYEGZrPnHeLUq49s5tKwBly626RzRtEjBsq9qRZdBgp5TaM8bKfQ==
X-Gm-Gg: ASbGncudWDVsvzK7fWrKaqzEh9Xyw6Tmc1aBaQMKcycdJFwk/erGZiuhLwDvmOuCyTC
	3tZFndyMN/n2SmbpL/0UP2OMS+raeS/rFr2PHBTXYxA5I4cMsyO2xVeaJD7o1IDRonW7QSyZgPq
	W8bMzK5lNmYhOupMsvj0Lg8hRZ951f+2kbf8i8TFgRUKur824xo6MZtJLcmnnIoCxw33MolR4p6
	ySAbySv0kkJDMh47EbB7Qfj2F4Ue6meptixp/KrbFR/ScCraSSKHkZwvuHGU6/JRVdOHNHMG1In
	/OYzzQG5w040xFGrwoIPJpsX2EL9x2Gy4dBOrpQ10YVpCTgNwWyeYjCzbB2HdYVxH/2Y9CgMMLt
	T9SrxjrvSn5ey
X-Google-Smtp-Source: AGHT+IH8P/DkShMI85EvZJ5v6MDd9+mObIek7fIZqM+CU2TsUvLqgYAhWUIqbWS1GKSbuWmJDThg7w==
X-Received: by 2002:a17:902:ea12:b0:269:68c2:a23a with SMTP id d9443c01a7336-2697c829e97mr130771425ad.11.1758323394000;
        Fri, 19 Sep 2025 16:09:54 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26e0cb100fesm14969115ad.1.2025.09.19.16.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 16:09:53 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 1/7] bpf: Clear pfmemalloc flag when freeing all fragments
Date: Fri, 19 Sep 2025 16:09:46 -0700
Message-ID: <20250919230952.3628709-2-ameryhung@gmail.com>
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

It is possible for bpf_xdp_adjust_tail() to free all fragments. The
kfunc currently clears the XDP_FLAGS_HAS_FRAGS bit, but not
XDP_FLAGS_FRAGS_PF_MEMALLOC. So far, this has not caused a issue when
building sk_buff from xdp_buff since all readers of xdp_buff->flags
use the flag only when there are fragments. Clear the
XDP_FLAGS_FRAGS_PF_MEMALLOC bit as well to make the flags correct.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/net/xdp.h | 5 +++++
 net/core/filter.c | 1 +
 2 files changed, 6 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index b40f1f96cb11..f288c348a6c1 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -115,6 +115,11 @@ static __always_inline void xdp_buff_set_frag_pfmemalloc(struct xdp_buff *xdp)
 	xdp->flags |= XDP_FLAGS_FRAGS_PF_MEMALLOC;
 }
 
+static __always_inline void xdp_buff_clear_frag_pfmemalloc(struct xdp_buff *xdp)
+{
+	xdp->flags &= ~XDP_FLAGS_FRAGS_PF_MEMALLOC;
+}
+
 static __always_inline void
 xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
 {
diff --git a/net/core/filter.c b/net/core/filter.c
index 63f3baee2daf..5837534f4352 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4210,6 +4210,7 @@ static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
 
 	if (unlikely(!sinfo->nr_frags)) {
 		xdp_buff_clear_frags_flag(xdp);
+		xdp_buff_clear_frag_pfmemalloc(xdp);
 		xdp->data_end -= offset;
 	}
 
-- 
2.47.3


