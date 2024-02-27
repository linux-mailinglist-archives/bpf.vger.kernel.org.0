Return-Path: <bpf+bounces-22773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED618869AE0
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 16:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34A6287E9B
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 15:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05143148307;
	Tue, 27 Feb 2024 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QyaDeuTY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA906146E9B
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048675; cv=none; b=Vnq1QkcOu+z6ksVzLTDQAYj6C3zrdpkVwANL4fXOjb3yHXmgylEc0fqUE/PoxQVDmXOfb63/mLzvpYPWR83WOQuR+EFMpRrOKPxkEypAFTSbYAfcOmxsFpM7Oyg0+bTTY2SMXDUb6X9Kx9t1fFn1Aae8EkcN8oLfxwRb4aQsTYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048675; c=relaxed/simple;
	bh=G9yIq1UUe7Jy5IKgqipKCB37DVtAPsay/xE5VGy7JGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XswV8rpGEDgWHDzuLQnWxuM/5hwqqfq4UZVqa+utwfe73nKKw2odr2K+fLOIRvKWLPtCWwHunKEohtCdBtroudb8IAodiaUgIQGEeoQOvrjjNBKbcfjOC8vGNM7Z0mOdkLns5pwj6FLJmJn1TtQTFjIzTP750lvQLEW/2rOv9Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QyaDeuTY; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6093419f332so4045327b3.0
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 07:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1709048673; x=1709653473; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fvLPNpXdLGD+M5a3hZKAFIZfEPkaIJ/ji6J8mxzWC4I=;
        b=QyaDeuTYW/zCYpeqBDUNHYJTiVWsmtDI98B4keln5MbOuSLo5Xt76iWzrnHW7EWA+U
         vCYqfhdw+wEtEm3Zb3PCyonEXbfqiyArKvmsDdqWOEv+02S0ajmB2mswPZ4NtpJtn6MZ
         ip5s056V8p2hjJ+dgDP4hcWmZPTtR713NKa7lbD+NCW/nfHRjMotqtbpX3t31ghTl8Gw
         zs2Mmblbw4AY72XCTqV7Wk0VU2Nm3Th499miW1b0+vQsPj9lrgkyMQqh9iF3jwUW1q7g
         PkgCfHDvJ8hNq9V9ZpYVVycClX5Wt/3ec+a6+PbSF3szZugdRLSFxeT4+wwMa3hsoi+q
         HuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709048673; x=1709653473;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fvLPNpXdLGD+M5a3hZKAFIZfEPkaIJ/ji6J8mxzWC4I=;
        b=XKMOPdtYDOGcDhGQUjctWLFgHRMCMua+4ROESQRY0nuxvW+GmigGj2OG7jyns3WxVf
         XI1nwaGjDSMy/WMrZhnxv9n5mJka3nhxsmL0MqxX/MzQ3TymEBLfBRY18xKXChBkBndW
         GZidsnQA+g/5Zw/puGzd2pOQDDWpt4hPGnVfmRKTJTqkpihPEzLelTDGy9AezJN+YkVq
         eQLf/dk4FCCjHadwVuaxD6ipj5dGAUly7Erq/DBdB6KS5FQXceOqA49XiDDkKdj3R+jz
         a7yqzGKI2oaTFLYvobk6RbysJRsvvYGT29/xbltcolFAlWjt6dtlTP1nz0wbP/iShPu8
         Etdw==
X-Forwarded-Encrypted: i=1; AJvYcCU4jv4rdZKl51CQXfuBOhFaWcuF/JtA6gfKdYwmyaoQyeU5UkNMvqsZ8mNWqNZvv1M5u8TFRBEkm1/bJykv5njqkMAO
X-Gm-Message-State: AOJu0Yxq1yyDlbxZwnsJW7oAyELXp9/7LNKYXd8gHHBnurcY6OCnGfgQ
	NmjaI2UI1MCyj5vv5TCnus27J8ZSrjLRbm/fqrr++Y2N/ioKWsQ6S8YNw1V4x+0=
