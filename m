Return-Path: <bpf+bounces-21158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCB5848FD8
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 19:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24597B224AA
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 18:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7682249F9;
	Sun,  4 Feb 2024 18:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="3WKD+aXi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bzjlJtz9"
X-Original-To: bpf@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC46249E8
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 18:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707070133; cv=none; b=dMhkaIXXplDjO5RhVUT361hHeGrBiCkVMRK3X263RqxlxADpFJFIzYiAN1zAxD1JijfwERY5GV+76aFYGCxjARkvqcRgfRJUwKrGTfk+TKOjWmczZ1ruy0dAb9hF/pM2oZ6R0dN5THFnB8CNJOKG0rxCME3/AJs+deJ70ymaG4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707070133; c=relaxed/simple;
	bh=Y7v2zLf+dZmRyl6KEaFHcCNlgI2qNyIo8/IVmlXX0Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7tlbbCGS6iA4mwE8cPJpoOlMZvC908TDtX5y6JHUVX+loYC25SdDwl8PcSRfNEqqB53p6IixamfJ1rKRIUvoAz84pCluPAfPhwQEqH2rLFlniZCLrbXw0LsjDUgLgv2HigwI/AmgPFUcpDiNkTCfl99f3pq+fKNXYZ0J8DYtKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=3WKD+aXi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bzjlJtz9; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id EDB9C3200A78;
	Sun,  4 Feb 2024 13:08:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 04 Feb 2024 13:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1707070128; x=1707156528; bh=t/zNDZWSk9
	4E2l73mHGdoLUsuhJgLik5ks5MZ4b+PNM=; b=3WKD+aXiAeeDYor07AtyZVd8ZU
	472/4ijWt08/PyMFtK4SOay3ovjL5MN8fV84bQ29O5J3NBCLC24xxcoLq3P6hf1W
	VaQoa4ngTq7zMfDlaDOUXJPszLefQrtMamgiSsRtrdB8WJP+weUAbdxueOoUq9WO
	5+RYtuAJ/oVZf0idAtW2U5usDK5igpVfzX1AlhaRet+Op9eP2vwoOHTelVmB8q0b
	Z3QIltfkl7HQxqqL84XCOHKvB24gaLayU9Mdu1KjwGvK7DDxEiGDbBz+7qGz5c0G
	SSt+auhackYG/XqTYkzKV7MXEbBPYTDWeoWMUM2/UVsjYcsKwJEN83qNxAkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707070128; x=1707156528; bh=t/zNDZWSk94E2l73mHGdoLUsuhJg
	Lik5ks5MZ4b+PNM=; b=bzjlJtz92COiyeMu72/JY8nuOwmMPjS9anYvxMgcTIm/
	SMQRD9XsZpwi4FdrwdZCNMF0Y76JuT5+UGhBV4FZRnTruOldmMky2w5FrwfWkhs6
	U5uJxbOyu5XOugCkub3zfZ+qc4xQg/z1DWiZadUJe0ypRrBXlTWGhu3v54hTFLZx
	fxkXzOz5a3gA6PG9Dy/RqP+y7FpfZnnCGtbzBbtTdWhcGxcicyjB//hhVjHqUqj+
	FtaRVml7UrJFlFlDMMFSsMURLmEiat9ILg+Cf0cqQP0j/guy8Rrk/a5lwzpYa6ww
	khOgwvODLA/2aHC+2EPhkB7o+fBXXdlA+H/i5m7RPA==
X-ME-Sender: <xms:sNK_ZdQGVY9HiK75yLzHmB2YdwpgycVe9nm0wILPJ19y4mpWiHRBPQ>
    <xme:sNK_ZWx8vNbSwp2pYUaCiUMh4diouYL3OAdpgbpNgHbhGaNmsWjzTaR6jdz4FpLxs
    AdcXTa7x6LtzeTh3A>
X-ME-Received: <xmr:sNK_ZS1a-hhbkZIKjIq7J5yn725jA_8mRVEtmRqcyBzDJ_P0eOsTbJZSrKko46LsJVCdSYMt6Fg0dGcJuIs3yXGMtBGT-K00sXr_epA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedukedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdt
    tddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeffkeeuudekheduffduffff
    gfegiedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:sNK_ZVA__Psfbd8HPPbG8Wb965o3PAnOWTDQ_pSNMpeHOi-DFMxs9w>
    <xmx:sNK_ZWiZTOXpMewxXmrERLYsJFJWLw7lgK5v4EK9ny2ddLt-716SAA>
    <xmx:sNK_ZZpdN5Azc54c1NPSmWZ7iPfnfR2H6rI28fifjRVgXE3aisDRSw>
    <xmx:sNK_ZYaP0IGSSVDkeYi_vOTvT-zXkrJMElfFyu45WTUppl6SITVFSA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Feb 2024 13:08:47 -0500 (EST)
