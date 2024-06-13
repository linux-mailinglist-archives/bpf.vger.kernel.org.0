Return-Path: <bpf+bounces-32100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F39907780
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 17:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92148283AB2
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 15:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D5A12EBE6;
	Thu, 13 Jun 2024 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4BjOjSl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B461826AE4;
	Thu, 13 Jun 2024 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293873; cv=none; b=nyLddwGU7ecX1mSzlpoqmkUGjgV6QanOQb4hj0d1bZIDLmUH6rshSc0bma8wmN1+sfP4LelhzQGqQ3W2bx4r7yaLPwcBDSF6yrtnGH1uxQQYrA8VFRjlmvLrPZI1bPS9wdXKSIIQEqVI3lN/5HCRCBfbw0/ZnpnDNWzmLRC1Hqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293873; c=relaxed/simple;
	bh=R1iEcqr0dQ89Cf7R5SABV+vKDM3/NnP8bdj36rzs/7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axbaS1Yh4SeWhgIeLy7UrdCRhkJnlDZ0S11mG6VKFL7OxyXHzBbv5rl6nTVAdfxKDLwt4XEdTLzhv8fs3IPE7f5CUV7mY1XTMi+R7+H189cPLIPj5OflMm1EitqOJw4vMTHUiw5EWUrCl/huqaLXkCZr/nvcJu7szm9IRIhj67I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4BjOjSl; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dfac121b6a6so975165276.0;
        Thu, 13 Jun 2024 08:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718293870; x=1718898670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVRo5ZVHpJ+jVwv9XudQZT4KE/rMNJoDFGVv8w2Sido=;
        b=k4BjOjSliD18q4XU5/Fws+Njyf0wo0cvJAHkddNeqhAKCgkNVXCDEahmoEUUXPYTgz
         GD3YFM+QnI5yucjCvXB5mZLm1jhEqW+yCxccqKxgN8LmLGIXkCGaNUuwNc6D75YGcFxM
         SV3/AAbmF4Ptn5TqlGgEAEJFxI1nYVPmQFeUlz1eqB11T0qb7Z17rTKX3SdatdQBCT4x
         sNJ2McOFE3MnxR2TuXfinmRJ3/GS1mMFuFRIGS3FGSEKJ8vr1JLkYFdJhfnKn/IgjBNB
         KYR6p78OTEtSL7g5h1TMVY8oNK7TiN4AQYvDekhaRHp33FJ+moq2mpI/LN2jR6t3ZBxE
         YIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718293870; x=1718898670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVRo5ZVHpJ+jVwv9XudQZT4KE/rMNJoDFGVv8w2Sido=;
        b=P9BrEz1BxF5/yOvkO94JXXrWPkAG6e7LlxmKIbXDyqRxpI/hsf00h3j/iw3+M0lwDD
         gZrJhspX+b/6X1zEk1/GxY5uRsQd9crEeOPsJHWR+EM6vdV+NClUEfme6lht19HISuhh
         k7/qvbWa3Wp47uqYxNyBjeSR92H98SbVavGXVpacs8b56hANHuUIs7CJCRLhGvQrnGAF
         2kWoU9SCZ0/kfU/h4vTtex3a5kZkj83H0c+n3g3Xsaoti80G/Pm0bYzVEPcpsfDo0Yzg
         EknSRKF8Xd3hWw0sOcIbeWrJljcUmn8Q8K6gHZDeKebs7/iIXdLCAmgKrMRcYvUv0DYw
         INsA==
X-Forwarded-Encrypted: i=1; AJvYcCXF/e04u69oQsSafQchRyiI5Uh71k9KajeNtlA4hD4N1FE6TzuJ3G8jp0rexcScVmBxEJt1uEu4biYNbR3MlVbwGHGm71Ky5uBnXZDXt2xUYdZfLzSkP1n0HwnlZdYhJeXiIR2h6LRjciF1c5Gv7Ntmsxgi1ImB3xWTJACxbqYOSQeQTehcQMy/DAsVDVJYt7T/YTK3rdkpmaaOkbhncADgbDWO95asGUTNcQ==
X-Gm-Message-State: AOJu0YyvhzMtGK0JOjxu7TItOP2AgtwJD2E4y2zRT77nQ8ICJFQo49z1
	4pHS5rroW/qIUUhGtLt6l6ZB7GL47GvFJ22XPSsmmVzaS5Svy2frgjFiyGFhPXEaMC4zf0CusbA
	K+fvhcpCpzl20ahx9pRF4hI4ND+g=
