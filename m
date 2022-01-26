Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD2649C937
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 13:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241042AbiAZMCa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 07:02:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58063 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241031AbiAZMC3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 Jan 2022 07:02:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643198548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JffvNSe2BvAV1CIblV/we+uBV7wt/SYCRMsaGQKbhCY=;
        b=bVM0tDtUtVXr0Mj6dbicCiqUP4CYbhp5hp7AZ2blCjRm3ikx6G589XY0qveoKVssd6Gwz1
        WfXcbVd+JfIsbG9q/+uEmCnc/oMeytqGidHDNqHM72wcVIYMfhBbTpGEEZJc5RVpDcZ+eS
        wdEb+AdyosdBzukZWqptWBlC+8yKAI4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-0CT83-tEM0GwUtBpxETQ1A-1; Wed, 26 Jan 2022 07:02:27 -0500
X-MC-Unique: 0CT83-tEM0GwUtBpxETQ1A-1
Received: by mail-ej1-f69.google.com with SMTP id r18-20020a17090609d200b006a6e943d09eso4783977eje.20
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 04:02:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JffvNSe2BvAV1CIblV/we+uBV7wt/SYCRMsaGQKbhCY=;
        b=452YmmHA3imVUJi37bFzcsqP3DQTjB4UnW2blZObZ1p+ZRTrq5f61wqQt5Do1AA924
         buKXItF6lIHBBkVpNF++EtW+KpFQfv4iEZx1zYtkxrLyC6a1UexnlPMNB3MrIpBwd63f
         kV5QXdWkFBieCr2g5M3/sVZInknm2VWEOl0Jt2cl8Ms7BhlM88cgrmn96tuLTEeMViYt
         lxGE/Ua/ah3WQrMWDUX6kiy/A46+JqARe/AIhCxhKfE3JpWLY03ty54PL5Hx2J6Yyt+A
         F4mgb/79KLCri7wSjvmZzNo2f8k+2Y1RqUuR3jVxsnEOFiExtaKoGQbmcY/jsomvi87J
         JPuQ==
X-Gm-Message-State: AOAM5323k8BLSlmMPU+DSoJtd4VdnExPqFU8Q4FU/XnehP8pV+RD0v93
        nw3jEBqhlX3NAtUPEzzNV04kjR2mm6WtPxjJd+C52sMHEelhhRRTnxCA8R4//yAVeRKLBlfqYyj
        FtVHePwRcBVg9
X-Received: by 2002:a17:907:7208:: with SMTP id dr8mr20302097ejc.503.1643198546014;
        Wed, 26 Jan 2022 04:02:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0+dKaLOqKZ04M8CubkNiWEfd6Zntql4B7K4J5CdeX8Zg49omzBwDYV9V8DA87HIjWqq5ZZw==
X-Received: by 2002:a17:907:7208:: with SMTP id dr8mr20302068ejc.503.1643198545600;
        Wed, 26 Jan 2022 04:02:25 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id e19sm6248161ejl.225.2022.01.26.04.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 04:02:25 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 513FF1805FA; Wed, 26 Jan 2022 13:02:24 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Nikolay Aleksandrov <nikolay@nvidia.com>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@kernel.org>,
        Yoshiki Komachi <komachi.yoshiki@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        "bridge@lists.linux-foundation.org" 
        <bridge@lists.linux-foundation.org>,
        Ido Schimmel <idosch@idosch.org>
Subject: Re: [RFC bpf-next 1/2] net: bridge: add unstable
 br_fdb_find_port_from_ifindex helper
In-Reply-To: <YfEr3Soy8YuJczHk@lore-desk>
References: <cover.1643044381.git.lorenzo@kernel.org>
 <720907692575488526f06edc2cf5c8f783777d4f.1643044381.git.lorenzo@kernel.org>
 <61553c87-a3d3-07ae-8c2f-93cf0cb52263@nvidia.com>
 <CAADnVQLv=45+Symc-8Y9QuzOAG40e3XkvVxQ-ibO-HOCyJhETw@mail.gmail.com>
 <YfEr3Soy8YuJczHk@lore-desk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 26 Jan 2022 13:02:24 +0100
Message-ID: <87ee4u3dtb.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> On Mon, Jan 24, 2022 at 10:32 AM Nikolay Aleksandrov <nikolay@nvidia.com> wrote:
>> > >
>> > > +int br_fdb_find_port_from_ifindex(struct xdp_md *xdp_ctx,
>> > > +                               struct bpf_fdb_lookup *opt,
>> > > +                               u32 opt__sz)
>> > > +{
>> > > +     struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
>> > > +     struct net_bridge_port *port;
>> > > +     struct net_device *dev;
>> > > +     int ret = -ENODEV;
>> > > +
>> > > +     BUILD_BUG_ON(sizeof(struct bpf_fdb_lookup) != NF_BPF_FDB_OPTS_SZ);
>> > > +     if (!opt || opt__sz != sizeof(struct bpf_fdb_lookup))
>> > > +             return -ENODEV;
>> > > +
>> > > +     rcu_read_lock();
>> > > +
>> > > +     dev = dev_get_by_index_rcu(dev_net(ctx->rxq->dev), opt->ifindex);
>> > > +     if (!dev)
>> > > +             goto out;
>> 
>> imo that is way too much wrapping for an unstable helper.
>> The dev lookup is not cheap.
>> 
>> With all the extra checks the XDP acceleration gets reduced.
>> I think it would be better to use kprobe/fentry on bridge
>> functions that operate on fdb and replicate necessary
>> data into bpf map.
>> Then xdp prog would do a single cheap lookup from that map
>> to figure out 'port'.
>
> ack, right. This is a very interesting approach. I will investigate
> it. Thanks.

I think it would be interesting to try both, and compare their
performance. I'm a bit sceptical about Alexei's assertion that
dev_get_by_index_rcu() is that expensive: we do such a lookup in the XDP
redirect code when using the non-map bpf_redirect() helper, and I have
not been able to measure a significant performance difference between
the map and non-map variants (after we added bulking to the latter).

If looking up devices by ifindex does turn out to be too expensive,
maybe what we really need is a way to pass around 'struct net_device'
pointers to BPF helpers, so a given BPF program only has to do the
lookup once if it's calling multiple dev-based helpers? I think this
should be doable with BTF, no?

-Toke

