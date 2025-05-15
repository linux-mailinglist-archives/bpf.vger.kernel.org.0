Return-Path: <bpf+bounces-58332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3256AB8D8C
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 19:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A706A04FE1
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 17:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8DF25742F;
	Thu, 15 May 2025 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c73wFUJa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B464AD51
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329489; cv=none; b=pX747943rN29P6jpRlW2vTnDrXaTUiFPX0mChop5B3iXIe3mMWATSkDvOUloiwuI/VArdCOuVQh+Azq5xiO6nE77t8xFreJ4auRA4/oSjjjSZgu/S3CQPqkUS1eM/JnlxWl90U4v78FocshJ8rNMRI3/wXkeB+pgui7KuMCyYDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329489; c=relaxed/simple;
	bh=MqMgQpxrSHIxbZFBrgBvwjE69sxR9FXQu3kmoudt1w8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oX5Xuk+1/tDnG+5SgDUAncyRJJDO9xYVIbftpdQ0w2jFLCWlNJahtzCDaN0c0PUt6zZmCedJYnp3iF4ZoJIwvRPXY7t6kEdUwOq7C/sC5CbzWxhYvKTJrqGmznXCRBN0KydP9qT6066J3FcUA7i36anXLFRdtL5l5rumQmapmZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c73wFUJa; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-30aa3980af5so1433318a91.0
        for <bpf@vger.kernel.org>; Thu, 15 May 2025 10:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747329487; x=1747934287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+5HVf21ZS35nf2D9NjMYisSxOJP2spuRtxfgZBw3AE=;
        b=c73wFUJaQdVSGuAi9YUk8WB4IVsraGsl3VeNtUmDg0SDyDzzYDAQob8/Buoaqze15n
         ivQ/Mu1a7IbnHExgpbh3YRkGa7bQzWcvQSb8Wkj5GkiwAFEd5jhJ7B5xMqDoz0BJYJqF
         fE3w/YB+KT1PkHTgsD3W2s7EFsbVOwEnh//9BP7ttr4lOv1R/FAibXP8vhsqe4S2FQ+E
         411NGv6r5viyCSADuUuOja0l7U/uI5opN9j5NQqjxk+nZA9SErstUH7Ww26fTy8KnrrD
         3LdeW1kf3WMnBXfVvRixiI4ElJYTBynO3eQX0DVBKQPRPXi4faZPxF4yCpqWvFpX+mFv
         hjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747329487; x=1747934287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+5HVf21ZS35nf2D9NjMYisSxOJP2spuRtxfgZBw3AE=;
        b=ZClltc+zHm3Z8W214JJL1ZjsIs0fvnq0aIDEy8Dxsg4R7s1+XcijeLjWZ7M7DXLXk9
         3naz0FhvBom4vUMhIbJROIkLeut5e5cpnF/kGvwOkoeVe8MiZ9kb7Pr1+iVF+UelSNsf
         DLBnXrbGiUPvxPg1ImhPQYiRGG2jqgmnhbzM7s4a2Dfg5b2dWK6NHqa6l5TCrUjybwOD
         7h+uNOfaPf7XVVBP7nQ0TvjPSpKmN0bwNB8rPNPc4ryZzYbIaKoFQ4g8n9L9lM15m8Co
         YcPpXpG/YEzq086inMoQKOC9MAtOj7gkUOLlpl7ioGWO54QTHsJctceklNFn1iTKN2/t
         5tLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAOpIJzKTkeQewDah8Io9Eap/rscbI3xz/90dTdnOf3rHMq5DV61eKEkOwpi1QEpC6+wY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+LEuQLQiXNJuFLNMls8M0Fl5JNLmXkO3IgBHhlIyiVtyvxgMK
	pFFej3fYR/GIpas1DhmK01nVzMIA4fKTLeFF2u7mzt3OxVBwoKS3XIw9mkP0AzXK/WNI9xCCjl0
	PdtyYimkcpKvv+FrM7MmhlmfOd+ffZ88=
X-Gm-Gg: ASbGnctJ8hvmpqHmAToFr4OR6QNN0trmCIkcs3zdJzFHai3REzEWmGLfpyXFfJ/9soe
	gfFmwdWBAMl+5Oa6hs17QySvYw3MHC/D9pPJKncNP3ylvlSOwo6/9+QTeHh79vX7prhedJ0jMAV
	WhJSH/jh0hZt7yOsdLuIdQKgXl9YSZwztAL7/t6hR9RlXem7Cp
