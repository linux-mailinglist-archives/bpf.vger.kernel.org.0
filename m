Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F358D647B08
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 01:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiLIAy7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 19:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiLIAy5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 19:54:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA16FA19AB
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 16:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670547244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wK8VlcaE7X4LbFxkIkLWkMtxEqPupWeXGXIS/zZUBk=;
        b=Z11LLnXNvVipf6cKBIa3p7U9IVlHG4V9cufcwBjhqGkSg7O94RXZNrSxJDyqEoFrxVrKnD
        Su3UzC+b1ojtjT93o8XYCR/EbU9Iv7Vg2dePYASF80tIxhGxp4sHf6ZjknEj2/xRQaEWk5
        2UVXGGAFPY+xAL6gCN7Gbr/zpH2rtQg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-75-s4nsszTJPdim3XDKTbLoRg-1; Thu, 08 Dec 2022 19:54:03 -0500
X-MC-Unique: s4nsszTJPdim3XDKTbLoRg-1
Received: by mail-ed1-f72.google.com with SMTP id y18-20020a056402359200b004635f8b1bfbso430454edc.17
        for <bpf@vger.kernel.org>; Thu, 08 Dec 2022 16:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wK8VlcaE7X4LbFxkIkLWkMtxEqPupWeXGXIS/zZUBk=;
        b=ClmWD9634wjHjbKv9m8IJYn43UFSbiezmJLXy1+MPk076oDLO/ye4wEaIWjNYCdzCj
         Gi4QGd3qUrNd2BXn7tl0K2fEYUDH2xBhs58SeFAKy2mhZx60KGGbHIUGjBK2K/kr9x0z
         82Gv0ZEvuK5cPKf5xha/DQf74opDJ4IbaDoXJEQ7o9jd0Al2+/yZhpNi+yrDj/juvFXn
         p61AS8QpkDzSmC6f7/5Q38nqJxcaozOaoIwYmmszUp53lp77aXAd1XwpStLkX5er+CAj
         9q1H9V4/nYlMySN83TL0Fck+o58vrg5GU5WLonE3g107Ms66+fTlBLL4/gaL5u2ahPD/
         ZWQA==
X-Gm-Message-State: ANoB5plX19/k0MJJ1LefTqZ9HKblcg0QODxvnqB+svSxUr/CRpGphlQM
        U7+/iD30Z5HVulK64QHu7vOrgEcEmJSqChGjbanmkU+by/zXs+Rf3VPyo6sFlHopAjca5LNScwM
        qKfIbJ6t6cSOB
X-Received: by 2002:a17:906:a085:b0:7ad:a42f:72c2 with SMTP id q5-20020a170906a08500b007ada42f72c2mr3829968ejy.35.1670547242162;
        Thu, 08 Dec 2022 16:54:02 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Dq/3Saa/gSGiHAByXoJdf4OzG0rTx8PeaUoHG2r0e0OgPiQIdd2Z/nxR6yDH4wxgcvPt3rw==
X-Received: by 2002:a17:906:a085:b0:7ad:a42f:72c2 with SMTP id q5-20020a170906a08500b007ada42f72c2mr3829940ejy.35.1670547241698;
        Thu, 08 Dec 2022 16:54:01 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id bj15-20020a170906b04f00b007b5903e595bsm10223039ejb.84.2022.12.08.16.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 16:54:00 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AEC0B82E9DB; Fri,  9 Dec 2022 01:53:59 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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
In-Reply-To: <CAADnVQ+MyE280Q-7iw2Y-P6qGs4xcDML-tUrXEv_EQTmeESVaQ@mail.gmail.com>
References: <20221206024554.3826186-1-sdf@google.com>
 <20221206024554.3826186-12-sdf@google.com> <875yellcx6.fsf@toke.dk>
 <CAKH8qBv7nWdknuf3ap_ekpAhMgvtmoJhZ3-HRuL8Wv70SBWMSQ@mail.gmail.com>
 <87359pl9zy.fsf@toke.dk>
 <CAADnVQ+=71Y+ypQTOgFTJWY7w3YOUdY39is4vpo3aou11=eMmw@mail.gmail.com>
 <87tu25ju77.fsf@toke.dk>
 <CAADnVQ+MyE280Q-7iw2Y-P6qGs4xcDML-tUrXEv_EQTmeESVaQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 09 Dec 2022 01:53:59 +0100
