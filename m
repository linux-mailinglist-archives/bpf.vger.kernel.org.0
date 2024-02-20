Return-Path: <bpf+bounces-22345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F28B85C6B2
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 22:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326B11C21BC9
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 21:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E79152E16;
	Tue, 20 Feb 2024 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KeI1XX9s"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641D0152DE3
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 21:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463034; cv=none; b=qR600mujJ+Yh7FjbG4nF5HZcr0Vjz1dUjNIGDMUySbCaUo3lLspOHp5dUTcF1jMMtlTGftm8e0M3Eq2uIgTB4eyQ/ytJzbtQO3opIWvGfquzzcW6bPl1VB6Zlq2s+B8koOOl2VUYwC9YdeUbCgEqFUmZDseVbRIzR0FlMBe5D8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463034; c=relaxed/simple;
	bh=cipXQlNv4sse2Ziln+P6/irhO5BInmuCXm1MSqxh1+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Btfsx3ll/bgWLhptoxOLLC3iCt1UcTCyTCOEajlK0JSXINcly2TOlWGk1X9Lhhix6DEXrSbow6X4RM5WeyjDvBxjfiWiMKO+iDP7XNLrclEiFccGCndfY/H0hcFoIxmfqLvcQnKRBoy88HECbCmgQFL+zQUyOlhJZw2+NRvMmHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KeI1XX9s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708463031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3QkuKLxJ76L/BrinDXWxNFTbgD97NGShDyQ2eneyZQ=;
	b=KeI1XX9sQQKyyH+2q20YK2zJfAa4mSfoZAxUisfIyc48+MK+S+2X4OGPWN0/vp8I7J7m5g
	dmQtOmgwDKi3sIPJIpEUiSa0HySky/UwkhbjCi1sH0Hp2ykoGqF5vYaCJ/8eR4b0DY69/Y
	8VkXjgacubi1J05kY6u6qd5UAcD0cw0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-G1CW_fZCNvmsclO3eqbzrQ-1; Tue, 20 Feb 2024 16:03:49 -0500
X-MC-Unique: G1CW_fZCNvmsclO3eqbzrQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d240155a45so20982421fa.0
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 13:03:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708463028; x=1709067828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3QkuKLxJ76L/BrinDXWxNFTbgD97NGShDyQ2eneyZQ=;
        b=MbCTI/gHgijllgl8lsSMSBsgdORodfAOs2AXYMN1ezTLe59DhH91LzI63WcXd0Thwh
         rjJy3/RARa/w8ucOfFA+q6XtC8NIhEtilE6fBMFz8X8tQcvYAp/raypI3OYYF48u6AG1
         1vM2gIbGNLsKNJXv9KAXdmBuV8Q1JmjEsETzIDePsSpg+E9jjUUWonldPKy3VJlgqi0E
         U8twliD9dKEcOuQNSZWesAuSE6ts1Suj1QiFvbBUSt5p09RAkONAQ96mNYW7V5qqxmLg
         pmp8TUkTg9PvksJDIBLS3jDljcfnEFim9WEGsm1rxO8WrviQheP2/QRrawJB9/2WpZW1
         CX9w==
X-Forwarded-Encrypted: i=1; AJvYcCWvf+QRG+uolF15xdm13AvuccCWlIaAFV2XCkFmLGd3f2we1UT35EqKEw23/9pap9HQlJq8WSUcLT5zqIbh5prefGpN
X-Gm-Message-State: AOJu0Ywzb3LaV7rpQ/IS/ci+At4gwTPqXKtF8cOkYgh31tyQCuBhHiA5
	gP2ud1f/qlP2+GgRLPNfq+jokLrNbi/DTZpAWiCRZ/yFi2SaJ5XXfrF2JvoF3DqDIpiCr5muqMa
	QjpH8xdJW2XsbZRHErnayskmblIRVYzumAq0762Ht4n4/5MFMlA==
X-Received: by 2002:a2e:7c0a:0:b0:2d2:524c:a535 with SMTP id x10-20020a2e7c0a000000b002d2524ca535mr336221ljc.16.1708463028430;
        Tue, 20 Feb 2024 13:03:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG60dxeq25alXiX4VbMN5JGwluPEpaR/RAtCHUW/qILAHLufLZZ8FTovybFEsqHlSTgo+I9iA==
X-Received: by 2002:a2e:7c0a:0:b0:2d2:524c:a535 with SMTP id x10-20020a2e7c0a000000b002d2524ca535mr336215ljc.16.1708463028196;
        Tue, 20 Feb 2024 13:03:48 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id x17-20020aa7cd91000000b005649df0654asm1672575edv.21.2024.02.20.13.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 13:03:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B6CAD10F63F2; Tue, 20 Feb 2024 22:03:44 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 3/4] bpf: test_run: Fix cacheline alignment of live XDP frame data structures
Date: Tue, 20 Feb 2024 22:03:40 +0100
Message-ID: <20240220210342.40267-4-toke@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220210342.40267-1-toke@redhat.com>
References: <20240220210342.40267-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The live XDP frame code in BPF_PROG_RUN suffered from suboptimal cache
line placement due to the forced cache line alignment of struct
xdp_rxq_info. Rearrange things so we don't waste a whole cache line on
padding, and also add explicit alignment to the data_hard_start field in
the start-of-page data structure we use for the data pages.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/bpf/test_run.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 60a36a4df3e1..485084c302b2 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -113,12 +113,12 @@ struct xdp_page_head {
 		/* ::data_hard_start starts here */
 		DECLARE_FLEX_ARRAY(struct xdp_frame, frame);
 		DECLARE_FLEX_ARRAY(u8, data);
-	};
+	} ____cacheline_aligned;
 };
 
 struct xdp_test_data {
-	struct xdp_buff *orig_ctx;
 	struct xdp_rxq_info rxq;
+	struct xdp_buff *orig_ctx;
 	struct net_device *dev;
 	struct xdp_frame **frames;
 	struct sk_buff **skbs;
-- 
2.43.0


