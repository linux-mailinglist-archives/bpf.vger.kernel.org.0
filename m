Return-Path: <bpf+bounces-22777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CA7869CA1
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 17:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECED8287D85
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 16:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2600A24205;
	Tue, 27 Feb 2024 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B1FOEuLn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1AF208A4
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052275; cv=none; b=JEQ3jXvvboR0jCRfDaX4BestAk95Twtu9Nmr9TFFW9daMUoNjm9fi7tzk+KYB9NpostT8ouLLhhBkYtG3pkPTLwBq8oZMhReZmIlwJVY5lfQcIfDLCGKAtz7M13tNGCIjDWWoeqUcVxs7HK/z4FgOAswExocM9RSo3fPivHAojs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052275; c=relaxed/simple;
	bh=8L9o+rkshv7jCoxYQ1OSs1r5Tuu6hIBgXJukq+nieLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LoIUHTqtCZ527Shi9TU7t0qjH7mzPVhEA1Zzo8Igl8ExpKOjG7HlIIIvMjQuQEA9pPLoy6yB1OggTNKdczyIxvlZZMVDj0oTE7C7o8JQYrnI5t09IL4JtlFp24N9O6o6WwJjcnSOZdBm+ckfG3ity9WftlGdbZot9/c2v1n9aWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B1FOEuLn; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so13480a12.1
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 08:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709052272; x=1709657072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y67+F1ljFr7EvcM7vrsKGJMZCewGN818+2H79M1Cvug=;
        b=B1FOEuLnt/8hSJBh3wUIemO8PpPk3LCgmYqZWxXZrBQWZCXQfkA1Vey782oxfFvz/T
         5HIve13wZ/jAsW73fQR4tJUqV4vWVLwKWvXrvc7A+cVFQlJoDVkbQ18a0CFjdLjRgub9
         0sZIIqd0wdoLyHwKah0tq5kDVJg8H/3R/gm2ejmBWg+QihVzLdMYTma9Qd6CgZDiGVLl
         C2M9hFc3noLTca+6gTGagUUkkZaRSPBvg1lURs9jXwlsz8LPkZFwfuPPgcDAGCAAuKlx
         D9uIl1kMgb8naoOEpHLyYuvPi0aMoWicGvp3jjT9SNifY4AQGk5zJ0W9kidwdFv112LK
         eQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709052272; x=1709657072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y67+F1ljFr7EvcM7vrsKGJMZCewGN818+2H79M1Cvug=;
        b=puMng1LRNGDnZtNdGpSGF4bxYoW4SV388WxpStNtYhqA0hxpU3qAXm+vk89BS/Nqzg
         /y1KFZGQPT23d4shf9+j94LuS5W5nafQT86ImZeC9gQPaNX6WBMJsrAJjoveWHjZnI88
         WuwvAnN3+GZCYWF2KuS55QBaKgGpgfLmN+Bndyixn0ReKnRrVBKWegZjgvJlDuvj5g00
         Gko6h1LLbOy2r7cq4tgF+fqouRHpWgDSUAprG0lDhjVfUUUjJKBpg7hVG8TNuz2pgRN6
         VRfjVW30Rs08WtEj6AVEAJa/Si5jIEVgd3eu8fLteAwNto6ImMQ0Q0bGN/jMFXqW5tRz
         svSA==
X-Forwarded-Encrypted: i=1; AJvYcCUeplLLe7rJGSf8k1W04hD05a9XmeV0PKWEol1wfI0HL5K4w9n2/vxJetEfL2GnkGnMMqNa9+aWGoVChcHTVNtWva7y
X-Gm-Message-State: AOJu0YwXicEFOy4NDgt028mQG8X0aJJBrt6qbrrnUWHkLp87xsXfxKeA
	AEDUqJr3KN5S2l5J+CeLVR4eoRtDH1KZz7Ko7L4O/MGqDKxhxos2vSpnAJGw11Np0jUGeZL9Doy
	02uIvTNqMD5Cxc2pBTsc/xsquEgsXT01zhA4L
X-Google-Smtp-Source: AGHT+IHJEIutuvD5mT3lzoYNxTYBdXitRMfqCawctD2clmn+EK2ztXIcJWsbARjP3/Zy2n0mCTYUoL9z4fZMXvDxHhg=
X-Received: by 2002:a50:9ea5:0:b0:55f:8851:d03b with SMTP id
 a34-20020a509ea5000000b0055f8851d03bmr198565edf.5.1709052271564; Tue, 27 Feb
 2024 08:44:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zd4DXTyCf17lcTfq@debian.debian>
