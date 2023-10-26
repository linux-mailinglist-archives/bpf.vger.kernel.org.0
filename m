Return-Path: <bpf+bounces-13287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA9D7D7A0E
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 03:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35301B21310
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 01:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB17469D;
	Thu, 26 Oct 2023 01:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNkC8cVI"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD0C1C3D;
	Thu, 26 Oct 2023 01:18:32 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79380137;
	Wed, 25 Oct 2023 18:18:30 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7788db95652so28328785a.2;
        Wed, 25 Oct 2023 18:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698283109; x=1698887909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kTIJhCDs/cr1w8DQETXIYlo5ICvFF6pPgJ8G/6XtlbM=;
        b=TNkC8cVI62q+Am2TciahI1RJQIiDD1iElPe89b7whG2gKQvCijqRCWXlZdm6PNeGOy
         /GPNkzTvvFQSMcS09XLItf8I++wm/CqM9g2afsTVnl3gpl8/gwuh9UqY9e2Ait7zNkun
         pnL6UzB9y0/qKsTHfWH7eIYIUty/keH3GsQ/C2fC36GpP5jC1VbEr977uvZJgky8V6Wn
         MHGA/ZG6BZ4lqfURhGHGkFiSglE9lK2Y9oBI3krn+ODPYH+GOaQq6HnQPUnAl3ecMiCV
         OFTscc02r3jZlHEzfhHGvmmLhRVFUsiNeGn5i2UT5kFispfdzyvgdtyDWf5rksWZhwyc
         d88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698283109; x=1698887909;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTIJhCDs/cr1w8DQETXIYlo5ICvFF6pPgJ8G/6XtlbM=;
        b=gezKvPbSO845Wapaq6LJdHZacOLkR4Aat8vqCp+1EQeB8x8OOh9NtEGalQKVlhwkQ/
         mqPCUBxyE1kH/s/dcFvr8a/p1oyrd9IcrdlMrpjlc+Vqf8NbF7W5Vvgiqpjwg8DkQGFv
         FTpQK1oQ3YeO2Of5yJRaYsyVAT65DQeq6pjRpBrfeOssqL8ix4eT+8WAngJzl3d2QHVd
         gKlw1cCe/jegy4hIR995E5ElkH/SKGOuDy9Y/oahzSA2k79wLLckn/d0X4f2N7OBOSvZ
         CYqXkYUYwWHER6lpJ2OEA9np6P1bidEQe39gDSaxGgs7jLarB7bG/eyF9sknM1ivWHJ/
         dOCw==
X-Gm-Message-State: AOJu0Yy3S6hSFwOdrU0SpTSI6ApOZi0QZTPd+1qQGzwUElBsLDf5Hd2U
	KJl7p9MZ539m3+vYTxwNXYw=
X-Google-Smtp-Source: AGHT+IGRXKPn/XOvDfXHfP/g4hZBmTE/jXYkXOeUuP8QailXL/yuDb4CWi182h9vCZPHDJkpWjSchw==
X-Received: by 2002:a05:620a:170a:b0:775:903e:388c with SMTP id az10-20020a05620a170a00b00775903e388cmr21083139qkb.2.1698283109510;
        Wed, 25 Oct 2023 18:18:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:1545:3e11:ea38:83fe? ([2600:1700:6cf8:1240:1545:3e11:ea38:83fe])
        by smtp.gmail.com with ESMTPSA id s67-20020a818246000000b00583f8f41cb8sm5496248ywf.63.2023.10.25.18.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 18:18:29 -0700 (PDT)
Message-ID: <8e5e26e8-52c7-40a8-bf49-98ac2c330db9@gmail.com>
Date: Wed, 25 Oct 2023 18:18:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/7] netkit, bpf: Add bpf programmable net
 device
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, razor@blackwall.org, ast@kernel.org,
 andrii@kernel.org, john.fastabend@gmail.com, sdf@google.com,
 toke@kernel.org, kuba@kernel.org, andrew@lunn.ch,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
