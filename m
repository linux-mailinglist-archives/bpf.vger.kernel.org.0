Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497EE611A66
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 20:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJ1SqZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Oct 2022 14:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJ1SqY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Oct 2022 14:46:24 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A2924473E
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 11:46:23 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id o2so3405228ilo.8
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 11:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BUEnwbILm0RrJRzh9nhTtkoyV8KawPDkBr+FO7E6eJE=;
        b=OEM2S29VlPFvaBDNRnimgr7+Djgx9aWzQzINf/4SJFAFzJKspkkVK+HCj941UhQN3o
         yliKmaPXljYuNcyqLBOIZAjhEmHwPw2Pw4nkn4yJkWNwgAP8tQIqoiCK6LDyErbi+dGm
         a4yIvu0p/RXgIBWcbe53jaSxwmnTcdbsBNZwLExc2wVY8uCnIR5tRq+fGutFJBRbhpRA
         AwJvGfMs9IBszPsqi1IUXZaO4bDrX6W+wI6RzQmtpK67ZVPA2fucmMT3nft0y6g5LyRa
         Q8RuwYHjGlGPxQGAyS6KMkqRxq8JFxkC2U2cBtTZoZMfy/tpzX/LDgtbMxpLYu7e/qgT
         nPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUEnwbILm0RrJRzh9nhTtkoyV8KawPDkBr+FO7E6eJE=;
        b=fEDrO3Q5jibYmk/cgfIsaIXY5K1XBrsaB/K7hAR5AqONedIacH/FrG9r4jLHJOHfnL
         CYmhdMOz2drb2g+HFQcn0Tzgu5oXHfV0u78VgALtThGC5p/S647kAZG3dp8NzBcQMLOM
         NlHOJ7fbpYyGlySBJ8Da6CZif8FX/zSH2P1sK335XX1s5Wjn+MdQX9UTJ+AH7SgvVTJh
         JsuSnilrKKSP8ywsFxh0wUuQjraSpguRNU2iZ9/5VzJ2aB2vQfB0NNVRs1rVhf0qWkLF
         OTGU8naX6U+r4azCkHBQUAuk6QM+ZtsV7/mbI2QvQbhIbs7YthyugXWhzepOJ2AZj/w8
         D5pA==
X-Gm-Message-State: ACrzQf0OQ7gPAjXaY6dBj3W3PVTryXJ33lOjaBW7naawqUg3cYEyXHdK
        UFZrJHddkcBl7j6FkQwZnHTy3pyohbznJpJ8grkfK0muAtiPGA==
X-Google-Smtp-Source: AMsMyM7TkTJ2M4RZSOD8R2Q4DzOTMnQMjO6dzfuwFlSN8Qvuombxc6lZqxZlnL+93s+O4iRzdw7XCcXueJVfbeUL8zw=
X-Received: by 2002:a92:db03:0:b0:300:5dc4:d111 with SMTP id
 b3-20020a92db03000000b003005dc4d111mr365055iln.257.1666982782376; Fri, 28 Oct
 2022 11:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221027200019.4106375-1-sdf@google.com> <635bfc1a7c351_256e2082f@john.notmuch>
 <20221028110457.0ba53d8b@kernel.org>
In-Reply-To: <20221028110457.0ba53d8b@kernel.org>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 28 Oct 2022 11:46:11 -0700
Message-ID: <CAKH8qBshi5dkhqySXA-Rg66sfX0-eTtVYz1ymHfBxSE=Mt2duA@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/5] xdp: hints via kfuncs
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Oct 28, 2022 at 11:05 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 28 Oct 2022 08:58:18 -0700 John Fastabend wrote:
> > A bit of extra commentary. By exposing the raw kptr to the rx
> > descriptor we don't need driver writers to do anything.
> > And can easily support all the drivers out the gate with simple
> > one or two line changes. This pushes the interesting parts
> > into userspace and then BPF writers get to do the work without
> > bother driver folks and also if its not done today it doesn't
> > matter because user space can come along and make it work
> > later. So no scattered kernel dependencies which I really
> > would like to avoid here. Its actually very painful to have
> > to support clusters with N kernels and M devices if they
> > have different features. Doable but annoying and much nicer
> > if we just say 6.2 has support for kptr rx descriptor reading
> > and all XDP drivers support it. So timestamp, rxhash work
> > across the board.
>
> IMHO that's a bit of wishful thinking. Driver support is just a small
> piece, you'll have different HW and FW versions, feature conflicts etc.
> In the end kernel version is just one variable and there are many others
> you'll already have to track.
>
> And it's actually harder to abstract away inter HW generation
> differences if the user space code has to handle all of it.

I've had the same concern:

Until we have some userspace library that abstracts all these details,
it's not really convenient to use. IIUC, with a kptr, I'd get a blob
of data and I need to go through the code and see what particular type
it represents for my particular device and how the data I need is
represented there. There are also these "if this is device v1 -> use
v1 descriptor format; if it's a v2->use this another struct; etc"
complexities that we'll be pushing onto the users. With kfuncs, we put
this burden on the driver developers, but I agree that the drawback
here is that we actually have to wait for the implementations to catch
up.

Jakub mentions FW and I haven't even thought about that; so yeah, bpf
programs might have to take a lot of other state into consideration
when parsing the descriptors; all those details do seem like they
belong to the driver code.

Feel free to send it early with just a handful of drivers implemented;
I'm more interested about bpf/af_xdp/user api story; if we have some
nice sample/test case that shows how the metadata can be used, that
might push us closer to the agreement on the best way to proceed.



> > To find the offset of fields (rxhash, timestamp) you can use
> > standard BTF relocations we have all this machinery built up
> > already for all the other structs we read, net_devices, task
> > structs, inodes, ... so its not a big hurdle at all IMO. We
> > can add userspace libs if folks really care, but its just a read so
> > I'm not even sure that is helpful.
> >
> > I think its nicer than having kfuncs that need to be written
> > everywhere. My $.02 although I'll poke around with below
> > some as well. Feel free to just hang tight until I have some
> > code at the moment I have intel, mellanox drivers that I
> > would want to support.
>
> I'd prefer if we left the door open for new vendors. Punting descriptor
> parsing to user space will indeed result in what you just said - major
> vendors are supported and that's it.
