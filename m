Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBEB69F8FE
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 17:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjBVQ3P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 11:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjBVQ3O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 11:29:14 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560132A157;
        Wed, 22 Feb 2023 08:29:11 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id ec43so32221759edb.8;
        Wed, 22 Feb 2023 08:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXMSnD0TNrkNwGD3Y9+NOTvS6S1ymasxXdnswLBQDag=;
        b=oVi4FXujqyY44krQnwtk++mlPPK6vFaXUeJA/Uoa4WRHPRcko3+m1sUzKOn1kV8NXR
         8Q1T2j0HqwqWbec0G389VVRj537zf40l1BtRRXPj10kEw2SuwKutTDvUyuNNBt+fHJej
         sX3HcidV51yGghhvlYWQ2ZH4WG8UTW9QEt1BZMetZg/cyh3xF1BajXnx8RPdamXpYYy2
         FFNqeAiwSKZWcIEh9Sq6F3rs/FD+lykIAZnNI7VhxBsNDMJZLDUtSZy9gC3mwKtT9KMv
         2suXgoFFDPiO3bHwLmbtc03XMFvvChzB/Uo4dSV/RiWZDj9Cvry08RNl66sB3JG6e/Ge
         XmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXMSnD0TNrkNwGD3Y9+NOTvS6S1ymasxXdnswLBQDag=;
        b=wPx+kJ67QQpqloA6L/UU3ArvIzYnlOGsOjPso0NqAfvDhxVJpM1gOKajEuecgmnBtZ
         Sz67kZ3PEw7Xe6zFPoxJyf5TDxfz3fxpcjvCwOxmE1VLKbckykPRTpNdzFxBRLOEkH14
         CE36mxObL6MgP7hmXWWsXrr2rLdWLe/I1aX0IZnT44yOK86QJlIebiAPymUFZrcMBuPm
         c3ZXy1afif5ftaOcyuyZQTLzuOZ1gOrv+lUYlTyog0VRT1hK03CzWVpAbtYiIwI96aTa
         dp/Q/5XxtQRU4Rjk1tplMRdBEwfq6C+XclmgEzwTq7pQSBpxl93OZFXWrEltSr8Qim86
         PREg==
X-Gm-Message-State: AO0yUKXfNnVXS+FV/eY2xJPQGs5KeMoohm+lv93hmu7frrEfn/bGGDVY
        tBSnLBnIQEeN4/NUoj+TP5xJF7arAO8z07EPk7U=
X-Google-Smtp-Source: AK7set99PBOT7bUquNmD5zN1zb4oeyIA44DqoRzzd+9HOUdTkllqn71L3NRU1cNFf/rVM7Cvky0CKlON9Ll/FEVQ8tg=
X-Received: by 2002:a17:906:dfe8:b0:895:58be:963 with SMTP id
 lc8-20020a170906dfe800b0089558be0963mr8142846ejc.3.1677083349630; Wed, 22 Feb
 2023 08:29:09 -0800 (PST)
MIME-Version: 1.0
References: <9c476aa64c9588205817833dbaa622f87c0e0081.1677051600.git.viresh.kumar@linaro.org>
 <CAMuHMdXd3876o+petD51xfnJRBOOg=oqkO_pdsmcr8=Uec2KDg@mail.gmail.com> <7189da9a-f634-01ae-194d-a4d14a319a1c@intel.com>
In-Reply-To: <7189da9a-f634-01ae-194d-a4d14a319a1c@intel.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 22 Feb 2023 08:28:58 -0800
Message-ID: <CAADnVQKX0ZD=8Xu4U2H_vbyuNoXJv0UZ1OffUtqw3vs0v95ELQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix undeclared function 'barrier_nospec' warning
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 22, 2023 at 7:33 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/22/23 07:03, Geert Uytterhoeven wrote:
> > On Wed, Feb 22, 2023 at 9:26 AM Viresh Kumar <viresh.kumar@linaro.org> =
wrote:
> >> Add the missing header for architectures that don't define
> >> the barrier_nospec() macro. The nospec.h header is added after the
> >> inclusion of barrier.h to avoid redefining the macro for architectures
> >> that already define barrier_nospec() in their respective barrier.h
> >> headers.
> >>
> >> Fixes: 74e19ef0ff80 ("uaccess: Add speculation barrier to copy_from_us=
er()")
> >> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >> ---
> >> Linus's master branch fails currently to build for arm64 without this =
commit.
> > Not just arm64 =F0=9F=99=81
> > http://kisskb.ellerman.id.au/kisskb/head/5b7c4cabbb65f5c469464da6c5f614=
cbd7f730f2
>
> Thanks for the fix, and sorry for the breakage, folks!  Obviously:
>
> Tested-by: Dave Hansen <dave.hansen@linux.intel.com>
>
> Now time to go make sure I have bpf turned on in all my cross builds.

Not clear why the broken commit got applied bypassing bpf@vger and not
going through BPF CI. :(

Yesterday I applied pretty much the same fix from Huacai Chen.

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=3D34=
5d24a91c79f408e355c8b7e873ccde0f097eea

and BPF CI is now back to green.

Linus,
Since the blast radius is big, may be apply the fix directly ?
