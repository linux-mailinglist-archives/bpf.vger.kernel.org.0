Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17D162572D
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 10:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiKKJqC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 04:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiKKJqB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 04:46:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F294B2A1
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 01:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668159905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zNf7ZXOT6z9fd4Tt6B6QdA1QJpIGsL1BM+FjfGyIKL0=;
        b=D4LtCxJuepEyJk4etcmIGGCRZr+zVpiMH1QeB/pkifPqrMdmWexRhG/IndPdGjIBSijeqB
        sxL/20MFGp/suLyvqr/4y0ulJY6Nt2Oj4vzGliuks6aKsJaty4UvA+NqKlEd+P2ES73gXh
        FQP/IFaCYwBRg6B0tSEvF/8MuI8bryA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-642-ACG_jr-JOUCElHjn_08iFw-1; Fri, 11 Nov 2022 04:45:03 -0500
X-MC-Unique: ACG_jr-JOUCElHjn_08iFw-1
Received: by mail-ej1-f71.google.com with SMTP id hb35-20020a170907162300b007ae6746f240so2736689ejc.12
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 01:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNf7ZXOT6z9fd4Tt6B6QdA1QJpIGsL1BM+FjfGyIKL0=;
        b=fYYJ9CfUgLsN/e1diQgYcoojhM2qNjZTwhpnO4w4RUgZLke5ptSUYlRagkgwFI9Hbx
         1p6D/yQl0HPrA2FHhiJ7jNAvwICBsWlrihQoTKgjwPnNMmplSkJSM/CGqTTXUxbfJ8Ij
         crZvA/kjO4+Gx65/yQ6JElwrGvdVVtTnwgDT9N/yhqai32GFf4VQcJzh0imkJ3Ig5hFE
         bM5SNapDMlUFnSWFCj4ghiPv7o06LNOMiX9xw5X17PWgwB53q5dkO3YiZ97Qgm7wlyTr
         o83cLbjuxKTwAZ0ldhFqOKdvwUu4OmewOyNxilMDbzrY4lYL1wAyujbH07slJ+ePBN5m
         NL6w==
X-Gm-Message-State: ANoB5pnQmNidLYoPLQJK7iK3xHbUqBJhkOTgyYalDjAZ/oAxBCmiAfCv
        YbsbmvlBRBbH/T1PuZBmG7x0OGw5o+MzQQGeS2Pm2+BovC4rfPrSYe+FbofeYGNY6MBzTtOU+lQ
        q6s2BR5TESbuv
X-Received: by 2002:aa7:c702:0:b0:461:8156:e0ca with SMTP id i2-20020aa7c702000000b004618156e0camr733252edq.271.1668159902256;
        Fri, 11 Nov 2022 01:45:02 -0800 (PST)
X-Google-Smtp-Source: AA0mqf51QzkFNHVdKXxekMd802nRscfJVnL2TqOzrhRzF34Md3cQPmIKH7X2QQ2HioI6VTLXL5UqJw==
X-Received: by 2002:aa7:c702:0:b0:461:8156:e0ca with SMTP id i2-20020aa7c702000000b004618156e0camr733214edq.271.1668159901827;
        Fri, 11 Nov 2022 01:45:01 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id f7-20020a1709063f4700b0078d0981516esm719419ejj.38.2022.11.11.01.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 01:45:01 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 800987A68A3; Fri, 11 Nov 2022 10:44:58 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Stanislav Fomichev <sdf@google.com>, ast@kernel.org,
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
In-Reply-To: <ed37045f-eb3d-8db0-4e5d-12bf7da8587e@linux.dev>
References: <20221104032532.1615099-1-sdf@google.com>
 <20221104032532.1615099-7-sdf@google.com>
 <187e89c3-d7de-7bec-c72e-d9d6eb5bcca0@linux.dev>
 <CAKH8qBv_ZO=rsJcq2Lvq36d9sTAXs6kfUmW1Hk17bB=BGiGzhw@mail.gmail.com>
 <9a8fefe4-2fcb-95b7-cda0-06509feee78e@linux.dev>
 <6f57370f-7ec3-07dd-54df-04423cab6d1f@linux.dev> <87leokz8lq.fsf@toke.dk>
 <5a23b856-88a3-a57a-2191-b673f4160796@linux.dev> <871qqazyc9.fsf@toke.dk>
 <7eb3e22a-c416-e898-dff0-1146d3cc82c0@linux.dev> <87mt8yxuag.fsf@toke.dk>
 <ed37045f-eb3d-8db0-4e5d-12bf7da8587e@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 11 Nov 2022 10:44:58 +0100
Message-ID: <87iljl7rl1.fsf@toke.dk>
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

Martin KaFai Lau <martin.lau@linux.dev> writes:

> On 11/10/22 3:29 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> For the metadata consumed by the stack right now it's a bit
>>>> hypothetical, yeah. However, there's a bunch of metadata commonly
>>>> supported by hardware that the stack currently doesn't consume and that
>>>> hopefully this feature will end up making more accessible. My hope is
>>>> that the stack can also learn how to use this in the future, in which
>>>> case we may run out of space. So I think of that bit mostly as
>>>> future-proofing...
>>>
>>> ic. in this case, Can the btf_id be added to 'struct xdp_to_skb_metadat=
a' later
>>> if it is indeed needed?  The 'struct xdp_to_skb_metadata' is not in UAP=
I and
>>> doing it with CO-RE is to give us flexibility to make this kind of chan=
ges in
>>> the future.
>>=20
>> My worry is mostly that it'll be more painful to add it later than just
>> including it from the start, mostly because of AF_XDP users. But if we
>> do the randomisation thing (thus forcing AF_XDP users to deal with the
>> dynamic layout as well), it should be possible to add it later, and I
>> can live with that option as well...
>
> imo, considering we are trying to optimize unnecessary field
> initialization as below, it is sort of wasteful to always initialize
> the btf_id with the same value. It is better to add it in the future
> when there is a need.

Okay, let's omit the BTF ID for now, and see what that looks like. I'll
try to keep in mind to see if I can find any reasons why we'd need to
add it back and make sure to complain before this lands if I find any :)

-Toke

