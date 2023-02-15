Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C9E697481
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 03:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBOCnk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 21:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBOCnj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 21:43:39 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F7C113DA
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 18:43:38 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id u6-20020a170903124600b00188cd4769bcso9991461plh.0
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 18:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676429017;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s1U1f1VTlLmz4j5eRvxBDgvqgzKVN0xAx/m9Js/LBb8=;
        b=hpod647FwiksBYh5ZbosQw8GPK9ZTyY4D/R/RfvfUp02ALYszmJ1O4q2714L4w+nKT
         Xf07f4S6vOPwTZp+tK30r27DzhVuDZq0iuLnboXZHu6ykGUI38y5yRbVso9VQ/CexQ7o
         jz0AlOyZQ8M0x6UmscidFW6XsbK/19xUVFTz24SAXBByAZoX+WsEOanXMigGe2Gxqx8f
         EWyBXH1a6c1VyJMsy9sLnSrZRDT7iEJ+S7rLdtGdvDMNCLQhgk3sytwtnyCeiTsTAZ+m
         TMAnNYjcVVN0yMRyHDKMmt7Uw7Gqb7IxP1AWRmyn61E1bNYhgFXYrREcOru4Qjwr/x62
         sY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676429017;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1U1f1VTlLmz4j5eRvxBDgvqgzKVN0xAx/m9Js/LBb8=;
        b=mtQnhD+Xkh6QR3RDqKxkrqIg4tj3mwzSr2mxzEA35l51h7klpjdUwRzcnzjVqHuLet
         x3n9CsV8nuOjaenHdNaOulJc805sL85Z/pOXWClN8nx5b+bsAxcXiHEl62v4LFH/9dC2
         gFcoiw5aXfTTYLl/5JtYioS4nXAv2e2MgcgJn6u/vDnYbw9eZdl9F0+w/5NbKF2ODKe0
         qCI7MDNuviHIS/gMChK3wzGQmwCXKZeX18Tam7XSMx8k8B+RVIzkKClk+Fmpnfc2/GOq
         zRjrqtZqq7A75Po/GbMT6bwBLHkkQRONLLgdFNUv3Sv4f+9EqzkpJbqFRlufGgC7aL4z
         cORg==
X-Gm-Message-State: AO0yUKU7nRf3NwgiHeKD9lmYGuB8/o3inmsH5J6/uqEx77vWNhwslSiY
        avGloA0H1EUe2Q8rDBbVf1c/ZLk=
X-Google-Smtp-Source: AK7set8H68XPSPNYU7AZbXikE3srUsBr+v10QpneGjzRyiQmERdUkoYnQU0t4LA2lMHU8jO7miUVGmg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:aa7:9570:0:b0:5a8:b3db:4600 with SMTP id
 x16-20020aa79570000000b005a8b3db4600mr70542pfq.3.1676429017595; Tue, 14 Feb
 2023 18:43:37 -0800 (PST)
Date:   Tue, 14 Feb 2023 18:43:36 -0800
In-Reply-To: <20230214221718.503964-3-kuifeng@meta.com>
Mime-Version: 1.0
References: <20230214221718.503964-1-kuifeng@meta.com> <20230214221718.503964-3-kuifeng@meta.com>
Message-ID: <Y+xG2DNzFt2Uq+8F@google.com>
Subject: Re: [PATCH bpf-next 2/7] net: Update an existing TCP congestion
 control algorithm.
From:   Stanislav Fomichev <sdf@google.com>
To:     Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/14, Kui-Feng Lee wrote:
> This feature lets you immediately transition to another congestion
> control algorithm or implementation with the same name.  Once a name
> is updated, new connections will apply this new algorithm.

> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>   include/linux/bpf.h            |  1 +
>   include/net/tcp.h              |  2 ++
>   net/bpf/bpf_dummy_struct_ops.c |  6 ++++++
>   net/ipv4/bpf_tcp_ca.c          |  6 ++++++
>   net/ipv4/tcp_cong.c            | 39 ++++++++++++++++++++++++++++++++++
>   5 files changed, 54 insertions(+)

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 13683584b071..5fe39f56a760 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1450,6 +1450,7 @@ struct bpf_struct_ops {
>   			   void *kdata, const void *udata);
>   	int (*reg)(void *kdata);
>   	void (*unreg)(void *kdata);
> +	int (*update)(void *kdata, void *old_kdata);
>   	const struct btf_type *type;
>   	const struct btf_type *value_type;
>   	const char *name;
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index db9f828e9d1e..239cc0e2639c 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1117,6 +1117,8 @@ struct tcp_congestion_ops {

>   int tcp_register_congestion_control(struct tcp_congestion_ops *type);
>   void tcp_unregister_congestion_control(struct tcp_congestion_ops *type);
> +int tcp_update_congestion_control(struct tcp_congestion_ops *type,
> +				  struct tcp_congestion_ops *old_type);

>   void tcp_assign_congestion_control(struct sock *sk);
>   void tcp_init_congestion_control(struct sock *sk);
> diff --git a/net/bpf/bpf_dummy_struct_ops.c  
> b/net/bpf/bpf_dummy_struct_ops.c
> index ff4f89a2b02a..158f14e240d0 100644
> --- a/net/bpf/bpf_dummy_struct_ops.c
> +++ b/net/bpf/bpf_dummy_struct_ops.c
> @@ -222,12 +222,18 @@ static void bpf_dummy_unreg(void *kdata)
>   {
>   }

> +static int bpf_dummy_update(void *kdata, void *old_kdata)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   struct bpf_struct_ops bpf_bpf_dummy_ops = {
>   	.verifier_ops = &bpf_dummy_verifier_ops,
>   	.init = bpf_dummy_init,
>   	.check_member = bpf_dummy_ops_check_member,
>   	.init_member = bpf_dummy_init_member,
>   	.reg = bpf_dummy_reg,
> +	.update = bpf_dummy_update,
>   	.unreg = bpf_dummy_unreg,
>   	.name = "bpf_dummy_ops",
>   };
> diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
> index 13fc0c185cd9..66ce5fadfe42 100644
> --- a/net/ipv4/bpf_tcp_ca.c
> +++ b/net/ipv4/bpf_tcp_ca.c
> @@ -266,10 +266,16 @@ static void bpf_tcp_ca_unreg(void *kdata)
>   	tcp_unregister_congestion_control(kdata);
>   }

> +static int bpf_tcp_ca_update(void *kdata, void *old_kdata)
> +{
> +	return tcp_update_congestion_control(kdata, old_kdata);
> +}
> +
>   struct bpf_struct_ops bpf_tcp_congestion_ops = {
>   	.verifier_ops = &bpf_tcp_ca_verifier_ops,
>   	.reg = bpf_tcp_ca_reg,
>   	.unreg = bpf_tcp_ca_unreg,
> +	.update = bpf_tcp_ca_update,
>   	.check_member = bpf_tcp_ca_check_member,
>   	.init_member = bpf_tcp_ca_init_member,
>   	.init = bpf_tcp_ca_init,
> diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
> index db8b4b488c31..22fd7c12360e 100644
> --- a/net/ipv4/tcp_cong.c
> +++ b/net/ipv4/tcp_cong.c
> @@ -130,6 +130,45 @@ void tcp_unregister_congestion_control(struct  
> tcp_congestion_ops *ca)
>   }
>   EXPORT_SYMBOL_GPL(tcp_unregister_congestion_control);

> +/* Replace a registered old ca with a new one.
> + *
> + * The new ca must have the same name as the old one, that has been
> + * registered.
> + */
> +int tcp_update_congestion_control(struct tcp_congestion_ops *ca, struct  
> tcp_congestion_ops *old_ca)
> +{
> +	struct tcp_congestion_ops *existing;
> +	int ret = 0;
> +

[..]

> +	/* all algorithms must implement these */
> +	if (!ca->ssthresh || !ca->undo_cwnd ||
> +	    !(ca->cong_avoid || ca->cong_control)) {
> +		pr_err("%s does not implement required ops\n", old_ca->name);
> +		return -EINVAL;
> +	}
> +
> +	ca->key = jhash(ca->name, sizeof(ca->name), strlen(ca->name));

Can we have this as some common _validate method to avoid copy-paste
from tcp_register_congestion_control.

Or, even better, can we can since function handle both cases?

tcp_register_congestion_control(ca, old_ca);
	- when old_ca == NULL -> register
	- when old_ca != NULL -> try to update

> +
> +	spin_lock(&tcp_cong_list_lock);
> +	existing = tcp_ca_find_key(ca->key);
> +	if (ca->key == TCP_CA_UNSPEC || !existing || strcmp(existing->name,  
> ca->name)) {
> +		pr_notice("%s not registered or non-unique key\n",
> +			  ca->name);
> +		ret = -EINVAL;
> +	} else if (existing != old_ca) {
> +		pr_notice("invalid old congestion control algorithm to replace\n");
> +		ret = -EINVAL;
> +	} else {
> +		list_del_rcu(&existing->list);
> +		list_add_tail_rcu(&ca->list, &tcp_cong_list);
> +		pr_debug("%s updated\n", ca->name);
> +	}
> +	spin_unlock(&tcp_cong_list_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(tcp_update_congestion_control);
> +
>   u32 tcp_ca_get_key_by_name(struct net *net, const char *name, bool  
> *ecn_ca)
>   {
>   	const struct tcp_congestion_ops *ca;
> --
> 2.30.2

