Return-Path: <bpf+bounces-22983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D4086BDA6
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 02:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66182285177
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 01:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9B829D0C;
	Thu, 29 Feb 2024 00:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="H+SHl2py";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bPMAh6wT"
X-Original-To: bpf@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B071A224DC
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 00:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168227; cv=none; b=COlL5oyKhco0NB4x/WPM7sTlejFUDykQU0toSCi4X6IdhR5Lhr2vysBlrqv+Fu23ubTx9pZo8nN+LqMiquteuckV5BsVeQQf70NG2IgjlKp6Ctqasy2f0hAzoEEqs8FzdDNaYXPzLCPE2onaA6WgMujhdQWITbTzkZVl+mmM30s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168227; c=relaxed/simple;
	bh=km3Embtu6k2I+xt4ZYTUv4KK6ISY+6X2zxONpHK9CrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aA38KGbw9hYQEIpF7cApti7IfxNDShFF6quKuFbLPp98Ezml56rFX5+rHBfUxT2ae+8AtxSMRI5OH6fKMvfFHs63VgNMt69fQ1k7MjFXaGW/KUjKtI90G3Ey5OUdFHGT++zY/Xmj0Sf/fPlQphcLcxbdWlUz2YSVLvjx/BNjcXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=H+SHl2py; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bPMAh6wT; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 9DB585C0189;
	Wed, 28 Feb 2024 19:57:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 28 Feb 2024 19:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709168223; x=1709254623; bh=pdKiR7da5w
	Kkawj4dEY7sPyidEpGgrLgSPCB1xMeEAs=; b=H+SHl2pyo2z6Nf2+g0M2QwlXT3
	Vte7WEkjwypYRlV2SvALHhTaS+e/5sYjSKyOzcjjB0tQtux3NvzMaS9DG0opeNyi
	1pWUOgCuS9whNUsvBOw6j0l1JzSosdk8hEiIqLaOLWNNTmGkXvLJKUzo2PtBjd86
	uclFIZWXbUzjGqgBDsNg+fDsCprMmCex4qomQmBsGm+r63smVCfnW2Sr4W5HdyWb
	0GO06oJcPINeg5N6psoS82WdzIrjvOeb5UR0vh8VT7CyCHPe8AoVmr+DNcbqQm7v
	Fvl/CRqAj3cSF58gh2eu902NUR9EoMJi4x0fAva+1DAGLjvVXJdy7Jb/461g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709168223; x=1709254623; bh=pdKiR7da5wKkawj4dEY7sPyidEpG
	grLgSPCB1xMeEAs=; b=bPMAh6wTx6FNqcxq9G/DJ/5UXvJdaZ3vcLuUcj2H270q
	BOq8qqezCtIq4jONxMFiJ+6QdHPjRBwH7+Ic3t9F3YHt+FKCRbK3Rxa5U2TecMB6
	CZS7iiK/Nzkry4eWPrbYRFDCEnK7HGfrfdswEE+OSKGiBgwnn2IfNkQseW0ap322
	Yjk3tKSLfeHI4XAniudqskw3bPm3O9lV6WTf1XflGPZZslQf/kM6MLK97A2waai4
	+G+aWeRFrm89owr1ixuqtERESGbA+HHah75YYzQzUNJzYF4kdAbvXZN9+sSJfsfw
	hc90Z0qMiQx95aWFCTd+WjO/sSGut7QkmiFDJxbPSw==
X-ME-Sender: <xms:X9bfZbEDqzEMwrW3s-nc36qWcGYB_PuCKI-Ybx6DTVxJmqlhwqmcSg>
    <xme:X9bfZYW0Q_icM3GjC7AkL0fS1Zh84ejPmblrnEUtB7TzhTj-Mjr8xE-oRw7BTQOWY
    46W35f4IVXf2fLLtw>
