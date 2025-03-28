Return-Path: <bpf+bounces-54872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A254DA75097
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 19:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9951740C4
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 18:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CF71E1A3F;
	Fri, 28 Mar 2025 18:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVSfusWE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF39122094
	for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743188386; cv=none; b=jPcZQOcyxIeALaBs27kAibWxbON6GM0O3npa7L4zzh6rMl3MP5sHDmTjg44WTgD9F8FnX8wMknWPuhmEtvPr1cvH+zf2OhchvX43Z4Xktz+flCDolx5w4J7tC5xmY14POUe1B77PY8pn1pH1CRQFXFBshYEXmfWM6VAPTVcRbC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743188386; c=relaxed/simple;
	bh=s2pkKEZl9HPF4ZT4QEk60RCcbTE70NTojCm1+RewEZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pe+hVKnIm1yR+HCwBsFCvIO+fVcNFzNCjiNONGw8n8GSxw7UKGU6seUdIjRAw8VdQDBVyFHFGS1cU7fGP+m3J7fNPR1l1e+ieEMaEGoX3LrmCZWswYtl7vocSDqu+v+1xaslQ49nn+9OksYO8il4bvJduRUHmZpsHBii+Q2KD0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVSfusWE; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-30384072398so3488456a91.0
        for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 11:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743188383; x=1743793183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+lzyDRRjbJyrszRoHHA/+rRBw4PCxAnFSdOUww3xHo=;
        b=PVSfusWEbz8KHJh9w21iCQTW0ypKbksSLTy6bXzkkfQzFhCjkrjRro0Xr9QDMSYw8N
         qZgRCEYZ7cEGfZTWRy/37VBP0ehnvLooo1s3PHJKhqWZWzUhjD0Vukt+GzFGsrKe9mbo
         1emu3b6ufJ0MvmPxjz811xE3xIePkP3hN+hf3W8BUeYDUqRZ8os4171u4S8uEAdo5cVq
         I1ZkzkjVvUWiX7DxZ7Itbe3cjrDN2jisnTfYOs/u24wfrgw4ogz8rXWzoftrgzHLWo9c
         Q9C3iZujbkR5VBCxe1ShZ1PPcHD250kkdJW7VsIlhBqVmdb0LRHsuAJEalkTIUW66KVc
         596w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743188383; x=1743793183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+lzyDRRjbJyrszRoHHA/+rRBw4PCxAnFSdOUww3xHo=;
        b=pRPgwQa2VR0yHdcN027VgaiVvbd8GeH+hVCHnHJLghhjIEU3tced00Z8sf89vmLSnj
         YrPzWeLLL5StgD/oS/lRaxJkJLpIf1AowU8TRiKR+vSqE8QBE65ZPQwA2Bb1/jJRwQCD
         amVhiggalTS6lI9/36ECEELA1sCB87cCCG0IE6zgoBpVWZfo2yUh3wErEkxM0QV+i8ta
         yY5PG5ixk8P8dSRAhpfn+udOrGrdB8WhRpBORSbFr47GMRjqIFx2+YdLtTB6P03XkBTY
         VmY7cN1DnEJ2ju1vUDT2Y2DDKkQuPwBJqwAHyNB85a0Vg7GHLVj8kjWdE3qbyL84JKql
         JDgw==
X-Gm-Message-State: AOJu0Yx0GTKKTME+wC7NjyOyhcZsC0XRTf7ixkX+EnpxCbq93IAciSF7
	nQ+tpIBmQ/JdtMtEPQsXkBl6DHJdXaTntUdi88xpvL3OVKM6KwFH6Ut96usvVIrnXOdCGnT0HE0
	93UvTgv5ILf6FqkcDxRlWIfqNhsc=
X-Gm-Gg: ASbGnctmI6rwsb92162UgJpoVt9giwF6kLlMD1vtk8pibnL58zNqxgkenlwjj47UNrx
	+dTwfSjghLudKTbsjAbCPanB8p1ZuCbQ6UxUelUl2f1AxFXfum4anT5b5iJpj8OXFKKHnvuZGTQ
	S0F6lllFKefar6VtpmLPHHwZzOY53DjWSOGVVc95lJwA==
X-Google-Smtp-Source: AGHT+IHJN/Ap20TStuWs8qq5nFZqaOzowEEQjAELpMQKYzXIHSOfvCbhFkyAxJU4IlMG8SMbJFJXZGhwRj8xungEMDQ=
X-Received: by 2002:a17:90b:4b06:b0:2ff:4a8d:74f8 with SMTP id
 98e67ed59e1d1-30531f78cccmr506529a91.6.1743188382647; Fri, 28 Mar 2025
 11:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320214058.2946857-1-ameryhung@gmail.com> <20250320214058.2946857-2-ameryhung@gmail.com>
 <CAEf4Bza-WiBjEEhtk-kXCjrkP_d5_-mGpezqm6_S+qiuDoEc1g@mail.gmail.com> <CAMB2axNZtBaWSE+LPTNU8hO-VyBRj=w0JiJnhSLosOyts1nSuw@mail.gmail.com>
