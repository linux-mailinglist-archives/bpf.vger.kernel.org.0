Return-Path: <bpf+bounces-58207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 395B7AB7121
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 18:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5FB1B66F7F
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0E2253933;
	Wed, 14 May 2025 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPuRrTQ8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9EE163;
	Wed, 14 May 2025 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747239738; cv=none; b=CVcL5sfxG0hulcIGPIERPCsvcGMGxJDGi9zfBgZ4BcSbS4z1R3xshbjpAzjbsJgjgfmnNYcg4zoRtqqTPblyiRV8VBwFDga5KeskkJTQDfTOPbWpn50mxP0XgjRRkcy4voF5lkrCmVpkuTDMKbNZY8nEbxkvsXNY2lYUG/GC+og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747239738; c=relaxed/simple;
	bh=qHojaWkqD4u/btc35P3/kLBBca/hKj+1gUDJ0GjSQo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYRIOGPoqBX+mBIPqP8YBgbZjTH4ihyQoLPmNoiF4hERACm84pG+mnlpQQ/JOfGYAv5BxXBO1lycNOYq60JOcomMxX9lHjcAskUPESX7C9qK/rplQGblYx7YfE8Q0ddncdQqCALyLlLNW+YDNrbHcHIhrGyNdKTRYQx+c7C1uI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPuRrTQ8; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-306b6ae4fb2so34045a91.3;
        Wed, 14 May 2025 09:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747239734; x=1747844534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pV+LeVADCSwpmjoh/LSKTEYh6bY+ssEYLaBtqVhQcS8=;
        b=PPuRrTQ8RtowGIWGMeEl/F/PBHbTC9Zi61PcEtYjBmrg1CSAyN9kRaPCLb7hPgkhcq
         3VgggeSK0SQOKg/FIs2GKDzDZ8e4KPFsBq/4yriaqNKmqbca9wDy3vhrYzGrxfnmwYPE
         FaVzu2etN+d+JxZ6/G/gonAtAA1pjbUc5W0uDYPtKdsgycpY7skxKizjooLHhQIeYSv7
         WSt8HFrGIrDWMnhuuCgtIKxT6Vm3lfRjz/REtWebTVEq9z2lxs2xEtugJmbZPwP7Z4vN
         TcjJu7VoMrem6cM2SWwWIXXF2hi2u5hU5fDEkoSgPV2E1jjHkLqRSpMCOwwhy4lXpQQp
         onDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747239734; x=1747844534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pV+LeVADCSwpmjoh/LSKTEYh6bY+ssEYLaBtqVhQcS8=;
        b=UNRdCrJ9QFFWabUxKXk93YpOArCU9m+MvGNYesk9qObq+DVo9nFkf/qLVsc7n45cKH
         mnIHl2ZQgOqh8x4LWpCFOBmLh7EjYnV3bUK6FKSF19tOL5TaR+hn+1OTmv0qQ3s2chhN
         NCj6Vt5gph1pEYgU3OmpTgmx0GLVk2tiQWSOsg8e02QyyNun54TRgkSAZ7aN7NaWRkd5
         9ToGMLc3eYbjtJNrZkgdhSo78zV8TLo6B4tH+Ciqon7Zc3eTTzFjMK2dOlB8Ac0m1MBA
         kfzFhDHlyRNygiFk6SCY4vlniatdb8ClBw5O0Yr9P/LlanF/G5Pf3XOzXPd4R/CZe8hv
         RBdg==
X-Forwarded-Encrypted: i=1; AJvYcCUtpmqjq+RECax9v1nY7KtPaPVgs4Y1GmrtVEosn/CNeQ14etJ+EkyM6D9k2cjOhSft1fY=@vger.kernel.org, AJvYcCWHapjlyvBnbopE27kRUxux07iJfPJ8OO4yA60zUNjdRbioYPAyyV+oMYFGg2c/uy7nC3HK2XnXng==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqX8zKdZ8DiNnv57Uy7obwn88rZ58hgq8VJe183ncQVsmOqK92
	iFWztRH/n7ee2Bffi+xF/bA1mcMWr2G4k1/SSsNubv5SSOl97bU3/XSdvuFLXtkFgGqKcU/1/Qu
	lC32FI12U0oKQu438wHjiQVLl+Gk=
X-Gm-Gg: ASbGncvS+3XPe7O/6D5zufSJNws/jK3wCKs/wzrDXCRj2LcwBhL1nH70gWVF4Zg4F6i
	On6YUAUElk/LiVDPKL6CEBzTOJJpPU9Nxmb1kOShxuwOCj2CPDtA6RniR8ZWMdSwG2gCl5eOXm3
	VlUGK6zA5QK2P4Z2Cczr++Wnmo9eKOkvXyNqeoT/x6lfkvGAxY
