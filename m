Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69710647A6D
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 01:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiLIAEA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 19:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiLIADl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 19:03:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3204BE2
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 16:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670544168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eDjpZTzpQHuFcOQSGAT2WzTURtYSuufNt2pnLYu1YmI=;
        b=SQRQA40DGTjmXjpUshj0QYBVOT6qzenJufmk2VJvqFIXwLNK4n3/mXRU7grXu24CpSG+w1
        P5gzg2o5x/MbuacvpuxBl7GmI5gXoZt11bExyoU0+tBqw7zRlGGfsecSdQlMQk/Ad60UDp
        PB1fnYFFrbbDdcl/+jNSRcnXkXBxEyo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-29-n7kUyYBPMCa34gN8wF36_Q-1; Thu, 08 Dec 2022 19:02:46 -0500
X-MC-Unique: n7kUyYBPMCa34gN8wF36_Q-1
Received: by mail-ej1-f70.google.com with SMTP id gn36-20020a1709070d2400b007ba3374574dso1999441ejc.23
        for <bpf@vger.kernel.org>; Thu, 08 Dec 2022 16:02:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDjpZTzpQHuFcOQSGAT2WzTURtYSuufNt2pnLYu1YmI=;
        b=7zr+lYaF27Vu8Yi9FEBMEoJiIREddh5XyMPhqymkz/sDn/5CI+WCkK4Meazx+loMS0
         c9s1dEIhnD7KcHIx7xdha1gTi/WKVEX5bLBVUOx6w5LML/0gJWeUN5WbMdLgEHFEOys7
         IZ2qYxUX+n7vn4IyTDBLc+AGNxGQR27x5uSmgnlzo/VPmG0MmAv6TTPeDWVkqVNMLF4t
         aXZ9kVd3N6o3aTKKri/zAvFlLnSkKqA2eqpfBbkDIS+DuN244e55ieZxL2G8itv8V/vi
         M/4j9gK4/sHGfGPxpoSvS5H9gcIGJFhvUl3wgfoOp2I6D5f8qEm4aqYypa1SzKzp1cdq
         sUOA==
X-Gm-Message-State: ANoB5pl4NBU8JecmuEk3ImB37z+xIbkxVFfQedKW8UGzTcnTB+bh+k0Z
        SbQLUoxcWSDmpEBcHMe1pR+QdimjqReUVh7dlJE62TuGYJoexBJPZsqrclwriWQoObY2KlSzx3/
        8uuYmleB298PY
X-Received: by 2002:a17:906:2a44:b0:78d:f457:1052 with SMTP id k4-20020a1709062a4400b0078df4571052mr3230370eje.15.1670544165615;
        Thu, 08 Dec 2022 16:02:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf76wB+k5ajX4E3y8sgqWTu39b5SiGHxM11076HvMfkR+2aSdEsML81MxIdPiWvaJ0xdpilLsw==
X-Received: by 2002:a17:906:2a44:b0:78d:f457:1052 with SMTP id k4-20020a1709062a4400b0078df4571052mr3230329eje.15.1670544165123;
        Thu, 08 Dec 2022 16:02:45 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709061da100b007ae1e528390sm10136701ejh.163.2022.12.08.16.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 16:02:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E751A82E9C2; Fri,  9 Dec 2022 01:02:41 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Subject: Re: [xdp-hints] Re: [PATCH bpf-next v3 11/12] mlx5: Support RX XDP
 metadata
In-Reply-To: <CAKH8qBv7nWdknuf3ap_ekpAhMgvtmoJhZ3-HRuL8Wv70SBWMSQ@mail.gmail.com>
References: <20221206024554.3826186-1-sdf@google.com>
 <20221206024554.3826186-12-sdf@google.com> <875yellcx6.fsf@toke.dk>
 <CAKH8qBv7nWdknuf3ap_ekpAhMgvtmoJhZ3-HRuL8Wv70SBWMSQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 09 Dec 2022 01:02:41 +0100
Message-ID: <87359pl9zy.fsf@toke.dk>
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

Stanislav Fomichev <sdf@google.com> writes:

> On Thu, Dec 8, 2022 at 2:59 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> Stanislav Fomichev <sdf@google.com> writes:
>>
>> > From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> >
>> > Support RX hash and timestamp metadata kfuncs. We need to pass in the =
cqe
>> > pointer to the mlx5e_skb_from* functions so it can be retrieved from t=
he
>> > XDP ctx to do this.
>>
>> So I finally managed to get enough ducks in row to actually benchmark
>> this. With the caveat that I suddenly can't get the timestamp support to
>> work (it was working in an earlier version, but now
>> timestamp_supported() just returns false). I'm not sure if this is an
>> issue with the enablement patch, or if I just haven't gotten the
>> hardware configured properly. I'll investigate some more, but figured
>> I'd post these results now:
>>
>> Baseline XDP_DROP:         25,678,262 pps / 38.94 ns/pkt
>> XDP_DROP + read metadata:  23,924,109 pps / 41.80 ns/pkt
>> Overhead:                   1,754,153 pps /  2.86 ns/pkt
>>
>> As per the above, this is with calling three kfuncs/pkt
>> (metadata_supported(), rx_hash_supported() and rx_hash()). So that's
>> ~0.95 ns per function call, which is a bit less, but not far off from
>> the ~1.2 ns that I'm used to. The tests where I accidentally called the
>> default kfuncs cut off ~1.3 ns for one less kfunc call, so it's
>> definitely in that ballpark.
>>
>> I'm not doing anything with the data, just reading it into an on-stack
>> buffer, so this is the smallest possible delta from just getting the
>> data out of the driver. I did confirm that the call instructions are
>> still in the BPF program bytecode when it's dumped back out from the
>> kernel.
>>
>> -Toke
>>
>
> Oh, that's great, thanks for running the numbers! Will definitely
> reference them in v4!
> Presumably, we should be able to at least unroll most of the
> _supported callbacks if we want, they should be relatively easy; but
> the numbers look fine as is?

Well, this is for one (and a half) piece of metadata. If we extrapolate
it adds up quickly. Say we add csum and vlan tags, say, and maybe
another callback to get the type of hash (l3/l4). Those would probably
be relevant for most packets in a fairly common setup. Extrapolating
from the ~1 ns/call figure, that's 8 ns/pkt, which is 20% of the
baseline of 39 ns.

So in that sense I still think unrolling makes sense. At least for the
_supported() calls, as eating a whole function call just for that is
probably a bit much (which I think was also Jakub's point in a sibling
thread somewhere).

-Toke