X-ME-Received: <xmr:X9bfZdKy_0DJqmwL6ZjCMqTrdDN2B796EajN0PmTrOS_YbJL4ELNfLI6yuKgaYF_wD727Dzf4Sj59TbTx9dfjff-7HymLLKL5OPku4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeekgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddt
    vdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeffkeeuudekheduffduffffgfeg
    iedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:X9bfZZE7A6Ljzwnp_HraLFH-WzsfZlay1GI9-9W8uvGSTCyA3KRr7g>
    <xmx:X9bfZRVn1MbdZ6nHd-sHUK4LHl5V1zVHU-0qYdmI2-2iYhxrCCcJzw>
    <xmx:X9bfZUNeTztqk9KLa5_ZMFgMOddiy80pTcV1j-1ENiVd32kg8vhUAQ>
    <xmx:X9bfZTK3FKpWhQKagv9AnnUZLTIh6WCTBNlfQ6xmtZYUcx4UWtO00A>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Feb 2024 19:57:02 -0500 (EST)
Date: Wed, 28 Feb 2024 17:57:01 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, jolsa@kernel.org, quentin@isovalent.com, 
	andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v4 2/2] pahole: Inject kfunc decl tags into BTF
Message-ID: <s3fcrvcbxjn47nw3nhcus4hmyx3zkxz26vz4ddm2fxoskacf4s@tfd2rx7n33vc>
References: <cover.1707071969.git.dxu@dxuuu.xyz>
 <28e81ccf28d6dd33f6db50af6526dc1770502b8d.1707071969.git.dxu@dxuuu.xyz>
 <8e0580c6-bc72-4644-a010-c73d779f385c@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e0580c6-bc72-4644-a010-c73d779f385c@oracle.com>

Hi Alan,

On Thu, Feb 08, 2024 at 10:00:15AM +0000, Alan Maguire wrote:
> On 04/02/2024 18:40, Daniel Xu wrote:

[...]

> > +
> > +		if (shdr.sh_type == SHT_SYMTAB) {
> > +			symbols_shndx = i;
> > +			symscn = scn;
> > +			symbols = data;
> > +			strtabidx = shdr.sh_link;
> > +		} else if (!strcmp(secname, BTF_IDS_SECTION)) {
> > +			idlist_shndx = i;
> > +			idlist_addr = shdr.sh_addr;
> > +			idlist = data;
> > +		}
> > +	}
> > +
> 
> Can we use the existing list of ELF functions collected via
> btf_encoder__collect_symbols() for the above? We merge info across CUs
> about ELF functions. It _seems_ like there might be a way to re-use this
> info but I might be missing something; more below..

So the above two sections are only used to acquire information on the
set8's. For collecting functions, this patch uses BTF (see
btf_encoder__collect_btf_funcs()).