In-Reply-To: <CAMB2axNZtBaWSE+LPTNU8hO-VyBRj=w0JiJnhSLosOyts1nSuw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Mar 2025 11:59:30 -0700
X-Gm-Features: AQ5f1JrByWkov1ShUBOX_CqU7F5h0VS2DhBb3Cjz9URfezXhAecHktCLCQkafhM
Message-ID: <CAEf4Bzb5mWBSPGaUppU8fs-B73YbzrsdEPreA7kZvcD=W9SR_Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] bpf: Allow creating dynptr from uptr
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 4:21=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Thu, Mar 20, 2025 at 3:45=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Mar 20, 2025 at 2:41=E2=80=AFPM Amery Hung <ameryhung@gmail.com=
> wrote:
> > >
> > > Currently, bpf_dynptr_from_mem() only allows creating dynptr from loc=
al
> > > memory of reg type PTR_TO_MAP_VALUE, specifically ringbuf. This patch
> > > futher supports PTR_TO_MEM as a valid source of data.
> > >
> > > For a reg to be PTR_TO_MEM in the verifier:
> > >  - read map value with special field BPF_UPTR
> > >  - ld_imm64 kfunc (MEM_RDONLY)
> > >  - ld_imm64 other non-struct ksyms (MEM_RDONLY)
> > >  - return from helper with RET_PTR_TO_MEM: ringbuf_reserve (MEM_RINGB=
UF)
> > >    and dynptr_from_data
> > >  - return from helper with RET_PTR_TO_MEM_OR_BTF_ID: this_cpu_ptr,
> > >    per_cpu_ptr and the return type is not struct (both MEM_RDONLY)
> > >  - return from special kfunc: dynptr_slice (MEM_RDONLY), dynptr_slice=
_rdwr
> > >  - return from non-special kfunc that returns non-struct pointer:
> > >    hid_bpf_get_data
> > >
> > > Since this patch only allows PTR_TO_MEM without any flags, so only up=
tr,
> > > global subprog argument, non-special kfunc that returns non-struct pt=
r,
> > > return of bpf_dynptr_slice_rdwr() and bpf_dynptr_slice_rdwr() will be=
 allowed
> > > additionally.
> > >
> > > The last two will allow creating dynptr from dynptr data. Will they c=
reate
> > > any problem?
> >
> > Yes, I think so. You need to make sure that dynptr you created from
> > that PTR_TO_MEM is invalidated if that memory "goes away". E.g., for
> > ringbuf case:
> >
> > void *r =3D bpf_ringbuf_reserve(..., 100);
> >
> > struct dynptr d;
> > bpf_dynptr_from_mem(r, 100, 0, &d);
> >
>
> ^ This will fail during verification because "r" will be PTR_TO_MEM |
> MEM_RINGBUF.

We discussed all this at LSFMMBPF2025, but for those who follow and
didn't attend, we can just slightly modify the example by adding one
extra bpf_dynptr_slice() constructed from r:


void *r =3D bpf_ringbuf_reserve(..., 100);
void *m =3D bpf_dynpt_slice(&r, ...);
if (!m) return 0; /* shouldn't happen */

struct dynptr d;
bpf_dynptr_from_mem(m, 100, 0, &d);

void *p =3D bpf_dynptr_data(&d, 0, 100);
if (!p) return 0; /* can't happen */

bpf_ringbuf_submit(r, 0);

*(char *)p =3D '\0'; /* bad things happen */


And we can keep building this long chain of dependencies. So we'd need
to take all that into account and propagate invalidation across entire
tree of dependencies between dynptrs and slices.

>
> Only five of the listed PTR_TO_MEM cases will be allowed with this
> patch additionally: uptr, global subprog argument, hid_bpf_get_data,
> bpf_dynptr_ptr_data and bpf_dynptr_slice_rdwr. For the former three,
> the memory seems to be valid all the time. For the last two, IIUC,
> bpf_dynptr_data or bpf_dynptr_slice_rdwr should be valid if null
> checks pass. I am just so not sure about the nested situation (i.e.,
> creating another dynptr from data behind a dynptr).
>
> Thanks,
> Amery
>
> > void *p =3D bpf_dynptr_data(&d, 0, 100);
> > if (!p) return 0; /* can't happen */
> >
> > bpf_ringbuf_submit(r, 0);
> >
> >
> > *(char *)p =3D '\0'; /* bad things happen */
> >
> >
> > Do you handle that situation? With PTR_TO_MAP_VALUE "bad things" can't
> > happen even if value is actually deleted/reused (besides overwriting
> > some other element's value, which we can do without dynptrs anyways),
> > because that memory won't go away due to RCU and it doesn't contain
> > any information important for correctness (ringbuf data area does have
> > it).
> >
> >
> > >
> > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > ---
> > >  include/uapi/linux/bpf.h | 4 +++-
> > >  kernel/bpf/verifier.c    | 3 ++-
> > >  2 files changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index beac5cdf2d2c..2b1335fa1173 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -5562,7 +5562,9 @@ union bpf_attr {
> > >   *     Description
> > >   *             Get a dynptr to local memory *data*.
> > >   *
> > > - *             *data* must be a ptr to a map value.
> > > + *             *data* must be a ptr to valid local memory such as a =
map value, a uptr,
> > > + *             a null-checked non-void pointer pass to a global subp=
rogram, and allocated
> > > + *             memory returned by a kfunc such as hid_bpf_get_data()=
,
> > >   *             The maximum *size* supported is DYNPTR_MAX_SIZE.
> > >   *             *flags* is currently unused.
> > >   *     Return
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 22c4edc8695c..d22310d1642c 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -11307,7 +11307,8 @@ static int check_helper_call(struct bpf_verif=
ier_env *env, struct bpf_insn *insn
> > >                 }
> > >                 break;
> > >         case BPF_FUNC_dynptr_from_mem:
> > > -               if (regs[BPF_REG_1].type !=3D PTR_TO_MAP_VALUE) {
> > > +               if (regs[BPF_REG_1].type !=3D PTR_TO_MAP_VALUE &&
> > > +                   regs[BPF_REG_1].type !=3D PTR_TO_MEM) {
> > >                         verbose(env, "Unsupported reg type %s for bpf=
_dynptr_from_mem data\n",
> > >                                 reg_type_str(env, regs[BPF_REG_1].typ=
e));
> > >                         return -EACCES;
> > > --
> > > 2.47.1
> > >

