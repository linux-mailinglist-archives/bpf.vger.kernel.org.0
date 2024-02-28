Return-Path: <bpf+bounces-22884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C787986B3A4
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 16:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5500E1F29F34
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 15:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED2815CD7A;
	Wed, 28 Feb 2024 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AV9GFThM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E9515B990
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135337; cv=none; b=SbrW247tbfRJbd4rO43gUgxJ7IN0wksrYZAkT2lA5p++ovsOvAchFyhXVEqkuaZF9Q7EM79LZzTTDzXgSsgZoaJMvZFRu2F5c4dpBrYu49rAQwoD/1LXJ4Sn3aXBzp37EjUl5dGIVQmxUB1tfFwlJIog45BR/aMGWZHZsQVBiE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135337; c=relaxed/simple;
	bh=2l1p0FkVJJIA9aD06YUCULtHRpOuCYtkSMCuCgp9obs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QtnyPcTHZy45FvQmaoTLyMf422wpE/d0mBSXs6VV4j+0zRBeK3lzYy8cS0S5ZKG9NNyzYJ3dijVLdG3H5aGuIPffvuXehWF9cr5w3HnXg4aWIoXTblXRhlaRjl1zxnK/gnXg6yhIOITcM0PmeIKcnMO2NeY1PyFbJIvWkTxXwq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AV9GFThM; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-564fc495d83so6722785a12.0
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 07:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1709135333; x=1709740133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0acqoRsfoE0kZ4l/ZEfScsnB2Z0F6y/I1cj4Xx9Gu/I=;
        b=AV9GFThMIaiOJVpI5PfUgjZd9U0Sazv4ZnFOEMGUqTaWZPBEcEv72TI4lHAVH1yGiR
         09LPzq+icnWE7mb/ogqQ+rwON/ATozBgPArgfgjqUdi031NSF5v9kwto6f//uv0zbFnj
         8DWUHnh3QptET+R2c3zdvRvOL8bNVUkJ6T6Z2jOSYg9omUf2miQQYPcZAsXpRrS9Xt/P
         wp56rrrzvtHcRUbJypj1IaBa31b5Qif0BlF5ocffT8WSVwXWGjzL33q6L6UA4U82FaAI
         fBsXdVaXiKBtWtwBm4jyjHxXXpgwjqxYqnxNZ5GS4kCmIuShYMyp/P8t9e/ZAs0xQiIH
         +okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709135333; x=1709740133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0acqoRsfoE0kZ4l/ZEfScsnB2Z0F6y/I1cj4Xx9Gu/I=;
        b=iAXvOfxX/ERczBS8lzHpt7t78s1EPaStDmEXL/CsHjKnuGh87Ud9lhcBj7VxT4hX9T
         j5D4IDCARg0lBwfC3x3r2Ljt+Pvdd4ecIX2L44x+6H7wuUX0VFJa2A+msjHH7sJyzAcx
         5zw2twYlRd5SHqrmckmXhH3NP9OHKKqbFxxs+6ADxFoMm1Hkf6yAnQA+UfrTvRvOXIuQ
         LFSAu33ciS/wThz7HT77TFGyEQ5aSDYnDVlaZ09BgO3Cr+O77GVEX0PbqydkBS2TSfvR
         /aH1VtmdRrFORv+80wJnznBfxc37Me6Ncig5iFe5fd/nbWeZk1qloOkPmBwK7djcZlih
         laFw==
X-Forwarded-Encrypted: i=1; AJvYcCVjWOmIkAYDUn2Tr3veLemeGYZ+b/rkjRODFXNu6pMaFVbJAScKOm0rFrKw9kwUFhgSdNkKmcmCJtIB9+n2ggPK1nvR
X-Gm-Message-State: AOJu0YzT8ixE7Y+ULN1HqUtONGhK9SeoS8F5q+l8O6JBTkvfy7dqlZLC
	XkC9+wEaU98GHej1Oyoid/8swgb8bTw8qES12WhyYlQgNq/Ubn+6ZxhyyxGDERzG8+H05v+8ep0
	r3j/1tjCRe/+89jv3e1CsHSGO1Asb/lJ+3cIGLQ==
