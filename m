Return-Path: <bpf+bounces-23111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E89ED86DA58
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 04:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6761F23BB8
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 03:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C9747A52;
	Fri,  1 Mar 2024 03:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="crTZllqg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7563845C12
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 03:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709264854; cv=none; b=Sw1neGt4SmJJaPwVI2K48dcLWHpy3lXAJ+R+aNTUdcdC0PlPfu+K2jcR71mSV8yPlWSqsISdZSEvr1KQDfrTuJwZBFjElFTuN+2dk/Moykayf8ssjjVEc1g/aWsRLQRVxQjf3CGrE3SDInU8l8q5VbTl4pHTlaSQy/4KoTKx1w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709264854; c=relaxed/simple;
	bh=SJCpqDpJSEgHDV5tQDF3yUR/bwYgJ4fDZGCiE46Z7X0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Uk7xRIjEimE2KM1ZFim2EaCNhb7x06tECk+1uaGUzif/dW/IQN84CtRCJ4UqVYLmPitiQgoj/YJezHIchrdAXXhCr3Qm4AhGEmv/epJPyLMR7ci0D54oysAHV4w7mKWpyt1Gc3WCChuW9nBReyTKQrMxfa+o0OeS7fwpOqzVZfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=crTZllqg; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-787b0b1deeaso76709185a.3
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 19:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1709264851; x=1709869651; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ir94IXljskTATdQD9ZYQYe2IqsDn2CAqbjyFa/bExS8=;
        b=crTZllqgfLAdCjAr9U0yj+xpC4zfMf45RBEwW0aPCi+3yJFZMI59MnZXYsVIyEauMh
         cLfsu0OSqiCOFRiMiojnI6yQGRaYJOKQ9tELJahw80kzJtLPwY+dJjtMsDrX4SA516b/
         JxHYm9XajT5YxjhHcm7o/GN6o+QXVQV8VaRRCtVyzWmjseql2mXBKJqSuT1Hk03/Rojw
         1dDySYOkOj9T21GO7MtMcYzF/VzrSo8wMSk6ZAm1IhweP2wKYCVzZubXy1RCmme85H2n
         3Auq7DaE5oZoYR1FI0mcwl3ISQbYr8FPtmDowonD5/fTx7yR8DxhPGikC/ezGIwoFA/b
         SZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709264851; x=1709869651;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ir94IXljskTATdQD9ZYQYe2IqsDn2CAqbjyFa/bExS8=;
        b=Yx7uAbpenrmZd3545Kqpd9tH3+hMH48tmKt2GM3gwU7Ln6IXpeDOLJXA88Yt7Xx9bO
         7Hviv6FwExXN2cMwRrk5WUC2l/KUbyaSzo6SvE0E+OP62FhRGLgmNx861hSEkucLL9No
         v5YXCo9OmTSiCOMvyoDVt7VoUOgPQsp1lsVaqoDkpopNPYu1UHzKHwzlZNhSkk4jYXzW
         aRyuH1vLckNyxUSLJnM/H8jN9IWamI5cuXN8m9p5/qdTxdz+g+niZxGzOklEzLcf9+Uo
         K6TegwEusMnqa7zU/rf/ZrmuyVN31/f3ae9XmeYaa0V8aZHVVkTYoukJwofNFkFZpdnZ
         Z3QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmIE6TzLOVeTfl3VbED5NLEZmFwjj1nT+dtnbVsVQMxvFbpmDs5P/sT3T7wJvS3abXPzg84aPDLhDbZ1MfncnyMj5N
X-Gm-Message-State: AOJu0YzSmlLEHen7IOFgaZvmrgPG8CoEclYQj1wO8T1VIgZOrQVzIQ2s
	8/gF/1EaiW03t9CA8q4fXcznI7T4NFlv26VMCpL6Rs+L4AOlsaHZidUjWnQm2SA=
X-Google-Smtp-Source: AGHT+IHBV4j0XvZKRjdEXGH77v8/UWe0r7iiAV8Gl34A3ObsJ5NNm4GAwjkOVJ2t5W472XbKjrF4aw==
X-Received: by 2002:a05:6214:12e:b0:68f:e766:5ee4 with SMTP id w14-20020a056214012e00b0068fe7665ee4mr657937qvs.25.1709264851278;
        Thu, 29 Feb 2024 19:47:31 -0800 (PST)
Received: from debian.debian ([2a09:bac5:7a49:f91::18d:13])
        by smtp.gmail.com with ESMTPSA id qo13-20020a056214590d00b0068d11cf887bsm1441728qvb.55.2024.02.29.19.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 19:47:30 -0800 (PST)
Date: Thu, 29 Feb 2024 19:47:27 -0800
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
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com
Subject: [PATCH v2] net: raise RCU qs after each threaded NAPI poll
Message-ID: <ZeFPz4D121TgvCje@debian.debian>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We noticed task RCUs being blocked when threaded NAPIs are very busy at
workloads: detaching any BPF tracing programs, i.e. removing a ftrace
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

This is simply fixed by adapting similar behavior of ksoftirqd: after
the thread repolls for a while, raise a RCU QS to help expedite the
tasks RCU grace period. No more blocking afterwards.

Some brief iperf3 throughput testing in my VM with net-next kernel shows no
noteable perf difference with 1500 byte MTU for 10 repeat runs each:

Before:
UDP:  3.073Gbps (+-0.070Gbps)
TCP: 37.850Gbps (+-1.947Gbps)

After:
UDP:  3.077Gbps (+-0.121 Gbps)
TCP: 38.120Gbps (+-2.272 Gbps)

Note I didn't enable GRO for UDP so its throughput is lower than TCP.

Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop support")
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
v1->v2: moved rcu_softirq_qs out from bh critical section, and only
raise it after a second of repolling. Added some brief perf test result.

---
 net/core/dev.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 275fd5259a4a..76cff3849e1f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6751,9 +6751,12 @@ static int napi_threaded_poll(void *data)
 {
 	struct napi_struct *napi = data;
 	struct softnet_data *sd;
+	unsigned long next_qs;
 	void *have;
 
 	while (!napi_thread_wait(napi)) {
+		next_qs = jiffies + HZ;
+
 		for (;;) {
 			bool repoll = false;
 
@@ -6778,6 +6781,21 @@ static int napi_threaded_poll(void *data)
 			if (!repoll)
 				break;
 
+			/* cond_resched cannot unblock tasks RCU writers, so it
+			 * is necessary to relax periodically and raise a QS to
+			 * avoid starving writers under frequent repoll, e.g.
+			 * ftrace trampoline clean up work. When not repoll,
+			 * napi_thread_wait will enter sleep and have the same
+			 * QS effect.
+			 */
+			if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
+			    time_after(jiffies, next_qs)) {
+				preempt_disable();
+				rcu_softirq_qs();
+				preempt_enable();
+				next_qs = jiffies + HZ;
+			}
+
 			cond_resched();
 		}
 	}
-- 
2.30.2


