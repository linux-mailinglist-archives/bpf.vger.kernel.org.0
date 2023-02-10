Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5571691D50
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 11:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjBJKyE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 05:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjBJKyD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 05:54:03 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8F3126D8
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 02:54:02 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id m2so14732532ejb.8
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 02:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IY4Whe06KZr/dCRKC/k3Pnuiy/Cav2kBFD8hLrrOg8g=;
        b=nY/IGLGNDxwn530xHObj2thmUqHZRExRlPumHRiXuRfiSoGNDPEVEF+L5oTEXv8PcP
         ETbaF/URLWOEk55Yq0H8SNZ5bXxPS/Ze9/GJ9GFYZs9XeTEJ7dl9t9krGUkdAC3wi0WF
         U3t/xZxHsaRWpDmZSXBrwiZnSO7RT+1smDyvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IY4Whe06KZr/dCRKC/k3Pnuiy/Cav2kBFD8hLrrOg8g=;
        b=EKD+qImOXsfcL+Pj+Rf+eWgOAwqJxpn5a4YTVoQOxV5paR/4bwSk6ttPo3IaJfmB4/
         Tc3a5hHU5zN+Ht2AVxLqnWJAhYirrBNgoaI+SIGJlSy5yG43+nvjjrKkCCDCKH/c/qBy
         7zvm0XeH6t/jPxJ/0GTu8BmDj50xXX07Kx06gPKztFerWr2Zaq4d0iJVZTQExNwhEaVB
         I+tbq8g1cgMLQyQKYB43/dsqby1pHdbZfkZZvxwSuUPDmzglZ2cKooVaYl0h6uH0dweY
         jfp1l77KT6ETOKnEV1DxNrWDYsyZVegKBWHbxlIHfy/DcPmZkC6uNTZmz7xnOQhGJV0n
         WtVg==
X-Gm-Message-State: AO0yUKXKOJpvHQTD9vQXz33z7To6aDEh2mGF7RxbtlzUzSX1d8qj/tsn
        ijL6g+xq8RAhbPK93WYIMEZn44dP1eI/VFceWkaJAQ==
X-Google-Smtp-Source: AK7set8xkzxBOD+wDzOrHdqZR4xd8pnPuGMx8oY9OQNbChtJSYSGC6AgESAHznUmU7N13mMocyUpTYWHP03Gt0TCi8c=
X-Received: by 2002:a17:906:7242:b0:889:a006:7db5 with SMTP id
 n2-20020a170906724200b00889a0067db5mr3270379ejk.138.1676026440994; Fri, 10
 Feb 2023 02:54:00 -0800 (PST)
MIME-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com> <CAOQ4uxiyRxsZjkku_V2dBMvh1AGiKQx-iPjsD5tmGPv1PgJHvQ@mail.gmail.com>
 <CA+PiJmRLTXfjJmgJm9VRBQeLVkWgaqSq0RMrRY1Vj7q6pV+omw@mail.gmail.com>
 <2dc5e840-0ce8-dae9-99b9-e33d6ccbb016@fastmail.fm> <CAOQ4uxiBD5NXLMXFev7vsCLU5-_o8-_H-XcoMY1aqhOwnADo9w@mail.gmail.com>
 <283b5344-3ef5-7799-e243-13c707388cd8@fastmail.fm> <CAOQ4uxjvUukDSBk977csO5cX=-1HiMHmyQxycbYQgrpLaanddw@mail.gmail.com>
 <CAJfpegvHKkCn0UnNRVxFXjjnkOuq0N4xLN4WzpqVX+56DqdjUw@mail.gmail.com> <81e010cc-b52b-4b20-8d08-631ce8ca7fad@app.fastmail.com>
In-Reply-To: <81e010cc-b52b-4b20-8d08-631ce8ca7fad@app.fastmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 10 Feb 2023 11:53:50 +0100
Message-ID: <CAJfpegsocoi-KobnSpD9dHvZDeDwG+ZPKRV9Yo-4i8utZa5Jww@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/21] FUSE BPF: A Stacked Filesystem Extension for FUSE
To:     Nikolaus Rath <nikolaus@rath.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>,
        Daniel Rosenberg <drosen@google.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@android.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 10 Feb 2023 at 10:42, Nikolaus Rath <nikolaus@rath.org> wrote:
>
> On Fri, 10 Feb 2023, at 09:38, Miklos Szeredi wrote:
> > On Fri, 3 Feb 2023 at 12:43, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> >> > Thanks a lot Amir, I'm going to send out an invitation tomorrow. Maybe
> >> > Nikolaus as libfuse maintainer could also attend?
> >> >
> >>
> >> Since this summit is about kernel filesystem development, I am not sure
> >> on-prem attendance will be the best option for Nikolaus as we do have
> >> a quota for
> >> on-prem attendees, but we should have an option for connecting specific
> >> attendees remotely for specific sessions, so that could be great.
> >
> > Not sure.  I think including non-kernel people might be beneficial to
> > the whole fs development community.  Not saying LSF is the best place,
> > but it's certainly a possibility.
> >
> > Nikolaus, I don't even know where you're located.  Do you think it
> > would make sense for you to attend?
>
> Hi folks,
>
> I'm located in London.
>
> I've never been at LHS, so it's hard for me to tell if I'd be useful there or not. If there's interest, then I would make an effort to attend.
>
> Are we talking about the event in Vancouver on May 8th?

Yes, that's the one.

I'd certainly think it would be useful, since there will be people
with interest in fuse filesystems and hashing out the development
direction involves libfuse as well.

Here's the CFP and attendance request if you are interested:

  https://events.linuxfoundation.org/lsfmm/program/cfp/

Thanks,
Miklos
