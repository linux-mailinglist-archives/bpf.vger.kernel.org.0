Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9123059EF90
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 01:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiHWXKi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 19:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiHWXKg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 19:10:36 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5801121834
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 16:10:34 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id b2so11690688qvp.1
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 16:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=MumlvhJREMBor+ss6ERltbWqLmkO6d0Q+SqXHbmQZKg=;
        b=MYoJhc4xdeTM1XIFpLePX2fQtFxGiuJu9zgZlETmHrj4uACoEgSoVwCaoZA20kiQPW
         JHRbZl0qTR9TViUhNE31lUdBkjfHbrVsrOvN6GQuOGGtUlJBGAV3bM1PJCkZ5fkK9cy2
         BjfsDvidSl58Hs8Cfi+z3sE0cvMg9vzZa9cB5paagTTVjuIsULidaK0XqItKLKt/Kw/1
         mzEhvq1vmpg06S7xUnqscmWqsPgby1Qs8Y0exI3fBKso+6mkqwDti/+rwxNGFcpoGeef
         1lDOxC1nGgviPPDD6BHd57Tb7yHNNCxF6OF4lyakueN/u2XWpEpnagJ/LAZLCFs0MtfC
         7d9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=MumlvhJREMBor+ss6ERltbWqLmkO6d0Q+SqXHbmQZKg=;
        b=No1b1iur1HfIwiFcklngQnHUcATPwvjMiCCqPrM+zQMW+TJDrDpYsoM7u68VrOg6M9
         heM8Nx/0VSxzjbiGKvdm2lK86XcuGLb4UqrWTlTgd0ublhBJD2u5qPOT6z58iGBNCDGJ
         LEr1kgMpzO7Yd8aCOn8dZ1IHb0Ga1oEPTEWFfujXyMHxPmP34ccQYKNZ103LGkGk6D6k
         3g/fr9yddNQumNhEw0LtpUvhl2Q1A9xvneJBEmySml12Iwflv6Oi453vNS5VlE4lZ/o5
         YiHcu4bnqzUvo9u333ViOYUdmYuLJYx7hWSexbLOufcn9EHPgPNqAEuanwL0EoUfVkdy
         ke9g==
X-Gm-Message-State: ACgBeo0t6wkmghK8Zpo7HZFVrN6WeKwCBYS9c6KTzb6R3f6xAX3KMPXH
        JfVJ/3UhZF+Y+gxZHFaegbyAXQj0ebzr3Mw2t9A=
X-Google-Smtp-Source: AA6agR73DrbStkrokdO7Y+rG2S7m4FMHlKMyl2bCEJzH9gFzZfp+tRxOxDmJBCCegUWre1G/JH+VlacJSu7jqdourGU=
X-Received: by 2002:a0c:8e8c:0:b0:474:9a1e:c412 with SMTP id
 x12-20020a0c8e8c000000b004749a1ec412mr22450671qvb.122.1661296233307; Tue, 23
 Aug 2022 16:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220822130820.1252010-1-eyal.birger@gmail.com> <3d69a390-f503-e3b8-78ab-b74f5d32e84d@iogearbox.net>
In-Reply-To: <3d69a390-f503-e3b8-78ab-b74f5d32e84d@iogearbox.net>
From:   Eyal Birger <eyal.birger@gmail.com>
Date:   Wed, 24 Aug 2022 02:10:21 +0300
Message-ID: <CAHsH6GvHZJtgfaKcpeyuut9ChbO5EmY27XpjJPyr73ZVbSuktQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next,v2] selftests/bpf: add lwt ip encap tests to test_progs
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Daniel,

On Wed, Aug 24, 2022 at 1:43 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 8/22/22 3:08 PM, Eyal Birger wrote:
> > Port test_lwt_ip_encap.sh tests onto test_progs.
> >
> > In addition, this commit adds "egress_md" tests which test a similar
> > flow as egress tests only they use gre devices in collect_md mode
> > for encapsulation and set the tunnel key using bpf_set_tunnel_key().
> >
> > This introduces minor changes to test_lwt_ip_encap.{sh,c} for consistency
> > with the new tests:
> >
> > - GRE key must exist as bpf_set_tunnel_key() explicitly sets the
> >    TUNNEL_KEY flag
> >
> > - Source address for GRE traffic is set to IP*_5 instead of IP*_1 since
> >    GRE traffic is sent via veth5 so its address is selected when using
> >    bpf_set_tunnel_key()
> >
> > Note: currently these programs use the legacy section name convention
> > as iproute2 lwt configuration does not support providing function names.
> >
> > Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
> [...]
>
> Thanks for following up. Is there now anything that test_lwt_ip_encap.c
> doesn't cover over test_lwt_ip_encap.sh? If not, I'd vote for removing
> the latter given the port is then covered in CI via test_progs.

The .c version includes all tests in the .sh and two more.
At least when I tried using vmtest the .sh version seems broken.

I can resubmit with an additional patch removing it, or send a follow
up patch as you prefer.

Thanks,
Eyal.
>
> > diff --git a/tools/testing/selftests/bpf/test_lwt_ip_encap.sh b/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
> > index 6c69c42b1d60..a79f7840ceb1 100755
> > --- a/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
> > +++ b/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
> > @@ -238,7 +238,8 @@ setup()
> >       ip -netns ${NS3} -6 route add ${IPv6_6}/128 dev veth8 via ${IPv6_7}
> >
> >       # configure IPv4 GRE device in NS3, and a route to it via the "bottom" route
> > -     ip -netns ${NS3} tunnel add gre_dev mode gre remote ${IPv4_1} local ${IPv4_GRE} ttl 255
> > +     ip -netns ${NS3} tunnel add gre_dev mode gre remote ${IPv4_5} \
> > +             local ${IPv4_GRE} ttl 255 key 0
> >       ip -netns ${NS3} link set gre_dev up
> >       ip -netns ${NS3} addr add ${IPv4_GRE} dev gre_dev
> >       ip -netns ${NS1} route add ${IPv4_GRE}/32 dev veth5 via ${IPv4_6} ${VRF}
> > @@ -246,7 +247,8 @@ setup()
> >
> >
> >       # configure IPv6 GRE device in NS3, and a route to it via the "bottom" route
> > -     ip -netns ${NS3} -6 tunnel add name gre6_dev mode ip6gre remote ${IPv6_1} local ${IPv6_GRE} ttl 255
> > +     ip -netns ${NS3} -6 tunnel add name gre6_dev mode ip6gre remote ${IPv6_5} \
> > +             local ${IPv6_GRE} ttl 255 key 0
> >       ip -netns ${NS3} link set gre6_dev up
> >       ip -netns ${NS3} -6 addr add ${IPv6_GRE} nodad dev gre6_dev
> >       ip -netns ${NS1} -6 route add ${IPv6_GRE}/128 dev veth5 via ${IPv6_6} ${VRF}
> >
>
