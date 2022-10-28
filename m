Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4C5611916
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 19:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJ1RSO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Oct 2022 13:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiJ1RSN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Oct 2022 13:18:13 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE376D9E1
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 10:18:12 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id m15so8781030edb.13
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 10:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YJzE1X5uEpZW2wbMCTv/6vFq/t9SZfBtbWwyFR0IkwE=;
        b=iWqw/uzej3Wt2brzrA9hMmjaPyYYifLG/i5c52aNV/vQ8l9GCvADK+uFSla+HHtUlt
         KlhxFPt/NC61bCxoAKrYoMFQUVmWZXAOvpUTVk381PvwPZbJq6qFQIfH4LDVrYOgd3Db
         4w1iGHwey+uHIk5vje3Oycvm8U2chTo7sa0Psgniu8CAtKAihw4trl3hKL3eSRHqVdWZ
         Yi+Ei7o8AkqjwBqWl7rsaBcoV5+MpjgLEbQ+X/5MwiOA8vVndTNljfxiry0QGAm9P7Ve
         z61vvw7XrgU4P50bK9PDckyLfqjz6r2aIDcosd6aG7Q/WDj0XUGflXnuUSSNRqC9uVw3
         uvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJzE1X5uEpZW2wbMCTv/6vFq/t9SZfBtbWwyFR0IkwE=;
        b=ljbAD7pikv1dKECXhZHmfOehY8yRtYuOP9nLsjevAtaFnkLidfHW2frIca6IxZL2gB
         VHKjqUXGJ3U5ElbIZqJsEdk/Oaw1j2epGh2M05Rwgghsgy2ucxlsVbtvNiGmDuibrtLN
         OsKyYHbtspDHbsKVbAfq6aeFR0CGts+4QiR5L0RqmIfXbJRYhR8p1TfrDRfQv973pj8j
         rWNxVOa9nfjpc9XBN2OHY9+M1Q1RtDqoIhGtpnbXbT2TYzSmve86FyNTCxi6gwo3OHSD
         MpU2cbbRAMgImp0AYJptK/mTjP/iG4GPX5JeFYEE+nUlR+Q5sXpbSPjILxAEYQDd7gfc
         kDJg==
X-Gm-Message-State: ACrzQf2CpFTbSveRCumH/Za3sVU8i7zFz6+4JJB94b4kMB/3f2vO54Dp
        CT95JgJ2dHN7iAa46R4YPShABVMg3W8ajzjwHpI=
X-Google-Smtp-Source: AMsMyM6LIb7G1iw7ov8Ox+F3zxmGcRqroS1AoOWIMiVY8x0sAQxqouyBHbnaSMrRpnqR5MoGHy99DTQO9U6pZtSIS/U=
X-Received: by 2002:aa7:c2ca:0:b0:461:89a6:2281 with SMTP id
 m10-20020aa7c2ca000000b0046189a62281mr477359edp.260.1666977490943; Fri, 28
 Oct 2022 10:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
 <21be7356-8710-408a-94e3-1a0d3f5f842e@www.fastmail.com> <CAEf4BzawXPiXY3mNabi0ggyTS9wtg6mh8x97=fYGhuGj4=2hnw@mail.gmail.com>
 <Y1t2OxF3o0mtF1Hm@kroah.com>
In-Reply-To: <Y1t2OxF3o0mtF1Hm@kroah.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 28 Oct 2022 10:17:58 -0700
Message-ID: <CAEf4Bzbdkp4CbXpGvCRSm8DK+SzSPMk9Lf2qtZaRCqkZAZEzEQ@mail.gmail.com>
Subject: Re: Closing the BPF map permission loophole
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Lorenz Bauer <oss@lmb.io>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 27, 2022 at 11:26 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 27, 2022 at 09:54:57AM -0700, Andrii Nakryiko wrote:
> > But first, two notes.
> >
> > 1) Backporting this is going to be hard, and I don't think that should
> > be the goal, it's going to be too intrusive, probably.
>
> Don't worry about backporting when doing your work.  Get it correct
> first, and let others worry about any backporting if it's even needed.
>

Yep, I agree, thanks, Greg!

I was pointing this out here explicitly because during previous
discussions the "backportability" aspect was a distraction and reason
for miscommunication issues and I wanted to get that out of the way.

> thanks,
>
> greg k-h
