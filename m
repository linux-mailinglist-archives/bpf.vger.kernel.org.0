Return-Path: <bpf+bounces-56033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57855A8B6D2
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 12:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071823BA1E2
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 10:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971742327A1;
	Wed, 16 Apr 2025 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Da2JERO3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831FB221549;
	Wed, 16 Apr 2025 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744799598; cv=none; b=Nh5r1Btx3zBUzxWRfA6OReHqazp+WbkWPUSLQnZHfzNGjTlAbeaNzD8pzMZDyT7u75zI8Nlh2FgJXe0UgTeEluOhjMga+BI9ylwbPd32iwbIkZAXUfrze8+zlaBSeLZiBzZVJmihIF59UITf4YjiqDEybLSB6b6mYyBYQMTM1Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744799598; c=relaxed/simple;
	bh=JzYUMkBuCes1Dw/7ZiXiwcmaGeSyNdDzr7GNHEveqL0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRLjFwoghcoHcO2KJP074MrfCkXO173V7RH43OcP5IHhX1C3oVIdhLyEd6zU0AeBLSxvlaKMKViQ7sblUSd09ocwi8/b7fnIO43YV3m4TGNe2NlAGsdnFGYhmZum3UpnNemEAWQrt9/z6YkQZzpzRI2m7BurxkXEgcSJZ9uSwZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Da2JERO3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22c33ac23edso5485295ad.0;
        Wed, 16 Apr 2025 03:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744799596; x=1745404396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H3VNWkLuqpNZQi8O9NIwCqmZy36u8O1N/mhwm+SrP2s=;
        b=Da2JERO31uM/57pac/tncHUg9BtjJWRrARJ503IwK2oY4BtYm7n3TDgriH7aq4tEcp
         Q74RTqNlLsuvSEsz+oQ1SLD/3jyEVP0ySSGAhuHIgD4CNiH19MXBWfIQK50/o/Gp58Pn
         GLX5I9lq+q8pi1PvwAygLSGUkwFnptYIFF1FVGhoyI5MVx2DwicHS44n+lchcxS3CHcD
         efkBoM2dNrYxUC4xrCUaLiW8NX+YKFrLx8f4cu7AWB9Zev4K6pJt5bxrekRHt3uSstiU
         9z+fxVntdHW0uZmW0wCcke/gvHN38eEP8UQCx9bK61f5Q8ZJqzUwROyi+IjAK0jFiD2/
         L6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744799596; x=1745404396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3VNWkLuqpNZQi8O9NIwCqmZy36u8O1N/mhwm+SrP2s=;
        b=hu0ke6v+HsRYWp2zWRMi5cF9U6KB58q8pzhTHqLF/tAHxkl+ucMy0y+pRtMTQn8P64
         YJdlwNf/YH2xgvRSo0sRibGD0A2j0BD4VlHr0dyhQ9nwIIhQfUEBouau/2ffK4yksfm7
         XX4dLiEe64IZKxAN3yTj9H91UbPdOji/dOH/UF0UeoK/JLsgBf9tgof3Sh7wmaQeCH/t
         2vGtI0bgE4AcfGBfo8Or7JwKGitw30VJT/U9K6JAWijPHcx+cq16mfxrHCps3I44y38J
         76jrjeSEJPk/wWpMQ3mGd7mypDbThjgNvGJT7uG0hcRZ51KOw6Huk4rBnVEhv4quKVXA
         lqgA==
X-Forwarded-Encrypted: i=1; AJvYcCUbOFdoaU3Vc4i4RENSsNJH2QfNclZHnaPAhe2H+3X7RdQiALng/Fc7wrMtH0aHJbmT4BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCex6I5mX9KHzxeO9VbAvPhrYze2s+zP6Rc1sZZcxOXpVOcoUM
	V0cPvmwtRJiE1KnHeiCPf6h3nvFd+ljCVRq9Jw7IGnl1q6wYikPd
X-Gm-Gg: ASbGncuy94XcfPCxcSNGX61Xo+5vd7GC1j1tf+IqAxVpZlSsH0BFiubMLbgTO8SO4Vv
	E9YlOoUbyVVpWJ+GXd5EQg+m7W5Ur7DzvZmSiw0QaTJUj6609VFWZY5XTvj7uKqdzlecOXebjps
	nZp4Yb6bDEGzIeKyBShllWwOBEWKnVNrNRx6VqH3o28uJ5ffoyPBqS1SL+hoi050w1jZfz7enX9
	IuNAPANtDvUpZ0Tb7bUtHeOJIbrI3EAwmzILslmpaC4oTine5suqp7ekVbq49K2gPxWz1Kgkzx2
	GvWVBOkFJXNybdHQyxpQgZ6j0eNI7Rw9Ri/M4raloHsOkri4mTqXFLj0XQde2g/ZS1uhcp/KKqz
	zBUzfsVU=
