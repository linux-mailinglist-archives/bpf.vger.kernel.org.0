Return-Path: <bpf+bounces-40832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D460198F1E6
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 16:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA50B22A57
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 14:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F1119F410;
	Thu,  3 Oct 2024 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejdlYh81"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED5E149E13;
	Thu,  3 Oct 2024 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967189; cv=none; b=lgF2rPVsPamazLl4ebngI4ZLgc9rXiB7B7uaEI4BS/e+MqFcMGXrMsHGFANbYBKulQvI4UhDJv1Zw5Mmx6rT/FuSz5Oqt1/QzSyWXlsBYHA0lw40IVuA3/TTfMaY06jkhaAs+3F8azW1wRvSujtHz9VR2byl/GUS9qvFcoPc224=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967189; c=relaxed/simple;
	bh=1gHfGtgJCiVXkIM3G7xyANQ7BhXSDpShLt0hLJhoSOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9vH+aUFmaA0dNJBQgeAeJKIqKhsIkXCe5PkUQO2JvO2FQqnGg/YXgDx70t/etsZ1cX84u/hkqF0k/ozd2MpwIlHo1hluP2CC1m5CtzuJCfj1AlfbZEXhu3m8JblAnUSx8SvQr08Zky2+8A7CAW3ZQd6483LSwmuWzYPv06bJQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejdlYh81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB53C4CEC5;
	Thu,  3 Oct 2024 14:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727967189;
	bh=1gHfGtgJCiVXkIM3G7xyANQ7BhXSDpShLt0hLJhoSOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ejdlYh81kzxytlb/gXPVcue1vni+zpKEuO2F4jq3zUtFc0n6uhSeqdLpNV0zAYDsh
	 NP5f5sisLpMHyOjLNGxb1JV/nSb29SHsfZFl5fQgTNaqn4dSMuivu4h+GElw1mt9wA
	 2QyKg3M6JahDMJqLe4qPCLzy6/BJnEZiP+mOtDLkjatQbgkvBABh024y4QAZyXKnQ6
	 MpLbHxWdj2FjzShvzfLkBCUgEXBiWandqEGoeC7a+5UThcMOMge9lzI+S13pVHj/6C
	 PgK9Wr/BC6o1Ch9WCzVxGyvpX6jGBYsL9A9DUw1o04z1mzMI3hZdnHY8m1Ls/Y7BPe
	 1iNHUO7bvLxqg==
Date: Thu, 3 Oct 2024 11:53:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org
Subject: Re: [PATCH dwarves v3 5/5] pahole: add global_var BTF feature
Message-ID: <Zv6v0WdEBg4dEJAP@x1>
References: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
 <20241002235253.487251-6-stephen.s.brennan@oracle.com>
 <22da229b-86d0-4a0c-b5d6-4883b64669f2@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22da229b-86d0-4a0c-b5d6-4883b64669f2@oracle.com>

On Thu, Oct 03, 2024 at 03:40:35PM +0100, Alan Maguire wrote:
> On 03/10/2024 00:52, Stephen Brennan wrote:
> > So far, pahole has only encoded type information for percpu variables.
> > However, there are several reasons why type information for all global
> > variables would be useful in the kernel:

> > 1. Runtime kernel debuggers like drgn could use the BTF to introspect
> > kernel data structures without needing to install heavyweight DWARF.

> > 2. BPF programs using the "__ksym" annotation could declare the
> > variables using the correct type, rather than "void".

> > It makes sense to introduce a feature for this in pahole so that these
> > capabilities can be explored in the kernel. The feature is non-default:
> > when using "--btf-features=default", it is disabled. It must be
> > explicitly requested, e.g. with "--btf-features=+global_var".
 
> I'm not totally sure switching global_var to a non-default feature is
> the right answer here.
 
> The --btf_features "default" set of options are meant to closely mirror
> the upstream kernel options we enable when doing BTF encoding. However,
> in scripts/Makefile.btf we don't use "default"; we explicitly call out
> the set of features we want. We can't just use "default" in that context
> since the meaning of "default" varies based upon whatever version of
> pahole you have.
 
