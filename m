Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43C16E103D
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 16:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjDMOoO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 10:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjDMOoD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 10:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810EF2139
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 07:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681396995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4AHxBsSprZmHnjqJ7yFpvkrSr9FZKh55hACs17k4xbc=;
        b=Hj8aqrmyxSxyxniJLmg8LYWK5KGJQu9u7g+KknWx8QD8rymNqUng0b9Y9DYTkWx6FGVXmT
        jZGwobF0ovD92p/KYm5Z7Brg8E2JQGu91ieXSeHb9aL345ebVIYzppSOA5j7wEpRZJOjOj
        WmijfEVd3b649seAWaCnU60ZvoGq04I=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-U7Gwmi60Nj6zUyTxKUl0Fg-1; Thu, 13 Apr 2023 10:43:13 -0400
X-MC-Unique: U7Gwmi60Nj6zUyTxKUl0Fg-1
Received: by mail-ed1-f69.google.com with SMTP id t27-20020a50ab5b000000b0050047ecf4bfso8335277edc.19
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 07:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681396992; x=1683988992;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4AHxBsSprZmHnjqJ7yFpvkrSr9FZKh55hACs17k4xbc=;
        b=DyOXhmXltd5+qlGzZtE6JXIV0WBq2f8Zt6a+Fj9UFd2el/VHEFQXXYRXgXKx2GL1d8
         ndLr3jTghBKMBR6JxBlJoHKrgcomDVq86GrswQlD+9AuZSnPH6jwqeTinj8XZ6tZnji9
         XJkt5hqj5itVYZCR6Ofw8ASOz9oF8MHGYqq4fdp97ce+U0eVV3151MGMBxPvCjaUuuAK
         eLnUJ6kPKfxuVbbEyE9CvMfZjCK+jY9z/6zJqAM0Bz59QTgmkx1Vl+6MoG91pBXVqvMe
         UhVu9yf5VVdsDV/bHvsoMVHLWRF+pOZrf+TXyzBTKYIIjn5cWdVmf2LZslGN4ygh6aKU
         2uFQ==
X-Gm-Message-State: AAQBX9ddL/9C+jBghlwBMLcBajo4MZrS4CSUz2rdXT0ZQ/uKsRG9DWsP
        vx8DNUgalqJ7KVzxSow+ruPSWqUY3hpMlHPEJjeDubt6GL4QtnXXxSti6RnALTuT3MEicqzCNgb
        vJ1+ggZ8YJl3p
X-Received: by 2002:a17:906:2559:b0:94a:e89a:4fc9 with SMTP id j25-20020a170906255900b0094ae89a4fc9mr2839222ejb.73.1681396991587;
        Thu, 13 Apr 2023 07:43:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350YK2Rx/74f9cfSeHxFgTwYsET7Q9ppWRh9RgrRWvGYX6r8Sckh3iEVCMCl2u1De0h+WIngw9g==
X-Received: by 2002:a17:906:2559:b0:94a:e89a:4fc9 with SMTP id j25-20020a170906255900b0094ae89a4fc9mr2839170ejb.73.1681396990829;
        Thu, 13 Apr 2023 07:43:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id d25-20020a05640208d900b004fa99a22c3bsm907510edz.61.2023.04.13.07.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 07:43:10 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C79B1AA7B30; Thu, 13 Apr 2023 16:43:09 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Yafang Shao <laoar.shao@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ast@kernel.org, hawk@kernel.org, john.fastabend@gmail.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>, martin.lau@linux.dev
Subject: Re: [PATCH net-next] bpf, net: Support redirecting to ifb with bpf
In-Reply-To: <968ea56a-301a-45c5-3946-497401eb95b5@iogearbox.net>
References: <20230413025350.79809-1-laoar.shao@gmail.com>
 <968ea56a-301a-45c5-3946-497401eb95b5@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 13 Apr 2023 16:43:09 +0200
Message-ID: <874jpj2682.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

>> 2). We can't redirect ingress packet to ifb with bpf
>> By trying to analyze if it is possible to redirect the ingress packet to
>> ifb with a bpf program, we find that the ifb device is not supported by
>> bpf redirect yet.
>
> You actually can: Just let BPF program return TC_ACT_UNSPEC for this
> case and then add a matchall with higher prio (so it runs after bpf)
> that contains an action with mirred egress redirect that pushes to ifb
> dev - there is no change needed.

I wasn't aware that BPF couldn't redirect directly to an IFB; any reason
why we shouldn't merge this patch in any case?

>> This patch tries to resolve it by supporting redirecting to ifb with bpf
>> program.
>> 
>> Ingress bandwidth limit is useful in some scenarios, for example, for the
>> TCP-based service, there may be lots of clients connecting it, so it is
>> not wise to limit the clients' egress. After limiting the server-side's
>> ingress, it will lower the send rate of the client by lowering the TCP
>> cwnd if the ingress bandwidth limit is reached. If we don't limit it,
>> the clients will continue sending requests at a high rate.
>
> Adding artificial queueing for the inbound traffic, aren't you worried
> about DoS'ing your node?

Just as an aside, the ingress filter -> ifb -> qdisc on the ifb
interface does work surprisingly well, and we've been using that over in
OpenWrt land for years[0]. It does have some overhead associated with it,
but I wouldn't expect it to be a source of self-DoS in itself (assuming
well-behaved TCP traffic).

-Toke

[0] https://openwrt.org/docs/guide-user/network/traffic-shaping/sqm

