Return-Path: <bpf+bounces-35383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D53CC939E29
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 11:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45E101F23711
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 09:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9462814D2A8;
	Tue, 23 Jul 2024 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FycEj5sm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vYQ1IT6z"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7D022097;
	Tue, 23 Jul 2024 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721727987; cv=none; b=Q8rpkdbR8lWlYpFsI0enE4VxkCZTL4w63EQpzAudcfQCVQiKd8K7wFjJIG/3VpIoAzMkqivDQ630UQNB559liPB+pCFMsdk6R09X+psvZV1jH26p8YRANOfRbSkyD4bcvtOfEgTr79Du+L7d9HQ3D23V5nK06XyMjhY32LMK6hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721727987; c=relaxed/simple;
	bh=SDZkrHDXihkZLFUA+afpklJ0Ka1GpK6r8zEb7TtzG1Y=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Uuxjpi0+e4pX1YJutXF/ps8YfAL564hVi1YAlpHZlDi/VIbhrXNAC8wC4JB5Lk+mimiHSl/NJ02ktEpP3Cs4gMAnBBvFqMpOtKpRFy2RVKP39tDSzvJii5mA3jxAgq7kTjwVBuQCGgGVGCP38fZtLuXZ/Gh5JNaLWNEs7IaFZqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=FycEj5sm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vYQ1IT6z; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AC52E1140117;
	Tue, 23 Jul 2024 05:46:23 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Tue, 23 Jul 2024 05:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721727983; x=1721814383; bh=hYTOAv7vr3
	4W2ZK6n4dVMB6LprUK2UnFmXnaIU3Myz0=; b=FycEj5smQgz/MqqtxNiqeaBDeM
	pkCET+nHwsuOuqkLiPR1C5562XzxtkTdkSGmqBJ4ntBbYpjODYKf4awcnvk2gVCD
	7Jx3JDI6b8Vl5ZKDHzWFZjMKUmS+8iCOohpvqXKS+n6IvawiuAlpQYZWn+BUb/OH
	0Z0PwbElOxkfWG+fEKs8LbqLuQIGm5JRy3mrrnzJFrzP2GQVeZvAhp+mfduGDgRU
	2GSTS+7gWYIvJKqICAB0qSe2GLwAEJBdevWniXk0+B7iauSQsmTM0XiLO9KiXfHM
	ZVzN6/ax4NfbyZyFa38JeEsWzkxfk2oecWknrnVvfYE83Un/R0jGGzVCVM5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721727983; x=1721814383; bh=hYTOAv7vr34W2ZK6n4dVMB6LprUK
	2UnFmXnaIU3Myz0=; b=vYQ1IT6z7/W3zMSmYbcefRQOjjjOnHvy838azHswQrzP
	o5teq+J2JVlmRrmxwWlSDFDHNVbKDhmgYT7ysFS6Otg/0bRhm5ZYjSOeYpWf7B3s
	Cuxno3Fa3AMPTDSb5X4yBx+MeUcbWTIaRdGR0Y1WAc/6x18XVExYg4nabnqFCw+U
	My8xletdSHEFq/SqOigalfyp5OIc9eflOXvXuAKBQo6KMTLqHecYYo7cOdQGtt7q
	D3vHTFFAczfnL4rP8zYcAE2SQxxV7AP8O+u1guhdy/JdrIzuayzxwgg12jSwfpgz
	70nVV51atwhZjsOkZ1B/gYimqtcVdxJxURfKE7Y4qg==
X-ME-Sender: <xms:73ufZmsq4JF53pu_FWvRsOIHN_zt3RHkUKIxYNcmS_Og8hjDArf78g>
    <xme:73ufZrdNKK9s4niT0xfWRaC5_9fT8MUicaWmVqitVPDGRfv2GeGCgHwY5G2HFulyb
    echEScyOdPqUEDJbNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheelgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:73ufZhzZDxjnricPq40w8HHkK0s5iEvd0X-K185gKNch0H-4WrO8pg>
    <xmx:73ufZhMFgi6GFYQwE2N6dr0Wp44utj98e8pPAuUhMe37J2M7MSh_lg>
    <xmx:73ufZm__sgHeW1vp3hEWeNOtfykdXHfEaybV_jvb3llskcz8MkvgEw>
    <xmx:73ufZpUY78dE3N4JnnJbS7ReQGGt-jPGvOdxgTGDlfYtxje5rzzy7A>
    <xmx:73ufZpV6AORtIRVqwLozrg1qvDCqSHgtbuyn-ValQKKAALFDAEWWtTlE>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 36290B6008D; Tue, 23 Jul 2024 05:46:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1a663b40-644b-48b3-880e-b24e3dd4827e@app.fastmail.com>
