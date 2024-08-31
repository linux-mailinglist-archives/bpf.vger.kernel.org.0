Return-Path: <bpf+bounces-38627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5128966D69
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 02:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646A21F24970
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 00:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB244C99;
	Sat, 31 Aug 2024 00:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="UJClZ7qa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LtRXlSSb"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B9063A9;
	Sat, 31 Aug 2024 00:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725063581; cv=none; b=OSoQ90M3xkqlLdhEznsmz/buU554jRlwtxyNE08uQwRqN5c7YZfY4k86J7BRj+2pFNXyKmj/dxfna5U9ZmoWB+b5nrzi7TbexAGGpX5K7k5TNyLChmTZn4dOqJjKuAorKDVhGrsThvDKZEJrSlouKjMsmKSxVP3l2vf+0XHFnbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725063581; c=relaxed/simple;
	bh=Xit+zkVOBlL3WyOtKLFfILoFr16PkK9e1KukdDCKCms=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UCWHY/+bX7hlKqqSk/+joLci3kam6kQiZ6my43DA2VILnT49aniwk2gv0KzuAiOrcOZw254VwJD5SeUX9iDo1LEnHWd8db79VT1TNrsOyM3GOSo5VZxd+tzBoRZ+d5xjf7mThMCb4FGKf8XdlzsDsZGRWhTd4bkb4xLmige9yIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=UJClZ7qa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LtRXlSSb; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A62AC11402B6;
	Fri, 30 Aug 2024 20:19:38 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Fri, 30 Aug 2024 20:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725063578;
	 x=1725149978; bh=1HRunSKQ4x8fkLSvpoO3iIkHr9AmUojJnMboig4OCPc=; b=
	UJClZ7qa6wlu6Dj7jVVyD8UTfCFkR0mv56tuyskSSR8PunRMeJQtUSkYE1RbGeWL
	EqxpFdOpevhzcW4ds6/x8l03oBDRfxQ1BiGQFO1UQIo7yxfc/rCpKgQ5PU4Y7iYS
	ANQdbFtSgF8mK5VeGz+EIQ4a2sSXPk8QP2z8sIhD1Yb2HQbNP4ghwYX5QofzPAtg
	3OyvcJaAvKtCEdj3DmP85ey5CEpAYTnL3lawzVaBa3SXkY9Q1DTFdeNUL5EHTPPx
	yKKSsFMjP+4u7BeJhz13u0iS8QMFAsmdH0XL1zgOiej+ofSFbRs1wYvPrJqleVSM
	8w3QMUpRN2zmVSAQMZK2DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725063578; x=
	1725149978; bh=1HRunSKQ4x8fkLSvpoO3iIkHr9AmUojJnMboig4OCPc=; b=L
	tRXlSSb4SmsrLPtfOPWfv+HuqaezDNUAO4Q3eeiLgLK/si7TtK3/tVxOzEHaM9U2
	yQuoQ2Kf0rUEOVhy39NmLi4vBdVOZB142gTqd7ePddVSJ09yX1tT7njeeG9fDHdX
	GGvLN+CuuW6Xa+cxDNtkn1HzBw7DGE1dBbpUBnEQDGh4N7HOvug/KaXoqMOwFxcO
	eKg8+9x3ccoiKyevJzWkJ8Zg4zOVrsOiPIbNGgTUV1rHOJUyr+2891vZkxEEQwZz
	k6HyWT9rPo2NBKJMPgMgjvVuKlK3CwZ87JuIE81yOTSR0VeFfTM+Wm6GI1jEEvfJ
	eZWxGOmyU59OGvUcQK7dw==
