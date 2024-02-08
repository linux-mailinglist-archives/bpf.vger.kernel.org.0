Return-Path: <bpf+bounces-21525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B442184E8B4
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 20:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEBF4B2BD6B
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 19:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F23E364D8;
	Thu,  8 Feb 2024 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APibbuL/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296E9364B7
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418588; cv=none; b=uF8H8AKjQDIPTkJJHbw8tFRVHQs24DsoYOiN1XH5HHMmuup3df6B9yj1Ly6Kc/cvER/woPnwC6aM8skL3gI4v0R4dacbGKwXYoQsZMFEmiACwvxq8uA8PlgEPqvGS6+4upiZsiI9X5DczWcixnl5d1xcGAd3ojSoKgqn9iRqOso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418588; c=relaxed/simple;
	bh=EAPUV4eQDE045bPk1qkljNvfmiW5700wIZ8y8OfY/S8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKSZaqztf2o66gdO6OSYnzv/mKHpEwaEFDEIRpJiV8Tmfz3XIDzjEpixUbu3U0PyJTCTMnLOveae+NtyiqyQiCYJs6mWfVhIb19PEBxNKyS66dQZhVoi5mJbgLjgw4nC48C/9YL3EHFMcPO9A5TFiKwdCZEmqJTsNkE4MGn07xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APibbuL/; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-296717ccc2aso959036a91.1
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 10:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707418586; x=1708023386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhQ88eL4fk1cfo3XQWJOhOltM20VLquDz9bXCJI039Y=;
        b=APibbuL/ThKrbX8rWgik/I+dQGOg+BIa064MJhwCjGxuGEjnlc4F+hX/ihhjl9CH2H
         iYPC6Q27PnN2avzj2Mpdw7ZDd815BIcLvEUqi9s66i3QJ8lYPY1pb8OKWwAwBr7iuy1n
         kqX6LJnLsC2uX0R1qNFxzocVCzDrXPyXfvFhsgzOGPaSW7kPS+OEV9sk8gUtfHHqnKz2
         WEA3z2JLo3gvlkpHeFWeLJkGD6ZRTkEU20IbdkjO6s3JUODpOYyim72PUoBjjcgO1/8x
         Zx4kJCxxS5OHqECo2VrehlTf3cf+yE05vmG6KWEFiRZBrHSOnnvtOAdmYiRff0Ir/mwE
         Gsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707418586; x=1708023386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhQ88eL4fk1cfo3XQWJOhOltM20VLquDz9bXCJI039Y=;
        b=gOcijrajFQW33hYBfnLJBOZQ+zCdFGE8Doz3S+YpSBm7rW5bh5vSt6JcEy6XuvFI6g
         THI3utWOcMnWawOmL/7gsXlNMSBJ0fKjAOLILVU0RL/ekFv2WNv3GvtB5bUTk5LPvan9
         rTgPoIhBaMbSjiiX5qKB8fgxG7Uqr2/b6Qa6dFQO6KPAFhk4AeKIx/oeskvpfjrtG/Ao
         U3qVr4SEcX7j271lwtYmMUPNj/msobvdFX9hHSWu2mDOTkMcuiWxktYHWn+PJooOzQmz
         2SuiqT6mxiBA4uHStIUT52XfC4+6tzVJ9kSnJix2O78GazmnjHk4UE5EyAKY6Bn+ukF5
         7kCw==
X-Forwarded-Encrypted: i=1; AJvYcCUH5N0QnAzo1EPBxcQulhayRMYcrHt5YJRUiy9ah3PnX3Z1Oxig3gBf4UiwvXZUokodGEwUMnodwANRHHcI6vzXsI95
X-Gm-Message-State: AOJu0YxtHVj/S8WfpiDlGAvOsN85q5JANLuWA+AAczAdlUhU84j8Pj+t
	+xf8CnXlhs6aF7s+edOJiSvKeoTKL254AZ4HZyO+h3tz2GX7Gu6/wQ1tYQmbwDdKpFSt4aDsdZK
	MhfqDUHLlqPiaeq4WBNgsHueDyeoDnBLM
