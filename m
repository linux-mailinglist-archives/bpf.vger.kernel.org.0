Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3426256F5
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 10:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbiKKJjN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 04:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbiKKJjM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 04:39:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F386DCE4
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 01:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668159494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CuzRwI1mSTi/386dr9HtHu+gFAxlK7t/8OnS9h0/MI8=;
        b=AhnIctxeCpN8RqRjsz/pQFU3vd7pUSZcStlVe43xd+0Mya5BN5YJGYgW2hwvaOXB7WgLYi
        F3d99aBORvAZc+4klCjqu4PKlg9bZ5+V9Wk4zEiqQ7HDFsxTh/CcAQnoEorUWIE6jiVCWZ
        DpO5Oqvz0GArLtPTtc2AOxOvGYOJMtA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-613-Dt8ah1ovP76rlLa2bJaqSQ-1; Fri, 11 Nov 2022 04:38:12 -0500
X-MC-Unique: Dt8ah1ovP76rlLa2bJaqSQ-1
Received: by mail-ej1-f70.google.com with SMTP id xc12-20020a170907074c00b007416699ea14so2730965ejb.19
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 01:38:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuzRwI1mSTi/386dr9HtHu+gFAxlK7t/8OnS9h0/MI8=;
        b=H/hT2cv3if5koA3dmGBv7Vu38wQKcBa5t+SQA2T0Yc2diW41Ff+MyVgoWKbBv/KR8x
         8f00mjiz6Zk3A2nPFslXspRLYqSATC0Ez6AeVX3Pyzd+X5r6Na3Dkv44YewnmdXw9yGL
         vB4Jqdv72VcOE7RLSlbcAo0ys7QkGVxrJPzPm8VJ1dLCME0ziYBh6Sb/fJGiz7fcEETH
         jw/hngQ0xlE+B02ONh8jH0UBsYarIfV8bH5Q5ZRxOOU3kn+Gvj1sID711H8/41InHrY9
         sW18Gb5Jw19JG9nyBd9FjUy5eERQyhUeiVjuovYIXbvvX7Vs7iQZPT4tsbId2uS3i98S
         zLBg==
X-Gm-Message-State: ANoB5pkEXKshHcLkJrRi3xEyK88j4MagCbsrVhrpldqlbG7w25SFcRJL
        2Idwnf5IJx6KKqGQyh7toNSlrWmtmSY7OicP/mK84mG170YqT9ygBmvClR9uEhuKYp54MLPmDIM
        koR2tmoRSwnJJ
X-Received: by 2002:a05:6402:34f:b0:460:12ef:cc45 with SMTP id r15-20020a056402034f00b0046012efcc45mr731711edw.249.1668159491246;
        Fri, 11 Nov 2022 01:38:11 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5BoVg5/sQIOxSVn1Wrw0hWRqLlG7VKbMrBd99qOGof+9QDVLhrIqKUJpzb0Jcybgy+fNljWA==
X-Received: by 2002:a05:6402:34f:b0:460:12ef:cc45 with SMTP id r15-20020a056402034f00b0046012efcc45mr731679edw.249.1668159490817;
        Fri, 11 Nov 2022 01:38:10 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id eg25-20020a056402289900b00457b5ba968csm875513edb.27.2022.11.11.01.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 01:38:10 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3E3EE7A689F; Fri, 11 Nov 2022 10:37:53 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [xdp-hints] Re: [RFC bpf-next v2 06/14] xdp: Carry over xdp
 metadata into skb context