In-Reply-To: <Zd4DXTyCf17lcTfq@debian.debian>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 27 Feb 2024 17:44:17 +0100
Message-ID: <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 4:44=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> We noticed task RCUs being blocked when threaded NAPIs are very busy in
> production: detaching any BPF tracing programs, i.e. removing a ftrace
> trampoline, will simply block for very long in rcu_tasks_wait_gp. This
> ranges from hundreds of seconds to even an hour, severely harming any
> observability tools that rely on BPF tracing programs. It can be
> easily reproduced locally with following setup:
>
> ip netns add test1
> ip netns add test2
>
> ip -n test1 link add veth1 type veth peer name veth2 netns test2
>
> ip -n test1 link set veth1 up
> ip -n test1 link set lo up
> ip -n test2 link set veth2 up
> ip -n test2 link set lo up
>
> ip -n test1 addr add 192.168.1.2/31 dev veth1
> ip -n test1 addr add 1.1.1.1/32 dev lo
> ip -n test2 addr add 192.168.1.3/31 dev veth2
> ip -n test2 addr add 2.2.2.2/31 dev lo
>
> ip -n test1 route add default via 192.168.1.3
> ip -n test2 route add default via 192.168.1.2
>
> for i in `seq 10 210`; do
>  for j in `seq 10 210`; do
>     ip netns exec test2 iptables -I INPUT -s 3.3.$i.$j -p udp --dport 520=
1
>  done
> done
>
> ip netns exec test2 ethtool -K veth2 gro on
> ip netns exec test2 bash -c 'echo 1 > /sys/class/net/veth2/threaded'
> ip netns exec test1 ethtool -K veth1 tso off
>
> Then run an iperf3 client/server and a bpftrace script can trigger it:
>
> ip netns exec test2 iperf3 -s -B 2.2.2.2 >/dev/null&
> ip netns exec test1 iperf3 -c 2.2.2.2 -B 1.1.1.1 -u -l 1500 -b 3g -t 100 =
>/dev/null&
> bpftrace -e 'kfunc:__napi_poll{@=3Dcount();} interval:s:1{exit();}'
>
> Above reproduce for net-next kernel with following RCU and preempt
> configuraitons:
>
> # RCU Subsystem
> CONFIG_TREE_RCU=3Dy
> CONFIG_PREEMPT_RCU=3Dy
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=3Dy
> CONFIG_TREE_SRCU=3Dy
> CONFIG_TASKS_RCU_GENERIC=3Dy
> CONFIG_TASKS_RCU=3Dy
> CONFIG_TASKS_RUDE_RCU=3Dy
> CONFIG_TASKS_TRACE_RCU=3Dy
> CONFIG_RCU_STALL_COMMON=3Dy
> CONFIG_RCU_NEED_SEGCBLIST=3Dy
> # end of RCU Subsystem
> # RCU Debugging
> # CONFIG_RCU_SCALE_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_RCU_REF_SCALE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=3D21
> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=3D0
> # CONFIG_RCU_TRACE is not set
> # CONFIG_RCU_EQS_DEBUG is not set
> # end of RCU Debugging
>
> CONFIG_PREEMPT_BUILD=3Dy
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=3Dy
> # CONFIG_PREEMPT is not set
> CONFIG_PREEMPT_COUNT=3Dy
> CONFIG_PREEMPTION=3Dy
> CONFIG_PREEMPT_DYNAMIC=3Dy
> CONFIG_PREEMPT_RCU=3Dy
> CONFIG_HAVE_PREEMPT_DYNAMIC=3Dy
> CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=3Dy
> CONFIG_PREEMPT_NOTIFIERS=3Dy
> # CONFIG_DEBUG_PREEMPT is not set
> # CONFIG_PREEMPT_TRACER is not set
> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
>
> An interesting observation is that, while tasks RCUs are blocked,
> related NAPI thread is still being scheduled (even across cores)
> regularly. Looking at the gp conditions, I am inclining to cond_resched
> after each __napi_poll being the problem: cond_resched enters the
> scheduler with PREEMPT bit, which does not account as a gp for tasks
> RCUs. Meanwhile, since the thread has been frequently resched, the
> normal scheduling point (no PREEMPT bit, accounted as a task RCU gp)
> seems to have very little chance to kick in. Given the nature of "busy
> polling" program, such NAPI thread won't have task->nvcsw or task->on_rq
> updated (other gp conditions), the result is that such NAPI thread is
> put on RCU holdouts list for indefinitely long time.
>
> This is simply fixed by mirroring the ksoftirqd behavior: after
> NAPI/softirq work, raise a RCU QS to help expedite the RCU period. No
> more blocking afterwards for the same setup.
>
> Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop support=
")
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
>  net/core/dev.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 275fd5259a4a..6e41263ff5d3 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6773,6 +6773,10 @@ static int napi_threaded_poll(void *data)
>                                 net_rps_action_and_irq_enable(sd);
>                         }
>                         skb_defer_free_flush(sd);
> +
> +                       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +                               rcu_softirq_qs();
> +
>                         local_bh_enable();
>
>                         if (!repoll)
> --
> 2.30.2
>

Hmm....
Why napi_busy_loop() does not have a similar problem ?

It is unclear why rcu_all_qs() in __cond_resched() is guarded by

#ifndef CONFIG_PREEMPT_RCU
     rcu_all_qs();
#endif


Thanks.

