Return-Path: <bpf+bounces-66641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BD9B37E8A
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 11:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5ADA203B91
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 09:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39187341AA5;
	Wed, 27 Aug 2025 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wsf5I45Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE5F2F3C26
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286093; cv=none; b=ioRCoanBC7wekP1RwG7Fpi5LlyjwPkHgSrG3OTikTSzNI3MiFegIWu5VEtTNuG9lxd/xrkLYHaMlK5A3WaoRSsbEJqUAI2pIdfkKGwSP9NhYptkR6xjdFnE8X7uWQWgSp/cxSeNWOYiI7LvGbhIpbXmTjckoG+0uqEvWAlDc4RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286093; c=relaxed/simple;
	bh=SIlqTwhLzWz/smF0man098JnQ7w0dXMfWkDodhPt2gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1Iuzdvh87e91pkndaptZ9QZBzHYOE3cwekfyVWF9LNpGy8oyzFx3+DqPsMq3iIe708H4aoIzSH0K8sRfCibQBG09HsqoZRUYOYEb2ZJkLz7CjV3zJ9hKP7r+EPUegQTeLUEnOvnFHX2lT0ltTmbCFnCXrc3s3yIzprdDSKk6TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wsf5I45Z; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b004954so51974795e9.0
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 02:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756286090; x=1756890890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OQvfm+0aw5PXpwYaMEYsejA3RvCIG7u3OeODJdHKg84=;
        b=Wsf5I45ZOVnk6UCFCQFASRtyqOo02wur76Z93r92PRkijn6HyTZCUjAzNKu8jBWlzO
         14ErLwMEdjN1pHhdwfY4W4BN4JtdtzlodxfRTzuJuQOX0Grwj8KUw8Mr6nf4GL+tz86c
         xVKexjqxg93iG1tUgsWOEhh32/lUvHruGwkt+odrBPEo1ahu9x3NVLKUilqQcK0FM7Mf
         3eAeLl/VUufbcCmu93Oseu+tKLUvx+m5s0ap13ewq3NgsZhKEWdhwObcl0K7HGDsGFYx
         tKxXxGihNzdyAo7kiKlzW2yE+yhnqruyvt62cIaax7WriihW1NaMnPHXv7RMV7Kkh3IO
         D9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756286090; x=1756890890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQvfm+0aw5PXpwYaMEYsejA3RvCIG7u3OeODJdHKg84=;
        b=NMTceM0x1QEOtbz5sZBsyquTJGlF0VMqqS5RKRd6eENiVF1IsdShGNR04/VgQ+Tx7x
         EZ6EXSeo0RLL5sqxgp35IMU/Iz4XOsjyvYpLtjwg/HW0KyI3+PQoCFbPAcfT2VcPYuVG
         27wW+THePKaTCJHIIYZDn5KMyedNgWoyPSrg+V8V7r66RV4X+u4b3A7Ufk86Sj54ZpSC
         N4EvbAigileWvdvG3T033+Gj2DUxhhhxpA8HxiQNwDUaTAhC/6TaQL5jEVu9V6Piyvy+
         Sg2HhLNFTOWV4DfpDu5tQ63ETTfqJLZNlBj4Mj78KtDowCBM10iN21Tml91gSD+MZB2d
         axkg==
X-Gm-Message-State: AOJu0Yx1ScnKxYUq08PxETrnU/UzloGuig4v52Kzx143GuKOwl27EBRL
	YL77UWgualwzNKBi0MYdjT0Gu4dk8GSRQEU2yghmZe7CcTGsOVMEoJOj
X-Gm-Gg: ASbGncs/1Nfn5paIEEsgqKcWzM3D8aVoxA6gDIGIhMeUD0Tlo1AIJPK/GT+DcpJpZ3J
	WDQtlQf8ODrO7ketHsbDvOJRJjlAEoSVIdplmxfoVKZ8JCTTutId9KpX1rpFahAWV5iwvFgj5bY
	r+WPgCj+7oeGdnDCobZnDB0ln93PinR62b+QmQlBvQ/mC3c5ycyTwX1bro1mYHbUQA6TzFh7aGg
	HO4ql2Mvey1XMyXGnqjBereHKeuA3EgEnJjzYwuWL9G/DMbsX6861Ty4kf/T9k4wPGdIH85w/p9
	V4/DK28x/MKKnyVm1REbSY9M5tcuEfb/3DiAcPh7FTt3syU5zdRC35ChYtEmGWJWQuWTpRD3d3O
	ovnGegPw9nsJeL++k7oSmuSWM4vIAJgJGsQ==
X-Google-Smtp-Source: AGHT+IEaZyvDisOFpPOPggeWcV4H/8VATTv2S5+iohu7yinqeDRmiPKk0i8yQ+7bskJfzZgJMUZjrA==
X-Received: by 2002:a05:600c:4748:b0:45b:47e1:ef66 with SMTP id 5b1f17b1804b1-45b517dae4fmr152015595e9.37.1756286089967;
        Wed, 27 Aug 2025 02:14:49 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b73627bc4sm5448765e9.9.2025.08.27.02.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 02:14:49 -0700 (PDT)
Date: Wed, 27 Aug 2025 09:20:52 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 05/11] bpf: support instructions arrays with
 constants blinding
Message-ID: <aK7N9HPsBWs3TiWz@mail.gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
 <20250816180631.952085-6-a.s.protopopov@gmail.com>
 <a46fd2898d1ece291d66703c656c38eced1a706c.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a46fd2898d1ece291d66703c656c38eced1a706c.camel@gmail.com>

On 25/08/25 04:29PM, Eduard Zingerman wrote:
> On Sat, 2025-08-16 at 18:06 +0000, Anton Protopopov wrote:
> 
> [...]
> 
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 5d1650af899d..27e9c30ad6dc 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> 
> [...]
> 
> > @@ -1544,6 +1562,7 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
> >  	}
> >  
> >  	clone->blinded = 1;
> > +	clone->len = insn_cnt;
> 
> Is this an old bug? Does it require a separate commit and a fixes tag?

Turns out this change is actually not needed, as the
bpf_patch_insn_single() function sets the len properly.

> >  	return clone;
> >  }
> >  #endif /* CONFIG_BPF_JIT */
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index e1f7744e132b..863b7114866b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> 
> [...]
> 
> > @@ -21665,7 +21666,15 @@ static int jit_subprogs(struct bpf_verifier_env *env)
> >  		func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
> >  		if (!i)
> >  			func[i]->aux->exception_boundary = env->seen_exception;
> > +
> > +		/*
> > +		 * To properly pass the absolute subprog start to jit
> > +		 * all instruction adjustments should be accumulated
> > +		 */
> > +		instructions_added -= func[i]->len;
> >  		func[i] = bpf_int_jit_compile(func[i]);
> > +		instructions_added += func[i]->len;
> > +
> 
> Nit: This -= / += pair is a bit hackish, maybe add a separate variable
>      to compute current delta?

Sure, I've rewrote this piece.

> >  		if (!func[i]->jited) {
> >  			err = -ENOTSUPP;
> >  			goto out_free;

