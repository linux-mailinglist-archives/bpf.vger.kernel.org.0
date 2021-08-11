Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108033E9339
	for <lists+bpf@lfdr.de>; Wed, 11 Aug 2021 16:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhHKOFm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Aug 2021 10:05:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60301 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231739AbhHKOFl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 11 Aug 2021 10:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628690717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u+UwXrDdUvMVeVeP5V7tq2RnSOSZajczg7aig3TAtJw=;
        b=LR7b3qyXIUivawaMJas+7EbdhEqirBTzgNvi35ZCpkr90S3Mi68sBLki6UzEMnhoRZuoNT
        K78dajXm6g1h2xeoNpLYsod9lNFAk6bm6vgN0Km1wQrZcORr4VJz+f7p2QPyNnAt7niZQt
        s64Iazc3OoyGTPuu9pyK4zk26LxDptw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-zvgFjAywNYO_Y3o8IyHiaw-1; Wed, 11 Aug 2021 10:05:16 -0400
X-MC-Unique: zvgFjAywNYO_Y3o8IyHiaw-1
Received: by mail-qv1-f69.google.com with SMTP id w10-20020a0cfc4a0000b0290335dd22451dso1341720qvp.5
        for <bpf@vger.kernel.org>; Wed, 11 Aug 2021 07:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u+UwXrDdUvMVeVeP5V7tq2RnSOSZajczg7aig3TAtJw=;
        b=hj+8Q9FXplTXYYN6JOy70ieYvH6zJq3ip+y3OTevCmwWNw+bogOvVkFofHC1rFaJip
         z5TEHgdt/kyaDo7Q283F1F52elNOw9FRgK2zl34ktLsj++wi4g7YEzRfSbofDRrLK79y
         HKeXVRaeyiWIuk86QFN5RFY9SsC3GpyAs+gwazDl9UXADQ7SUGVxl/DNcgL2XpaPR1dx
         c/15s1D9riss1fojbxCMhwS6CaAisKGab4qlt0ZR2haFv0lzvDpY9ac+C1oHAUZd4ELd
         5O23frnTyi3TVyrHK//8iR0JCPw/wQSwpdeMD6NGM9ug04tshHODdnn4TQDKmV0h+Xw3
         3eAQ==
X-Gm-Message-State: AOAM530oHRjzwiLTev3lnHtVL41ziErNwtr1DTGHSTBJTeAcNF/MqMwr
        zA2ugfNMO7nQo24X+HmsdqoJgn3/MPSOxaR0lf4ravsrqjLavNrCZRl6cP1qoQo4eUcUUG9eQEY
        r9BKRS5lF0WbG
X-Received: by 2002:a37:9643:: with SMTP id y64mr32674337qkd.213.1628690715646;
        Wed, 11 Aug 2021 07:05:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCyP6IAxayqVXnCpyOW3A+Q4cpJNidAxOrcHuQ7RfdL9iiN6zS6fZT6rLuYZQ8u7eQLyhK4g==
X-Received: by 2002:a37:9643:: with SMTP id y64mr32674294qkd.213.1628690715222;
        Wed, 11 Aug 2021 07:05:15 -0700 (PDT)
Received: from jtoppins.rdu.csb ([107.15.110.69])
        by smtp.gmail.com with ESMTPSA id 18sm12894916qkm.128.2021.08.11.07.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 07:05:14 -0700 (PDT)
Subject: Re: [PATCH bpf-next v6 1/7] net: bonding: Refactor bond_xmit_hash for
 use with xdp_buff
To:     Jussi Maki <joamaki@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, j.vosburgh@gmail.com,
        Andy Gospodarek <andy@greyhouse.net>, vfalico@gmail.com,
        Andrii Nakryiko <andrii@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
References: <20210609135537.1460244-1-joamaki@gmail.com>
 <20210731055738.16820-1-joamaki@gmail.com>
 <20210731055738.16820-2-joamaki@gmail.com>
 <2bb53e7c-0a2f-5895-3d8b-aa43fd03ff52@redhat.com>
 <CAHn8xckOsLD463JW2rc1LhjjY0FQ-aRNqSif_SJ6GT9bAH7VqQ@mail.gmail.com>
From:   Jonathan Toppins <jtoppins@redhat.com>
Message-ID: <3b0657f0-d7ef-e568-57c2-0db41acea615@redhat.com>
Date:   Wed, 11 Aug 2021 10:05:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAHn8xckOsLD463JW2rc1LhjjY0FQ-aRNqSif_SJ6GT9bAH7VqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/11/21 4:22 AM, Jussi Maki wrote:
> Hi Jonathan,
> 
> Thanks for catching this. You're right, this will NULL deref if XDP
> bonding is used with the VLAN_SRCMAC xmit policy. I think what
> happened was that a very early version restricted the xmit policies
> that were applicable, but it got dropped when this was refactored.
> I'll look into this today and will add in support (or refuse) the
> VLAN_SRCMAC xmit policy and extend the tests to cover this.

In support of some customer requests and to stop adding more and more 
hashing policies I was looking at adding a custom policy that exposes a 
bitfield so userspace can select which header items should be included 
in the hash. I was looking at a flow dissector implementation to parse 
the packet and then generate the hash from the flow data pulled. It 
looks like the outer hashing functions as they exist now, 
bond_xmit_hash() and bond_xmit_hash_xdp(), could make the correctly 
formatted call to __skb_flow_dissect(). We would then pass around the 
resultant struct flow_keys, or bonding specific one to add MAC header 
parsing support, and it appears we could avoid making the actual hashing 
functions know if they need to hash an sk_buff vs xdp_buff. What do you 
think?

-Jon

