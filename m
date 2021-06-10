Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6672B3A3391
	for <lists+bpf@lfdr.de>; Thu, 10 Jun 2021 20:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhFJSz4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Jun 2021 14:55:56 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:40844 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhFJSz4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Jun 2021 14:55:56 -0400
Received: by mail-ot1-f54.google.com with SMTP id l15-20020a05683016cfb02903fca0eacd15so690348otr.7
        for <bpf@vger.kernel.org>; Thu, 10 Jun 2021 11:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z/y4ezM2Lnp9NTepfzVyGLj9aNGUTw9YHCVVUUGW7t8=;
        b=cqyWXrahzJdhvSJjlfVQbwA8pusKkdRkdcEv/FSRPvL4FMwSzvPTTq8jQQqPwL8/dB
         Zw2YWjOnLaSOfNjrTXeZIhX/qcI2x7pvAak/B+LdBZBTicn+MIXTD8tDaf6/m3UMYOZX
         6NDbJoha4aZTe0GG2G6JesAVmZ8wA/ikSa2v36Z6qQb4qWq2U4lXq/a+eaozcSyFZFkU
         F/BkfMB/621sER6gDrTTX7MmO7o8w1ilpQNwSKE5PHyO8d77cmxAOR4KUAKXeeZSiYaK
         4peHyg5qd3cv/uP+nocV7vvdj+gxIJaIN3NZ59c36GvvCrh8GBsNaxs9W3CPHdlOTmFl
         e+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z/y4ezM2Lnp9NTepfzVyGLj9aNGUTw9YHCVVUUGW7t8=;
        b=m7dxin02OD+RDRMkcAYFzIFI2KMbj6fB+3afErqJKDP6zzTk5kzyuF/aoDqH3eN83x
         olaDdGyHZxIQW1IfNjLOVPLU0RsOyjhtzSiR2G6BilMREmQ0IDdzq82dcb8IwBwV6GzO
         cttudjgHoRvlyrJeoZVIZOwSt82yLDt3iV3nETp8NY0eYOQpKGk4510JAVTpycrv8bpW
         D2eU5UTsqdh6sc+ftb5CZbU0T0Ba6XzTCA389Rw3EZlxv4eHHq+ti8v7N7R1r47WZ7gu
         svSgERMsiTXTKbF+/Zxq8TQhLG0VvSp2sDg7a6u+F2XYmccTGkOfri4hmo22LCs4du+M
         6fxw==
X-Gm-Message-State: AOAM533QUETmpcMsJFJ5aEGULJLVfluh20vlN49NxWQiUqGO6zvrQnKl
        TC8UAI7jdagmyfuGyoyq/n0=
X-Google-Smtp-Source: ABdhPJzsL7cSAgGPHSbW8iu/dAinpT2Fr/Eeq2j5+F2P8kzt/lT579dqwNOkll10Lq9WCLHZmukuMA==
X-Received: by 2002:a05:6830:3082:: with SMTP id f2mr3608353ots.300.1623351163586;
        Thu, 10 Jun 2021 11:52:43 -0700 (PDT)
Received: from Davids-MacBook-Pro.local ([8.48.134.22])
        by smtp.googlemail.com with ESMTPSA id m66sm716351oia.28.2021.06.10.11.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 11:52:43 -0700 (PDT)
Subject: Re: bpf_fib_lookup support for firewall mark
To:     Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>
References: <CA+FoirDxh7AhApwWVG_19j5RWT1dp23ab1h0P1nTjhhWpRC5Ow@mail.gmail.com>
 <3e6ba294-12ca-3a2f-d17c-9588ae221dda@gmail.com>
 <CA+FoirCt1TXuBpyayTnRXC2MfW-taN9Ob-3mioPojfaWvwjqqg@mail.gmail.com>
 <CA+FoirALjdwJ0=F6E4w2oNmC+fRkpwHx8AZb7mW1D=nU4_qZUQ@mail.gmail.com>
 <c2f77a3d-508f-236c-057c-6233fbc7e5d2@iogearbox.net>
 <68345713-e679-fe9f-fedd-62f76911b55a@gmail.com>
 <CA+FoirA28PANkzHE-4uHb7M0vf-V3UZ6NfjKbc_RBJ2=sKSrOQ@mail.gmail.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <6248c547-ad64-04d6-fcec-374893cc1ef2@gmail.com>
