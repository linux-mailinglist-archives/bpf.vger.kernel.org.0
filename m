Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD20064F854
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 09:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiLQIpH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Dec 2022 03:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQIpG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Dec 2022 03:45:06 -0500
X-Greylist: delayed 2673 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 17 Dec 2022 00:45:05 PST
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E5D17E1A;
        Sat, 17 Dec 2022 00:45:05 -0800 (PST)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 2BH8ijR4006775;
        Sat, 17 Dec 2022 17:44:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2BH8ijR4006775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1671266686;
        bh=LHeucGCPwMdgCGBwHWBUilHEHkQaQRZPEHaHIlGQdN8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lE0+CsG52o3f20fEyTU9yUtd7iYk9Bn/HQQlB6B/Hh9CxI/PI0WoYU7oVKZgm+dUJ
         SFFOrSdQIgkUaYCvK1VFXYqXvh7rXFdv2SmPWsHqPBsu/rmxDBu6eRCcg48phX8kwa
         zMuq4Ghq2bpYWwQlmgvTzGTFnR2PHOOoWDcSNQlU3dt5K9AQdosviNl0PBEtJfcgbN
         hnBUSR2wCnJKdyPd5DUDlo0USZSip/wIaU6/2tZ49tKlsmHm8wd6JiQfHM81Jm7EIY
         TGI4uaqHPboOhd8l4Nw4VlT4zXC6gmUxY3cX6SSfBvczbD7YtmeLGoErB8hjLqySxP
         a8ijgeQmRFXaw==
X-Nifty-SrcIP: [209.85.160.54]
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-14449b7814bso6070130fac.3;
        Sat, 17 Dec 2022 00:44:46 -0800 (PST)
X-Gm-Message-State: AFqh2krVXPygpEy4gqObiMu7PKBGnK02/EsB73de9Q+YWpE4WPPOUmqU
        hoYjmOp8p6rgmlPf6IANTGxFPuCvfy5TJ1GXCAU=
X-Google-Smtp-Source: AMrXdXvP1ofd0t5v1b6rbg3fmaf6LHIaqutyPKXmOtf3qP7yg5FU0tS0EUKDRsQH2AqhAXcv3p2e8+d0UCGUMl6p5mE=
X-Received: by 2002:a05:6871:450d:b0:144:a2de:1075 with SMTP id
 nj13-20020a056871450d00b00144a2de1075mr581546oab.194.1671266685319; Sat, 17
 Dec 2022 00:44:45 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNASM6KsrXHXLykaQ=rJ3YZ5OA+7im4=g=3Ob3EPt97n_HQ@mail.gmail.com>
 <tencent_6B46BD116F0C168438B3982F0F546C5F6709@qq.com>
In-Reply-To: <tencent_6B46BD116F0C168438B3982F0F546C5F6709@qq.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 17 Dec 2022 17:44:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNASu6i9V4b_u68azpM45zPM0udGW8kVWGd+UZzJtSq0+TA@mail.gmail.com>
Message-ID: <CAK7LNASu6i9V4b_u68azpM45zPM0udGW8kVWGd+UZzJtSq0+TA@mail.gmail.com>
Subject: Re: Re: [PATCH] kbuild: Fix compilation error
To:     Rong Tao <rtoax@foxmail.com>
Cc:     bpf@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu, rongtao@cestc.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Dec 17, 2022 at 5:11 PM Rong Tao <rtoax@foxmail.com> wrote:
>
> Yes, It's happen in the mainline kernel.
>
> I pulled the latest code and habitually compiled samples/bpf,
>
> $ git remote get-url origin
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> $ make -C samples/bpf
>
> and the compilation error occurred. I applied this patch and can
> fix this compilation error.




I want you to describe the steps to reproduce the issue from the pristine
source tree instead of printing the URL of your origin.



I prepared a template for you.
Please fill the following 3 square brackets.



$ git log --oneline  -1
 [ Fill the commit hash you are working on ]
$ git clean -dfx

 [ Fill steps between "git clean -dfx" and "make -C samples/bpf" ]

$ make -C samples/bpf
 [ Fill the error message you get ]





-- 
Best Regards
Masahiro Yamada
