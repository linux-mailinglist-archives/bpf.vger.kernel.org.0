Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F020265F66D
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 23:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbjAEWIy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 17:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbjAEWIh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 17:08:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042A567BE4
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 14:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672956470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3YOSltnvGCgHoui8rGSPPtll0eWrr6bzdIvNenAKi10=;
        b=ZBiFP3AwMhGkdLLonKTdwzXfMFw/AF5sYh/q6eHpbUNIyg/bXry6+mWe1vRyHDlmB+NuHX
        DyMtAJWP1MZKCoGr+bTgP7SH/rGJnltfyatpk8+An8Nos6zqlPOCXm9AZIOQab3pEgDB6K
        UOWP0el8EhNuuaVLH+s7n/7Vkz/kmlY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-455-WL-zSu7VMsuhRxrpr_3sHA-1; Thu, 05 Jan 2023 17:07:49 -0500
X-MC-Unique: WL-zSu7VMsuhRxrpr_3sHA-1
Received: by mail-ed1-f70.google.com with SMTP id w3-20020a056402268300b00487e0d9b53fso15363473edd.10
        for <bpf@vger.kernel.org>; Thu, 05 Jan 2023 14:07:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YOSltnvGCgHoui8rGSPPtll0eWrr6bzdIvNenAKi10=;
        b=qX5R/xtEzUM3vDMelBmj813e5XpD7I/f/0KgCv3uCRS5Cf9X31LECCoR+Tf24wqYxX
         DG7p90lOUpk+xYRDbKyl0nQ0Dyv4Ne9bUH3IcZHm1yjmpQyZ1SrsP7Qitox0RemfMXkK
         S3XwGpdP2Bhd8weBKQmSquWRGxxclsY8CDXsrhFsl/OqiY8MuYjB0GTvy7RyIcCBANqo
         z04XoPfdbqBG2Y2enugxO5HZmWOlQ9Zda8nZuJfHMWLMOCD59o6wFWiIKKRN7JtEw4SN
         357t+CkwheIpYIv/2ILAbdBabD8iGPoPbQtWBjUIIG09fnLZH0lz8Q4DaNsVFgbyZM/k
         hWNA==
X-Gm-Message-State: AFqh2kqQHl9t82XYykqgsnU7mY7UDZdH3tbY1uOQ+rqYzrkqliqux7JS
        ryrK8UcO52W4bzYbkpG1zMZaIIA27i5FjXBkrbpk0uGp+sqSupZgXAcTP+uHnb4FFZ6bOWlx82Y
        7YqLUQllTRsbl
X-Received: by 2002:a17:907:d311:b0:829:5e3f:3c92 with SMTP id vg17-20020a170907d31100b008295e3f3c92mr62084512ejc.73.1672956466510;
        Thu, 05 Jan 2023 14:07:46 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuExOLlObe9DFxMUemSRSpluUWYv8k07Rq8NnwtmWi4jUGLJHA/M15nW117Z6A+tZB0ODTH2w==
X-Received: by 2002:a17:907:d311:b0:829:5e3f:3c92 with SMTP id vg17-20020a170907d31100b008295e3f3c92mr62084358ejc.73.1672956464203;
        Thu, 05 Jan 2023 14:07:44 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id z27-20020a1709063a1b00b007aea1dc1840sm16997455eje.111.2023.01.05.14.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 14:07:43 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D08AA8D9F2E; Thu,  5 Jan 2023 23:07:42 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc:     Tariq Toukan <ttoukan.linux@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Andy Gospodarek <andrew.gospodarek@broadcom.com>,
        ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        hawk@kernel.org, john.fastabend@gmail.com, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        kpsingh@kernel.org, lorenzo.bianconi@redhat.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>, gal@nvidia.com,
        Saeed Mahameed <saeedm@nvidia.com>, tariqt@nvidia.com
Subject: Re: [PATCH net-next v2] samples/bpf: fixup some tools to be able to
 support xdp multibuffer
In-Reply-To: <Y7cBfE7GpX04EI97@C02YVCJELVCG.dhcp.broadcom.net>
References: <20220621175402.35327-1-gospo@broadcom.com>
 <40fd78fc-2bb1-8eed-0b64-55cb3db71664@gmail.com> <87k0234pd6.fsf@toke.dk>
 <20230103172153.58f231ba@kernel.org> <Y7U8aAhdE3TuhtxH@lore-desk>
 <87bkne32ly.fsf@toke.dk> <a12de9d9-c022-3b57-0a15-e22cdae210fa@gmail.com>
 <871qo90yxr.fsf@toke.dk> <Y7cBfE7GpX04EI97@C02YVCJELVCG.dhcp.broadcom.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 05 Jan 2023 23:07:42 +0100
