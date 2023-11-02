Return-Path: <bpf+bounces-14010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCC47DFAAC
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 20:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D321F2204B
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 19:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CF621353;
	Thu,  2 Nov 2023 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRdqVq7j"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDDE1CFB6
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 19:07:06 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15BF136
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 12:07:03 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso199161966b.0
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 12:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698952022; x=1699556822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dx8cpcmrOZxzhEqxNTxc4dvmHYweBXWx1RB8KilgMfE=;
        b=eRdqVq7j6jmC1Ctu0ZmZ2cwMXXD6h/Uu0+i7+JF1dcVXr9LoHyPHRwU/g7MRZUUWXT
         E3gcyghcgrRWMikU3bAY0FvMZ7cjoTM9iYR27bHzFOQLnqjbjsVFNt2lg0cxqcA9HXbN
         XY7zQoUxuH9uUEgyUoiwFiIYYvyJdcr7N/ZOF28EQexefey7+SXdLiuJcxEb0a2d21M5
         PoTZ01WHpDFnhyweeLF3h6eDg5Ak8LikmvjomxeBssvEpVXXB7aVDAvYBOIMc+S0LTnJ
         famvlxFPHSiJdx1tmjXIDFiOALrOAAC+N51hrgsXX6vE9rUZx6rDOUpW02pQ8Si95KfB
         g+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698952022; x=1699556822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dx8cpcmrOZxzhEqxNTxc4dvmHYweBXWx1RB8KilgMfE=;
        b=OFitxehxw8fMhf1i71miul2U9CHOrf4iv9JHjit+H4XvaEhpndwb/WbyN6LIP4Nr7M
         fXVKHQV9SVtJUKuVIZcmqTdgeSqFub66eU5Dqk1nwnnJlC1OXzV/dsfSOabnuFFDTpgr
         kYhMWWPpFPvfxX/2ZvTWywRP2mV67+Ffoupk5mfgH59eQSMU1TLsmQ9rG2orMz70U42R
         b18Hof6IKiYRzx/N5jyX/H/IkncF0lJ60qMkXxzyleT7wZ7XRksmW4/7MrMOe1sbEkmz
         fThlsTIsp+46h0xYQG5ytoJu8SffJxQXeXLv/1p9F98EzXQ65eoosinKSiJGi49YJjVX
         tWtg==
X-Gm-Message-State: AOJu0YwesCegfarag8LhM596Ag4cdZpkYsPPJZ563R+w7vWaK5TVGAap
	jgCjnVlPVqRXoaVTxaDY9yvChFSiktgAbpzqSzo=
X-Google-Smtp-Source: AGHT+IElS1HrxuD4m483T6kr3C2TOa9PyL5ja4nYdmkgG6cBBrGv5ayN5G2qNcof/Q5ycn4VImku5ADxwN+WZfCdTpA=
X-Received: by 2002:a17:906:4705:b0:9a1:abae:8d30 with SMTP id
 y5-20020a170906470500b009a1abae8d30mr3899114ejq.47.1698952021693; Thu, 02 Nov
 2023 12:07:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024235551.2769174-1-song@kernel.org> <20231024235551.2769174-2-song@kernel.org>
 <CAEf4Bzbr8dgksh2z+4nEkAFdV9gquhR+HROULKdTkWrUpSM9-Q@mail.gmail.com>
 <CAEf4BzbDFDX30Y_Hcmd__hgDp+m6X+htr-wTeBtaoauEnrEdLw@mail.gmail.com>
 <CAEf4BzaD+FV_PM8_4yWnZVed9pXE-KX6CwpYEmiUDpMRQDNEXQ@mail.gmail.com>
 <15A85D6B-56E5-4C9F-B7AB-A62F3DA8294C@fb.com> <B1DDF0D9-5365-4421-83AF-E7F6C0439422@fb.com>
In-Reply-To: <B1DDF0D9-5365-4421-83AF-E7F6C0439422@fb.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 Nov 2023 12:06:50 -0700
Message-ID: <CAEf4BzY_aW0-Ao9vaYoRJ=A3b2=VYqyAX--4UK6CYv7QGAjzgg@mail.gmail.com>
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

On Thu, Nov 2, 2023 at 11:16=E2=80=AFAM Song Liu <songliubraving@meta.com> =
wrote:
>
>
>
> > On Nov 2, 2023, at 11:09=E2=80=AFAM, Song Liu <songliubraving@meta.com>=
 wrote:
> >
> >
> >
> >> On Nov 2, 2023, at 10:16=E2=80=AFAM, Andrii Nakryiko <andrii.nakryiko@=
gmail.com> wrote:
> >>
> >> On Thu, Nov 2, 2023 at 10:09=E2=80=AFAM Andrii Nakryiko
> >> <andrii.nakryiko@gmail.com> wrote:
> >>>
> >>> On Thu, Nov 2, 2023 at 9:56=E2=80=AFAM Andrii Nakryiko
> >>> <andrii.nakryiko@gmail.com> wrote:
> >>>>
> >>>> On Tue, Oct 24, 2023 at 4:56=E2=80=AFPM Song Liu <song@kernel.org> w=
rote:
> >>>>>
> >>>>> kfuncs bpf_dynptr_slice and bpf_dynptr_slice_rdwr are used by BPF p=
rograms
> >>>>> to access the dynptr data. They are also useful for in kernel funct=
ions
> >>>>> that access dynptr data, for example, bpf_verify_pkcs7_signature.
> >>>>>
> >>>>> Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr to bpf.h so that ker=
nel
> >>>>> functions can use them instead of accessing dynptr->data directly.
> >>>>>
> >>>>> Update bpf_verify_pkcs7_signature to use bpf_dynptr_slice instead o=
f
> >>>>> dynptr->data.
> >>>>>
> >>>>> Also, update the comments for bpf_dynptr_slice and bpf_dynptr_slice=
_rdwr
> >>>>> that they may return error pointers for BPF_DYNPTR_TYPE_XDP.
> >>>>>
> >>>>> Signed-off-by: Song Liu <song@kernel.org>
> >>>>> ---
> >>>>> include/linux/bpf.h      |  4 ++++
> >>>>> kernel/bpf/helpers.c     | 16 ++++++++--------
> >>>>> kernel/trace/bpf_trace.c | 15 +++++++++++----
> >>>>> 3 files changed, 23 insertions(+), 12 deletions(-)
> >>>>>
> >>>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >>>>> index b4825d3cdb29..3ed3ae37cbdf 100644
> >>>>> --- a/include/linux/bpf.h
> >>>>> +++ b/include/linux/bpf.h
> >>>>> @@ -1222,6 +1222,10 @@ enum bpf_dynptr_type {
> >>>>>
> >>>>> int bpf_dynptr_check_size(u32 size);
> >>>>> u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
> >>>>> +void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offs=
et,
> >>>>> +                      void *buffer__opt, u32 buffer__szk);
> >>>>> +void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32=
 offset,
> >>>>> +                           void *buffer__opt, u32 buffer__szk);
> >>>>>
> >>>>> #ifdef CONFIG_BPF_JIT
> >>>>> int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bp=
f_trampoline *tr);
> >>>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >>>>> index e46ac288a108..af5059f11e83 100644
> >>>>> --- a/kernel/bpf/helpers.c
> >>>>> +++ b/kernel/bpf/helpers.c
> >>>>> @@ -2270,10 +2270,10 @@ __bpf_kfunc struct task_struct *bpf_task_fr=
om_pid(s32 pid)
> >>>>> * bpf_dynptr_slice will not invalidate any ctx->data/data_end point=
ers in
> >>>>> * the bpf program.
> >>>>> *
> >>>>> - * Return: NULL if the call failed (eg invalid dynptr), pointer to=
 a read-only
> >>>>> - * data slice (can be either direct pointer to the data or a point=
er to the user
> >>>>> - * provided buffer, with its contents containing the data, if unab=
le to obtain
> >>>>> - * direct pointer)
> >>>>> + * Return: NULL or error pointer if the call failed (eg invalid dy=
nptr), pointer
> >>>>
> >>>> Hold on, nope, this one shouldn't return error pointer because it's
> >>>> used from BPF program side and BPF program is checking for NULL only=
.
> >>>> Does it actually return error pointer, though?
> >
> > Right. kfunc should not return error pointer.
> >
> >>>
> >>> So I just checked the code (should have done it before replying,
> >>> sorry). It is a bug that slipped through when adding bpf_xdp_pointer(=
)
> >>> usage. We should always return NULL from this kfunc on error
> >>> conditions. Let's fix it separately, but please don't change the
> >>> comments.
> >>>
> >>>>
> >>>> I'm generally skeptical of allowing to call kfuncs directly from
> >>>> internal kernel code, tbh, and concerns like this are one reason why=
.
> >>>> BPF verifier sets up various conditions that kfuncs have to follow,
> >>>> and it seems error-prone to mix this up with internal kernel usage.
> >>>>
> >>>
> >>> Reading bpf_dynptr_slice_rdwr code, it does look exactly like what yo=
u
> >>> want, despite the confusingly-looking 0, NULL, 0 arguments. So I gues=
s
> >>> I'm fine exposing it directly, but it still feels like it will bite u=
s
> >>> at some point later.
> >>
> >> Ok, now I'm at patch #5. Think about what you are doing here. You are
> >> asking bpf_dynptr_slice_rdrw() if you can get a directly writable
> >> pointer to a data area of length *zero*. So if it's SKB, for example,
> >> then yeah, you'll be granted a pointer. But then you are proceeding to
> >> write up to sizeof(struct fsverity_digest) bytes, and that can cross
> >> into non-contiguous memory.
>
> By the way, the syntax and comment of bpf_dynptr_slice() is confusing:
>
>  * @buffer__opt: User-provided buffer to copy contents into.  May be NULL
>  * @buffer__szk: Size (in bytes) of the buffer if present. This is the
>  *               length of the requested slice. This must be a constant.
>
> It reads (to me) as, "if buffer__opt is NULL, buffer__szk should be 0".
>
> Is this just my confusion, or is there a real issue?

It's a bit confusing, but no, that size needs to be a "how much data
do I want to read/write", so even if buffer is NULL, size has to be
specified.

"This is the length of the requested slice." is the most important
part in that comment.

>
> Thanks,
> Song
>
>
> >>
> >> So I'll take it back, let's not expose this kfunc directly to kernel
> >> code. Let's have a separate internal helper that will return either
> >> valid pointer or NULL for a given dynptr, but will require valid
> >> non-zero max size. Something with the signature like below
> >>
> >> void * __bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len=
);
> >>
> >> If ptr can provide a direct pointer to memory of length *len*, great.
> >> If not, return NULL. This will be an appropriate internal API for all
> >> the use cases you are adding where we will be writing back into dynptr
> >> from other kernel APIs with the assumption of contiguous memory
> >> region.
> >
>

