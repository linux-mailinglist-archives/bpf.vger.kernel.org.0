Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE526483FB
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 15:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiLIOoD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 09:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiLIOnr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 09:43:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D462EF5F
        for <bpf@vger.kernel.org>; Fri,  9 Dec 2022 06:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670596971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3tx0av2joJCHZ+LPD9LeNR/VWtTnFN1Ae73a7ouYRGg=;
        b=cTeb2HNRA6Sw3J5M/vcDyjq8Iv303wXow60dgmt5ej9bHNpehLb2bMtB6qqfSzhX5vg8PO
        0HBlvg3L3X1HbWzojHuLXv+yjTHvz0vvICF37zfjL86Tb5GQEuE8uOqSSLvJkI3FZrGc22
        Us2MyHn2TQP6no/fKhTMhavoQTTCNKk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-235-TIOvgy_wMwydZMLiuBf2zg-1; Fri, 09 Dec 2022 09:42:43 -0500
X-MC-Unique: TIOvgy_wMwydZMLiuBf2zg-1
Received: by mail-ej1-f69.google.com with SMTP id oz34-20020a1709077da200b007adc8d68e90so3214425ejc.11
        for <bpf@vger.kernel.org>; Fri, 09 Dec 2022 06:42:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tx0av2joJCHZ+LPD9LeNR/VWtTnFN1Ae73a7ouYRGg=;
        b=rnXHlL/dWmNVD7JFqMAfEdBBsKKyRd5zO3mis8HvnGfvT3s7jE20UdzmOrLBDnNIhL
         +id8ffZN1QmAgDayVzsmu5AYaqQYV5C9D9N/O9mgCCqvzVhX3hdqZ5aoB8IwC/RiXHZE
         xcE/UgxskTb9+Q+hcRzW3FpPE90mnFt0uStJp088XsiLbGQwC4iLjQGqcaLz/95MHhbM
         5IQg7hXT6a1CYJx3P9y2Hmech4WJV2zigbywKbQ85IcsHHSCJq4Encp2aLq//INk/29p
         ppWI8t6334w2wSWb0tmU2K86lRTcpeZMGjdIc+CY+EQAoztzSVbhCL19S9+M6DE0gQ0/
         il/g==
X-Gm-Message-State: ANoB5pmfIOUgIe0LUfY6v+FrX/72feyJzLGzGWZvJtFyxpyD9DIkuxbI
        7ICap37PGtXX2PIRmufqe9Fdecq+7N7OpkmmH9GDe0JLfKf3buexDhl+qlJF2dlgDY1ZJFC9B9Z
        FFW0PUY1jO6jw
X-Received: by 2002:aa7:cb19:0:b0:469:65a4:9127 with SMTP id s25-20020aa7cb19000000b0046965a49127mr4910350edt.17.1670596960687;
        Fri, 09 Dec 2022 06:42:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf45v3MaiR4jZc44ncRHidw/bGHa3QmIHsq68jVMvMjmqQp3xJXs+IGjMS9bS4H1EHbYZ8JA2w==
X-Received: by 2002:aa7:cb19:0:b0:469:65a4:9127 with SMTP id s25-20020aa7cb19000000b0046965a49127mr4910335edt.17.1670596960290;
        Fri, 09 Dec 2022 06:42:40 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id i9-20020a056402054900b00463c5c32c6esm709791edx.89.2022.12.09.06.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:42:38 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 28F2182EB3C; Fri,  9 Dec 2022 15:42:37 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        Network Development <netdev@vger.kernel.org>
Subject: Re: [xdp-hints] Re: [PATCH bpf-next v3 11/12] mlx5: Support RX XDP
 metadata
