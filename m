Return-Path: <bpf+bounces-46310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E03D9E781A
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 19:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8302188626E
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFF5198A39;
	Fri,  6 Dec 2024 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+ZKNP30"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74FD2206AA
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733509847; cv=none; b=Ky69H7ydSyTlR4FFYpE6AhSoAfLM8OKd+3LvCyV4udz+m/c3CE+Mx6S5XXz5rmdWt72ymStLyOkL77cMkhOv1X8V4qo35RzLeyh+EjlqLfhE2rB+VgGJePRBMBGg7FR18GtCjj9dht7+3W3ygiTPKT3Hy0tUeitmGWYkD/6UnEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733509847; c=relaxed/simple;
	bh=IqLAldFBDJeWHgnaQdx33DwGuebwg+vPH9jRsBn+8HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJh49NKXzXIxlB2FgkDQ9sQYQVgiRwrXoAeZc0O62tTvmr+LC2WhXCXm8+QSCe2qA9gugETalH7pVIeT9kbBhCTbVbMTOob1n3n+q1+1xzliNinoJCCZ+4DBsBSCOrxED8EUwYZ15nNHBhnacsbSmWR4j/FGF+jcQoJQvdTWpfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+ZKNP30; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-aa63dbda904so201795766b.3
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 10:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733509844; x=1734114644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqLAldFBDJeWHgnaQdx33DwGuebwg+vPH9jRsBn+8HM=;
        b=f+ZKNP30rGzQ2y04KSe6+TNUw45CoANcn2QDlwRyLdQWHtuwPipvhIu9+JrcEtnkyF
         B4zHsdyorOydfFFAq+wI1c7yu+OmZGXKiqlL8g8SF9LxzftJ6y3I00kYJJ1tElmrqNQY
         PF13oyENiLPsI35PHX4W13SuVTaDisW4G1E3YUxLArxl8L4KPQ9KiZWyD6SXPYhECYip
         7GjwjHKXt97nfsyRV6t26b6mq2D38H+A8nQZQern2vvpOLT5c6nxqsafaupuo76Qcyqh
         OsibpR+UOxskwR1bn8sAgMgixdoGYqLqe7M/sGC4g+mLC4sv1V75kP6j9/nzHROp8P8W
         drnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733509844; x=1734114644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqLAldFBDJeWHgnaQdx33DwGuebwg+vPH9jRsBn+8HM=;
        b=TZj++YCtCA8/Vax2RfHSYZnHbq/Zrzsz97l6dyCKJToSw9v9JgRbSCrJj1nq7iv5yj
         fbSCDJyNZCxSw1fZW4n4gVJ+OAMv7MFCiFT0zzMTZm2TmkIgILnFyVeSprxvvxwrHcjb
         bH5p85lxkbpd9TS9KBlgtjs8hW0S0k5Ji3iViSCdKaPyn2BH8eLRjMDNUG0RU7HyrFu7
         BGAiJLoQaQoaPIEdyGXx8tzf/OTZs+hDuAmaL8qhQ794WoOaeinpN2swHlIXOGApy90W
         QXC7AqmVvT6elVstnka6Pn+M60iGO1figP+Vzt+QZQ8AYqpBmWbJu0uDsxcSEPcNvbFQ
         sVlw==
X-Forwarded-Encrypted: i=1; AJvYcCVbX3a37EXK0ZgTPwpB8kZEk7/TaU7rePzulgOqYQZLODvtu6JvB3ioVQlx5ILGlMlGRKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrM884C6ZfhLMAn6Ywcg4KI6rhfKeDB197upMb4/dRPySocfDy
	PipIZcxxECxW4aoA3D+7z7riaPaS3Cb34vVIhPb72m19CTRYuljBTUgnk4K61b8a9Yfw/W9ItFv
	EtLDQRI5/UsopuNuBFkAMJmicyYKzyocafV0=
X-Gm-Gg: ASbGncuKKbeQsXP8GHIxQVtSwD08qznbYPCTcpthecO0YOs93dzXCAZxdiukyqCL19K
	oqlmkoVRrREV8YtwvPgs5ATIGQlzrwvsLVV5upk05PUD7vqIBfxYMBa7eHr35f/eF
