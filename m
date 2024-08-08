Return-Path: <bpf+bounces-36688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 513FF94C1B1
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 17:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDBBB1F216DD
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 15:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854C5190055;
	Thu,  8 Aug 2024 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbaJ4144"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7523218EFC4;
	Thu,  8 Aug 2024 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131801; cv=none; b=NaF+kpADyGEBEwKhOx/pkUNZupqPu+lhPa6evomzhioxwtrOco8fXgfQSW/5HJg+UBD9r/oYidTr6H0oP1t1E650CcacBt+vTlp3SF/k6EK+ScmOThhuobPZjG3daAQh+aKbeMYWPEqdcVAdTLLRWULf5D0Qf6xJF0d5WFffhqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131801; c=relaxed/simple;
	bh=A+/opCpEYIW9pah39pVdNVTgLaIoXLrBJVVuCdXlVQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODqm7XXTbOCNiSzznmqIqUTZGtt6UYEG7u/w0JpjJsC3qzRRgVT83e82DaFohiCs3gGcMCfZEjDnRIofyMn2x4OgzqPKg/YDNcuzJGeNAWr31/WWx9NU6hIW4PGLafyKCdbYUBsAYZzffaQIQ9kJrbyDvxOEp/IINKN+2FX3GIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbaJ4144; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-36bd70f6522so567566f8f.1;
        Thu, 08 Aug 2024 08:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723131798; x=1723736598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGvr0jiShE3Q6pCXxe49idYWa+0u7kSgOq5J7iA/+dU=;
        b=XbaJ41447SrqBZO/UxFKk2/Ybx0Z7O7bmgcgjifMCT4CmtWQ8V0ETxKBy2q4jli5An
         gFLxElq6p4J6N8QwgAsCrjr6F4N578Sp+vY+whS4WtZt/inOKTWyFcHlgDggLAHfvUzk
         AxmuKXPGbak0+2YWIazA78ZYPvmo4bpoF/BhQO5LlnYFXwRMFukbu64FO9V9layOo36O
         j/uJ0ytLTXKR7j3U5VQUrSXSAp6+bNTqn0gpM/k2GG+Y0d7zYB/YE36JeVgsLVl2C2Ey
         Hmk2xr4VpZ4+YfIZFtoQxouCNUauYK8BisNLbuiuu8vxNoJBowE2oeq8ziuMBubJA5hP
         jTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723131798; x=1723736598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGvr0jiShE3Q6pCXxe49idYWa+0u7kSgOq5J7iA/+dU=;
        b=UEOG0M/F6r4xoX+aK54/W30jHUDwcYvYAcG4IQFACKnEjGz3U4Z+D6Sj6SXCzCA8pp
         gldhM1oHTuwjGcc6hmxcgxvX1mnJan/i82ktvrm6bAVa3a7bUgaoDKEJtPuvoyi/68vy
         d/g7fSKa3+SYS27aWGPu94y0ZKiYIEMTyCaFu2HM2T6QKPFS+hIclK3tgGQxpVH/jUda
         8jmqmB2ktZa2z6T9XFlkvmoadJbNu0B0nO6IGTQkmHFWXV7t1E9+jxUNn0a46bModbBK
         X2ZmdaYbOtufjyewWQrbWq6gKaXLwLsUOdFxYpKbk9AP/yayy5TGszj3ZPZ3Rw0kVmAy
         tMlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXW9xk3W5KXwpUWlwe610sGQgR2qg8lGokhYK8R3SVtrQAYZ2rwvToe8uIMGW/ZRN+hSUpu/obrU5w9tA6863l83LnrkXRGpqqrWQGC5SlCA04OFcM2JiPDMQEqMtqbK/b
X-Gm-Message-State: AOJu0Yzmr+mZnLETqAlt3Z4VTh64CnjkVJIfoQIoIHZsoUiOJ3+O88A5
	plEIF7m51Y+Lm37wJygwV+M4GANYgU83TwlgNlIG2d7G9CxNbw0OFeHzd1aHQqic3m+xi14Zi+O
	oNFcXTX0xKMamxvCJ1PdArWnBTx0=
