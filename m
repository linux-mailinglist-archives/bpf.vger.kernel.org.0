Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596461BD265
	for <lists+bpf@lfdr.de>; Wed, 29 Apr 2020 04:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgD2Co5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Apr 2020 22:44:57 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:48211 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgD2Co4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Apr 2020 22:44:56 -0400
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 03T2iGBG006076;
        Wed, 29 Apr 2020 11:44:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 03T2iGBG006076
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588128256;
        bh=JDmR7sOxWAOl0xZYRbW4YRt3haUZ3+lv4J0EA18vymI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q/yYGad2P24vpHqjYYWp7m2gP2fI2M7oBkWhGlZcKA0Zctu3ZBEqxdMArVF7fWpSe
         njBjqzsnHgQORhBhZJEDFoy8fqA3tJoBszJYr3xotRpYmCUC30JhZi0uZcIZUy1zHR
         iUCdhLLCW91f4y3ntcdz/RLeMcjLthMrswRQCJj82IK93PMGj14iCN/R7t11UaJ22W
         HRikYDzFODh3dKfCx/KZfXilzM6zXgq4Oj2Z1lke92DKB5CNFZ/Ha/4AESK4pHfQ9m
         F+7S8yI13gwCZij88lUV+oPf70Kx2WK9rUyt9dv57e0o6JycxnqloY7peyaMw8LlCJ
         PR8acZl5In0TQ==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id c24so329347uap.13;
        Tue, 28 Apr 2020 19:44:16 -0700 (PDT)
X-Gm-Message-State: AGi0Pubo1vWYI0UF8hYB0p9vlNA69NhQkRAXxG4+/5elJutGgetkanXx
        noVOHZic7sGkBKgrbMD/zPlgNdKz+6VfrWSXaYM=
X-Google-Smtp-Source: APiQypIic2qLjnYXcUQFI9eAhK3sbWyA8cGUJR3QdnhGvAahYp29unTLMtwRxxKMfhqQS3AFgxecNxBdWnBpeP30lS4=
X-Received: by 2002:ab0:1166:: with SMTP id g38mr24264521uac.40.1588128255296;
 Tue, 28 Apr 2020 19:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200423073929.127521-1-masahiroy@kernel.org> <20200423073929.127521-3-masahiroy@kernel.org>
 <20200424203231.b4lonbdgzkoxf7ug@treble>
In-Reply-To: <20200424203231.b4lonbdgzkoxf7ug@treble>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 29 Apr 2020 11:43:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNATrGDegfn2j5gmHTSj8V=Wd53SpLqG4-T1gfn3j19mEtg@mail.gmail.com>
Message-ID: <CAK7LNATrGDegfn2j5gmHTSj8V=Wd53SpLqG4-T1gfn3j19mEtg@mail.gmail.com>
Subject: Re: [PATCH 02/16] Revert "objtool: Skip samples subdirectory"
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 25, 2020 at 5:32 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Thu, Apr 23, 2020 at 04:39:15PM +0900, Masahiro Yamada wrote:
> > This reverts commit 8728497895794d1f207a836e02dae762ad175d56.
> >
> > This directory contains no object.
> >
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  samples/Makefile | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/samples/Makefile b/samples/Makefile
> > index f8f847b4f61f..5ce50ef0f2b2 100644
> > --- a/samples/Makefile
> > +++ b/samples/Makefile
> > @@ -1,6 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  # Makefile for Linux samples code
> > -OBJECT_FILES_NON_STANDARD := y
> >
> >  obj-$(CONFIG_SAMPLE_ANDROID_BINDERFS)        += binderfs/
> >  obj-$(CONFIG_SAMPLE_CONFIGFS)                += configfs/
> > --
> > 2.25.1
>
> Hm, somehow I was thinking this would work recursively for
> subdirectories.  Anyway, you're right:
>
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
>
> --
> Josh
>

Applied to linux-kbuild.


-- 
Best Regards
Masahiro Yamada
