Return-Path: <bpf+bounces-35033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D4D93721C
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 03:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028321C21215
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 01:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E594A4696;
	Fri, 19 Jul 2024 01:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PW40PyH5"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021A215D1
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 01:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721354057; cv=none; b=qTu2ouflKMrpbuLbPz5tAzWQ02HMM7TStl3TN2ggVKZzG+WXYKBNfi1BbhRyPr28t1mkoLyrYPH1npkCv1bm552gA7MY/1Ve8itntHmwlzf3HivLjVrNdjAY4u4pzHUn43R5O39emASuWm2GrIY8HrKP7QCPQkfSdFSYAw76ehw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721354057; c=relaxed/simple;
	bh=uuvdFKOn/RpjfOTlS5Oiwmqk31G7+mcNyD0n2OfmAoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+7iAnnEDxP9cE3zUGAdkauRBOBWJmYxZsVxoyYOr1OWeK2KlSyGzPlZBeJDEWtR8CH2e66/S/r41VnbPqLRG2w090+nXLzAk30jZJml3i09VS6nnHMaRVsyi0UACB+gbehjon3sB44hyl+emjgpX/RrplQLjMKoplvgbAc8HnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PW40PyH5; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: ameryhung@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721354049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HEc/gJkN+QyAS4XnuyU87XlyuosFVsaG+PUDhORCgQg=;
	b=PW40PyH5qchdRMhrGGHr78ESSs4xCMtSVTnOGki15MyNqqMeCNd5+c5Jme5WqYFtvPqWpZ
	ntYZwfzgscs32gpotQ+1w/AP76xyjNz+shj02JPWMxkjOxTX5XT0wPXF8j0z77fB6KwMln
	Baqckx/+rr5QdYEyBGqrmuKdSDyJQpc=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: yangpeihao@sjtu.edu.cn
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: andrii@kernel.org
X-Envelope-To: alexei.starovoitov@gmail.com
X-Envelope-To: martin.lau@kernel.org
X-Envelope-To: sinquersw@gmail.com
X-Envelope-To: toke@redhat.com
X-Envelope-To: jhs@mojatatu.com
X-Envelope-To: jiri@resnulli.us
X-Envelope-To: sdf@google.com
X-Envelope-To: xiyou.wangcong@gmail.com
X-Envelope-To: yepeilin.cs@gmail.com
Message-ID: <f3ec8147-69ad-4852-be93-92a2a627229a@linux.dev>
Date: Thu, 18 Jul 2024 18:54:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v9 10/11] selftests: Add a bpf fq qdisc to selftest
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, yangpeihao@sjtu.edu.cn,
 daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com,
 martin.lau@kernel.org, sinquersw@gmail.com, toke@redhat.com,
 jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com,
 xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
 <20240714175130.4051012-11-amery.hung@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240714175130.4051012-11-amery.hung@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/14/24 10:51 AM, Amery Hung wrote:
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__type(key, __u32);
> +	__type(value, struct fq_stashed_flow);
> +	__uint(max_entries, NUM_QUEUE + 1);
> +} fq_stashed_flows SEC(".maps");
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

Potentially, multiple qdisc instances will content on these global locks. Do you 
think it will be an issue in setup like the root is mq and multiple fq(s) below 
the mq, like mq => (fq1, fq2, fq3...)?

I guess it could be solved by storing them into the map's value and each fq 
instance uses its own lock and list/rb (?) to make it work like ".priv_size", 
but just more work is needed in ".init". Not necessary the top of the things to 
tackle/optimize for now though.

[ ... ]

> +SEC("struct_ops/bpf_fq_enqueue")
> +int BPF_PROG(bpf_fq_enqueue, struct sk_buff *skb, struct Qdisc *sch,
> +	     struct bpf_sk_buff_ptr *to_free)
> +{
> +	struct fq_flow_node *flow = NULL, *flow_copy;
> +	struct fq_stashed_flow *sflow;
> +	u64 time_to_send, jiffies;
> +	u32 hash, sk_hash;
> +	struct skb_node *skbn;
> +	bool connected;
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
> +		goto drop;
> +
> +	if (hash != PRIO_QUEUE) {
> +		if (connected && flow->socket_hash != sk_hash) {

The commit message mentioned it does not handle the hash collision. Not a 
request for now, I just want to understand if you hit some issues.

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
> +	skbn = bpf_obj_new(typeof(*skbn));
> +	if (!skbn) {
> +		bpf_kptr_xchg_back(&sflow->flow, flow)
Please post the patch that makes the bpf_kptr_xchg() work. It is easier if I can 
try the selftests out.


