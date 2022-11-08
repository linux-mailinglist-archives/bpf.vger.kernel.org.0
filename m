Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C518621F91
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 23:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiKHWxr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 17:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiKHWxq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 17:53:46 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB722CC9D
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 14:53:45 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id cb2-20020a056830618200b00661b6e5dcd8so9206391otb.8
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 14:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=knuha/0L3whh8nT50lR2ItuT1EONyZVV+ouqJ68QHZA=;
        b=i4I18xsZKajr58O29V/LVujDoAOrDQYT3U7wdkvIrXpZbp9Ca5Qiz8midqU94kQUvG
         gK76lIwmEix693nERMwMD6nG3KorWFLH/s/CHOQz//303Bvnm/tfoXivbxi1i0o4jXIW
         2PpsEz25qapySiXRBuCGz0aZYcfaU3D4FmlWh/TFh79GWt/Qdepu0al2QH59vWvwGs4c
         Z7YlYsstqw5pFYtTap3ya3+HLSnjPu9tsI7N6wdqLiA9XSmiUJ1OcG7JqNjiT75YOeFf
         XAd96YEsw7RXoFHQ25QlPlf9bi+lKbkUfmFPwU1ozWFnU1kt5PEaDyFAGAt5ZwuaAyTD
         Hzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=knuha/0L3whh8nT50lR2ItuT1EONyZVV+ouqJ68QHZA=;
        b=K/pMXLyk8RHWiPNdu9X0izF2r5T0jj5AFTqL4eh6rMeJt+m6M588qignBDTnUy6pa+
         LCgzV17QDF9xOGxAO7R8Prw45XKY2JzTkcd4uuBdt85ikj1WZO8T3B3NzHgahm60peSA
         YDx+Fy/tq61J8TwpZ9dGP//avBMsctKepsflV3adaC2bjxS1snSc70ovbiA3QWuXEilR
         /b6l2K5gdPcXJKw8k75MftM8OL+PbqpQe8e6timRSVURWPaQ4ADGFxTv8QZ728ypRUoH
         hCXt+jK1iF1JUeebRoNiqqaB0YGsfH4Vl7IuVah2U95VmodMWzexhBL5qSq8JU9Y+/rT
         YMuQ==
X-Gm-Message-State: ACrzQf01OcEJqbav9/vy9R49iyi/E2ypLZvzfJPKTUZHmPcwJN8cbJPg
        ZarP9VvtrzQ7dRFC7kpmf78KI6od2dlHpGK9EFifOQ==
X-Google-Smtp-Source: AMsMyM6sbyW4Z90a1WvOaiYwAlYDgogLA5zn3UR3LNLstqEXoVzvOwGScU2a4MAsLERATJ/u37KNdb+1huwgmhmZXno=
X-Received: by 2002:a9d:62d8:0:b0:66c:4f88:78ff with SMTP id
 z24-20020a9d62d8000000b0066c4f8878ffmr23580029otk.269.1667948024724; Tue, 08
 Nov 2022 14:53:44 -0800 (PST)
MIME-Version: 1.0
References: <000000000000dc81b705a0af279c@google.com> <000000000000564bd705ecdf291f@google.com>
In-Reply-To: <000000000000564bd705ecdf291f@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 8 Nov 2022 14:53:34 -0800
Message-ID: <CACT4Y+bnN7oZp2WJf+Jcx8+de1roOdLB=f_Zu+0H4UHEkfcO8A@mail.gmail.com>
Subject: Re: [syzbot] WARNING in bpf_check (3)
To:     syzbot <syzbot+245129539c27fecf099a@syzkaller.appspotmail.com>
Cc:     andrii@kernel.org, andriin@fb.com, ast@kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        daniel@iogearbox.net, davem@davemloft.net, haoluo@google.com,
        hawk@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org,
        kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        martin.lau@linux.dev, memxor@gmail.com, nathan@kernel.org,
        ndesaulniers@google.com, netdev@vger.kernel.org, sdf@google.com,
        shanavas@crystalwater.ae, song@kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        trix@redhat.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 7 Nov 2022 at 02:48, syzbot
<syzbot+245129539c27fecf099a@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 34dd3bad1a6f1dc7d18ee8dd53f1d31bffd2aee8
> Author: Alexei Starovoitov <ast@kernel.org>
> Date:   Fri Sep 2 21:10:47 2022 +0000
>
>     bpf: Relax the requirement to use preallocated hash maps in tracing progs.
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1232e176880000
> start commit:   506357871c18 Merge tag 'spi-fix-v6.0-rc4' of git://git.ker..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1b95a17a5bfb1521
> dashboard link: https://syzkaller.appspot.com/bug?extid=245129539c27fecf099a
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10940477080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177e8f43080000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: bpf: Relax the requirement to use preallocated hash maps in tracing progs.
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable based on the subsystem and the patch:

#syz fix:
bpf: Relax the requirement to use preallocated hash maps in tracing progs.
