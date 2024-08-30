Return-Path: <bpf+bounces-38622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6746966CEB
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 01:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 119A8B23013
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 23:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815D118E368;
	Fri, 30 Aug 2024 23:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="fa5xmtCa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p/kXSQPu"
X-Original-To: bpf@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229A1175D5E;
	Fri, 30 Aug 2024 23:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725060693; cv=none; b=jTZ2PB0c8c2gTIDe42yg4RlnnhOrYNERQ8ROMDUbNL8Wz/PxF5HyaEHNlAv2GyF/a8WntRkEcHE+Lao08+TinhOTs1fBfEqwFh9RZuxLCHQV/POEmcgEusN2tuoQGiSKqBmT2juEDdVZQRGI9ob2eXa+xtB8WhV9PoU3Teby92U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725060693; c=relaxed/simple;
	bh=/jDfksFVh+SL/YS7JWz4c36XTPe+Nm1xdBuIoRLujJI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DxA7Kf/fhXbBrX45gaSsVLlCgF3j9kllXDUFi99b+OxIMbXPySzurnghi6k5h7dPABX7oSIf48tg0UlXgKJWxPmTTvEwOydAdOSJUBzvHjeu3THvvf4oomdWjqVnp+n6VdKckoU3iSTAJ0ACRM2Jb07dMF9+VYmeZG/FqiP7uaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=fa5xmtCa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p/kXSQPu; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 103901380298;
	Fri, 30 Aug 2024 19:31:30 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Fri, 30 Aug 2024 19:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725060690;
	 x=1725147090; bh=Ox11PnhqYjtKX4MSHzjEqTvyzXoH7X+J6NjAfudOl0s=; b=
	fa5xmtCatcOd+baSYMEB9sZffDuKWHC3wi5NVUC+//8pqqBYjL7Pg3lJ8kGKIfwT
	aPE/ltCUq7MfPjmqibyP7Dsw6HBRYLRoanOmb9EuF6h6SI/ETJj5xUf8PmpzdVM8
	87m8DO4E5oqdYLn0taAk+nRFqwssX7vLWJ4h9o3/kNxrPveWN0VQ9a6j1AHLHKkM
	XV8QUcjqj1w+Fq7tDqUeEr4gslVFu+cCCLih/eUG/WLa8XSRvbXB32u1rBGSo+cA
	FcFpsxC9hB+pkLpVw2HiKiGca2DLDgtHiKcCOOJXtwY2B1msu36NB/WqrCwYJ59h
	R5nl+OKD9OgYQZ/JG/ClWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725060690; x=
	1725147090; bh=Ox11PnhqYjtKX4MSHzjEqTvyzXoH7X+J6NjAfudOl0s=; b=p
	/kXSQPuKCvhGRtyJHRITvEs1l8oDep/Rzngh/FwZQBMC/BqZrT7OOC2gEiK+FIMv
	uFYn2GgdlhDmvmfPvL1UROHCJ0AmmKZIUgbEtFudO/hrBF37knsxZ+c1tc5mSTjk
	bJR9N4B9qIigdYZvjnASXezmbIRQyiYI3BCCkhCQAa4oL8rZSDJFogYi0ocTwKmA
	euPe/qveTGa+zZzrC4swIWoDMZK3nvjMBZLececKYSUEKeehns4ZHdGS0AsYcafI
	qxFLs1EpF0dpthwtSa5qs1aenXLy45KNeMdz9xSsRQjVAb90YR5gpAgMo2j2g7hD
	S8VVqfn91cc5CPv3bD7lw==
