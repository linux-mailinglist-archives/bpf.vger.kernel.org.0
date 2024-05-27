Return-Path: <bpf+bounces-30647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 290838D02C2
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 16:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A57D1C21BD5
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 14:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1D815FA92;
	Mon, 27 May 2024 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1KgTtpm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A134915ECE7;
	Mon, 27 May 2024 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716818429; cv=none; b=nd7aGiVJXgjai/EEFzcv21ae7r1UkLp46UvkRs5dB+OvB6NcLxHpdSnrtQXhuEb9Ixg0pFPdCn8cyfBv4/mm2dK4P+QFs4dTwswL1Pyx+DIEBF3N8BvU+BIbmZBiHnCi5deeRgnBow3sLD4mReilRU7xdA8uNce33vVqQnHPHCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716818429; c=relaxed/simple;
	bh=C+1tPGApB2vY2STWPtBY6qjLrBhTd6qsZaU8j09B7f4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YdIzNAZR892h8sfMEZeyt1gLZ3+HBuHKLQznFB0Y/Ae5Mt2KQ7uQd2SLdLp6Mz6fmSSGB3/JdtWBN2tXmIwj1BUsk4wgz5y1YmSVoffjdY4peVKVqhnmgwirtugRcpIW8EvG2uAu4S07zFpsqw2FeLUQ6zkyibpMiGQf31J5r9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1KgTtpm; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-701ae8698d8so124192b3a.0;
        Mon, 27 May 2024 07:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716818428; x=1717423228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TY/wlrJh5pwz9DH42R4v/71GLr5C1YLgWTdRX4V5jw=;
        b=N1KgTtpmRUamj1yFcNBPaLmu4t8mrDLLdctoY4Ne7TWZoFiMp8Q/dkzCzy1/VdfPeX
         39dFuHqnTiOkWXCmHmDi+tWbVdXb8MQTncuh5Go35d7sOvEplg2h+DSLMyes5uXFrdpo
         2jbMMyj8KMC6eDtpQosixYfvpyb5t0QVt1FRZjBtVqokv8O1U0rykPWlRpOYwXk2AnNF
         f6x00+k8+ohsdmDDCx0CK5+5ctiDxEXH9yTBQuS4cB7IfcXVMlSzoZdOlZ0SsSJ6EM/j
         koGYMdRcy4biWkV6M4lfLmre3CyrE3xT1sbYDtJBxko7+sY9+uRVKupUHFmc35i/E2b7
         D0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716818428; x=1717423228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TY/wlrJh5pwz9DH42R4v/71GLr5C1YLgWTdRX4V5jw=;
        b=tDn/hGaGMXwdHGKfDThH8xUBcvYEiy3IjUdX13MMlViQuAp5A2aMk10m3Bu45N6jqp
         h9yGUSdpZvpiY6kDU8RJiSxDPSxl/TDpyx+PiB8MS7tc4s1QIvM0/5bMh3zIK7XI4yDl
         d0yPhenIbSU6/HBtS1heFKw8655X5qcs5QzkAdW0vwpdmN/N1B206yz486mQDfw7ozLg
         lIXFULZRFZ77NDUGWRRL5B+dveUlYTLxnkvvzQGcnrNFSbFy3UOd8DM+a/BjNdlpRAoX
         dqupAMu03cmc9idD+KVGHd79GZu7YncxL+ULssc9UkMM9/mT3vsjHdqdMbkJ8FuKuOLC
         PfgA==
X-Forwarded-Encrypted: i=1; AJvYcCVIrtfAwyFpFEy1ceCjmCcwfAHIs4n8GYvZvYh+p9+LuH1F57aztn6G/ksrPHIHR0q3y4u1uitAUvMZzCBJ8Oypt03cRh0enoEueU7CobQTjfFljOwCjDEFrTvyud0cME64kmKfC2kYf0Pjv8XsFxYE1Eqx3XmeHYbe
X-Gm-Message-State: AOJu0YzRw+R4GF23OzagxcCJzm67xaS3WrkAzNOOqvONdbGRija6183S
	DPykG2cDGuSOe2T/gbdxenYFeK9/IAS3ET1qUyNHAtqlDyE+oLyl
X-Google-Smtp-Source: AGHT+IG1y3hyXS6rQ8h83tfkcOWfC6ohR6WHfSS7FY5mVqgldixau5o4vfJtoDm1zmR8cz+64fR+cQ==
X-Received: by 2002:a05:6a20:3d88:b0:1af:b86d:b6dc with SMTP id adf61e73a8af0-1b212f63dfdmr10693850637.55.1716818427764;
        Mon, 27 May 2024 07:00:27 -0700 (PDT)
Received: from localhost.localdomain ([124.126.229.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682265494dcsm6053319a12.74.2024.05.27.07.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:00:27 -0700 (PDT)
From: Fred Li <dracodingfly@gmail.com>
To: dracodingfly@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	kafai@fb.com,
	kpsingh@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	songliubraving@fb.com,
	yhs@fb.com
Subject: Re: [PATCH] test_bpf: Add an skb_segment test for a non linear frag_list whose head_frag=1 and gso_size was mangled
Date: Mon, 27 May 2024 21:59:45 +0800
Message-Id: <20240527135945.89764-1-dracodingfly@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20240517154028.70588-1-dracodingfly@gmail.com>
References: <20240517154028.70588-1-dracodingfly@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For kernel 6.6.8, when sg is true and skb_headlen(list_skb) != len, it also has 
chance run into this BUG_ON() line 4548.
'''
4544                 hsize = skb_headlen(head_skb) - offset;
4545 
4546                 if (hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&
4547                     (skb_headlen(list_skb) == len || sg)) {
4548                         BUG_ON(skb_headlen(list_skb) > len);
4549 
4550                         nskb = skb_clone(list_skb, GFP_ATOMIC);
'''

As commit 9e4b7a99a03a("net: gso: fix panic on frag_list with mixed head alloc types")
said. It walk the frag_list in skb_segment and clear NETIF_F_SG when there is non head_frag 
skb. 

But for frag_list only with one head_frag, NETIF_F_SG was not cleared, if skb_headlen(list_skb) != len,
in this case, maybe we can fix it with run into segment as commit 13acc94eff122(net: permit skb_segment on 
head_frag frag_list skb). 

Any suggestions for resolving this issue.

Thanks

Fred Li