> So "default" is simply a convenient shorthand for pahole testing which
> corresponds to "give me the set of features that upstream kernels use".
> It could have a better name that reflects that more clearly I suppose.
 
> When we do switch this on in-kernel, we'll add the explicit "global_var"
> to the list of features in scripts/Makefile.btf.
 
> So with all this said, do we make global_vars a default or non-default
> feature? It would seem to make sense to specify non-default, since it is
> not switched on for the kernel yet, but looking ahead, what if the 1.28
> pahole release is used to build vmlinux BTF and we add global_var to the
> list of features? In such a case, our "default" set of values would be
> out of step with the kernel. So it's not a huge deal, but I would
> consider keeping this a default feature to facilitate testing; this
> won't change what the kernel does, but it makes testing with full
> variable generation easier (I can just do "--btf_features=default").

This "default" really is confusing, as you spelled out above :-\ When to
add something to it so that it reflects what the kernel has is tricky,
perhaps we should instead have a ~/.config/pahole file where developers
can add BTF features to add to --btf_features=default in the period
where something new was _really_ added to the kernel and before the next
version when it _have been added to the kernel set of BTF features_ thus
should be set into stone in the pahole sources?

So I think we should do as Stephen did, keep it out of
--btf_features=default, as it is not yet in the kernel set of options,
and have the config file, starting with being able to set those
features, i.e. we would have:

$ cat ~/.config/pahole
[btf_encoder]
	btf_features=+global_var

wdyt?

- Arnaldo
 
