Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730F76EEE74
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 08:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239495AbjDZGkp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 02:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239223AbjDZGko (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 02:40:44 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7659DE62
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 23:40:38 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4efea87c578so7093e87.1
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 23:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682491237; x=1685083237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=26EaJCB4BLLjpmwn+UJgLwabpmkPDEPq9rinV+1slYg=;
        b=VDIVNx8LrwzttePAvdnXS2sDN2anEP+SmBVydC+gTIck5cs4NM01wEgckxFMBH/8DB
         Fj29SrK1x8MLN7v/rA5mQg5Z7ai9GdF/tuYZpKTkAI77zFORov6oyciyadm1vr4xipxM
         n3lY1Dbh0xQ/asAgJJMz3gzsb1oFS2/5DAoftRk3WUOfPehnCVlh0vc9LeOvzWC9Rd6C
         nLX81wAUVKYDjTRmapCXJZjDjvhh1kYV67j4tsJJn5m+CaiwKrThuufoKGxnsnjSyTZ8
         yWH8uUpOy850MNsLVVOCzlwBYW+awdFfPQYzAOUeWf90+uvCsErqJ9gISEvLcHf0bsNJ
         ZepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682491237; x=1685083237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26EaJCB4BLLjpmwn+UJgLwabpmkPDEPq9rinV+1slYg=;
        b=VqKIxP8xL+nWbQdYeAwX51iLrqap3NHmUWII6I/wIAOurCfEFjYSLh4o0/LB5Py1vG
         zaaafddB/LwZNfDwwBuxFc/Y67UfJzbf73rncwp1MLOyIM6MDnKt2INwe+d1XgZl1S/k
         T0OUnT2mnWiThIDD6nxh8h0IHloYjQ84VVWMvm0QC3WKZIa/8mhZimTwqP7SAOtQ1Jak
         c4TF1v2KTh1Czj5ZLV35sGt6/z0jrWbTqD9loXNJuRQ+0nB7HNjd5eKrY6nYBlOXqcDt
         6Upo1MKHCBJKcRCrgMlBbe7eS0f31rbwq/p2jf3hrqL10KAiw6df8CSAzwtgHyeKjt5K
         aNTg==
X-Gm-Message-State: AC+VfDzag3IDteQ956OZMoGGE0G/MLyzWIc59SUE38pRFHhXOHsDNx7p
        ECs1XVQbgzKwqJuWEcGpnBA+5SX3G+WkKVLqzrQ7Hw==
X-Google-Smtp-Source: ACHHUZ5cVNzl395xaBLbIB0gf8rLCrYPuaZPJN0WZn147Mwa5s1vko3C35Ob71ekGdCqtq/gzHms8ZpADoD8xdj8JKI=
X-Received: by 2002:a05:6512:4023:b0:4ea:e5e2:c893 with SMTP id
 br35-20020a056512402300b004eae5e2c893mr65339lfb.1.1682491236524; Tue, 25 Apr
 2023 23:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000079eebe05fa2ea9ad@google.com> <20230426044928.GD1496740@google.com>
In-Reply-To: <20230426044928.GD1496740@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 26 Apr 2023 08:40:23 +0200
Message-ID: <CACT4Y+bJQOYV4_VumkrwobDio8CH-oqT2Wuo4Gzz2+BkX6tqzA@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in __dabt_svc
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     syzbot <syzbot+d692037148a8169fc9dd@syzkaller.appspotmail.com>,
        alex.gaynor@gmail.com, andriy.shevchenko@linux.intel.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
        bpf@vger.kernel.org, gary@garyguo.net,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        ojeda@kernel.org, pmladek@suse.com, rostedt@goodmis.org,
        rust-for-linux@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        wedsonaf@gmail.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 26 Apr 2023 at 06:49, Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/04/25 13:06), syzbot wrote:
> > 8<--- cut here ---
> > Unable to handle kernel NULL pointer dereference at virtual address 000005fc when read
> > [000005fc] *pgd=80000080004003, *pmd=00000000
> > Internal error: Oops: 206 [#1] PREEMPT SMP ARM
> > Modules linked in:
> > CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.0-syzkaller #0
> > Hardware name: ARM-Versatile Express
>
> > Insufficient stack space to handle exception!
>
> So much stuff is going on there.
>
> > Task stack:     [0xdf85c000..0xdf85e000]
> > IRQ stack:      [0xdf804000..0xdf806000]
> > Overflow stack: [0x828ae000..0x828af000]
> > Internal error: kernel stack overflow: 0 [#2] PREEMPT SMP ARM
> > Modules linked in:
> > CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.0-syzkaller #0
> > Hardware name: ARM-Versatile Express
> > PC is at __dabt_svc+0x14/0x60 arch/arm/kernel/entry-armv.S:210
> > LR is at vsnprintf+0x378/0x408 lib/vsprintf.c:2862
> > pc : [<80200a74>]    lr : [<817ad5d8>]    psr: 00000193
> > sp : df804028  ip : df805868  fp : df805864
> > r10: 00000060  r9 : ffffffff  r8 : 00000010
> > r7 : 00000020  r6 : 00000004  r5 : ffffffff  r4 : df805960
> > r3 : ffffffff  r2 : 00000040  r1 : ffffffff  r0 : 8264d250
> > Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > Control: 30c5387d  Table: 80003000  DAC: 00000000
> > Register r0 information:
> > 8<--- cut here ---
> > Unable to handle kernel NULL pointer dereference at virtual address 000001ff when read
> > [000001ff] *pgd=80000080004003, *pmd=00000000
> > Internal error: Oops: 206 [#3] PREEMPT SMP ARM
> > Modules linked in:
> > CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.0-syzkaller #0
> > Hardware name: ARM-Versatile Express
> > PC is at __find_vmap_area mm/vmalloc.c:841 [inline]
> > PC is at find_vmap_area mm/vmalloc.c:1862 [inline]
> > PC is at find_vm_area mm/vmalloc.c:2571 [inline]
> > PC is at vmalloc_dump_obj+0x38/0xb4 mm/vmalloc.c:4108
> > LR is at __raw_spin_lock include/linux/spinlock_api_smp.h:132 [inline]
> > LR is at _raw_spin_lock+0x18/0x58 kernel/locking/spinlock.c:154
>
> Not sure if I can make sense out of this.

+linux-arm-kernel@

I suspect this is some recent arch/arm related corruption.
There are also these similar boot crashes that started happening at
roughly the same time:
https://syzkaller.appspot.com/bug?id=4d697346183db2f86ba2f76acb7d66e7731f88df
https://syzkaller.appspot.com/bug?id=dcd98d67539fe4d0d28d2e655e510569eda6f4de
