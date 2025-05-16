Return-Path: <bpf+bounces-58406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C00D7ABA04D
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 17:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92CAA1743E1
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 15:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE011BF33F;
	Fri, 16 May 2025 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRCl1Jby"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6567D07D
	for <bpf@vger.kernel.org>; Fri, 16 May 2025 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747410640; cv=none; b=l5tLkWk+YL/c3ZlnvkTe3NvbqjKvLf0UP6xm2/JmtLNNwROSlsw5VoRWOCHQTmIoL0N+Bh/e3VcanRTaxG6dkfvfqMid+oethiTmch6+DgXLLucWKzh/1LfzV8hCpGFP+cVVVoRWurgQpxMkkP4+EVwLLOhUQhh8Ge0Jijw+k40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747410640; c=relaxed/simple;
	bh=zCnoOAiyk/FScx9YbMjwRiv/+SdKfDSu/RWXpoeVIBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWoDgzlgVFB2sutnwoa9wejRQb9Av+YgBe1f8BD2qnjHcJKM3n+aftYNgDZsWttST5+LhWQT5Oe+VWnOiIDq35Ywlt1khSyc/u0sI7ZUJ660n4F9gF54tGaaEKUv2GvEqFh4fRDSy70ef58VZ2tGlbNC2WoA+HJjlIWyn/DaJgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRCl1Jby; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b0db0b6a677so1846222a12.2
        for <bpf@vger.kernel.org>; Fri, 16 May 2025 08:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747410638; x=1748015438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiokMjazJmTJuESnSf/4K0rZQWNYc3gngaw8F/dmTo8=;
        b=IRCl1JbyMDAG72fP/7q08bLUXKIKWoqtnQplZxYRfpDHpeatVaQPy3+eGGBDkgA5kT
         LL6anOKHtd+DTJJa7oXyrV097EiAcW3ZbyoaJy7+Z736D/dD3i+zKFgl59Gmi216gIw1
         LuOYANKgRRcRB/6F3cv5VyMa0g2Vxvx7XpOhAkTR+ICFSIVNEB2mpUHgirQt7qymKP6N
         xEA+6Io2aDw/lsGh8IF8Snmctdq2A94y7x+26l6JM6crRkEBEDFJidfkfI044zOHgEAx
         bsbh5rWS/qPXBSyerj7i0bIfS0+UgQdyvIGea+/Qn3j8R3634EKTV9mA4SOsvwBYVYKz
         qGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747410638; x=1748015438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiokMjazJmTJuESnSf/4K0rZQWNYc3gngaw8F/dmTo8=;
        b=vqc+/QAKfBfwj2cT0CZRxD18uD960ocQHzMNlupH292n3Ngg533V1U9I+Gt4DjEfXw
         GH71lUVJkFrP2/Fq+iAS/+QKUqCbiqEnptj4vgdA9nnnC4DxWxwRledkMqRcNPULYmKj
         gSgCkYSoHO1Y5IPShp6Is/EXYuUns1CRrUIrJfemmp+39cbqU6KB+IOK9fpedyN3DOvD
         j1T3jUW39WOe5ZwoFrLcuRoZbzsoi/yr/ZEemytJkLXz89MO1LOBc7Qxc1DTHZSiV1p9
         BADfRQqBuylh5X4kSTPngBTeZVyluXoR9F7ofZr2XpwaNDI19Xx5UNUveaVVsXqiVHgP
         ZS3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXl8RFiqeXSljBguxuiYBZIiSKAydIAKQ6Yq5W/mtwVxglPmO1crp5yx+K2VESum/LsT+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG/TS+mK6pGFMXb1jrDcchax+T9aHpLsxmUy3sEJeKzYKXIKej
	AMH5spPsz3LGVvW2ub4UHkYy+PwKGeJRI9CMfSjkzqA04VBPdF8uDlF9YZJi8fRLtmkfl++/Yu5
	sGniDh1ewH+AEbaAbv26hW1hYDJpy1x8Djot6
