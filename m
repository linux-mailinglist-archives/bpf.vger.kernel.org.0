Return-Path: <bpf+bounces-69289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F614B93965
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F98B7A92F1
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 23:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EACF2F3612;
	Mon, 22 Sep 2025 23:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXgi0XcV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7309327A47C
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584040; cv=none; b=BpISwyMfUYJB6PHj7WClZuzxbd3bRKGEzKG0GyDrVlMAvMLmFYYFPIv/vWJL/KbOjrvs96cPpjESDQcy7z91SPrjpUniB+K90pqO8JL70wHoej48VGkWPC/4fmWOn3WKKvKF4KL2Sd4d1ttKzOUN5sLn2bD3LROfHoSIOxhtVMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584040; c=relaxed/simple;
	bh=RY4vyhTW2f0bqZ50MhY7X3Zavq16OFmxObJLoF6ooLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAzUOrCWTlxBQmqMzB1uGbWGD+2nUtLPZlzk3XDxFqaVnRUGdPHQwOuoZMAlfzf8e7qQaZ1AXf/eJATu10hAG6HZyt2iVdzKn40Nm+pI9780X4mBr3C/x0/LrECez7jTTlFZPTsyP7mRPJJ2kXPIttAvlYja3dvlc45BKI5amK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXgi0XcV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-25669596921so53174655ad.1
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 16:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758584038; x=1759188838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEMsRO7TZHSh+9hG3bYkPqo/ea+Q2binhPvJcPdGhgo=;
        b=QXgi0XcV6rqviHfOFkU1957qzzRXNORsZ7di65X23b1UXr9orL/uinsYe1k+N3UV2D
         QntNy9fH7JH80ogv9CtnIBodvKMJn5HzsNhYiHzb32F904GpJ1wOMltMZ2zPEtAxFhY8
         noFSttmhMgBtwgWkcZLY7zbMF6wK2typ2TW8fLrJb9Dixj6+OkMOixm68JrG0JPgmPvT
         K0Mmb4P3vTy0c+yliwiGFsPPJp0pFmuM3SSC10dgJSzoCWDLjw0Nrg5HMCdJqpcZ3JR4
         oNKf7OHH0367hMvWuU0QQa8y1fpkpoVSB+O+aJWh/MJeFa0iKiwJFBS9AmM2o2mU+nRU
         9pAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758584038; x=1759188838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEMsRO7TZHSh+9hG3bYkPqo/ea+Q2binhPvJcPdGhgo=;
        b=JeNlfwhUHKrJCveW3EfLHeWfsNV0z8ZpT850ZGrJ1pbkDJ5YbJ8mGkhpshn8hO5uvi
         E4qSCCogkBH6Q1b9pk2YX0ghYkPKaDEHNCCwI7dq9BSVl9Z4vwhsb25rj0s9dKWeofr3
         y4TQk1WDrvpeFVQUgUxRH31kWubOY2xYJypFsCQFiG0Dw93qUrzT6AUP7HK2ieMrg4ri
         +DZn5KRJcgFrXca2Rq/qA5carMV/9JchA4KKEGFBzJz0o7Ty8MbVukUbFX2XI9PdJ1OA
         kikWwIoBSQyRvzSWlLWCBm15eijhwmFlJf+wStXRwdG8QGyalHWFMv7AfF2kACTUF4Jh
         Ep1w==
X-Gm-Message-State: AOJu0YyiK42hiZ/gYHRjE4ATAZ3PxK87q+VT1r3BFHqTlDWLYAzh/QgO
	Fx+xTzfxhy2KNuiKZnYDiXZ4xnOhC1mo7zHyZB/KLKeaFo4U4s6CqV1x4WbkvA==
X-Gm-Gg: ASbGncvdRczxsFCyphNswjbYX2dPGiTvRAmxhp+FmrbefdKSL36mPMMcmI//Sl0nnUm
	dOJ5CLRMdVgQr053ZR6gOtljeb8UkO6McOCscug3EZayJAcFRnWh8saOSzRGrfiuXnBO4cqWD0r
	VwXtV4vugP3hlhucTyFpn3r8eeEenAunTiV6002GYnpy62LIe2nPMvFCkzU49ktkULY0F3dqiMl
	IFUxWEJwmbBza+9pd3wlExRZoH6bGeIL4kt3pSz40NDBtB+c4f4rxpc3rXjK+vjmhjjIDHy9wTY
	++a7XaHKGmxhHi4AZk4z7nHC1lVHUYmBF0YRSGNTTZLMIIou7v7KO7DDt3YLwVR8boDgvfYd9jw
	hYlfK//OBsNfSvQ==
X-Google-Smtp-Source: AGHT+IFli+7qKpqXBAL0FjmI7t/09HNmmxUPAxbWmuChBYdr7dn3srih2OOB3NQrLfPplajYGStBEw==
X-Received: by 2002:a17:903:2f85:b0:266:f01a:98d5 with SMTP id d9443c01a7336-27cc79c350amr7785845ad.57.1758584038604;
        Mon, 22 Sep 2025 16:33:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c081sm145042545ad.41.2025.09.22.16.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:33:58 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 1/8] bpf: Clear pfmemalloc flag when freeing all fragments
Date: Mon, 22 Sep 2025 16:33:49 -0700
Message-ID: <20250922233356.3356453-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922233356.3356453-1-ameryhung@gmail.com>
References: <20250922233356.3356453-1-ameryhung@gmail.com>
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

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
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


