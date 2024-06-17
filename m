Return-Path: <bpf+bounces-32292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2C690AECA
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 15:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5A4EB23AC6
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 13:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E8019755E;
	Mon, 17 Jun 2024 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b="FDh662+m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835F5194AC7
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630014; cv=none; b=ocfLYKENESxkyRtmAjSzS1D2fRYkHO7gRizBIeytpB6xcC8dojX5+lOeokvlJBpBlEhYZb0Y+wxjCWOqnWdkr3G1uDT3kABgQD75VTDDrNsHDU3Hev1ck5VGSv0qWDmr1cGhCVG+r4H5VHHRQw6uNB8VjaVRRzFby10ZLgGdFrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630014; c=relaxed/simple;
	bh=VPCRp3F4OeanXTuEzx1+sveCYGis5+woWU9DT5ctWPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mruKveBXICZTxptHm6yuq1iIUsRmWYOplFAu3c7WyE6BrTa22Hi2x+789/xK5vHlfcoEjGrV3R1zlIMsMY+qEDv3XNvsLnBd32/vWnB69uCJALLqfmo58Sg+tepyAQiFREYFOmhDttELmGN911UVzn6Kbo4ZjpxjiluTbEVT3jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com; spf=pass smtp.mailfrom=datadoghq.com; dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b=FDh662+m; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datadoghq.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57cc7e85b4bso350589a12.0
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 06:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=datadoghq.com; s=google; t=1718630011; x=1719234811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEdv7Rjn+Z6l2nbU6Wyj+56fuP+24zCQVWnDwkRoqro=;
        b=FDh662+mIw2AOrPOHCobz7XC8eByYTF0NQIW7toPPTynp3IVYoYhIzennIzRfqdumT
         /ojdMwNOaO+gllFWVq8dWuPWthBD4tBz1S+0j8OpqOW2uqdDrMRttQScO09EJOIc8Qiq
         Vg+fLEmCC0zebptxsI33wvRC1/g0Aykxnu4SM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718630011; x=1719234811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEdv7Rjn+Z6l2nbU6Wyj+56fuP+24zCQVWnDwkRoqro=;
        b=wNoVyGhBjd8RZDtyWg6KgjcmHVqPLCeJTAiz5pfQyznpHTHHrd398OtrIClipKThVS
         jvHiEW9vGnKCMMLogup4jmazBMfuEE1YCmXfq8uJint0Vpv14fG3oE7qcAuhkmVogeFg
         HA3bVLki0voG669vIVbxVrRogWuFafBRvCuAVE5YuQZUdwS2suyBJxFX82VUFc1gXp5a
         X9L5tEV5u29iD5wRxncd+NmVsCjMuNg8wa/lRi8cykNJF+YzbRIHnzXYbbcBxb2Y33Gx
         /I+Hq+NWV+LoErDtgFjq+i2LVTy2lV2Ucft2QWUsJnnoCPWDDvF4erYAQrq1K5cG00i9
         7+YA==
X-Forwarded-Encrypted: i=1; AJvYcCUFNpQSyMvNCjfXDxB89A5Fr5JxRbP2mgOhv2i4CE18QRGh4y6/eL8JqNvyPkOZcXr5a25WiW3NP2GSzzYjAR27/qwn
X-Gm-Message-State: AOJu0Yz2xwgUrEbtYgFy/vBHeSuTZ/NC4rVXPAERVuwyGRnJUsQu2L8K
	vSpYmLzFJEhD84dkFD9/np7YpTioRFGfIkG5M6vJ3ewJhN3LNt4KHPLhE39qGCzhc9U9ZQ4bUIO
	32SGxP7SaCOPp2BJcsnzoXTK/m0jaKaRpXKxi+g==
X-Google-Smtp-Source: AGHT+IFAOOzOyHVjZtnCDz+kB7egdNRtH+ZJf9GgPxFYnNpP09dMnWTBwkMzowoG5vE1CkFHJu8kLfWMND0RTMUY64w=
X-Received: by 2002:a50:8d0e:0:b0:57c:53c9:ccc7 with SMTP id
 4fb4d7f45d1cf-57cbd51f37bmr8391538a12.0.1718630010640; Mon, 17 Jun 2024
 06:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOzX8ix3TVUOgNAWkXbK6RAqBCmazgeL=PE-fCV+KZ_HyfLW3Q@mail.gmail.com>
 <CAADnVQJ31p+LCYrHYZd0RisUC_MvU1a8-F+QRiKAJkPw52Edtg@mail.gmail.com>
In-Reply-To: <CAADnVQJ31p+LCYrHYZd0RisUC_MvU1a8-F+QRiKAJkPw52Edtg@mail.gmail.com>
From: Usama Saqib <usama.saqib@datadoghq.com>
Date: Mon, 17 Jun 2024 15:13:19 +0200
Message-ID: <CAOzX8ixsxPbw1ke=DsDd_b38k1TE+JRG3LvJfh4wD60mhHvAqA@mail.gmail.com>
Subject: Re: Why is recursion protection needed in bpf syscalls?
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Song Liu <song@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the information.

> Folks are working on adding htab-like
> protection to other map types and there is an orthogonal effort
> to introduce bpf specific spinlock with run-time deadlock protection
> that bpf maps and progs will use.

A few followup questions regarding this if you don't mind.
1. Would this allow to remove the recursion protection which prevents
kprobes and tracepoints from nesting?
2. What exactly is the reason for using a per-cpu bpf_prog_active to
perform recursion protection for kprobes and tracepoints, as opposed
to the more granular approach taken by raw_tracepoints or
bpf_trampolines?
    2a. Is nesting protection required at all for raw_tracepoints?
Atleast for raw_tracepoints the protection seems to have been
introduced to address the WARN_ON_ONCE when the allowed nesting level
in try_get_fmt_tmp_buf() is exceeded? Why not just remove the warning
if nesting is possible and expected?

Thanks,
Usama Saqib.



On Fri, Jun 14, 2024 at 10:00=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 12, 2024 at 3:38=E2=80=AFAM Usama Saqib <usama.saqib@datadogh=
q.com> wrote:
> >
> > Hello,
> >
> > Some map operations via syscalls on hash maps (and some others)
> > disable bpf programs from running on the same CPU with
> > bpf_disable_instrumentation. The provided reason for this is to
> > prevent deadlocks when a nested bpf program tries to access an already
> > held bucket lock. From my understanding, this can happen due to a
> > kprobe on a function called after the lock is acquired. However,
> > htab_lock_bucket already handles this case by returning EBUSY if such
> > a scenario were to happen. Is there any other reason for disabling bpf
> > programs on the CPU?
>
> Correct. bpf_disable_instrumentation() is a mechanism to prevent
> bpf-kprobe progs being invoked from the inner places of bpf maps.
> htab has a separate protection via htab_lock_bucket.
> array map doesn't need such thing, but there are other map types.
> disable_instrumentation() is mainly for those.
>
> > The effect of this is that 1) bpf programs attached to a kprobe or
> > tracepoint in an irq context get skipped while inside
> > bpf_[enable,disable]_instrumentation block but before the
> > preempt_disable via htab_lock_bucket, 2) when CONFIG_PREEMPTION=3Dy and
> > preempt=3Dfull then a bpf program running from user context may also ge=
t
> > skipped while inside the bpf_[enable,disable]_instrumentation block.
>
> Yes. It is unfortunate. Folks are working on adding htab-like
> protection to other map types and there is an orthogonal effort
> to introduce bpf specific spinlock with run-time deadlock protection
> that bpf maps and progs will use.
> Once it's available this disable_instrumention logic can be lifted.

