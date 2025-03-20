Return-Path: <bpf+bounces-54505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C31A6B189
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 00:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397E1189FFF8
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 23:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7400F229B2C;
	Thu, 20 Mar 2025 23:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jF6s7WOU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BA321CFEC
	for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 23:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742512873; cv=none; b=uBgGA6jHhTTn4ApmSW8is3ijKWBInUUVjJNFM5rvtm81gA5kXP7hF7l8PcRk4QALwfC3prS6LOJAhLxk01XdOz0D3NsXWaJPrcH9AdhmV4FEUSKDOTccXjbDjQrPPWpjoH2O84poLO758eIn/lOw+g9iJgeQ7cinKN5YYjgU+yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742512873; c=relaxed/simple;
	bh=HNDs9xwZf7XdzOnDym0SAXNIQcJAghsNxXW/eN2Nhfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCF6RrGniKZ6qb0h1Q4FPBvNJQ8rBGRgqrrAlVoaj/shKYPoFBr6jfEbOtlBxHkWhag/Ookp5EgEiWTNfvORtvAG5PWSOLakMbaiKKDAFmwqsq17a4rexw56gAwujJM6hQzDJO9J5yPvbgcuHxEpJS1dIG/HIG+x/RL8hBNYOgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jF6s7WOU; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6f6ca9a3425so15480707b3.2
        for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 16:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742512870; x=1743117670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnNJ7f0uE36qRhrkDTYf1brLu1gXLwWqzAQmFxHP06Y=;
        b=jF6s7WOUDKYxZQ5ytPZwpva30fHyoO7OB6V7siYY/4udb5SyaDbH6/OsGsqs5AMhK8
         Zx6tabEKXGjb7uPtYfJvih8MBbhez+5CYtpB0vVOqs/M51icKwejRT46t6p4wKxVNzRB
         HVywh06hfy0t0VsIoxphIFQ8XrEMJXVfJ2AIw1wCrM8nj1D4KIEvNFcHcfH2KBDNlc2F
         /QJgbJals2JYS5DlsPLM7YFceh0Ti8YYJwjQrAJl/j6mnMndCz8uKjxDbnULc+7GGnQb
         q4u3flLIIwnAnDgfoCfpp2O089hA3nronlV6nnWnbOx3Q9v6ibGTFcRIZe5hCFPJWo4o
         Azdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742512870; x=1743117670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnNJ7f0uE36qRhrkDTYf1brLu1gXLwWqzAQmFxHP06Y=;
        b=Zx8LwqqbcJpWkbKhBKLL3Cy3yM9T3oGq5XLhac3kIWqAkM6dbuRlGYyATrtuH6y3AY
         mbQv7WyKSIPAVvftA2LtqxFlz4Vuh/OdSO7UHpuFrRR4jbKHWCgaXoZMMmBBdbLDr1OU
         v/uvh1DEVe42hseHHlcHQ6BesiTUGCcj2jDBnmitzyOoHflr8co5Ctm1qJAMxJ3aFAgD
         xudMTZYSI3i/K51VcioOv/lScz65+w/skzSPE6CzEKicgan2a4CFySjjsWM9e4Z32AID
         AGR4u7kaRlPhGfBwiJoHZ/6gW0NWZNdpq2HW/1NMRjlawJWS4+cferkJYJHIVoxkHkWY
         zr5Q==
X-Gm-Message-State: AOJu0Yw98eKaJFNrMTQndhulJb+mIbtGMLxcnnVViWbAoVvd+yUtVa+s
	ITJoIXVODX04tLH8U7ibY6jYu1SIXDD398+uB+vqDXTds0AbDvoEEcZVxZ98Ep1zg/3WY5FZb/N
	2oOlweKj2siU75s7IrdyMf1lbIj2SPxlD
X-Gm-Gg: ASbGncshHr7ohR/ymMfu+TcePtoToppeqWB3uooab+omGqUmpBdtlm7efPoIlKrQSUY
	2byfmzRoXMiaB9uxoguXRPbBNgHN2ELjsBxY+xE6OgQnrSiEwcP9f2JlyYCnXd8TRdageNgrO2G
	GGp406Tkv9OxhJY30dLjQr+osIiQ==
X-Google-Smtp-Source: AGHT+IE4Z5S1sBoaBGmLTcZNBAC5chY7Pt/+FFXjPmIDWInt7gmiTj8gIUWL/9Z5qIruIVNWLarokwD0Q+c7KrDnxhw=
X-Received: by 2002:a05:690c:7089:b0:6fd:25dc:effe with SMTP id
 00721157ae682-700bacd54damr16626707b3.25.1742512870176; Thu, 20 Mar 2025
 16:21:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320214058.2946857-1-ameryhung@gmail.com> <20250320214058.2946857-2-ameryhung@gmail.com>
 <CAEf4Bza-WiBjEEhtk-kXCjrkP_d5_-mGpezqm6_S+qiuDoEc1g@mail.gmail.com>
