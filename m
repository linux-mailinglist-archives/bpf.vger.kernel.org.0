Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F29F6C3CBA
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 22:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjCUVb7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 17:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCUVb6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 17:31:58 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FF9584A0
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 14:31:56 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id i36-20020a635424000000b0050f93a35888so1623399pgb.17
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 14:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679434315;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BHaAr0uDAMxGAcb/KipOUQu6/FQIs0rhE+32XUg/qjU=;
        b=j9tPSOPKmVWWyArQXRU009Jg8h4u639apWU23LgsjLQsM7WeceF5snjZNpa476OMU1
         qbb2m4Ba3cSwIlBliulfi7d3z9jYP7/dNPMY96n3/y057QMmlQlkzq0MNrq0pcoSFSw/
         n3GkPfag7kquJ4cBDCYLlF2VR2+nXuhxiFljLpyv2vRkrL06ER3FjqCzo2z3CuXF5/Yk
         fFWUyIFRszl+5OMRma8aZmnaVZaUfRSpfXUdPfQAYN2uwyzxwxZGeSpjlPwloOBt1aIP
         5Lw9f9KV8O3ZxPXqJhfK2GydE/CyFQGaf/HeqkHIE/nl2h0aED5KjMw7YrXwStGpam9d
         2OXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679434315;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHaAr0uDAMxGAcb/KipOUQu6/FQIs0rhE+32XUg/qjU=;
        b=Pz+6lcOHXo6ak2py5g2NViGfAlY0Dhz4ifPV+BCuWluuxuuKXCRmXK94EJSQ39kTAD
         RpMzh4d5erDBO+AdBJK5Hl+OEDf2GGc2JAzMOA/3vg51M+ZpA2fnnVPZQBTH/mIZ4OzO
         QEazaWNiwBIwjyokp4NTWiWxm/y3tst8YNIeASJDj0TgZesLW73WeldjwFo4zNhpncdu
         CD4viyRyaubr4tmJr7AoaMmSYU0cKPtuqrdIcWf8afF/H2s+HnqEVs39DdEO6+f1Uiwg
         FZkXgiOz/6xXm9w7NcoiF77I8ecLjSXWdO0Uk0ej8ntWZN6deghznMEvobj0BZme/YZD
         skCA==
X-Gm-Message-State: AO0yUKWgsuPVs1ulyqYkiSGPUXQzDMg7DlhdKwgUYNukPKw/WBgWS+qF
        zG97ONcSMT0QUEiohfF886wNoyQ=
X-Google-Smtp-Source: AK7set8RXRP/1D8JaseSa6mJ1mqLl+OZmNRrOo5uzMqvlgM5qXXZBFVejvqzYW3MVGIVlozzXY12hJQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a65:61b0:0:b0:50c:bde:50c7 with SMTP id
 i16-20020a6561b0000000b0050c0bde50c7mr115615pgv.12.1679434315388; Tue, 21 Mar
 2023 14:31:55 -0700 (PDT)
Date:   Tue, 21 Mar 2023 14:31:54 -0700
In-Reply-To: <20230321184541.1857363-4-aditi.ghag@isovalent.com>
Mime-Version: 1.0
References: <20230321184541.1857363-1-aditi.ghag@isovalent.com> <20230321184541.1857363-4-aditi.ghag@isovalent.com>
Message-ID: <ZBoiShkzD5KY2uIt@google.com>
Subject: Re: [PATCH v3 bpf-next 3/5] [RFC] net: Skip taking lock in BPF context
From:   Stanislav Fomichev <sdf@google.com>
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/21, Aditi Ghag wrote:
> When sockets are destroyed in the BPF iterator context, sock
> lock is already acquired, so skip taking the lock. This allows
> TCP listening sockets to be destroyed from BPF programs.

> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> ---
>   net/ipv4/inet_hashtables.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)

> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index e41fdc38ce19..5543a3e0d1b4 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -777,9 +777,11 @@ void inet_unhash(struct sock *sk)
>   		/* Don't disable bottom halves while acquiring the lock to
>   		 * avoid circular locking dependency on PREEMPT_RT.
>   		 */
> -		spin_lock(&ilb2->lock);
> +		if (!has_current_bpf_ctx())
> +			spin_lock(&ilb2->lock);
>   		if (sk_unhashed(sk)) {
> -			spin_unlock(&ilb2->lock);
> +			if (!has_current_bpf_ctx())
> +				spin_unlock(&ilb2->lock);

That's bucket lock, why do we have to skip it?

>   			return;
>   		}

> @@ -788,7 +790,8 @@ void inet_unhash(struct sock *sk)

>   		__sk_nulls_del_node_init_rcu(sk);
>   		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> -		spin_unlock(&ilb2->lock);
> +		if (!has_current_bpf_ctx())
> +			spin_unlock(&ilb2->lock);
>   	} else {
>   		spinlock_t *lock = inet_ehash_lockp(hashinfo, sk->sk_hash);

> --
> 2.34.1