X-Google-Smtp-Source: AGHT+IGzBlAbfeVreoYUfE2O87QRKTQE9sxsJHzb49znwW6137XNCqlsRXG0X4SB/k5yJqUf2EAyRacLODx7axPY8fw=
X-Received: by 2002:a25:f627:0:b0:dfb:29:3d95 with SMTP id 3f1490d57ef6-dff1384ca1fmr153682276.11.1718293870466;
 Thu, 13 Jun 2024 08:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613042747.3770204-1-howardchu95@gmail.com>
 <ZmrqQs64TvAt8XjK@x1> <ZmrtGuhdMlbssODG@x1>
In-Reply-To: <ZmrtGuhdMlbssODG@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 13 Jun 2024 23:50:59 +0800
Message-ID: <CAH0uvogFih59J1nBQKKM4r2Fc1UA755EoAa01e6MihSd1_QHFg@mail.gmail.com>
Subject: Re: [PATCH v4] perf trace: BTF-based enum pretty printing
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	mic@digikod.net, gnoack@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Arnaldo,

Thanks for testing and reviewing this patch, and your precious suggestions.

On Thu, Jun 13, 2024 at 8:59=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Jun 13, 2024 at 09:47:02AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, Jun 13, 2024 at 12:27:47PM +0800, Howard Chu wrote:
> > > changes in v4:
>
> > > - Add enum support to tracepoint arguments
>
> > That is cool, but see below the comment as having this as a separate
> > patch.
> >
> > Also please, on the patch that introduces ! syscall tracepoint enum arg=
s
> > BTF augmentation include examples of tracepoints being augmented. I'll
>
> You did it as a notes for v4, great, I missed that.
>
> > try here while testing the patch as-is.
>
> The landlock_add_rule continues to work, using the same test program I
> posted when testing your v1 patch:
>
> root@x1:~# perf trace -e landlock_add_rule
>      0.000 ( 0.016 ms): landlock_add_r/475518 landlock_add_rule(ruleset_f=
d: 1, rule_type: LANDLOCK_RULE_PATH_BENEATH, rule_attr: 0x7ffd790ff690) =3D=
 -1 EBADFD (File descriptor in bad state)
>      0.115 ( 0.003 ms): landlock_add_r/475518 landlock_add_rule(ruleset_f=
d: 2, rule_type: LANDLOCK_RULE_NET_PORT, rule_attr: 0x7ffd790ff690) =3D -1 =
EBADFD (File descriptor in bad state)
>
> Now lets try with some of the !syscalls tracepoints with enum args:
>
> root@x1:~# perf trace -e timer:hrtimer_start --max-events=3D5
>      0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff225050, function=
: 0xffffffff9e22ddd0, expires: 210588861000000, softexpires: 21058886100000=
0, mode: HRTIMER_MODE_ABS)
> 18446744073709.551 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff2a5050, =
function: 0xffffffff9e22ddd0, expires: 210588861000000, softexpires: 210588=
861000000, mode: HRTIMER_MODE_ABS)
>      0.007 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff325050, function=
: 0xffffffff9e22ddd0, expires: 210588861000000, softexpires: 21058886100000=
0, mode: HRTIMER_MODE_ABS)
>      0.007 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff3a5050, function=
: 0xffffffff9e22ddd0, expires: 210588861000000, softexpires: 21058886100000=
0, mode: HRTIMER_MODE_ABS)
> 18446744073709.543 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff425050, =
function: 0xffffffff9e22ddd0, expires: 210588861000000, softexpires: 210588=
861000000, mode: HRTIMER_MODE_ABS)
> root@x1:~#
>
> Cool, it works!
>
> Now lets try and use it with filters, to get something other than HRTIMER=
_MODE_ABS:
>
> root@x1:~# perf trace -e timer:hrtimer_start --filter=3D'mode!=3DHRTIMER_=
MODE_ABS' --max-events=3D5
> No resolver (strtoul) for "mode" in "timer:hrtimer_start", can't set filt=
er "(mode!=3DHRTIMER_MODE_ABS) && (common_pid !=3D 475859 && common_pid !=
=3D 4041)"
> root@x1:~#
>
>
> oops, that is the next step then :-)

Sure, I will add support for enum filtering(enum string -> int).