X-ME-Sender: <xms:UVbSZloqNjDkvYVot25HKEFaITNkuJ5vTGrpo-RKMPF0SOeSU2o54A>
    <xme:UVbSZnoAC5Am8X5QI1yoK-PHft4YBcVMbPOeUgZGk1x0klZ2JCHV3UhkltyBN52Y9
    xMWA4MnBnHld8AHVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefjedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlvdefmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthejredtredttdenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugi
    husegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeijeegieekffekudekkeek
    hfdvjeehleeiheeileelvdeltedukefgleegheevudenucffohhmrghinhepkhgvrhhnvg
    hlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepudehpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhr
    tghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpth
    htohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrlhgvkhhs
    rghnuggvrhdrlhhosggrkhhinhesihhnthgvlhdrtghomhdprhgtphhtthhopegurghnih
    gvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrnhgurhhiiheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    ephhgrfihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:UVbSZiMo9WrzlMm-Uxb0qS74NF_Fl5HrV465QZKnWv6m4yzabQooaQ>
    <xmx:UVbSZg71mGufeqDop1-4LNScjQ41O25QHLO9t0opTNM0vKXCAPc2Vw>
    <xmx:UVbSZk6vdoVCQOp88s9V15X9KgYvipWU-YedzmvAYiacxHxAGZVo8A>
    <xmx:UVbSZohU1zU1Usw9y2evgXiELxVo_YqJk44sa8Y_W3C6h7LYh8UEzQ>
    <xmx:UlbSZjTK9gWDzxN96kQg8XVIfEYx7vqN6OB7r_fWkgeYsy6Vgs_r7_wC>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3523B18A0065; Fri, 30 Aug 2024 19:31:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 30 Aug 2024 16:31:08 -0700
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Alexander Lobakin" <aleksander.lobakin@intel.com>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>
Cc: "Lorenzo Bianconi" <lorenzo@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "David Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <302ead12-9bb1-4c22-adf5-c89c2e6d059e@app.fastmail.com>
In-Reply-To: <20240830162508.1009458-2-aleksander.lobakin@intel.com>
References: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
 <20240830162508.1009458-2-aleksander.lobakin@intel.com>
Subject: Re: [PATCH bpf-next 1/9] firmware/psci: fix missing '%u' format literal in
 kthread_create_on_cpu()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Aug 30, 2024, at 9:25 AM, Alexander Lobakin wrote:
> kthread_create_on_cpu() always requires format string to contain one
> '%u' at the end, as it automatically adds the CPU ID when passing it
> to kthread_create_on_node(). The former doesn't marked as __printf()
> as it's not printf-like itself, which effectively hides this from
> the compiler.
> If you convert this function to printf-like, you'll see the following:
>
> In file included from drivers/firmware/psci/psci_checker.c:15:
> drivers/firmware/psci/psci_checker.c: In function 'suspend_tests':
> drivers/firmware/psci/psci_checker.c:401:48: warning: too many 
> arguments for format [-Wformat-extra-args]
>      401 |                                                
> "psci_suspend_test");
>          |                                                
> ^~~~~~~~~~~~~~~~~~~
> drivers/firmware/psci/psci_checker.c:400:32: warning: data argument not 
> used by format string [-Wformat-extra-args]
>      400 |                                                (void 
> *)(long)cpu, cpu,
>          |                                                              
>      ^
>      401 |                                                
> "psci_suspend_test");
>          |                                                
> ~~~~~~~~~~~~~~~~~~~
>
> Add the missing format literal to fix this. Now the corresponding
> kthread will be named as "psci_suspend_test-<cpuid>", as it's meant by
> kthread_create_on_cpu().
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: 
> https://lore.kernel.org/oe-kbuild-all/202408141012.KhvKaxoh-lkp@intel.com
> Closes: 
> https://lore.kernel.org/oe-kbuild-all/202408141243.eQiEOQQe-lkp@intel.com
> Fixes: ea8b1c4a6019 ("drivers: psci: PSCI checker module")
> Cc: stable@vger.kernel.org # 4.10+
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/firmware/psci/psci_checker.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/psci/psci_checker.c 
> b/drivers/firmware/psci/psci_checker.c
> index 116eb465cdb4..ecc511c745ce 100644
> --- a/drivers/firmware/psci/psci_checker.c
> +++ b/drivers/firmware/psci/psci_checker.c
> @@ -398,7 +398,7 @@ static int suspend_tests(void)
> 
>  		thread = kthread_create_on_cpu(suspend_test_thread,
>  					       (void *)(long)cpu, cpu,
> -					       "psci_suspend_test");
> +					       "psci_suspend_test-%u");
>  		if (IS_ERR(thread))
>  			pr_err("Failed to create kthread on CPU %d\n", cpu);
>  		else
> -- 
> 2.46.0

Acked-by: Daniel Xu <dxu@dxuuu.xyz>