X-Google-Smtp-Source: AGHT+IFkcv2Ll67t+Hyu5TmE8m2mKnb6K2q23lVIgIVE9n/RjXEEqPxdMVxNa8jwzp0f/+YtiWNyp6exJWpkIN/gOeE=
X-Received: by 2002:a17:90b:560b:b0:2fe:d766:ad8e with SMTP id
 98e67ed59e1d1-30e2e59bccamr6489847a91.4.1747239733920; Wed, 14 May 2025
 09:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508132237.1817317-1-alan.maguire@oracle.com>
 <CAEf4BzZfFixwy4vQG8jrUBtAOUFx=t1KG2F+AtKPVNCsMz0vQw@mail.gmail.com>
 <aCG8kz1eZjjw+sSU@kodidev-ubuntu> <4bc9b6c3-4e02-48d3-9b07-c7b1069bfd35@oracle.com>
In-Reply-To: <4bc9b6c3-4e02-48d3-9b07-c7b1069bfd35@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 14 May 2025 09:22:00 -0700
X-Gm-Features: AX0GCFtAQbtOBXKaGwpwvvmBaU-sG9jSYgvYK4xPjlsuNM1raPQJB3zn8tefVZY
Message-ID: <CAEf4BzZoWiBqSBhmxviQ21hQ21m5eKQ=CUYk9AMAB+Z3xFkpGw@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/3] bpf: handle 0-sized structs properly
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Tony Ambardar <tony.ambardar@gmail.com>, martin.lau@linux.dev, ast@kernel.org, 
	andrii@kernel.org, alexis.lothore@bootlin.com, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	mykolal@fb.com, bpf@vger.kernel.org, dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 3:31=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 12/05/2025 10:17, Tony Ambardar wrote:
> > On Fri, May 09, 2025 at 11:40:47AM -0700, Andrii Nakryiko wrote:
> >> On Thu, May 8, 2025 at 6:22=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>>
> >>> When testing v1 of [1] we noticed that functions with 0-sized structs
> >>> as parameters were not part of BTF encoding; this was fixed in v2.
> >>> However we need to make sure we handle such zero-sized structs
> >>> correctly since they confound the calling convention expectations -
> >>> no registers are used for the empty struct so this has knock-on effec=
ts
> >>> for subsequent register-parameter matching.
> >>
> >> Do you have a list (or at least an example) of the function we are
> >> talking about, just curious to see what's that.
> >>
> >
> > BTW, Alan shared an example in the other pahole patch thread:
> > https://lore.kernel.org/dwarves/07d92da1-36f3-44d2-a0a4-cf7dabf278c6@or=
acle.com/
> >
>
> Yep, the one I came across on x86_64 was
>
> static int __io_run_local_work(struct io_ring_ctx *ctx, io_tw_token_t
> tw, int min_events, int max_events);
>
> (the io_tw_token_t parameter is a typedef for
>
> struct io_tw_state {
> };
>
>
> >> The question I have is whether it's safe to assume that regardless of
> >> architecture we can assume that zero-sized struct has no effect on
> >> register allocation (which would seem logical, but is that true for
> >> all ABIs).
> >>
> >> BTW, while looking at patch #2, I noticed that
> >> btf_distill_func_proto() disallows functions returning
> >> struct-by-value, which seems overly aggressive, at least for structs
> >> of up to 8 bytes. So maybe if we can validate that both cases are not
> >> introducing any new quirks across all supported architectures, we can
> >> solve both limitations?
> >>
> >
>
> Good idea. I'll try and address this and add a return value test.
>
> > Given pahole (and my related patch) assume pass-by-value for well-sized
> > structs, I'd like to see this too. But while the pahole patch works on
> > 64/32-bit archs, I noticed from patch #1 that e.g. ___bpf_treg_cnt()
> > seems to hard-code a 64-bit register size. Perhaps we can fix that too?
> >
>
> So I think your concern is the assumptions
>
>
>         __builtin_choose_expr(sizeof(t) =3D=3D 8, 1,        \
>         __builtin_choose_expr(sizeof(t) =3D=3D 16, 2,        \
>
> ? We may need arch-specific macros that specify register size that we
> can use here, or is there a better way?

we know the target architecture, so this shouldn't be hard to define
the word size accordingly and use that here?

>
> >> P.S., oh, and s390x selftest (test_struct_args) isn't happy, please ch=
eck.
>
> Yep, working to repro this locally now, thanks.
>
> Alan

