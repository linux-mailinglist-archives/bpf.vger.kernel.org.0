Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0206549CD
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 01:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiLWAhe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 19:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbiLWAhc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 19:37:32 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA4E21E3F
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 16:37:30 -0800 (PST)
Message-ID: <5983e0f0-e1ee-5843-33ea-64d139e2e849@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671755849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JceIQfLZRY1LXp17Oy+hIAu5loWLm7BBcPqVgvGdpPU=;
        b=S5bf+K30PuZZxmPcy4S9JAWZJ9ZdmTh3vUE37ERua6ilsbetSslQL/5aQ3bNWveBMQsEIT
        vWSxHSLDDHBCkXHfqtWvc6qBLdP09gqWrDVMbybBoLMNRKbWPXq2fF8fi/GNTqJnMoJ3Ku
        2ZojUur5BVTk7+Fb4Ds+KY45qi3cf58=
Date:   Thu, 22 Dec 2022 16:37:25 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 08/17] bpf: Support consuming XDP HW metadata
 from fext programs
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org
References: <20221220222043.3348718-1-sdf@google.com>
 <20221220222043.3348718-9-sdf@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221220222043.3348718-9-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/20/22 2:20 PM, Stanislav Fomichev wrote:
> diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> index 0e3fc743e0a8..60978a1f9baa 100644
> --- a/kernel/bpf/offload.c
> +++ b/kernel/bpf/offload.c
> @@ -187,17 +187,13 @@ static void __bpf_offload_dev_netdev_unregister(struct bpf_offload_dev *offdev,
>   	kfree(ondev);
>   }
>   
> -int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
> +static int __bpf_prog_dev_bound_init(struct bpf_prog *prog, struct net_device *netdev)
>   {
>   	struct bpf_offload_netdev *ondev;
>   	struct bpf_prog_offload *offload;
>   	int err;
>   
> -	if (attr->prog_type != BPF_PROG_TYPE_SCHED_CLS &&
> -	    attr->prog_type != BPF_PROG_TYPE_XDP)
> -		return -EINVAL;
> -
> -	if (attr->prog_flags & ~BPF_F_XDP_DEV_BOUND_ONLY)
> +	if (!netdev)

Is this !netdev test needed?

>   		return -EINVAL;
>   
>   	offload = kzalloc(sizeof(*offload), GFP_USER);
> @@ -205,21 +201,13 @@ int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
>   		return -ENOMEM;
>   
>   	offload->prog = prog;
> +	offload->netdev = netdev;
>   
> -	offload->netdev = dev_get_by_index(current->nsproxy->net_ns,
> -					   attr->prog_ifindex);
> -	err = bpf_dev_offload_check(offload->netdev);
> -	if (err)
> -		goto err_maybe_put;
> -
> -	prog->aux->offload_requested = !(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY);
> -
> -	down_write(&bpf_devs_lock);
>   	ondev = bpf_offload_find_netdev(offload->netdev);
>   	if (!ondev) {
>   		if (bpf_prog_is_offloaded(prog->aux)) {
>   			err = -EINVAL;
> -			goto err_unlock;
> +			goto err_free;
>   		}
>   
>   		/* When only binding to the device, explicitly
> @@ -227,25 +215,80 @@ int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
>   		 */
>   		err = __bpf_offload_dev_netdev_register(NULL, offload->netdev);
>   		if (err)
> -			goto err_unlock;
> +			goto err_free;
>   		ondev = bpf_offload_find_netdev(offload->netdev);
>   	}
>   	offload->offdev = ondev->offdev;
>   	prog->aux->offload = offload;
>   	list_add_tail(&offload->offloads, &ondev->progs);
> -	dev_put(offload->netdev);
> -	up_write(&bpf_devs_lock);
>   
>   	return 0;
> -err_unlock:
> -	up_write(&bpf_devs_lock);
> -err_maybe_put:
> -	if (offload->netdev)
> -		dev_put(offload->netdev);
> +err_free:
>   	kfree(offload);
>   	return err;
>   }
>   
> +int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
> +{
> +	struct net_device *netdev;
> +	int err;
> +
> +	if (attr->prog_type != BPF_PROG_TYPE_SCHED_CLS &&
> +	    attr->prog_type != BPF_PROG_TYPE_XDP)
> +		return -EINVAL;
> +
> +	if (attr->prog_flags & ~BPF_F_XDP_DEV_BOUND_ONLY)
> +		return -EINVAL;
> +
> +	netdev = dev_get_by_index(current->nsproxy->net_ns, attr->prog_ifindex);
> +	if (!netdev)
> +		return -EINVAL;
> +
> +	down_write(&bpf_devs_lock);
> +	err = bpf_dev_offload_check(netdev);
> +	if (err)
> +		goto out;
> +
> +	prog->aux->offload_requested = !(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY);

nit. move the bpf_dev_offload_check() and offload_requested assignment out.  I 
don't think they need lock protection so that it is clear what the lock is 
protecting in the future reading.  It seems the original code have them outside 
also.

> +
> +	err = __bpf_prog_dev_bound_init(prog, netdev);
> +	if (err)
> +		goto out;

nit. goto can be saved.

> +
> +out:
> +	dev_put(netdev);
> +	up_write(&bpf_devs_lock);
> +	return err;
> +}
> +
> +int bpf_prog_dev_bound_inherit(struct bpf_prog *new_prog, struct bpf_prog *old_prog)
> +{
> +	int err;
> +
> +	if (!bpf_prog_is_dev_bound(old_prog->aux))
> +		return 0;
> +
> +	if (bpf_prog_is_offloaded(old_prog->aux))
> +		return -EINVAL;
> +
> +	down_write(&bpf_devs_lock);
> +	if (!old_prog->aux->offload) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	new_prog->aux->dev_bound = old_prog->aux->dev_bound;
> +	new_prog->aux->offload_requested = old_prog->aux->offload_requested;

nit. Same here, I think the initialization can be moved outside of the lock.

> +
> +	err = __bpf_prog_dev_bound_init(new_prog, old_prog->aux->offload->netdev);
> +	if (err)
> +		goto out;

goto can be saved.

> +
> +out:
> +	up_write(&bpf_devs_lock);
> +	return err;
> +}
> +
>   int bpf_prog_offload_verifier_prep(struct bpf_prog *prog)
>   {
>   	struct bpf_prog_offload *offload;
> @@ -687,6 +730,22 @@ bool bpf_offload_dev_match(struct bpf_prog *prog, struct net_device *netdev)
>   }
>   EXPORT_SYMBOL_GPL(bpf_offload_dev_match);
>   
> +bool bpf_prog_dev_bound_match(struct bpf_prog *lhs, struct bpf_prog *rhs)
> +{
> +	bool ret;
> +
> +	if (bpf_prog_is_offloaded(lhs->aux) != bpf_prog_is_offloaded(rhs->aux))
> +		return false;
> +
> +	down_read(&bpf_devs_lock);
> +	ret = lhs->aux->offload && rhs->aux->offload &&
> +	      lhs->aux->offload->netdev &&
> +	      lhs->aux->offload->netdev == rhs->aux->offload->netdev;
> +	up_read(&bpf_devs_lock);
> +
> +	return ret;
> +}
> +
>   bool bpf_offload_prog_map_match(struct bpf_prog *prog, struct bpf_map *map)
>   {
>   	struct bpf_offloaded_map *offmap;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 11c558be4992..64a68e8fb072 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2605,6 +2605,12 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
>   			goto free_prog_sec;
>   	}
>   
> +	if (type == BPF_PROG_TYPE_EXT && dst_prog) {

Does it also need to test the bpf_prog_is_dev_bound(dst_prog->aux)?  Otherwise, 
the bpf_prog_dev_bound_inherit() below will fail on everything for !CONFIG_NET.

> +		err = bpf_prog_dev_bound_inherit(prog, dst_prog);
> +		if (err)
> +			goto free_prog_sec;
> +	}
> +
>   	/* find program type: socket_filter vs tracing_filter */
>   	err = find_prog_type(type, prog);
>   	if (err < 0)
> @@ -3021,6 +3027,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>   			goto out_put_prog;
>   		}
>   
> +		if (bpf_prog_is_dev_bound(prog->aux) &&

Like here.

> +		    !bpf_prog_dev_bound_match(prog, tgt_prog)) {
> +			err = -EINVAL;
> +			goto out_put_prog;
> +		}
> +
>   		key = bpf_trampoline_compute_key(tgt_prog, NULL, btf_id);
>   	}
>   
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 320451a0be3e..64f4d2b5824f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16537,11 +16537,6 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>   	if (tgt_prog) {
>   		struct bpf_prog_aux *aux = tgt_prog->aux;
>   
> -		if (bpf_prog_is_dev_bound(tgt_prog->aux)) {
> -			bpf_log(log, "Replacing device-bound programs not supported\n");
> -			return -EINVAL;
> -		}
> -
>   		for (i = 0; i < aux->func_info_cnt; i++)
>   			if (aux->func_info[i].type_id == btf_id) {
>   				subprog = i;