X-Google-Smtp-Source: AGHT+IGbsl/mBnU6VRBpu1n+409NWhcBiQwkcHmBgtkU3VbYN5c/yPgaCkTYo8UORx8alxLz4pRoDfG2fQTvc0whEMQ=
X-Received: by 2002:a17:90b:58e4:b0:2ff:6f88:b04a with SMTP id
 98e67ed59e1d1-30e7d57dd3emr312080a91.15.1747329486963; Thu, 15 May 2025
 10:18:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746598898.git.vmalik@redhat.com> <19913411da8c08170d959207e28262efc0a5d813.1746598898.git.vmalik@redhat.com>
 <CAEf4BzZBB3rD0gfxq3ZC0_RuBjXHBMqdXxw3DcEyuYhmh7n5HA@mail.gmail.com>
 <e1bb9c33b8852e1d3575f7cefe50aca266a8ff2b.camel@gmail.com>
 <CAEf4BzZ5x2JGcnZftf1KRiBziaz_On_mMtW77ArvnOyFNWh==Q@mail.gmail.com> <16d66553-e02d-4a13-aa54-50054aec3c98@redhat.com>
In-Reply-To: <16d66553-e02d-4a13-aa54-50054aec3c98@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 May 2025 10:17:54 -0700
X-Gm-Features: AX0GCFvMnzTdyQCy1fAM4BfC4eSYeBA5tmB0ZGWpL4Na_mLD5EZAmnR4SdN_KUU
Message-ID: <CAEf4BzbRiwivpVY4X29aq5txGP1UtpiGkjz=J0vLyvBO-Hw8Xw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/4] bpf: Add kfuncs for read-only string operations
To: Viktor Malik <vmalik@redhat.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 5:27=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> On 5/10/25 00:03, Andrii Nakryiko wrote:
> > On Fri, May 9, 2025 at 2:37=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >>
> >> On Fri, 2025-05-09 at 11:20 -0700, Andrii Nakryiko wrote:
> >>
> >> [...]
> >>
> >>>> +/**
> >>>> + * bpf_strchr - Find the first occurrence of a character in a strin=
g
> >>>> + * @s: The string to be searched
> >>>> + * @c: The character to search for
> >>>> + *
> >>>> + * Note that the %NUL-terminator is considered part of the string, =
and can
> >>>> + * be searched for.
> >>>> + *
> >>>> + * Return:
> >>>> + * * const char * - Pointer to the first occurrence of @c within @s
> >>>> + * * %NULL        - @c not found in @s
> >>>> + * * %-EFAULT     - Cannot read @s
> >>>> + * * %-E2BIG      - @s too large
> >>>> + */
> >>>> +__bpf_kfunc const char *bpf_strchr(const char *s, char c)
> >>>
> >>> so let's say we found the character, we return a pointer to it, and
> >>> that memory goes away (because we never owned it, so we don't really
> >>> know what and when will happen with it). Question, will verifier allo=
w
> >>> BPF program to dereference this pointer? If yes, that's a problem. Bu=
t
> >>> if not, then I'm not sure there is much point in returning a pointer.
>
> You are right, at the moment, the verifier marks the returned pointers
> as `rdonly_mem_or_null` so an attempt to dereference them will result
> into a verifier error. Which is clearly not very useful.
>
> I'd say that, theoretically, the pointers returned from these kfuncs
> should be treated by the verifier in the same way as the passed
> pointers. That is, if PTR_TO_MAP_VALUE is passed,
> PTR_TO_MAP_VALUE_OR_NULL should be returned, and so on.
>
> >>> I'm just trying to imply that in BPF world integer-based APIs work
> >>> better/safer, overall? For strings, we can switch any
> >>> pointer-returning API to position-returning (or negative error) API
> >>> and it would more or less naturally fit into BPF API surface, no?
> >>
> >> Integer based API solves the problem with memory access but is not
> >> really ergonomic. W/o special logic in verifier the returned int would
> >> be unbounded, hence the user would have to compare it with string
> >> length before using.
> >>
> >> It looks like some verifier logic is necessary regardless of API being
> >> integer or pointer based. In any case verifier needs additional rules
> >> for each pointer type to adjust bounds on the return value or its refo=
bj_id.
>
> IMO the problem here is that we can't just say anything about the
> returned pointer (or index) rather than it is within the bounds of the
> original string (or within the passed size for bounded kfuncs). So, any
> access to that pointer with an offset other than 0 will still need an
> explicit bounds check.