X-Google-Smtp-Source: AGHT+IGxd0uduOpWaghN84/5O70fkOe1L9JQeaHvV7YXMLmIQuGCnT3QGkqLXmtBDFh8WX3/Tq8Zng==
X-Received: by 2002:a17:902:d2c7:b0:224:23ab:b88b with SMTP id d9443c01a7336-22c358c526cmr19518175ad.8.1744799595485;
        Wed, 16 Apr 2025 03:33:15 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd22f0fc5sm10350115b3a.91.2025.04.16.03.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 03:33:14 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Wed, 16 Apr 2025 03:33:11 -0700
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH dwarves v1] dwarf_loader: Fix skipped encoding of
 function BTF on 32-bit systems
Message-ID: <Z/+HZ3w2KmbK5OAi@kodidev-ubuntu>
References: <20250410083359.198724-1-tony.ambardar@gmail.com>
 <07d92da1-36f3-44d2-a0a4-cf7dabf278c6@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07d92da1-36f3-44d2-a0a4-cf7dabf278c6@oracle.com>

On Thu, Apr 10, 2025 at 01:20:45PM +0100, Alan Maguire wrote:
> On 10/04/2025 09:33, Tony Ambardar wrote:
> > While doing JIT development on armhf BTF kernels, I hit a strange issue
> > where some functions were missing in BTF data. This required considerable
> > debugging but can be reproduced simply:
> > 
> > $ bpftool --version
> > bpftool v7.6.0
> > using libbpf v1.6
> > features: llvm, skeletons
> > 
> > $ pahole --version
> > v1.29
> > 
> > $ pahole -J -j --btf_features=decl_tag,consistent_func,decl_tag_kfuncs .tmp_vmlinux_armhf
> > btf_encoder__tag_kfunc: failed to find kfunc 'scx_bpf_select_cpu_dfl' in BTF
> > btf_encoder__tag_kfuncs: failed to tag kfunc 'scx_bpf_select_cpu_dfl'
> > 
> > $ pfunct -Fbtf -E -f scx_bpf_select_cpu_dfl .tmp_vmlinux_armhf
> > <nothing>
> > 
> > $ pfunct -Fdwarf -E -f scx_bpf_select_cpu_dfl .tmp_vmlinux_armhf
> > s32 scx_bpf_select_cpu_dfl(struct task_struct * p, s32 prev_cpu, u64 wake_flags, bool * is_idle);
> > 
> > $ pahole -J -j --btf_features=decl_tag,decl_tag_kfuncs .tmp_vmlinux_armhf
> > 
> > $ pfunct -Fbtf -E -f scx_bpf_select_cpu_dfl .tmp_vmlinux_armhf
> > bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct * p, s32 prev_cpu, u64 wake_flags, bool * is_idle);
> > 
> > The key things to note are the pahole 'consistent_func' feature and the u64
> > 'wake_flags' parameter vs. arm 32-bit registers. These point to existing
> > code handling arguments larger than register-size, but only structs.
> > 
> > Generalize the code for any type of argument exceeding register size (i.e.
> > cu->addr_size). This should work for integral or aggregate types, and also
> > avoids a bug in the current code where a register-sized struct could be
> > mistaken for larger.
> > 
> > Fixes: a53c58158b76 ("dwarf_loader: Mark functions that do not use expected registers for params")
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> 
> Thanks for investigating this! I've tested this versus baseline on
> x86_64 and aarch64. I'm seeing some small divergence in functions
> encoded; for example on aarch64 we don't get a representation for
> 
> static int __io_run_local_work(struct io_ring_ctx *ctx, io_tw_token_t
> tw, int min_events, int max_events);
> 
> The reason for that is the second argument is a typedef io_tw_token_t,
> which is in turn a typedef for:
> 
> struct io_tw_state {
> };
> 
> i.e. an empty struct.
> 
> The reason is with your patch we've moved from type-centric to
> size-centric criteria used to allow functions into BTF that have
> unexpected register usage; because the above function uses unexpected
> registers _and_ does not exceed the address size, the function is marked
> as having an inconsistent reg mapping. In this case, that seems
> reasonable since it is true; there is no register needed to represent
> the second argument.
> 
> The deeper rationale here in allowing functions that have structs that
> may be represented by multiple registers is that we can handle this
> outcome; the BPF_PROG2() macro was added to handle such cases and seems
> to handle multi-register representation but _not_ representations where
> a register is not needed at all. I'm basing that on the
> ___bpf_union_arg() macro in bpf_tracing.h so please correct me if I'm
> wrong (we could potentially add a sizeof(t) == 0 clause here perhaps).
> 
> So in other words, though we see small divergences in representation I
> _think_ they are consistent with our expectations.
> 
> I'd really like to see wider testing of this patch before it lands
> however so we can shake out other problematic cases if any. If folks
> could try this and compare BTF representations to baseline that would be
> great! In particular comparing raw BTF is necessary since vmlinux.h
> representations don't include functions (aside from kfuncs). Now that we
> have always-reproducible BTF a simple diff of "bpftool btf dump file
> vmlinux" can be used to make such comparisons.
> 
> However perhaps we could also think about enhancing the bpf_tracing.h
> macro to handle zero-sized parameters like empty structs such that later
> parameters are mapped to registers correctly (presuming that's
> possible)? Yonghong, what do you think?

