Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6632552C4BC
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 22:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242657AbiERUrK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 16:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242646AbiERUrI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 16:47:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7C2516D10D
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 13:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652906826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6fGaMCZY5et8TukPAizblMAmglbYj53OBTyrqhmz88w=;
        b=ZM1YcQlAvkB/1eqli6J87ogAHRZw7+DScvpsYtF/EzPDfCjgnj3NAHMHWq0l5W3v3AMV85
        5tr1GBTVE4tqKaWfknZK+N1VEC0jaTxOWJJw+sTfVOpwS2yzsXZVB70ej1aWDTdyEpLkam
        UttznWEMf62nfKXCQMK7upfZYqLw9oM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-45rg3KFQOgKDz5EqIZmtvA-1; Wed, 18 May 2022 16:47:05 -0400
X-MC-Unique: 45rg3KFQOgKDz5EqIZmtvA-1
Received: by mail-ej1-f70.google.com with SMTP id hr42-20020a1709073faa00b006f4dc7f0be1so1506016ejc.22
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 13:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=6fGaMCZY5et8TukPAizblMAmglbYj53OBTyrqhmz88w=;
        b=Raz5G+XlBj1+1ZqqOqCcX0eGVnE8PbcAL9r9wM9aTBS9whwUobPJ5rPL+QYHPpk9qK
         3VQsG23hqGjhzElMdAqkd5L94wnzfR/2gjbRNS0//6R4WSRvMFWkMqTlQPnDtV1lEFIw
         31bLaBkVUv1WIhxA+oIFZNjmTZ5g8Q1EJ2/awyYBAgEo/RhxRwvJrLuResbH2moq4SOl
         VKV7RNxI031Ktr+QKqZ4hppb0FKIshJofwWl8GbVeQj+57IK1WhTrhhOT4/AN0Nc1Mvm
         d4JkqCjSNgPfQ4phYDTVOcFx1lznc6NwAUNeCn1pQ6W1BXdsa4np1BBUIQt27aYKjLO6
         gbsA==
X-Gm-Message-State: AOAM530cTk6KGwLOVXSQwnI9NycIv+Gg7hpTVxYMI2Xgl8agAWpP3GxA
        ml3mLwABOqLx1o0MLL+N3COSxgDWSRBz63qGe/ih1BH2o5EUhbdqb/ySZ8QgEpuWoDQK0oJWILA
        oyGopgvXl9EpP
X-Received: by 2002:a05:6402:42c3:b0:427:d0e6:77e4 with SMTP id i3-20020a05640242c300b00427d0e677e4mr1713687edc.49.1652906823659;
        Wed, 18 May 2022 13:47:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxU+QcXpwCCUC54IoV+68Kfuh6QV3pxBg4jLbN9Abl1ZBDKxwxbxaitmQrB/0M+62Dhle2xRg==
X-Received: by 2002:a05:6402:42c3:b0:427:d0e6:77e4 with SMTP id i3-20020a05640242c300b00427d0e677e4mr1713571edc.49.1652906822014;
        Wed, 18 May 2022 13:47:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id hf1-20020a1709072c4100b006f3ef214da0sm1287460ejc.6.2022.05.18.13.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:47:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9E1D038ECC8; Wed, 18 May 2022 22:47:00 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, davem@davemloft.net, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, pablo@netfilter.org,
        fw@strlen.de, netfilter-devel@vger.kernel.org,
        lorenzo.bianconi@redhat.com, brouer@redhat.com, memxor@gmail.com
Subject: Re: [PATCH v3 bpf-next 4/5] net: netfilter: add kfunc helper to add
 a new ct entry
In-Reply-To: <40e7ce4b79c86c46e5fbf22e9cafb51b9172da19.1652870182.git.lorenzo@kernel.org>
References: <cover.1652870182.git.lorenzo@kernel.org>
 <40e7ce4b79c86c46e5fbf22e9cafb51b9172da19.1652870182.git.lorenzo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 18 May 2022 22:47:00 +0200