In-Reply-To: <CAEf4Bza-WiBjEEhtk-kXCjrkP_d5_-mGpezqm6_S+qiuDoEc1g@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 20 Mar 2025 16:20:59 -0700
X-Gm-Features: AQ5f1JrbU3zSWRzbHUXf-g2XAL_0v-kITnJxvnUiXSWk-p9sgwh5D-Cvn0SuzSE
Message-ID: <CAMB2axNZtBaWSE+LPTNU8hO-VyBRj=w0JiJnhSLosOyts1nSuw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] bpf: Allow creating dynptr from uptr
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 3:45=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Mar 20, 2025 at 2:41=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > Currently, bpf_dynptr_from_mem() only allows creating dynptr from local
> > memory of reg type PTR_TO_MAP_VALUE, specifically ringbuf. This patch
> > futher supports PTR_TO_MEM as a valid source of data.
> >
> > For a reg to be PTR_TO_MEM in the verifier:
> >  - read map value with special field BPF_UPTR
> >  - ld_imm64 kfunc (MEM_RDONLY)
> >  - ld_imm64 other non-struct ksyms (MEM_RDONLY)
> >  - return from helper with RET_PTR_TO_MEM: ringbuf_reserve (MEM_RINGBUF=
)
> >    and dynptr_from_data
> >  - return from helper with RET_PTR_TO_MEM_OR_BTF_ID: this_cpu_ptr,
> >    per_cpu_ptr and the return type is not struct (both MEM_RDONLY)
> >  - return from special kfunc: dynptr_slice (MEM_RDONLY), dynptr_slice_r=
dwr
> >  - return from non-special kfunc that returns non-struct pointer:
> >    hid_bpf_get_data
> >
> > Since this patch only allows PTR_TO_MEM without any flags, so only uptr=
,
> > global subprog argument, non-special kfunc that returns non-struct ptr,
> > return of bpf_dynptr_slice_rdwr() and bpf_dynptr_slice_rdwr() will be a=
llowed
> > additionally.
> >
> > The last two will allow creating dynptr from dynptr data. Will they cre=
ate
> > any problem?
>
> Yes, I think so. You need to make sure that dynptr you created from
> that PTR_TO_MEM is invalidated if that memory "goes away". E.g., for
> ringbuf case:
>
> void *r =3D bpf_ringbuf_reserve(..., 100);
>
> struct dynptr d;
> bpf_dynptr_from_mem(r, 100, 0, &d);
>

^ This will fail during verification because "r" will be PTR_TO_MEM |
MEM_RINGBUF.

Only five of the listed PTR_TO_MEM cases will be allowed with this
patch additionally: uptr, global subprog argument, hid_bpf_get_data,
bpf_dynptr_ptr_data and bpf_dynptr_slice_rdwr. For the former three,
the memory seems to be valid all the time. For the last two, IIUC,
bpf_dynptr_data or bpf_dynptr_slice_rdwr should be valid if null
checks pass. I am just so not sure about the nested situation (i.e.,
creating another dynptr from data behind a dynptr).

Thanks,
Amery

> void *p =3D bpf_dynptr_data(&d, 0, 100);
> if (!p) return 0; /* can't happen */
>
> bpf_ringbuf_submit(r, 0);
>
>
> *(char *)p =3D '\0'; /* bad things happen */
>
>
> Do you handle that situation? With PTR_TO_MAP_VALUE "bad things" can't
> happen even if value is actually deleted/reused (besides overwriting
> some other element's value, which we can do without dynptrs anyways),
> because that memory won't go away due to RCU and it doesn't contain
> any information important for correctness (ringbuf data area does have
> it).
>
>
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  include/uapi/linux/bpf.h | 4 +++-
> >  kernel/bpf/verifier.c    | 3 ++-
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index beac5cdf2d2c..2b1335fa1173 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -5562,7 +5562,9 @@ union bpf_attr {
> >   *     Description
> >   *             Get a dynptr to local memory *data*.
> >   *
> > - *             *data* must be a ptr to a map value.
> > + *             *data* must be a ptr to valid local memory such as a ma=
p value, a uptr,
> > + *             a null-checked non-void pointer pass to a global subpro=
gram, and allocated
> > + *             memory returned by a kfunc such as hid_bpf_get_data(),
> >   *             The maximum *size* supported is DYNPTR_MAX_SIZE.
> >   *             *flags* is currently unused.
> >   *     Return
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 22c4edc8695c..d22310d1642c 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -11307,7 +11307,8 @@ static int check_helper_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn
> >                 }
> >                 break;
> >         case BPF_FUNC_dynptr_from_mem:
> > -               if (regs[BPF_REG_1].type !=3D PTR_TO_MAP_VALUE) {
> > +               if (regs[BPF_REG_1].type !=3D PTR_TO_MAP_VALUE &&
> > +                   regs[BPF_REG_1].type !=3D PTR_TO_MEM) {
> >                         verbose(env, "Unsupported reg type %s for bpf_d=
ynptr_from_mem data\n",
> >                                 reg_type_str(env, regs[BPF_REG_1].type)=
);
> >                         return -EACCES;
> > --
> > 2.47.1
> >

