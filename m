Return-Path: <bpf+bounces-60950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE524ADF0C4
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 17:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3963F4A1112
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2449A2EF281;
	Wed, 18 Jun 2025 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6j8dsn0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D15B283145;
	Wed, 18 Jun 2025 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750259372; cv=none; b=sDxQi3NQrh9y/ZhiZE3Qt2NhZ4SdQcvrjM01IxsMBKA0TCslnkZqF75RKt5CbbeDHGyuqo4xDubhJR6ftMKP8xMwsSvFUIi/3Y0AEUzCDsRRe9V/92w+HxxnRzsj1248v6RTt2pqFWMQ74yFIPDCuXq3ByEU1s/yY6xJt2p7yDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750259372; c=relaxed/simple;
	bh=sHdDL0lA0stF0MeG+rkk3pcKnkNoIWMrrmlS6ON+UeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvSODjh26pEHpgrqbZuDOXzcgI2Q4XgpAo4Xk7xYz3WAqV90KKM8gsBb+LMZvIdxY5fB3qv3WiotIw+cSRWvH6BgeUXtMjUjN0piUaDCZYCp3ObqL7mvNf0xUtoxbQNQsZmXFM3pCHq1GLF2ONyk5oRklJ+RJjEpPyrxT4bGp0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6j8dsn0; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso5760606a12.2;
        Wed, 18 Jun 2025 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750259370; x=1750864170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cNb6f+/HlT4jqkJKTMtbJO2tCcxdBDz9ZG+I5Pj37LI=;
        b=X6j8dsn01GqLFdtPPpw2RP0UDa+OFHPobow29Y8aI4wUFZgowERLmBPpcou2mLt5VY
         Q6PuzLt7Uoc/u/iJQMSc91y6l+nFSA2nm2Xvy7P52UAAX0fJr5qoGcu21OvhTe4J0xnG
         pVn8roaszI3K1W4mHCrPIQsRRsNX03GE1nq16p92zCbaIYTJU4KgtiZeMJYJddoV4X69
         lNKzPlUor1v1wsNcnBLIhybw/2P6MRXmPSWRKyhExRZ7ueMjOhNlEcpFqJkvCl3XZTKB
         eG4BLJQgh+6v5JIk8hNJiuuvatVRHGe3ywzjHwfWDE5BH7eJ3bxwR8RE8ubKiJ3W6a5h
         hEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750259370; x=1750864170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNb6f+/HlT4jqkJKTMtbJO2tCcxdBDz9ZG+I5Pj37LI=;
        b=TFyKnHQnO7iF6+RRACWQ0IHfvuEk76K2U4iOdLdd72PRuj4n9Oy39r0QN+a7ORLvDL
         oCa7opVGtD8dU1bwjr9NEfXDe22Uj/q2knp1al6vbhd2yrR2QuWHJGbaiOcYNaHAJQ5W
         OlrPNYaxk4Ouqbv867pUz94ZVIWFuSZ+Ps16rj58ilGBnX22EudywM61kYzYceqzRFAg
         R8Uh92sB9HvnRopR7A1m8osLLrLBTTSvMbYKrOhy/8J0nvNsrB/oShjYKKmg5QCgWXKY
         wgPYmGnr7WG2J5RNUbj8iiH1waVgO0YS2/YYRC7QL3NWyoatwdqnWOLbohCJFHDdXcVU
         4/tw==
X-Forwarded-Encrypted: i=1; AJvYcCVtdKwKgJ5q27cKSdSw8GONhjaAbdHNevo64BR3AWsTtUFPbKGA/HJnPnhqby+pru84y677G+mX@vger.kernel.org, AJvYcCW3gZABBUGZgFs1xkX4ULA5Sf9HulGdZJ6P/VfKElndWmajH95IR7VVCxcGs4GIvBWjJAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXSwBQ4RqVvJz+6UKnP/cPj6nEnJ46cfxvjwDIf8QcJP0MpFsD
	KoBooyO/mgOdk2ia5QOADUP7KlAEp5X2lnOx+EO93xF4fkQrhdVONx8=
X-Gm-Gg: ASbGncttH/hcN4z2UloZeIw/JbjhyITMA6rzDvvOrAYs/YtVjehUg4Zk0CjKw+4DKqS
	BaHyqAFdhYGgJn1FLz0eDK+hqJ1Cb+HnAclYzk1P5gVhSJF2e1iB7pkEfP7xSCdvUS/TWp1pUC7
	6jFmlGtex9i2kBDYht9FyrjAfpT1Q0fL15sUTFO4PUDUrtg5OyviyZ15BmTR/ySrIut62wqamCU
	qZrTchTda2oXSBAUXAAJR9fpiBxzSiODscACf3ZKy65mAV8QUB6mvrHPggerl5PNiOVaViLRWiQ
	4HiwXFP0N3hhloADy3+DMPnLaRlHttNyNHshi9o/9SstwTz0tQAAChW1765voZu7LnkneajIbrF
	YSEM/Y4q0QoGe8kqmRLOSrUQ=
X-Google-Smtp-Source: AGHT+IGUm7uBSvn4NHDyf/t75YKWMdQKachTxhA8/0XLD5p+1+PaWOBk+QFFO5aAgkLt6UXKrHgO/Q==
X-Received: by 2002:a05:6a21:6d8c:b0:21a:bfb6:1c74 with SMTP id adf61e73a8af0-21fbd58c764mr30915422637.34.1750259368276;
        Wed, 18 Jun 2025 08:09:28 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b2fe163a470sm11130566a12.9.2025.06.18.08.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 08:09:27 -0700 (PDT)
Date: Wed, 18 Jun 2025 08:09:26 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2] net: xsk: add sysctl_xsk_max_tx_budget in
 the xmit path
Message-ID: <aFLWpssHj9sE9vvc@mini-arch>
References: <20250618065553.96822-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250618065553.96822-1-kerneljasonxing@gmail.com>

On 06/18, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> For some applications, it's quite useful to let users have the chance to
> tune the max budget, like accelerating transmission, when xsk is sending
> packets. Exposing such a knob also helps auto/AI tuning in the long run.
> 
> The patch unifies two definitions into one that is 32 by default and
> makes the sysctl knob namespecified.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> v2
> Link: https://lore.kernel.org/all/20250617002236.30557-1-kerneljasonxing@gmail.com/
> 1. use a per-netns sysctl knob

Why are you still insisting on the sysctl? Why not a per-socket (struct
xdp_sock) value? And then you can add a setsockopt (xsk_setsockopt) to tune it.