X-Google-Smtp-Source: AGHT+IGDs/FmUgKJX95xAQvM7rHKP/sOM/K55Wqr9h4H1yiTxI5eOnUhGi6CkOKhyMt+k+BZTI2f1nloTScWzvYjGLU=
X-Received: by 2002:a17:906:32d2:b0:aa6:3f03:7ab4 with SMTP id
 a640c23a62f3a-aa63f038759mr271379866b.46.1733509844053; Fri, 06 Dec 2024
 10:30:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
 <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com>
 <47f2a827d4946208e984110541e4324e653338e0.camel@gmail.com>
 <CAEf4BzZBPp40E-_itj1jFT2_+VSL9QcqjK4OQvt6sy5=iJx8Yw@mail.gmail.com>
 <4bbdf595be6afbe52f44c362be6d7e4f22b8b00f.camel@gmail.com>
 <CAADnVQKscY7UC-5nAYxaEM4FQZGiFdLUv-27O+-qvQqQX0To5A@mail.gmail.com>
 <1f77772b8c8775b922ae577a6c3877f6ada4a0a1.camel@gmail.com>
 <CAEf4BzZybLU0bmYJqH2XJYG_g8Pvm+STRdHBtE1c5zbhHvtrcg@mail.gmail.com>
 <CAADnVQJ7WuFge8YZ-g07VK6XhmMCf1RHa0B64O0_S4TLzu0yUg@mail.gmail.com>
 <CAEf4BzZPFy1XXf=2mXVpdVw70rJjgUfPnDOzWb5ZXrJF1=XqUA@mail.gmail.com>
 <CAADnVQL-0SAvibeS45arBoZcwYjQjVnsrMeny=xzptOdUOwdjQ@mail.gmail.com>
 <CAEf4BzZF3ZrVC0j=s2SpCyRWzfxS8Gcmh1vXomX4X=VS-COxJw@mail.gmail.com> <CAADnVQJ-y4G9TH-3kgau56OdijFQ4ua+_JNqv5VYFE7AzL418Q@mail.gmail.com>
In-Reply-To: <CAADnVQJ-y4G9TH-3kgau56OdijFQ4ua+_JNqv5VYFE7AzL418Q@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Dec 2024 19:30:07 +0100
Message-ID: <CAP01T74hPaBjmbpfaD4=KBu1TRm2+D=bUiLpMqEbXO9=DkX_yw@mail.gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, andrii <andrii@kernel.org>, Nick Zavaritsky <mejedi@gmail.com>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Dec 2024 at 19:26, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Dec 6, 2024 at 9:42=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> >
> > Or, *importantly*, if user anticipates that "freplace-ment" BPF
> > program for such subprog might need to invalidate packet pointers, but
> > the default subprog implementation doesn't actually call any of those
> > special helpers, user can just explicitly say that "yes, this subprog
> > should be treated as such that invalidates pkt pointers". With your
> > approach there is no way to even express this, unless you hack default
> > subprog implementation to intentionally have reachable
> > pkt-invalidating helper, but not really call it at runtime.
>
> Exactly.
> This artificial issue can be easily solved without tags.
> The nop subprog can have an empty call to bpf_skb_pull_data(skb, 0).
> And it will be much more obvious to anyone reading the C code
> instead of a magic tag.

Wouldn't it be less obvious? You would still need a fat comment
explaining why you're doing a dummy bpf_skb_pull_data, because
normally it wouldn't occur if it is to clear pkt pointers, and you
will say it's because it tells the verifier that it invalidates the
packet for the caller.

It would certainly be clear if we had a bpf_skb_clear_pkt_ptrs, which
would be a verifier built-in and no-op at runtime, but we don't. But
then that's the same as a tag.

>
> > No, it's not. It's conceptually absolutely the same. Verifier can
> > derive that global subprog arg has to be a trusted pointer. It's just
> > that with pkt invalidation it's trivial enough to detect (crudely and
> > eagerly, but still) in check_cfg(), while for trusted pointers you
> > can't take this shortcut.
>
> Not really. We only introduced the following tags:
> __arg_ctx
> __arg_trusted
> __arg_arena
> because the verifier cannot infer them.
> We are _not_ going to introduce __arg_dynptr as we argued in the past.
> Anything that can be expressed via normal C should stay in C.