X-Google-Smtp-Source: AGHT+IH6aNVk09cB3BKpFmicAgoTrrf89CPJseyBBFpZq1osNLfkiSUTaktPPiTWbLXN0g4Fh9V9YOaHGTLIEoKLs4M=
X-Received: by 2002:a05:6402:1810:b0:566:4a85:ceb7 with SMTP id
 g16-20020a056402181000b005664a85ceb7mr3104478edy.28.1709135333422; Wed, 28
 Feb 2024 07:48:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zd4DXTyCf17lcTfq@debian.debian> <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
 <d633c5b9-53a5-4cd6-9dbb-6623bb74c00b@paulmck-laptop> <87edcwerj6.fsf@toke.dk>
 <6b6ce007-4527-494f-8d03-079f7bf139f9@paulmck-laptop>
In-Reply-To: <6b6ce007-4527-494f-8d03-079f7bf139f9@paulmck-laptop>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 28 Feb 2024 09:48:42 -0600
Message-ID: <CAO3-PbpPN0ASFbkgb1J=uBnY=hd6s4CPACRuQtWng_3Apsy_NQ@mail.gmail.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
To: paulmck@kernel.org
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 9:10=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Wed, Feb 28, 2024 at 12:50:53PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
> > "Paul E. McKenney" <paulmck@kernel.org> writes:
> >
> > > On Tue, Feb 27, 2024 at 05:44:17PM +0100, Eric Dumazet wrote:
> > >> On Tue, Feb 27, 2024 at 4:44=E2=80=AFPM Yan Zhai <yan@cloudflare.com=
> wrote:
> > >> >
> > >> > We noticed task RCUs being blocked when threaded NAPIs are very bu=
sy in
> > >> > production: detaching any BPF tracing programs, i.e. removing a ft=
race
> > >> > trampoline, will simply block for very long in rcu_tasks_wait_gp. =
This
> > >> > ranges from hundreds of seconds to even an hour, severely harming =
any
> > >> > observability tools that rely on BPF tracing programs. It can be
> > >> > easily reproduced locally with following setup:
> > >> >
> > >> > ip netns add test1
> > >> > ip netns add test2
> > >> >
> > >> > ip -n test1 link add veth1 type veth peer name veth2 netns test2
> > >> >
> > >> > ip -n test1 link set veth1 up
> > >> > ip -n test1 link set lo up
> > >> > ip -n test2 link set veth2 up
> > >> > ip -n test2 link set lo up
> > >> >
> > >> > ip -n test1 addr add 192.168.1.2/31 dev veth1
> > >> > ip -n test1 addr add 1.1.1.1/32 dev lo
> > >> > ip -n test2 addr add 192.168.1.3/31 dev veth2
> > >> > ip -n test2 addr add 2.2.2.2/31 dev lo
> > >> >
> > >> > ip -n test1 route add default via 192.168.1.3
> > >> > ip -n test2 route add default via 192.168.1.2
> > >> >
> > >> > for i in `seq 10 210`; do
> > >> >  for j in `seq 10 210`; do
> > >> >     ip netns exec test2 iptables -I INPUT -s 3.3.$i.$j -p udp --dp=
ort 5201
> > >> >  done
> > >> > done
> > >> >
> > >> > ip netns exec test2 ethtool -K veth2 gro on
> > >> > ip netns exec test2 bash -c 'echo 1 > /sys/class/net/veth2/threade=
d'
> > >> > ip netns exec test1 ethtool -K veth1 tso off
> > >> >
> > >> > Then run an iperf3 client/server and a bpftrace script can trigger=
 it:
