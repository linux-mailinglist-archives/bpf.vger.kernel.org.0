Return-Path: <bpf+bounces-27497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BD08ADBF1
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 04:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962B61C210C2
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 02:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FB317BD2;
	Tue, 23 Apr 2024 02:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="PGg8uu+A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dHD2M/z5"
X-Original-To: bpf@vger.kernel.org
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AAD1799D;
	Tue, 23 Apr 2024 02:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713839382; cv=none; b=WS8MEH/Wv77DY13rE7v6SPSpBehXQMt51WY3CJC9bOXOes0jEoyz48mbx+SnxenqM9AkfFVAyhTrPGuausHMFOYeEU2/IKXvhuTPl1P13RQ4pcHcDt8VrurOmHrMpAmi0zmcIxfO2cTIqiC0rCYeurhUe8tZ4IutyRmovCsD+y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713839382; c=relaxed/simple;
	bh=iuUICXPd82aanQpc8YCuSJ5RCWPhOMIE80SU0p8rmkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdrqbG2LkPVDGB99WjSwXQpuHSUcNBsLdYcJXt09V2fFypXSSLXKbp10wW1odh9n7DtHfxBwJ3GTYJGWZXdOvtnEds0Y+YZy8diFlTV/8hRMzVyAqvFX22BV9ISSAROr1O/majr8RBOb7sLb3BXDO057Sr1zn6monD7PRkNI/Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=PGg8uu+A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dHD2M/z5; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id CFED9180010B;
	Mon, 22 Apr 2024 22:29:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 22 Apr 2024 22:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1713839378;
	 x=1713925778; bh=07SUXgPxaGhlLuUfaceY8uMxnhhi3OU/3MlY84GXCJ0=; b=
	PGg8uu+An2QCqAACFcx1LWlOg+i/C34D/evrlvpu/mfli48d70QC62YSvPhH3/As
	KFuQ2QOMG5XfE2rG+tdfhDTLal5PdDFi8v8U/32hkA4qIEvtj33rEzKq4unLnxHF
	2em5b/zpdYC5YN6s0A2Dyfkv5b/7gPZn7V9Db0o3ge0Ef+5L8WYRLxey5X78Vtwc
	YG0/T9KBW2k8wru1bRoLzPsww68/GN3y4zF3+ywoq1/G/Obn58b28gowYch8yFn3
	LynupxtvnT6N7DXNtdPhZSo32igLIz+P7qodZ7gXiIpdHVNUrmwp41Xziptn9k15
	lnP7qCNar0qWQbFdYpP/KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713839378; x=
	1713925778; bh=07SUXgPxaGhlLuUfaceY8uMxnhhi3OU/3MlY84GXCJ0=; b=d
	HD2M/z5PLP9svsZZrtTwnV7EWidnCqnCVAHMvxKq4/u6LtbNgb4sHMl4g+/BQHQf
	s/vGzaAWC9YvzaFk0LX4G3AzXPlIXEeHBwhRPLBt+qAfF1g41F8MlA0ew3m05N42
	VqD3IIqrxP1lqpY3jU1F11PLxPnHPHv4o+iGJYeI6YBpT4kQ/Cyt/FQ68eVwomQy
	t9SbF2hHlGwXCXc4o2Jiecg+s6kNM6JVoVjs8QA7tKb8N6fYIijbq/hdtTQPIY4E
	jEnc0fpRNU2C5yCqS9aoc3STqDoisusN1pVER8koygjCZUvAp8vskmU5aYxZHliz
	HEf4sszTWlGW6HzKgjGdQ==
X-ME-Sender: <xms:ER0nZiet1qHA_s8qFtp3KSan3rJTLIbZ_yEXX0-MjhS6EL_jIhoSYw>
    <xme:ER0nZsPf4oFzBw8NTanESZsE_LNQdpLsPG61qSjzFhjF96lnV8BZYpmaiHuEZPBHx
    VNjhinURpQbDm0nng>
X-ME-Received: <xmr:ER0nZjjQxnvWpETXbTbGuaxQKn6nztTaboaR1FRohL_eeXhUWMACno8IRI5yxenWgdEM66ZFRT8qd9mi0daXeeRErKPN7OtjGU9Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeltddgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtugfgjgestheksfdt
    tddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedtgfeuueeukeeikefgieeukeffleetkeekkeeggeffvedt
    vdejueehueeuleefteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:ER0nZv9jPBtJQ8os5F8w4RiW1M6UaQnSK7857z3nNGlHX7ZbVE1sTg>
    <xmx:Eh0nZutx5WfLWQio1CuOQhOBAWNOCzg3Y7lUbc6MWXfu5skPAymDxA>
    <xmx:Eh0nZmE_lbBkYgyx8k7kLwro7TqFMxzSu1Y-JPwgQcNeemKbuj5JaA>
    <xmx:Eh0nZtOzhkTrWWQjFaKmmWIBilEVejYuM-3DEnOvF1U2V-ODv4FGKg>
    <xmx:Eh0nZoKCvm98eyRK-RqqW2eTTB65UpBCtOBB1ezK_KwQHQfYRsBFM1Cg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Apr 2024 22:29:37 -0400 (EDT)
Date: Mon, 22 Apr 2024 20:29:35 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCHES 0/2] Introduce --btf_features=+extra_features syntax
Message-ID: <uhpbft44tp3arrmvdryd23hfobndoubu3c33d6bntsuyovrtq3@r766mv2yfdqw>
References: <20240419205747.1102933-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240419205747.1102933-1-acme@kernel.org>

Hi Arnaldo,

On Fri, Apr 19, 2024 at 05:57:43PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> 	Please take a look if you agree this is a more compact, less
> confusing way of asking for the set of standard BTF features + some
> extra features such as 'reproducible_build'.
> 
> 	We have this in perf, for things like:
> 
> ⬢[acme@toolbox pahole]$ perf report -h -F 
> 
>  Usage: perf report [<options>]
> 
>     -F, --fields <key[,keys...]>
>                           output field(s): overhead period sample  overhead overhead_sys
>                           overhead_us overhead_guest_sys overhead_guest_us overhead_children
>                           sample period weight1 weight2 weight3 ins_lat retire_lat
>                           p_stage_cyc pid comm dso symbol parent cpu socket
>                           srcline srcfile local_weight weight transaction trace
>                           symbol_size dso_size cgroup cgroup_id ipc_null time
>                           code_page_size local_ins_lat ins_lat local_p_stage_cyc
>                           p_stage_cyc addr local_retire_lat retire_lat simd
>                           type typeoff symoff dso_from dso_to symbol_from symbol_to
>                           mispredict abort in_tx cycles srcline_from srcline_to
>                           ipc_lbr addr_from addr_to symbol_daddr dso_daddr locked
>                           tlb mem snoop dcacheline symbol_iaddr phys_daddr data_page_size
>                           blocked
> 
> ⬢[acme@toolbox pahole]$
> 
> From the 'perf report' man page for '-F':
> 
>         If the keys starts with a prefix '+', then it will append the specified
>         field(s) to the default field order. For example: perf report -F +period,sample.

I think for perf it makes sense to have compact representation b/c
folks might be doing a lot of ad-hoc work. But encoding BTF seems more
like a write-once, read mostly. So having `+` notation doesn't feel like
it'd help that much.

As someone who's not seen that style of syntax before, it's not
immediately obvious what it does. But seeing `all`, I have a pretty
good idea.

[..]

Thanks,
Daniel

