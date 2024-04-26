Return-Path: <bpf+bounces-27873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3460F8B2DF7
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 02:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60A41F21DDC
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 00:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B89653;
	Fri, 26 Apr 2024 00:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="JRw+CGZr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XvLzfUMM"
X-Original-To: bpf@vger.kernel.org
Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87214620
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 00:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714090991; cv=none; b=hYJQqGVaEkpXBZ+Uc+DTjqJHv7qegho8rRuqQSBfz0sbwUdQlhSkjy6kHNflc7gt0q0VW35hBywvRU8GXNu1g6LjWLmCKS+/nkXTWB3zwhk9Aaev/tY5YkMhHgnx07SxxqXnnnjhHMkwPTXYoQMaoF9pPay8FGKU6z4cXC7MEsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714090991; c=relaxed/simple;
	bh=n8maNEBZxReHycDdqoHFTLtwBixiJB7dDXZBuo38yp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cq8PlpfRWXP6PD/XVzYDTA6QgaX/8uevxaXrLwlDpmTWodDZx/xGaUyYcYcfZoB1cOCHEMCFHhgIet9A3GHlpSvi/hq6BoIPHiW8Df41dgXW50vxMwJUm0KV22XLg/ULTdwmPmbtjJDdbVc6zF0YeHB9ssfrvKm7RyCUSqtExHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=JRw+CGZr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XvLzfUMM; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id DD7961C000F0;
	Thu, 25 Apr 2024 20:23:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 25 Apr 2024 20:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1714090987; x=1714177387; bh=9MdlnH4zm4
	90tOXaxWVS63hxZbumYGjtob9TOtCBiuQ=; b=JRw+CGZrLMRYnUx38Gg9A5MDax
	kQG7vCF1m5rbjyRg/oQXZKhc8+DiYrsnAOsYvB6wq2Kg4pp43miAK/9Gp7YQPY/p
	lM2n6pFQJ/7dy8uYckH7+GJi95GpY+qJPdPNLma8uDYF9cWPfFm8vD/DnkKuYNU8
	wPT7fJb6n1H2n5V8IYeUXzjwiFaC4NrJI0plG82YvOO+JFNXYrwNTXtOpJc99Eff
	jti88tdHx7t0kqFvI/EF1SO+eWxgyK5WuIjLgSrsXITeh6GJvGNyQRkLYDFmCwls
	ZWSctVfpZfbFFgOd9TADvAQEY+33Cs0xO5ggb4o0qbCZmaIu80Kr7lp96Zig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714090987; x=1714177387; bh=9MdlnH4zm490tOXaxWVS63hxZbum
	YGjtob9TOtCBiuQ=; b=XvLzfUMM+6O0FM8Em+GFIv/udbt5h1stY70WHgInlg0E
	BuAPKV4MQn7HxuEfHuHcJyeFPDFHpVl521E6ER+V+ce3Ya8tagGWQo3aPHuHTtYE
	2CB+o3W73aJ7hRQ5riuGmKIjXQOC3pHqysR9p0Zo5duOfHj8jih1EUEWtdMmUnpv
	aK7arHw+XO5zre1e2pmk9G6LzmHTBMvYYwBTukUGxPU5+O5/Jh6fZVGvoE7aG55V
	doEcJ28CXfVkBw3xgbJuq8QnAVoq6yN9Fy1ELf8A6fRhvTP+0l82YQzw2EA8dWlR
	UATxIrdwB75c3WVarXXJvfnwcguzYFZXnFk5+4WZ3Q==
X-ME-Sender: <xms:6vMqZvPug8KjqE0Omcj6mO2CpoTr-2H5PnnvxXo4hWwnctxikaQi8g>
    <xme:6vMqZp8r1aQ8hoskASEVerm3ZKovk0lbeyWQ4fVG9jkIeAyfOEHfuYbwBImbJNnJz
    s6zRcTQLJWpqf9ZOA>
X-ME-Received: <xmr:6vMqZuTE6MMRxJJTnaDAEpm1dm2AnXvzF4HWB3ly35Jjs3R-y9XPqqA9uuq-7bwSQxcOOR47HYBrURPr0cXbcS3r10YPb_cIOiug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelkedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepleehieefgffhffdvueegjedthefftefhheehvddtvdehtdfh
    keduheduveegjedtnecuffhomhgrihhnpehrvghprhhoughutghisghlvggpsghuihhlug
    drshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    ugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:6vMqZjsZFApbM6E8Dze6qJyMuT-rTc_2rWTbmG4Bn06AROettbKNsw>
    <xmx:6vMqZneE4QGyJSy5o3hhm1yl3wgkb_dCmsYNFLpBtALPlPqRN6M9hA>
    <xmx:6vMqZv3sojr5FU5UiVe_3VKQ3NnxN0MbYoTkLzGgR2Q7q-85x5KRHw>
    <xmx:6vMqZj_HI6oAeByN6x-f9Ynq3efe0uUm37KAJetWjWMit_kHDp_pOw>
    <xmx:6_MqZr7-HWN9j4hZAqpzFJ86GT2hlu0Ge9CLDjwTDnsVqwh-lR1A7ni3>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Apr 2024 20:23:06 -0400 (EDT)
Date: Thu, 25 Apr 2024 18:23:04 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, jolsa@kernel.org, quentin@isovalent.com, 
	eddyz87@gmail.com, andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v7 2/2] pahole: Inject kfunc decl tags into BTF
Message-ID: <4ptkrgn7wcfcnl6qlqcrj2t4izc6ms236w3p3t6rc25yvz365u@ftzwrtwemn4a>
References: <cover.1713980005.git.dxu@dxuuu.xyz>
 <bd853cc2c6da4c29984b8751c0adf81a3ba0b8a3.1713980005.git.dxu@dxuuu.xyz>
 <7399c206-23e0-49ea-b46f-5ea582c18cc5@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7399c206-23e0-49ea-b46f-5ea582c18cc5@oracle.com>

Hi Alan,

On Thu, Apr 25, 2024 at 09:16:07AM +0100, Alan Maguire wrote:
> On 24/04/2024 18:33, Daniel Xu wrote:
> > This commit teaches pahole to parse symbols in .BTF_ids section in
> > vmlinux and discover exported kfuncs. Pahole then takes the list of
> > kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> > 
> > Example of encoding:
> > 
> >         $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kfunc'" | wc -l
> >         121
> > 
> >         $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
> >         [56337] FUNC 'bpf_ct_change_timeout' type_id=56336 linkage=static
> >         [127861] DECL_TAG 'bpf_kfunc' type_id=56337 component_idx=-1
> > 
> > This enables downstream users and tools to dynamically discover which
> > kfuncs are available on a system by parsing vmlinux or module BTF, both
> > available in /sys/kernel/btf.
> > 
> > This feature is enabled with --btf_features=decl_tag,decl_tag_kfuncs.
> > 
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > Tested-by: Jiri Olsa <jolsa@kernel.org>
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > Tested-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> 
> I ran into failures running the reproducible build test in tests/
> with this patch.
> 
> You can reproduce this by running that via
> 
> bash reproducible_build.sh /path/2/vmlinux
> 
> or just doing
> 
> pahole --btf_features=default
> --btf_encode_detached=/tmp/vmlinux.btf.serial /path/2/vmlinux
> 
> The problem seems to be with detached encoding. It stems from the
> assumption that encoder->filename is the source of the BTF and the
> destination. In the case of detached BTF, source and destination are
> different, so I think we just need to store both the source and
> destination for encoding in struct btf_encoder.
> 
> The following change fixed this for me:
> 

Thanks, I can confirm the patch works. Will respin.

Daniel