In-Reply-To: <20240722094226.21602-14-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-14-ysionneau@kalrayinc.com>
Date: Tue, 23 Jul 2024 09:46:01 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yann Sionneau" <ysionneau@kalrayinc.com>, linux-kernel@vger.kernel.org
Cc: "Jonathan Borne" <jborne@kalrayinc.com>,
 "Julian Vetter" <jvetter@kalrayinc.com>,
 "Clement Leger" <clement@clement-leger.fr>,
 "Guillaume Thouvenin" <thouveng@gmail.com>,
 "Jules Maselbas" <jmaselbas@zdiv.net>,
 =?UTF-8?Q?Marc_Poulhi=C3=A8s?= <dkm@kataplop.net>,
 "Marius Gligor" <mgligor@kalrayinc.com>,
 "Samuel Jones" <sjones@kalrayinc.com>,
 "Vincent Chardon" <vincent.chardon@elsys-design.com>, bpf@vger.kernel.org
Subject: Re: [RFC PATCH v3 13/37] kvx: Add build infrastructure
Content-Type: text/plain

On Mon, Jul 22, 2024, at 09:41, ysionneau@kalrayinc.com wrote:
> +
> +config GENERIC_CALIBRATE_DELAY
> +	def_bool y

You don't seem to define ARCH_HAS_READ_CURRENT_TIMER 
or calibrate_delay_is_known(), so it appears that you are
measuring the loops per jiffy. Since you are using a
cycle counter for your delay loop, you should be able
to just set the value directly instead.

> +	select GENERIC_IOMAP
> +	select GENERIC_IOREMAP

GENERIC_IOMAP is something you should normally not
set, it is a bit misnamed and not at all generic ;-)

> +config ARCH_SPARSEMEM_ENABLE
> +	def_bool y
> +
> +config ARCH_SPARSEMEM_DEFAULT
> +	def_bool ARCH_SPARSEMEM_ENABLE
> +
> +config ARCH_SELECT_MEMORY_MODEL
> +	def_bool ARCH_SPARSEMEM_ENABLE

There has been some discussion about removing traditional
sparsemem support in favor of just using SPARSEMEM_VMEMMAP,
which is simpler and more efficient on 64-bit architectures.

You should probably have a look at that.

> +config SMP
> +	bool "Symmetric multi-processing support"
> +	default n
> +	select GENERIC_SMP_IDLE_THREAD
> +	select GENERIC_IRQ_IPI
> +	select IRQ_DOMAIN_HIERARCHY

Do you have a use case for turning SMP off in practice?
Non-SMP kernels can be a little more efficient, but it's
getting rare these days to actually have systems with
just one CPU.

> +config KVX_PAGE_SHIFT
> +	int
> +	default 12

There is now a generic CONFIG_PAGE_SIZE and CONFIG_PAGE_SHIFT
setting, so you can remove the custom ones and just use
'select HAVE_PAGE_SIZE_4KB'

> --- /dev/null
> +++ b/arch/kvx/include/asm/Kbuild
> @@ -0,0 +1,20 @@
> +generic-y += asm-offsets.h
> +generic-y += clkdev.h
> +generic-y += auxvec.h
> +generic-y += bpf_perf_event.h
> +generic-y += cmpxchg-local.h
> +generic-y += errno.h
> +generic-y += extable.h
> +generic-y += export.h
...

You seem to have more entries here than necessary, e.g.
clkdev.h and auxvec.h are no longer in asm-generic, and
export.h is deprecated.

      Arnd

