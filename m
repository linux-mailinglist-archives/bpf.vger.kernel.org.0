Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8B369250C
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 19:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjBJSKL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 13:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjBJSKI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 13:10:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0807070A
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 10:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676052562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bktzj9pUtDvfzFEYNHOpgZ9otzlEtCU+sjtmZV2ehpA=;
        b=a/7tyEoBz8AB4Ow4DbU/Y9myyOkB5TBQOVbj7DzUdmrq5uO4T6zsScnaqHZv4qws8AcybV
        5A15inHowTN6wslnhAuKvQyEz/FQaxF/s5va8+wgHU67SP8t7m7PAO/Kc8ybsN7Z17jqiM
        830OnIyhOxgbYoqSkczGek4gW9YCy8c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-86-UwuS-EB1MQ6ggs_TUyGRiA-1; Fri, 10 Feb 2023 13:09:16 -0500
X-MC-Unique: UwuS-EB1MQ6ggs_TUyGRiA-1
Received: by mail-ed1-f70.google.com with SMTP id g19-20020a056402115300b004a26cc7f6cbso4030738edw.4
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 10:09:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bktzj9pUtDvfzFEYNHOpgZ9otzlEtCU+sjtmZV2ehpA=;
        b=gQESQY/3aJYA2CrebaxmbG/sIksjd4QmZlJbSQfH5UgMkj1IlWwfNEHer0wX/Sjze+
         g5miJmq/Xkv8DjGrFJo/ZQ5WCsff0JubDP2/R5cxj5tUico/GAjUCwI0s85loz1g2mYC
         nND478vKz3drWWeXAMOm2Q916k+DO73EaXY1m/SZo6imTypmeXQUPNjB5HIdYW5gDD2q
         O8wesLs99zxnH+cjI6RUNlSGGN62VCJRtC388KSPOYvw5t/bGKcESBlP3Nfa0V8FF+pz
         Ex7Ryh+kCKtUGtpBoDv/56x0EiQN9NqvmwsfrN2pCOLLXV7xzddJmMdTPloC9sZyP0gz
         /0rA==
X-Gm-Message-State: AO0yUKVxFA5LDCGauwnRXOG6ea3Dh8Tghl3pUqv+uVoSGGlR7vvOcAcE
        rwEbqMETIZKCwEILCwmzuLWLnEIXvxc8a3ISdQ8NuMJjB6vMRRf2wmPmMF20SFXlTwV/U01JdWO
        bKRYf76BJJWqTOk1RHQ==
X-Received: by 2002:a17:906:1ec8:b0:88d:5fd1:3197 with SMTP id m8-20020a1709061ec800b0088d5fd13197mr15634096ejj.50.1676052554995;
        Fri, 10 Feb 2023 10:09:14 -0800 (PST)
X-Google-Smtp-Source: AK7set9IcNHTm+2uFIQaJFbvxf0GV4vcbWMrGctJyoagu2VVIovhZ9nGDJhJoXQ7kr1gNOVf0B3XXw==
X-Received: by 2002:a17:906:1ec8:b0:88d:5fd1:3197 with SMTP id m8-20020a1709061ec800b0088d5fd13197mr15634064ejj.50.1676052554472;
        Fri, 10 Feb 2023 10:09:14 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id kg12-20020a17090776ec00b008710789d85fsm2672300ejc.156.2023.02.10.10.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 10:09:14 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CDA9C973E85; Fri, 10 Feb 2023 19:09:12 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/6] ice: post-mbuf fixes
In-Reply-To: <20230210170618.1973430-1-alexandr.lobakin@intel.com>
References: <20230210170618.1973430-1-alexandr.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 10 Feb 2023 19:09:12 +0100
Message-ID: <87fsbd75pz.fsf@toke.dk>
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

Alexander Lobakin <alexandr.lobakin@intel.com> writes:

> The set grew from the poor performance of %BPF_F_TEST_XDP_LIVE_FRAMES
> when the ice-backed device is a sender. Initially there were around
> 3.3 Mpps / thread, while I have 5.5 on skb-based pktgen...
>
> After fixing 0005 (0004 is a prereq for it) first (strange thing nobody
> noticed that earlier), I started catching random OOMs. This is how 0002
> (and partially 0001) appeared.
> 0003 is a suggestion from Maciej to not waste time on refactoring dead
> lines. 0006 is a "cherry on top" to get away with the final 6.7 Mpps.
> 4.5 of 6 are fixes, but only the first three are tagged, since it then
> starts being tricky. I may backport them manually later on.
>
> TL;DR for the series is that shortcuts are good, but only as long as
> they don't make the driver miss important things. %XDP_TX is purely
> driver-local, however .ndo_xdp_xmit() is not, and sometimes assumptions
> can be unsafe there.
>
> With that series and also one core code patch[0], "live frames" and
> xdp-trafficgen are now safe'n'fast on ice (probably more to come).

Nice speedup! And cool to see that you're playing around with
xdp-trafficgen :)

-Toke