> And on that subject, I tested with this series, and all looks good.
> vmlinux BTF grew by 1.5Mb to 6.7Mb for me on a bpf-next kernel.
> Following datasecs were seen:
> 
> [156581] DATASEC '.rodata' size=7379360 vlen=5472
> [156582] DATASEC '__init_rodata' size=496 vlen=3
> [156583] DATASEC '__param' size=15160 vlen=375
> [156584] DATASEC '__modver' size=864 vlen=12
> [156585] DATASEC '.data' size=5955041 vlen=15839
> [156586] DATASEC '.vvar' size=656 vlen=2
> [156587] DATASEC '.data..percpu' size=229632 vlen=389
> [156588] DATASEC '.init.data' size=2057888 vlen=5565
> [156589] DATASEC '.x86_cpu_dev.init' size=40 vlen=5
> [156590] DATASEC '.apicdrivers' size=56 vlen=7
> [156591] DATASEC '.data_nosave' size=4 vlen=1
> [156592] DATASEC '.bss' size=3788800 vlen=4080
> [156593] DATASEC '.brk' size=196608 vlen=2
> [156594] DATASEC '.init.scratch' size=4194304 vlen=1
> 
> Biggest contributors in terms of BTF size appear to be
> 
> - .data (15839 vars)
> - .init.data (5565 vars)
> - .rodata (5472 vars)
> - .bss (4080 vars)
> 
> > Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> 
> > ---
> >  btf_encoder.c      | 5 +++++
> >  btf_encoder.h      | 1 +
> >  dwarves.h          | 1 +
> >  man-pages/pahole.1 | 7 +++++--
> >  pahole.c           | 3 ++-
> >  5 files changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 2fd1648..2730ea8 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -2348,6 +2348,8 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
> >  		encoder->encode_vars = 0;
> >  		if (!conf_load->skip_encoding_btf_vars)
> >  			encoder->encode_vars |= BTF_VAR_PERCPU;
> > +		if (conf_load->encode_btf_global_vars)
> > +			encoder->encode_vars |= BTF_VAR_GLOBAL;
> >  
> >  		GElf_Ehdr ehdr;
> >  
> > @@ -2400,6 +2402,9 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
> >  			encoder->secinfo[shndx].name = secname;
> >  			encoder->secinfo[shndx].type = shdr.sh_type;
> >  
> > +			if (encoder->encode_vars & BTF_VAR_GLOBAL)
> > +				encoder->secinfo[shndx].include = true;
> > +
> >  			if (strcmp(secname, PERCPU_SECTION) == 0) {
> >  				found_percpu = true;
> >  				if (encoder->encode_vars & BTF_VAR_PERCPU)
> > diff --git a/btf_encoder.h b/btf_encoder.h
> > index 91e7947..824963b 100644
> > --- a/btf_encoder.h
> > +++ b/btf_encoder.h
> > @@ -20,6 +20,7 @@ struct list_head;
> >  enum btf_var_option {
> >  	BTF_VAR_NONE = 0,
> >  	BTF_VAR_PERCPU = 1,
> > +	BTF_VAR_GLOBAL = 2,
> >  };
> >  
> >  struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool verbose, struct conf_load *conf_load);
> > diff --git a/dwarves.h b/dwarves.h
> > index 0fede91..fef881f 100644
> > --- a/dwarves.h
> > +++ b/dwarves.h
> > @@ -92,6 +92,7 @@ struct conf_load {
> >  	bool			btf_gen_optimized;
> >  	bool			skip_encoding_btf_inconsistent_proto;
> >  	bool			skip_encoding_btf_vars;
> > +	bool			encode_btf_global_vars;
> >  	bool			btf_gen_floats;
> >  	bool			btf_encode_force;
> >  	bool			reproducible_build;
> > diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> > index b3e6632..7c1a69a 100644
> > --- a/man-pages/pahole.1
> > +++ b/man-pages/pahole.1
> > @@ -238,7 +238,9 @@ the debugging information.
> >  
> >  .TP
> >  .B \-\-skip_encoding_btf_vars
> > -Do not encode VARs in BTF.
> > +By default, VARs are encoded only for percpu variables. When specified, this
> > +option prevents encoding any VARs. Note that this option can be overridden
> > +by the feature "global_var".
> >  
> >  .TP
> >  .B \-\-skip_encoding_btf_decl_tag
> > @@ -304,7 +306,7 @@ Encode BTF using the specified feature list, or specify 'default' for all standa
> >  	encode_force       Ignore invalid symbols when encoding BTF; for example
> >  	                   if a symbol has an invalid name, it will be ignored
> >  	                   and BTF encoding will continue.
> > -	var                Encode variables using BTF_KIND_VAR in BTF.
> > +	var                Encode percpu variables using BTF_KIND_VAR in BTF.
> >  	float              Encode floating-point types in BTF.
> >  	decl_tag           Encode declaration tags using BTF_KIND_DECL_TAG.
> >  	type_tag           Encode type tags using BTF_KIND_TYPE_TAG.
> > @@ -329,6 +331,7 @@ Supported non-standard features (not enabled for 'default')
> >  	                   the associated base BTF to support later relocation
> >  	                   of split BTF with a possibly changed base, storing
> >  	                   it in a .BTF.base ELF section.
> > +	global_var         Encode all global variables using BTF_KIND_VAR in BTF.
> >  .fi
> >  
> >  So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.
> > diff --git a/pahole.c b/pahole.c
> > index b21a7f2..9f0dc59 100644
> > --- a/pahole.c
> > +++ b/pahole.c
> > @@ -1301,6 +1301,7 @@ struct btf_feature {
> >  	BTF_DEFAULT_FEATURE(decl_tag_kfuncs, btf_decl_tag_kfuncs, false),
> >  	BTF_NON_DEFAULT_FEATURE(reproducible_build, reproducible_build, false),
> >  	BTF_NON_DEFAULT_FEATURE(distilled_base, btf_gen_distilled_base, false),
> > +	BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
> 
> see above, I'd suggest making this a BTF_DEFAULT_FEATURE() to make
> testing easier.
> 
> >  };
> >  
> >  #define BTF_MAX_FEATURE_STR	1024
> > @@ -1733,7 +1734,7 @@ static const struct argp_option pahole__options[] = {
> >  	{
> >  		.name = "skip_encoding_btf_vars",
> >  		.key  = ARGP_skip_encoding_btf_vars,
> > -		.doc  = "Do not encode VARs in BTF."
> > +		.doc  = "Do not encode any VARs in BTF [if this is not specified, only percpu variables are encoded. To encode global variables too, use --encode_btf_global_vars]."
> >  	},
> >  	{
> >  		.name = "btf_encode_force",

