Return-Path: <bpf+bounces-73495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F49C32C86
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 20:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F88B3B2338
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 19:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5E82D77E2;
	Tue,  4 Nov 2025 19:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFNXpq42"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16C421ABC9
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284561; cv=none; b=C0JFUTCOEIb8RZxAu0uUiC75PLsfTRrtdsmFNmy/436KR3CfcZVGc2znSmz3C9Cylswnm0XGE6evpeaseWU/ro9cMmuf/HXhv4v2wqsvPJ9aZ/gVI/3ag0MpSnbolu8p+23rveYhyfothVrJL0tM56qOJKDqZLlREGgW7DQqeLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284561; c=relaxed/simple;
	bh=SVpvND3Opb4lIXVJkJyppCGAKbL30F9uNMosYms8eNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acrtnFQJ3C21Lir6qDa+WXUj7Ud4AOvZvC/JaqD37UWsDka2SUsIgkr0QLgpfl+yM7uG9eTwoYWeVPEma6Ei9OmbIRH6PMdiV2EhFHE1WXpkpPxoRmydYZkMm8t/8rGA0/vMxdsOE3ffk2iFbo7b57wHn6CHP1tVJ5LxYI3rZog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFNXpq42; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7ae1557db07so160404b3a.0
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 11:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762284559; x=1762889359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4+Qy4se2CoYDcbISDYsRrV4DHRxq/+P+IzxGTvSQOU=;
        b=fFNXpq421wfSxhl9MDprg3jLhD+hoaEuVkTpbmj1IOTDD9kzgsGwL2WcihRwjiysLv
         He31fh2a2LRFDnhqdno25f86r0o+W5FiU76oU6DOVCrl8DCqyBUWBXa3AAhAGBuh5g5l
         XkKxneT1g8aycgNSFPWHSysXSbpi19D/c1jiDwfeqMrg+cGklGEHLYjz4mv575rx7I0+
         93BVaVs/3E6L8ckpLdTQcbqDd7WkB94eX9vyF3yxsdfeINAsmbBALAuAsub62i9moAHF
         jY8wY4sJQdSUxfyYHzbHCCkQ6Y64NLbQwnjbSP0hIlWjANvjw5KX3yY0iy149UYVfsYh
         SknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762284559; x=1762889359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4+Qy4se2CoYDcbISDYsRrV4DHRxq/+P+IzxGTvSQOU=;
        b=sYspjDAMiUbO8bzWFCh+XmF7TSX/zh/sT6xmG31Grs+Sam+5m862gIiAOnT+JTLocg
         cYyY6kX7ro1wyud0OdelyoBpugwBHXnwBqTN3RmXZbk4F4V8HlFfFmoT+SJF6q+nEzGb
         vp9t21zzH9WaQJCL9GLD49vqgv1B7E1UPYCRrT+orxe7ZqPdQdoX+35T4Mdc0rfxYbD2
         FUS7+8/BCA0tpju1MJKC/92s70bEdEcbGuSlYhJvxbVreiyrhtuWSqiwkDquMiodkQjM
         SJppSO302wld21dupQOtCyGf1qDos2u3mW3M6MQiDETbSPLTJOfLchM40rNlOwxumIrT
         nWxw==
X-Forwarded-Encrypted: i=1; AJvYcCVec3RFI8tyjoPnFawo2PgCgtYTE0ztNM/v7/rLxk/H2AH0CrFSC+R9IcQtyGsq4v7sa3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXfW58gl0cgnRQ9/mXv4s30iAu/RAYdJCawrGiPAxxvsp/Smzk
	bROo/JhXbeKUOD6p4B6yU+fIPMvN6VCHD7p+xMi8aPY7NKUSIZsMoKS+aQTxKaJaayTwHb7DCQ+
	BYptkU4A+tL+ztalK++TzgZc/KHKe0Ck=