Message-ID: <87o7sdjt20.fsf@toke.dk>
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

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Thu, Dec 8, 2022 at 4:29 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>> > On Thu, Dec 8, 2022 at 4:02 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
redhat.com> wrote:
>> >>
>> >> Stanislav Fomichev <sdf@google.com> writes:
>> >>
>> >> > On Thu, Dec 8, 2022 at 2:59 PM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>> >> >>
>> >> >> Stanislav Fomichev <sdf@google.com> writes:
>> >> >>
>> >> >> > From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> >> >> >
>> >> >> > Support RX hash and timestamp metadata kfuncs. We need to pass i=
n the cqe
>> >> >> > pointer to the mlx5e_skb_from* functions so it can be retrieved =
from the
>> >> >> > XDP ctx to do this.
>> >> >>
>> >> >> So I finally managed to get enough ducks in row to actually benchm=
ark
>> >> >> this. With the caveat that I suddenly can't get the timestamp supp=
ort to
>> >> >> work (it was working in an earlier version, but now
>> >> >> timestamp_supported() just returns false). I'm not sure if this is=
 an
>> >> >> issue with the enablement patch, or if I just haven't gotten the
>> >> >> hardware configured properly. I'll investigate some more, but figu=
red
>> >> >> I'd post these results now:
>> >> >>
>> >> >> Baseline XDP_DROP:         25,678,262 pps / 38.94 ns/pkt
>> >> >> XDP_DROP + read metadata:  23,924,109 pps / 41.80 ns/pkt
>> >> >> Overhead:                   1,754,153 pps /  2.86 ns/pkt
>> >> >>
>> >> >> As per the above, this is with calling three kfuncs/pkt
>> >> >> (metadata_supported(), rx_hash_supported() and rx_hash()). So that=
's
>> >> >> ~0.95 ns per function call, which is a bit less, but not far off f=
rom
>> >> >> the ~1.2 ns that I'm used to. The tests where I accidentally calle=
d the
>> >> >> default kfuncs cut off ~1.3 ns for one less kfunc call, so it's
>> >> >> definitely in that ballpark.
>> >> >>
>> >> >> I'm not doing anything with the data, just reading it into an on-s=
tack
>> >> >> buffer, so this is the smallest possible delta from just getting t=
he
>> >> >> data out of the driver. I did confirm that the call instructions a=
re
>> >> >> still in the BPF program bytecode when it's dumped back out from t=
he
>> >> >> kernel.
>> >> >>
>> >> >> -Toke
>> >> >>
>> >> >
>> >> > Oh, that's great, thanks for running the numbers! Will definitely
>> >> > reference them in v4!
>> >> > Presumably, we should be able to at least unroll most of the
>> >> > _supported callbacks if we want, they should be relatively easy; but
>> >> > the numbers look fine as is?
>> >>
>> >> Well, this is for one (and a half) piece of metadata. If we extrapola=
te
>> >> it adds up quickly. Say we add csum and vlan tags, say, and maybe
>> >> another callback to get the type of hash (l3/l4). Those would probably
>> >> be relevant for most packets in a fairly common setup. Extrapolating
>> >> from the ~1 ns/call figure, that's 8 ns/pkt, which is 20% of the
>> >> baseline of 39 ns.
>> >>
>> >> So in that sense I still think unrolling makes sense. At least for the
>> >> _supported() calls, as eating a whole function call just for that is
>> >> probably a bit much (which I think was also Jakub's point in a sibling
>> >> thread somewhere).
>> >
>> > imo the overhead is tiny enough that we can wait until
>> > generic 'kfunc inlining' infra is ready.
>> >
>> > We're planning to dual-compile some_kernel_file.c
>> > into native arch and into bpf arch.
>> > Then the verifier will automatically inline bpf asm
>> > of corresponding kfunc.
>>
>> Is that "planning" or "actively working on"? Just trying to get a sense
>> of the time frames here, as this sounds neat, but also something that
>> could potentially require quite a bit of fiddling with the build system
>> to get to work? :)
>
> "planning", but regardless how long it takes I'd rather not
> add any more tech debt in the form of manual bpf asm generation.
> We have too much of it already: gen_lookup, convert_ctx_access, etc.

Right, I'm no fan of the manual ASM stuff either. However, if we're
stuck with the function call overhead for the foreseeable future, maybe
we should think about other ways of cutting down the number of function
calls needed?

One thing I can think of is to get rid of the individual _supported()
kfuncs and instead have a single one that lets you query multiple
features at once, like:

__u64 features_supported, features_wanted =3D XDP_META_RX_HASH | XDP_META_T=
IMESTAMP;

features_supported =3D bpf_xdp_metadata_query_features(ctx, features_wanted=
);

if (features_supported & XDP_META_RX_HASH)
  hash =3D bpf_xdp_metadata_rx_hash(ctx);

...etc


-Toke

