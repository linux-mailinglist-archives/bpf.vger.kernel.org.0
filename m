Return-Path: <bpf+bounces-68957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52489B8AE48
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED57C1CC43A0
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B6226E711;
	Fri, 19 Sep 2025 18:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoThJH8J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3944525DD0B
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306064; cv=none; b=eWqt5mBoY4FGj8wBeBUK0KZOdKFabDzHZadPCGLCPxjdRwdlnNRZtAvCcpBsGS5Hcu/wjcDqvo/NVRXwF/jkqb7/65y+xO1SSgM+Zps7lIPR6y7lPOPYB95dr61bVTDlY6OiIfxY+u3GhDdyFCP8754WZcCBgovuVvM8FR8MPuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306064; c=relaxed/simple;
	bh=5Wh1I62F1f9o/ydZ0qw8dXoBNDdZQT9dEqo+DcjIuWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0BOyUxEXB2Uwmit0UYnMOwodHHfpSNx1mPq5lXf9UwNJrkQCIw7fu/FHrLaGInpLbKPUl6m7CCOLX7J9mH1Jg/n3OcSAbD+XrKG2lZLOCArqC4BWfaiofyJZOUoXs/4ZTFc+mzLfkaWNW1M8vZ+ixICGEMhl6+Hxcoy2+N2BdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoThJH8J; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77da29413acso2320351b3a.1
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 11:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758306062; x=1758910862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bfJUnC1N1J8Qx74Y/0YQX4REZwiozdtUFZdSXz1p/o=;
        b=MoThJH8J2zLhx9k5WtjWMRpHxFKB7wdV1TTJAlAlrVKRLz070Z0iz2VniS1Oen2EGs
         rtWEhpAqyHH+Va9WCj34nEryXU6YAWbxT+z7T6KXS/veSLAHTsQgPKO1N7cQlvalE01l
         mpqA9xfOU45Yn31q03uQkpoAldvnyoCxMGBxNJPTB2feflC0CsW9qP1sxOjKNdGwlHBO
         DDGS/s2Uq3VwuVhmSA78Sp1NS9G372y5UwM4ePbe/Yz0rhzJWFatmJGN6yCtOAZD+TgJ
         98Vh4suYHPFvJsFUDUgrt9VqGCnRqjqPtFSrl7bJmJJfV0+QGl5GJ9DWOMDIRIWrZpvi
         0qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306062; x=1758910862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bfJUnC1N1J8Qx74Y/0YQX4REZwiozdtUFZdSXz1p/o=;
        b=tIYyoqR2WX/4yQEWKv1PexsOdoPG97eq56vLdANo6jBgUWF/6J7lFIByB2Ah3wLaO0
         yCdHZ0YvEsrAqMxhy+VSFFCOQ5SuDxyaN/8TVY4zUkNmeKiwuYuNV2okfpaJ46+pEY9w
         69iqKMvtPOv1GQdD6SPvQP9pZx14feyotw7mCl69i5mSg3LX4/IkOI882p966wmrhEyH
         7FEMSc17+0X6PxyD7PdpjqF+Alq4XQeN1YYJerqEnP7Wh3Jyz4TWpSUhaOLj3JUt/YgP
         LRt+ksOVaHsEVNGBS9SvH4nUoOOigsX1vxeiafio8eVqw4npvlje7vHQpq/iW66gSv/4
         GnwA==
X-Gm-Message-State: AOJu0YxmqOv/JctujgiNB/qceMI8IQUbwIgqyYzmCWSL2a8YR7wpEdWJ
	Dw+Hgt51Y5SuD1mSrVKltvzjoPjDkHLEHo6rs8sYexzYqoMasANvDXvSGR5GDA==
X-Gm-Gg: ASbGncv3EgPQLNrOHzKtv/JWKQJzDRuyD46ZeMTGles9cO8N6NgEPCuPmB97avMmnKR
	IeniHIUmC5HlT5t4C6lMVSigwIWR02R+ILRpCK8hm2twvHVXKEtcJmeh8coCi09LRuXZutXHSKY
	N19clZlJSfpWd7ewSqSEsaEq/w6h1pUXbwigovmS1LyXVgzVchw/Z+HWhTq6cBnoff/rKhgaPzc
	rGgfF9/hGBw/wHkmp/1zW0ia3Sp8OE+NamzCOeiO7QsOzRN0Wj7XV0309tR3ixWLGNUEeHEwrx+
	hHvjaegQC+ho90O1+SO2RfvQHioWaRG9L0OhkhIdA4wGK4IE9CU7HKD4XbyXLx8aL3D251tlow6
	JFQA96R+ukrNNgqiuFZ0Bbqt4
X-Google-Smtp-Source: AGHT+IGOb0rV9m+TXnivyiMYU0jEF5nN5BKGJOkG3zrfm7v+1/+1D3Y5WpQnhi1t/HCfbb7yUb1ApA==
X-Received: by 2002:a17:903:244c:b0:264:416:8cad with SMTP id d9443c01a7336-269ba517175mr68364255ad.38.1758306062275;
        Fri, 19 Sep 2025 11:21:02 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803587absm59858265ad.137.2025.09.19.11.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:21:01 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 1/7] bpf: Clear pfmemalloc flag when freeing all fragments
Date: Fri, 19 Sep 2025 11:20:54 -0700
Message-ID: <20250919182100.1925352-2-ameryhung@gmail.com>
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


