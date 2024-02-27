Return-Path: <bpf+bounces-22797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D530E86A191
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 22:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3C928E10B
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 21:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F22614F972;
	Tue, 27 Feb 2024 21:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bRfHDvAC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F8B14EFEB
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709068992; cv=none; b=I7sdwFY6rJHyCaogjgwvP/pgPXC61kxqctNHxGT0jWbrWmAhWo7NAijuxE1aQA8pocav6V+tDcp2Q5z7Sl446/xi4HRc7ufGErdtOouNO2/9M1bEgZ4OgAOuOAFYKZzS9341v6U/8N7WuZZj4VIWlz1h9aP+XhEB0ImnRJCon0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709068992; c=relaxed/simple;
	bh=EbE0NpjDsX2f82kmxrArsWy71nW9ItuJ2Y3sA+HtFsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loV/vgsRG3nYUH40YbZmR5WmqL4gu6E6bHUo9YsJrSLg7/tN+t+T158D01fS86zm3JXIy80D/1SXSFilM3HLIrmPAkFD/Vwb+WdMz2USLVB/92KM68vlFvnHEOZXPH1CwgxOlXR9JLK5rnAJ9cJKVNEWz7UglnLfc+dC90h4fLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bRfHDvAC; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-565ef8af2f5so3347272a12.3
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 13:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1709068988; x=1709673788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhErYklq/EJPQHwU+q7yFPhN9tYP/IYN1YoBwGWgE3U=;
        b=bRfHDvACxttR2PALUf0DnK+G3/FSee3l2zXGVIBjPH3Lh0E9DmrPLpfdJBBbNF4eQj
         uxI0PqL+/RkxG7DF6CUwdYEI+mTmZezXjFtDic2we0khgK9m0EIvO4WBcpdnN4EtLFtw
         XupYlgsGdZSdnodONJXdK2zMq/HKlj+ibH1P+c4AYIe0hGGKLhQr/OkfXRSZ6TJ2C7P9
         jqfpvBe1ouhCzFWEIsmfuzglxUCbaQyTvt3km34xrTRQqfa2lcb3ENOE4VkgDk+pfcXF
         fW3FAThtk28QgAH+Mv4ngfJVL4t31lDxFQwtZgeRjOXxbAetnuh6wqsk7Zk/7dTF9ngR
         mtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709068988; x=1709673788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhErYklq/EJPQHwU+q7yFPhN9tYP/IYN1YoBwGWgE3U=;
        b=hiY928XMC4Yv8hWaYxfCidm+2Ul0MWY/S1H5PucAO0GiQvbo/vxIoE485qR1K6E1bN
         61WcA4Xcc1XRw7Av2aYeG4TSYzNFIctoJIKECH7BipqdbOvrkqSCWMZTqVYdVhJGsSe+
         BlSB7DUwflOvjy0VIrhClcrx7XOPTlgwJiGRstmXx7yuSEwgai0TVbbLviwOhXA1u4lj
         7+hEwUVKF7VSjypdlY/UnFaHg6Qc+jt3pCFTWsKQ3qCHmmH1T8mSYSxUqe3DpEjyi1cU
         ta1y9HvQQ21F6aZVFdTJ7Aa17l3+PEYouAQRuYFZkS/xo9wLmDRu19Wo/4TjvaSXR55P
         sCMg==
X-Forwarded-Encrypted: i=1; AJvYcCUORgKZ2/51KbQEToomuyd2t4zmSPtu5W8RrFar18vIr4ZN30GzAWvZGSceqKgBfJQSkB68s4TX1QSBUogxdPWg6abH
X-Gm-Message-State: AOJu0YyH4cV3faq3moARPsU7rAeDat9BNLfsz56IdOgitTejosXtpP8s
	OSS+K/5I1MSNXmpzx9LydG+5KaY+Jl89eHU7EnEZeQP0Mtwl+0SkpPqVfqL+dhRvEV971DppX3D
	ZQdeXnI2y8hdC5ySw8lZ40YdbDw8wfhayBlVbPg==
