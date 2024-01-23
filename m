Return-Path: <bpf+bounces-20149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 041D4839D63
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 00:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285651C21AD1
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 23:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D686A5465E;
	Tue, 23 Jan 2024 23:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pX8n63m2"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A551154FA1
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 23:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706053901; cv=none; b=EaNEzUU6otbG0C1+3iOWR+aw/9obc3BjCbljbAjpQSpCdI4+sfu/ZKnJy0CPBduLLrbVFfcpzMo4C7t186UxyJHZlP/v9nIpf4p6sQomti75qjaGkZxqwTID8XyPFdeeMLt68PA2maQ0/ML2y+MI/f8SS9JRPY7p1TN6htdSOPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706053901; c=relaxed/simple;
	bh=Ek1cytM7WS2sE1riwtMA+G7qFW4BlkKBOIO3LuJ5He0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLLQdkR2gwqvMk2qfZGdUGm4uwrSVpg0UsdkyRi25sMJ5aBrVCi0sFMaepiwnFFnJ+8+ehuNeWKoopppHkkrR7ktgm3BQkUJMCcW6UlRaOSQulrBfVNUnQbCyKM2RO9o1UYnB2+7pUBYItgeZXumF95jY4WaRbmcDL/ory+xHFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pX8n63m2; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0484f7f7-715f-4084-b42d-6d43ebb5180f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706053895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k47V9DDWici+9jkUdApGNBTXQr4GlP/PqYqY9dLSWEk=;
	b=pX8n63m2wmR8CgI32R/UBaVE9EwRttIyL4KC8sbyCKoe3D+1UzEkx9pqGuTs2rjtSP7014
	Me+5kLj72dsCxB7A9HzH/URMKiUggtAh6pQjo0cG1OUhFOwvTqHz9mgi/cGv0HiKL9H5+E
	Dv52w3RTS5pUX9pKg40oPwibEuhBaUI=
Date: Tue, 23 Jan 2024 15:51:26 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v7 1/8] net_sched: Introduce eBPF based Qdisc
Content-Language: en-US
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, toke@redhat.com,
 jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com,
 xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com, netdev@vger.kernel.org
