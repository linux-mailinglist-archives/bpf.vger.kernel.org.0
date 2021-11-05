Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E92446534
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 15:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhKEOul (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 10:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbhKEOul (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 10:50:41 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190FBC061714
        for <bpf@vger.kernel.org>; Fri,  5 Nov 2021 07:48:01 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id v15so8289864ljc.0
        for <bpf@vger.kernel.org>; Fri, 05 Nov 2021 07:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=zfhV6Gwgf0sNTi1LiHNLJjrEkjkdv8O0IylaTB1V6Y0=;
        b=XDEkCdq9vbijnaUXZhE9vmtvMCpG1ac/W5v/wUUDSrfijdB5fVv7957sSp5zWsZZ2/
         C2K85AnqNElbJBe6g896rOCaVQ5pIYggI8IHKX0RbF6D5DGd8Lmyb3pEwWxAy6LXXgVn
         oGOp86j+3iXftmpZRb4jzb6FKWSIytairdoPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=zfhV6Gwgf0sNTi1LiHNLJjrEkjkdv8O0IylaTB1V6Y0=;
        b=1iR10jUxCOCzjhj8uAl2JhNRzFhOHQv/O7iRBcsg2zNZyQvTBIaz+1TRrVIfqa2Lwc
         M+UOdaO4VNsr1wZhDLEEM15BMx9jBWRqONjOlHkjR+UT5yzaLkzQjsJsxDpfEs+TJI+n
         CHxvWPdCTnVGBYouexa3TuKq81RnPdEa4xVoi7A+6F0r+LEZvEZCtOobLu37awkbx9Jz
         G2v8hwYvk80L7f+Y3el7TeRcH5Er+snt67tIxJrubqFjN7aIrHZdL3zSS7ggYnnW2LPr
         ZYUY0R477dXKVpQxmny5v3QkO7QiPtUW5/jQ7E20r5OCnCmDddlmM4aXFrdNxHZG1Wj7
         kvyA==
X-Gm-Message-State: AOAM532QZgVNDkFMrUvkvoxqW8jiEzFMKIbYYmiXRLxAM4pBP9KUawxd
        HpPV32Ad0Acm9+eq8gcqHX20NQ==
X-Google-Smtp-Source: ABdhPJyqGf7LHd6ltIp1FxZaIjg29uJoEhLhJOgH/6HaLKpsEWoaMg5bWUcdQFLgXGB1IwbsV0ryOw==
X-Received: by 2002:a2e:9c0b:: with SMTP id s11mr62580170lji.259.1636123679311;
        Fri, 05 Nov 2021 07:47:59 -0700 (PDT)
Received: from cloudflare.com (2a01-110f-480d-6f00-ff34-bf12-0ef2-5071.aa.ipv6.supernova.orange.pl. [2a01:110f:480d:6f00:ff34:bf12:ef2:5071])
        by smtp.gmail.com with ESMTPSA id g19sm106394ljl.27.2021.11.05.07.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 07:47:58 -0700 (PDT)
References: <20211104122304.962104-1-markpash@cloudflare.com>
 <20211104122304.962104-2-markpash@cloudflare.com>
 <32332bb4-1848-0280-9482-5189ab912b02@fb.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Yonghong Song <yhs@fb.com>,
        Mark Pashmfouroush <markpash@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>, kernel-team@cloudflare.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add ifindex to bpf_sk_lookup
In-reply-to: <32332bb4-1848-0280-9482-5189ab912b02@fb.com>
Date:   Fri, 05 Nov 2021 15:47:57 +0100
Message-ID: <87y262hd5u.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 04, 2021 at 07:06 PM CET, 'Yonghong Song' via kernel-team+notifications wrote:
> On 11/4/21 5:23 AM, Mark Pashmfouroush wrote:
>> It may be helpful to have access to the ifindex during bpf socket
>> lookup. An example may be to scope certain socket lookup logic to
>> specific interfaces, i.e. an interface may be made exempt from custom
>> lookup code.
>> Add the ifindex of the arriving connection to the bpf_sk_lookup API.
>> Signed-off-by: Mark Pashmfouroush <markpash@cloudflare.com>
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index 24b7ed2677af..0012a5176a32 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -1374,6 +1374,7 @@ struct bpf_sk_lookup_kern {
>>   		const struct in6_addr *daddr;
>>   	} v6;
>>   	struct sock	*selected_sk;
>> +	u32		ifindex;
>
> In struct __sk_buff, we have two ifindex related fields:
>
>         __u32 ingress_ifindex;
>         __u32 ifindex;
>
> Does newly-added ifindex corresponds to skb->ingress_ifindex or
> skb->ifindex? From comments:
>   > +	__u32 ifindex;		/* The arriving interface. Determined by inet_iif. */
>
> looks like it corresponds to ingress? Should be use the name
> ingress_ifindex to be consistent with __sk_buff?
>

On ingress these two (skb->skb_iif and skb->dev-ifindex) are the same,
if I read the code correctly [1].

That said, I agree that ingress_ifindex would be less ambiguous (iif ->
ingress interface, can't get that wrong).

Also, as Yonghong points out __sk_buff and xdp_md context objects
already use this identifier for the same bit of information, so it will
be less of surprise.

[1] https://elixir.bootlin.com/linux/latest/source/net/core/dev.c#L5258

[...]
