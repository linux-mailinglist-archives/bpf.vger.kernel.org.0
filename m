Return-Path: <bpf+bounces-23130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4299C86DD1F
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 09:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91E8BB264E1
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 08:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2E869E0C;
	Fri,  1 Mar 2024 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rGXprctB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364FC47F6A
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 08:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281846; cv=none; b=mXZoaDEAhMs6HKwg0U6ZRjbyw0ApRlA0Yp1GDnxopFsgN05r9sW3Lup6jYIyxY6UEp2DfIeE/GBMegFIN5CjqE2ktzJZwtc5skBkuM7ENLtrWZERimizNyiy7yX1nAMQ+t8dWDmFAz3mM3DXZFcylttVskGJZ7omAtgMILo+XcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281846; c=relaxed/simple;
	bh=kmXMD5wxosP4C0HytvGYV8f6rRp1M0hxu3/wjfE2CJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDd6k2oL9Vp0EB5SGyIlaqWQefIgk6OpPodr9FiaSeil2O03/dwqeudOQj075Z59BVrn5hwl6lg5+NKL5yCwGofIWN4me35tgGiceImMB3a6L/jtesTHuLmXc2IpFKnPUit7o0hdZng6KD5Vd5wgIVep7Fphn6MsK1umjmxJ+Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rGXprctB; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso8664a12.0
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 00:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709281843; x=1709886643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmXMD5wxosP4C0HytvGYV8f6rRp1M0hxu3/wjfE2CJ8=;
        b=rGXprctBDcRXELGRZjuJjUglDPm4/EGZQqkhXTQ/CVqpVjQ1vO9ClIB8VJjDsvvzP1
         tHuX1uKzcss99uesUQNo9NHEU9IyAb9Shd9sh/E2QYacSWlO6ZzpeUxa4+7s2f3lkUv6
         uQr7OSexv1DfIFUVmSmu95u9vPNExqqW55M57ibHkpn1sLBhaT62BIm+Rrm3mM9IVCwh
         bKpWGSSKogKIJo+g+yM20PUXg8Qmx0NQvWzXdFNTQUdvETtkym/AJrv12ylTlsF2IinR
         S5kIL44DHvqujGfOKlT0HHV7EH7j3nYIASHUxNMZ2a6DIV/G6WJarQI/8oo18olAoMni
         MALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709281843; x=1709886643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmXMD5wxosP4C0HytvGYV8f6rRp1M0hxu3/wjfE2CJ8=;
        b=k7DUBJBSYYXg6aMn9r5rkGkuul9kt4ylXa08CwYgFzS3pgbb/mJ3NUM7Xmyf6EbmW7
         n0SXJgyO2GgBE8z24ntAvcAdTWzw1nngUQaX0IjJNTqgoz79Uo438lI6kJvcnYkJ/LDn
         Pqy32s79Fxr1fy+lvKN5SviR+GcFmy9gQl3HuXbZGDB14z4pkKMKGGgEBnd7Elzz3Yqy
         bYFvX1tmNmxN1WdYsyHI3aWJCyQ+Ijlsd5LVmnwhnvq/CdYbJW/fHO9MbjD9PVonch/N
         yspvwdh1/8RD2SpPOoRs/OGKE672kMO8VI3mFjYhqQtL9c4ebWm1PApprAF5EVHOPctO
         uwNg==
X-Forwarded-Encrypted: i=1; AJvYcCU7KqctQw1pdVkT1TxJm/SY9IHYcKan70pMsd7wl2rB4tg3P5ueyT0aQqsh6NlrpJYlhU5tkOB0+2/IxtWn7R+0bt9W
X-Gm-Message-State: AOJu0Yyumyk2yF0t7s63tXVDYEuC0lN3KeR5d1Qro4F25Hp4KPkmXrtw
	u81Ytzstf+7bmYLltZg/qmkOKWZAbRQUsG7275R2+zWOd507sEQNuFbfYGSpue1wG4wxknH80fU
	htM4QvmFn0wKl2dTV+O+ujFMQ0EXcBRioAZeY
X-Google-Smtp-Source: AGHT+IEwf1M0NlR4bQMpE6O2swlKwBptVLThyMgoIRxdaxLQgX35Cs6YnZnFaBd9av2rZ/03Z91FM2azqVxy5Ou4Vt8=
X-Received: by 2002:a05:6402:b10:b0:565:ad42:b97d with SMTP id
 bm16-20020a0564020b1000b00565ad42b97dmr90989edb.0.1709281843426; Fri, 01 Mar
 2024 00:30:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZeFPz4D121TgvCje@debian.debian> <CAO3-PboqKqjqrAScqzu6aB8d+fOq97_Wuz8b7d5uoMKT-+-WvQ@mail.gmail.com>
In-Reply-To: <CAO3-PboqKqjqrAScqzu6aB8d+fOq97_Wuz8b7d5uoMKT-+-WvQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Mar 2024 09:30:32 +0100
Message-ID: <CANn89iLCv0f3vBYt8W+_ZDuNeOY1jDLDBfMbOj7Hzi8s0xQCZA@mail.gmail.com>
Subject: Re: [PATCH v2] net: raise RCU qs after each threaded NAPI poll
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com, Joel Fernandes <joel@joelfernandes.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 4:50=E2=80=AFAM Yan Zhai <yan@cloudflare.com> wrote:
>
> On Thu, Feb 29, 2024 at 9:47=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wro=
te:
> >
> > We noticed task RCUs being blocked when threaded NAPIs are very busy at
> > workloads: detaching any BPF tracing programs, i.e. removing a ftrace
> > trampoline, will simply block for very long in rcu_tasks_wait_gp. This
> > ranges from hundreds of seconds to even an hour, severely harming any
...
> >
> > Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop suppo=
rt")
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > ---
> > v1->v2: moved rcu_softirq_qs out from bh critical section, and only
> > raise it after a second of repolling. Added some brief perf test result=
.
> >
> Link to v1: https://lore.kernel.org/netdev/Zd4DXTyCf17lcTfq@debian.debian=
/T/#u
> And I apparently forgot to rename the subject since it's not raising
> after every poll (let me know if it is prefered to send a V3 to fix
> it)
>

I could not see the reason for 1sec (HZ) delays.

Would calling rcu_softirq_qs() every ~10ms instead be a serious issue ?

In anycase, if this all about rcu_tasks, I would prefer using a macro
defined in kernel/rcu/tasks.h
instead of having a hidden constant in a networking core function.

Thanks.

