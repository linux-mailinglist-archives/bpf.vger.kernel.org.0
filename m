Return-Path: <bpf+bounces-30471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABEE8CE0FD
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 08:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513251C210A2
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 06:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1D7128374;
	Fri, 24 May 2024 06:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iKuHShVI"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B865438DE5
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 06:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716531913; cv=none; b=KzYZeIdvPYQK5yKD4YRhfaoTks1wiNhZbILAGqAMR1ZWOSQjiMD6zJVIHHQnlAYo5yT6784rLBjeSlu8ChxusvPA1e57oKmOT7xQ4jt+q27Y5Np8vREdI6ZCz5iubDXGDd6hghRI5x/1OPhlVPCpy/SyPh9gjx8Y5TDGFNuBUO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716531913; c=relaxed/simple;
	bh=Th/wyoN5I6NBJ4KJcZvy+3OjavZOYx9qbaCggK9xVcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5vq78WGeGHUyuSIWVm5p3UYZ4KVV+QlAKGKl+3nF5LYltuc0hzNjZnBsq+aEkeEKM/W38XJnkcw9fldXljqd0cx3GvhR8o4ct4lmVdyavWgfZfWv/l5f00f9T9dU5BkF28UNC/yDbnVfwKOiREcYkvcDsX2aOqV1+VWM3MLieo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iKuHShVI; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: ameryhung@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716531902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkHP8bSt0iaT2ujp25iEOhPoAZerzEA6zarFKTD8Q2c=;
	b=iKuHShVII5TP39KcxM9fGTLAo1+eA3QS1IBrPCBD1mrq7qmkVK7/ohOiglfH9Hn52k06tu
	kauBgHkigicYCUag6Rax2PZx9nGUZ6YJkoOGM4k2FAZaDiGgBvuYs3omg5JxZFfiC8aE7h
	Bexu+OtXjOuFD8aLaOp/NItUnH9PELw=
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: yangpeihao@sjtu.edu.cn
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: andrii@kernel.org
X-Envelope-To: martin.lau@kernel.org
X-Envelope-To: sinquersw@gmail.com
X-Envelope-To: toke@redhat.com
X-Envelope-To: jhs@mojatatu.com
X-Envelope-To: jiri@resnulli.us
X-Envelope-To: sdf@google.com
X-Envelope-To: xiyou.wangcong@gmail.com
X-Envelope-To: yepeilin.cs@gmail.com
Message-ID: <6ad06909-7ef4-4f8c-be97-fe5c73bc14a3@linux.dev>
Date: Thu, 23 May 2024 23:24:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v8 18/20] selftests: Add a bpf fq qdisc to selftest
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 sdf@google.com, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
 <20240510192412.3297104-19-amery.hung@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240510192412.3297104-19-amery.hung@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/10/24 12:24 PM, Amery Hung wrote:
> This test implements a more sophisticated qdisc using bpf. The bpf fair-
> queueing (fq) qdisc gives each flow an equal chance to transmit data. It
> also respects the timestamp of skb for rate limiting. The implementation
> does not prevent hash collision of flows nor does it recycle flows.

Does it hit some issue to handle the flow collision (just curious if there are 
missing pieces to do this)?

> The bpf fq also takes the chance to communicate packet drop information
> with a bpf clsact EDT rate limiter using bpf maps. With the info, the
> rate limiter can compenstate the delay caused by packet drops in qdisc
> to maintain the throughput.
> 

> diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
> new file mode 100644
> index 000000000000..5118237da9e4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
> @@ -0,0 +1,660 @@
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_experimental.h"
> +#include "bpf_qdisc_common.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +#define NSEC_PER_USEC 1000L
> +#define NSEC_PER_SEC 1000000000L
> +#define PSCHED_MTU (64 * 1024 + 14)
> +
> +#define NUM_QUEUE_LOG 10
> +#define NUM_QUEUE (1 << NUM_QUEUE_LOG)
> +#define PRIO_QUEUE (NUM_QUEUE + 1)
> +#define COMP_DROP_PKT_DELAY 1
> +#define THROTTLED 0xffffffffffffffff
> +
> +/* fq configuration */
> +__u64 q_flow_refill_delay = 40 * 10000; //40us
> +__u64 q_horizon = 10ULL * NSEC_PER_SEC;
> +__u32 q_initial_quantum = 10 * PSCHED_MTU;
> +__u32 q_quantum = 2 * PSCHED_MTU;
> +__u32 q_orphan_mask = 1023;
> +__u32 q_flow_plimit = 100;
> +__u32 q_plimit = 10000;
> +__u32 q_timer_slack = 10 * NSEC_PER_USEC;
> +bool q_horizon_drop = true;
> +
> +bool q_compensate_tstamp;
> +bool q_random_drop;
> +
> +unsigned long time_next_delayed_flow = ~0ULL;
> +unsigned long unthrottle_latency_ns = 0ULL;
> +unsigned long ktime_cache = 0;
> +unsigned long dequeue_now;
> +unsigned int fq_qlen = 0;

I suspect some of these globals may be more natural if it is stored private to 
an individual Qdisc instance. i.e. qdisc_priv(). e.g. in the sch_mq setup.

A high level idea is to allow the SEC(".struct_ops.link") to specify its own 
Qdisc_ops.priv_size.

The bpf prog could use it as a simple u8 array memory area to write anything but 
the verifier can't learn a lot from it. It will be more useful if it can work 
like map_value(s) to the verifier such that the verifier can also see the 
bpf_rb_root/bpf_list_head/bpf_spin_lock...etc.

> +
> +struct fq_flow_node {
> +	u32 hash;
> +	int credit;
> +	u32 qlen;
> +	u32 socket_hash;
> +	u64 age;
> +	u64 time_next_packet;
> +	struct bpf_list_node list_node;
> +	struct bpf_rb_node rb_node;
> +	struct bpf_rb_root queue __contains_kptr(sk_buff, bpf_rbnode);
> +	struct bpf_spin_lock lock;
> +	struct bpf_refcount refcount;
> +};
> +
> +struct dequeue_nonprio_ctx {
> +	bool dequeued;
> +	u64 expire;
> +};
> +
> +struct fq_stashed_flow {
> +	struct fq_flow_node __kptr *flow;
> +};
> +
> +struct stashed_skb {
> +	struct sk_buff __kptr *skb;
> +};
> +
> +/* [NUM_QUEUE] for TC_PRIO_CONTROL
> + * [0, NUM_QUEUE - 1] for other flows
> + */
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__type(key, __u32);
> +	__type(value, struct fq_stashed_flow);
> +	__uint(max_entries, NUM_QUEUE + 1);
> +} fq_stashed_flows SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__type(key, __u32);
> +	__type(value, __u64);
> +	__uint(pinning, LIBBPF_PIN_BY_NAME);
> +	__uint(max_entries, 16);
> +} rate_map SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__type(key, __u32);
> +	__type(value, __u64);
> +	__uint(pinning, LIBBPF_PIN_BY_NAME);
> +	__uint(max_entries, 16);
> +} comp_map SEC(".maps");
> +
> +#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
> +
> +private(A) struct bpf_spin_lock fq_delayed_lock;
> +private(A) struct bpf_rb_root fq_delayed __contains(fq_flow_node, rb_node);
> +
> +private(B) struct bpf_spin_lock fq_new_flows_lock;
> +private(B) struct bpf_list_head fq_new_flows __contains(fq_flow_node, list_node);
> +
> +private(C) struct bpf_spin_lock fq_old_flows_lock;
> +private(C) struct bpf_list_head fq_old_flows __contains(fq_flow_node, list_node);
> +
> +private(D) struct bpf_spin_lock fq_stashed_skb_lock;
> +private(D) struct bpf_list_head fq_stashed_skb __contains_kptr(sk_buff, bpf_list);

[ ... ]