> > >> >
> > >> > ip netns exec test2 iperf3 -s -B 2.2.2.2 >/dev/null&
> > >> > ip netns exec test1 iperf3 -c 2.2.2.2 -B 1.1.1.1 -u -l 1500 -b 3g =
-t 100 >/dev/null&
> > >> > bpftrace -e 'kfunc:__napi_poll{@=3Dcount();} interval:s:1{exit();}=
'
> > >> >
> > >> > Above reproduce for net-next kernel with following RCU and preempt
> > >> > configuraitons:
> > >> >
> > >> > # RCU Subsystem
> > >> > CONFIG_TREE_RCU=3Dy
> > >> > CONFIG_PREEMPT_RCU=3Dy
> > >> > # CONFIG_RCU_EXPERT is not set
> > >> > CONFIG_SRCU=3Dy
> > >> > CONFIG_TREE_SRCU=3Dy
> > >> > CONFIG_TASKS_RCU_GENERIC=3Dy
> > >> > CONFIG_TASKS_RCU=3Dy
> > >> > CONFIG_TASKS_RUDE_RCU=3Dy
> > >> > CONFIG_TASKS_TRACE_RCU=3Dy
> > >> > CONFIG_RCU_STALL_COMMON=3Dy
> > >> > CONFIG_RCU_NEED_SEGCBLIST=3Dy
> > >> > # end of RCU Subsystem
> > >> > # RCU Debugging
> > >> > # CONFIG_RCU_SCALE_TEST is not set
> > >> > # CONFIG_RCU_TORTURE_TEST is not set
> > >> > # CONFIG_RCU_REF_SCALE_TEST is not set
> > >> > CONFIG_RCU_CPU_STALL_TIMEOUT=3D21
> > >> > CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=3D0
> > >> > # CONFIG_RCU_TRACE is not set
> > >> > # CONFIG_RCU_EQS_DEBUG is not set
> > >> > # end of RCU Debugging
> > >> >
> > >> > CONFIG_PREEMPT_BUILD=3Dy
> > >> > # CONFIG_PREEMPT_NONE is not set
> > >> > CONFIG_PREEMPT_VOLUNTARY=3Dy
> > >> > # CONFIG_PREEMPT is not set
> > >> > CONFIG_PREEMPT_COUNT=3Dy
> > >> > CONFIG_PREEMPTION=3Dy
> > >> > CONFIG_PREEMPT_DYNAMIC=3Dy
> > >> > CONFIG_PREEMPT_RCU=3Dy
> > >> > CONFIG_HAVE_PREEMPT_DYNAMIC=3Dy
> > >> > CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=3Dy
> > >> > CONFIG_PREEMPT_NOTIFIERS=3Dy
> > >> > # CONFIG_DEBUG_PREEMPT is not set
> > >> > # CONFIG_PREEMPT_TRACER is not set
> > >> > # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> > >> >
> > >> > An interesting observation is that, while tasks RCUs are blocked,
> > >> > related NAPI thread is still being scheduled (even across cores)
> > >> > regularly. Looking at the gp conditions, I am inclining to cond_re=
sched
> > >> > after each __napi_poll being the problem: cond_resched enters the
> > >> > scheduler with PREEMPT bit, which does not account as a gp for tas=
ks
> > >> > RCUs. Meanwhile, since the thread has been frequently resched, the
> > >> > normal scheduling point (no PREEMPT bit, accounted as a task RCU g=
p)
> > >> > seems to have very little chance to kick in. Given the nature of "=
busy
> > >> > polling" program, such NAPI thread won't have task->nvcsw or task-=
>on_rq
> > >> > updated (other gp conditions), the result is that such NAPI thread=
 is
> > >> > put on RCU holdouts list for indefinitely long time.
> > >> >
> > >> > This is simply fixed by mirroring the ksoftirqd behavior: after
> > >> > NAPI/softirq work, raise a RCU QS to help expedite the RCU period.=
 No
