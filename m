Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44393A395B
	for <lists+bpf@lfdr.de>; Fri, 11 Jun 2021 03:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhFKBng (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Jun 2021 21:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhFKBnf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Jun 2021 21:43:35 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4339BC061574
        for <bpf@vger.kernel.org>; Thu, 10 Jun 2021 18:41:25 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id i8-20020a4aa1080000b0290201edd785e7so350329ool.1
        for <bpf@vger.kernel.org>; Thu, 10 Jun 2021 18:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Jqz8+eKLsVGv+svaH1hI5GsnLs2QnATYewlEmrcVDM=;
        b=NeiEavMacJopnb1Zq08QR2hYK2UYcVaEi6K+zw8c1q5oau7APpss/5l7SQKAqeYCSV
         FwK14Px588Uo3Nv8ayy80YOuxNOJlq//+YJ+pnL+QdmDX7XPosbsd1ycpkKGvPjlKB0i
         t6jrzr13+qw3ZKAkHBj5xDmVHBe3YM5JwePIMDWBotM+z7kZDyThEVAN9i6YTQoIXOuC
         w13afj8GLBmV/s7Aozn0kfU8OmnyAEIgSijXFZq6OI3x41UQH4uP7pgqpEoYiuazWnYL
         uWxfN5evJe3+Neeab2VDnOUUVXmk/QCelq27YxH64T3Y6HAVeGrFpEdSdCACIIAy5tVQ
         z18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Jqz8+eKLsVGv+svaH1hI5GsnLs2QnATYewlEmrcVDM=;
        b=EHDj7XBqlVAOVHCXX7PO0rxnFXHEG9PlEp1oWBw6WFfOzG9kBUam7VlKE4PV2f3O38
         LpZ6TZ4DABKfNaKQJo6yGs4dKszYAgzKahbv/mFRZl3zi/LSznAVmn11aEAWCcqI5CLo
         VPcyIIJU4+EjlcI0uVFKq/Rf3FPMBk7nHOj4aSEXT6lIIc8m8CgEvj3cHKelyKXJeHsD
         NraRkeO+eTWfBHoPU9fUBzwXoBKCAg/3ow/3O8n5WJUZEEwjrE9WLf15wZrmEe6f+tQJ
         IVyL37p30KL4fQWGKMhe3ZdYf4tYo3s53LtPyXAyngur1LlNpHWWVkH4Xeyc4TJzTxiL
         1WPA==
X-Gm-Message-State: AOAM531oZA4NBTVp6EcokETj3xiLthR1gtYPVIo9OQE8h24fCDseTThN
        aLUzzHEZuBlqwNpZ2ltmxVf1JWk+M/g=
X-Google-Smtp-Source: ABdhPJzEYuvy2eX0Xt77r9Bdae8ieG7r5Qk8xQpaTl6MW8wIxwvMUiOu6oO6T7TdvSqgLXf3rcrMkg==
X-Received: by 2002:a4a:a283:: with SMTP id h3mr1035567ool.90.1623375683744;
        Thu, 10 Jun 2021 18:41:23 -0700 (PDT)
Received: from Davids-MacBook-Pro.local ([8.48.134.22])
        by smtp.googlemail.com with ESMTPSA id p7sm709202otq.9.2021.06.10.18.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 18:41:22 -0700 (PDT)
Subject: Re: bpf_fib_lookup support for firewall mark
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Cc:     bpf@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>
References: <CA+FoirDxh7AhApwWVG_19j5RWT1dp23ab1h0P1nTjhhWpRC5Ow@mail.gmail.com>
 <3e6ba294-12ca-3a2f-d17c-9588ae221dda@gmail.com>
 <CA+FoirCt1TXuBpyayTnRXC2MfW-taN9Ob-3mioPojfaWvwjqqg@mail.gmail.com>
 <CA+FoirALjdwJ0=F6E4w2oNmC+fRkpwHx8AZb7mW1D=nU4_qZUQ@mail.gmail.com>
 <c2f77a3d-508f-236c-057c-6233fbc7e5d2@iogearbox.net>
 <68345713-e679-fe9f-fedd-62f76911b55a@gmail.com>
 <CA+FoirA28PANkzHE-4uHb7M0vf-V3UZ6NfjKbc_RBJ2=sKSrOQ@mail.gmail.com>
 <6248c547-ad64-04d6-fcec-374893cc1ef2@gmail.com>
 <7742f2a2-11a7-4d8f-d8c1-7787483a3935@iogearbox.net>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <64222254-eef3-f1c4-2b75-6ea1668a0ad5@gmail.com>
Date:   Thu, 10 Jun 2021 19:41:21 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7742f2a2-11a7-4d8f-d8c1-7787483a3935@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/10/21 2:58 PM, Daniel Borkmann wrote:
>> But, I do not think the vlan data should be overloaded right now. We
>> still have an open design issue around supporting vlans on ingress
>> (XDP). One option is to allow the lookup to take the vlan as an input,
>> have the the bpf helper lookup the vlan device that goes with the
>> {device index, vlan} pair and use that as the input device. If we
>> overload the vlan_TCI with fwmark that prohibits this option.
> 
> I guess it's not overly pretty, but if all things break down and there's
> no other
> unused space, wouldn't it work if we opt into the vlan as input (instead
> of mark)
> in future via flag?
> 
>>> Moreover, there are 12 extra bytes used only as output for the
>>> smac/dmac.
>>> If the above works then maybe this opens up the opportunity to
>>> incorporate
>>> even more input parameters that way?
>>
>> I think that's going to be tricky since the macs are 6-byte arrays.

