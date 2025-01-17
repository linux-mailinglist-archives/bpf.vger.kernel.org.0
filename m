Return-Path: <bpf+bounces-49230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AD7A15830
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 20:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116C6188BAEF
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 19:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19F71A9B2C;
	Fri, 17 Jan 2025 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iky2NzGL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C041A257D;
	Fri, 17 Jan 2025 19:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737142464; cv=none; b=DaqffCMYIPrbiuoZo6WNJ6I1l8G+fSdobFq0HuL8TDFByqSrJGJCAGpft8mNYaRzwuBdmjr6YqKXeiKs64XOWKxtaewgkUpG3b3zaybt6af6dlJzbiG489/aN9DiSFEvpZZHBqpAYe0ZLUac/7PqhyQ5JD3C4fAdTI1EgKFqyHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737142464; c=relaxed/simple;
	bh=kP817+zunpmSIjH2DRbe3vVat5c+yGue7TnclNFwr/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5UNrl4jNK9Amk1xY/2SABJC/RI4EeuxM52+SvSgIKLQtx6e6uNoT5RsvZjqCSef3EoCSD/Mia+H7Xcy6SJ46wXJ/gtowb8sEeeJrbuK1wwCq9vDJn/lGOZdm4IdhWYDs2Sa8oCyqGcYzHbyCVdZSJZuZjmN0xgj3/0Bfg3NWVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iky2NzGL; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ef748105deso3412596a91.1;
        Fri, 17 Jan 2025 11:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737142462; x=1737747262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kP817+zunpmSIjH2DRbe3vVat5c+yGue7TnclNFwr/A=;
        b=iky2NzGLre5F1Mls1ax7q0Y6ETFk/C3Ocu/9BDB3g2+GBPMlOvQ9ukudxdla0WTOIh
         0gq5C3/4aCI6/B2lBUQpg0gaI7kr2VyJ9Mbg8kSyjNPYUOiSUINMUaP2s+8i5gT1D4mb
         v3F/6T8+GVDPZq98PpOaCFRvSF9zH7zKZKBCd2nIuzGGVWOVn5ix42XVPlPLcHeb+GII
         Uss3uyRV0MDnz0xBCZi2r8X5/RNzcMd4Xu99+zJMco+WVlGnVJd2RmCvZtvi07d7hf2n
         Ny9zjGIfXfS3Sv+OnqKm+hYbU5oyCTEjrtdYkK0vMUO7lE1KCbvDetVYqj/M0umY7YxY
         BAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737142462; x=1737747262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kP817+zunpmSIjH2DRbe3vVat5c+yGue7TnclNFwr/A=;
        b=oj2O/HQdAaAlZ8qhpEXSHavnxqfwzeWEGlQvJcFG6bdDesuG9IxqQ+9NuiO8E1AktR
         vsZBAT5Mj2G2Ox3S17pDPQ5zk8aWa3mjLBsASUuIzsxCON21u1245uCLQtEnDAm7unnj
         pJ35vQu+8gbDkPTEKbcD5am9zicppY/HUteYq4H4nlNKPBxE0nXfQuvQ7AnCR/WLIjDV
         VOAQRF69+iVFv9bqs3UEVeVstWvWuxa3Zxp+u0MoVng1kNJssd6HECPe6FSUImHnaL/b
         rwoXToEpyATkNZdb4d97GSyQFbqHby6WGySa5MOu030LnIAojy2X5y5DlcKxaFOu/X/u
         duAA==
X-Forwarded-Encrypted: i=1; AJvYcCUpvs96WAsgGtVXoQaHkyreWOHbevCdT+emoKZu40GIpFwN9yGACMqcyvc4YB3qd7xOpr0XOLO+eZVt@vger.kernel.org, AJvYcCUsYUSr/kdG2lmhZMmIO0wS+7NsbaQAVAGn8e/Iu19+coG+WcMKbUICzz6jzKh+mKY1HjZhZMEdeOL7mdpk@vger.kernel.org, AJvYcCVxMAo6r5Zlw00Dlxvn51Mm4w2PbObaGoU8ey3NgQznRN/fhAu2TIAtpq3uRXP3ZE/59lTS1LRyeKSEFhcLGnalDQ39@vger.kernel.org, AJvYcCXrxetZBCq18wp4DfTQm+dorgP7qPmgGcHza95DfpFN0ALeh6BYytptPKqq8+nkWOLQIvI=@vger.kernel.org, AJvYcCXxkkOQ0cZt3BAyBmFNDyM9Oei3zn+90Swkdzff74+BuDWC9lWnCe516SWyy/iItStMIcRuRKzv@vger.kernel.org
X-Gm-Message-State: AOJu0YyUSMVCB35PLY48/JW7OBwWcxo8vRsq+krsgK667OoLWsfG+VQl
	nHPLwHUyQZ1Ps7+DHO7N7glB3GR405M9GzFQyHULjC5BVQ/1Y3NJLfQ165uI5QpQ5gfZSEXcr5X
	lSBUfp9MfP5VyQ7DQjQg5UNXPq9I=