X-Gm-Gg: ASbGnctd20Wjf04hnVNyryeAlvA//0JpIm4GBBzF7rLpDcOOIN+mlxgpOPKZ/7+BqY2
	OkLMZz3b33AdRCS+3Rztb0rdPo8aUrQlUSw4bEk/gzz8byeOep4FRl59WD7r92jEpyAxUvhTYRu
	WNt3iugME697K6v29z0hNUSAyYK/b0pjkpeL/PBnZml+czacM9
X-Google-Smtp-Source: AGHT+IHjYcDrKMxpGXdBEZOcNAQEIkUYlWRv+uVBrttimq+RO7V85eDPCxOF+ieUs1MupAN9G/jf2ALeLN7i3UcyePU=
X-Received: by 2002:a17:902:f603:b0:223:f408:c3dc with SMTP id
 d9443c01a7336-231d43db55emr49059305ad.9.1747410637789; Fri, 16 May 2025
 08:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746598898.git.vmalik@redhat.com> <19913411da8c08170d959207e28262efc0a5d813.1746598898.git.vmalik@redhat.com>
 <CAEf4BzZBB3rD0gfxq3ZC0_RuBjXHBMqdXxw3DcEyuYhmh7n5HA@mail.gmail.com>
 <e1bb9c33b8852e1d3575f7cefe50aca266a8ff2b.camel@gmail.com>
 <CAEf4BzZ5x2JGcnZftf1KRiBziaz_On_mMtW77ArvnOyFNWh==Q@mail.gmail.com>
 <16d66553-e02d-4a13-aa54-50054aec3c98@redhat.com> <CAEf4BzbRiwivpVY4X29aq5txGP1UtpiGkjz=J0vLyvBO-Hw8Xw@mail.gmail.com>
 <71eb7443-18ce-4bf6-8371-a55a0016c6c1@redhat.com>
In-Reply-To: <71eb7443-18ce-4bf6-8371-a55a0016c6c1@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 May 2025 08:50:25 -0700
X-Gm-Features: AX0GCFsQF6qr2BTytd5M3ERtfKEVZZ7yQjIYa3DCeIleE9H_RlGPA2klEL9BcgU
Message-ID: <CAEf4BzZtKVW+NEBTOpFK23KixNtwzgeRJwc-tBXQkWsqov-ZvA@mail.gmail.com>
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

