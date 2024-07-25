Return-Path: <bpf+bounces-35676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E3793CA28
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 23:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B355E283269
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 21:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC0713D8B3;
	Thu, 25 Jul 2024 21:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dT+jRFAg"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632C6D299
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 21:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721942713; cv=none; b=CeqtuqPKfM/cf0gbEtwqzjfPJQDX/ow92GFryKSxLtobIxgkST5/e1IwqHmdUPUsiEJCfvxY4cHEEZWyn9AJOiKxLUazno94eUEJNKUzFjYlBrj/nsRqwbLCb93wewksEvWE+34U3PyQKQYq7oUCGVX+3jCl9rNMnRLihId65jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721942713; c=relaxed/simple;
	bh=0JC/WLN6BjuTUQVH8BKpfB1ZXi6mkyKsqHg7uaUydkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccVs5IVfyOiRFac4GRtKq1KWMfse0NX0FvNFOHfb4nADMicQXMkPJUrttVM3GTZFboY9X6Haom13oUC0Zr23gyX+BT+ezFCRj6IVs7yZ2YFHVJSA+uiDJZ8J6F9LZ2POT4rK9ghK6fpUkFKfgHp1sZDZLws4lBZKqgKwVAsKzmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dT+jRFAg; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d0ff81d2-3297-4b13-855b-810c11390dc9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721942708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SuxSTTda5CLjkytbbMkgs4nkmCaGaqv3jbRpvg9tUx8=;
	b=dT+jRFAgntc0bRa03UTutPpwXrDGISJ3rNOyp987z4ExZgFup6rS6/0XnuRgG3C2skb8Ty
	qSJ52w5v67KAyCb//6iMHao0A4ZDDGzXC+DwpXvCFBP+FUzkTZafQqLi6YVVwovneLpPMw
	HW5GTocSZyLP0QEfDMn9NFRG3QLv0jc=
Date: Thu, 25 Jul 2024 14:24:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v9 05/11] bpf: net_sched: Support implementation of
 Qdisc_ops in bpf
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, yangpeihao@sjtu.edu.cn,
 daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com,
 martin.lau@kernel.org, sinquersw@gmail.com, toke@redhat.com,
 jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com,
 xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
 <20240714175130.4051012-6-amery.hung@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240714175130.4051012-6-amery.hung@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/14/24 10:51 AM, Amery Hung wrote:
> +static const struct bpf_func_proto *
> +bpf_qdisc_get_func_proto(enum bpf_func_id func_id,
> +			 const struct bpf_prog *prog)
> +{
> +	switch (func_id) {

Instead of an empty switch, it should be useful to provide the skb->data related 
helper. It can start with read only dynptr first, the BPF_FUNC_dynptr_read 
helper here.

Also, the kfuncs: bpf_dynptr_slice and bpf_dynptr_from_skb_rdonly.

> +	default:
> +		return bpf_base_func_proto(func_id, prog);

[ ... ]

> +	}
> +}
> +
> +BTF_ID_LIST_SINGLE(bpf_sk_buff_ids, struct, sk_buff)
> +BTF_ID_LIST_SINGLE(bpf_sk_buff_ptr_ids, struct, bpf_sk_buff_ptr)
> +
> +static bool bpf_qdisc_is_valid_access(int off, int size,
> +				      enum bpf_access_type type,
> +				      const struct bpf_prog *prog,
> +				      struct bpf_insn_access_aux *info)
> +{
> +	struct btf *btf = prog->aux->attach_btf;
> +	u32 arg;
> +
> +	arg = get_ctx_arg_idx(btf, prog->aux->attach_func_proto, off);
> +	if (!strcmp(prog->aux->attach_func_name, "enqueue")) {
> +		if (arg == 2) {
> +			info->reg_type = PTR_TO_BTF_ID | PTR_TRUSTED;
> +			info->btf = btf;
> +			info->btf_id = bpf_sk_buff_ptr_ids[0];
> +			return true;

This will allow type == BPF_WRITE to ctx which should be rejected. The below 
bpf_tracing_btf_ctx_access() could have rejected it.

> +		}
> +	}
> +
> +	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
> +}
> +

[ ... ]

> +
> +static bool is_unsupported(u32 member_offset)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(unsupported_ops); i++) {
> +		if (member_offset == unsupported_ops[i])
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int bpf_qdisc_check_member(const struct btf_type *t,
> +				  const struct btf_member *member,
> +				  const struct bpf_prog *prog)
> +{
> +	if (is_unsupported(__btf_member_bit_offset(t, member) / 8))

Note that the ".check_member" and the "is_unsupported" can be removed as you 
also noticed on the recent unsupported ops cleanup patches.

> +		return -ENOTSUPP;
> +	return 0;
> +}

[ ... ]

> +static struct Qdisc_ops __bpf_ops_qdisc_ops = {
> +	.enqueue = Qdisc_ops__enqueue,
> +	.dequeue = Qdisc_ops__dequeue,
> +	.peek = Qdisc_ops__peek,
> +	.init = Qdisc_ops__init,
> +	.reset = Qdisc_ops__reset,
> +	.destroy = Qdisc_ops__destroy,
> +	.change = Qdisc_ops__change,
> +	.attach = Qdisc_ops__attach,
> +	.change_tx_queue_len = Qdisc_ops__change_tx_queue_len,
> +	.change_real_num_tx = Qdisc_ops__change_real_num_tx,
> +	.dump = Qdisc_ops__dump,
> +	.dump_stats = Qdisc_ops__dump_stats,

Similar to the above is_unsupported comment. The unsupported ops should be 
removed from the cfi_stubs.

> +	.ingress_block_set = Qdisc_ops__ingress_block_set,
> +	.egress_block_set = Qdisc_ops__egress_block_set,
> +	.ingress_block_get = Qdisc_ops__ingress_block_get,
> +	.egress_block_get = Qdisc_ops__egress_block_get,
> +};
> +
> +static struct bpf_struct_ops bpf_Qdisc_ops = {
> +	.verifier_ops = &bpf_qdisc_verifier_ops,
> +	.reg = bpf_qdisc_reg,
> +	.unreg = bpf_qdisc_unreg,
> +	.check_member = bpf_qdisc_check_member,
> +	.init_member = bpf_qdisc_init_member,
> +	.init = bpf_qdisc_init,
> +	.validate = bpf_qdisc_validate,

".validate" is optional. The empty "bpf_qdisc_validate" can be removed.

> +	.name = "Qdisc_ops",
> +	.cfi_stubs = &__bpf_ops_qdisc_ops,
> +	.owner = THIS_MODULE,
> +};