In-Reply-To: <d403ef7d-6dfd-bcaf-6088-cff5081f49e9@linux.dev>
References: <20221104032532.1615099-1-sdf@google.com>
 <20221104032532.1615099-7-sdf@google.com>
 <187e89c3-d7de-7bec-c72e-d9d6eb5bcca0@linux.dev>
 <CAKH8qBv_ZO=rsJcq2Lvq36d9sTAXs6kfUmW1Hk17bB=BGiGzhw@mail.gmail.com>
 <9a8fefe4-2fcb-95b7-cda0-06509feee78e@linux.dev>
 <6f57370f-7ec3-07dd-54df-04423cab6d1f@linux.dev> <87leokz8lq.fsf@toke.dk>
 <5a23b856-88a3-a57a-2191-b673f4160796@linux.dev>
 <CAKH8qBsfVOoR1MNAFx3uR9Syoc0APHABsf97kb8SGpK+T1qcew@mail.gmail.com>
 <32f81955-8296-6b9a-834a-5184c69d3aac@linux.dev>
 <CAKH8qBuLMZrFmmi77Qbt7DCd1w9FJwdeK5CnZTJqHYiWxwDx6w@mail.gmail.com>
 <87y1siyjf6.fsf@toke.dk>
 <CAKH8qBsfzYmQ9SZXhFetf_zQPNmE_L=_H_rRxJEwZzNbqtoKJA@mail.gmail.com>
 <87o7texv08.fsf@toke.dk>
 <CAKH8qBtjYV=tb28y6bvo3tGonzjvm2JLyis9AFPSMTuXsL3NPA@mail.gmail.com>
 <87eduaxsep.fsf@toke.dk> <d403ef7d-6dfd-bcaf-6088-cff5081f49e9@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 11 Nov 2022 10:37:53 +0100
Message-ID: <87o7td7rwu.fsf@toke.dk>
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

Martin KaFai Lau <martin.lau@linux.dev> writes:

> On 11/10/22 4:10 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>> The problem with AF_XDP is that, IIUC, it doesn't have a data_meta
>>> pointer in the userspace.
>>>
>>> You get an rx descriptor where the address points to the 'data':
>>> | 256 bytes headroom where metadata can go | data |
>>=20
>> Ah, I was missing the bit where the data pointer actually points at
>> data, not the start of the buf. Oops, my bad!
>>=20
>>> So you have (at most) 256 bytes of headroom, some of that might be the
>>> metadata, but you really don't know where it starts. But you know it
>>> definitely ends where the data begins.
>>>
>>> So if we have the following, we can locate skb_metadata:
>>> | 256-sizeof(skb_metadata) headroom | custom metadata | skb_metadata | =
data |
>>> data - sizeof(skb_metadata) will get you there
>>>
>>> But if it's the other way around, the program has to know
>>> sizeof(custom metadata) to locate skb_metadata:
>>> | 256-sizeof(skb_metadata) headroom | skb_metadata | custom metadata | =
data |
>>>
>>> Am I missing something here?
>>=20
>> Hmm, so one could argue that the only way AF_XDP can consume custom
>> metadata today is if it knows out of band what the size of it is. And if
>> it knows that, it can just skip over it to go back to the skb_metadata,
>> no?
>
> +1 I replied with a similar point in another email. I also think we
> can safely assume this.

Great!

>>=20
>> The only problem left then is if there were multiple XDP programs called
>> in sequence (whether before a redirect, or by libxdp chaining or tail
>> calls), and the first one resized the metadata area without the last one
>> knowing about it. For this, we could add a CLOBBER_PROGRAM_META flag to
>> the skb_metadata helper which if set will ensure that the program
>> metadata length is reset to 0?
>
> How is it different from the same xdp prog calling bpf_xdp_adjust_meta() =
and=20
> bpf_xdp_metadata_export_to_skb() multiple times.  The earlier stored=20
> skb_metadata needs to be moved during the latter bpf_xdp_adjust_meta().  =
The=20
> latter bpf_xdp_metadata_export_to_skb() will overwrite the earlier skb_me=
tadata.

Well, it would just be a convenience flag, so instead of doing:

metalen =3D ctx->data - ctx->data_meta;
if (metalen)
  xdp_adjust_meta(-metalen);
bpf_xdp_metadata_export_to_skb(ctx);

you could just do:

bpf_xdp_metadata_export_to_skb(ctx, CLOBBER_PROGRAM_META);

and the kernel would do the check+move for you. But, well, the couple of
extra instructions to do the check in BPF is probably fine.

(I'm talking here about a program that wants to make sure that any
custom metadata that may have been added by an earlier program is
removed before redirecting to an XSK socket; I expect we'd want to do
something like this in the default program in libxdp).

-Toke

