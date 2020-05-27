Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B1C1E3EDE
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 12:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725294AbgE0KWH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 May 2020 06:22:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59741 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726964AbgE0KWC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 May 2020 06:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590574920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DGTsXmZBOnXWALLJ93Bh3zg3e2amhZp5+fELSnd0gNQ=;
        b=JjdRdyhPra2acMbQf4NN6HZOajqMjaLU9J70vX6wSl+dvH3Xl/Ng3T3UI38Qv38QcyeqSK
        Gsc+2tHDZ+HVG/Q3IEHFYEOEiYjCmVQECC0rWgrB2/h7eTR6z/IdDBCctMOXp0Nxu4EXzu
        28LCaVcrPFwk9biJBJHjDd3oHbdujEg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-cQnEWK-gOW-eJUgf24e9ew-1; Wed, 27 May 2020 06:21:57 -0400
X-MC-Unique: cQnEWK-gOW-eJUgf24e9ew-1
Received: by mail-ej1-f72.google.com with SMTP id ng1so8651304ejb.22
        for <bpf@vger.kernel.org>; Wed, 27 May 2020 03:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DGTsXmZBOnXWALLJ93Bh3zg3e2amhZp5+fELSnd0gNQ=;
        b=RUwxoh93ahIfWVq7smX1h4BFGVddrTMcqPrkt1FjGwABODXIknxXlIjCZ9X/xC9YyW
         uonfE1HS3Vw6tfujhxQEPfPoCoNY2Mjw8cfVB9X7Psn6QDdnzFbc1re8tMYNybqEudOc
         skbFgytYV4rwB2zLOzKKXJbr0EEy+tOQF326656KB5fjTXCbiUA9zAUQ0RV+3H6gfzFm
         xijdAR6ddQJ+eVqlMJXgPM16PUl6J9Di6dOBQ0WJHw62d+JK44zpk2TliD4ytRWQ6XVO
         k+AZ4nT2B0+Kl9EVDz5ryD87B7gB3HsZyfRbhfH7C7DEYeTuqobnyw4jUGilno6lDQ21
         Heaw==
X-Gm-Message-State: AOAM533iZCEj/mXiBhacvzVGQgXg9yhAKYZkG7FLgGPY9prcMZ0AA2VV
        vZNTr/tSE9k26BldLNqoWfAN9/vKRCH9nChXpQMRdLGa6KgPxSbADuJePwFgKU4cUyb837Xq16P
        xS2yKBytWjbsk
X-Received: by 2002:a17:906:5210:: with SMTP id g16mr5394435ejm.197.1590574915989;
        Wed, 27 May 2020 03:21:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2IDOYIhlplTt0p7rwOBXYSp12/k03N749FhDrM21+a4R4xMIePpSIW5mE4yARFTWNcOPBjQ==
X-Received: by 2002:a17:906:5210:: with SMTP id g16mr5394407ejm.197.1590574915752;
        Wed, 27 May 2020 03:21:55 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id p25sm1923931eds.76.2020.05.27.03.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 03:21:54 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 27BEA1804EB; Wed, 27 May 2020 12:21:54 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Hangbin Liu <liuhangbin@gmail.com>, bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Jiri Benc <jbenc@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [PATCHv4 bpf-next 0/2] xdp: add dev map multicast support
In-Reply-To: <20200526140539.4103528-1-liuhangbin@gmail.com>
References: <20200415085437.23028-1-liuhangbin@gmail.com> <20200526140539.4103528-1-liuhangbin@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 27 May 2020 12:21:54 +0200
Message-ID: <87zh9t1xvh.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hangbin Liu <liuhangbin@gmail.com> writes:

> Hi all,
>
> This patchset is for xdp multicast support, which has been discussed
> before[0]. The goal is to be able to implement an OVS-like data plane in
> XDP, i.e., a software switch that can forward XDP frames to multiple
> ports.
>
> To achieve this, an application needs to specify a group of interfaces
> to forward a packet to. It is also common to want to exclude one or more
> physical interfaces from the forwarding operation - e.g., to forward a
> packet to all interfaces in the multicast group except the interface it
> arrived on. While this could be done simply by adding more groups, this
> quickly leads to a combinatorial explosion in the number of groups an
> application has to maintain.
>
> To avoid the combinatorial explosion, we propose to include the ability
> to specify an "exclude group" as part of the forwarding operation. This
> needs to be a group (instead of just a single port index), because a
> physical interface can be part of a logical grouping, such as a bond
> device.
>
> Thus, the logical forwarding operation becomes a "set difference"
> operation, i.e. "forward to all ports in group A that are not also in
> group B". This series implements such an operation using device maps to
> represent the groups. This means that the XDP program specifies two
> device maps, one containing the list of netdevs to redirect to, and the
> other containing the exclude list.
>
> To achieve this, I re-implement a new helper bpf_redirect_map_multi()
> to accept two maps, the forwarding map and exclude map. If user
> don't want to use exclude map and just want simply stop redirecting back
> to ingress device, they can use flag BPF_F_EXCLUDE_INGRESS.
>
> The example in patch 2 is functional, but not a lot of effort
> has been made on performance optimisation. I did a simple test(pkt size 64)
> with pktgen. Here is the test result with BPF_MAP_TYPE_DEVMAP_HASH
> arrays:
>
> bpf_redirect_map() with 1 ingress, 1 egress:
> generic path: ~1600k pps
> native path: ~980k pps
>
> bpf_redirect_map_multi() with 1 ingress, 3 egress:
> generic path: ~600k pps
> native path: ~480k pps
>
> bpf_redirect_map_multi() with 1 ingress, 9 egress:
> generic path: ~125k pps
> native path: ~100k pps
>
> The bpf_redirect_map_multi() is slower than bpf_redirect_map() as we loop
> the arrays and do clone skb/xdpf. The native path is slower than generic
> path as we send skbs by pktgen. So the result looks reasonable.

How are you running these tests? Still on virtual devices? We really
need results from a physical setup in native mode to assess the impact
on the native-XDP fast path. The numbers above don't tell much in this
regard. I'd also like to see a before/after patch for straight
bpf_redirect_map(), since you're messing with the fast path, and we want
to make sure it's not causing a performance regression for regular
redirect.

Finally, since the overhead seems to be quite substantial: A comparison
with a regular network stack bridge might make sense? After all we also
want to make sure it's a performance win over that :)

-Toke

