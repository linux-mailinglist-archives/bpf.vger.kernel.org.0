Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F256983EF
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 19:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjBOS51 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 13:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjBOS5Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 13:57:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581943BDB5;
        Wed, 15 Feb 2023 10:57:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E41DA61D18;
        Wed, 15 Feb 2023 18:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5690EC433A1;
        Wed, 15 Feb 2023 18:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676487443;
        bh=5sA/GkKB672YgfySlkTvpsgV6jFfW0ewXVzumpKClJ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qUP0g1Y3vKUKJX2u/BfxIK1I2EFwOmujk3pcDIOzBlcbomaqFq/0Lr6C+tI9tXloW
         T22Dyf5Lzdq2jrIS3ujGaHB/oGxv3Ggl3BaAyLn4Nv5JXbC2eMvd66ybaWIkO9ZoHr
         BawRrDM91wmtng4Zg1nUl6RPp6kQSVmB7xW9dQdoV3vVZpmAZOKu26DxDjtu2DVn3c
         ZSCXXNraymAkpSZI2+047+OL9mH+qC7Gq+eVhvAT5E9dPcW6FwPo8U80Idig9XzRg9
         fIBvbtFCYTBi2s/BDO8HMoKuRp/5KabW83GlT655u9WBpYpcaC+KqrXPv3g9pM3PSF
         DJGdYrjtFKUCA==
Received: by mail-lf1-f53.google.com with SMTP id v17so28782004lfd.7;
        Wed, 15 Feb 2023 10:57:23 -0800 (PST)
X-Gm-Message-State: AO0yUKXbbpl2rQTh5fmIw2unEyXL6zBirMz8hAJwzgwmYLZnB7X9qnUi
        tl4RVm/HIpKkYiuMEuHyLgkZJdZL5EVi9LIcDik=
X-Google-Smtp-Source: AK7set8D9UvcPF2NNMQcbWg4CZbyXd3FwtHrjDgfodVpnwH/PgU4hJiVgfzHdeZn0aI103wP3X5ft++Y5Ec496D4TYI=
X-Received: by 2002:ac2:593a:0:b0:4db:4568:6fe9 with SMTP id
 v26-20020ac2593a000000b004db45686fe9mr871517lfi.3.1676487441367; Wed, 15 Feb
 2023 10:57:21 -0800 (PST)
MIME-Version: 1.0
References: <20230210064243.116335-1-jiapeng.chong@linux.alibaba.com>
 <Y+0MsMomkcDBdjNI@chrisdown.name> <Y+0PzlA0LijhfD8R@dev-arch.thelio-3990X> <Y+0VAr21hlIdrxyp@chrisdown.name>
In-Reply-To: <Y+0VAr21hlIdrxyp@chrisdown.name>
From:   Song Liu <song@kernel.org>
Date:   Wed, 15 Feb 2023 10:57:09 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5U2qXa_O46_v-hzWqq5L7bRs6bQe5QGGnMOMzX3y4KgA@mail.gmail.com>
Message-ID: <CAPhsuW5U2qXa_O46_v-hzWqq5L7bRs6bQe5QGGnMOMzX3y4KgA@mail.gmail.com>
Subject: Re: [PATCH] module: Remove the unused function within
To:     Chris Down <chris@chrisdown.name>, mcgrof@kernel.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        ndesaulniers@google.com, trix@redhat.com,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Chris,

On Wed, Feb 15, 2023 at 9:23 AM Chris Down <chris@chrisdown.name> wrote:
>
> +Cc: Song

Thanks for the CC!

>
> Nathan Chancellor writes:
> >On Wed, Feb 15, 2023 at 04:47:44PM +0000, Chris Down wrote:
> >> Jiapeng Chong writes:
> >> > The function within is defined in the main.c file, but not called
> >> > elsewhere, so remove this unused function.
> >>
> >> Huh? It's used by __module_text_address(), no?
> >
> >Not after commit 2ece476a2346 ("module: replace module_layout with
> >module_memory") in -next. This patch should have a fixes tag, even if
> >the warning is currently hidden behind W=1.
>
> Huh, I thought I had checked out latest -next, but must have not done so
> somehow :-) Mea culpa.
>
> If it's only in -next then no Fixes needed, since there's no stable rev yet.
>
> Jiapeng, in future, please make sure to cc the author of related commits when
> reporting stuff like this :-) It helps people to update their patches.
>
> Song, you probably want to update your patch.

Luis, would you prefer a new patch with everything folded in? Or would
you apply the patches on your end?

Thanks,
Song
