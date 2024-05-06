Return-Path: <bpf+bounces-28733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA348BD80A
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 01:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0944B21DA8
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 23:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D30015B99E;
	Mon,  6 May 2024 23:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFF/q6E/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1F51E492;
	Mon,  6 May 2024 23:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715037003; cv=none; b=p3PvvQdHYLfBGQ4RK8RDYMRSGf9KY8v8p+dercix1asilymhWj/C0g795D85t8dNFJtmlTQygwCeMM40oxzCo8JQKBuZX0FJWt6No1KnueafZKIDK+0XCFLyuCEzm758AFR7PUVK3Y19Om4uifmD1lGZ5K+L1ZHe3KrECvjNPZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715037003; c=relaxed/simple;
	bh=jb6AoaZ4+1JJOP5y0uiexhZgPhIBpaMIIaYEadS16Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dq7d/ztGS7bwT+R6gunl+rpBaUKKlGmSa6F4pTPuShoYV5XwtRNedSihydA/WtCkmPNKQUxWdsw/Cdxj/MhRNrMMwUhpWJwvnlRQNa6LKl+NfBOhYrXmFbEfXaV9sPvCdGSyx1EELzeYyysKInyuw5C79161SC/c8tGZNsBhOLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFF/q6E/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34db6a29a1eso1571042f8f.1;
        Mon, 06 May 2024 16:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715037000; x=1715641800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2djqDQE+yQ6VgjclssSW7VHfPd80JOhsReXmW/fEqXY=;
        b=nFF/q6E/ncV3MYvnMC7xKGOyT/arhdI5FKJ2nO17qmvlhvec75Ip4UFkbelMBZm7u+
         PBybAqvSwcZ9oDJ8hZ65h3OUtU6K6Tuy4OkIGMJU59xY9PCjEXwEAGoDPocnQ+odxFom
         N4Er+uN2wFHGu3eg6asD6OXFTuW6yF4gNJU933BhbVd4uV4tZ6+URa8Jwqd66UlaKEXz
         FEA2YE5NWTnaVcLhc7lKdA+UZIO5JJc7OE0mGh0wB5dw8+AOkZN8ljykJ0/x5DDTqv8I
         +nfXwAZgQyqRLuTHKeUPhB9EQwjDvTRuBnfJV5zlxfON94q4okZL4aKm22KMg0a5rCoU
         77jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715037000; x=1715641800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2djqDQE+yQ6VgjclssSW7VHfPd80JOhsReXmW/fEqXY=;
        b=GaQdPszgEpeawo3JT8tP1hTAO04LdGbkLuwmnMF5k9+FiNe9ikF2g8dgHY/iTVaqn2
         QExx9KJgqi2XrNYK6XUhBmP06jo4TO/obfKkG5vH2uOOp2yVDE2RseuD7jJ3P38Kfo12
         i0dQiiYiCDYH3GOwV1MxmcUr5OTn9d/3fSRb6HrLwZOGIPj1NIBG4iys3BKAKJRNQPkc
         Y39/1DsJlK+uTbiDY8KvJ6UBRY0qCl7H2VFQ78lnM1gP/R7I0Zybzh7ZdWbUIw/Z1JkM
         /vRIsPAzucIrNmB+6lWg8cHZxeu5uZN7vE/mYLjODOoLbA++Vl7U2FmCkbw2/QTmOAJr
         ZZ8g==
X-Forwarded-Encrypted: i=1; AJvYcCUaK882yAs7A/4I5W3SbVLAoLMrcy0nHYyak7mj5O7c+Hbrqn7BR12EfPEQSsWKRxjwIMCvyCHopGjpmcLmkC9+xbXZAYCJ3bMDumqOZVVj10hfF8NzN6R3fnBS4w1/r1ghl/lQ0j3Hhzfzd0zYYg0lMoT0GILyGM4p
X-Gm-Message-State: AOJu0YwXiLNQZKp11BEH1vJXozsm/o7CPlhnvv2FoznjxEQjEfl/rvpx
	mvMI2t9aD2zKDuZ1LTi82ZFnvMkPgmXNk4+reoPZJUOCLjlrRmLpeynVvEPL3K2WgGrClApeLjU
	9nEhgpMBIt8Ib/U5eE2pKEC6VAY4=