X-Gm-Gg: ASbGnct1WlGQuuX5UTewgTTJLXruhMapS2SPYqfrm+lnEPpLjO5520GR+iZrVUfGfXt
	qLRaRX0VWJDKpFVoZFTBs1GWKIcG4v7xFswsw
X-Google-Smtp-Source: AGHT+IF2B4+R6BOjobobgMGU/ri7MVR8a7OMIjTaaa31OYd6NHFTkUEcoruEUlFu4PWWQGgx/gpoecf08h1NetUrKB0=
X-Received: by 2002:a17:90b:274a:b0:2ee:ab04:1037 with SMTP id
 98e67ed59e1d1-2f782c98d31mr6183974a91.17.1737142462217; Fri, 17 Jan 2025
 11:34:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <20250117013927.GB2610@redhat.com> <20250117170229.f1e1a9f03a8547d31cd875db@kernel.org>
 <20250117140924.GA21203@redhat.com> <CAEf4BzYhcG8waFMFoQS5dFWVkQGP6ed_0mwGTK4quN5+6-8XuA@mail.gmail.com>
 <CAHsH6GvgqXgd3F_Nqf-f-tOigtmOACXFukSm+Wpi561xf2vCAA@mail.gmail.com>
In-Reply-To: <CAHsH6GvgqXgd3F_Nqf-f-tOigtmOACXFukSm+Wpi561xf2vCAA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Jan 2025 11:34:09 -0800
X-Gm-Features: AbW1kvYx0b6w443F5xG-HuJu-GCwzIL5Adm8kGvAgeyUkRBiTfLyRlVhkaRBVMQ
Message-ID: <CAEf4BzYPh5CpZWxGnFmtasZ9THmmW0ShUw2j4=K9X5+=LzpRaw@mail.gmail.com>
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without filtering
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, kees@kernel.org, 
	luto@amacapital.net, wad@chromium.org, andrii@kernel.org, jolsa@kernel.org, 
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de, daniel@iogearbox.net, 
	ast@kernel.org, rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com, 
	bpf@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 11:24=E2=80=AFAM Eyal Birger <eyal.birger@gmail.com=
> wrote:
>
> On Fri, Jan 17, 2025 at 9:51=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Jan 17, 2025 at 6:10=E2=80=AFAM Oleg Nesterov <oleg@redhat.com>=
 wrote:
> > >
> > > On 01/17, Masami Hiramatsu wrote:
> > > >
> > > > On Fri, 17 Jan 2025 02:39:28 +0100
> > > > Oleg Nesterov <oleg@redhat.com> wrote:
> > > >
> > > > > A note for the seccomp maintainers...
> > > > >
> > > > > I don't know what do you think, but I agree in advance that the v=
ery fact this
> > > > > patch adds "#ifdef CONFIG_X86_64" into __secure_computing() doesn=
't look nice.
> > > > >
> > > >
> > > > Indeed. in_ia32_syscall() depends arch/x86 too.
> > > > We can add an inline function like;
> > > >
> > > > ``` uprobes.h
> > > > static inline bool is_uprobe_syscall(int syscall)
> > > > {
> > >
> > > We can, and this is what I tried to suggest from the very beginning.
> > > But I agree with Eyal who decided to send the most trivial fix for
> > > -stable, we can add the helper later.
> > >
> > > I don't think it should live in uprobes.h and I'd prefer something
> > > like arch_seccomp_ignored(int) but I won't insist.
> >
> > yep, I think this is the way, keeping it as a general category. Should
> > we also put rt_sigreturn there explicitly as well? Also, wouldn't it
> > be better to have it as a non-arch-specific function for something
> > like rt_sigreturn where defining it per each arch is cumbersome, and
> > have the default implementation also call into an arch-specific
> > function?
>
> I like the more generic approach and keeping CONFIG_X86 out of seccomp,
> and more generic than uprobes, however, I'm not sure where a common part
> to place it which includes arch/x86/include/asm/syscall.h would be. And
> as mentioned before, this would make this bugfix more complex to backport=
.
>
> For that reason I wouldn't refactor handling rt_sigreturn as part of
> this fix.
>

SGTM, it can always be improved later, if necessary

> Thanks!
> Eyal.

