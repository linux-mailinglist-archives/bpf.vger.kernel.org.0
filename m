Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EF5520D26
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 07:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbiEJFQi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 01:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbiEJFQh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 01:16:37 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB1B2A83F7
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 22:12:41 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id d6so18593837ede.8
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 22:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fgc4HxmdEdNTRUgxx6D1tte3hSHFOUJ+zE0fY7Bkc7A=;
        b=fAaSgoBDOImbW2XugRD/rccF0S0fDkTZOaKEQbO3xd7CLZ8F1T3wpHOMudyl5Rxai6
         CjAgcSxkPSniAHMMAmv3LgONooXlxUMnikg3Uzbpphh1KllpcnKrnZsaxn2mX3WCJ61m
         oAwYFrF+Pzt7/lOmXEBu4nNR5+GU+kqfiOhDtoV0mc/JUM30x4Ai4XKLjiqboIaN3UmK
         Qsfqn+lc2WQWgojuMX12/uwVpXfvqNVEPr4whudMU1V1G1YgDtzHep3MTDZmJ+iXJusE
         0mpkz6f7CihklKDCgIVGBjnV/TdJhdvbsud8rRn/DvyXfGPUrfEupKwGjjxeV/KpQ0F+
         DbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fgc4HxmdEdNTRUgxx6D1tte3hSHFOUJ+zE0fY7Bkc7A=;
        b=P0SMNnOgysk2a0S63hyJJW7nlU1nBWLHfqSspjoEDS0BD4PARgOmnMIpejNCh2DXd0
         CZj47D4M4CEr9jdlscO2GdsRDOWC2EETHTAR0h/BFkVAphBpcW08ebzEtV+LNYbT9G3X
         SmkqbM0iF3dLa98z1xFploExuKP2BloijLxBko3M/V7zhVFf2h+sD92KXV0QsCNOSle2
         iDGZ5f01s9saQcjuFwpmmVTMXywN8Tt51aYiT89rDkH3fFaYjXly3U+N90QICRpvmBeh
         SoyuPHkAoo/PKBnhvBy3c7fPv9v30HwVLLiu1hujPchEC4hi4Kad9qGiY+uf0kC6vlPC
         ihMQ==
X-Gm-Message-State: AOAM5320xmGQTMTv1j/S/1dQ9CSC+Wr/FPU0pWtzOG5srtXCUaOeXBsP
        3nh4sU+r6Qo6YeM5K4qt7gqDqf3rsuvwzI1Zi+R86SSUHOw=
X-Google-Smtp-Source: ABdhPJyfoEh4mSloDQ6Jy1Gc/FcgK6mSrHPw0MSu4X5zk0xIQ9mvBamuWFRNK9kWwGJe1tWCOusRatd6xKZj8EPVVys=
X-Received: by 2002:aa7:c6c3:0:b0:425:b13b:94f with SMTP id
 b3-20020aa7c6c3000000b00425b13b094fmr21035701eds.313.1652159559660; Mon, 09
 May 2022 22:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAN9vWDLY24LEY-zhBSNVRTPBqbYQd+D62av0jKK_BqMvwt5-ig@mail.gmail.com>
 <CAEf4Bza6Ks-FGAGkLCGhK1KEDRdtqv==y7nN63KejF829XQtfA@mail.gmail.com>
In-Reply-To: <CAEf4Bza6Ks-FGAGkLCGhK1KEDRdtqv==y7nN63KejF829XQtfA@mail.gmail.com>
From:   Michael Zimmermann <sigmaepsilon92@gmail.com>
Date:   Tue, 10 May 2022 07:12:28 +0200
Message-ID: <CAN9vWD+6SBQtQqxZ__bvqJ8MsrOUr4cfQcU99at1XVPSUiOsmw@mail.gmail.com>
Subject: Re: BPF maps don't work without CONFIG_TRACING/CONFIG_FTRACE
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thank you for your answer.
What I'm ultimately trying to do is: Use aya-rs to watch egress on a
network interface and notify userspace through a map (for certain IPs
only).

In my actual use case, the userspace is supposed to do more complex
stuff but for testing I simply logged the receival of a message
through the BPF map on the console. And that is what I expect to
happen and which does happen as long as CONFIG_TRACING/CONFIG_FTRACE
are active. If not, I simply never receive any messages on any map.

I've also tried this using an XDP program which sends a message every
time it sees a packet. And while the program seemed to be
working(since it did block certain traffic), I never saw any data in
the map when those configs were disabled.

Also, I'm giving you two configs(tracing and ftrace) since the other
one seems to get y-selected automatically if one of them is active.

On Tue, May 10, 2022 at 2:00 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, May 3, 2022 at 2:40 AM Michael Zimmermann
> <sigmaepsilon92@gmail.com> wrote:
> >
> > Hi,
> >
> > I'm using a kernel which has TRACING and FTRACE disabled and it looks
> > like BPF programs are unable to communicate with usespace.
> > I've reproduced this on aarch64 and x86_64 with both aya-rs's XDP
> > sample and bcc's "tc_perf_event.py" sample. bcc's sample uses
> > BPF_PERF_OUTPUT instead of maps though.
> >
> > Everything seems to run and work correctly, but there's no data being
> > send to userspace resulting in no log output.
> > Is that expected or am I running into a weird bug here?
> >
>
> You probably need to provide few more details on what you are trying
> to do, what you expect to happen and what's actually happening. As it
> is it's hard to provide any useful help.
>
> > Thanks
> > Michael