This should work (whitespace damaged on paste). It preserves the vlan
for potential later use, and we have 2 more 4-byte holes. Untested, not
even compiled. Can you try it out?

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 418b9b813d65..476bc81f3d04 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5954,8 +5954,20 @@ struct bpf_fib_lookup {
        /* output */
        __be16  h_vlan_proto;
        __be16  h_vlan_TCI;
-       __u8    smac[6];     /* ETH_ALEN */
-       __u8    dmac[6];     /* ETH_ALEN */
+
+       union {
+               /* input */
+               struct {
+                       __u32 fwmark;
+                       /* 2 4-byte holes for input */
+               };
+
+               /* output: source and dest mac */
+               struct {
+                       __u8    smac[6];     /* ETH_ALEN */
+                       __u8    dmac[6];     /* ETH_ALEN */
+               };
+       };
 };

 struct bpf_redir_neigh {

diff --git a/net/core/filter.c b/net/core/filter.c
index 239de1306de9..a9b4fd2a6657 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5303,6 +5303,7 @@ static int bpf_ipv4_fib_lookup(struct net *net,
struct bpf_fib_lookup *params,
        fl4.saddr = params->ipv4_src;
        fl4.fl4_sport = params->sport;
        fl4.fl4_dport = params->dport;
+       fl4.flowi4_mark = params->fwmark;
        fl4.flowi4_multipath_hash = 0;

        if (flags & BPF_FIB_LOOKUP_DIRECT) {
@@ -5315,7 +5316,6 @@ static int bpf_ipv4_fib_lookup(struct net *net,
struct bpf_fib_lookup *params,

                err = fib_table_lookup(tb, &fl4, &res, FIB_LOOKUP_NOREF);
        } else {
-               fl4.flowi4_mark = 0;
                fl4.flowi4_secid = 0;
                fl4.flowi4_tun_key.tun_id = 0;
                fl4.flowi4_uid = sock_net_uid(net, NULL);
@@ -5429,6 +5429,7 @@ static int bpf_ipv6_fib_lookup(struct net *net,
struct bpf_fib_lookup *params,
        fl6.saddr = *src;
        fl6.fl6_sport = params->sport;
        fl6.fl6_dport = params->dport;
+       fl6.flowi6_mark = params->fwmark;

        if (flags & BPF_FIB_LOOKUP_DIRECT) {
                u32 tbid = l3mdev_fib_table_rcu(dev) ? : RT_TABLE_MAIN;
@@ -5441,7 +5442,6 @@ static int bpf_ipv6_fib_lookup(struct net *net,
struct bpf_fib_lookup *params,
                err = ipv6_stub->fib6_table_lookup(net, tb, oif, &fl6, &res,
                                                   strict);
        } else {
-               fl6.flowi6_mark = 0;
                fl6.flowi6_secid = 0;
                fl6.flowi6_tun_key.tun_id = 0;
                fl6.flowi6_uid = sock_net_uid(net, NULL);