X-Gm-Gg: ASbGncsJ4dKTVEaFtSy9S1BR006QhkFwbsXhvrthibyEVyczVbgzxSrfJa5fKdxtlqu
	1GrrgwTNXYUQMXWcUXwaQGTPuVx9d36UKoDCBtWiqg6K60LK5I6uGolLievdr9X4/02/Uu7328s
	eISNs3l9mk3AHU8i3eJNG8lpG4c77cZbKOxQ/4b5IihNhNN64PeMNNFUKxhECEAoku1JFJWMgAl
	4C99CnD929vtnixwlg5vMglrxSQxSYdKr3Z4T5Yn5jBDJpx9vYg2C6VZi4RZSvuOhzow97ikMrC
X-Google-Smtp-Source: AGHT+IG1LY5Ro5QEeSzQqZEhbBC0dsU6xwekLsNDpr9iYjVb6cRyNybKwVv3lNMexpjr/31zQgTEUpQnJewO/QdrqWY=
X-Received: by 2002:a05:6a20:4310:b0:334:a82b:97bf with SMTP id
 adf61e73a8af0-34f86408fd4mr474660637.54.1762284559042; Tue, 04 Nov 2025
 11:29:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104-implv2-v2-0-6dbc35f39f28@meta.com> <529b54a3-c534-4760-9bec-ed1214e82819@linux.dev>
In-Reply-To: <529b54a3-c534-4760-9bec-ed1214e82819@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Nov 2025 11:29:05 -0800
X-Gm-Features: AWmQ_bk9gBBUayAsMCVrgRfOpjXWf_8RorTlhM-GWSbOgYYEj8D2gpVJ3mjDcOw
Message-ID: <CAEf4Bza3xzxucYS_1U=hoHs=ihJGvpSk4h1M1k-cnb4eyDQwtg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 0/2] bpf: add _impl suffix for kfuncs with implicit args
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 9:23=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> On 11/4/25 7:29 AM, Mykyta Yatsenko wrote:
> > We=E2=80=99re introducing support for implicit kfunc arguments and need=
 to
> > rename new kfuncs to comply with the naming convention.
> > This new feature, will for each kfunc of the form:
> >
> > `bpf_foo_impl(args..., aux__prog)`
> >
> > generate a public BTF type:
> >
> > `bpf_foo(args...)`
> >
> > and the verifier will resolve calls to bpf_foo() to bpf_foo_impl(),
> > supplying a valid struct bpf_prog_aux via aux__prog.
>
> Hi Mykyta, thank you for submitting this.
>
> The explanation in this cover is inaccurate. There were a few
> discussions, and the "implicit" feature is in active development, so
> it is confusing... Let me try to elaborate.
>
> Currently if a kfunc needs access to struct bpf_prog_aux data, it must
> have an explicit void *aux__prog argument in its declaration. Then on
> BPF side the users must pass a dummy value (conventionally NULL).
>
> In the v6.18-rc4 these 4 functions are using aux__prog argument:
>   * bpf_wq_set_callback_impl (note existing _impl suffix)
>   * bpf_task_work_schedule_signal
>   * bpf_task_work_schedule_resume
>   * bpf_stream_vprintk
>
> The goal of the KF_IMPLICIT_ARGS feature is to hide this argument from
> BPF programs, as it is supplied by the verifier.
>
> With it, the kfuncs still require an explicit argument in the
> kernel declaration, for example:
>
>     __bpf_kfunc int bpf_foo(int arg, struct bpf_prog_aux *aux__implicit);
>
> In order to hide it from the BPF users, the following functions will
> be produced in BTF from the above declaration:
>
>     /* no aux arg for BPF interface kfunc */
>     __bpf_kfunc int bpf_foo(int arg);
>
>     /* no kfunc decl_tag for _impl function */
>     int bpf_foo_impl(int arg, struct bpf_prog_aux *aux__implicit);
>
> Now the problem with existing aux__prog users that you're renaming in
> this patchset is that because they don't have an _impl suffix, their
> prototype will change, breaking binary compatibility with existing BPF
> programs. If we simply mark them as KF_IMPLICIT_ARGS, then they lose
> an argument in BTF, for example:
>
>     bpf_task_work_schedule_signal(task, tw, map__map, callback, aux__prog=
);
>
> becomes
>
>     bpf_task_work_schedule_signal(task, tw, map__map, callback);
>
> However, if we rename it to "bpf_task_work_schedule_signal_impl", then
> after KF_IMPLICIT_ARGS feature is implemented, we can *add a new
> kfunc* "bpf_task_work_schedule_signal" with an implicit arg.
>
> This way we can avoid breaking BPF progs calling this kfunc, although
> renaming is still a disruption of course.
>
> See links to previous discussions:
> * https://lore.kernel.org/bpf/20251029190113.3323406-1-ihor.solodrai@linu=
x.dev/
> * https://lore.kernel.org/bpf/20250924211716.1287715-1-ihor.solodrai@linu=
x.dev/
> * https://lore.kernel.org/dwarves/20250924211512.1287298-1-ihor.solodrai@=
linux.dev/
>
> >
> > Three kfuncs added in 6.18 don=E2=80=99t follow this *_impl convention =
and
> > therefore won=E2=80=99t participate in the new mechanism:
> >  * bpf_task_work_schedule_resume()
> >  * bpf_task_work_schedule_signal()
> >  * bpf_stream_vprintk()
> >
> > Rename them to align with the implicit-arg flow:
> > bpf_task_work_schedule_resume() -> bpf_task_work_schedule_resume_impl()
> > bpf_task_work_schedule_signal() -> bpf_task_work_schedule_signal_impl()
> > bpf_stream_vprintk() -> bpf_stream_vprintk_impl()
> >
> > The implicit-arg mechanism is not in tree yet, so callers must switch t=
o
> > the *_impl names for now. Once the new mechanism lands, the plain
> > names (without _impl) will be reintroduced as BTF-visible entry points
> > and will resolve to the _impl versions automatically.
> >