> 
> 
> > +	/* Cannot resolve symbol or .BTF_ids sections. Nothing to do. */
> > +	if (symbols_shndx == -1 || idlist_shndx == -1) {
> > +		err = 0;
> > +		goto out;
> > +	}
> > +
> > +	if (!gelf_getshdr(symscn, &shdr)) {
> > +		elf_error("Failed to get ELF symbol table header");
> > +		goto out;
> > +	}
> > +	nr_syms = shdr.sh_size / shdr.sh_entsize;
> > +
> > +	err = btf_encoder__collect_btf_funcs(encoder, &btf_funcs);
> > +	if (err) {
> > +		fprintf(stderr, "%s: failed to collect BTF funcs\n", __func__);
> > +		goto out;
> > +	}
> > +
> > +	/* First collect all kfunc set ranges.
> > +	 *
> > +	 * Note we choose not to sort these ranges and accept a linear
> > +	 * search when doing lookups. Reasoning is that the number of
> > +	 * sets is ~O(100) and not worth the additional code to optimize.
> > +	 */
> > +	for (i = 0; i < nr_syms; i++) {
> > +		struct btf_kfunc_set_range range = {};
> > +		const char *name;
> > +		GElf_Sym sym;
> > +
> > +		if (!gelf_getsym(symbols, i, &sym)) {
> > +			elf_error("Failed to get ELF symbol(%d)", i);
> > +			goto out;
> > +		}
> > +
> > +		if (sym.st_shndx != idlist_shndx)
> > +			continue;
> > +
> > +		name = elf_strptr(elf, strtabidx, sym.st_name);
> > +		if (!is_sym_kfunc_set(&sym, name, idlist, idlist_addr))
> > +			continue;
> > +
> > +		range.start = sym.st_value;
> > +		range.end = sym.st_value + sym.st_size;
> 
> we could potentially record this info when we collect symbols in
> btf_encoder__collect_function(). The reason I suggest this is that it is
> likely that to fully clarify which symbol a name refers to we will end
> up needing the address.  So struct elf_function could record start and
> size, and that could be used by you later without having to parse ELF
> for symbols (you'd still need to for the BTF ids section).

This start/end pair is just for the set8's in .BTF_ids section. Which
btf_encoder__collect_function() rightfully does not look at. So I think
new code needs to be added for set8 collection anyways. I don't have any
strong feelings about whether we should hook into
btf_encoder__collect_symbols() or not -- IMHO it's a bit cleaner to have
all the set8 stuff on its own codepath.

What cases do you see needing the location + size for? Since kfuncs are
exported, I would think it's not possible for a single object file to
have multiple copies of the same kfunc. Nor that the compiler inline the
kfunc.

> 
> Then all you'd need to do is iterate over BTF functions, using
> btf_encoder__find_function() to get a function and associated ELF info
> by name.

Didn't know about this, thanks. I'll take a look at if the patch can use
the existing function metadata. That should get rid of
btf_encoder__collect_btf_funcs() if it works.

> 
> 
> > +		gobuffer__add(&btf_kfunc_ranges, &range, sizeof(range));
> > +	}
> > +
> > +	/* Now inject BTF with kfunc decl tag for detected kfuncs */
> > +	for (i = 0; i < nr_syms; i++) {
> > +		const struct btf_kfunc_set_range *ranges;
> > +		unsigned int ranges_cnt;
> > +		char *func, *name;
> > +		GElf_Sym sym;
> > +		bool found;
> > +		int err;
> > +		int j;
> > +
> > +		if (!gelf_getsym(symbols, i, &sym)) {
> > +			elf_error("Failed to get ELF symbol(%d)", i);
> > +			goto out;
> > +		}
> > +
> > +		if (sym.st_shndx != idlist_shndx)
> > +			continue;
> > +
> > +		name = elf_strptr(elf, strtabidx, sym.st_name);
> > +		func = get_func_name(name);
> > +		if (!func)
> > +			continue;
> > +
> > +		/* Check if function belongs to a kfunc set */
> > +		ranges = gobuffer__entries(&btf_kfunc_ranges);
> > +		ranges_cnt = gobuffer__nr_entries(&btf_kfunc_ranges);
> > +		found = false;
> > +		for (j = 0; j < ranges_cnt; j++) {
> > +			size_t addr = sym.st_value;
> > +
> > +			if (ranges[j].start <= addr && addr < ranges[j].end) {
> > +				found = true;
> > +				break;
> > +			}
> > +		}
> > +		if (!found) {
> > +			free(func);
> > +			continue;
> > +		}
> > +
> > +		err = btf_encoder__tag_kfunc(encoder, &btf_funcs, func);
> > +		if (err) {
> > +			fprintf(stderr, "%s: failed to tag kfunc '%s'\n", __func__, func);
> > +			free(func);
> > +			goto out;
> > +		}
> > +		free(func);
> > +	}
> > +
> > +	err = 0;
> > +out:
> > +	__gobuffer__delete(&btf_funcs);
> > +	__gobuffer__delete(&btf_kfunc_ranges);
> > +	if (elf)
> > +		elf_end(elf);
> > +	if (fd != -1)
> > +		close(fd);
> > +	return err;
> > +}
> > +
> >  int btf_encoder__encode(struct btf_encoder *encoder)
> >  {
> >  	int err;
> > @@ -1367,6 +1718,14 @@ int btf_encoder__encode(struct btf_encoder *encoder)
> >  	if (btf__type_cnt(encoder->btf) == 1)
> >  		return 0;
> >  
> > +	/* Note vmlinux may already contain btf_decl_tag's for kfuncs. So
> > +	 * take care to call this before btf_dedup().
> > +	 */
> 
> sorry another thing I should have thought of here; if the user has asked
> to skip encoding declaration tags, we should respect that for this case
> also. So you'll probably need to set
> 
> 	encoder->skip_encoding_btf_decl_tag =
> conf_load->skip_encoding_btf_decl_tag;
> 
> ..earlier on, and bail here if encoder->skip_encoding_btf_decl_tag is
> true. We'd need to be consistent in that if the user asks not to encode
> declaration tags we don't do it for this case either.

Yeah, good catch. Will do.

[...]

Thanks,
Daniel