> +SEC("struct_ops/bpf_fq_enqueue")
> +int BPF_PROG(bpf_fq_enqueue, struct sk_buff *skb, struct Qdisc *sch,
> +	     struct bpf_sk_buff_ptr *to_free)
> +{
> +	struct iphdr *iph = (void *)(long)skb->data + sizeof(struct ethhdr);
> +	u64 time_to_send, jiffies, delay_ns, *comp_ns, *rate;
> +	struct fq_flow_node *flow = NULL, *flow_copy;
> +	struct fq_stashed_flow *sflow;
> +	u32 hash, daddr, sk_hash;
> +	bool connected;
> +
> +	if (q_random_drop & (bpf_get_prandom_u32() > ~0U * 0.90))
> +		goto drop;
> +
> +	if (fq_qlen >= q_plimit)
> +		goto drop;
> +
> +	if (!skb->tstamp) {
> +		time_to_send = ktime_cache = bpf_ktime_get_ns();
> +	} else {
> +		if (fq_packet_beyond_horizon(skb)) {
> +			ktime_cache = bpf_ktime_get_ns();
> +			if (fq_packet_beyond_horizon(skb)) {
> +				if (q_horizon_drop)
> +					goto drop;
> +
> +				skb->tstamp = ktime_cache + q_horizon;
> +			}
> +		}
> +		time_to_send = skb->tstamp;
> +	}
> +
> +	if (fq_classify(skb, &hash, &sflow, &connected, &sk_hash) < 0)
> +		goto drop;
> +
> +	flow = bpf_kptr_xchg(&sflow->flow, flow);
> +	if (!flow)
> +		goto drop; //unexpected
> +
> +	if (hash != PRIO_QUEUE) {
> +		if (connected && flow->socket_hash != sk_hash) {
> +			flow->credit = q_initial_quantum;
> +			flow->socket_hash = sk_hash;
> +			if (fq_flow_is_throttled(flow)) {
> +				/* mark the flow as undetached. The reference to the
> +				 * throttled flow in fq_delayed will be removed later.
> +				 */
> +				flow_copy = bpf_refcount_acquire(flow);
> +				flow_copy->age = 0;
> +				fq_flows_add_tail(&fq_old_flows, &fq_old_flows_lock, flow_copy);
> +			}
> +			flow->time_next_packet = 0ULL;
> +		}
> +
> +		if (flow->qlen >= q_flow_plimit) {
> +			bpf_kptr_xchg_back(&sflow->flow, flow);
> +			goto drop;
> +		}
> +
> +		if (fq_flow_is_detached(flow)) {
> +			if (connected)
> +				flow->socket_hash = sk_hash;
> +
> +			flow_copy = bpf_refcount_acquire(flow);
> +
> +			jiffies = bpf_jiffies64();
> +			if ((s64)(jiffies - (flow_copy->age + q_flow_refill_delay)) > 0) {
> +				if (flow_copy->credit < q_quantum)
> +					flow_copy->credit = q_quantum;
> +			}
> +			flow_copy->age = 0;
> +			fq_flows_add_tail(&fq_new_flows, &fq_new_flows_lock, flow_copy);
> +		}
> +	}
> +
> +	skb->tstamp = time_to_send;
> +
> +	bpf_spin_lock(&flow->lock);
> +	bpf_rbtree_excl_add(&flow->queue, &skb->bpf_rbnode, skb_tstamp_less);
> +	bpf_spin_unlock(&flow->lock);
> +
> +	flow->qlen++;
> +	bpf_kptr_xchg_back(&sflow->flow, flow);
> +
> +	fq_qlen++;
> +	return NET_XMIT_SUCCESS;
> +
> +drop:
> +	if (q_compensate_tstamp) {
> +		bpf_probe_read_kernel(&daddr, sizeof(daddr), &iph->daddr);
> +		rate = bpf_map_lookup_elem(&rate_map, &daddr);
> +		comp_ns = bpf_map_lookup_elem(&comp_map, &daddr);
> +		if (rate && comp_ns) {
> +			delay_ns = (u64)qdisc_skb_cb(skb)->pkt_len * NSEC_PER_SEC / (*rate);
> +			__sync_fetch_and_add(comp_ns, delay_ns);
> +		}
> +	}
> +	bpf_qdisc_skb_drop(skb, to_free);
> +	return NET_XMIT_DROP;
> +}

[ ... ]

