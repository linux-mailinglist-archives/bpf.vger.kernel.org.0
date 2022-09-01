Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9945A8E01
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 08:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiIAGKs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 02:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiIAGKr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 02:10:47 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86C9BB01A
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 23:10:46 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b5so20898542wrr.5
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 23:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=BSZ8RYQwsEq+ZHDeMsWovu5X93zcXLSLqCbeRmnPF0g=;
        b=Q9tdOAtZSvK1cKFUHCrrmy+dNrwbqG4v5Ux2iG7WztwgCgXctUHZVd6nt57AC+o+f/
         i7BS4oMD+HiWKMsfp2qQSkb42Dw9bEBw/RyPL2+wXdQC3XFUPFR5g3WOk2AbVQmkoJOh
         7G87x0O84Dy6O6OWkQGBzUU12o1+oxLUgygcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BSZ8RYQwsEq+ZHDeMsWovu5X93zcXLSLqCbeRmnPF0g=;
        b=rD3QUwYtq3JS+468lSnesLFxQCeFxAK+cO+5v23eUBoSfWeIUWL3OXO+13e3cRWlfT
         UHTEBw4b+cAf6AR1dAVf7La6dv/UXEbhhhO7IpaJUjThQtkewjnd6anXh+HegZP1PJMU
         7gq1HBGQMiXlbahsqV/PD7CEIQGxFSomcKPvT+XXY1UE0E5F5qgu8ujCIQkMpzHvyR97
         G9o9ZEIwzUARS88bCjlIBuofH0nmOhf8PSHpx64t0RzsvMZZcRKCLw1ow8qzK1c686vt
         V+YPF3xptqA7w1n8gP79BWfBK7edZkgi3n2kQwMeZtS0CjjTW9VCtE3Ew/nHo7WgaK4U
         gWzg==
X-Gm-Message-State: ACgBeo1WZEjvPEhumUPmJA11MAOc5nPACwolLj3sjRi+smmiYSs8kx4D
        FGllX6d5EgEu6Qpe8PhXFFzXOg==
X-Google-Smtp-Source: AA6agR5n1yptRTC/Isqzm+FAkqPBEptlcnlvS0EMZbFPLukJVercrl+f04L1tu5fp6pktl+ps/L8Ng==
X-Received: by 2002:a05:6000:4005:b0:225:8b27:e6d5 with SMTP id cy5-20020a056000400500b002258b27e6d5mr13516657wrb.603.1662012645267;
        Wed, 31 Aug 2022 23:10:45 -0700 (PDT)
Received: from blondie ([5.102.239.127])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d6790000000b0021f0c0c62d1sm13715385wru.13.2022.08.31.23.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 23:10:44 -0700 (PDT)
Date:   Thu, 1 Sep 2022 09:10:40 +0300
From:   Shmulik Ladkani <shmulik@metanetworks.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Support getting tunnel flags
Message-ID: <20220901091040.2fcd73af@blondie>
In-Reply-To: <3b4e74bb-5ede-e773-69e6-6c272ffa2459@iogearbox.net>
References: <20220831144010.174110-1-shmulik.ladkani@gmail.com>
        <3b4e74bb-5ede-e773-69e6-6c272ffa2459@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 31 Aug 2022 22:46:15 +0200
Daniel Borkmann <daniel@iogearbox.net> wrote:

> The bpf_skb_set_tunnel_key() helper has a number of flags we pass in, e.g.
> BPF_F_ZERO_CSUM_TX, BPF_F_DONT_FRAGMENT, BPF_F_SEQ_NUMBER, and then based on
> those flags we set:
> 
>    [...]
>    info->key.tun_flags = TUNNEL_KEY | TUNNEL_CSUM | TUNNEL_NOCACHE;
>    if (flags & BPF_F_DONT_FRAGMENT)
>            info->key.tun_flags |= TUNNEL_DONT_FRAGMENT;
>    if (flags & BPF_F_ZERO_CSUM_TX)
>            info->key.tun_flags &= ~TUNNEL_CSUM;
>    if (flags & BPF_F_SEQ_NUMBER)
>            info->key.tun_flags |= TUNNEL_SEQ;
>    [...]
> 
> Should we similarly only expose those which are interesting/relevant to BPF
> program authors as a __u16 tunnel_flags and not the whole set? Which ones
> do you have a need for? TUNNEL_SEQ, TUNNEL_CSUM, TUNNEL_KEY, and then the
> TUNNEL_OPTIONS_PRESENT?

Indeed, I noticed this and considered various approaches:

1. Convert the "interesting" internal TUNNEL_xxx flags back to BPF_F_yyy
and place into the new 'tunnel_flags' field.
This has 2 drawbacks:
 - The BPF_F_yyy flags are from *set_tunnel_key* enumeration space,
   e.g. BPF_F_ZERO_CSUM_TX.
   I find it awkward that it is "returned" into tunnel_flags from a
   *get_tunnel_key* call.
 - Not all "interesting" TUNNEL_xxx flags can be mapped to existing
   BPF_F_yyy flags, and it doesn't make sense to create new BPF_F_yyy
   flags just for purposes of the returned tunnel_flags.

2. Place key.tun_flags into 'tunnel_flags' but mask them, keeping only
   "interesting" flags.
   That's ok, but the drawback is that what's "intersting" for my
   usecase might be limiting for other usecases.

Therefore I decided to expose what's in key.tun_flags *as is*, which seems
most flexible. The bpf user can just choose to ingore bits he's not
interested in. The TUNNEL_xxx are uapi, so no harm exposing them back in
the get_tunnel_key call.

WDYT?

Best,
Shmulik


