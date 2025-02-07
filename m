Return-Path: <bpf+bounces-50708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5529A2B79C
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 02:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1090E3A5D23
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 01:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E0212E1CD;
	Fri,  7 Feb 2025 01:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vry0vW4i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104A32417DB;
	Fri,  7 Feb 2025 01:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738890403; cv=none; b=JAhbuBbNx/1+8y/aq52r7Gt28qQEmu8gC1TnAdLjPBYCCB0VL+q28GzBh8TI+2DHspOTlsoaxPkVpdFHIkXW8/CiiJvxaqiuDIzOS2I7H09pJYwvu/RDM+7x9lqaZ+5GiqwoQq1L+a9VwnVP4lzxYqCeY3ip9JIBRNkTA0L9P3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738890403; c=relaxed/simple;
	bh=+JH0Kl+LMqU7iLscxtuKqy44N/84J/QF10jNS2ZDf4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZEUctxgiTMNZCsr9cNpBSa/326uXMujM6h2LA2wAQkzFgRZLCzSYdGxiFJ7Lx9sFeP8iyVH0HAeDlJ/Otb8cSB82+6RYtS8muErG5Rhhn0k7NRHQvgAjSjL+kRKwvSp8hq2DX6zxvwBHOF4pG0WRFRiK1sHVgcXbEy0j0E/1N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vry0vW4i; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5f2e370bb3aso484913eaf.0;
        Thu, 06 Feb 2025 17:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738890401; x=1739495201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JH0Kl+LMqU7iLscxtuKqy44N/84J/QF10jNS2ZDf4M=;
        b=Vry0vW4irX2SPKA3mNJiU1ns3qGIUoCEevlVoHCBXUUHHQtu5TsyzDeVmaHBnB3Gsv
         q7wfiKkdAtfOsbYiGF8B0zbMoJMU2V4lZo6G+ItXOFHimdjQySd4f4VETSE3YAHncSPc
         hTaNq4mqOViGotXkc4hDMJy99upj/xC3q9vqNb1V9BCxU0Vuwex2n47280Dcm3+dDkoP
         mwoGIiCz5v4fIKhIq2MLPGF3ZOrPmeSWOMK9xmlonYbsdRuCG9J5SWGTmzDrlM0+E8S5
         8ZSmATKbnwtVX5LGCF9U5KEpHvTVt8+yhcJq4THG9kYEhWOOeZrzWCkvv/x8OEFvNhAS
         4BxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738890401; x=1739495201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JH0Kl+LMqU7iLscxtuKqy44N/84J/QF10jNS2ZDf4M=;
        b=rKpPRPJnkIAizxqNwPXzsVWpu3PUp1rRga4UMIUeEvE4754TenxjCyReKHaSpHlfAT
         jiAphtvsldqf8O21vUIJ0DZtNAcqM8I3nirtmVi5gyijLR5CdOWF4FwqXPmqFb+M7r+y
         aNuUxGX3n92peXS3gzhFHjNEinI+cvOZDQ7fNHx6erDLE+aGAUfR+/f8YL60uH5OWTBb
         Hx2KkvDa+wYXXWIoEhi5V69x5d2ujqr3RcZqLTcu9ectVdNau6rOYeaeqD/1zaxMRiCX
         PLNzdzrKrOzFlNDHnhgPdEsRKMEd3nqcxu2HxmFhjEp2+Vk/m2DaRyeADrmyFZhFJveD
         H7Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVENKD4bT2pSasn7x1jc6q89GBCZEzJIB1T4O9ginUzTAZbnLAuZK5L9jeWu++jeXzksydBeJin24dtBzWX@vger.kernel.org, AJvYcCVUf5glB/icOioFnrcorKmu24C2WYPyXaNkKkj0JffQzjsQra8w2a3oT0uZAd2aHSor91/N7iAc+gQj@vger.kernel.org, AJvYcCXIeAV+EelkVdnrhHPwdcpnko9HfLea0RUbec1iSP2MWOYzr8M9YqNntfprtdJ9AucdwSs=@vger.kernel.org, AJvYcCXtti+xc5GTaXB66dv+Vs/XJa9kHKOkXdq1ASPoqjFHMU1+wFEU6SKMieyYpT2nHALT5LoqTnNwtT8noJshnr3w6+2E@vger.kernel.org
X-Gm-Message-State: AOJu0YxMWqMsIhopDfTLpsMA1TvKEroJ7gRVRBJkzwopNnU0llyRIITL
	s/m0hXyioBpedsCIeUT+L2lgjtuHm2o/KotIxF9ciV5Sj4DW8bzeG2WqXhuXGNhA62Xijco3YBo
	yQ6iaaN6/l3f21LjHpHyq6nmQWto=
X-Gm-Gg: ASbGncveQ+WjKbMb6LBw+MiD53p+fPKjiviP09WIKqjtv6+RJzUyBvY7/qS2qlMw0+A
	EMrR0YccnlboTsaUalvlLq4wXDzSqyc5SdHVzn1z2Esik8JiPtivNXKyxO4ZOD4AUPex6+1Gg
X-Google-Smtp-Source: AGHT+IH6PgOBBsrDtgXx2JTZNM4qBaBpe1kRv9ipONlpI7hxIPRJYGND+fDpdMRAh1TLVLWYEjAKQVE9EkCdEERHwfw=
X-Received: by 2002:a05:6871:6ab:b0:29e:5cb1:b148 with SMTP id
 586e51a60fabf-2b83ebab2d9mr1014808fac.6.1738890400959; Thu, 06 Feb 2025
 17:06:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250202162921.335813-1-eyal.birger@gmail.com> <173887689139.3506371.3849387827240027734.b4-ty@kernel.org>
In-Reply-To: <173887689139.3506371.3849387827240027734.b4-ty@kernel.org>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Thu, 6 Feb 2025 17:06:29 -0800
X-Gm-Features: AWEUYZns78o6xbyYTFmpyttX5UpU8FdcPPtVjInXDaQiS1b1lneCixXIegt5rtM
Message-ID: <CAHsH6Gv7SLuy+v1hRzxH7sk-dVDRKA=iTyeabRBkoFuMGz7_YQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] seccomp: pass uretprobe system call through seccomp
To: Kees Cook <kees@kernel.org>
Cc: luto@amacapital.net, wad@chromium.org, oleg@redhat.com, 
	mhiramat@kernel.org, andrii@kernel.org, jolsa@kernel.org, olsajiri@gmail.com, 
	cyphar@cyphar.com, songliubraving@fb.com, yhs@fb.com, 
	john.fastabend@gmail.com, peterz@infradead.org, tglx@linutronix.de, 
	bp@alien8.de, daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com, 
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com, 
	bpf@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 1:22=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Sun, 02 Feb 2025 08:29:19 -0800, Eyal Birger wrote:
> > uretprobe(2) is an performance enhancement system call added to improve
> > uretprobes on x86_64.
> >
> > Confinement environments such as Docker are not aware of this new syste=
m
> > call and kill confined processes when uretprobes are attached to them.
> >
> > Since uretprobe is a "kernel implementation detail" system call which i=
s
> > not used by userspace application code directly, pass this system call
> > through seccomp without forcing existing userspace confinement environm=
ents
> > to be changed.
> >
> > [...]
>
> With the changes I mentioned in each patch, I've applied this to
> for-next/seccomp, with the intention of getting them into v6.14-rc2.
>
> Thanks!

Thank you very much for your help.

Eyal.

