Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5083D65DB
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 19:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhGZQzP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 12:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhGZQzP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Jul 2021 12:55:15 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A0AC061757
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 10:35:42 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id o5so17726528ejy.2
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 10:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jWYryqPqaeokAftPRoukk0ARkpcE4AzaVLrtIEz6sC4=;
        b=GcveJMQpbaFnSCNuFk/BOrotbsnPsBIVlEqQUhQD3JsJ3Ly0M5YlVmK0xIChWw9rbu
         GLrwYFZwmFx68WdL1CSCYLwPInfVlchLpSL93DlSm87HEHgdSiB8aAT83Vp/d9Ba68B/
         PSQ+bLALjclygphpmhFdogrpYeKyZpjCybg5cBmlSxc9bGBcR6p0yYSpIFw8QRH7J+vs
         v20BNLo84hzcV9rU32Vxa0tiyXoHBh+iCnu0TEdwdeffrjL6AG/LZAsyM7HllxBgFRnn
         vU8iRr7PqZG2whk1N3EEZzMagyZludn9WxhWD06fiBDCRfmLDleq4sJ9+2lQx/QR7V7C
         iVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jWYryqPqaeokAftPRoukk0ARkpcE4AzaVLrtIEz6sC4=;
        b=Bc8JGac8byo0ER7LQsmvdWSeK44qK3r8f97JegvbVESce/HVvQ1gRtWp9D6Mjeo5zn
         yGdeiTmAFBKGNJgPZ6Fq/eclOxAOuELxC4rqz8oyneQS3+gpNpxad8LktUdJi1LBKGxl
         aaQH5KvUMbJbEC2hw1J/yNTc849fNHVRENZLwqe1nF+6McEqSTUnFxtCysm2EUSvgR55
         SiuJW3qmzr/HnkuTMuFyleWGfv3WHw8F1QKI/uoahD0zcDIt2LA9R6tLael5YXmrhnnr
         KHAcFgi6yhpZwYHY5zvO7Dta6m21r1wC5cMqlSgNiGd3dYqFQOIAEaCv+ZRVo9mWZ2bT
         Dt1w==
X-Gm-Message-State: AOAM530I3ERc5ulxHz2Jw1bLP5q7WsG4iLoeh90u4SLzMwb8Ctk3/Q/C
        HNcR3DjDAdOim5g7TO3N2njmj/QlphESVrpVWBs=
X-Google-Smtp-Source: ABdhPJx2OgdULJWFGLsWkcALrrh+/Z/4J+nx+xVPAXvtzYuDLiab1pF9hBV2ceH+RCE0zofiLd68fnK5w56Tt8J0eds=
X-Received: by 2002:a17:907:3e03:: with SMTP id hp3mr16224526ejc.183.1627320941275;
 Mon, 26 Jul 2021 10:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <a1ae15c8-f43c-c382-a7e0-10d3fedb6a@gmail.com> <CAK3+h2z+V1VNiGsNPHsyLZqdTwEsWMF9QnXZT2mi30dkb2xBXA@mail.gmail.com>
 <8af534e8-c327-a76-c4b5-ba2ae882b3ae@gmail.com> <7ba1fa1f-be6-1fa2-1877-12f7b707b65@gmail.com>
 <441e955a-0e2a-5956-2e91-e1fcaa4622aa@fb.com> <CAK3+h2w=CO8vvo_Td=w08zKxfko1DA96xk4fvCXvUA1wLZvOMA@mail.gmail.com>
 <e1a2904f-1b43-e1a8-e20d-0449798274bb@fb.com> <CAK3+h2z=qxzDm=-isjuM01n8Mt5NpoAHCkwHNzOWFXNMAczUdw@mail.gmail.com>
