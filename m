Return-Path: <bpf+bounces-14002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649D17DF9AE
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 19:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17482281CA6
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 18:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27D12111C;
	Thu,  2 Nov 2023 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKWlIB3k"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C7F21104
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 18:13:08 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B346D66
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 11:12:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9d8d3b65a67so184202266b.2
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 11:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698948753; x=1699553553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkHpsWC2+XtnAC21pG0c8GJ6X3CWEOj0GTt71/LvGlM=;
        b=OKWlIB3kKDK2u3d64qI5QqQQip7ofuKjvvhFsKzOHnFOWkH39WDmYOquRdKm6KrwzF
         0IKxrb62RIhnZON/NcxJAm5XXc07ggf62NfxOvHgKGc907ZbAG6j+3smXmRUyrXJAbCO
         1tWJbZLQGt/3GeeWymP+SVMIUOAdMwNr2r31AoUttJPl2YoiLbYjwWMY1eNqdA/PnP7I
         OT3ARvBE6UKcnS5mGj7/cpQoh7ILPm44zbkO47UUmzABurxKS7IB0hA5CAozqOH0ihaz
         pbgHRUZRlc8RyvGGevAwmR74lKuzTSjL3yz8LStWShGKWRQ64kDWI4L9wXFnFxHbbjXj
         3mmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698948753; x=1699553553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkHpsWC2+XtnAC21pG0c8GJ6X3CWEOj0GTt71/LvGlM=;
        b=BmzFjxETFUlFR/zwTi8GtXQEUdRaduWDd2y1RALP3SYUPTcnrbVYznQzamqahvSPBV
         sciuPdx7jR33bmPgF1wST/0DUMF4hQeFaNsC49uO8D9QNUK9teuZvvCKl8q1Xu9lw50s
         WHdrjLkcvD+1NtScjED4b9vDK1VvUxv3/is11Q0qH3Pmy9j3oTslrx7qaKt2k+jPIRV7
         QoD9Dc3pvwH3FZ0iRBtJjLZlZO2pwJbTMEy33KyhHK/aUTIhEuf2chn3mYgZsshi67bq
         vTZOIYjTv7vjsEoXrRFZLNzxqZ5YaQt6uWyg9sDh2botB84czvxwO9IAm0Use9gAvflS
         HE0g==
X-Gm-Message-State: AOJu0Yzy1TnZdqKdwwM4gdvCKoGCOh6vWRSLkb4wz4qftXV59Y3vS2EU
	13fN4NRQthOBP9KgCrzTKUHQWgIvpFgL83EkcmY=
X-Google-Smtp-Source: AGHT+IHBj+EShxFh0IXvAtUv7AvuRcYcM9UDlIyab5lO/9uTgzYveT4mTaAKfClWsxo/dZgRtut5J3JVQMPMB9moFSs=
X-Received: by 2002:a17:906:fd89:b0:9b9:a1dd:5105 with SMTP id
 xa9-20020a170906fd8900b009b9a1dd5105mr5786730ejb.50.1698948753082; Thu, 02
 Nov 2023 11:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024235551.2769174-1-song@kernel.org> <20231024235551.2769174-2-song@kernel.org>
 <CAEf4Bzbr8dgksh2z+4nEkAFdV9gquhR+HROULKdTkWrUpSM9-Q@mail.gmail.com>
 <CAEf4BzbDFDX30Y_Hcmd__hgDp+m6X+htr-wTeBtaoauEnrEdLw@mail.gmail.com>
 <CAEf4BzaD+FV_PM8_4yWnZVed9pXE-KX6CwpYEmiUDpMRQDNEXQ@mail.gmail.com> <15A85D6B-56E5-4C9F-B7AB-A62F3DA8294C@fb.com>
In-Reply-To: <15A85D6B-56E5-4C9F-B7AB-A62F3DA8294C@fb.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 Nov 2023 11:12:21 -0700
Message-ID: <CAEf4BzaV4LZUqHcfFZvkY=6J8vF9xhHG_cUNUyVzgQmj4=ke6g@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 1/9] bpf: Expose bpf_dynptr_slice* kfuncs for
 in kernel use
