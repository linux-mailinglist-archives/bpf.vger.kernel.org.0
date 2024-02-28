Return-Path: <bpf+bounces-22886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47E886B42E
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 17:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A65828318F
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 16:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B2415D5C1;
	Wed, 28 Feb 2024 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="XfvIlw/H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rXJhV0+j"
X-Original-To: bpf@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9861D15B98B
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136482; cv=none; b=LsGKr6KWGuU4a0sCs4RQoWXN6deMU36RDpEOcx9Y0f1QzGD69WvQGhI0RuDWwXCVpXXSa7Txu2YECnP5JqGbUsjBWTGMjdNvVQ6w8uaEqoz69V2/z+MVbMaAjdjKp6C+udkEDSC7U4wXs3XuHWO3IhNMRcgIL4sooBVvVl+93RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136482; c=relaxed/simple;
	bh=OFwf1uUDN/0r5/eZh93+LKLkbnzfEWSTp29XDdiDdHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpWK5mzAsxas/vDcuQSi/iE5yCDNkI3FVr2v24LyvKcYBWD3oN4Re4FpIoR8qRYMHw3m2uu+wjRgI67mh1EVX+XAv4Yw9BlKVTTUr9SHgPu8JEbRo4HGm4cmff8EJyD9CiU9AR7A/6FwiBIzq1pUDv4seNdqL2DxwL7plEYnAoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=XfvIlw/H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rXJhV0+j; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id C28213200AF3;
	Wed, 28 Feb 2024 11:07:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 28 Feb 2024 11:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709136473; x=1709222873; bh=BY6DBW3uAy
	mplsvJeu511/30jCyCom3bS75tyK+D7Gw=; b=XfvIlw/Hdj6MtSFdunc/w7lYDP
	8zBFPSL/oURGgpDizajASBcjvW6lJOo3zfFNsiQIBriVG2tjCpBq6yv7cR2LYeeG
	ZoaW3HWe3DTZZEKd/ellC6rNcnnFOy1pRsPeCQK5+IjcwmtUCkBEZoP2ciN+c8iK
	cp5pFsB5mgaGED2I0AvrJboIa+EYMDMQd2gK5SiTJFnmhDXfZSQkOJAYu9A+BGt2
	NnO4bdiqP5LfAYSTU2v+KWiekPrYNKNE2xYMnPLxeAK/fzQCfTHTnFX2NU57EEUw
	pxPh1ifeGv6sxzBHHNNUQXCjXJ0oMv1EUrksYgOqWOLxvAmp9nqcpjjG7cvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709136473; x=1709222873; bh=BY6DBW3uAymplsvJeu511/30jCyC
	om3bS75tyK+D7Gw=; b=rXJhV0+j8hA7EmH1xe8UuKItSqY2FebCqCmGQpmGTnor
	IVRLEgx3CnFVU4FNW5r1hfyUSWedpZxbjXKPcBZvvQBMxMMlNcgcEl2qFC/ykNdp
	BlNTJUHwjK1pn2+KIRee880wtZkU0mZ4MmmneA/McbFRmzmrvMd9h/ckuDRPGPw1
	EscpJITG35Jl0ceiDwqT+bG3GMT8GCCUXfNO+ltDZQAmjAMmkDpwHPui5+o0z+BB
	eiaXPEvs+CzN9zfyzCavd5PS6RMc6ZrNGf7AR2qe9bloNDzAcL7SSRDyadb4Wnia
	W7qwpeniheMVQikgREimAWsJwddhanVwMHaQguL0bw==
X-ME-Sender: <xms:WFrfZcq3fQMKm2r1lCHcCle5lh-Ee_ppoGXfTcwpYW-DM_wkvU_Z0w>
    <xme:WFrfZSrZ1FFNi3OI-OY6LRiuqyU6IxiPE1d6IrRH73dA_610H7-ZpgFQNFIHt6q7b
    Mfa0HkMyTXyFxEXJQ>