X-Google-Smtp-Source: AGHT+IHqc2xzkwbAvcr5fQRGREMJd5T6r7kytrtxnzTAlan3DZ9TQlMAdMMuov7gUcj7CaeWUm/8tYXHjdtK2PIKMfA=
X-Received: by 2002:aa7:c456:0:b0:565:9fff:6046 with SMTP id
 n22-20020aa7c456000000b005659fff6046mr6700370edr.3.1709068988451; Tue, 27 Feb
 2024 13:23:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zd4DXTyCf17lcTfq@debian.debian> <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
 <d633c5b9-53a5-4cd6-9dbb-6623bb74c00b@paulmck-laptop>
In-Reply-To: <d633c5b9-53a5-4cd6-9dbb-6623bb74c00b@paulmck-laptop>
From: Yan Zhai <yan@cloudflare.com>
Date: Tue, 27 Feb 2024 15:22:57 -0600
Message-ID: <CAO3-Pbp8uhWOwszbBq75kpXm+=nQphZbej1xwGCtkxeG62ou5g@mail.gmail.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
To: paulmck@kernel.org
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 12:32=E2=80=AFPM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Tue, Feb 27, 2024 at 05:44:17PM +0100, Eric Dumazet wrote:
> > On Tue, Feb 27, 2024 at 4:44=E2=80=AFPM Yan Zhai <yan@cloudflare.com> w=
rote:
> > >
> > > We noticed task RCUs being blocked when threaded NAPIs are very busy =
in
> > > production: detaching any BPF tracing programs, i.e. removing a ftrac=
e
> > > trampoline, will simply block for very long in rcu_tasks_wait_gp. Thi=
s
> > > ranges from hundreds of seconds to even an hour, severely harming any
> > > observability tools that rely on BPF tracing programs. It can be
> > > easily reproduced locally with following setup:
> > >
> > > ip netns add test1
> > > ip netns add test2
> > >
> > > ip -n test1 link add veth1 type veth peer name veth2 netns test2
> > >
> > > ip -n test1 link set veth1 up
> > > ip -n test1 link set lo up
> > > ip -n test2 link set veth2 up
> > > ip -n test2 link set lo up
> > >
> > > ip -n test1 addr add 192.168.1.2/31 dev veth1
> > > ip -n test1 addr add 1.1.1.1/32 dev lo
> > > ip -n test2 addr add 192.168.1.3/31 dev veth2
> > > ip -n test2 addr add 2.2.2.2/31 dev lo
> > >
> > > ip -n test1 route add default via 192.168.1.3
> > > ip -n test2 route add default via 192.168.1.2
> > >
> > > for i in `seq 10 210`; do
> > >  for j in `seq 10 210`; do
> > >     ip netns exec test2 iptables -I INPUT -s 3.3.$i.$j -p udp --dport=
 5201
