Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FC763B4A9
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 23:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbiK1WMp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 17:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbiK1WMj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 17:12:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0663430561
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 14:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669673501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5BMPgwHcrrlbhB+DA3tYoZ2wLQmTOscwvY24xCKdS00=;
        b=ha5kQxJucjdGfO5mZBGDcoQCk2onMQG0ivwOAHShd0yCPXNs8arImjWnM6vKbgXZQnYo1V
        AK+2tA9WKk3RofdqQkj2H9HMTN+kPkz4S5LXNiGXg6qAcOVe9U1RERJf0LY73BjIuf5w1U
        OQubUYl+jPZrCXNWlbDXWbJjTLDGPiU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-615-_dJcXDgLO9OWyzqNFeiGJA-1; Mon, 28 Nov 2022 17:11:39 -0500
X-MC-Unique: _dJcXDgLO9OWyzqNFeiGJA-1
Received: by mail-ej1-f72.google.com with SMTP id xj11-20020a170906db0b00b0077b6ecb23fcso5158169ejb.5
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 14:11:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5BMPgwHcrrlbhB+DA3tYoZ2wLQmTOscwvY24xCKdS00=;
        b=ABhoeM3KCQvSWhKmQsgyYdC3EQIxV9kmM0ZYTqkS2e8RUh+EvwhEDjZyjrlAuLDYxw
         1NbM4xqgDuDLuGbuB1OOsEdyfvwu6CgQpLC4hLgUVACBy+Eqc7lts4Tl7xL9pLqiqi/9
         myLqafgai0BxqweVvCRFQuCsvLx3HbhpmuJRyjALe+LgeNUzNETH5vXAXoa45EdMCvzs
         UES+nzXbXxo41pFkfad8O/BpFW7AmJci7dIcwsixI8T2OtgSdSgH48K2CQkkuBj0bE4p
         S4WirEj6oJYXdo8XFVBFXjkQsH6GbEBREhIKv+S6y7zlegUEs/QL9uoUzWA4XRnLmcSI
         K3Uw==
X-Gm-Message-State: ANoB5pn2xd9NCE4TiNzWZQkVRIpcOQ5Q61tYHXMS3IDmvYj7h3soHH/z
        yjD669BhBiisXFHkqkHtdUZ/IYaILbgjrQifFL1rlu3fV0hMLJyv+DHE87sL+9ScQWSMbmqifno
        F9yCxVNtucI5H
X-Received: by 2002:a05:6402:1814:b0:46a:b1ba:22b8 with SMTP id g20-20020a056402181400b0046ab1ba22b8mr17295927edy.316.1669673498389;
        Mon, 28 Nov 2022 14:11:38 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7st7yCH/4V5YU/vN37QSzfbku3pyjeb6Q1i19qaft96cPj12mRMZj1zEN/rQhzerrf48Hkow==
X-Received: by 2002:a05:6402:1814:b0:46a:b1ba:22b8 with SMTP id g20-20020a056402181400b0046ab1ba22b8mr17295888edy.316.1669673498075;
        Mon, 28 Nov 2022 14:11:38 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id l17-20020a056402125100b00463c367024bsm5474590edw.63.2022.11.28.14.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 14:11:37 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id ECC627EBE9E; Mon, 28 Nov 2022 23:11:36 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, Tariq Toukan <tariqt@nvidia.com>,
        David Ahern <dsahern@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Subject: Re: [xdp-hints] Re: [PATCH bpf-next v2 6/8] mlx4: Introduce
 mlx4_xdp_buff wrapper for xdp_buff
In-Reply-To: <CAKH8qBvbYuCq-iiXnMw1QxFbfLFhorpF1+GGqU1yVzX2LhoUzQ@mail.gmail.com>
References: <20221121182552.2152891-1-sdf@google.com>
 <20221121182552.2152891-7-sdf@google.com> <874jupviyc.fsf@toke.dk>
 <CAKH8qBuF_1UoUPzh_X6FMrJ61zCNDroqSuc-Pp2uH7Q4azmN8Q@mail.gmail.com>
 <20221123111431.7b54668e@kernel.org> <Y3557Ecr80Y9ZD2z@google.com>
 <871qptuyie.fsf@toke.dk> <20221123174746.418920e5@kernel.org>
 <87edts2z8n.fsf@toke.dk> <Y3+K7dJLFX7gRQp+@boxer> <Y3+XtkkIh0o++Dgr@boxer>
 <874jun3m58.fsf@toke.dk>
 <CAKH8qBvbYuCq-iiXnMw1QxFbfLFhorpF1+GGqU1yVzX2LhoUzQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 28 Nov 2022 23:11:36 +0100
Message-ID: <871qpm20h3.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stanislav Fomichev <sdf@google.com> writes:

>> >> Why can't you simply have a pointer to xdp_buff in driver specific
>> >> xdp_buff container which would point to xdp_buff that is stack based (or
>> >> whatever else memory that will back it up - I am about to push a change
>> >> that makes ice driver embed xdp_buff within a struct that represents Rx
>> >> ring) for XDP path and for ZC the pointer to xdp_buff that you get from
>> >> xsk_buff_pool ? This would satisfy both sides I believe and would let us
>> >> keep the same container struct.
>> >>
>> >> struct mlx4_xdp_buff {
>> >>      struct xdp_buff *xdp;
>> >>      struct mlx4_cqe *cqe;
>> >>      struct mlx4_en_dev *mdev;
>> >>      struct mlx4_en_rx_ring *ring;
>> >>      struct net_device *dev;
>> >> };
>> >
>> > Nah this won't work from kfunc POV, probably no way to retrieve the
>> > mlx4_xdp_buff based on xdp_buff ptr that needs to be used as an arg.
>> >
>> > Sorry I'll think more about it, in the meantime let's hear more voices
>> > whether we should keep Stan's original approach + modify xdp_buff_xsk or
>> > go with Toke's proposal.
>>
>> OK, so I played around with the mlx5 code a bit more, and I think the
>> "wrapping struct + cb area" can be made to work without too many ugly
>> casts; I'll send an updated version of the mlx5 patches with this
>> incorporated tomorrow, after I've run some tests...
>
> I'll probably send a v3 sometime tomorrow (PST), so maybe wait for me
> to make sure we are working on the same base?
> Or LMK if you prefer to do it differently..

OK, I'll send you my mlx5 patches off-list so you can just incorporate
those. Got stuck on some annoying build issues for the perf testing, so
will defer that until your next version, then :)

-Toke