On Thu, May 15, 2025 at 10:59=E2=80=AFPM Viktor Malik <vmalik@redhat.com> w=
rote:
>
> On 5/15/25 19:17, Andrii Nakryiko wrote:
> > On Thu, May 15, 2025 at 5:27=E2=80=AFAM Viktor Malik <vmalik@redhat.com=
> wrote:
> >>
> >> On 5/10/25 00:03, Andrii Nakryiko wrote:
> >>> On Fri, May 9, 2025 at 2:37=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> >>>>
> >>>> On Fri, 2025-05-09 at 11:20 -0700, Andrii Nakryiko wrote:
> >>>>
> >>>> [...]
> >>>>
> >>>>>> +/**
> >>>>>> + * bpf_strchr - Find the first occurrence of a character in a str=
ing
> >>>>>> + * @s: The string to be searched
> >>>>>> + * @c: The character to search for
> >>>>>> + *
> >>>>>> + * Note that the %NUL-terminator is considered part of the string=
, and can
> >>>>>> + * be searched for.
> >>>>>> + *
> >>>>>> + * Return:
> >>>>>> + * * const char * - Pointer to the first occurrence of @c within =
@s
> >>>>>> + * * %NULL        - @c not found in @s
> >>>>>> + * * %-EFAULT     - Cannot read @s
> >>>>>> + * * %-E2BIG      - @s too large
> >>>>>> + */
> >>>>>> +__bpf_kfunc const char *bpf_strchr(const char *s, char c)
> >>>>>
> >>>>> so let's say we found the character, we return a pointer to it, and
> >>>>> that memory goes away (because we never owned it, so we don't reall=
y
> >>>>> know what and when will happen with it). Question, will verifier al=
low
> >>>>> BPF program to dereference this pointer? If yes, that's a problem. =
But
> >>>>> if not, then I'm not sure there is much point in returning a pointe=
r.
> >>
> >> You are right, at the moment, the verifier marks the returned pointers
> >> as `rdonly_mem_or_null` so an attempt to dereference them will result
> >> into a verifier error. Which is clearly not very useful.
> >>
> >> I'd say that, theoretically, the pointers returned from these kfuncs
> >> should be treated by the verifier in the same way as the passed
> >> pointers. That is, if PTR_TO_MAP_VALUE is passed,
> >> PTR_TO_MAP_VALUE_OR_NULL should be returned, and so on.
> >>
> >>>>> I'm just trying to imply that in BPF world integer-based APIs work
> >>>>> better/safer, overall? For strings, we can switch any
> >>>>> pointer-returning API to position-returning (or negative error) API
> >>>>> and it would more or less naturally fit into BPF API surface, no?
> >>>>
> >>>> Integer based API solves the problem with memory access but is not
> >>>> really ergonomic. W/o special logic in verifier the returned int wou=
ld
> >>>> be unbounded, hence the user would have to compare it with string
> >>>> length before using.
> >>>>
> >>>> It looks like some verifier logic is necessary regardless of API bei=
ng
> >>>> integer or pointer based. In any case verifier needs additional rule=
s
> >>>> for each pointer type to adjust bounds on the return value or its re=
fobj_id.
> >>
> >> IMO the problem here is that we can't just say anything about the
> >> returned pointer (or index) rather than it is within the bounds of the
> >> original string (or within the passed size for bounded kfuncs). So, an=
y
> >> access to that pointer with an offset other than 0 will still need an
> >> explicit bounds check.
> >
> > Exactly.
> >
> >>
> >>> You can't safely dereference any pointer returned from these APIs,
> >>> because the memory might not be there anymore.
> >>
> >> You can't if the memory comes from an untrusted source. But what if th=
e
> >> memory is owned by the BPF program (e.g. on stack or in a map)? Then, =
it
> >> should be possible to dereference it safely, shouldn't it? IMHO, this
> >> would be quite a common use-case: read string into BPF memory using
> >> bpf_probe_read_str -> use string kfunc to search it -> do something wi=
th
> >> the returned pointer (dereference it). From ergonomics perspective, it
> >> shouldn't be necessary to use bpf_probe_read or __get_kernel_nofault
> >> again.
> >
> > For bpf_probe_read_str -> use kfunc scenario, I thought the main
> > *goal* is to avoid the bpf_probe_read_str operation altogether. That's
> > why we allow unsafe pointers passed into those kfuncs you are adding
> > and why we use __get_kernel_nofault internally.
>
> My original use-case (for bpftrace) was pure ergonimics - we typically
> have a string on stack or in a map and instead of writing the string
> operation by hand, we could use a pre-defined kfunc. But your suggested
> use-case is probably even more valuable.
>
> > So with that, you'd actually just use, say, bpf_strchr(), get back
> > some pointer or index, calculate substring (prefix) length, and *then*
> > maybe bpf_probe_read_str into ringbuf or local buffer, if you'd like
> > to capture the data and do some post processing.
>
> Agreed. The great strength I can see in this is that in many cases, you
> don't need the follow-up bpf_probe_read_str at all - getting the length
> of the (sub)string, testing for substring or character inclusion, etc.
>
> >>
> >>> For integers, same idea. If you use bpf_probe_read_{kernel,user} to
> >>> read data, then verifier doesn't care about the value of integer.
> >>>
> >>> But that's not ergonomic, so in some other thread few days ago I was
> >>> proposing that we should add an untyped counterpart to bpf_core_cast(=
)
> >>> that would just make any memory accesses performed using
> >>> __get_kernel_nofault() semantics. And so then:
> >>>
> >>>
> >>> const char *str =3D <random value or we got it from somewhere untrust=
ed>;
> >>> int space_idx =3D bpf_strchr(str, ' ');
> >>> if (space_idx < 0)
> >>>   return -1; /* bad luck */
> >>>
> >>> const char *s =3D bpf_mem_cast(str);
> >>> char buf[64] =3D {};
> >>>
> >>> bpf_for(i, 0, space_idx)
> >>>     buf[i] =3D s[i]; /* MAGIC */
> >>>
> >>> bpf_printk("STUFF BEFORE SPACE: %s", buf);
> >>
> >> I can imagine that this would be a nice helper for accessing untrusted
> >> memory in general but I don't think it's specific to string kfuncs. At
> >> the moment, reading an untrusted string requires bpf_probe_read_str so
> >> calling it after processing the string via a kfunc doesn't introduce a=
ny
> >> extra call.
> >
> > I might be confused, see above. My impression was that with your
> > functions we won't need bpf_probe_read_str() and that was the whole
> > point of your __get_kernel_nofault-based reimplementation. If not for
> > that, we'd use trusted memory pointers and just used internal kernel
> > strings, knowing that we are working with MAP_VALUE or PTR_TO_STACK of
> > well-bounded size.
> >
> > Then again, see what I wrote above. I imagine that the user would not
> > do bpf_probe_read_str() at all. I'll do bpf_strchr(), followed by
> > bpf_memcast(), followed by iterating from 0 to the index returned from
> > bpf_strchr(), if I need to process the substring.
>
> Yeah, I can see value in that although I'm not sure what's the
> difference between bpf_mem_cast and bpf_probe_read_str since they both
> use __get_kernel_nofault under the hood. Just ergonomics and the fact
> that bpf_mem_cast doesn't need a buffer? Also, shouldn't the

