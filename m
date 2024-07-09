Return-Path: <bpf+bounces-34250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6CB92BDA5
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 17:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B2F1F231C9
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 15:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D22C19D095;
	Tue,  9 Jul 2024 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="curNHAX2"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B9E43147
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537238; cv=none; b=NgdLwQUGEq+wgPL5LQqqzd7dSzAvTiDAETj4bQyGmg4niLnDcTOt3wmEkPHOrV9hOTfiZW8ndYNAVm1xYsY+yBgsGVCJ1V5cXGKLsXSujUMsffRigqp5u4Bi7UB+tavdvZbJZinEF+sKvZGulu5eAgKXLsQhvjsJl1DzbM1oahs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537238; c=relaxed/simple;
	bh=Kq0bu7ld03TVnSG4bBb/VJAQ50d0X2o9434kFEXzdkA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fLgzsVS+Nvm0a7Z5nU7WFdsm8dh3l6DRnxEBvnsYLtyDkjOHl2sA+N0MQomXpLX5owKjyyjaWj8XGAjGyPc3pz3HAiW50MVXvioGsK9d57EcRvy9XHWASfRoYz6JWj+nWOKuEsybFS8D3Kr2uY9xvOKwekOoAHEjK1vGdaasSd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=curNHAX2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720537236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Kq0bu7ld03TVnSG4bBb/VJAQ50d0X2o9434kFEXzdkA=;
	b=curNHAX2Ki7VXIBMMo/qgd2Mh0AST54PPcOICYExMYTr7ZCzL9Td7uCh1nrPeistmABnli
	T+86p5tLWr1zi5iWvrP7fCDKDJVgk7dQ/FvK1vu7jJ5vMTYEPx4TPSwGCNBKDyXzULuSy3
	uTHyMPS6gfP+U0O3rVXpKDgq3myLmU4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-OVOgHkGLOGKKNkKJzp_Y_Q-1; Tue, 09 Jul 2024 11:00:35 -0400
X-MC-Unique: OVOgHkGLOGKKNkKJzp_Y_Q-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ee9cf9398aso5802821fa.0
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 08:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720537233; x=1721142033;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kq0bu7ld03TVnSG4bBb/VJAQ50d0X2o9434kFEXzdkA=;
        b=UQHM+hNJK47mGKIfqc9Kp7wtqto76ftB7qF4rcTx6g23FUvilzUOjaj9EWsI6wAzCS
         EWqKXbkduYT8yhyC8UU5bZSbSg2jfQU3AxQILDMq+4AF3a8HYic+YU5p8vCnbSQLpRD6
         kK9fAtgRV1u/+bzK8jHkn++ie7faR5WVgfrRM2F7WoHxQbRAi+3mxeBG3ZUxQ5fNQX46
         lDErK0nevU7hr+N6M4PkLPL+1jTqmC5VyCRInoU4FvA3pigccK6S5q1/2dSp3aBl/rFO
         WTXge/xdLGiBCR4OOl0Et3LurPQKqjwuReWJnYPCZ4VIBqflko+8QgLzPNGr9PGTVQws
         G4ng==
X-Forwarded-Encrypted: i=1; AJvYcCVqXuzLS0z8xicepb2pNVlnIGBGiipYUlvMUzNSqgL517+3MndLuGTRj4OTOuiKy1mlba2BAuAlEGk7Lj/fPcUBjBJN
X-Gm-Message-State: AOJu0Yzk4i/dkQAme/8P1bgR4ALolWTjf09CM/KnIVztjjGfKCx7qiMu
	or7/gvuGRMFECDEvXYJfo0GoWyB/8RVJkNOO2Rkw5UJHIUfNoiAc4/QcO95dBNqmUoNGGV3J/Ax
	vVa5vgU4xHWrOOWk6mz4G7Rmyj62hVARrYDj1SmsjXECCP2+2qA==
X-Received: by 2002:a2e:9643:0:b0:2ee:8d03:9127 with SMTP id 38308e7fff4ca-2eeb31bc80amr13327691fa.5.1720537233378;
        Tue, 09 Jul 2024 08:00:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzSIBLUVNFMJlgjgGwZUy27eYj1OnSCedYvQzPEXLfnWlHaUPkHiY3DJ75FTVc2T10o/Z+zg==
X-Received: by 2002:a2e:9643:0:b0:2ee:8d03:9127 with SMTP id 38308e7fff4ca-2eeb31bc80amr13327461fa.5.1720537232840;
        Tue, 09 Jul 2024 08:00:32 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1710:e810:1180:8096:5705:abe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f10ebsm44597185e9.16.2024.07.09.08.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 08:00:32 -0700 (PDT)
Message-ID: <25cdf00fe435dfe4f2e18aeb645245cd8fb99f20.camel@redhat.com>
Subject: Re: pull-request: bpf-next 2024-07-08
From: Paolo Abeni <pabeni@redhat.com>
To: patchwork-bot+netdevbpf@kernel.org, Daniel Borkmann
 <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 ast@kernel.org,  andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org,  bpf@vger.kernel.org
Date: Tue, 09 Jul 2024 17:00:31 +0200
In-Reply-To: <172053542890.29513.3572609329958435109.git-patchwork-notify@kernel.org>
References: <20240708221438.10974-1-daniel@iogearbox.net>
	 <172053542890.29513.3572609329958435109.git-patchwork-notify@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-09 at 14:30 +0000, patchwork-bot+netdevbpf@kernel.org
wrote:
> This pull request was applied to netdev/net.git (main)
> by Paolo Abeni <pabeni@redhat.com>:

FTR, I did not. The bot just went wild.

/P