To: Song Liu <songliubraving@meta.com>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"fsverity@lists.linux.dev" <fsverity@lists.linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Eric Biggers <ebiggers@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	"roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 11:09=E2=80=AFAM Song Liu <songliubraving@meta.com> =
wrote:
>
>
>
> > On Nov 2, 2023, at 10:16=E2=80=AFAM, Andrii Nakryiko <andrii.nakryiko@g=
mail.com> wrote:
> >
> > On Thu, Nov 2, 2023 at 10:09=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Thu, Nov 2, 2023 at 9:56=E2=80=AFAM Andrii Nakryiko
> >> <andrii.nakryiko@gmail.com> wrote:
> >>>
> >>> On Tue, Oct 24, 2023 at 4:56=E2=80=AFPM Song Liu <song@kernel.org> wr=
ote:
> >>>>
> >>>> kfuncs bpf_dynptr_slice and bpf_dynptr_slice_rdwr are used by BPF pr=
ograms
> >>>> to access the dynptr data. They are also useful for in kernel functi=
ons
> >>>> that access dynptr data, for example, bpf_verify_pkcs7_signature.
> >>>>
> >>>> Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr to bpf.h so that kern=
el
> >>>> functions can use them instead of accessing dynptr->data directly.
> >>>>
> >>>> Update bpf_verify_pkcs7_signature to use bpf_dynptr_slice instead of
> >>>> dynptr->data.
> >>>>
> >>>> Also, update the comments for bpf_dynptr_slice and bpf_dynptr_slice_=
rdwr
> >>>> that they may return error pointers for BPF_DYNPTR_TYPE_XDP.
> >>>>
> >>>> Signed-off-by: Song Liu <song@kernel.org>
> >>>> ---
> >>>> include/linux/bpf.h      |  4 ++++
> >>>> kernel/bpf/helpers.c     | 16 ++++++++--------
> >>>> kernel/trace/bpf_trace.c | 15 +++++++++++----
> >>>> 3 files changed, 23 insertions(+), 12 deletions(-)
> >>>>
> >>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >>>> index b4825d3cdb29..3ed3ae37cbdf 100644
> >>>> --- a/include/linux/bpf.h
> >>>> +++ b/include/linux/bpf.h
> >>>> @@ -1222,6 +1222,10 @@ enum bpf_dynptr_type {
> >>>>
> >>>> int bpf_dynptr_check_size(u32 size);
> >>>> u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
> >>>> +void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offse=
t,
> >>>> +                      void *buffer__opt, u32 buffer__szk);
> >>>> +void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 =
offset,
> >>>> +                           void *buffer__opt, u32 buffer__szk);
> >>>>
> >>>> #ifdef CONFIG_BPF_JIT
> >>>> int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf=
_trampoline *tr);
> >>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >>>> index e46ac288a108..af5059f11e83 100644
> >>>> --- a/kernel/bpf/helpers.c
> >>>> +++ b/kernel/bpf/helpers.c
> >>>> @@ -2270,10 +2270,10 @@ __bpf_kfunc struct task_struct *bpf_task_fro=
m_pid(s32 pid)
> >>>>  * bpf_dynptr_slice will not invalidate any ctx->data/data_end point=
ers in
> >>>>  * the bpf program.
> >>>>  *
> >>>> - * Return: NULL if the call failed (eg invalid dynptr), pointer to =
a read-only
> >>>> - * data slice (can be either direct pointer to the data or a pointe=
r to the user
> >>>> - * provided buffer, with its contents containing the data, if unabl=
e to obtain
> >>>> - * direct pointer)
> >>>> + * Return: NULL or error pointer if the call failed (eg invalid dyn=
ptr), pointer
> >>>
> >>> Hold on, nope, this one shouldn't return error pointer because it's
> >>> used from BPF program side and BPF program is checking for NULL only.
> >>> Does it actually return error pointer, though?
>
> Right. kfunc should not return error pointer.

Turns out it doesn't, see discussion in [0]. Maybe you can sneak in
that comment in your next revision as a separate lightweight patch :)

  [0] https://lore.kernel.org/bpf/CAEf4Bzb4VbH56S2D_5Sc3u9V=3DOXOy20JTr4wsO=
bBOiUA32Md2Q@mail.gmail.com/

>
> >>
> >> So I just checked the code (should have done it before replying,
> >> sorry). It is a bug that slipped through when adding bpf_xdp_pointer()
> >> usage. We should always return NULL from this kfunc on error
> >> conditions. Let's fix it separately, but please don't change the
> >> comments.
> >>
> >>>
> >>> I'm generally skeptical of allowing to call kfuncs directly from
> >>> internal kernel code, tbh, and concerns like this are one reason why.
> >>> BPF verifier sets up various conditions that kfuncs have to follow,
> >>> and it seems error-prone to mix this up with internal kernel usage.
> >>>
> >>
> >> Reading bpf_dynptr_slice_rdwr code, it does look exactly like what you
> >> want, despite the confusingly-looking 0, NULL, 0 arguments. So I guess
> >> I'm fine exposing it directly, but it still feels like it will bite us
> >> at some point later.
> >
> > Ok, now I'm at patch #5. Think about what you are doing here. You are
> > asking bpf_dynptr_slice_rdrw() if you can get a directly writable
> > pointer to a data area of length *zero*. So if it's SKB, for example,
> > then yeah, you'll be granted a pointer. But then you are proceeding to
> > write up to sizeof(struct fsverity_digest) bytes, and that can cross
> > into non-contiguous memory.
> >
> > So I'll take it back, let's not expose this kfunc directly to kernel
> > code. Let's have a separate internal helper that will return either
> > valid pointer or NULL for a given dynptr, but will require valid
> > non-zero max size. Something with the signature like below
> >
> > void * __bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len)=
;
> >
> > If ptr can provide a direct pointer to memory of length *len*, great.
> > If not, return NULL. This will be an appropriate internal API for all
> > the use cases you are adding where we will be writing back into dynptr
> > from other kernel APIs with the assumption of contiguous memory
> > region.
>
> Sounds good. Fixing this in the next version.
>
> Thanks,
> Song
>

