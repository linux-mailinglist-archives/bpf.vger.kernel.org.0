Return-Path: <bpf+bounces-62436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4DEAF9B16
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 21:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB573A3510
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 19:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BC51D90DF;
	Fri,  4 Jul 2025 19:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7JR74Ek"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A880C2E36F8
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751656585; cv=none; b=sUngV2in1hOO5bOaEZzgvl1sV/Yetxh1Do2Ld8jFvWQHQIykJQwf9psGMEaqelfioU+uoEZTkqEoa4vxvG/KETrfrrGI8QZKfh5/DgHPVFClXCJ1amkeWIvrAgX8TdO/7EZHtQy9p4k7Oz/aLM91MO2vbTfg7IoLkSW6bwHnRP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751656585; c=relaxed/simple;
	bh=SwQp2pWMOq/coF8eI+So7XhQVrkrIA2TK9nv5rq/HTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPmU/PkF0nnjXs05EP/ot3YPytUQL6wsdNQjr0BgPk+Y4FXimMJA9zqz/Nre2lEuLMINagEBhdoa78IHyU82N44AtmN4TzzixuxDwntD1caQzKuqSKUzu4IBwQnzzEj4JKMbCHCTtC13IPiWwUCGfOBROVxzG1RRZCQjXNGe0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7JR74Ek; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-60c3aafae23so5134001a12.1
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 12:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751656582; x=1752261382; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qR1RRKm34BVBvGVKloc6c5+oxu8ACtA9thh2zmKFVfE=;
        b=F7JR74Ek7sFYg/Zn74W/MfJelbRO60j7RYNSDPMzpRazfrvKdyy7HouXI7LePuFXnY
         uOxgE4RbqDp/ekJvzO+IO4q/qVYFGVtkqYoyQWLZRlSWU5AR67DYnBwcYiRrh1px2aKn
         oHITrKYEExd1e+oKpR0pXyjxT1AObIE2ywvuuBuvlWyYvgcJXfMwsgAgJjiQ3G0CbGse
         LFpYBmtm5WrgUpFWnxvfthDLuieuSVqrjd0jt7BXVAWZu1+ruMx4SPmg3WT8OLncKdbf
         ocJZkUOO2YJlhh8szh5G1mB12+GekBGoZt3qQMNi2WbjebTg4iiLMx4dfaGfMju0Fj+W
         UAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751656582; x=1752261382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qR1RRKm34BVBvGVKloc6c5+oxu8ACtA9thh2zmKFVfE=;
        b=Ja06Ko2YfsbNedrUxHN62gT73W63ax5+JGZyfzpuRY4OuVqXDyyUVHkqevvmkVv97P
         XGngGEj86yGBe5+vjq9O4tgqWbvgpArY9O1zRIG1zw+gbUvXxjla9EwFU5XgMnzSIeUJ
         UASwg3XEnDZSI1UTsAjDOMqhKw+lL/edWRt0+J11arSYeQOB6XlBceSVoORIXOI7AtNA
         nLrjQdZLIac7npUhGhTAznckyUAdWHtt45ba+Hch45fpgG0kL9RYtZn0hqMFMVDHS8Gt
         /5sfwHOSvLql8DC4OO45vvyD7XduFgjajC3fKWRYxEh+/dK0UkLilXMF37nCUNc3p3AK
         bdyA==
X-Forwarded-Encrypted: i=1; AJvYcCXMSB2sm97w33RKmyIXSYw5ev7DtL3TIMnrQZJ2eg5VLaO9Wou2m8On3Utv9XbJQgY4/J0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjGSChBtrAqaE9lA+bbTJt3itBNbpcJyhYJXPvGW7nKqgIDueG
	Wu23lNHC4fadMQ9srP3h/aJPRLqLl7M9OKS35FUWOoL79x+3EjOec2jbcZd6yjcxd4g09yKFw3A
	VXQdJ8klYYZpaiWdxM4tSbHhx4y1zTc7sZqZ1A+0=
