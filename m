Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C832624E4D
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 00:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiKJXPS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 18:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKJXPR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 18:15:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4FDE086
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 15:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668122059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YA1B4F3JHrLMlEJmAH0blzoYzQuaQ9SskbALpJV/L2Q=;
        b=eYa9w4VLuO2TElji25HRZy+oBHP8eWqYlDS2tKBJGED0kyoVCIGPLOA2Ug3s1PvaL2ALlk
        gQH0lTidl63e7VGbSuDy58mbBK0iAJg6362B5RP3g6GewcbIIqSor/91iyjfA7NLc2f2Ax
        ItmGUgc80gwweLAwOyXliqWqAyvdmCs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-502-AJt6WD0JPSiD7NyNE-KAew-1; Thu, 10 Nov 2022 18:14:18 -0500
X-MC-Unique: AJt6WD0JPSiD7NyNE-KAew-1
Received: by mail-ej1-f71.google.com with SMTP id dn14-20020a17090794ce00b007ae5d040ca8so2030017ejc.17
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 15:14:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YA1B4F3JHrLMlEJmAH0blzoYzQuaQ9SskbALpJV/L2Q=;
        b=BhSAKRTCUE+kwF5PW8K0Cw8QIZMcTF2lgBkzp+Qhg09PEugujBZJ5Nt2UpN+O1K7zb
         epDq95JBbpq7l4drb14UGgYA7Evoq8DpeXRi8OZf8mTdZFhNWvIxioJWsjtr0a57jHVC
         KllCfSoMdoZwpVsN+VBI4ZtocZJIMVbpUk8oZowG0kt7kuYevRuhQeMgumvP1GMZgWk2
         Hkg5fqhzKOJeGq2/Ch8+9d2AIHjPAOPFcmpDF8WE0mEsOguhpaEqxcj7G1hOax9YGWTf
         Myuxia484VO2FUKfAdLcmFIKasvx47ot4JED21+HDTtbO8kPuNO0kTwoTMKXTRWGwX38
         GKiQ==
X-Gm-Message-State: ACrzQf3lQTldGfSPjR6m1BX6u73OWjXzqP/mTVufK+/SEvDqFdCDlbF+
        bYIBKLkVTERHeXSLaBlDPAl2kdwHpf8+sF9+oeHZKoFH274blHF00H61Xwz52Ch1vkYesa9H2tX
        ykkRbENBjLX4C
X-Received: by 2002:a17:906:9610:b0:781:d0c1:4434 with SMTP id s16-20020a170906961000b00781d0c14434mr4158650ejx.756.1668122056976;
        Thu, 10 Nov 2022 15:14:16 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5M827Mm0onMuO+GRMDe4mDoRlhE6cRZFk+sbnuX3ylS5Bplm4nsOuGHj+qfQXPy2VWaCsfgQ==
X-Received: by 2002:a17:906:9610:b0:781:d0c1:4434 with SMTP id s16-20020a170906961000b00781d0c14434mr4158639ejx.756.1668122056644;
        Thu, 10 Nov 2022 15:14:16 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id b14-20020aa7dc0e000000b00462e1d8e914sm370531edu.68.2022.11.10.15.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 15:14:16 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 497E0782747; Fri, 11 Nov 2022 00:14:15 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
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
In-Reply-To: <CAKH8qBsfzYmQ9SZXhFetf_zQPNmE_L=_H_rRxJEwZzNbqtoKJA@mail.gmail.com>
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
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 11 Nov 2022 00:14:15 +0100
Message-ID: <87o7texv08.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Skipping to the last bit:

>> >> >    } else {
>> >> >      use kfuncs
>> >> >    }
>> >> >
>> >> > 5. Support the case where we keep program's metadata and kernel's
>> >> > xdp_to_skb_metadata
>> >> >    - skb_metadata_import_from_xdp() will "consume" it by mem-moving the
>> >> > rest of the metadata over it and adjusting the headroom
>> >>
>> >> I was thinking the kernel's xdp_to_skb_metadata is always before the program's
>> >> metadata.  xdp prog should usually work in this order also: read/write headers,
>> >> write its own metadata, call bpf_xdp_metadata_export_to_skb(), and return
>> >> XDP_PASS/XDP_REDIRECT.  When it is XDP_PASS, the kernel just needs to pop the
>> >> xdp_to_skb_metadata and pass the remaining program's metadata to the bpf-tc.
>> >>
>> >> For the kernel and xdp prog, I don't think it matters where the
>> >> xdp_to_skb_metadata is.  However, the xdp->data_meta (program's metadata) has to
>> >> be before xdp->data because of the current data_meta and data comparison usage
>> >> in the xdp prog.
>> >>
>> >> The order of the kernel's xdp_to_skb_metadata and the program's metadata
>> >> probably only matters to the userspace AF_XDP.  However, I don't see how AF_XDP
>> >> supports the program's metadata now.  afaict, it can only work now if there is
>> >> some sort of contract between them or the AF_XDP currently does not use the
>> >> program's metadata.  Either way, we can do the mem-moving only for AF_XDP and it
>> >> should be a no op if there is no program's metadata?  This behavior could also
>> >> be configurable through setsockopt?
>> >
>> > Agreed on all of the above. For now it seems like the safest thing to
>> > do is to put xdp_to_skb_metadata last to allow af_xdp to properly
>> > locate btf_id.
>> > Let's see if Toke disagrees :-)
>>
>> As I replied to Martin, I'm not sure it's worth the complexity to
>> logically split the SKB metadata from the program's own metadata (as
>> opposed to just reusing the existing data_meta pointer)?
>
> I'd gladly keep my current requirement where it's either or, but not both :-)
> We can relax it later if required?

So the way I've been thinking about it is simply that the skb_metadata
would live in the same place at the data_meta pointer (including
adjusting that pointer to accommodate it), and just overriding the
existing program metadata, if any exists. But looking at it now, I guess
having the split makes it easier for a program to write its own custom
metadata and still use the skb metadata. See below about the ordering.

>> However, if we do, the layout that makes most sense to me is putting the
>> skb metadata before the program metadata, like:
>>
>> --------------
>> | skb_metadata
>> --------------
>> | data_meta
>> --------------
>> | data
>> --------------
>>
>> Not sure if that's what you meant? :)
>
> I was suggesting the other way around: |custom meta|skb_metadata|data|
> (but, as Martin points out, consuming skb_metadata in the kernel
> becomes messier)
>
> af_xdp can check whether skb_metdata is present by looking at data -
> offsetof(struct skb_metadata, btf_id).
> progs that know how to handle custom metadata, will look at data -
> sizeof(skb_metadata)
>
> Otherwise, if it's the other way around, how do we find skb_metadata
> in a redirected frame?
> Let's say we have |skb_metadata|custom meta|data|, how does the final
> program find skb_metadata?
> All the progs have to agree on the sizeof(tc/custom meta), right?

Erm, maybe I'm missing something here, but skb_metadata is fixed size,
right? So if the "skb_metadata is present" flag is set, we know that the
sizeof(skb_metadata) bytes before the data_meta pointer contains the
metadata, and if the flag is not set, we know those bytes are not valid
metadata.

For AF_XDP, we'd need to transfer the flag as well, and it could apply
the same logic (getting the size from the vmlinux BTF).

By this logic, the BTF_ID should be the *first* entry of struct
skb_metadata, since that will be the field AF_XDP programs can find
right off the bat, no?

-Toke

