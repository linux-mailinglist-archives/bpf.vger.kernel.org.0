Return-Path: <bpf+bounces-40831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EFD98F1B5
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 16:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169131F226ED
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 14:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7111F1A073A;
	Thu,  3 Oct 2024 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RW2ZIt3h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DED19F412;
	Thu,  3 Oct 2024 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727966493; cv=none; b=JNuSg8Mr/rkxUd+a2epVpJZzqTIumWprmL3UslQXsY5sUNVxA2ZKBgKRPplSl/e4x4bJLQn269bHvG1WmgMF6b6WWmJm9TDkinb29Gp2rg4oRnBDr4WaWQ+amEpDz6J+AuT5Ve6w0UFwLXwOU9RvXUhUQjDimwerw/Ey6wj+W7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727966493; c=relaxed/simple;
	bh=9+7mIx4jqqogUVxVLX88lhVuz/rGTMeANzoEjlxYwzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I37oFIDd1+oOpDonOqt375iJZGkmwHr7IIgc5JhFEs0lLG5i5jLa2wbrTd3rME899iDKVB0FehVFjmRkyh1I554828tBzd20/UmLyBMZICTBg6SW20odywB/UYCnFq1799KUlNV8lP8NAXHFnL5JCju9wPh0Tc1qBN8ToE4/ucs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RW2ZIt3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08082C4CEC7;
	Thu,  3 Oct 2024 14:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727966492;
	bh=9+7mIx4jqqogUVxVLX88lhVuz/rGTMeANzoEjlxYwzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RW2ZIt3hwjQoOlbtMdGq7lTqEFjMkE8FA+7xmqAqfKMulLe+p6Y0Qn+QFKUZKyy57
	 x2c2WpR+gkGsJQyh5tllP9G5vyVY1NeXdge/Jn3lDud3dCA53wz0Cj0CpPcrzkE3Yr
	 ikb7sDzC5j6rTVRcyv1dEG4Ln+BWxDZMxSzEr36hRDVx3BL/LOaW83XINZvBAaMKla
	 pbozfNnajiLNahamkuhucS4MjxBGdCbc4aswrQZChbPUmHmDt2Tahn53cdvphFCXz6
	 Xys49EhEW9DUJktCE6LsivQ50Mx+7wLwk21B6bKrcQBo5i/mlUmdqeJFnFh42H3ftM
	 OrDGCWw/HmTgQ==
Date: Thu, 3 Oct 2024 11:41:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org
Subject: Re: [PATCH dwarves v3 1/5] btf_encoder: use bitfield to control var
 encoding
Message-ID: <Zv6tGQr_UKPPoshR@x1>
References: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
 <20241002235253.487251-2-stephen.s.brennan@oracle.com>
 <d25392a8-fa5c-4188-8e8b-fc822d9862f2@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d25392a8-fa5c-4188-8e8b-fc822d9862f2@oracle.com>

On Thu, Oct 03, 2024 at 02:41:17PM +0100, Alan Maguire wrote:
> On 03/10/2024 00:52, Stephen Brennan wrote:
> > We will need more granularity in the future, in order to add support for
> > encoding global variables as well. So replace the skip_encoding_vars
> > boolean with a flag variable named "encode_vars". There is currently
> > only one bit specified, and it is set when percpu variables should be
> > emitted.
> > 
> > Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Thanks, applying this first one.

- Arnaldo
 
> > ---
> >  btf_encoder.c | 10 ++++++----
> >  btf_encoder.h |  6 ++++++
> >  2 files changed, 12 insertions(+), 4 deletions(-)
> > 
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 51cd7bf..652a945 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -119,7 +119,6 @@ struct btf_encoder {
> >  	uint32_t	  type_id_off;
> >  	bool		  has_index_type,
> >  			  need_index_type,
> > -			  skip_encoding_vars,
> >  			  raw_output,
> >  			  verbose,
> >  			  force,
> > @@ -137,6 +136,7 @@ struct btf_encoder {
> >  		int		allocated;
> >  		uint32_t	shndx;
> >  	} percpu;
> > +	int                encode_vars;
> >  	struct {
> >  		struct elf_function *entries;
> >  		int		    allocated;
> > @@ -2369,7 +2369,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
> >  
> >  		encoder->force		 = conf_load->btf_encode_force;
> >  		encoder->gen_floats	 = conf_load->btf_gen_floats;
> > -		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
> >  		encoder->skip_encoding_decl_tag	 = conf_load->skip_encoding_btf_decl_tag;
> >  		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
> >  		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
> > @@ -2377,6 +2376,9 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
> >  		encoder->has_index_type  = false;
> >  		encoder->need_index_type = false;
> >  		encoder->array_index_id  = 0;
> > +		encoder->encode_vars = 0;
> > +		if (!conf_load->skip_encoding_btf_vars)
> > +			encoder->encode_vars |= BTF_VAR_PERCPU;
> >  
> >  		GElf_Ehdr ehdr;
> >  
> > @@ -2436,7 +2438,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
> >  		if (!encoder->percpu.shndx && encoder->verbose)
> >  			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
> >  
> > -		if (btf_encoder__collect_symbols(encoder, !encoder->skip_encoding_vars))
> > +		if (btf_encoder__collect_symbols(encoder, encoder->encode_vars & BTF_VAR_PERCPU))
> >  			goto out_delete;
> >  
> >  		if (encoder->verbose)
> > @@ -2633,7 +2635,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
> >  			goto out;
> >  	}
> >  
> > -	if (!encoder->skip_encoding_vars)
> > +	if (encoder->encode_vars)
> >  		err = btf_encoder__encode_cu_variables(encoder);
> >  
> >  	if (!err)
> > diff --git a/btf_encoder.h b/btf_encoder.h
> > index f54c95a..91e7947 100644
> > --- a/btf_encoder.h
> > +++ b/btf_encoder.h
> > @@ -16,6 +16,12 @@ struct btf;
> >  struct cu;
> >  struct list_head;
> >  
> > +/* Bit flags specifying which kinds of variables are emitted */
> > +enum btf_var_option {
> > +	BTF_VAR_NONE = 0,
> > +	BTF_VAR_PERCPU = 1,
> > +};
> > +
> >  struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool verbose, struct conf_load *conf_load);
> >  void btf_encoder__delete(struct btf_encoder *encoder);
> >  