> +SEC("struct_ops/bpf_fq_dequeue")
> +struct sk_buff *BPF_PROG(bpf_fq_dequeue, struct Qdisc *sch)
> +{
> +	struct dequeue_nonprio_ctx cb_ctx = {};
> +	struct sk_buff *skb = NULL;
> +
> +	skb = fq_dequeue_prio();
> +	if (skb) {
> +		bpf_skb_set_dev(skb, sch);
> +		return skb;
> +	}
> +
> +	ktime_cache = dequeue_now = bpf_ktime_get_ns();
> +	fq_check_throttled();
> +	bpf_loop(q_plimit, fq_dequeue_nonprio_flows, &cb_ctx, 0);
> +
> +	skb = get_stashed_skb();
> +
> +	if (skb) {
> +		bpf_skb_set_dev(skb, sch);
> +		return skb;
> +	}
> +
> +	if (cb_ctx.expire)
> +		bpf_qdisc_watchdog_schedule(sch, cb_ctx.expire, q_timer_slack);
> +
> +	return NULL;
> +}

The enqueue and dequeue are using the bpf map (e.g. arraymap) or global var 
(also an arraymap). Potentially, the map can be shared by different qdisc 
instances (sch) and they could be attached to different net devices also. Not 
sure if there is potentail issue? e.g. the bpf_fq_reset below.
or a bpf prog dequeue a skb with a different skb->dev.

> +
> +static int
> +fq_reset_flows(u32 index, void *ctx)
> +{
> +	struct bpf_list_node *node;
> +	struct fq_flow_node *flow;
> +
> +	bpf_spin_lock(&fq_new_flows_lock);
> +	node = bpf_list_pop_front(&fq_new_flows);
> +	bpf_spin_unlock(&fq_new_flows_lock);
> +	if (!node) {
> +		bpf_spin_lock(&fq_old_flows_lock);
> +		node = bpf_list_pop_front(&fq_old_flows);
> +		bpf_spin_unlock(&fq_old_flows_lock);
> +		if (!node)
> +			return 1;
> +	}
> +
> +	flow = container_of(node, struct fq_flow_node, list_node);
> +	bpf_obj_drop(flow);
> +
> +	return 0;
> +}
> +
> +static int
> +fq_reset_stashed_flows(u32 index, void *ctx)
> +{
> +	struct fq_flow_node *flow = NULL;
> +	struct fq_stashed_flow *sflow;
> +
> +	sflow = bpf_map_lookup_elem(&fq_stashed_flows, &index);
> +	if (!sflow)
> +		return 0;
> +
> +	flow = bpf_kptr_xchg(&sflow->flow, flow);
> +	if (flow)
> +		bpf_obj_drop(flow);
> +
> +	return 0;
> +}
> +
> +SEC("struct_ops/bpf_fq_reset")
> +void BPF_PROG(bpf_fq_reset, struct Qdisc *sch)
> +{
> +	bool unset_all = true;
> +	fq_qlen = 0;
> +	bpf_loop(NUM_QUEUE + 1, fq_reset_stashed_flows, NULL, 0);
> +	bpf_loop(NUM_QUEUE, fq_reset_flows, NULL, 0);
> +	bpf_loop(NUM_QUEUE, fq_unset_throttled_flows, &unset_all, 0);

I am not sure if it can depend on a bpf prog to do cleanup/reset. What if it 
missed to drop some skb which potentially could hold up resources like sk/dev/netns?

A quick thought is that the struct_ops knows all the bpf progs and each prog 
tracks the used map in prog->aux->used_maps. The kernel can clean it up. 
However, the map may still be used by other Qdisc instances.

It may be easier if the skb can only be enqueued somewhere in the qdisc_priv() 
and then cleans up its own qdisc_priv during reset.

> +	return;
> +}
> +
> +SEC(".struct_ops")
> +struct Qdisc_ops fq = {
> +	.enqueue   = (void *)bpf_fq_enqueue,
> +	.dequeue   = (void *)bpf_fq_dequeue,
> +	.reset     = (void *)bpf_fq_reset,
> +	.id        = "bpf_fq",
> +};