X-ME-Received: <xmr:WFrfZROL1KjQXDtBIKq5Ld5u7IsxMGNXTbctKtaeN6NOvc20nfAeAaRaHMrP7W0eN3s5FlwmNdWhCIoNXFHc5d3BucmJgCvjjTVhb60>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeejgdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhepfffhvf
    evuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeujeetkeehvddvkeelhf
    ehgeevveehveejleffudehteduudefheefkeekleevjeenucffohhmrghinhepugiguhhu
    uhdrgiihiienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:WVrfZT612ct7YOGptnUQnHZ-97PkCHQZi4xkWvRVTsGkqG5e0T0Rlg>
    <xmx:WVrfZb6j83k5UaCybgcNdtCeulj_hcSGqfVvFqdOo7Tx7ltdvHvfDQ>
    <xmx:WVrfZTgI6Amt5YSr52Z4Y57ts_bdhyzk3ZISho0eGWZJjWQofr0iRQ>
    <xmx:WVrfZeYBL4pv8zro0V-WEwH7SVuE3IKLct8xcJe25lkdqyGjf7TuNg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Feb 2024 11:07:52 -0500 (EST)
Date: Wed, 28 Feb 2024 09:07:50 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: acme@kernel.org, jolsa@kernel.org, quentin@isovalent.com, 
	alan.maguire@oracle.com, andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v4 2/2] pahole: Inject kfunc decl tags into BTF
Message-ID: <7bpvkfzqfawuzltt7jicekwlbxokdbprom6io3fxef3rbng4ud@hwohkmt662ar>
References: <cover.1707071969.git.dxu@dxuuu.xyz>
 <28e81ccf28d6dd33f6db50af6526dc1770502b8d.1707071969.git.dxu@dxuuu.xyz>
 <1853738ac796d75c53970e21b6d61bf5140a6cc1.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1853738ac796d75c53970e21b6d61bf5140a6cc1.camel@gmail.com>

Hi Eduard,

Apologies for long delay - life has been busy.

On Tue, Feb 06, 2024 at 01:31:20AM +0200, Eduard Zingerman wrote:
> On Sun, 2024-02-04 at 11:40 -0700, Daniel Xu wrote:
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
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> 
> I've tested this patch-set using kernel built both with clang and gcc,
> on current bpf-next master (2d9a925d0fbf), both times get 124 kfunc definitions.
> 
> Tested-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> Two nitpicks below.
> 
> [...]
> 
> > +static char *get_func_name(const char *sym)
> > +{
> > +	char *func, *end;
> > +
> > +	if (strncmp(sym, BTF_ID_FUNC_PFX, sizeof(BTF_ID_FUNC_PFX) - 1))
> > +		return NULL;
> > +
> > +	/* Strip prefix */
> > +	func = strdup(sym + sizeof(BTF_ID_FUNC_PFX) - 1);
> > +
> > +	/* Strip suffix */
> > +	end = strrchr(func, '_');
> > +	if (!end || *(end - 1) != '_') {
> 
> Nit: this would do out of bounds access on malformed input
>      "__BTF_ID__func___"

I think this is actually ok. Reason is we have the strncmp() above
so we know the prefix is there. Then the strdup() in the malformed cased
returns empty string. And strrchr() will then return NULL, so we don't
enter the branch.

I tested it with: https://pastes.dxuuu.xyz/c3j4kk

        $ gcc test.c
        dxu@kashmir~/scratch $ ./a.out
        name=(null)

> 
> > +		free(func);
> > +		return NULL;
> > +	}
> > +	*(end - 1) = '\0';
> > +
> > +	return func;
> > +}
> 
> [...]
> 
> > +static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
> > +{
> 
> [...]
> 
> > +	elf = elf_begin(fd, ELF_C_READ, NULL);
> > +	if (elf == NULL) {
> > +		elf_error("Cannot update ELF file");
> > +		goto out;
> > +	}
> > +
> > +	/* Location symbol table and .BTF_ids sections */
> > +	elf_getshdrstrndx(elf, &strndx);
> 
> Nit: in theory elf_getshdrstrndx() could fail and strndx would remain
>      uninitialized.

Sure, will fix. Also fixing typo (Location -> Locate).

Thanks,
Daniel

