Return-Path: <bpf+bounces-21809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2CB852570
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 02:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C63CB23E86
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 01:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E659A937;
	Tue, 13 Feb 2024 00:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLwJ/Fbl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA80A92D
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 00:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707784479; cv=none; b=F5q6XvFZsuE3Nm2NKIVCqU0JNY3xT9SEUiMOfojVrR+eROMvAgipvEeU/r84Ydzi/bgRnzEMSnVn1kfp1u1vqipp0KuQYUobCUV4AS+qxliLzOozzM7eBDbaLTJ5XDoSIQnasoSAjuAwAQfMHdbL8MLmjYP3tkxFSkuurwBNtD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707784479; c=relaxed/simple;
	bh=velqxREXkYVjZ9VP76u7j3Qt6ErklJEdl2Kp1z6MqNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUsI9m+/E87H3zkscf3e8sFc9LepBLl7vWvkeH8/g4WyJ+IqwU+Ud92rnrnS9CMEcXuG7+YbMcinRisGO+k+NYWelQQIW7sh21IpSsiGaBwnPFs6PDyG1AOOgPJrPwjY9GUnhL7vuEJZc8bTqpFG+1x/QtZlHQo1y2OiBWmQwug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLwJ/Fbl; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a3122b70439so492775466b.3
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 16:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707784475; x=1708389275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxW4MmEuWYcQQJ4MQcJEoVimZJDJqH74fzoiy1xnldk=;
        b=PLwJ/FblyN3g2Lo08A26T3ygGERMAREh8iXe2QwawJ5Zlhj+dhs4oj3mraIhuXoTGy
         w44pcVyrEcsQaRHaYsljkmtlAWJTUZvFhvZlLGi32I7ahVVIg0+3HYszXVSTD93Oy1tk
         RJG5PSGeje0JrY236eMZttBdPNTuYZ8k1xC35lWYzb9pev7sATCgwFiISh/r6DhgHVtQ
         rZvlPGNAHVP4rczQyIL0niKxn4x+sDHttGAooJ8EYHi/77c+kUR9zBgHkI4uN+sAh2w9
         gVbdfm1ZdzNkMsnDlaHdQVlxcxl5vkBrcHnDi2kKkAtxzr7PQuU5fuI7cdlt0cDIOsgE
         k/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707784475; x=1708389275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxW4MmEuWYcQQJ4MQcJEoVimZJDJqH74fzoiy1xnldk=;
        b=m3vMiruwNobBk1p/VE4sx5OxDmKgXK0QlrEzJDz8/D+RQabCzcYkavXAlq5YZiT1mo
         N7Mu3JOoTpY4ZB3yWmpIfntVae5brRBNdVQlULQExooEuUKzpdjcRpJnrM6EpMszAlib
         LQxMP0BV0lTfan4xgAI6xbUqDJ0hY971WjwxhB3EYqlhJlAMBBZ+LgalGu6o8TD66ayQ
         o0hLqvm22pJGMkoM9KVR44wVC1o+dfYysWY1fwT9A9z060Xus5U2uijiLXc33pvHHE8B
         Ul62IO0Up9XwKWeuqvXOJb4+l0OhUBbUnjwS8flktgZpYwik+4/S7oXtLIX3ZWm0RYZg
         ZHqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7S0ES7ABiHmRFpBzfE/HBkee6L+2iLou5z56LLM2eIIC+knGOVEyd4MQxa64BfaF4BC9xYHvLww+RKe0kqJ+1Pqy+
X-Gm-Message-State: AOJu0YyWHgZvPbVcyHVLSDhDfvHB2+wYapUv9ugY3gu1M0A5loiF54rw
	3ZJCerm2oAGAuzmOj51fE7Ga/kaAuIQLOH81P5yVOIScpPW1D0pS5Nw+ErlXrekpScdNZmpPwTJ
	WhEDrLXbjR1zrCW60AGan1xyz1cwJtwCXNnU=