X-ME-Sender: <xms:mWHSZm4Ao1Wd85dKLrgqp8mXrM7VsFsPuTUSmHA0j2kMyv0BFER2aQ>
    <xme:mWHSZv4eKPqSoIBDZxRi_Fl3lVLc_R95wqICE__xaIjYvyFhiXlw4unm3dQR3bVtE
    1aGpusATy-s7TixMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefjedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlfeehmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthejredtredttdenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugi
    husegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeegleeifffhudduueekhfei
    fefgffegudelveejfeffueekgfdtledvvdeffeeiudenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggp
    rhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghn
    ugesghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrd
    gtohhmpdhrtghpthhtoheprghlvghkshgrnhguvghrrdhlohgsrghkihhnsehinhhtvghl
    rdgtohhmpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtg
    hpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehhrgifkheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mWHSZle-dVxZzBjilfXvCp0DwryT3oFiZ8pWygwMqnpznMxqJSJk4Q>
    <xmx:mWHSZjKhO1ax2s2E3gQLD6ZxMfXHpDASVAIvLwA55HFHGBSiWi1d3Q>
    <xmx:mWHSZqJSknzf8N_tERiitFhN6jUAM00XaoBSMRBB4N3giPZdNlhzsg>
    <xmx:mWHSZkxXyaoEa3EywarhPWxH0sEipjSCicc03a4p32iJ4mbw8MjI-A>
    <xmx:mmHSZsgbc17hu8EMcdhgMMLsSAL52hS78FusZ0uKLyDxQ7vKHvHmCpYD>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A6C4D18A0065; Fri, 30 Aug 2024 20:19:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 30 Aug 2024 17:19:17 -0700
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
Message-Id: <60cbe452-e1f3-4507-9b3b-563906eccb15@app.fastmail.com>
In-Reply-To: <20240830162508.1009458-4-aleksander.lobakin@intel.com>
References: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
 <20240830162508.1009458-4-aleksander.lobakin@intel.com>
Subject: Re: [PATCH bpf-next 3/9] net: napi: add ability to create CPU-pinned threaded
 NAPI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Aug 30, 2024, at 9:25 AM, Alexander Lobakin wrote:
> From: Lorenzo Bianconi <lorenzo@kernel.org>
>
> Add netif_napi_add_percpu() to pin NAPI in threaded mode to a particular
> CPU. This means, if the NAPI is not threaded, it will be run as usually,
> but when switching to threaded mode, it will always be run on the
> specified CPU.
> It's not meant to be used in drivers, but might be useful when creating
> percpu threaded NAPIs, for example, to replace percpu kthreads or
> workers where a NAPI context is needed.
> The already existing netif_napi_add*() are not anyhow affected.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/linux/netdevice.h | 35 +++++++++++++++++++++++++++++++++--
>  net/core/dev.c            | 18 +++++++++++++-----
>  2 files changed, 46 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index ca5f0dda733b..4d6fb0ccdea1 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -377,6 +377,7 @@ struct napi_struct {
>  	struct list_head	dev_list;
>  	struct hlist_node	napi_hash_node;
>  	int			irq;
> +	int			thread_cpuid;
>  };
> 
>  enum {
> @@ -2619,8 +2620,18 @@ static inline void netif_napi_set_irq(struct 
> napi_struct *napi, int irq)
>   */
>  #define NAPI_POLL_WEIGHT 64
> 
> -void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
> -			   int (*poll)(struct napi_struct *, int), int weight);
> +void netif_napi_add_weight_percpu(struct net_device *dev,
> +				  struct napi_struct *napi,
> +				  int (*poll)(struct napi_struct *, int),
> +				  int weight, int thread_cpuid);
> +
> +static inline void netif_napi_add_weight(struct net_device *dev,
> +					 struct napi_struct *napi,
> +					 int (*poll)(struct napi_struct *, int),
> +					 int weight)
> +{
> +	netif_napi_add_weight_percpu(dev, napi, poll, weight, -1);
> +}
> 
>  /**
>   * netif_napi_add() - initialize a NAPI context
> @@ -2665,6 +2676,26 @@ static inline void netif_napi_add_tx(struct 
> net_device *dev,
>  	netif_napi_add_tx_weight(dev, napi, poll, NAPI_POLL_WEIGHT);
>  }
> 
> +/**
> + * netif_napi_add_percpu() - initialize a CPU-pinned threaded NAPI 
> context
> + * @dev:  network device
> + * @napi: NAPI context
> + * @poll: polling function
> + * @thread_cpuid: CPU which this NAPI will be pinned to
> + *
> + * Variant of netif_napi_add() which pins the NAPI to the specified 
> CPU. No
> + * changes in the "standard" mode, but in case with the threaded one, 
> this
> + * NAPI will always be run on the passed CPU no matter where scheduled.
> + */
> +static inline void netif_napi_add_percpu(struct net_device *dev,
> +					 struct napi_struct *napi,
> +					 int (*poll)(struct napi_struct *, int),
> +					 int thread_cpuid)
> +{
> +	netif_napi_add_weight_percpu(dev, napi, poll, NAPI_POLL_WEIGHT,
> +				     thread_cpuid);
> +}
> +
>  /**
>   *  __netif_napi_del - remove a NAPI context
>   *  @napi: NAPI context
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 98bb5f890b88..93ca3df8e9dd 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -1428,8 +1428,13 @@ static int napi_kthread_create(struct 
> napi_struct *n)
>  	 * TASK_INTERRUPTIBLE mode to avoid the blocked task
>  	 * warning and work with loadavg.
>  	 */
> -	n->thread = kthread_run(napi_threaded_poll, n, "napi/%s-%d",
> -				n->dev->name, n->napi_id);
> +	if (n->thread_cpuid >= 0)
> +		n->thread = kthread_run_on_cpu(napi_threaded_poll, n,
> +					       n->thread_cpuid, "napi/%s-%u",
> +					       n->dev->name);
> +	else
> +		n->thread = kthread_run(napi_threaded_poll, n, "napi/%s-%d",
> +					n->dev->name, n->napi_id);
>  	if (IS_ERR(n->thread)) {
>  		err = PTR_ERR(n->thread);
>  		pr_err("kthread_run failed with err %d\n", err);
> @@ -6640,8 +6645,10 @@ void netif_queue_set_napi(struct net_device 
> *dev, unsigned int queue_index,
>  }
>  EXPORT_SYMBOL(netif_queue_set_napi);
> 
> -void netif_napi_add_weight(struct net_device *dev, struct napi_struct 
> *napi,
> -			   int (*poll)(struct napi_struct *, int), int weight)
> +void netif_napi_add_weight_percpu(struct net_device *dev,
> +				  struct napi_struct *napi,
> +				  int (*poll)(struct napi_struct *, int),
> +				  int weight, int thread_cpuid)
>  {
>  	if (WARN_ON(test_and_set_bit(NAPI_STATE_LISTED, &napi->state)))
>  		return;
> @@ -6664,6 +6671,7 @@ void netif_napi_add_weight(struct net_device 
> *dev, struct napi_struct *napi,
>  	napi->poll_owner = -1;
>  #endif
>  	napi->list_owner = -1;
> +	napi->thread_cpuid = thread_cpuid;
>  	set_bit(NAPI_STATE_SCHED, &napi->state);
>  	set_bit(NAPI_STATE_NPSVC, &napi->state);
>  	list_add_rcu(&napi->dev_list, &dev->napi_list);
> @@ -6677,7 +6685,7 @@ void netif_napi_add_weight(struct net_device 
> *dev, struct napi_struct *napi,
>  		dev->threaded = false;
>  	netif_napi_set_irq(napi, -1);
>  }
> -EXPORT_SYMBOL(netif_napi_add_weight);
> +EXPORT_SYMBOL(netif_napi_add_weight_percpu);
> 
>  void napi_disable(struct napi_struct *n)
>  {
> -- 
> 2.46.0

Acked-by: Daniel Xu <dxu@dxuuu.xyz>