In-Reply-To: <CAK3+h2z=qxzDm=-isjuM01n8Mt5NpoAHCkwHNzOWFXNMAczUdw@mail.gmail.com>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Mon, 26 Jul 2021 10:35:30 -0700
Message-ID: <CAK3+h2yDOFAK8bNQu4Y_=O_QGQ3CrMd0NSrGahv3NXbJkDB92Q@mail.gmail.com>
Subject: Re: Prog section rejected: Argument list too long (7)!
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jul 25, 2021 at 8:49 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
>
> On Sun, Jul 25, 2021 at 7:39 PM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 7/25/21 6:14 PM, Vincent Li wrote:
> > > On Sun, Jul 25, 2021 at 6:01 PM Yonghong Song <yhs@fb.com> wrote:
> > >>
> > >>
> > >>
> > >> On 7/25/21 8:22 AM, Vincent Li wrote:
> > >>>
> > >>>
> > >>>
> > >>> On Sat, 24 Jul 2021, Vincent Li wrote:
> > >>>
> > >>>>
> > >>>>
> > >>>> On Sat, 24 Jul 2021, Vincent Li wrote:
> > >>>>
> > >>>>> On Fri, Jul 23, 2021 at 7:17 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
> > >>>>>>
> > >>>>>>
> > >>>>>> Hi BPF experts,
> > >>>>>>
> > >>>>>> I have a cilium PR https://github.com/cilium/cilium/pull/16916 that
> > >>>>>> failed to pass verifier in kernel 4.19, the error is like:
> > >>>>>>
> > >>>>>> level=warning msg="Prog section '2/7' rejected: Argument list too long
> > >>>>>> (7)!" subsys=datapath-loader
> > >>>>>> level=warning msg=" - Type:         3" subsys=datapath-loader
> > >>>>>> level=warning msg=" - Attach Type:  0" subsys=datapath-loader
> > >>>>>> level=warning msg=" - Instructions: 4578 (482 over limit)"
> > >>>>>> subsys=datapath-loader
> > >>>>>> level=warning msg=" - License:      GPL" subsys=datapath-loader
> > >>>>>> level=warning subsys=datapath-loader
> > >>>>>> level=warning msg="Verifier analysis:" subsys=datapath-loader
> > >>>>>> level=warning subsys=datapath-loader
> > >>>>>> level=warning msg="Error filling program arrays!" subsys=datapath-loader
> > >>>>>> level=warning msg="Unable to load program" subsys=datapath-loader
> > >>>>>>
> > >>>>>> then I tried to run the PR locally in my dev machine with custom upstream
> > >>>>>> kernel version, I narrowed the issue down to between upstream kernel
> > >>>>>> version 5.7 and 5.8, in 5.7, it failed with:
> > >>>>>
> > >>>>> I further narrow it down to between 5.7 and 5.8-rc1 release, but still
> > >>>>> no clue which commits in 5.8-rc1 resolved the issue
> > >>>>>
> > >>>>>>
> > >>>>>> level=warning msg="processed 50 insns (limit 1000000) max_states_per_insn
> > >>>>>> 0 total_states 1 peak_states 1 mark_read 1" subsys=datapath-loader
> > >>>>>> level=warning subsys=datapath-loader
> > >>>>>> level=warning msg="Log buffer too small to dump verifier log 16777215
> > >>>>>> bytes (9 tries)!" subsys=datapath-loader
> > >>
> > >> The error message is "Log buffer too small to dump verifier log 16777215
> > >> bytes (9 tries)!".
> > >>
> > >> Commit 6f8a57ccf8511724e6f48d732cb2940889789ab2 made the default log
> > >> much shorter. So it fixed the above log buffer too small issue.
> > >>
> > >
> > > Thank you for the confirmation, after I remove 'verbose' log, indeed
> > > the problem went away for kernel 5.x- 5.8, but the
> > > "Prog section '2/7' rejected: Argument list too long.." issue
> > > persisted even after I remove the "verbose" logging
> > > for kernel version 4.19, any clue on that?
> >
> > No, I don't.
> >
> > You need to have detailed verifier log. In verifier, there are quite
> > some places which returns -E2BIG.
> >
> I will do another round of bisect,  correct myself, the "The argument
> list too long" occurred in 5.1, but not in 5.2

It looks to be this commit fixed the issue
commit c04c0d2b968ac45d6ef020316808ef6c82325a82 (HEAD)
Author: Alexei Starovoitov <ast@kernel.org>
Date:   Mon Apr 1 21:27:45 2019 -0700
    bpf: increase complexity limit and maximum program size

>
> > >
> > >
> > >>>>>> level=warning msg="Error filling program arrays!" subsys=datapath-loader
> > >>>>>> level=warning msg="Unable to load program" subsys=datapath-loader
> > >>>>>>
> > >>>>>> 5.8 works fine.
> > >>>>>>
> > >>>>>> What difference between 5.7 and 5.8 to cause this verifier problem, I
> > >>>>>> tried to git log v5.7..v5.8 kernel/bpf/verifier, I could not see commits
> > >>>>>> that would make the difference with my limited BPF knowledge. Any clue
> > >>>>>> would be appreciated!
> > >>>>
> > >>>> I have git bisected to this commit:
> > [...]