>
> If I do:
>
> root@x1:~# pahole --contains_enumerator=3DHRTIMER_MODE_ABS
> enum hrtimer_mode {
>         HRTIMER_MODE_ABS             =3D 0,
>         HRTIMER_MODE_REL             =3D 1,
>         HRTIMER_MODE_PINNED          =3D 2,
>         HRTIMER_MODE_SOFT            =3D 4,
>         HRTIMER_MODE_HARD            =3D 8,
>         HRTIMER_MODE_ABS_PINNED      =3D 2,
>         HRTIMER_MODE_REL_PINNED      =3D 3,
>         HRTIMER_MODE_ABS_SOFT        =3D 4,
>         HRTIMER_MODE_REL_SOFT        =3D 5,
>         HRTIMER_MODE_ABS_PINNED_SOFT =3D 6,
>         HRTIMER_MODE_REL_PINNED_SOFT =3D 7,
>         HRTIMER_MODE_ABS_HARD        =3D 8,
>         HRTIMER_MODE_REL_HARD        =3D 9,
>         HRTIMER_MODE_ABS_PINNED_HARD =3D 10,
>         HRTIMER_MODE_REL_PINNED_HARD =3D 11,
> }
> root@x1:~#
>
> And then use the value for HRTIMER_MODE_ABS instead:
>
> root@x1:~# perf trace -e timer:hrtimer_start --filter=3D'mode!=3D0' --max=
-events=3D1
>      0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff225050, function=
: 0xffffffff9e22ddd0, expires: 210759990000000, softexpires: 21075999000000=
0, mode: HRTIMER_MODE_ABS_PINNED_HARD)
> root@x1:~#
>
> Now also filtering HRTIMER_MODE_ABS_PINNED_HARD:
>
> root@x1:~# perf trace -e timer:hrtimer_start --filter=3D'mode!=3D0 && mod=
e !=3D 10' --max-events=3D2
>      0.000 podman/178137 timer:hrtimer_start(hrtimer: 0xffffa2024468fda8,=
 function: 0xffffffff9e2170c0, expires: 210886679225214, softexpires: 21088=
6679175214, mode: HRTIMER_MODE_REL)
>     32.935 podman/5046 timer:hrtimer_start(hrtimer: 0xffffa20244fabc40, f=
unction: 0xffffffff9e2170c0, expires: 210886712159707, softexpires: 2108867=
12109707, mode: HRTIMER_MODE_REL)
> root@x1:~#
>
> But this then should be a _third_ patch :-)

Sure.

>
> We're making progress!
>
> - Arnaldo

> See the comment about evsel__init_tp_arg_scnprintf() below. Also please
> do patches on top of previous work, i.e. the v3 patch should be a
> separate patch and this v4 should add the extra functionality, i.e. the
> support for !syscall tracepoint enum BTF augmentation.

Thank you for suggesting this. May I ask if this is saying that v3 and
v4 should all be separated?

> The convention here is that evsel__ is the "class" name, so the first
> arg is a 'struct evsel *', if you really were transforming this into a
> 'struct trace' specific "method" you would change the name of the C
> function to 'trace__init_tp_arg_scnprintf'.

Oops, my bad. Thanks for pointing it out.

>
> But in this case instead of passing the 'struct trace' pointer all the
> way down we should instead pass a 'bool *use_btf' argument, making it:
>
>
> static int evsel__init_tp_arg_scnprintf(struct evsel *evsel, bool *use_bt=
f)

You are right, we should do that. Thanks for pointing out this silly
implementation. I think we should do the same for
syscall__set_arg_fmts(struct trace *trace, struct syscall *sc) as
well. Also, I forgot to delete the unused 'bool use_btf' in struct
syscall, I will delete it.

>
> Then, when evlist__set_syscall_tp_fields(evlist, &use_btf) returns,
> check that use_btf to check if we need to call
> trace__load_vmlinux_btf(trace).

> And when someone suggests you do something and you implement it, a
> Suggested-by: tag is as documented in:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ grep -A5 Suggested-by Documentat=
ion/process/submitting-patches.rst
> Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:

> A Suggested-by: tag indicates that the patch idea is suggested by the per=
son
> named and ensures credit to the person for the idea. Please note that thi=
s
> tag should not be added without the reporter's permission

May I ask if you want a Suggested-by? Hats off to you sir.

Also, do you want me to do the fixes on evsel__init_tp_arg_scnprintf()
for tracepoint enum, and send it as v5, or just send a separate patch
for tracepoint enum, so we get a patch for syscall enum, and another
patch for tracepoint enum? Sorry to bother you on these trivial
things.

Thanks again for this detailed review, and valuable suggestions.

Thanks,
Howard