X-Gm-Gg: ASbGncvUivjuZ5p5Pu2fIyeYSWDamRigCWWkLSqPWQl+0bMwZulmdrDZnDb6AObrHrM
	I0ZbZUAxizlYp73MTkvetcqm3z1RSqOz1MmGHI2OLsN9lXw1I5SnQJotv+dKel0xtdOjn6B16NJ
	XdlyFyqog+1hFej1sgw3fAySHTz3jCFOY3TheJc+PhVnAUTQzQ5WEDST9vGn+6eCIvgeHfF1fWu
	CA=
X-Google-Smtp-Source: AGHT+IGowc+TLisxP8IubKZ3p2Wc+XHeCxeNvN3hlEnVMWbvi++ncg+V8gMVB3KMmiHCsLTtG2p0YqWEO16g7zW26JA=
X-Received: by 2002:a17:907:9487:b0:acb:37ae:619c with SMTP id
 a640c23a62f3a-ae3f9ccc41bmr441157766b.15.1751656581790; Fri, 04 Jul 2025
 12:16:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702224209.3300396-1-eddyz87@gmail.com> <20250702224209.3300396-5-eddyz87@gmail.com>
 <CAP01T74AYNX5ARJ5YXryUyKvn5o0Dv0JBoq3CCKcD8rh==uKQA@mail.gmail.com>
 <fb5b8613584dbce72359e44ef3974e4cb7c8298e.camel@gmail.com>
 <de7f3a2c5bc521c1111b0ed1870291c0889e4757.camel@gmail.com>
 <CAP01T75+cXUv4Je+bYQNb-Us_MF1s1Zc9fL0wmowLExKUQ8KNg@mail.gmail.com> <a8f522a0e9eaf060727b7782d700f998efaa757c.camel@gmail.com>
