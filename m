Return-Path: <bpf+bounces-65574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D166CB25660
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 00:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FB4888CD9
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F532FCBE9;
	Wed, 13 Aug 2025 22:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HygGpMvx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8032330E854;
	Wed, 13 Aug 2025 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755123222; cv=none; b=eLHwVmifQgiIOJyyYBdI675Mt2j8mh5DNk92cqrGsumlwit9n7uHux+98pJT7deq+iQBqn1sw1xM5JJGuA+wlSrzgXLW8T2VBT3xhLTZEeb+3TszFED6MvvYGQt6EPrn4t34ITSO7fka9FI/onrRIPvNjDP+GoISA4xt5Yh9AI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755123222; c=relaxed/simple;
	bh=C+rBWop/URPtiQRFTVupUQvND7/3bGvm87yBA5TUHBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7d29HcgrYJhVJ4beZGv8M9Wkln/IzwIilaDkY21jYF9g9N3d0En+u73ah70a4GmkHvmJ0wuHfbhTQIFDxsJ85+svDFjNS1wxQoiMpZIgb2uYvH/28JpJ5X2o1YAk+Y4AVHAy5vIf5DlkL0zWVbqGx5NHu3jxRg4Lp3ZTMEUqas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HygGpMvx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b00f187so1190165e9.0;
        Wed, 13 Aug 2025 15:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755123218; x=1755728018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lZHQWGUeCx38FxMOkWUZ+QfdA43fkpKsDYcpuopkjg=;
        b=HygGpMvxY5bpkb10fv+UCyj8BRWEKZRlXvHgb9axuy4wqd/MkZySCADR/hT4UnfAI7
         2wWXOS1LY9oTnGdO8jpFh+uzB2dZ/kfO+BomzTUPYtrXhXbfnqnvfyrCXA8BSJY7n7zY
         NWQC2Y6UoNIrilB/7KXTlEu4mXx9w1c74HHYB5Vd/jnyyH/YmXNo7fyMAJmWl1X2XfbP
         NhulgnXBFt9Kuguzy1fOkhPwRGSLZ3QLMX5BWy7KzmfkJ/7laYEES0pvnVkipDQddJbc
         f62LFmmVQa0ehjtdFCtJfOCLQbTxirRab72/obEG4b0dD8RTfc87SHjRq7oRtcBudoam
         0mfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755123218; x=1755728018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lZHQWGUeCx38FxMOkWUZ+QfdA43fkpKsDYcpuopkjg=;
        b=ZjqIm9bhXrgKKvtq+afSLQGsUXluPLj/Zeh4FcqWy4DimtCrtkahzd9ZE8SOmPmGAu
         n7fkMrtmM6dkBZPVkzkSgYt5Q8h/g7sVHpceKDFS8hG9KhwU0Jt7VoD2xFPEnODNeyFk
         9aIkAEfcAtUJxYWn0WzsmsB2LYJE3Z0MEwAEfuj5vo6bb/o4qC1GZhSFax4WCar/HVQn
         T6iGyd0tnujEPL5DSPkFJSdixZk8GqsXjIeDN+3gbluyTbyP84T/pdK6gsLoI1//xRqz
         Bvt37Uh2yBi/x8lTzZft6qB9QKHPAgXgGAYL47IhiYHEl6G8eNuSOlN5DIoG+h8O63DC
         xxfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKzkMEw1FWSC0hdjy0Gnnk5vGh2WtWo9lkw2EhAM161GMq6nfpaecdVogj061a1WAfKAt7DVzx6gJYtSRU@vger.kernel.org, AJvYcCVh1JeGmI6ENmPHMNbeiGB0TzKWedTXvbz9jVO4YNTq4H0bV64T8g7awUF+M3C3Pj9A11aP0s0jJqoZ@vger.kernel.org, AJvYcCXOVWg5/k0NBlzDvnO7foeUiavaJfBk5TpG16zoLpk78QunT/V8jPEfYybFIfA22p2wFGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJwj2IhtcDHd8PuKml77euYGzbeQ4dlYXpjsYW/KKA2ULvZfge
	5FYno3PT+DGwMgR7YDNTcDhA6IXJJTutBW+bqyG1OXTBsE9nAJB+TGFOzNiXGY3y
X-Gm-Gg: ASbGncuVTWmr+fyLUZLhEHn9UchNLVD03EnhFb+AQqFOb5+xGWscjf33XGHzWy67vZS
	Sr1MlrRYDyT/1pMRcM0hLuDQT/vnKRaFsfVZbdN5RnshaxLDk9BcMUg7FG8q/unOW/UOpJjp8IO
	N6tYMDLp50stw0/YPp0JRUT2+lOVr4F+2wHafunNJqyM9FKYgv0P8rQFjxMuc5nIE+toLoHEssz
	2QeiyxqyHvtDaejh9m4AbzjGrFhSMZoLQ9oPpi51oifbJPRp/gLtdAY0+SgfqCw/GeHVPwMEkDN
	yANQ0O+F8WxeZ9fuFSJKGL6cqddfwS2ZGVPfa7h6LOH35IVqxPvmEEAOIfmO2wjIRZ3aS292sfi
	buecipOGVR5R7K+XXPR4U
X-Google-Smtp-Source: AGHT+IHrsQ+9dDzk+oorVaNBNHERtEjkMW/gH3KTy6HYtB6IlnBeuZoCMiiPLd8fevWYY5tWyDXcdQ==
X-Received: by 2002:a05:600c:1390:b0:456:21d2:c6f7 with SMTP id 5b1f17b1804b1-45a1b667e8fmr2678465e9.23.1755123218126;
        Wed, 13 Aug 2025 15:13:38 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:48::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a5161e5sm16936955e9.7.2025.08.13.15.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 15:13:37 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: aleksander.lobakin@intel.com,
	alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	bpf@vger.kernel.org,
	corbet@lwn.net,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	hawk@kernel.org,
	horms@kernel.org,
	john.fastabend@gmail.com,
	kernel-team@meta.com,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next V4 4/9] eth: fbnic: Prefetch packet headers on Rx
Date: Wed, 13 Aug 2025 15:13:14 -0700
Message-ID: <20250813221319.3367670-5-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813221319.3367670-1-mohsin.bashr@gmail.com>
References: <20250813221319.3367670-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Issue a prefetch for the start of the buffer on Rx to try to avoid cache
miss on packet headers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 2adbe175ac09..65d1e40addec 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -888,7 +888,7 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 
 	/* Build frame around buffer */
 	hdr_start = page_address(page) + hdr_pg_start;
-
+	net_prefetch(pkt->buff.data);
 	xdp_prepare_buff(&pkt->buff, hdr_start, headroom,
 			 len - FBNIC_RX_PAD, true);
 
-- 
2.47.3