Date:   Thu, 10 Jun 2021 12:52:42 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CA+FoirA28PANkzHE-4uHb7M0vf-V3UZ6NfjKbc_RBJ2=sKSrOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/10/21 11:41 AM, Rumen Telbizov wrote:
>> that's the key point on performance - crossing a cacheline. I do not
>> have performance data at hand, but it is a substantial hit. That is why
>> the struct is so overloaded (and complicated for a uapi) with the input
>> vs output setting.
> 
> Makes perfect sense now. Thanks for clarifying David and Daniel.
> 
>> Presumably you are parsing the packet to id a flow to find the mark that
>> should be used with the FIB lookup. correct?
> 
> Let me briefly present my high-level use case here to give more colour.
> What I am building is an overlay network based on geneve. I have multiple
> sites, each of which is going to be represented by a separate routing table.
> The selection of the destination site (routing table) is based on firewall marks

To show my bias here - VRF is better than firewall marks for selecting
routing tables. :-)


> and the original packet is preserved intact, encapsulated in geneve. I have a
> TC/eBPF program running on the geneve interface which has to query the
> appropriate routing table based on the firewall mark and use the
> returned next hop
> as the tunnel key in the skb. Also worth mentioning is that those routing tables
> contain multiple (default) routes as I use ECMP to balance traffic/provide HA
> between sites,

thanks for explaining the use case

> 
>>> That said, given h_vlan_proto/h_vlan_TCI are both output parameters,
>>> maybe we could just union the two fields with a __u32 mark extension
>>> that we then transfer into the flowi{4,6}?
>>
>> That is one option.
>>
>> I would go for a union on sport and/or dport. It is a fair tradeoff to
>> request users to pick one - policy routing based on L4 ports or fwmark.
>> A bit harder to do with a straight up union at this point, but we could
>> also limit the supported fwmark to 16-bits. Hard choices have to be made.
> 
> A couple of comments on those two options: if the union is between the ports
> and the mark then a user of the function would have to choose between
> src+dst port or the mark in lookup, correct? If so wouldn't that
> result in a loss
> of the ability to use multipathing - since the hashing would be static? In my
> case that would certainly be another significant drawback.

yes, good point.

> 
> Having said that, what Daniel suggests looks very interesting to me.
> If I understand
> it correctly there are 32 bits in h_vlan_proto+h_vlan_TCI that are used only for
> output today so if they are merged in a union with a 32 bit mark then we'd stay
> at 64B structure and we can pass a full 32 bit mark.
> 
> So something like this?
> union {
>     /* input */
>     __u32 mark;
> 
>     /* output */
>     __be16 h_vlan_proto;
>     __be16 h_vlan_TCI;
> }

I think more like this:

	union {
		/* input: fwmark to use in lookup */
		__u32 fwmark;

		/* output: vlan information if egress is on a vlan */
		struct {
			__be16  h_vlan_proto;
			__be16  h_vlan_TCI;
		};
	};

But, I do not think the vlan data should be overloaded right now. We
still have an open design issue around supporting vlans on ingress
(XDP). One option is to allow the lookup to take the vlan as an input,
have the the bpf helper lookup the vlan device that goes with the
{device index, vlan} pair and use that as the input device. If we
overload the vlan_TCI with fwmark that prohibits this option.

> 
> Moreover, there are 12 extra bytes used only as output for the smac/dmac.
> If the above works then maybe this opens up the opportunity to incorporate
> even more input parameters that way?
> 

I think that's going to be tricky since the macs are 6-byte arrays.