X-Google-Smtp-Source: AGHT+IGXnzL/rWYCutvd130J4cmNqv1f5YDK2XMrbombYZYGTZgWIgP4lXhT7njTwHAbZHdHqRAwLh5eI4VkiTVUWyk=
X-Received: by 2002:a17:90a:e54b:b0:296:cfe7:98ca with SMTP id
 ei11-20020a17090ae54b00b00296cfe798camr5936881pjb.9.1707418586439; Thu, 08
 Feb 2024 10:56:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208090906.56337-1-laoar.shao@gmail.com> <20240208090906.56337-4-laoar.shao@gmail.com>
 <4e79dc07-ba34-49e3-92fe-a5f2c96045ee@linux.dev>
In-Reply-To: <4e79dc07-ba34-49e3-92fe-a5f2c96045ee@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Feb 2024 10:56:14 -0800
Message-ID: <CAEf4BzZQARf_n5YxfiuL=jKXrA8-=iFWmXe_X1jEi-QXnAQj-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] libbpf: Check the return value of bpf_iter_<type>_new()
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 9:43=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> On 2/8/24 1:09 AM, Yafang Shao wrote:
> > On success, bpf_iter_<type>_new() return 0. On failure, it returns ERR.
> > We'd better check the return value of it.
>
> Not sure whether this patch is necessary or not.
>
> I checked:
>    bpf_iter_num_{new,next}
>    bpf_iter_task_vma_{new,next}
>    bpf_iter_css_task_{new,next}
>
> It looks like the convention is for *_next() return NULL or not
> instead of relying on return value of _new() to decide whether to
> proceed or not. Maybe Andrii can clarify.

Yes, exactly. if bpf_iter_xxx_new() failed, subsequent
bpf_iter_xxx_next() should return NULL and bpf_iter_xxx_destroy() will
be a no-op as well. So yes, there is no need for extra error checking
here.

>
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >   tools/lib/bpf/bpf_helpers.h | 16 ++++++++++++----
> >   1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> > index 79eaa581be98..2cd2428e3bc6 100644
> > --- a/tools/lib/bpf/bpf_helpers.h
> > +++ b/tools/lib/bpf/bpf_helpers.h
> > @@ -133,6 +133,15 @@
> >   # define __bpf_unreachable()        __builtin_trap()
> >   #endif
> >
> > +#ifndef __must_check
> > +#define __must_check __attribute__((warn_unused_result))
> > +#endif
> > +
> > +static inline void * __must_check ERR_PTR(long error)
> > +{
> > +     return (void *) error;
> > +}
> > +
> >   /*
> >    * Helper function to perform a tail call with a constant/immediate m=
ap slot.
> >    */
> > @@ -340,14 +349,13 @@ extern void bpf_iter_num_destroy(struct bpf_iter_=
num *it) __weak __ksym;
> >       /* initialize and define destructor */                           =
                       \
> >       struct bpf_iter_##type ___it __attribute__((aligned(8), /* enforc=
e, just in case */,    \
> >                                                   cleanup(bpf_iter_##ty=
pe##_destroy))),       \
> > -     /* ___p pointer is just to call bpf_iter_##type##_new() *once* to=
 init ___it */         \
> >                              *___p __attribute__((unused)) =3D (       =
                         \
> > -                                     bpf_iter_##type##_new(&___it, ##a=
rgs),                  \
> >       /* this is a workaround for Clang bug: it currently doesn't emit =
BTF */                 \
> >       /* for bpf_iter_##type##_destroy() when used from cleanup() attri=
bute */                \
> > -                                     (void)bpf_iter_##type##_destroy, =
(void *)0);            \
> > +                                     (void)bpf_iter_##type##_destroy, =
                       \
> > +                                     ERR_PTR(bpf_iter_##type##_new(&__=
_it, ##args)));        \
> >       /* iteration and termination check */                            =
                       \
> > -     (((cur) =3D bpf_iter_##type##_next(&___it)));                    =
                         \
> > +     ((!___p) && ((cur) =3D bpf_iter_##type##_next(&___it)));         =
                         \
> >   )
> >   #endif /* bpf_for_each */
> >