> > >  done
> > > done
> > >
> > > ip netns exec test2 ethtool -K veth2 gro on
> > > ip netns exec test2 bash -c 'echo 1 > /sys/class/net/veth2/threaded'
> > > ip netns exec test1 ethtool -K veth1 tso off
> > >
> > > Then run an iperf3 client/server and a bpftrace script can trigger it=
:
> > >
> > > ip netns exec test2 iperf3 -s -B 2.2.2.2 >/dev/null&
> > > ip netns exec test1 iperf3 -c 2.2.2.2 -B 1.1.1.1 -u -l 1500 -b 3g -t =
100 >/dev/null&
> > > bpftrace -e 'kfunc:__napi_poll{@=3Dcount();} interval:s:1{exit();}'
> > >
> > > Above reproduce for net-next kernel with following RCU and preempt
> > > configuraitons:
> > >
> > > # RCU Subsystem
> > > CONFIG_TREE_RCU=3Dy
> > > CONFIG_PREEMPT_RCU=3Dy
> > > # CONFIG_RCU_EXPERT is not set
> > > CONFIG_SRCU=3Dy
> > > CONFIG_TREE_SRCU=3Dy
> > > CONFIG_TASKS_RCU_GENERIC=3Dy
> > > CONFIG_TASKS_RCU=3Dy
> > > CONFIG_TASKS_RUDE_RCU=3Dy
> > > CONFIG_TASKS_TRACE_RCU=3Dy
> > > CONFIG_RCU_STALL_COMMON=3Dy
> > > CONFIG_RCU_NEED_SEGCBLIST=3Dy
> > > # end of RCU Subsystem
> > > # RCU Debugging
> > > # CONFIG_RCU_SCALE_TEST is not set
> > > # CONFIG_RCU_TORTURE_TEST is not set
> > > # CONFIG_RCU_REF_SCALE_TEST is not set
> > > CONFIG_RCU_CPU_STALL_TIMEOUT=3D21
> > > CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=3D0
> > > # CONFIG_RCU_TRACE is not set
> > > # CONFIG_RCU_EQS_DEBUG is not set
> > > # end of RCU Debugging
> > >
> > > CONFIG_PREEMPT_BUILD=3Dy
> > > # CONFIG_PREEMPT_NONE is not set
> > > CONFIG_PREEMPT_VOLUNTARY=3Dy
> > > # CONFIG_PREEMPT is not set
> > > CONFIG_PREEMPT_COUNT=3Dy
> > > CONFIG_PREEMPTION=3Dy
> > > CONFIG_PREEMPT_DYNAMIC=3Dy
> > > CONFIG_PREEMPT_RCU=3Dy
> > > CONFIG_HAVE_PREEMPT_DYNAMIC=3Dy
> > > CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=3Dy
> > > CONFIG_PREEMPT_NOTIFIERS=3Dy
> > > # CONFIG_DEBUG_PREEMPT is not set
> > > # CONFIG_PREEMPT_TRACER is not set
> > > # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> > >
> > > An interesting observation is that, while tasks RCUs are blocked,
> > > related NAPI thread is still being scheduled (even across cores)
> > > regularly. Looking at the gp conditions, I am inclining to cond_resch=
ed
> > > after each __napi_poll being the problem: cond_resched enters the
> > > scheduler with PREEMPT bit, which does not account as a gp for tasks
> > > RCUs. Meanwhile, since the thread has been frequently resched, the
> > > normal scheduling point (no PREEMPT bit, accounted as a task RCU gp)
> > > seems to have very little chance to kick in. Given the nature of "bus=
y
> > > polling" program, such NAPI thread won't have task->nvcsw or task->on=
_rq
> > > updated (other gp conditions), the result is that such NAPI thread is
> > > put on RCU holdouts list for indefinitely long time.
> > >
> > > This is simply fixed by mirroring the ksoftirqd behavior: after
> > > NAPI/softirq work, raise a RCU QS to help expedite the RCU period. No
> > > more blocking afterwards for the same setup.
> > >
> > > Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop sup=
port")
> > > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > > ---
> > >  net/core/dev.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 275fd5259a4a..6e41263ff5d3 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -6773,6 +6773,10 @@ static int napi_threaded_poll(void *data)
> > >                                 net_rps_action_and_irq_enable(sd);
> > >                         }
> > >                         skb_defer_free_flush(sd);
>
> Please put a comment here stating that RCU readers cannot cross
> this point.
>
> I need to add lockdep to rcu_softirq_qs() to catch placing this in an
> RCU read-side critical section.  And a header comment noting that from
> an RCU perspective, it acts as a momentary enabling of preemption.
>
Just to clarify, do you mean I should state that this polling function
can not be called from within an RCU read critical section? Or do you
mean any read critical sections need to end before raising this QS?

Yan

> > > +                       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> > > +                               rcu_softirq_qs();
> > > +
> > >                         local_bh_enable();
> > >
> > >                         if (!repoll)
> > > --
> > > 2.30.2
> > >
> >
> > Hmm....
> > Why napi_busy_loop() does not have a similar problem ?
> >
> > It is unclear why rcu_all_qs() in __cond_resched() is guarded by
> >
> > #ifndef CONFIG_PREEMPT_RCU
> >      rcu_all_qs();
> > #endif
>
> The theory is that PREEMPT_RCU kernels have preemption, and get their
> quiescent states that way.
>
> The more recent practice involves things like PREEMPT_DYNAMIC and maybe
> soon PREEMPT_AUTO, which might require adjustments, so thank you for
> pointing this out!
>
> Back on the patch, my main other concern is that someone somewhere might
> be using something like synchronize_rcu() to wait for all in-progress
> softirq handlers to complete.  But I don't know of such a thing, and if
> there is, there are workarounds, including synchronize_rcu_tasks().
>
> So something to be aware of, not (as far as I know) something to block
> this commit.
>
> With the added comment:
>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
>
>                                                         Thanx, Paul