X-Google-Smtp-Source: AGHT+IFvGDpBq4mezoxHz08256qTGUAOJX8JO+BXt7kxYS/OeRlmENUiIFqJe7RPr6ebIj2UYVsKpfyd36hsYlJxkyY=
X-Received: by 2002:a17:906:a407:b0:a3c:15ea:8afb with SMTP id
 l7-20020a170906a40700b00a3c15ea8afbmr5838842ejz.58.1707784475491; Mon, 12 Feb
 2024 16:34:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZcqYNrktYhHFTtzH@debian.debian> <CAP01T74dQAt1UUGkUazx17XAj7k3LCMvw8Y+_rKzwH8eUao75g@mail.gmail.com>
 <CALrw=nGU-gBihe-08rJaxdwpRPQLBPLEQn5q+aBwzLKZ4Go+JQ@mail.gmail.com>
 <CAADnVQ+EL71GN6z3RnSBX5jfCmD9f5T9WN=sr_k+JmZzOOLqPg@mail.gmail.com>
 <CAP01T74t_w0sDaDV5zf3RsZNQg0Hz1XEYw2myOML0L=6afCjsg@mail.gmail.com>
 <CAADnVQLgC8wc5v8sSt=ZxAqLhwoPWXcwwLpSQwKAgaWvuuhF_g@mail.gmail.com> <CAO3-Pbp2idpgEcf7ynvx_ucoDXKPVupWctMk1nZ0i_3zPoOTEw@mail.gmail.com>
In-Reply-To: <CAO3-Pbp2idpgEcf7ynvx_ucoDXKPVupWctMk1nZ0i_3zPoOTEw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 13 Feb 2024 01:33:59 +0100
Message-ID: <CAP01T77KHwS8bmcXfYXn1OmdAXdrSz_sXooUZ5jAa7vSk=HmnQ@mail.gmail.com>
Subject: Re: Page faults in tracepoint caused by aliased pointer
To: Yan Zhai <yan@cloudflare.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Ignat Korchagin <ignat@cloudflare.com>, 
	bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Feb 2024 at 01:21, Yan Zhai <yan@cloudflare.com> wrote:
>
> On Mon, Feb 12, 2024 at 5:52=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Feb 12, 2024 at 3:42=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Tue, 13 Feb 2024 at 00:34, Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Mon, Feb 12, 2024 at 3:16=E2=80=AFPM Ignat Korchagin <ignat@clou=
dflare.com> wrote:
> > > > >
> > > > > [288931.217143][T109754] CPU: 4 PID: 109754 Comm: bpftrace Not ta=
inted
> > > > > 6.6.16+ #10
> > > >
> > > > ...
> > > > > [288931.217143][T109754]  ? copy_from_kernel_nofault+0x1d/0xe0
> > > > > [288931.217143][T109754]  bpf_probe_read_compat+0x6a/0x90
> > > > >
> > > > > And Jakub CCed here did it for 6.8.0-rc2+
> > > >
> > > > I suspect something is broken in your kernels.
> > > > Above is doing generic copy_from_kernel_nofault(),
> > > > so one should be able to crash the kernel without any bpf.
> > > >
> > > > We have this in selftests/bpf:
> > > > __weak noinline struct file *bpf_testmod_return_ptr(int arg)
> > > > {
> > > >         static struct file f =3D {};
> > > >
> > > >         switch (arg) {
> > > >         case 1: return (void *)EINVAL;          /* user addr */
> > > >         case 2: return (void *)0xcafe4a11;      /* user addr */
> > > >         case 3: return (void *)-EINVAL;         /* canonical, but i=
nvalid */
> > > >         case 4: return (void *)(1ull << 60);    /* non-canonical an=
d invalid */
> > > >         case 5: return (void *)~(1ull << 30);   /* trigger extable =
*/
> > > >         case 6: return &f;                      /* valid addr */
> > > >         case 7: return (void *)((long)&f | 1);  /* kernel tricks */
> > > >         default: return NULL;
> > > >         }
> > > > }
> > > > where we check that extables setup by JIT for bpf progs are working=
 correctly.
> > > > You should see the kernel crashing when you just run bpf selftests.
> > >
> > > I agree, this appears unrelated to BPF since it is happening when
> > > using copy_from_kernel_nofault (which should be jumping to the Efault
> > > label instead of the oops), but I think it's not specific to some
> > > custom kernel. I can reproduce it on my dev machine on top of bpf-nex=
t
> > > as well, and another machine with Ubuntu's generic 6.5 kernel for
> > > 24.04. And I think Ignat tried it on the mainline 6.8-rc2 as well.
> >
> copy_from_kernel_nofault is called in Jakub's reproducer, but the
> panic case in our production seems to be direct memory accessing
> according to bpftool dumped jited code. Will faults from such
> instructions also be caught correctly?
>

Yep, since faults in both cases end up in the page fault handler.
Once the fix pointed out by Alexei is applied, it should address both scena=
rios.

> Yan
>
> > Then it must be vsyscall address that this series are fixing:
> > https://patchwork.kernel.org/project/netdevbpf/patch/20240202103935.315=
4011-3-houtao@huaweicloud.com/
> >
> > We're still waiting on x86 maintainers to ack them.