References: <20231024214904.29825-1-daniel@iogearbox.net>
 <20231024214904.29825-2-daniel@iogearbox.net>
 <ad801a2c-217e-44b4-8dae-0ae7b1b8484f@gmail.com>
 <51abec01-c4ce-434f-694a-f932e0e203ec@linux.dev>
 <7e2b81d6-b154-446e-b074-1a8dc6426ce7@gmail.com>
In-Reply-To: <7e2b81d6-b154-446e-b074-1a8dc6426ce7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/25/23 18:15, Kui-Feng Lee wrote:
> 
> 
> On 10/25/23 15:09, Martin KaFai Lau wrote:
>> On 10/25/23 2:24 PM, Kui-Feng Lee wrote:
>>>
>>>
>>> On 10/24/23 14:48, Daniel Borkmann wrote:
>>>> This work adds a new, minimal BPF-programmable device called "netkit"
>>>> (former PoC code-name "meta") we recently presented at LSF/MM/BPF. The
>>>> core idea is that BPF programs are executed within the drivers xmit 
>>>> routine
>>>> and therefore e.g. in case of containers/Pods moving BPF processing 
>>>> closer
>>>> to the source.
>>>>
>>>
>>> Sorry for intruding into this discussion! Although it is too late to
>>> mentioned this since this patchset have been v4 already.
>>>
>>> I notice netkit has introduced a new attach type. I wonder if it
>>> possible to implement it as a new struct_ops type.
>>
>> Could your elaborate more about what does this struct_ops type do and 
>> how is it different from the SCHED_CLS bpf prog that the netkit is 
>> running?
> 
> I found the code has been landed.
> Basing on the landed code and
> the patchset of registering bpf struct_ops from modules that I
> am working on, it will looks like what is done in following patch.
> No changes on syscall, uapi and libbpf are required.
> 
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index 7e484f9fd3ae..e4eafaf397bf 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -20,6 +20,7 @@ struct netkit {
>       struct bpf_mprog_entry __rcu *active;
>       enum netkit_action policy;
>       struct bpf_mprog_bundle    bundle;
> +    struct hlist_head ops_list;
> 
>       /* Needed in slow-path */
>       enum netkit_mode mode;
> @@ -27,6 +28,13 @@ struct netkit {
>       u32 headroom;
>   };
> 
> +struct netkit_ops {
> +    struct hlist_node node;
> +    int ifindex;
> +
> +    int (*xmit)(struct sk_buff *skb);
> +};
> +
>   struct netkit_link {
>       struct bpf_link link;
>       struct net_device *dev;
> @@ -46,6 +54,22 @@ netkit_run(const struct bpf_mprog_entry *entry, 
> struct sk_buff *skb,
>           if (ret != NETKIT_NEXT)
>               break;
>       }
> +
> +    return ret;
> +}
> +
> +static __always_inline int
> +netkit_run_st_ops(const struct netkit *nk, struct sk_buff *skb,
> +       enum netkit_action ret)
> +{
> +    struct netkit_ops *ops;
> +
> +    hlist_for_each_entry_rcu(ops, &nk->ops_list, node) {
> +        ret = ops->xmit(skb);
> +        if (ret != NETKIT_NEXT)
> +            break;
> +    }
> +
>       return ret;
>   }
> 
> @@ -80,6 +104,8 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, 
> struct net_device *dev)
>       entry = rcu_dereference(nk->active);
>       if (entry)
>           ret = netkit_run(entry, skb, ret);
> +    if (ret == NETKIT_NEXT)
> +        ret = netkit_run_st_ops(nk, skb, ret);
>       switch (ret) {
>       case NETKIT_NEXT:
>       case NETKIT_PASS:
> @@ -900,6 +926,78 @@ static const struct nla_policy 
> netkit_policy[IFLA_NETKIT_MAX + 1] = {
>                           .reject_message = "Primary attribute is 
> read-only" },
>   };
> 
> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> +
> +static bool bpf_netkit_ops_is_valid_access(int off, int size,
> +                       enum bpf_access_type type,
> +                       const struct bpf_prog *prog,
> +                       struct bpf_insn_access_aux *info)
> +{
> +    return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
> +}
> +
> +static const struct bpf_verifier_ops bpf_netkit_verifier_ops = {
> +    .is_valid_access = bpf_netkit_ops_is_valid_access,
> +};
> +
> +static int bpf_netkit_ops_reg(void *kdata)
> +{
> +    struct netkit_ops *ops = kdata;
> +    struct netkit_link *nkl;
> +    struct net_device *dev;
> +
> +    BTF_STRUCT_OPS_TYPE_EMIT(netkit_ops);
> +    dev = netkit_dev_fetch(current->nsproxy->net_ns,
> +                   ops->ifindex,
> +                   BPF_NETKIT_PRIMARY);
> +    nkl = netkit_link(dev);
> +    hlist_add_tail_rcu(&ops->node, &nkl->ops_list);
> +
> +    return 0;
> +}
> +
> +static int bpf_netkit_ops_init(struct btf *btf)
> +{
> +    return 0;
> +}
> +
> +static int bpf_netkit_ops_init_member(const struct btf_type *t,
> +                       const struct btf_member *member,
> +                       void *kdata, const void *udata)
> +{
> +    struct netkit_ops *kops = kdata;
> +    struct netkit_ops *uops = kdata;
> +
> +    u32 moff = __btf_member_bit_offset(t, member) / 8;
> +    if (moff == offsetof(struct netkit_ops, ifindex)) {
> +        kops->ifindex = uops->ifindex;
> +        return 1;
> +    }
> +    if (mod < offsetof(struct netkit_ops, ifindex))
> +        return 1;
> +
> +    return 0;
> +}
> +
> +static void bpf_netkit_ops_unreg(void *kdata)
> +{
> +    struct netkit_ops *ops = kdata;
> +
> +    hlist_del_rcu(&ops->node);
> +}
> +
> +struct bpf_struct_ops bpf_netkit_ops = {
> +    .verifier_ops = &bpf_netkit_verifier_ops,
> +    .init = bpf_netkit_ops_init,
> +    .init_member = bpf_netkit_ops_init_member,
> +    .reg = bpf_netkit_ops_reg,
> +    .unreg = bpf_netki_ops_unreg,
> +    .name = "netkit_ops",
> +    .owner = THIS_MODULE,
> +};
> +
> +#endif /* CONFIG_DEBUG_INFO_BTF_MODULES */
> +
>   static struct rtnl_link_ops netkit_link_ops = {
>       .kind        = DRV_NAME,
>       .priv_size    = sizeof(struct netkit),
> @@ -917,17 +1015,22 @@ static struct rtnl_link_ops netkit_link_ops = {
> 
>   static __init int netkit_init(void)
>   {
> +    int ret;
> +
>       BUILD_BUG_ON((int)NETKIT_NEXT != (int)TCX_NEXT ||
>                (int)NETKIT_PASS != (int)TCX_PASS ||
>                (int)NETKIT_DROP != (int)TCX_DROP ||
>                (int)NETKIT_REDIRECT != (int)TCX_REDIRECT);
> 
> -    return rtnl_link_register(&netkit_link_ops);
> +    ret = rtnl_link_register(&netkit_link_ops);
> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> +    ret = ret ?: register_bpf_struct_ops(&bpf_netkit_ops);
> +#endif
>   }
> 
>   static __exit void netkit_exit(void)
>   {
> -    rtnl_link_unregister(&netkit_link_ops);
> +    rtnl_link_unregister(&bpf_netkit_ops);

This change should be removed.

>   }
> 
>   module_init(netkit_init);

