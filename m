Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F8D6EED16
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 06:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239363AbjDZEtm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 00:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239339AbjDZEtl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 00:49:41 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2B826AB
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 21:49:36 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a66888cb89so52562305ad.3
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 21:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682484575; x=1685076575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q87RPXE6DI0eKRLmsGLLiia6SM1aDcMrG91sJC9XiNc=;
        b=JRGC94+4PwQd6bj+bhMJ0luv77EUyXGXDPWLgjM+9V5XYwVSoDJsyG/MNujIHT3wMU
         xnqxxjhnlc52TYDsWIGO7u9ZKOE67uPf20AzGUTi6bDwdSGfRczZFPkhbkgd+6uAS5un
         f/CRZaDq5DKbiW8pq5UmoMX6r/dM2KCv99OmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682484575; x=1685076575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q87RPXE6DI0eKRLmsGLLiia6SM1aDcMrG91sJC9XiNc=;
        b=CEc2GE7fFRIkMMeR0/CJlkgtwJEMjUvS8cpkhqa4kdhf6xoKdkwXiBkscIbmEKJzTw
         1B9Q0DOAUJJy59Av6hK930bizycjwQ5EqD0xCgRhm6FqUywudDmjmK8NWQW9jgv022wm
         dhdH8kd/ySKjbeSJqBPEjS81qPwTlKboBICS/l5a5fwQHyq4gWac9VqYnpf0yo9OMbkC
         SPHxkluB2V8IFDcim69lAjRJxvZqXQv86P1uCNuKtaGxzEsGjpcgYSuqfFAdMNwRIux7
         1vkqIkccbRk6yHLuJxorJ3ewXVMiE/Z+4PfCM+UsrdjQBjWEYYFw8TKgwcPfCDzZRJiU
         iLKw==
X-Gm-Message-State: AAQBX9dYxcIdIMn6nQQPvXvyAQiYQyIraLFViGq+hQ715ikiyHjxApYw
        mc6WwsjX5T/ydJj12J+J0CW3yQ==
X-Google-Smtp-Source: AKy350ZMC1xD9dDoVpHt3Z1nGYL5MHRDxYRmBb0Li+R4+np0wLm8hyHeiS8ybBCDD+HubMTW09NfWw==
X-Received: by 2002:a17:902:a989:b0:1a6:5575:9059 with SMTP id bh9-20020a170902a98900b001a655759059mr18495024plb.62.1682484575457;
        Tue, 25 Apr 2023 21:49:35 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id bt20-20020a17090af01400b00246cfdb570asm10533287pjb.27.2023.04.25.21.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 21:49:34 -0700 (PDT)
Date:   Wed, 26 Apr 2023 13:49:28 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     syzbot <syzbot+d692037148a8169fc9dd@syzkaller.appspotmail.com>
Cc:     alex.gaynor@gmail.com, andriy.shevchenko@linux.intel.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
        bpf@vger.kernel.org, gary@garyguo.net,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        ojeda@kernel.org, pmladek@suse.com, rostedt@goodmis.org,
        rust-for-linux@vger.kernel.org, senozhatsky@chromium.org,
        syzkaller-bugs@googlegroups.com, wedsonaf@gmail.com
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in __dabt_svc
Message-ID: <20230426044928.GD1496740@google.com>
References: <00000000000079eebe05fa2ea9ad@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000079eebe05fa2ea9ad@google.com>
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On (23/04/25 13:06), syzbot wrote:
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference at virtual address 000005fc when read
> [000005fc] *pgd=80000080004003, *pmd=00000000
> Internal error: Oops: 206 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.0-syzkaller #0
> Hardware name: ARM-Versatile Express

> Insufficient stack space to handle exception!

So much stuff is going on there.

> Task stack:     [0xdf85c000..0xdf85e000]
> IRQ stack:      [0xdf804000..0xdf806000]
> Overflow stack: [0x828ae000..0x828af000]
> Internal error: kernel stack overflow: 0 [#2] PREEMPT SMP ARM
> Modules linked in:
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.0-syzkaller #0
> Hardware name: ARM-Versatile Express
> PC is at __dabt_svc+0x14/0x60 arch/arm/kernel/entry-armv.S:210
> LR is at vsnprintf+0x378/0x408 lib/vsprintf.c:2862
> pc : [<80200a74>]    lr : [<817ad5d8>]    psr: 00000193
> sp : df804028  ip : df805868  fp : df805864
> r10: 00000060  r9 : ffffffff  r8 : 00000010
> r7 : 00000020  r6 : 00000004  r5 : ffffffff  r4 : df805960
> r3 : ffffffff  r2 : 00000040  r1 : ffffffff  r0 : 8264d250
> Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 30c5387d  Table: 80003000  DAC: 00000000
> Register r0 information:
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference at virtual address 000001ff when read
> [000001ff] *pgd=80000080004003, *pmd=00000000
> Internal error: Oops: 206 [#3] PREEMPT SMP ARM
> Modules linked in:
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.0-syzkaller #0
> Hardware name: ARM-Versatile Express
> PC is at __find_vmap_area mm/vmalloc.c:841 [inline]
> PC is at find_vmap_area mm/vmalloc.c:1862 [inline]
> PC is at find_vm_area mm/vmalloc.c:2571 [inline]
> PC is at vmalloc_dump_obj+0x38/0xb4 mm/vmalloc.c:4108
> LR is at __raw_spin_lock include/linux/spinlock_api_smp.h:132 [inline]
> LR is at _raw_spin_lock+0x18/0x58 kernel/locking/spinlock.c:154

Not sure if I can make sense out of this.