References: <cover.1705432850.git.amery.hung@bytedance.com>
 <232881645a5c4c05a35df4ff1f08a19ef9a02662.1705432850.git.amery.hung@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <232881645a5c4c05a35df4ff1f08a19ef9a02662.1705432850.git.amery.hung@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/17/24 1:56 PM, Amery Hung wrote:
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 0bb92414c036..df280bbb7c0d 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -997,6 +997,7 @@ enum bpf_prog_type {
>   	BPF_PROG_TYPE_SK_LOOKUP,
>   	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
>   	BPF_PROG_TYPE_NETFILTER,
> +	BPF_PROG_TYPE_QDISC,
>   };
>   
>   enum bpf_attach_type {
> @@ -1056,6 +1057,8 @@ enum bpf_attach_type {
>   	BPF_CGROUP_UNIX_GETSOCKNAME,
>   	BPF_NETKIT_PRIMARY,
>   	BPF_NETKIT_PEER,
> +	BPF_QDISC_ENQUEUE,
> +	BPF_QDISC_DEQUEUE,
>   	__MAX_BPF_ATTACH_TYPE
>   };
>   
> @@ -7357,4 +7360,22 @@ struct bpf_iter_num {
>   	__u64 __opaque[1];
>   } __attribute__((aligned(8)));
>   
> +struct bpf_qdisc_ctx {
> +	__bpf_md_ptr(struct sk_buff *, skb);
> +	__u32 classid;
> +	__u64 expire;
> +	__u64 delta_ns;
> +};
> +
> +enum {
> +	SCH_BPF_QUEUED,
> +	SCH_BPF_DEQUEUED = SCH_BPF_QUEUED,
> +	SCH_BPF_DROP,
> +	SCH_BPF_CN,
> +	SCH_BPF_THROTTLE,
> +	SCH_BPF_PASS,
> +	SCH_BPF_BYPASS,
> +	SCH_BPF_STOLEN,
> +};
> +
>   #endif /* _UAPI__LINUX_BPF_H__ */

[ ... ]

> +static bool tc_qdisc_is_valid_access(int off, int size,
> +				     enum bpf_access_type type,
> +				     const struct bpf_prog *prog,
> +				     struct bpf_insn_access_aux *info)
> +{
> +	struct btf *btf;
> +
> +	if (off < 0 || off >= sizeof(struct bpf_qdisc_ctx))
> +		return false;
> +
> +	switch (off) {
> +	case offsetof(struct bpf_qdisc_ctx, skb):
> +		if (type == BPF_WRITE ||
> +		    size != sizeof_field(struct bpf_qdisc_ctx, skb))
> +			return false;
> +
> +		if (prog->expected_attach_type != BPF_QDISC_ENQUEUE)
> +			return false;
> +
> +		btf = bpf_get_btf_vmlinux();
> +		if (IS_ERR_OR_NULL(btf))
> +			return false;
> +
> +		info->btf = btf;
> +		info->btf_id = tc_qdisc_ctx_access_btf_ids[0];
> +		info->reg_type = PTR_TO_BTF_ID | PTR_TRUSTED;
> +		return true;
> +	case bpf_ctx_range(struct bpf_qdisc_ctx, classid):
> +		return size == sizeof_field(struct bpf_qdisc_ctx, classid);
> +	case bpf_ctx_range(struct bpf_qdisc_ctx, expire):
> +		return size == sizeof_field(struct bpf_qdisc_ctx, expire);
> +	case bpf_ctx_range(struct bpf_qdisc_ctx, delta_ns):
> +		return size == sizeof_field(struct bpf_qdisc_ctx, delta_ns);
> +	default:
> +		return false;
> +	}
> +
> +	return false;
> +}
> +

[ ... ]

> +static int sch_bpf_enqueue(struct sk_buff *skb, struct Qdisc *sch,
> +			   struct sk_buff **to_free)
> +{
> +	struct bpf_sched_data *q = qdisc_priv(sch);
> +	unsigned int len = qdisc_pkt_len(skb);
> +	struct bpf_qdisc_ctx ctx = {};
> +	int res = NET_XMIT_SUCCESS;
> +	struct sch_bpf_class *cl;
> +	struct bpf_prog *enqueue;
> +
> +	enqueue = rcu_dereference(q->enqueue_prog.prog);
> +	if (!enqueue)
> +		return NET_XMIT_DROP;
> +
> +	ctx.skb = skb;
> +	ctx.classid = sch->handle;
> +	res = bpf_prog_run(enqueue, &ctx);
> +	switch (res) {
> +	case SCH_BPF_THROTTLE:
> +		qdisc_watchdog_schedule_range_ns(&q->watchdog, ctx.expire, ctx.delta_ns);
> +		qdisc_qstats_overlimit(sch);
> +		fallthrough;
> +	case SCH_BPF_QUEUED:
> +		qdisc_qstats_backlog_inc(sch, skb);
> +		return NET_XMIT_SUCCESS;
> +	case SCH_BPF_BYPASS:
> +		qdisc_qstats_drop(sch);
> +		__qdisc_drop(skb, to_free);
> +		return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> +	case SCH_BPF_STOLEN:
> +		__qdisc_drop(skb, to_free);
> +		return NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
> +	case SCH_BPF_CN:
> +		return NET_XMIT_CN;
> +	case SCH_BPF_PASS:
> +		break;
> +	default:
> +		return qdisc_drop(skb, sch, to_free);
> +	}
> +
> +	cl = sch_bpf_find(sch, ctx.classid);
> +	if (!cl || !cl->qdisc)
> +		return qdisc_drop(skb, sch, to_free);
> +
> +	res = qdisc_enqueue(skb, cl->qdisc, to_free);
> +	if (res != NET_XMIT_SUCCESS) {
> +		if (net_xmit_drop_count(res)) {
> +			qdisc_qstats_drop(sch);
> +			cl->drops++;
> +		}
> +		return res;
> +	}
> +
> +	sch->qstats.backlog += len;
> +	sch->q.qlen++;
> +	return res;
> +}
> +
> +DEFINE_PER_CPU(struct sk_buff*, bpf_skb_dequeue);
> +
> +static struct sk_buff *sch_bpf_dequeue(struct Qdisc *sch)
> +{
> +	struct bpf_sched_data *q = qdisc_priv(sch);
> +	struct bpf_qdisc_ctx ctx = {};
> +	struct sk_buff *skb = NULL;
> +	struct bpf_prog *dequeue;
> +	struct sch_bpf_class *cl;
> +	int res;
> +
> +	dequeue = rcu_dereference(q->dequeue_prog.prog);
> +	if (!dequeue)
> +		return NULL;
> +
> +	__this_cpu_write(bpf_skb_dequeue, NULL);
> +	ctx.classid = sch->handle;
> +	res = bpf_prog_run(dequeue, &ctx);
> +	switch (res) {
> +	case SCH_BPF_DEQUEUED:
> +		skb = __this_cpu_read(bpf_skb_dequeue);
> +		qdisc_bstats_update(sch, skb);
> +		qdisc_qstats_backlog_dec(sch, skb);
> +		break;
> +	case SCH_BPF_THROTTLE:
> +		qdisc_watchdog_schedule_range_ns(&q->watchdog, ctx.expire, ctx.delta_ns);
> +		qdisc_qstats_overlimit(sch);
> +		cl = sch_bpf_find(sch, ctx.classid);
> +		if (cl)
> +			cl->overlimits++;
> +		return NULL;
> +	case SCH_BPF_PASS:
> +		cl = sch_bpf_find(sch, ctx.classid);
> +		if (!cl || !cl->qdisc)
> +			return NULL;
> +		skb = qdisc_dequeue_peeked(cl->qdisc);
> +		if (skb) {
> +			bstats_update(&cl->bstats, skb);
> +			qdisc_bstats_update(sch, skb);
> +			qdisc_qstats_backlog_dec(sch, skb);
> +			sch->q.qlen--;
> +		}
> +		break;
> +	}
> +
> +	return skb;
> +}

[ ... ]

> +static int sch_bpf_init(struct Qdisc *sch, struct nlattr *opt,
> +			struct netlink_ext_ack *extack)
> +{
> +	struct bpf_sched_data *q = qdisc_priv(sch);
> +	int err;
> +
> +	qdisc_watchdog_init(&q->watchdog, sch);
> +	if (opt) {
> +		err = sch_bpf_change(sch, opt, extack);
> +		if (err)
> +			return err;
> +	}
> +
> +	err = tcf_block_get(&q->block, &q->filter_list, sch, extack);
> +	if (err)
> +		return err;
> +
> +	return qdisc_class_hash_init(&q->clhash);
> +}
> +
> +static void sch_bpf_reset(struct Qdisc *sch)
> +{
> +	struct bpf_sched_data *q = qdisc_priv(sch);
> +	struct sch_bpf_class *cl;
> +	unsigned int i;
> +
> +	for (i = 0; i < q->clhash.hashsize; i++) {
> +		hlist_for_each_entry(cl, &q->clhash.hash[i], common.hnode) {
> +			if (cl->qdisc)
> +				qdisc_reset(cl->qdisc);
> +		}
> +	}
> +
> +	qdisc_watchdog_cancel(&q->watchdog);
> +}
> +

[ ... ]

> +static const struct Qdisc_class_ops sch_bpf_class_ops = {
> +	.graft		=	sch_bpf_graft,
> +	.leaf		=	sch_bpf_leaf,
> +	.find		=	sch_bpf_search,
> +	.change		=	sch_bpf_change_class,
> +	.delete		=	sch_bpf_delete,
> +	.tcf_block	=	sch_bpf_tcf_block,
> +	.bind_tcf	=	sch_bpf_bind,
> +	.unbind_tcf	=	sch_bpf_unbind,
> +	.dump		=	sch_bpf_dump_class,
> +	.dump_stats	=	sch_bpf_dump_class_stats,
> +	.walk		=	sch_bpf_walk,
> +};
> +
> +static struct Qdisc_ops sch_bpf_qdisc_ops __read_mostly = {
> +	.cl_ops		=	&sch_bpf_class_ops,
> +	.id		=	"bpf",
> +	.priv_size	=	sizeof(struct bpf_sched_data),
> +	.enqueue	=	sch_bpf_enqueue,
> +	.dequeue	=	sch_bpf_dequeue,

I looked at the high level of the patchset. The major ops that it wants to be 
programmable in bpf is the ".enqueue" and ".dequeue" (+ ".init" and ".reset" in 
patch 4 and patch 5).

This patch adds a new prog type BPF_PROG_TYPE_QDISC, four attach types (each for 
".enqueue", ".dequeue", ".init", and ".reset"), and a new "bpf_qdisc_ctx" in the 
uapi. It is no long an acceptable way to add new bpf extension.

Can the ".enqueue", ".dequeue", ".init", and ".reset" be completely implemented 
in bpf (with the help of new kfuncs if needed)? Then a struct_ops for Qdisc_ops 
can be created. The bpf Qdisc_ops can be loaded through the existing struct_ops api.

If other ops (like ".dump", ".dump_stats"...) do not have good use case to be 
programmable in bpf, it can stay with the kernel implementation for now and only 
allows the userspace to load the a bpf Qdisc_ops with .equeue/dequeue/init/reset 
implemented.

You mentioned in the cover letter that:
"Current struct_ops attachment model does not seem to support replacing only 
functions of a specific instance of a module, but I might be wrong."

I assumed you meant allow bpf to replace only "some" ops of the Qdisc_ops? Yes, 
it can be done through the struct_ops's ".init_member". Take a look at 
bpf_tcp_ca_init_member. The kernel can assign the kernel implementation for 
".dump" (for example) when loading the bpf Qdisc_ops.

> +	.peek		=	qdisc_peek_dequeued,
> +	.init		=	sch_bpf_init,
> +	.reset		=	sch_bpf_reset, > +	.destroy	=	sch_bpf_destroy,
> +	.change		=	sch_bpf_change,
> +	.dump		=	sch_bpf_dump,
> +	.dump_stats	=	sch_bpf_dump_stats,
> +	.owner		=	THIS_MODULE,
> +};
> +
> +static int __init sch_bpf_mod_init(void)
> +{
> +	return register_qdisc(&sch_bpf_qdisc_ops);
> +}
> +
> +static void __exit sch_bpf_mod_exit(void)
> +{
> +	unregister_qdisc(&sch_bpf_qdisc_ops);
> +}