X-Google-Smtp-Source: AGHT+IGxLV8o+I20/ACsrxFvjlgXJfW+QBAHlbBignGmLULqLzAKyI21XMdrf96e9JbOwJvccCh16JA6cXe8ZtJOOVs=
X-Received: by 2002:adf:e60c:0:b0:34d:b993:fe6e with SMTP id
 p12-20020adfe60c000000b0034db993fe6emr8100162wrm.0.1715036999414; Mon, 06 May
 2024 16:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
 <20240503182957.1042122-15-bigeasy@linutronix.de> <87y18mohhp.fsf@toke.dk>
In-Reply-To: <87y18mohhp.fsf@toke.dk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 6 May 2024 16:09:47 -0700
Message-ID: <CAADnVQJkiwaYXUo+LyKoV96VFFCFL0VY5Jgpuv_0oypksrnciA@mail.gmail.com>
Subject: Re: [PATCH net-next 14/15] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eric Dumazet <edumazet@google.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Hao Luo <haoluo@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 12:41=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>
> > The XDP redirect process is two staged:
> > - bpf_prog_run_xdp() is invoked to run a eBPF program which inspects th=
e
> >   packet and makes decisions. While doing that, the per-CPU variable
> >   bpf_redirect_info is used.
> >
> > - Afterwards xdp_do_redirect() is invoked and accesses bpf_redirect_inf=
o
> >   and it may also access other per-CPU variables like xskmap_flush_list=
.
> >
> > At the very end of the NAPI callback, xdp_do_flush() is invoked which
> > does not access bpf_redirect_info but will touch the individual per-CPU
> > lists.
> >
> > The per-CPU variables are only used in the NAPI callback hence disablin=
g
> > bottom halves is the only protection mechanism. Users from preemptible
> > context (like cpu_map_kthread_run()) explicitly disable bottom halves
> > for protections reasons.
> > Without locking in local_bh_disable() on PREEMPT_RT this data structure
> > requires explicit locking.
> >
> > PREEMPT_RT has forced-threaded interrupts enabled and every
> > NAPI-callback runs in a thread. If each thread has its own data
> > structure then locking can be avoided.
> >
> > Create a struct bpf_net_context which contains struct bpf_redirect_info=
.
> > Define the variable on stack, use bpf_net_ctx_set() to save a pointer t=
o
> > it. Use the __free() annotation to automatically reset the pointer once
> > function returns.
> > The bpf_net_ctx_set() may nest. For instance a function can be used fro=
m
> > within NET_RX_SOFTIRQ/ net_rx_action which uses bpf_net_ctx_set() and
> > NET_TX_SOFTIRQ which does not. Therefore only the first invocations
> > updates the pointer.
> > Use bpf_net_ctx_get_ri() as a wrapper to retrieve the current struct
> > bpf_redirect_info.
> >
> > On PREEMPT_RT the pointer to bpf_net_context is saved task's
> > task_struct. On non-PREEMPT_RT builds the pointer saved in a per-CPU
> > variable (which is always NODE-local memory). Using always the
> > bpf_net_context approach has the advantage that there is almost zero
> > differences between PREEMPT_RT and non-PREEMPT_RT builds.
>
> Did you ever manage to get any performance data to see if this has an
> impact?
>
> [...]
>
> > +static inline struct bpf_net_context *bpf_net_ctx_get(void)
> > +{
> > +     struct bpf_net_context *bpf_net_ctx =3D this_cpu_read(bpf_net_con=
text);
> > +
> > +     WARN_ON_ONCE(!bpf_net_ctx);
>
> If we have this WARN...
>
> > +static inline struct bpf_redirect_info *bpf_net_ctx_get_ri(void)
> > +{
> > +     struct bpf_net_context *bpf_net_ctx =3D bpf_net_ctx_get();
> > +
> > +     if (!bpf_net_ctx)
> > +             return NULL;
>
> ... do we really need all the NULL checks?

Indeed.
Let's drop all NULL checks, since they definitely add overhead.
I'd also remove ifdef CONFIG_PREEMPT_RT and converge on single implementati=
on:
static inline struct bpf_net_context * bpf_net_ctx_get(void)
{
 return current->bpf_net_context;
}