In-Reply-To: <CAKH8qBswBu7QAWySWOYK4X41mwpdBj0z=6A9WBHjVYQFq9Pzjw@mail.gmail.com>
References: <20221206024554.3826186-1-sdf@google.com>
 <20221206024554.3826186-12-sdf@google.com> <875yellcx6.fsf@toke.dk>
 <CAKH8qBv7nWdknuf3ap_ekpAhMgvtmoJhZ3-HRuL8Wv70SBWMSQ@mail.gmail.com>
 <87359pl9zy.fsf@toke.dk>
 <CAADnVQ+=71Y+ypQTOgFTJWY7w3YOUdY39is4vpo3aou11=eMmw@mail.gmail.com>
 <87tu25ju77.fsf@toke.dk>
 <CAADnVQ+MyE280Q-7iw2Y-P6qGs4xcDML-tUrXEv_EQTmeESVaQ@mail.gmail.com>
 <87o7sdjt20.fsf@toke.dk>
 <CAKH8qBswBu7QAWySWOYK4X41mwpdBj0z=6A9WBHjVYQFq9Pzjw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 09 Dec 2022 15:42:37 +0100
Message-ID: <87cz8sk59e.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stanislav Fomichev <sdf@google.com> writes:

> On Thu, Dec 8, 2022 at 4:54 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>> > On Thu, Dec 8, 2022 at 4:29 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
redhat.com> wrote:
>> >>
>> >> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>> >>
>> >> > On Thu, Dec 8, 2022 at 4:02 PM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>> >> >>
>> >> >> Stanislav Fomichev <sdf@google.com> writes:
>> >> >>
>> >> >> > On Thu, Dec 8, 2022 at 2:59 PM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>> >> >> >>
>> >> >> >> Stanislav Fomichev <sdf@google.com> writes:
>> >> >> >>
>> >> >> >> > From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> >> >> >> >
>> >> >> >> > Support RX hash and timestamp metadata kfuncs. We need to pas=
s in the cqe
>> >> >> >> > pointer to the mlx5e_skb_from* functions so it can be retriev=
ed from the
>> >> >> >> > XDP ctx to do this.
>> >> >> >>
>> >> >> >> So I finally managed to get enough ducks in row to actually ben=
chmark
>> >> >> >> this. With the caveat that I suddenly can't get the timestamp s=
upport to
>> >> >> >> work (it was working in an earlier version, but now
>> >> >> >> timestamp_supported() just returns false). I'm not sure if this=
 is an
>> >> >> >> issue with the enablement patch, or if I just haven't gotten the
>> >> >> >> hardware configured properly. I'll investigate some more, but f=
igured
>> >> >> >> I'd post these results now:
>> >> >> >>
>> >> >> >> Baseline XDP_DROP:         25,678,262 pps / 38.94 ns/pkt
>> >> >> >> XDP_DROP + read metadata:  23,924,109 pps / 41.80 ns/pkt
>> >> >> >> Overhead:                   1,754,153 pps /  2.86 ns/pkt
>> >> >> >>
>> >> >> >> As per the above, this is with calling three kfuncs/pkt
>> >> >> >> (metadata_supported(), rx_hash_supported() and rx_hash()). So t=
hat's
>> >> >> >> ~0.95 ns per function call, which is a bit less, but not far of=
f from
>> >> >> >> the ~1.2 ns that I'm used to. The tests where I accidentally ca=
lled the
>> >> >> >> default kfuncs cut off ~1.3 ns for one less kfunc call, so it's
>> >> >> >> definitely in that ballpark.
>> >> >> >>
>> >> >> >> I'm not doing anything with the data, just reading it into an o=
n-stack
>> >> >> >> buffer, so this is the smallest possible delta from just gettin=
g the
>> >> >> >> data out of the driver. I did confirm that the call instruction=
s are
>> >> >> >> still in the BPF program bytecode when it's dumped back out fro=
m the
>> >> >> >> kernel.
>> >> >> >>
>> >> >> >> -Toke
>> >> >> >>
>> >> >> >
>> >> >> > Oh, that's great, thanks for running the numbers! Will definitely
>> >> >> > reference them in v4!
>> >> >> > Presumably, we should be able to at least unroll most of the
>> >> >> > _supported callbacks if we want, they should be relatively easy;=
 but
