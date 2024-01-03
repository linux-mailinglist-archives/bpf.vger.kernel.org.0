Return-Path: <bpf+bounces-18874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A39823164
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 17:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24841F23E6F
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 16:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F441BDD7;
	Wed,  3 Jan 2024 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="pBg3VUjH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="39qkwTrs"
X-Original-To: bpf@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F831C282;
	Wed,  3 Jan 2024 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id A76C75C021B;
	Wed,  3 Jan 2024 11:40:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 03 Jan 2024 11:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704300028; x=1704386428; bh=mgO8GbUsZ3
	m6H3/C83cOc0dMTQ0nYbSwhaYENp9Au0E=; b=pBg3VUjH6TKpqlvjdLLvvJbA69
	K6WgPH8Lr5C25DC5yKqehYFjDWqrhIsPQWos8uCn+xkP7Ev7KCyyaZ8mlcBh63nh
	E9soAlVTnQ8KrrCpxTjMwblOHbbtLILqEwj1AH2RtZN4woC3J17VQRTQJ8cqnTr0
	3Lp5MRLbDF/w+SGHs34RSapGVb7W/kEPMNU2JOhBLvDKQIn/MqNmjFbMmlWp8p6b
	TOyFhyZtFxK1gyoDX2tn7P7Bpmy950lhxrvK1f/DztngP8LcBKh2p2apyXJoDLbQ
	7TLqJTrxFFjOuaVT2X6hhTpR6FwCCCpg6p5FjPgZIqIG1RAGlG/fAZSJ+p4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704300028; x=1704386428; bh=mgO8GbUsZ3m6H3/C83cOc0dMTQ0n
	YbSwhaYENp9Au0E=; b=39qkwTrsaHegDdyRt6LBmIc6oeUpivK/UDYcVGhbp6d/
	M+pfIdh6jeDIXtIwOH6awJQUqXjNDVePzmd0gkT501L96AKSPD2vYqr/2W4ISxvu
	nd8bMtPV7klb/yiRW8NCxIXS4V/YVvk0oHyGwe+twTbovsoBkSjz+wtTRtQYD3rL
	FzzHAKK7ni38lZxW913ztDqi0G8Y1RdC6NLiBTZ/8ZEQOO+wrEBuqUWtPI1qYPY8
	MEC10g8e59U5KFXkhvzPzVDxN5s4y/V4ZQ8g7kvXgfwGvEdK47AjovmY0GTyfUY5
	zmcoPfZRYZooiW8eKgyrcsVyyrewfn+wl8d48Fs41Q==
X-ME-Sender: <xms:_I2VZf0eXnuLQcjGHDeiWoXHyHMxe8f-4srMruqn6o6qEgG5I5nCjQ>
    <xme:_I2VZeGbHFaE__fLijDN7_5WOD60UvK2aqEn0_XV_wIGozKMqLMA-J4LEwLQRCBMr
    AnXrcDac4vSHw>
X-ME-Received: <xmr:_I2VZf7cBicfQF8LVi90JlJ06StrnTv6x-T1S0Qq28LZL6FZ0tMX9_zS_CjsXVIjjkmDUnE-OBIAKMpcN98ss1tK3EaZp5mtpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeghedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:_I2VZU24gwvtOi3bFMraElAY_c4NCXABRdgiWyrmRe5ABpJiEJkTLg>
    <xmx:_I2VZSFr6id8uY1Yg6oUXkrQUrvM9LsU8I3kSnyPImkAzt73WkDfwQ>
    <xmx:_I2VZV_fYXzhXqhOyMUXJAKQ3h7xl-eTeqdGvZBXs_UcsmdZeNnfuA>
    <xmx:_I2VZa8HtnLgBCFpHI5MjKQ-UteaXOedNBKRiVEP0osuaU8id_quYg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 11:40:27 -0500 (EST)
Date: Wed, 3 Jan 2024 17:40:25 +0100
From: Greg KH <greg@kroah.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH stable 5.15 0/1] bpf: Fix map poke update
Message-ID: <2024010309-oxidizing-dinginess-c48a@gregkh>
References: <20240103142557.4009040-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103142557.4009040-1-jolsa@kernel.org>

On Wed, Jan 03, 2024 at 03:25:56PM +0100, Jiri Olsa wrote:
> hi,
> sending the 5.15 backport of map poke update fix [1].
> 
> It's not straight backport, the details are in changelog. I also backported
> the bpf selftest [2] to reproduce the issue and verify the fix, but it's more
> deviated from the upstream so I decided not to post it. Also I had to fix bpf
> selftests on other place to be able to compile them.

Thanks, now queue dup.

greg k-h