Exactly.

>
> > You can't safely dereference any pointer returned from these APIs,
> > because the memory might not be there anymore.
>
> You can't if the memory comes from an untrusted source. But what if the
> memory is owned by the BPF program (e.g. on stack or in a map)? Then, it
> should be possible to dereference it safely, shouldn't it? IMHO, this
> would be quite a common use-case: read string into BPF memory using
> bpf_probe_read_str -> use string kfunc to search it -> do something with
> the returned pointer (dereference it). From ergonomics perspective, it
> shouldn't be necessary to use bpf_probe_read or __get_kernel_nofault
> again.

For bpf_probe_read_str -> use kfunc scenario, I thought the main
*goal* is to avoid the bpf_probe_read_str operation altogether. That's
why we allow unsafe pointers passed into those kfuncs you are adding
and why we use __get_kernel_nofault internally.

So with that, you'd actually just use, say, bpf_strchr(), get back
some pointer or index, calculate substring (prefix) length, and *then*
maybe bpf_probe_read_str into ringbuf or local buffer, if you'd like
to capture the data and do some post processing.

>
> > For integers, same idea. If you use bpf_probe_read_{kernel,user} to
> > read data, then verifier doesn't care about the value of integer.
> >
> > But that's not ergonomic, so in some other thread few days ago I was
> > proposing that we should add an untyped counterpart to bpf_core_cast()
> > that would just make any memory accesses performed using
> > __get_kernel_nofault() semantics. And so then:
> >
> >
> > const char *str =3D <random value or we got it from somewhere untrusted=
>;
> > int space_idx =3D bpf_strchr(str, ' ');
> > if (space_idx < 0)
> >   return -1; /* bad luck */
> >
> > const char *s =3D bpf_mem_cast(str);
> > char buf[64] =3D {};
> >
> > bpf_for(i, 0, space_idx)
> >     buf[i] =3D s[i]; /* MAGIC */
> >
> > bpf_printk("STUFF BEFORE SPACE: %s", buf);
>
> I can imagine that this would be a nice helper for accessing untrusted
> memory in general but I don't think it's specific to string kfuncs. At
> the moment, reading an untrusted string requires bpf_probe_read_str so
> calling it after processing the string via a kfunc doesn't introduce any
> extra call.

I might be confused, see above. My impression was that with your
functions we won't need bpf_probe_read_str() and that was the whole
point of your __get_kernel_nofault-based reimplementation. If not for
that, we'd use trusted memory pointers and just used internal kernel
strings, knowing that we are working with MAP_VALUE or PTR_TO_STACK of
well-bounded size.

Then again, see what I wrote above. I imagine that the user would not
do bpf_probe_read_str() at all. I'll do bpf_strchr(), followed by
bpf_memcast(), followed by iterating from 0 to the index returned from
bpf_strchr(), if I need to process the substring.

>
> BTW note that at the moment, the kfuncs do not accept strings from
> untrusted sources as the verifier doesn't know how to treat `char *`
> kfunc args and treats them as scalars (which are incompatible with other
> pointers). Here, changing also the kfunc args to ints would probably
> help, although I think that it would not be ergonomic at all. So, we
> still need some verifier work to handle `char *` args to kfuncs.

Ok, so that's probably the missing piece. We need to teach verifiers
to allow such untrusted pointers. I thought that was the whole idea
behind adding these APIs: to allow such usage.

>
> > Tbh, when dealing with libc string APIs, I still very frequently
> > convert resulting pointers into indices, so I don't think it's
> > actually an API regression to have index-based string APIs
>
> I agree here. In addition, it looks to me that returning pointers would
> require extra verifier work while returning indices would not. And we
> still need to apply extra bounds checks or access helpers in a majority
> of use-cases so we don't loose much ergonomics with integer-based APIs.
>

+1