It's not "just doesn't need a buffer", that's a major difference (and
that buffer is sometimes a major limitation and blocker) Strings can
be short *most of the time*, but occasionally could be very long. In
both cases you want to process them in their entirety, if possible,
but you can't afford pre-allocating buffer for the worst case just to
be able to make a local copy.

> dereferences after bpf_mem_cast be called under pagefault_disable?
>
> >> BTW note that at the moment, the kfuncs do not accept strings from
> >> untrusted sources as the verifier doesn't know how to treat `char *`
> >> kfunc args and treats them as scalars (which are incompatible with oth=
er
> >> pointers). Here, changing also the kfunc args to ints would probably
> >> help, although I think that it would not be ergonomic at all. So, we
> >> still need some verifier work to handle `char *` args to kfuncs.
> >
> > Ok, so that's probably the missing piece. We need to teach verifiers
> > to allow such untrusted pointers. I thought that was the whole idea
> > behind adding these APIs: to allow such usage.
>
> Yes, I'll look into that. Do you want to merge everything together or
> should I post the updated (likely int-based) kfuncs in the meantime as
> they are useful for trusted pointers as well?

I'd switch all APIs to integers. And to allow passing any untrusted
pointer, I believe we already have __ign suffix for kfunc argument. So
please add __ign where appropriate, and let's write a few more tests
validating that all this works?

bpf_mem_cast() is probably a separate feature, so I wouldn't block on that.

>
> Viktor
>
> >>
> >>> Tbh, when dealing with libc string APIs, I still very frequently
> >>> convert resulting pointers into indices, so I don't think it's
> >>> actually an API regression to have index-based string APIs
> >>
> >> I agree here. In addition, it looks to me that returning pointers woul=
d
> >> require extra verifier work while returning indices would not. And we
> >> still need to apply extra bounds checks or access helpers in a majorit=
y
> >> of use-cases so we don't loose much ergonomics with integer-based APIs=
.
> >>
> >
> > +1
> >
>

