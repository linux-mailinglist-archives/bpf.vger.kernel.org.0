Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03143560197
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 15:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbiF2NnU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jun 2022 09:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbiF2NnP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jun 2022 09:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FA9DC2A
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 06:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656510192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UW6EWWcDgP+o+MFt4vmMvtXMf9IPmqPd5CK2PWObuB8=;
        b=gTy5OSQEGk6LtnHhF81UEQN8PoM+tAObcLLrd0LCDThpU3FSy0x39BJRQTu2aO6dxCN+II
        3T9mlp/STfE397Q6Ui2i1uvJj1gZRrRG5ImgQZqU2gPhA17lRMjV+ZUCaMUB0CW9YTK4Pt
        tgXiY/qw/KwWNXIwKDn2LyLExhLw1xw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-Yww6H5svMZaYTksGmP4h0g-1; Wed, 29 Jun 2022 09:43:11 -0400
X-MC-Unique: Yww6H5svMZaYTksGmP4h0g-1
Received: by mail-ed1-f70.google.com with SMTP id x21-20020a05640226d500b00435bd7f9367so11959181edd.8
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 06:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=UW6EWWcDgP+o+MFt4vmMvtXMf9IPmqPd5CK2PWObuB8=;
        b=L37AV5g35n3glAHM7pRUYjK12vaGEYJ6R3eWZvVlq9bQ/u/mZs20AqFDpbJLnYfQXl
         DxcXbFKx66wRTQqh8jwouUOIWMXJwxCxPF4jNEtNWAj2ypoOiSjxG+lggvSPZpteEUwD
         B/fU38r7aj6Np4bbJjqlUFyEkICZxXPYJFE7E4AWRt0GO6WQAl+HQq5/aRcjNtW1vLxE
         oibUiCOGHqDhwaWiuCtI+Ds2EQV5IYAxKnnGEFwjvuKtM/iHxUNU/Sm6knm+W9AoKd37
         +x+ZgNKQ45Tvd4G1FQTsZl/fH+/lRMVJXvUKGE0xXJ2pmlEv/ySP9Pj0MPfvJNFibWAs
         hrUQ==
X-Gm-Message-State: AJIora8iRFIyO5aN0p96P22SyC4bN4pbRYAW+y6B/p3OZK8BfnxSZ+5+
        66gZZ1T6QvE+Lbo8dfJvYNBlQvgcq4TiCOvOmhkTeqfymzWh5s7osWrHpUS5J7lwi7CE4FdPBbO
        5YjjBC/z9B1fy
X-Received: by 2002:a17:906:7790:b0:722:e6cf:126 with SMTP id s16-20020a170906779000b00722e6cf0126mr3292396ejm.244.1656510188263;
        Wed, 29 Jun 2022 06:43:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vYU5mFSCUdnqHAOrvLJwONCfM6OwKiQER0S5rAaKhWqFBhKQ46eiivE/FPbenKVMLh3jLbRw==
X-Received: by 2002:a17:906:7790:b0:722:e6cf:126 with SMTP id s16-20020a170906779000b00722e6cf0126mr3292295ejm.244.1656510186810;
        Wed, 29 Jun 2022 06:43:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id y20-20020a17090629d400b00704cf66d415sm7768808eje.13.2022.06.29.06.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 06:43:05 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4C5A4477057; Wed, 29 Jun 2022 15:43:05 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Yajun Deng <yajun.deng@linux.dev>,
        Willem de Bruijn <willemb@google.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xdp-hints@xdp-project.net
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 00/52] bpf, xdp: introduce
 and use Generic Hints/metadata
In-Reply-To: <62bbedf07f44a_2181420830@john.notmuch>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <62bbedf07f44a_2181420830@john.notmuch>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 29 Jun 2022 15:43:05 +0200
Message-ID: <87iloja8ly.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John Fastabend <john.fastabend@gmail.com> writes:

> Alexander Lobakin wrote:
>> This RFC is to give the whole picture. It will most likely be split
>> onto several series, maybe even merge cycles. See the "table of
>> contents" below.
>
> Even for RFC its a bit much. Probably improve the summary
> message here as well I'm still not clear on the overall
> architecture so not sure I want to dig into patches.