> > >> > more blocking afterwards for the same setup.
> > >> >
> > >> > Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop =
support")
> > >> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > >> > ---
> > >> >  net/core/dev.c | 4 ++++
> > >> >  1 file changed, 4 insertions(+)
> > >> >
> > >> > diff --git a/net/core/dev.c b/net/core/dev.c
> > >> > index 275fd5259a4a..6e41263ff5d3 100644
> > >> > --- a/net/core/dev.c
> > >> > +++ b/net/core/dev.c
> > >> > @@ -6773,6 +6773,10 @@ static int napi_threaded_poll(void *data)
> > >> >                                 net_rps_action_and_irq_enable(sd);
> > >> >                         }
> > >> >                         skb_defer_free_flush(sd);
> > >
> > > Please put a comment here stating that RCU readers cannot cross
> > > this point.
> > >
> > > I need to add lockdep to rcu_softirq_qs() to catch placing this in an
> > > RCU read-side critical section.  And a header comment noting that fro=
m
> > > an RCU perspective, it acts as a momentary enabling of preemption.
> >
> > OK, so one question here: for XDP, we're basically treating
> > local_bh_disable/enable() as the RCU critical section, cf the discussio=
n
> > we had a few years ago that led to this being documented[0]. So why is
> > it OK to have the rcu_softirq_qs() inside the bh disable/enable pair,
> > but not inside an rcu_read_lock() section?
>
> In general, it is not OK.  And it is not OK in this case if this happens
> to be one of the local_bh_disable() regions that XDP is waiting on.
> Except that that region ends right after the rcu_softirq_qs(), so that
> should not be a problem.
>
> But you are quite right, that is an accident waiting to happen, so it
> would be better if the patch did something like this:
>
>         local_bh_enable();
>         if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
>                 preempt_disable();
>                 rcu_softirq_qs();
>                 preempt_enable();
>         }
>
Yeah we need preempt for this call. When I first attempt it after
local_bh_enable, I got the bug call:
[ 1166.384279] BUG: using __this_cpu_read() in preemptible [00000000]
code: napi/veth2-66/8439
[ 1166.385337] caller is rcu_softirq_qs+0x16/0x130
[ 1166.385900] CPU: 3 PID: 8439 Comm: napi/veth2-66 Not tainted
6.7.0-rc8-g3fbf61207c66-dirty #75
[ 1166.386950] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 1166.388110] Call Trace:
[ 1166.388417]  <TASK>
[ 1166.388684]  dump_stack_lvl+0x36/0x50
[ 1166.389147]  check_preemption_disabled+0xd1/0xe0
[ 1166.389725]  rcu_softirq_qs+0x16/0x130
[ 1166.390190]  napi_threaded_poll+0x21e/0x260
[ 1166.390702]  ? __pfx_napi_threaded_poll+0x10/0x10
[ 1166.391277]  kthread+0xf7/0x130
[ 1166.391643]  ? __pfx_kthread+0x10/0x10
[ 1166.392130]  ret_from_fork+0x34/0x50
[ 1166.392574]  ? __pfx_kthread+0x10/0x10
[ 1166.393048]  ret_from_fork_asm+0x1b/0x30
[ 1166.393530]  </TASK>

Since this patch is trying to mirror what __do_softirq has, should the
similar notes/changes apply to that side as well?


> Though maybe something like this would be better:
>
>         local_bh_enable();
>         if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>                 rcu_softirq_qs_enable(local_bh_enable());
>         else
>                 local_bh_enable();
>
> A bit ugly, but it does allow exact checking of the rules and also
> avoids extra overhead.
>
> I could imagine pulling the CONFIG_PREEMPT_RT check into the body of
> rcu_softirq_qs_enable().
>
> But is there a better way?
>
> > Also, looking at the patch in question:
> >
> > >> > +                       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> > >> > +                               rcu_softirq_qs();
> > >> > +
> > >> >                         local_bh_enable();
> >
> > Why does that local_bh_enable() not accomplish the same thing as the qs=
?
>
> In this case, because it does not create the appearance of a voluntary
> context switch needed by RCU Tasks.  So the wait for trampoline evacuatio=
n
> could still take a very long time.
>
>                                                         Thanx, Paul
>
> > -Toke
> >
> > [0] https://lore.kernel.org/bpf/20210624160609.292325-6-toke@redhat.com=
/
> >