TBH, it looks like both Mykyta's and Ihor's descriptions are a little
bit too detailed and are more concerned with details of the upcoming
feature.

What's important with these fixes is that we are fixing deviation from
the previously established "_impl" suffix naming convention for these
kfuncs that accept verifier-provided bpf_prog_aux arguments. Following
uniform convention will allow for transparent backwards compatibility
with the upcoming KF_IMPLICIT_ARGS feature, so this patch set aims to
fix current deviation from the convention so as to eliminate
unnecessary backwards incompatibility breakage in the future.

WDYT?

> > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > ---
> > Changes in v1:
> > - Split commit into 2
> > - Rebase on the correct branch
> > - Link to v1: https://lore.kernel.org/all/20251103232319.122965-1-mykyt=
a.yatsenko5@gmail.com/
> >
> > ---
> > Mykyta Yatsenko (2):
> >       bpf:add _impl suffix for bpf_task_work_schedule* kfuncs
> >       bpf:add _impl suffix for bpf_stream_vprintk() kfunc
> >
> >  kernel/bpf/helpers.c                               | 26 +++++++++++---=
------
> >  kernel/bpf/stream.c                                |  3 ++-
> >  kernel/bpf/verifier.c                              | 12 +++++-----
> >  tools/bpf/bpftool/Documentation/bpftool-prog.rst   |  2 +-
> >  tools/lib/bpf/bpf_helpers.h                        | 28 +++++++++++---=
--------
> >  tools/testing/selftests/bpf/progs/stream_fail.c    |  6 ++---
> >  tools/testing/selftests/bpf/progs/task_work.c      |  6 ++---
> >  tools/testing/selftests/bpf/progs/task_work_fail.c |  8 +++----
> >  .../testing/selftests/bpf/progs/task_work_stress.c |  4 ++--
> >  9 files changed, 50 insertions(+), 45 deletions(-)
> > ---
> > base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
> > change-id: 20251104-implv2-d6c4be255026
> >
> > Best regards,
>