+1 on this, and piggybacking on your comment to chime in on the general
architecture.

>> Now, a NIC driver, or even a SmartNIC itself, can put those params
>> there in a well-defined format. The format is fixed, but can be of
>> several different types represented by structures, which definitions
>> are available to the kernel, BPF programs and the userland.
>
> I don't think in general the format needs to be fixed.

No, that's the whole point of BTF: it's not supposed to be UAPI, we'll
use CO-RE to enable dynamic formats...

[...]

>> It is fixed due to it being almost a UAPI, and the exact format can
>> be determined by reading the last 10 bytes of metadata. They contain
>> a 2-byte magic ID to not confuse it with a non-compatible meta and
>> a 8-byte combined BTF ID + type ID: the ID of the BTF where this
>> structure is defined and the ID of that definition inside that BTF.
>> Users can obtain BTF IDs by structure types using helpers available
>> in the kernel, BPF (written by the CO-RE/verifier) and the userland
>> (libbpf -> kernel call) and then rely on those ID when reading data
>> to make sure whether they support it and what to do with it.
>> Why separate magic and ID? The idea is to make different formats
>> always contain the basic/"generic" structure embedded at the end.
>> This way we can still benefit in purely generic consumers (like
>> cpumap) while providing some "extra" data to those who support it.
>
> I don't follow this. If you have a struct in your driver name it
> something obvious, ice_xdp_metadata. If I understand things
> correctly just dump the BTF for the driver, extract the
> struct and done you can use CO-RE reads. For the 'fixed' case
> this looks easy. And I don't think you even need a patch for this.

...however as we've discussed previously, we do need a bit of
infrastructure around this. In particular, we need to embed the embed
the BTF ID into the metadata itself so BPF can do runtime disambiguation
between different formats (and add the right CO-RE primitives to make
this easy). This is for two reasons:

- The metadata might be different per-packet (e.g., PTP packets with
  timestamps interleaved with bulk data without them)

- With redirects we may end up processing packets from different devices
  in a single XDP program (in devmap or cpumap, or on a veth) so we need
  to be able to disambiguate at runtime.

So I think the part of the design that puts the BTF ID into the end of
the metadata struct is sound; however, the actual format doesn't have to
be fixed, we can use CO-RE to pick out the bits that a given BPF program
needs; we just need a convention for how drivers report which format(s)
they support. Which we should also agree on (and add core infrastructure
around) so each driver doesn't go around inventing their own
conventions.

>> The enablement of this feature is controlled on attaching/replacing
>> XDP program on an interface with two new parameters: that combined
>> BTF+type ID and metadata threshold.
>> The threshold specifies the minimum frame size which a driver (or
>> NIC) should start composing metadata from. It is introduced instead
>> of just false/true flag due to that often it's not worth it to spend
>> cycles to fetch all that data for such small frames: let's say, it
>> can be even faster to just calculate checksums for them on CPU
>> rather than touch non-coherent DMA zone. Simple XDP_DROP case loses
>> 15 Mpps on 64 byte frames with enabled metadata, threshold can help
>> mitigate that.
>
> I would put this in the bonus category. Can you do the simple thing
> above without these extra bits and then add them later. Just
> pick some overly conservative threshold to start with.

Yeah, I'd agree this kind of configuration is something that can be
added later, and also it's sort of orthogonal to the consumption of the
metadata itself.

Also, tying this configuration into the loading of an XDP program is a
terrible interface: these are hardware configuration options, let's just
put them into ethtool or 'ip link' like any other piece of device
configuration.

>> The RFC can be divided into 8 parts:
>
> I'm missing something why not do the simplest bit of work and
> get this running in ice with a few smallish driver updates
> so we can all see it. No need for so many patches.

Agreed. This incremental approach is basically what Jesper's
simultaneous series makes a start on, AFAICT? Would be nice if y'all
could converge the efforts :)

[...]

> I really think your asking questions that are two or three
> jumps away. Why not do the simplest bit first and kick
> the driver with an on/off switch into this mode. But
> I don't understand this cpumap use case so maybe explain
> that first.
>
> And sorry didn't even look at your 50+ patches. Figure lets
> get agreement on the goal first.

+1 on both of these :)

-Toke

