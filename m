Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508E362B1ED
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 04:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiKPDtg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 22:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKPDtf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 22:49:35 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E57CD4
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 19:49:33 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id v7-20020a4aa507000000b00496e843fdfeso2328470ook.7
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 19:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sn1PU0fhKeuhqwgr9BNVczeTZXPqtOjMcepvP649/uM=;
        b=KSecYQqIgdvkAamvuPhaAjfNRU1nsJQxItgUhdghyteHPLHArb4UBV61+XvkB1BYZV
         lOspB31aHbzJaoQ+U7w0Ew77M7Ww7CqsDfVV8XduYHOuy+kGpHUJfucUTxaEYC+cSh4s
         dlQMh2etxa7oiMpwezGIU+3vbarxfV5M0HapWebEqGWJSabLb2jheictduThrDshMvph
         crvMqa6fZ3Ff1JTnMAmzfzmH0V8Hm6EBwvo7h7HyI/hjRfX4cXwoEyzGNSonkHfmNnz8
         f4YKyq5JHuhOiePFwRBCy4x+ePt/+YZ1Yv1L8PWj9i4KB/ooAlDrWwjml6ltBUD2vauB
         PIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sn1PU0fhKeuhqwgr9BNVczeTZXPqtOjMcepvP649/uM=;
        b=njvQrY37t48cLpv6+NnDqzi2Q9MAgOpD1UbdOTlmhew2JUSYP7diTfeYCf125eIbSK
         /psmY9XftjQ0qbbtKHt53JWeRWH0UTDRuyrS/NVyhmmb2prYZk9A6TR45MeGefX50tws
         KBrX2AeeWZEaBghV7p+jvbdV1/8gZ6cOyoD31AR2HSocA2tcrMEGx92gldZia4N+2oaI
         csUvU+0DaGOvUMaZhxE6bSKhSrg+ZqPsr02z4T6KJw+7tWdXPEeM63+MRwHg71gakScn
         UfUgsum7homci5dEmLfkkiKPDSmeGX0Q6pD38a4Gyeg0usAGN5keZsBvTnY360moHrng
         n9Tw==
X-Gm-Message-State: ANoB5plSy1EAcjWei/p3YW8DD4K6xC4zetvGupGP0w+KU46hrM1SJLDZ
        AUjCCDibxRnteDilEpVawQ4350og5SSURDpbT1OStg==
X-Google-Smtp-Source: AA0mqf5774YJd7bWBwwygoPi/UspxVSpQCcUE+J2lCZVLszFqqptm6MNss35oP+CuTYc2V6oj5n8xA3A40mR3Sdxgvo=
X-Received: by 2002:a05:6820:1687:b0:480:a6b4:d398 with SMTP id
 bc7-20020a056820168700b00480a6b4d398mr8995102oob.86.1668570572838; Tue, 15
 Nov 2022 19:49:32 -0800 (PST)
MIME-Version: 1.0
References: <20221115030210.3159213-1-sdf@google.com> <20221115030210.3159213-7-sdf@google.com>
 <87wn7vdcud.fsf@toke.dk>
In-Reply-To: <87wn7vdcud.fsf@toke.dk>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 15 Nov 2022 19:49:21 -0800
Message-ID: <CAKH8qBugRAS_MJCgHGaYnj2L+7==E0QP37D8iais2mQ_W9ob-A@mail.gmail.com>
Subject: Re: [xdp-hints] [PATCH bpf-next 06/11] xdp: Carry over xdp metadata
 into skb context
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 3:20 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index b444b1118c4f..71e3bc7ad839 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6116,6 +6116,12 @@ enum xdp_action {
> >       XDP_REDIRECT,
> >  };
> >
> > +/* Subset of XDP metadata exported to skb context.
> > + */
> > +struct xdp_skb_metadata {
> > +     __u64 rx_timestamp;
> > +};
>
> Okay, so given Alexei's comment about __randomize_struct not actually
> working, I think we need to come up with something else for this. Just
> sticking this in a regular UAPI header seems like a bad idea; we'd just
> be inviting people to use it as-is.
>
> Do we actually need the full definition here? It's just a pointer
> declaration below, so is an opaque forward-definition enough? Then we
> could have the full definition in an internal header, moving the full
> definition back to being in vmlinux.h only?

Looks like having a uapi-declaration only (and moving the definition
into the kernel headers) might work. At least it does in my limited
testing :-) So let's go with that for now. Alexei, thanks for the
context on __randomize_struct!
