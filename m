Return-Path: <bpf+bounces-43834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 856709BA67F
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 16:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0BA281829
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 15:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA76183CBE;
	Sun,  3 Nov 2024 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5Suq9En"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCD818732B
	for <bpf@vger.kernel.org>; Sun,  3 Nov 2024 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730649427; cv=none; b=Nn8f+NtYvSLkV/TzAIN98m1gxiZpue0SO4yRc0Tg6CQCA4mtxv7IkhJbCVN+f6c1fV1Ip1HFCABXnxvwacv4JsKc119RRTCSLGPRoateye52l8HT8jhO3iAT735GOjbKRB35bBcc7nEsRpEyKQnv95aSqbL71RkAxwc6YLZ1/Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730649427; c=relaxed/simple;
	bh=ZhVYs7QyJe+w4Kh9hz3SbGQ2REXcKSZXtXHjMI98yW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuIRDUSy0CkUvd7CEoMBseWD2HWt3Mu+hW+Tge7WZ4nUEPPpiaEoB6k1eh+YZLwS0aYHyyq0tqTHtk6W5FZsQAw0wvM43n3B0tKDvRN/RsFlBYC3Wpxn4FfQAfNki4nnEtO2P5O2TfGBoE3WnKCk2LEQGNQnKhHJBMPLmaTs+RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5Suq9En; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5ced6a3f246so288254a12.3
        for <bpf@vger.kernel.org>; Sun, 03 Nov 2024 07:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730649424; x=1731254224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48pPw1R7EZFKHi7feartMmEfdRdjvRky4f4otg++Kio=;
        b=I5Suq9Enq5xbgwpBc2E/m5SE1ngZ/kc63RZuVsmtCg2UWLXHVm92KuYlDFkrKrqcYT
         Q9VHSS/55Oo9xSZcKptG2sT/l44cnNom5ZOFL3wFpNn55ZwEKiogDud7HNBSnC7iX45T
         H7da4EuzwBQVObPIW3LgJl/m7MNS52tf4lYLalPDq6NQ4iqdUvDaE0kcT0lk4OG4yVI8
         Ze2fMXaNYWGmfbVheKfsnW3qoicV4aJO44mWkGIZS1p3NfaSJu1MbvKOvig3YQ0SGI2v
         xumVF3u8R/VLykMtpvnTGyyHZkyT5MgZTo3vyoiXrfnbNs3Asge6onsEb02UhS5mtZIq
         jyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730649424; x=1731254224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48pPw1R7EZFKHi7feartMmEfdRdjvRky4f4otg++Kio=;
        b=rWDtBv09Xs4bhC5Ue+aE6dhqESphAj5aSxEhRVBXFeiPJHRAjCtwTF5QHJMlstpsoB
         xJWlR3Xr/aG5m676GiAWb4slOKYEtpeAUEOKmMan3W1yb4jt42KqcKmDHgtva31cXCvH
         VAJKXcQ13JfcS4HjuXvgyJmF/EgvV0awjK/3Wt9svH4isddv3RJhgRuhTJtI32YGgNWv
         5AgkHdBJ6yjj47Y4Op58D2KQffKmi+SeZJg87uUyPl1sNfGfJnsq913oRaytmS/ae5nY
         a+ECkirtWoQi0PyMEQ6yrF1abN8eL8QAfylFP/c2XEd0OJuCnmM6cJCwMdl3woL4VbpF
         izSg==
X-Forwarded-Encrypted: i=1; AJvYcCXZtaBGPDczAIonNgPuXRHts7RgT16OtieQO1k80Duv7i2k038GxQ+FCFUr9bql/GQWpXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx4kIRf+8CPytK3M6CoC+DL9tKzmgKstXvBm9TfiXcgYVtBplz
	XBmKH6k7Ti9yNa5sxOV/GweFREW8GYhNUjdXz9CEex+RlaS40ikyFbOGdrckE5VkxF6CWSs1apJ
	bulZR/xE0ODQtwALTogxgaSP2L2M=
X-Google-Smtp-Source: AGHT+IEZXUw/I9G8NyTdmy1FWIBIfgpbot9Jj2wh/jDEnZVX7uUgL08cmQ5SEJgMQRl15lRpMK0V/jpXyoGGB6vHOVw=
X-Received: by 2002:a17:907:3f85:b0:a8a:5ff9:bcd1 with SMTP id
 a640c23a62f3a-a9e65576a5emr870423666b.21.1730649423870; Sun, 03 Nov 2024
 07:57:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101195702.2926731-1-tao.lyu@epfl.ch> <CAADnVQKV=4Dc7e_rFJEYYX1-1HWO9Yzgwb5d2kPnCCzcwUX+_g@mail.gmail.com>
In-Reply-To: <CAADnVQKV=4Dc7e_rFJEYYX1-1HWO9Yzgwb5d2kPnCCzcwUX+_g@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sun, 3 Nov 2024 09:56:27 -0600
Message-ID: <CAP01T77Wu4a4anCfV2O78S-jJBmO8Z53YPsQHYfO1h2yKhLxqA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix incorrect precision backtracking
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Tao Lyu <tao.lyu@epfl.ch>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Hao Luo <haoluo@google.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Nov 2024 at 15:22, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 1, 2024 at 1:04=E2=80=AFPM Tao Lyu <tao.lyu@epfl.ch> wrote:
> >
> > Hi,
> >
> > The process_iter_arg check function misses the type check on the iter
> > args, which leads to any pointer types can be passed as iter args.
> >
> > As the attached testcase shows, when I pass a ptr_to_map_value whose
> > offset is 0, process_iter_arg still regards it as a stack pointer and
> > use its offset to check the stack slot types.
> >
> > In this case, as long as the stack slot types matched with the
> > ptr_to_map_value offset is correct, then checks can be bypassed.
> >
> > I attached the fix, which checks if the argument type is stack pointer.
> >
> > Please let me know if this fix might be incomplete.
> > I'm happy to revise it.
> >
> > Best,
> > Tao
> >
> > Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
> > ---
> >  kernel/bpf/verifier.c                     |  6 ++++++
> >  tools/testing/selftests/bpf/progs/iters.c | 23 +++++++++++++++++++++++
> >  2 files changed, 29 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 797cf3ed32e0..bc968d2b76d9 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -8031,6 +8031,12 @@ static int process_iter_arg(struct bpf_verifier_=
env *env, int regno, int insn_id
> >                 return -EINVAL;
> >         }
> >         t =3D btf_type_by_id(meta->btf, btf_id);
> > +
> > +       // Ensure the iter arg is a stack pointer
>
> no c++ comments pls.
>
> Also I believe Kumar sent a fix for this already.
> It fell through the cracks.
>
> Kumar,
> please resend.

For this one, I didn't. I believe the one you're referring to was a
different bug, and yeah, that appears to have fallen through.
I handed it over to someone and they unfortunately happened to switch
jobs after that.
I'll sync with Tao and one of us will resend the other fix.

Tao,
For this, I think you need to fix your subject line as well, and add a
selftest covering this particular case.
Passing in e.g. a map value should be sufficient to test this behavior.

>
> pw-bot: cr
>
> > +       if (reg->type !=3D PTR_TO_STACK) {
> > +               verbose(env, "iter pointer should be the PTR_TO_STACK t=
ype\n");
> > +               return -EINVAL;
> > +       }