In-Reply-To: <a8f522a0e9eaf060727b7782d700f998efaa757c.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 4 Jul 2025 21:15:45 +0200
X-Gm-Features: Ac12FXwfccf3lgS-HMYq3s6L70ozkvRrYNPzd7GyM5YLjVzuLdxF6BuUk-9Xo-g
Message-ID: <CAP01T74_diwrEB0D=LOqVGQTGjiETm65cqh3zZEL5S5EkTYaZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/8] bpf: attribute __arg_untrusted for global
 function parameters
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Matt Bobrowski <mattbobrowski@google.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Jul 2025 at 21:07, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Fri, 2025-07-04 at 20:50 +0200, Kumar Kartikeya Dwivedi wrote:
> > On Fri, 4 Jul 2025 at 20:33, Eduard Zingerman <eddyz87@gmail.com> wrote:
> > >
> > > On Fri, 2025-07-04 at 11:28 -0700, Eduard Zingerman wrote:
> > > > On Fri, 2025-07-04 at 20:03 +0200, Kumar Kartikeya Dwivedi wrote:
> > > >
> > > > [...]
> > > >
> > > > > > @@ -7818,6 +7821,22 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
> > > > > >                         sub->args[i].btf_id = kern_type_id;
> > > > > >                         continue;
> > > > > >                 }
> > > > > > +               if (tags & ARG_TAG_UNTRUSTED) {
> > > > > > +                       int kern_type_id;
> > > > > > +
> > > > > > +                       if (tags & ~ARG_TAG_UNTRUSTED) {
> > > > > > +                               bpf_log(log, "arg#%d untrusted cannot be combined with any other tags\n", i);
> > > > > > +                               return -EINVAL;
> > > > > > +                       }
> > > > > > +
> > > > > > +                       kern_type_id = btf_get_ptr_to_btf_id(log, i, btf, t);
> > > > >
> > > > > So while this makes sense for trusted, I think for untrusted, we
> > > > > should allow types in program BTF as well.
> > > > > This is one of the things I think lacks in bpf_rdonly_cast as well, to
> > > > > be able to cast to types in program BTF.
> > > > > Say you want to reinterpret some kernel memory into your own type and
> > > > > access it using a struct in the program which is a different type.
> > > > > I think it makes sense to make this work.
> > > >
> > > > Hi Kumar,
> > > >
> > > > Thank you for the review.
> > > > Allowing local program BTF makes sense to me.
> > > > I assume we should first search in kernel BTF and fallback to program
> > > > BTF if nothing found. This way verifier might catch a program
> > > > accessing kernel data structure but having wrong assumptions about
> > > > field offsets (not using CO-RE). On the other hand, this might get
> > > > confusing if there is an accidental conflict between kernel data
> > > > structure name and program local data structure name.
> > >
> > > Maybe just add __arg_untrusted_local and avoid ambiguity?
> >
> > That might be less ambiguous, sure. But I don't see why the fallback
> > would be confusing.
> > It might be nice if we can support it without asking users to learn
> > about the difference between the two tags, but if it's too ugly we can
> > go with explicit local tag.
> > A user can have a struct without preserve_access_index now and having
> > the same name as the kernel struct, and the program will load things
> > at potentially wrong offsets.
> > If the same type exists, the program would fail compilation in C due
> > to duplicate types.
> > Are there any other cases where it might be a footgun that you anticipate?
>
> Well, basically two cases assuming that program does not use vmlinux.h:
>
>   struct kernel_type { // assume kernel type has 'i' at another offset
>     int *i;
>   };
>
>   __weak int global(struct kernel_type *p __arg_untrusted) {
>     return p->i[7]; // assume no CO-RE relocation for &p->i
>   }
>
> In this case, if kernel BTF is searched first verifier can catch that
> access to 'i' is bogus. However, that is not necessary if one assumes
> that verifier should only check for errors that can bring down the
> kernel.

Right, but it's also possible that loading p->i[7] is ok in the actual
kernel type, so the kernel will just load the program but mark the
register as potentially unexpected type.

>
> Another case:
>
>   // assume there is kernel type with the same name, but program
>   // author does not know about that and does not use vmlinux.h,
>   // thus avoiding compilation error.
>   struct accidental_kernel_type {
>     int *i;
>   };
>
>   __weak int global(struct accidental_kernel_type *p __arg_untrusted) {
>     return p->i[7];
>   }
>
> In this case user would not expect any errors at load time.
>
> Hm.
> Maybe just always use program BTF?

Yeah, so if the user specifies a type and has co-re enabled, they're
accessing a kernel struct.
If they're doing it without co-re, it's broken today already, or they
know the struct is fixed in layout somehow so it's ok.
If not, they want to access things at fixed offsets. So we can just
use the type they're using to model untrusted derefs.

So always using prog BTF makes sense to me.

>
> > > > Supporting bpf_core_cast for both prog BTF and kernel BTF types is not
> > > > trivial because we cannot disambiguate local vs kernel types.
> > > > IIRC module BTF types probably don't work either but that's a different story.
> >
> > > I can add bpf_rdonly_cast_local() as a followup, do you remember
> > > context in which you needed this?
> >
> > Adding Matt.
> >
> > Not long ago we were discussing iterating over the bpf linked list
> > since support doesn't exist in the kernel and it was safe in the
> > specific context to iterate over the list.
> > Ofcourse, we could add iteration support in the kernel, but another
> > approach would be the ability to subtract offset from node to arrive
> > at an untrusted pointer to type in prog BTF (that was allocated using
> > bpf_obj_new).
> > But bpf_core_cast didn't work there, so we ended up discarding that approach.
> > Not to get hung up on this specific example, but I think it would be
> > useful in general.
>
> I see, makes sense.
> That should be possible now using bpf_rdonly_cast(..., 0) but one
> would need to explicitly cast each pointer in this way.

