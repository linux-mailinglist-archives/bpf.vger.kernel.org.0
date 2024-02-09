Return-Path: <bpf+bounces-21640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED6E84FB3E
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 18:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092561F2B18F
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 17:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFECB7EF01;
	Fri,  9 Feb 2024 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c081SQv5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62777BB1E
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707500823; cv=none; b=owzP3IdQJPyoJgbT+O3ZbHfZlQLDZtMdursQsfX4Tu6ziw/TnmOoQMG5mj134XjG5F1KGOjyG8HcP2KQzJLHZXrhKTZNukoxg77mYpcBTKX1lh5W6J3NVLVCgCqQ7v8B4f0P67WDvDTb3mqIHcVMmqxqO5FiNX+4vmyjqCsY64Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707500823; c=relaxed/simple;
	bh=da1K+ABA7b7BBasBYbyRr0psOcBrp87wtaLh29XpTO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hk9stlRR3rJVCm40fY5xvapVaIZmo197loEkBkM0zQ8+dc+aEy9gZM7DrqAP4MhBqFKSNe4pgq5V5V8QlboPPmnlOMVhbof4Ra7uVRGw1H/vFbNkZ2hheUDx4G0QARbsWmP8sTOQvU9vQ/Mg7pfF/Lfx2KGdi7HaqdycJys7S5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c081SQv5; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e05b72fd56so783599b3a.2
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 09:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707500821; x=1708105621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3PrzA+anQJfRHKq9Mt7etEQWWGYWT/UrxKbrjmadqb8=;
        b=c081SQv5Djdix2Yjov4ScQ40t5W8z06SV9bu18r5gJ5qTD7kZ6P5WONSJ0L0xamUPM
         arGaT8srCWvIzs9Y1djiPI9TNtq2rZaykraW80dtxwc2WYj62w1R1wo19hiaAET9S2sT
         m3i8cNBryXhVbN8P1kw8d1We9tMidwQukdmPSKcT1kOSN69QcEqMnPWOBWXZyYpY2rnW
         pG7Pm5lo2sbGZYYzqiiLTk7ultcpdphSPnb8K/xGyKg2/4KhXO5R2owKHi7OEqkr+DuB
         rM1tIpdytCa7AmVfB/g7Z8OWgzgPn4F2V86aXO27Ka1yqpJGTElckSqI4mHnXDi3FQVM
         NWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707500821; x=1708105621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PrzA+anQJfRHKq9Mt7etEQWWGYWT/UrxKbrjmadqb8=;
        b=D01raUVDZnEZQIQcXW6+Xu1MGoxKNbn8a9luI1Hpo39uDyYCJbw97Ln/uxl7A73Sx8
         IxLOISvAmWllf5adoEcuCNuqBTInHBS1FIdnREqacct/xxXEJBZrSTy5euiq/h65VnEb
         pavjhxlE28OiebGxVrSauwxeufyCnl4Jf0ehm09BvCw6izkfXGJyoSUG+XbGRG+Ta9XH
         EGb44rTYW1K9BiPNCYJ+aTRoVn6ktn6jXN4LKmoKVrjn6WJwflz+B+I5ruZubUtYgoyG
         Ig+d2tp6T7cyll1sqiUBgbfeXQ6Sb0TpjckLggeAUBU9aSrSYnW+XWvciiraQ5afk7z6
         RkeQ==
X-Gm-Message-State: AOJu0YzIX/RBWWRGnNaPzOoRFRQHQe71TKvjB+S4PbU4o3xisLuNKtJn
	20uUpw4f23ludvec1L5GwAMeGlnALS/WPCTodk8S+h95TrVRJiMM
X-Google-Smtp-Source: AGHT+IG8INriH1ZsuS017BwwZogJVVcXIZ/KPw6gV7OMhr7fblkm5cszcsoNoH1eUXAMnTUAnIIHcQ==
X-Received: by 2002:a05:6a20:c90e:b0:19e:a26c:b02c with SMTP id gx14-20020a056a20c90e00b0019ea26cb02cmr2403794pzb.48.1707500821125;
        Fri, 09 Feb 2024 09:47:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXSVDsRzRWBW1kGhUitCYNxX4M4TyzWjMZ626N+kDy//MnqGAVMV/NO6V6s0SipX5lYWCeFWGCUnAQLyMdYMzGMQt5O/O+7WUdpSSjPjVLIIk76jfLhLwXO+M9twd+T1uJWfAsnRxEEcbsNAQnXJCZyBXqoNHwPM3G3E7DZ7tGcOCaX8JBs0Tfpcrc8Zo1F2IrZKNyfX0Uliw86ZsKUnprUctc/vGG/tfNtcGgjtrIQ40e34YiD6O9tywsTOQWleaF2iix4GxtDuyaIjJ4IFZ1XM1ru8kgbPkB8caGzrci1cP7/8Tc+YAfnXZaGQYac3w==
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:a894])
        by smtp.gmail.com with ESMTPSA id hq5-20020a056a00680500b006e051ec4f90sm804827pfb.84.2024.02.09.09.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 09:47:00 -0800 (PST)
Date: Fri, 9 Feb 2024 09:46:57 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com, tj@kernel.org, 
	brho@google.com, hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 02/16] bpf: Recognize '__map' suffix in kfunc
 arguments
Message-ID: <jxfd2zufwee3rom5zt3pger5wkytwiuy3lepw5vacvg6lwuv7g@cxnjdxb3tr2d>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-3-alexei.starovoitov@gmail.com>
 <20240209165745.GB975217@maniforge.lan>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209165745.GB975217@maniforge.lan>