X-Google-Smtp-Source: AGHT+IGQgl+BuoURAJ4iKvHfQR/Ef6PSmWmX+Yul84JuEfhlB5gkfJi8vjm/Ee+qewtVLP1omH4PLA==
X-Received: by 2002:a25:13c4:0:b0:dcd:1854:9f43 with SMTP id 187-20020a2513c4000000b00dcd18549f43mr2079117ybt.3.1709048672424;
        Tue, 27 Feb 2024 07:44:32 -0800 (PST)
Received: from debian.debian ([2a09:bac5:7a49:f91::18d:13])
        by smtp.gmail.com with ESMTPSA id k25-20020ac86059000000b0042e8a53d216sm1796307qtm.86.2024.02.27.07.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:44:31 -0800 (PST)
Date: Tue, 27 Feb 2024 07:44:29 -0800
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com
Subject: [PATCH] net: raise RCU qs after each threaded NAPI poll
Message-ID: <Zd4DXTyCf17lcTfq@debian.debian>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We noticed task RCUs being blocked when threaded NAPIs are very busy in
production: detaching any BPF tracing programs, i.e. removing a ftrace
trampoline, will simply block for very long in rcu_tasks_wait_gp. This
ranges from hundreds of seconds to even an hour, severely harming any
observability tools that rely on BPF tracing programs. It can be
easily reproduced locally with following setup:

ip netns add test1
ip netns add test2

ip -n test1 link add veth1 type veth peer name veth2 netns test2

ip -n test1 link set veth1 up
ip -n test1 link set lo up
ip -n test2 link set veth2 up
ip -n test2 link set lo up

ip -n test1 addr add 192.168.1.2/31 dev veth1
ip -n test1 addr add 1.1.1.1/32 dev lo
ip -n test2 addr add 192.168.1.3/31 dev veth2
ip -n test2 addr add 2.2.2.2/31 dev lo

ip -n test1 route add default via 192.168.1.3
ip -n test2 route add default via 192.168.1.2

for i in `seq 10 210`; do
 for j in `seq 10 210`; do
    ip netns exec test2 iptables -I INPUT -s 3.3.$i.$j -p udp --dport 5201
 done
done

ip netns exec test2 ethtool -K veth2 gro on
ip netns exec test2 bash -c 'echo 1 > /sys/class/net/veth2/threaded'
ip netns exec test1 ethtool -K veth1 tso off

Then run an iperf3 client/server and a bpftrace script can trigger it:

ip netns exec test2 iperf3 -s -B 2.2.2.2 >/dev/null&
ip netns exec test1 iperf3 -c 2.2.2.2 -B 1.1.1.1 -u -l 1500 -b 3g -t 100 >/dev/null&
bpftrace -e 'kfunc:__napi_poll{@=count();} interval:s:1{exit();}'

Above reproduce for net-next kernel with following RCU and preempt
configuraitons:

# RCU Subsystem
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem
# RCU Debugging
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

CONFIG_PREEMPT_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y
CONFIG_PREEMPT_RCU=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_PREEMPT_NOTIFIERS=y
# CONFIG_DEBUG_PREEMPT is not set
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set

An interesting observation is that, while tasks RCUs are blocked,
related NAPI thread is still being scheduled (even across cores)
regularly. Looking at the gp conditions, I am inclining to cond_resched
after each __napi_poll being the problem: cond_resched enters the
scheduler with PREEMPT bit, which does not account as a gp for tasks
RCUs. Meanwhile, since the thread has been frequently resched, the
normal scheduling point (no PREEMPT bit, accounted as a task RCU gp)
seems to have very little chance to kick in. Given the nature of "busy
polling" program, such NAPI thread won't have task->nvcsw or task->on_rq
updated (other gp conditions), the result is that such NAPI thread is
put on RCU holdouts list for indefinitely long time.

This is simply fixed by mirroring the ksoftirqd behavior: after
NAPI/softirq work, raise a RCU QS to help expedite the RCU period. No
more blocking afterwards for the same setup.

Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop support")
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 net/core/dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 275fd5259a4a..6e41263ff5d3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6773,6 +6773,10 @@ static int napi_threaded_poll(void *data)
 				net_rps_action_and_irq_enable(sd);
 			}
 			skb_defer_free_flush(sd);
+
+			if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+				rcu_softirq_qs();
+
 			local_bh_enable();
 
 			if (!repoll)
-- 
2.30.2