>> >> >> > the numbers look fine as is?
>> >> >>
>> >> >> Well, this is for one (and a half) piece of metadata. If we extrap=
olate
>> >> >> it adds up quickly. Say we add csum and vlan tags, say, and maybe
>> >> >> another callback to get the type of hash (l3/l4). Those would prob=
ably
>> >> >> be relevant for most packets in a fairly common setup. Extrapolati=
ng
>> >> >> from the ~1 ns/call figure, that's 8 ns/pkt, which is 20% of the
>> >> >> baseline of 39 ns.
>> >> >>
>> >> >> So in that sense I still think unrolling makes sense. At least for=
 the
>> >> >> _supported() calls, as eating a whole function call just for that =
is
>> >> >> probably a bit much (which I think was also Jakub's point in a sib=
ling
>> >> >> thread somewhere).
>> >> >
>> >> > imo the overhead is tiny enough that we can wait until
>> >> > generic 'kfunc inlining' infra is ready.
>> >> >
>> >> > We're planning to dual-compile some_kernel_file.c
>> >> > into native arch and into bpf arch.
>> >> > Then the verifier will automatically inline bpf asm
>> >> > of corresponding kfunc.
>> >>
>> >> Is that "planning" or "actively working on"? Just trying to get a sen=
se
>> >> of the time frames here, as this sounds neat, but also something that
>> >> could potentially require quite a bit of fiddling with the build syst=
em
>> >> to get to work? :)
>> >
>> > "planning", but regardless how long it takes I'd rather not
>> > add any more tech debt in the form of manual bpf asm generation.
>> > We have too much of it already: gen_lookup, convert_ctx_access, etc.
>>
>> Right, I'm no fan of the manual ASM stuff either. However, if we're
>> stuck with the function call overhead for the foreseeable future, maybe
>> we should think about other ways of cutting down the number of function
>> calls needed?
>>
>> One thing I can think of is to get rid of the individual _supported()
>> kfuncs and instead have a single one that lets you query multiple
>> features at once, like:
>>
>> __u64 features_supported, features_wanted =3D XDP_META_RX_HASH | XDP_MET=
A_TIMESTAMP;
>>
>> features_supported =3D bpf_xdp_metadata_query_features(ctx, features_wan=
ted);
>>
>> if (features_supported & XDP_META_RX_HASH)
>>   hash =3D bpf_xdp_metadata_rx_hash(ctx);
>>
>> ...etc
>
> I'm not too happy about having the bitmasks tbh :-(
> If we want to get rid of the cost of those _supported calls, maybe we
> can do some kind of libbpf-like probing? That would require loading a
> program + waiting for some packet though :-(

If we expect the program to do out of band probing, we could just get
rid of the _supported() functions entirely?

I mean, to me, the whole point of having the separate _supported()
function for each item was to have a lower-overhead way of checking if
the metadata item was supported. But if the overhead is not actually
lower (because both incur a function call), why have them at all? Then
we could just change the implementation from this:

bool mlx5e_xdp_rx_hash_supported(const struct xdp_md *ctx)
{
	const struct mlx5_xdp_buff *_ctx =3D (void *)ctx;

	return _ctx->xdp.rxq->dev->features & NETIF_F_RXHASH;
}

u32 mlx5e_xdp_rx_hash(const struct xdp_md *ctx)
{
	const struct mlx5_xdp_buff *_ctx =3D (void *)ctx;

	return be32_to_cpu(_ctx->cqe->rss_hash_result);
}

to this:

u32 mlx5e_xdp_rx_hash(const struct xdp_md *ctx)
{
	const struct mlx5_xdp_buff *_ctx =3D (void *)ctx;

	if (!(_ctx->xdp.rxq->dev->features & NETIF_F_RXHASH))
                return 0;

	return be32_to_cpu(_ctx->cqe->rss_hash_result);
}

-Toke