On Fri, Feb 09, 2024 at 10:57:45AM -0600, David Vernet wrote:
> On Tue, Feb 06, 2024 at 02:04:27PM -0800, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> > 
> > Recognize 'void *p__map' kfunc argument as 'struct bpf_map *p__map'.
> > It allows kfunc to have 'void *' argument for maps, since bpf progs
> > will call them as:
> > struct {
> >         __uint(type, BPF_MAP_TYPE_ARENA);
> > 	...
> > } arena SEC(".maps");
> > 
> > bpf_kfunc_with_map(... &arena ...);
> > 
> > Underneath libbpf will load CONST_PTR_TO_MAP into the register via ld_imm64 insn.
> > If kfunc was defined with 'struct bpf_map *' it would pass
> > the verifier, but bpf prog would need to use '(void *)&arena'.
> > Which is not clean.
> > 
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  kernel/bpf/verifier.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index d9c2dbb3939f..db569ce89fb1 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -10741,6 +10741,11 @@ static bool is_kfunc_arg_ignore(const struct btf *btf, const struct btf_param *a
> >  	return __kfunc_param_match_suffix(btf, arg, "__ign");
> >  }
> >  
> > +static bool is_kfunc_arg_map(const struct btf *btf, const struct btf_param *arg)
> > +{
> > +	return __kfunc_param_match_suffix(btf, arg, "__map");
> > +}
> > +
> >  static bool is_kfunc_arg_alloc_obj(const struct btf *btf, const struct btf_param *arg)
> >  {
> >  	return __kfunc_param_match_suffix(btf, arg, "__alloc");
> > @@ -11064,7 +11069,7 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
> >  		return KF_ARG_PTR_TO_CONST_STR;
> >  
> >  	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
> > -		if (!btf_type_is_struct(ref_t)) {
> > +		if (!btf_type_is_struct(ref_t) && !btf_type_is_void(ref_t)) {
> >  			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
> >  				meta->func_name, argno, btf_type_str(ref_t), ref_tname);
> >  			return -EINVAL;
> > @@ -11660,6 +11665,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
> >  		if (kf_arg_type < 0)
> >  			return kf_arg_type;
> >  
> > +		if (is_kfunc_arg_map(btf, &args[i])) {
> > +			/* If argument has '__map' suffix expect 'struct bpf_map *' */
> > +			ref_id = *reg2btf_ids[CONST_PTR_TO_MAP];
> > +			ref_t = btf_type_by_id(btf_vmlinux, ref_id);
> > +			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
> > +		}
> 
> This is fine, but given that this should only apply to KF_ARG_PTR_TO_BTF_ID,
> this seems a bit cleaner, wdyt?
> 
> index ddaf09db1175..998da8b302ac 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10741,6 +10741,11 @@ static bool is_kfunc_arg_ignore(const struct btf *btf, const struct btf_param *a
>         return __kfunc_param_match_suffix(btf, arg, "__ign");
>  }
> 
> +static bool is_kfunc_arg_map(const struct btf *btf, const struct btf_param *arg)
> +{
> +       return __kfunc_param_match_suffix(btf, arg, "__map");
> +}
> +
>  static bool is_kfunc_arg_alloc_obj(const struct btf *btf, const struct btf_param *arg)
>  {
>         return __kfunc_param_match_suffix(btf, arg, "__alloc");
> @@ -10910,6 +10915,7 @@ enum kfunc_ptr_arg_type {
>         KF_ARG_PTR_TO_RB_NODE,
>         KF_ARG_PTR_TO_NULL,
>         KF_ARG_PTR_TO_CONST_STR,
> +       KF_ARG_PTR_TO_MAP,      /* pointer to a struct bpf_map */
>  };
> 
>  enum special_kfunc_type {
> @@ -11064,12 +11070,12 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>                 return KF_ARG_PTR_TO_CONST_STR;
> 
>         if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
> -               if (!btf_type_is_struct(ref_t)) {
> +               if (!btf_type_is_struct(ref_t) && !btf_type_is_void(ref_t)) {
>                         verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
>                                 meta->func_name, argno, btf_type_str(ref_t), ref_tname);
>                         return -EINVAL;
>                 }
> -               return KF_ARG_PTR_TO_BTF_ID;
> +               return is_kfunc_arg_map(meta->btf, &args[argno]) ? KF_ARG_PTR_TO_MAP : KF_ARG_PTR_TO_BTF_ID;

Makes sense, but then should I add the following on top:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e970d9fd7f32..b524dc168023 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11088,13 +11088,16 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
        if (is_kfunc_arg_const_str(meta->btf, &args[argno]))
                return KF_ARG_PTR_TO_CONST_STR;

+       if (is_kfunc_arg_map(meta->btf, &args[argno]))
+               return KF_ARG_PTR_TO_MAP;
+
        if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
-               if (!btf_type_is_struct(ref_t) && !btf_type_is_void(ref_t)) {
+               if (!btf_type_is_struct(ref_t)) {
                        verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
                                meta->func_name, argno, btf_type_str(ref_t), ref_tname);
                        return -EINVAL;
                }
-               return is_kfunc_arg_map(meta->btf, &args[argno]) ? KF_ARG_PTR_TO_MAP : KF_ARG_PTR_TO_BTF_ID;
+               return KF_ARG_PTR_TO_BTF_ID;
        }

?


