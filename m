Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2780064DCE0
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 15:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiLOOaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 09:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiLOOaR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 09:30:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F233F2D1DD
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 06:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671114570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F9zk1ydpzyPtO+/nncYucgHPeAfHU3SdhVuHl+hsa5c=;
        b=GQvZbclfDKY/dCb2fa5f9tNQOwLdxPVy2S20kD1Zajq9sovAO5LVCrpT26FRvtxvubsPGC
        Hi173pOW45Z95oTEv8+vgpwPEbw/Y4IbLHGl8ZvbLUcwk80yhXt8GdEII0WWJTvcA6ivwT
        JAzOVAwATaE7wwiTBBpglMxR9tMKXOk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-241-_OAASZX3NruTaJuFxQi_mQ-1; Thu, 15 Dec 2022 09:29:29 -0500
X-MC-Unique: _OAASZX3NruTaJuFxQi_mQ-1
Received: by mail-ej1-f72.google.com with SMTP id xc12-20020a170907074c00b007416699ea14so13738342ejb.19
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 06:29:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9zk1ydpzyPtO+/nncYucgHPeAfHU3SdhVuHl+hsa5c=;
        b=vY9eedgRRopp5P/XkUfpcFLBOSg75fepyXoMBJ2D15yzqSBv3D5RzFBbU5lvhoBBqj
         fDzwgbDI/oEbFy3mLjAQp1XinWd+GmnVfyLX+57NGbubCjdx1RKw1/82vNGJMGhf7Pd7
         m9iVYYwUgPeGm38upeToJJKDEr8NCc/XsCx1zdjIXhhGM05oME3Gsb1jRRVA2BfoK/4K
         40M0VFNtUNIinyOr4Zi02EYSRk1nqYL9a6IW2UtMjlQXG7Y5P8Tpe5QPE75JJxwzRGgx
         svB2EGxLs5NpL5QCR07VjVchnan2XzCbgMc0yfGkfdwdbMtzg1hwv3VK96Rf4izbL4HP
         Nfog==
X-Gm-Message-State: ANoB5pkRkyVF2nTVk9eVqk1Fs9wj3wAcpEndbywuXuBTociFc0QKN5ZU
        E0TRsMbFlwGS5MEURUFKoOkxHBFEBZZ+0OPASLFuYFPfWQnyKTxmaTRpvBnJhTE+HEo1GifRmgl
        kApLWTj/3dacf
X-Received: by 2002:a05:6402:1152:b0:467:9046:e2ef with SMTP id g18-20020a056402115200b004679046e2efmr24476805edw.17.1671114567074;
        Thu, 15 Dec 2022 06:29:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf59tSBcDngjM41CYfl+TarYqzZRUi/+mvPyr9Wha9rbixivAZTpjgcQ5WUIx76Xe4MQLXPDCQ==
X-Received: by 2002:a05:6402:1152:b0:467:9046:e2ef with SMTP id g18-20020a056402115200b004679046e2efmr24476765edw.17.1671114566271;
        Thu, 15 Dec 2022 06:29:26 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ee48-20020a056402293000b004615f7495e0sm7423125edb.8.2022.12.15.06.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 06:29:25 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2F3C982F7EB; Thu, 15 Dec 2022 15:29:25 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Larysa Zaremba <larysa.zaremba@intel.com>,
        Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
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
        netdev@vger.kernel.org
Subject: Re: [xdp-hints] Re: [RFC bpf-next v2 10/14] ice: Support rx
 timestamp metadata for xdp
In-Reply-To: <Y5sIUI1jeN3c7iQA@lincoln>
References: <20221104032532.1615099-1-sdf@google.com>
 <20221104032532.1615099-11-sdf@google.com> <Y5sIUI1jeN3c7iQA@lincoln>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 15 Dec 2022 15:29:25 +0100
Message-ID: <874jtweo56.fsf@toke.dk>
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

Larysa Zaremba <larysa.zaremba@intel.com> writes:

> On Thu, Nov 03, 2022 at 08:25:28PM -0700, Stanislav Fomichev wrote:
>> +			/* if (r5 == NULL) return; */
>> +			BPF_JMP_IMM(BPF_JNE, BPF_REG_5, 0, S16_MAX),
>
> S16_MAX jump crashes my system and I do not see such jumps used very often
> in bpf code found in-tree, setting a fixed jump length worked for me.
> Also, I think BPF_JEQ is a correct condition in this case, not BPF_JNE.
>
> But the main reason for my reply is that I have implemented RX hash hint
> for ice both as unrolled bpf code and with BPF_EMIT_CALL [0].
> Both bpf_xdp_metadata_rx_hash() and bpf_xdp_metadata_rx_hash_supported() 
> are implemented in those 2 ways.
>
> RX hash is the easiest hint to read, so performance difference
> should be more visible than when reading timestapm.
>
> Counting packets in an rxdrop XDP program on a single queue
> gave me the following numbers:
>
> - unrolled:		41264360 pps
> - BPF_EMIT_CALL:	40370651 pps
>
> So, reading a single hint in an unrolled way instead of calling 2 driver
> functions in a row, gives us a 2.2% performance boost.
> Surely, the difference will increase, if we read more than a single hint.
> Therefore, it would be great to implement at least some simple hints
> functions as unrolled.
>
> [0] https://github.com/walking-machine/linux/tree/ice-kfunc-hints-clean

Right, so this corresponds to ~0.5ns function call overhead, which is a
bit less than what I was seeing[0], but you're also getting 41 Mpps
where I was getting 25, so I assume your hardware is newer :)

And yeah, I agree that ideally we really should inline these functions.
However, seeing as that may be a ways off[1], I suppose we'll have to
live with the function call overhead for now. As long as we're
reasonably confident that inlining can be added later without disruptive
API breaks I am OK with proceeding without inlining for now, though.
That way, inlining will just be a nice performance optimisation once it
does land, and who knows, maybe this will provide the impetus for
someone to land it sooner rather than later...

-Toke

[0] https://lore.kernel.org/r/875yellcx6.fsf@toke.dk
[1] https://lore.kernel.org/r/CAADnVQ+MyE280Q-7iw2Y-P6qGs4xcDML-tUrXEv_EQTmeESVaQ@mail.gmail.com