Message-ID: <87v8lkzlch.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andy Gospodarek <andrew.gospodarek@broadcom.com> writes:

> On Thu, Jan 05, 2023 at 04:43:28PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Tariq Toukan <ttoukan.linux@gmail.com> writes:
>>=20
>> > On 04/01/2023 14:28, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> >>=20
>> >>>> On Tue, 03 Jan 2023 16:19:49 +0100 Toke H=C3=B8iland-J=C3=B8rgensen=
 wrote:
>> >>>>> Hmm, good question! I don't think we've ever explicitly documented=
 any
>> >>>>> assumptions one way or the other. My own mental model has certainly
>> >>>>> always assumed the first frag would continue to be the same size a=
s in
>> >>>>> non-multi-buf packets.
>> >>>>
>> >>>> Interesting! :) My mental model was closer to GRO by frags
>> >>>> so the linear part would have no data, just headers.
>> >>>
>> >>> That is assumption as well.
>> >>=20
>> >> Right, okay, so how many headers? Only Ethernet, or all the way up to
>> >> L4 (TCP/UDP)?
>> >>=20
>> >> I do seem to recall a discussion around the header/data split for TCP
>> >> specifically, but I think I mentally put that down as "something peop=
le
>> >> may way to do at some point in the future", which is why it hasn't ma=
de
>> >> it into my own mental model (yet?) :)
>> >>=20
>> >> -Toke
>> >>=20
>> >
>> > I don't think that all the different GRO layers assume having their=20
>> > headers/data in the linear part. IMO they will just perform better if=
=20
>> > these parts are already there. Otherwise, the GRO flow manages, and=20
>> > pulls the needed amount into the linear part.
>> > As examples, see calls to gro_pull_from_frag0 in net/core/gro.c, and t=
he=20
>> > call to pskb_may_pull() from skb_gro_header_slow().
>> >
>> > This resembles the bpf_xdp_load_bytes() API used here in the xdp prog.
>>=20
>> Right, but that is kernel code; what we end up doing with the API here
>> affects how many programs need to make significant changes to work with
>> multibuf, and how many can just set the frags flag and continue working.
>> Which also has a performance impact, see below.
>>=20
>> > The context of my questions is that I'm looking for the right memory=20
>> > scheme for adding xdp-mb support to mlx5e striding RQ.
>> > In striding RQ, the RX buffer consists of "strides" of a fixed size se=
t=20
>> > by pthe driver. An incoming packet is written to the buffer starting f=
rom=20
>> > the beginning of the next available stride, consuming as much strides =
as=20
>> > needed.
>> >
>> > Due to the need for headroom and tailroom, there's no easy way of=20
>> > building the xdp_buf in place (around the packet), so it should go to =
a=20
>> > side buffer.
>> >
>> > By using 0-length linear part in a side buffer, I can address two=20
>> > challenging issues: (1) save the in-driver headers memcpy (copy might=
=20
>> > still exist in the xdp program though), and (2) conform to the=20
>> > "fragments of the same size" requirement/assumption in xdp-mb.=20
>> > Otherwise, if we pull from frag[0] into the linear part, frag[0] becom=
es=20
>> > smaller than the next fragments.
>>=20
>> Right, I see.
>>=20
>> So my main concern would be that if we "allow" this, the only way to
>> write an interoperable XDP program will be to use bpf_xdp_load_bytes()
>> for every packet access. Which will be slower than DPA, so we may end up
>> inadvertently slowing down all of the XDP ecosystem, because no one is
>> going to bother with writing two versions of their programs. Whereas if
>> you can rely on packet headers always being in the linear part, you can
>> write a lot of the "look at headers and make a decision" type programs
>> using just DPA, and they'll work for multibuf as well.
>
> The question I would have is what is really the 'slow down' for
> bpf_xdp_load_bytes() vs DPA?  I know you and Jesper can tell me how many
> instructions each use. :)

I can try running some benchmarks to compare the two, sure!

-Toke

