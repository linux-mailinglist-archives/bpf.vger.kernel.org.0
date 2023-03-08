Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1E16B118D
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 20:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCHTAE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 14:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjCHTAC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 14:00:02 -0500
Received: from out-40.mta1.migadu.com (out-40.mta1.migadu.com [IPv6:2001:41d0:203:375::28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF96E85B14
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 10:59:57 -0800 (PST)
Message-ID: <a3ec530d-af78-6ed1-4412-bb527aa7a148@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678301995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2fQ+fqCPaUfG1iltMbf86EIvZ+/hEi0mOrCMdm/N6T8=;
        b=S7g942rmR0hXFaEICe3p4MkAagD/tu9CFYRaEkY8EtS7zrUoXixzI2uPy96dppx+fFaC5F
        A/kuU0hBZUPOL4v1odgyu5ZU6DHCOJnl9oV3Arb/rmRnS4rnl2N8VI+MVPQDAmOU1Hg7Jq
        /QxyPgVPTg7iRgabcmp+joYXvtXjf5s=
Date:   Wed, 8 Mar 2023 10:59:44 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 2/8] net: Update an existing TCP congestion
 control algorithm.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230308005050.255859-1-kuifeng@meta.com>
 <20230308005050.255859-3-kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230308005050.255859-3-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/7/23 4:50 PM, Kui-Feng Lee wrote:
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 50cfc2388cbc..00b6e1a2edaf 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1512,6 +1512,8 @@ struct bpf_struct_ops {
>   			   void *kdata, const void *udata);
>   	int (*reg)(void *kdata);
>   	void (*unreg)(void *kdata);
> +	int (*update)(void *kdata, void *old_kdata);
> +	int (*validate)(void *kdata);
>   	const struct btf_type *type;
>   	const struct btf_type *value_type;
>   	const char *name;
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index db9f828e9d1e..2abb755e6a3a 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1117,6 +1117,9 @@ struct tcp_congestion_ops {
>   
>   int tcp_register_congestion_control(struct tcp_congestion_ops *type);
>   void tcp_unregister_congestion_control(struct tcp_congestion_ops *type);
> +int tcp_update_congestion_control(struct tcp_congestion_ops *type,
> +				  struct tcp_congestion_ops *old_type);
> +int tcp_validate_congestion_control(struct tcp_congestion_ops *ca);
>   
>   void tcp_assign_congestion_control(struct sock *sk);
>   void tcp_init_congestion_control(struct sock *sk);
> diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
> index ff4f89a2b02a..158f14e240d0 100644
> --- a/net/bpf/bpf_dummy_struct_ops.c
> +++ b/net/bpf/bpf_dummy_struct_ops.c
> @@ -222,12 +222,18 @@ static void bpf_dummy_unreg(void *kdata)
>   {
>   }
>   
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
> index 13fc0c185cd9..e8b27826283e 100644
> --- a/net/ipv4/bpf_tcp_ca.c
> +++ b/net/ipv4/bpf_tcp_ca.c
> @@ -239,8 +239,6 @@ static int bpf_tcp_ca_init_member(const struct btf_type *t,
>   		if (bpf_obj_name_cpy(tcp_ca->name, utcp_ca->name,
>   				     sizeof(tcp_ca->name)) <= 0)
>   			return -EINVAL;
> -		if (tcp_ca_find(utcp_ca->name))
> -			return -EEXIST;

This belongs to patch 3 where BPF_F_LINK needs this. move it closer to where it 
is actually used.

>   		return 1;
>   	}
>   
> @@ -266,13 +264,25 @@ static void bpf_tcp_ca_unreg(void *kdata)
>   	tcp_unregister_congestion_control(kdata);
>   }
>   
> +static int bpf_tcp_ca_update(void *kdata, void *old_kdata)
> +{
> +	return tcp_update_congestion_control(kdata, old_kdata);
> +}
> +
> +static int bpf_tcp_ca_validate(void *kdata)
> +{
> +	return tcp_validate_congestion_control(kdata);
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
> +	.validate = bpf_tcp_ca_validate,
>   	.name = "tcp_congestion_ops",
>   };

In general, please move "validate" related bpf changes to patch 3 and "update" 
related changes to patch 5. They are bpf specific (including the changes in 
bpf_tcp_ca.c) and closer to where it will be used.

Then patch 2 should only have changes in tcp_cong.c as the preparation work for 
the later bpf needs. Please cc netdev for patch 2 in the next re-spin.

