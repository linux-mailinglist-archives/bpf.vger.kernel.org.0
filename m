Return-Path: <bpf+bounces-65462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBF0B23BA2
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 00:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F513A467B
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 22:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C573A2E5B1D;
	Tue, 12 Aug 2025 22:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrDwHAaW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CE02E54C4;
	Tue, 12 Aug 2025 22:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755036135; cv=none; b=DpLjJsNw7xbtecdzJaubvxY4NZe3TyDRwp/yga2APmA9Pez643b4e52/5fwbQBpNfTGKcWFA5Hz0cU94iwDkCaBHl+Corvy1F2z3W+y0l6yZsVQHt+zo89RPRMnU/LkVl8WwOChGb9ebr7SMSHEsclxOJQLdA7qgLXrh7H1HSbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755036135; c=relaxed/simple;
	bh=C+rBWop/URPtiQRFTVupUQvND7/3bGvm87yBA5TUHBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bf+a6ECtOc0yclSlw70UrJa/V8/GHi/zSERr82yebHj6CTG21qRz9iXrUbgXTtYFUBSi7auPnN/sRZ/sM++HDR3/ytrKxkyuhit+nD921/i0D4J57QttPpiwBZ5MoiTL9uf0lltqdTYy6tP1BnUW7VxLyISEh3S5MWhgh/E29GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrDwHAaW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9141866dcso607136f8f.2;
        Tue, 12 Aug 2025 15:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755036132; x=1755640932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lZHQWGUeCx38FxMOkWUZ+QfdA43fkpKsDYcpuopkjg=;
        b=RrDwHAaWxpsGnQsaxfwefxFvozZ0hqEngR4AWZHnpD10Y0G+R895BIIxgFkmPGgRKQ
         oF0xrFNSw2avcg+Hkdr6jrV5OnaSPiu9VZi0Y+AQ7IjxaSsBISUeJ4wYRqDWcTZky6AR
         Fc+ZvHbTdD6XRbmmEPdHixzBmAAL5wt+p2vmRRT9P0RJ6ttUWrR35l8eJFXqZ9cyWNwo
         Ye2JU9HJAiHXZMnOB94rMdPR+n02wanYstAiH9dqjGAwwhabWiFIGqOwANixRrq/8IE2
         M8p/KreHRH5sy6GA6VSrz6zOOEWZUVSG7ErJdzJufI9pT6Ytis1dVI7G0YPgnOTI60d8
         oTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755036132; x=1755640932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lZHQWGUeCx38FxMOkWUZ+QfdA43fkpKsDYcpuopkjg=;
        b=JnKhdbC/Xtu1tur1S2rIn+wVG4+dr7a07q9GU2Soipajny6kNOVmWvXrrBkYztzNrN
         7CdnpBLEpeSY1CQDV8+jrO3Bofw2LDpsTzmXNA2YYvIPvVcgn9KEijf2q/7R6aXdZi/7
         4lCOWemX0OjoODEgNoa2ap9M9JmwLBrsTEi9k/aojSGTgxdHC1L7ZZDhtjQ1LHTzbQVo
         919sUOBuuHsl1VS6pRn7o3gMm8Wm6YQ09id9BSdgyT+Rd6Mi454SJQkhANiVtxgfOI8A
         govGK8QV+p9Gb5SuZAJTqg3c7QKJjxU4G/P6QLOF8OxgGuUsvCHhNCYGqxMG9RRDdpGG
         /ZBA==
X-Forwarded-Encrypted: i=1; AJvYcCUs4WKjRgcepMkrdIbWLI/ZC6snnWBSn2kv0TsTHYkcMAzl2ZPzeBNYK3M9LLiHPwfW1uqqqei8CeLY@vger.kernel.org, AJvYcCW5Ec9jtRPOJLDzVHv97aPEpsEeRgKFTRhurPjvo+NqYW3E9vFsY1MmXA+9DImo1R6HjjE=@vger.kernel.org, AJvYcCXMpY6Ewa32Nchlj0M1bTkgTB+ZFISfERZLU2QV1Ire+Q0fAhGt6Ud/zx77mlnbLJsFhSdqMSGFtKIx8AqP@vger.kernel.org
X-Gm-Message-State: AOJu0YxFyldyrF6HQXpf7esmmQYx+viTFGydxKTa6MEbISawZwZs3CPB
	JppRrgDKW3owxbRiWgNQzKOpU7Mpx344a2dxiAy9Z8Wunt2dqrjLDXJhKvNja/BC
X-Gm-Gg: ASbGncsf2zHgKSFYbwaBxIp7/vAuVJwoEkhg6liSzFUdq/iLdZ9lgPESGYWxiKYyWyD
	CnK91qqPNMyoQSapD4cEF7+VGo/Wjbd78SMzsUiogOpLW9Fiyc46couOIdfcRHtd6/r9oBVOQS2
	uijAAaZiIZXh28WtqRUqzbvTsdveljjB/5V+eyZYmshUcLjuCs2twGBbNFWpMe+I+c6sVG/AB0S
	HSg9m9t2zM4nuDqWtJnKOsNdu8Ppcsw23GWvpvyetFHMJl20s4c8EjcAuL6llyNvkuZigkVY6aB
	k8UNdoidlvjrkQAMcf7Khg0o05p/r2fKkvVgYdYLooko8SbvKsHPXqrCv1gBvD2isMRoqT4EF0k
	DVTfwkC/1A1/1XQBHPqM=
X-Google-Smtp-Source: AGHT+IENcSsdJp2F42ucpThbb2RPVqs1xHfoHyxj5akB4HvjEGq/IvngIbaKJslviRj2/JJl4BRodg==
X-Received: by 2002:a05:6000:2083:b0:3a3:7ba5:9618 with SMTP id ffacd0b85a97d-3b917ea04dcmr445770f8f.29.1755036131543;
        Tue, 12 Aug 2025 15:02:11 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:1::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c469582sm44555966f8f.52.2025.08.12.15.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 15:02:09 -0700 (PDT)
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
Subject: [PATCH net-next V3 4/9] eth: fbnic: Prefetch packet headers on Rx
Date: Tue, 12 Aug 2025 15:01:45 -0700
Message-ID: <20250812220150.161848-5-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812220150.161848-1-mohsin.bashr@gmail.com>
References: <20250812220150.161848-1-mohsin.bashr@gmail.com>
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