Date: Sun, 4 Feb 2024 11:08:45 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: acme@kernel.org, quentin@isovalent.com, andrii.nakryiko@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v3] pahole: Inject kfunc decl tags into BTF
Message-ID: <ifkoiqmxww5cwm2zfsf56rxiikichw53o6gwo4hyaxqmyij4tu@hvemdh2fqfhv>
References: <0f25134ec999e368478c4ca993b3b729c2a03383.1706491733.git.dxu@dxuuu.xyz>
 <ZboeMyIvGChjaBLY@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZboeMyIvGChjaBLY@krava>

On Wed, Jan 31, 2024 at 11:17:23AM +0100, Jiri Olsa wrote:
> On Sun, Jan 28, 2024 at 06:30:19PM -0700, Daniel Xu wrote:
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
> > 
> > ---
> > Changes from v2:
> > * More reliably detect kfunc membership in set8 by tracking set addr ranges
> > * Rename some variables/functions to be more clear about kfunc vs func
> > 
> > Changes from v1:
> > * Fix resource leaks
> > * Fix callee -> caller typo
> > * Rename btf_decl_tag from kfunc -> bpf_kfunc
> > * Only grab btf_id_set funcs tagged kfunc
> > * Presort btf func list
> > 
> >  btf_encoder.c | 347 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 347 insertions(+)
> > 
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index fd04008..4f742b1 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -34,6 +34,11 @@
> >  #include <pthread.h>
> >  
> >  #define BTF_ENCODER_MAX_PROTO	512
> > +#define BTF_IDS_SECTION		".BTF_ids"
> > +#define BTF_ID_FUNC_PFX		"__BTF_ID__func__"
> > +#define BTF_ID_SET8_PFX		"__BTF_ID__set8__"
> > +#define BTF_SET8_KFUNCS		(1 << 0)
> > +#define BTF_KFUNC_TYPE_TAG	"bpf_kfunc"
> >  
> >  /* state used to do later encoding of saved functions */
> >  struct btf_encoder_state {
> > @@ -79,6 +84,7 @@ struct btf_encoder {
> >  			  gen_floats,
> >  			  is_rel;
> >  	uint32_t	  array_index_id;
> > +	struct gobuffer   btf_funcs;
> 
> why does this need to be stored in encoder?

I suppose it doesn't. It's used in multiple functions so I figured it'd
be less verbose than passing it around. Also since it's fairly generic.

I can move it to explicit arg passing if you want.

> 
> >  	struct {
> >  		struct var_info vars[MAX_PERCPU_VAR_CNT];
> >  		int		var_cnt;
> > @@ -94,6 +100,17 @@ struct btf_encoder {
> >  	} functions;
> >  };
> >  
> 
> SNIP
> 
> > +/* Returns if `sym` points to a kfunc set */
> > +static int is_sym_kfunc_set(GElf_Sym *sym, const char *name, Elf_Data *idlist, size_t idlist_addr)
> > +{
> > +	int *ptr = idlist->d_buf;
> > +	int idx, flags;
> > +	bool is_set8;
> > +
> > +	/* kfuncs are only found in BTF_SET8's */
> > +	is_set8 = !strncmp(name, BTF_ID_SET8_PFX, sizeof(BTF_ID_SET8_PFX) - 1);
> > +	if (!is_set8)
> > +		return false;
> > +
> > +	idx = sym->st_value - idlist_addr;
> > +	if (idx >= idlist->d_size) {
> > +		fprintf(stderr, "%s: symbol '%s' out of bounds\n", __func__, name);
> > +		return false;
> > +	}
> > +
> > +	/* Check the set8 flags to see if it was marked as kfunc */
> > +	idx = idx / sizeof(int);
> > +	flags = ptr[idx + 1];
> > +	return flags & BTF_SET8_KFUNCS;
> 
> I wonder it'd be easier to read/follow if we bring struct btf_id_set8
> declaration in here and use it to get the flags field

Yeah, it probably would be. Since it looks like resolve_btfids is going
that direction, might as well do it here as well.

> 
> > +}
> > +
> > +/*
> > + * Parse BTF_ID symbol and return the func name.
> > + *
> > + * Returns:
> > + *	Caller-owned string containing func name if successful.
> > + *	NULL if !func or on error.
> > + */
> > +
> 
> SNIP
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
> > +	err = btf_encoder__collect_btf_funcs(encoder);
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
> 
> I think we could event add gobuffer interface/support to sort and search
> quickly the data (we use it in other place), but that can be done as follow
> up when it will become a problem as you pointed out
> 
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
> 
> missing newline after declaration
> 
> > +			if (ranges[j].start <= addr && addr < ranges[j].end) {
> > +				found = true;
> > +				break;
> > +			}
> > +		}
> > +		if (!found)
> 
> leaking func

Ack, nice catch.

[..]

Thanks,
Daniel