Message-ID: <87y1yy8t6j.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Introduce bpf_xdp_ct_add and bpf_skb_ct_add kfunc helpers in order to
> add a new entry to ct map from an ebpf program.
> Introduce bpf_nf_ct_tuple_parse utility routine.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  net/netfilter/nf_conntrack_bpf.c | 212 +++++++++++++++++++++++++++----
>  1 file changed, 189 insertions(+), 23 deletions(-)
>
> diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
> index a9271418db88..3d31b602fdf1 100644
> --- a/net/netfilter/nf_conntrack_bpf.c
> +++ b/net/netfilter/nf_conntrack_bpf.c
> @@ -55,41 +55,114 @@ enum {
>  	NF_BPF_CT_OPTS_SZ = 12,
>  };
>  
> -static struct nf_conn *__bpf_nf_ct_lookup(struct net *net,
> -					  struct bpf_sock_tuple *bpf_tuple,
> -					  u32 tuple_len, u8 protonum,
> -					  s32 netns_id, u8 *dir)
> +static int bpf_nf_ct_tuple_parse(struct bpf_sock_tuple *bpf_tuple,
> +				 u32 tuple_len, u8 protonum, u8 dir,
> +				 struct nf_conntrack_tuple *tuple)
>  {
> -	struct nf_conntrack_tuple_hash *hash;
> -	struct nf_conntrack_tuple tuple;
> -	struct nf_conn *ct;
> +	union nf_inet_addr *src = dir ? &tuple->dst.u3 : &tuple->src.u3;
> +	union nf_inet_addr *dst = dir ? &tuple->src.u3 : &tuple->dst.u3;
> +	union nf_conntrack_man_proto *sport = dir ? (void *)&tuple->dst.u
> +						  : &tuple->src.u;
> +	union nf_conntrack_man_proto *dport = dir ? &tuple->src.u
> +						  : (void *)&tuple->dst.u;
>  
>  	if (unlikely(protonum != IPPROTO_TCP && protonum != IPPROTO_UDP))
> -		return ERR_PTR(-EPROTO);
> -	if (unlikely(netns_id < BPF_F_CURRENT_NETNS))
> -		return ERR_PTR(-EINVAL);
> +		return -EPROTO;
> +
> +	memset(tuple, 0, sizeof(*tuple));
>  
> -	memset(&tuple, 0, sizeof(tuple));
>  	switch (tuple_len) {
>  	case sizeof(bpf_tuple->ipv4):
> -		tuple.src.l3num = AF_INET;
> -		tuple.src.u3.ip = bpf_tuple->ipv4.saddr;
> -		tuple.src.u.tcp.port = bpf_tuple->ipv4.sport;
> -		tuple.dst.u3.ip = bpf_tuple->ipv4.daddr;
> -		tuple.dst.u.tcp.port = bpf_tuple->ipv4.dport;
> +		tuple->src.l3num = AF_INET;
> +		src->ip = bpf_tuple->ipv4.saddr;
> +		sport->tcp.port = bpf_tuple->ipv4.sport;
> +		dst->ip = bpf_tuple->ipv4.daddr;
> +		dport->tcp.port = bpf_tuple->ipv4.dport;
>  		break;
>  	case sizeof(bpf_tuple->ipv6):
> -		tuple.src.l3num = AF_INET6;
> -		memcpy(tuple.src.u3.ip6, bpf_tuple->ipv6.saddr, sizeof(bpf_tuple->ipv6.saddr));
> -		tuple.src.u.tcp.port = bpf_tuple->ipv6.sport;
> -		memcpy(tuple.dst.u3.ip6, bpf_tuple->ipv6.daddr, sizeof(bpf_tuple->ipv6.daddr));
> -		tuple.dst.u.tcp.port = bpf_tuple->ipv6.dport;
> +		tuple->src.l3num = AF_INET6;
> +		memcpy(src->ip6, bpf_tuple->ipv6.saddr, sizeof(bpf_tuple->ipv6.saddr));
> +		sport->tcp.port = bpf_tuple->ipv6.sport;
> +		memcpy(dst->ip6, bpf_tuple->ipv6.daddr, sizeof(bpf_tuple->ipv6.daddr));
> +		dport->tcp.port = bpf_tuple->ipv6.dport;
>  		break;
>  	default:
> -		return ERR_PTR(-EAFNOSUPPORT);
> +		return -EAFNOSUPPORT;
>  	}
> +	tuple->dst.protonum = protonum;
> +	tuple->dst.dir = dir;
> +
> +	return 0;
> +}
>  
> -	tuple.dst.protonum = protonum;
> +struct nf_conn *
> +__bpf_nf_ct_alloc_entry(struct net *net, struct bpf_sock_tuple *bpf_tuple,
> +			u32 tuple_len, u8 protonum, s32 netns_id, u32 timeout)
> +{
> +	struct nf_conntrack_tuple otuple, rtuple;
> +	struct nf_conn *ct;
> +	int err;
> +
> +	if (unlikely(netns_id < BPF_F_CURRENT_NETNS))
> +		return ERR_PTR(-EINVAL);
> +
> +	err = bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, protonum,
> +				    IP_CT_DIR_ORIGINAL, &otuple);
> +	if (err < 0)
> +		return ERR_PTR(err);
> +
> +	err = bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, protonum,
> +				    IP_CT_DIR_REPLY, &rtuple);
> +	if (err < 0)
> +		return ERR_PTR(err);
> +
> +	if (netns_id >= 0) {
> +		net = get_net_ns_by_id(net, netns_id);
> +		if (unlikely(!net))
> +			return ERR_PTR(-ENONET);
> +	}
> +
> +	ct = nf_conntrack_alloc(net, &nf_ct_zone_dflt, &otuple, &rtuple,
> +				GFP_ATOMIC);
> +	if (IS_ERR(ct))
> +		goto out;
> +
> +	ct->timeout = timeout * HZ + jiffies;
> +	ct->status |= IPS_CONFIRMED;
> +
> +	memset(&ct->proto, 0, sizeof(ct->proto));
> +	if (protonum == IPPROTO_TCP)
> +		ct->proto.tcp.state = TCP_CONNTRACK_ESTABLISHED;

Hmm, isn't it a bit limiting to hard-code this to ESTABLISHED
connections? Presumably for TCP you'd want to use this when you see a
SYN and then rely on conntrack to help with the subsequent state
tracking for when the SYN-ACK comes back? What's the usecase for
creating an entry in ESTABLISHED state, exactly?

(Of course, we'd need to be able to update the state as well, then...)

-Toke