Hi Alan,

Thanks so much for the additional context. I pressed pause to consider
this while waiting for further testing news or feedback, but haven't seen
anything since. Have you heard anything OOB?

I also understood dwarves could have CI working now, so wondering how
those tests with the patch might have gone. In fact, it would be great to
have a regular arm32 CI running if that's possible. Could you share how
the CI changes are being managed? I've recently been trying to update
the arm32 JIT and test_progs in tandem, with the goal of having a working
32-bit target for kernel-patches/bpf CI, but some baby-steps with dwarves
or libbpf could be very helpful.

As far as type-based vs size-based criteria, I'm not wedded to either, and
did look at the type-based route as currently exists. I needed to add
cases for DW_TAG_base_type (for ints), DW_TAG_volatile_type (recursive),
DW_TAG_union_type (same issues as structs), and then we still need size
tests anyway. Sticking with size-based (and a zero-test as you suggested)
seemed the simplest and preserved the functions you noticed missing.

Cheers,
Tony

> 
> Thanks!
> 
> Alan
> 
> > ---
> >  dwarf_loader.c | 37 ++++++++++++-------------------------
> >  1 file changed, 12 insertions(+), 25 deletions(-)
> > 
> > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > index e1ba7bc..22abfdb 100644
> > --- a/dwarf_loader.c
> > +++ b/dwarf_loader.c
> > @@ -2914,23 +2914,9 @@ out:
> >  	return 0;
> >  }
> >  
> > -static bool param__is_struct(struct cu *cu, struct tag *tag)
> > +static bool param__is_wide(struct cu *cu, struct tag *tag)
> >  {
> > -	struct tag *type = cu__type(cu, tag->type);
> > -
> > -	if (!type)
> > -		return false;
> > -
> > -	switch (type->tag) {
> > -	case DW_TAG_structure_type:
> > -		return true;
> > -	case DW_TAG_const_type:
> > -	case DW_TAG_typedef:
> > -		/* handle "typedef struct", const parameter */
> > -		return param__is_struct(cu, type);
> > -	default:
> > -		return false;
> > -	}
> > +	return tag__size(tag, cu) > cu->addr_size;
> >  }
> >  
> >  static int cu__resolve_func_ret_types_optimized(struct cu *cu)
> > @@ -2942,9 +2928,9 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
> >  		struct tag *tag = pt->entries[i];
> >  		struct parameter *pos;
> >  		struct function *fn = tag__function(tag);
> > -		bool has_unexpected_reg = false, has_struct_param = false;
> > +		bool has_unexpected_reg = false, has_wide_param = false;
> >  
> > -		/* mark function as optimized if parameter is, or
> > +		/* Mark function as optimized if parameter is, or
> >  		 * if parameter does not have a location; at this
> >  		 * point location presence has been marked in
> >  		 * abstract origins for cases where a parameter
> > @@ -2953,10 +2939,11 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
> >  		 *
> >  		 * Also mark functions which, due to optimization,
> >  		 * use an unexpected register for a parameter.
> > -		 * Exception is functions which have a struct
> > -		 * as a parameter, as multiple registers may
> > -		 * be used to represent it, throwing off register
> > -		 * to parameter mapping.
> > +		 * Exception is functions which have a wide
> > +		 * parameter, as multiple registers may be used
> > +		 * to represent it, throwing off register to
> > +		 * parameter mapping. Examples could include
> > +		 * structs or 64-bit types on a 32-bit arch.
> >  		 */
> >  		ftype__for_each_parameter(&fn->proto, pos) {
> >  			if (pos->optimized || !pos->has_loc)
> > @@ -2967,11 +2954,11 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
> >  		}
> >  		if (has_unexpected_reg) {
> >  			ftype__for_each_parameter(&fn->proto, pos) {
> > -				has_struct_param = param__is_struct(cu, &pos->tag);
> > -				if (has_struct_param)
> > +				has_wide_param = param__is_wide(cu, &pos->tag);
> > +				if (has_wide_param)
> >  					break;
> >  			}
> > -			if (!has_struct_param)
> > +			if (!has_wide_param)
> >  				fn->proto.unexpected_reg = 1;
> >  		}
> >  
> 