X-Google-Smtp-Source: AGHT+IEutqQjJQD0qkuqdDqs2LRDHEqm+pWN+bkFplz8BlaGtstRtyoCV0LEgrvtanZF6lUxnURsmiBHfn6GQzP1x+U=
X-Received: by 2002:adf:cd0f:0:b0:366:e9fa:178 with SMTP id
 ffacd0b85a97d-36d272997e9mr1653619f8f.0.1723131797205; Thu, 08 Aug 2024
 08:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZrCZS6nisraEqehw@jlelli-thinkpadt14gen4.remote.csb>
 <ZrECsnSJWDS7jFUu@krava> <CAADnVQLMPPavJQR6JFsi3dtaaLHB816JN4HCV_TFWohJ61D+wQ@mail.gmail.com>
 <ZrIj9jkXqpKXRuS7@krava> <CAADnVQ+NpPtFOrvD0o2F8npCpZwPrLf4dX8h8Rt96uwM+crQcQ@mail.gmail.com>
 <ZrSh8AuV21AKHfNg@krava>
In-Reply-To: <ZrSh8AuV21AKHfNg@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 Aug 2024 08:43:05 -0700
Message-ID: <CAADnVQLYxdKn-J2-2iXKKKTg=o6xkKWzV2WyYrnmQ-j62b9STA@mail.gmail.com>
Subject: Re: NULL pointer deref when running BPF monitor program (6.11.0-rc1)
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Artem Savkov <asavkov@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 3:46=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Tue, Aug 06, 2024 at 11:44:52AM -0700, Alexei Starovoitov wrote:
> > On Tue, Aug 6, 2024 at 6:24=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> > >
> > > > Jiri,
> > > >
> > > > the verifier removes the check because it assumes that pointers
> > > > passed by the kernel into tracepoint are valid and trusted.
> > > > In this case:
> > > >         trace_sched_pi_setprio(p, pi_task);
> > > >
> > > > pi_task can be NULL.
> > > >
> > > > We cannot make all tracepoint pointers to be PTR_TRUSTED | PTR_MAYB=
E_NULL
> > > > by default, since it will break a bunch of progs.
> > > > Instead we can annotate this tracepoint arg as __nullable and
> > > > teach the verifier to recognize such special arguments of tracepoin=
ts.
> > >
> > > ok, so you mean to be able to mark it in event header like:
> > >
> > >   TRACE_EVENT(sched_pi_setprio,
> > >         TP_PROTO(struct task_struct *tsk, struct task_struct *pi_task=
 __nullable),
> > >
> > > I guess we could make pahole to emit DECL_TAG for that argument,
> > > but I'm not sure how to propagate that __nullable info to pahole
> > >
> > > while wondering about that, I tried the direct fix below ;-)
> >
> > We don't need to rush such a hack below.
> > No need to add decl_tag and change pahole either.
> > The arg name is already vmlinux BTF:
> > [51371] FUNC_PROTO '(anon)' ret_type_id=3D0 vlen=3D3
> >         '__data' type_id=3D61
> >         'tsk' type_id=3D77
> >         'pi_task' type_id=3D77
> > [51372] FUNC '__bpf_trace_sched_pi_setprio' type_id=3D51371 linkage=3Ds=
tatic
> >
> > just need to rename "pi_task" to "pi_task__nullable"
> > and teach the verifier.
>
> the problem is that btf_trace_<xxx> is typedef
>
>   typedef void (*btf_trace_##call)(void *__data, proto);
>
> and dwarf does not store argument names for subroutine type entry,
> so it's not in BTF's TYPEDEF either
>
> it's the btf_trace_##call typedef ID that verifier has to work with,
> I wonder we could somehow associate that ID with __bpf_trace_##call
> subroutine entry which has the argument names
>
> we could store __bpf_trace_##call's BTF_ID in __bpf_raw_tp_map record,
> but we'd need to do the lookup based on the tracepoint name when loading
> the program .. ATM we do the lookup __bpf_raw_tp_map record only when
> doing attach, so we would need to move it to program load time
>
> or we could 'fix' the argument names in pahole, but that'd probably
> mean extra setup and hash lookup, so also not great

I would do a simple string search in vmlinux BTF for "__bpf_trace" + tp nam=
e.
No need to add btf_id-s and waste memory to speed up the slow path.

