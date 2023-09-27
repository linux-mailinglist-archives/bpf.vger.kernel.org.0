Return-Path: <bpf+bounces-10949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832EB7AFED1
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 10:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 52191283F6B
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 08:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1483A14F86;
	Wed, 27 Sep 2023 08:43:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABBBF4E3;
	Wed, 27 Sep 2023 08:43:38 +0000 (UTC)
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C8595;
	Wed, 27 Sep 2023 01:43:36 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 2adb3069b0e04-50335f6b48dso18019447e87.3;
        Wed, 27 Sep 2023 01:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695804214; x=1696409014; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PwtEcAbL6R2gKn5wZ7HYJTbgxFR7juHhIjF0LGuvSDo=;
        b=dhgvuOJybVMiXn7Rmw6l6vwSug730+DY8/Jl+07wN38t1ihHuLRQOoxLPoIePpxbpm
         z3lZp5jQEvDWRv+nJnsgVbrYwiKUj+u/n98senLQ16TOjmYm672vMckN7VicT66T5jia
         d9CjbST5Rbn6WzgQ/12WPf5ojsfFCH3JzMlKSm8q8RvQ5WJg1ZLrp1ZNkyeoIGU0sSys
         LdENPp81XnH07MASCYXtkTIleVTWp7I1bWb5V3a2XYjhFNnTdul1M/i4KgOWDouHe475
         xyF6m2uzkfDD+eSBOEW1G4pt/+gTHiCLNTnHw2POkRpUCStIxyz8+l2qVvQq8Bsm3qyE
         V0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695804214; x=1696409014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PwtEcAbL6R2gKn5wZ7HYJTbgxFR7juHhIjF0LGuvSDo=;
        b=I6+46LChNb2zMMCbE3lQ54OZkb/BUcPqhrpH98CIJzzkdIaj34lXP1D6KpjwKJtqxx
         rQj0eJ9QdwdZF9RrdEhuo0KwkPBAnu2IaNYdVH5Oj1UbQhkLXIK0dD2L44e4C/d/cCVS
         UKMVzxqLgLCPTnhdaIVB978pBiY+RZnFU8UmarBJTr5hmODVpdheqWVaJONE3K8sFzIM
         pzmznoodZDug/mY5s0a0Oq+o2PmR8rqEnIbPzsVE+RoeL50cY5WJk/iQ0YAgZktGhzfO
         ipQn1Qwaax1vm02j0taOWW6xDuOr3d6b/VTyAvnnTm0/UeMHaP7C4lEupGfD8kOvgXJV
         dXTA==
X-Gm-Message-State: AOJu0YwZddO5y8NQrycg5AFyCq7asN1Qqwgq2vS8+QLl1Dxt1dLxlXbL
	tFfdFEIqp6AmYOqGL9sOLpYGu2UkPUzuidDZrDWhvSbDPKPItw==
X-Google-Smtp-Source: AGHT+IGcfm2JF31Iyspin6t059Z3BrG3GH0t/qYEEp4LUmG/0L19fMUfVK0aUGnB8TgBPPBhNj/XP1UHq2AkzLCbSaQ=
X-Received: by 2002:a05:6512:2356:b0:503:3447:b704 with SMTP id
 p22-20020a056512235600b005033447b704mr1488775lfu.0.1695804214187; Wed, 27 Sep
 2023 01:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABcoxUaT2k9hWsS1tNgXyoU3E-=PuOgMn737qK984fbFmfYixQ@mail.gmail.com>
In-Reply-To: <CABcoxUaT2k9hWsS1tNgXyoU3E-=PuOgMn737qK984fbFmfYixQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 27 Sep 2023 10:42:57 +0200
Message-ID: <CAP01T74Axm22TTXSaphxZLF=mj7=PnN2SPB98UvWvGR4FW2U9Q@mail.gmail.com>
Subject: Re: Possible kernel memory leak in bpf_timer
To: Hsin-Wei Hung <hsinweih@uci.edu>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 27 Sept 2023 at 07:32, Hsin-Wei Hung <hsinweih@uci.edu> wrote:
>
> Hi,
>
> We found a potential memory leak in bpf_timer in v5.15.26 using a
> customized syzkaller for fuzzing bpf runtime. It can happen when
> an arraymap is being released. An entry that has been checked by
> bpf_timer_cancel_and_free() can again be initialized by bpf_timer_init().
> Since both paths are almost identical between v5.15 and net-next,
> I suspect this problem still exists. Below are kmemleak report and
> some additional printks I inserted.
>
> [ 1364.081694] array_map_free_timers map:0xffffc900005a9000
> [ 1364.081730] ____bpf_timer_init map:0xffffc900005a9000
> timer:0xffff888001ab4080
>
> *no bpf_timer_cancel_and_free that will kfree struct bpf_hrtimer*
> at 0xffff888001ab4080 is called
>
> [ 1383.907869] kmemleak: 1 new suspected memory leaks (see
> /sys/kernel/debug/kmemleak)
> BUG: memory leak
> unreferenced object 0xffff888001ab4080 (size 96):
>   comm "sshd", pid 279, jiffies 4295233126 (age 29.952s)
>   hex dump (first 32 bytes):
>     80 40 ab 01 80 88 ff ff 00 00 00 00 00 00 00 00  .@..............
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000009d018da0>] bpf_map_kmalloc_node+0x89/0x1a0
>     [<00000000ebcb33fc>] bpf_timer_init+0x177/0x320
>     [<00000000fb7e90bf>] 0xffffffffc02a0358
>     [<000000000c89ec4f>] __cgroup_bpf_run_filter_skb+0xcbf/0x1110
>     [<00000000fd663fc0>] ip_finish_output+0x13d/0x1f0
>     [<00000000acb3205c>] ip_output+0x19b/0x310
>     [<000000006b584375>] __ip_queue_xmit+0x182e/0x1ed0
>     [<00000000b921b07e>] __tcp_transmit_skb+0x2b65/0x37f0
>     [<0000000026104b23>] tcp_write_xmit+0xf19/0x6290
>     [<000000006dc71bc5>] __tcp_push_pending_frames+0xaf/0x390
>     [<00000000251b364a>] tcp_push+0x452/0x6d0
>     [<000000008522b7d3>] tcp_sendmsg_locked+0x2567/0x3030
>     [<0000000038c644d2>] tcp_sendmsg+0x30/0x50
>     [<000000009fe3413f>] inet_sendmsg+0xba/0x140
>     [<0000000034d78039>] sock_sendmsg+0x13d/0x190
>     [<00000000f55b8db6>] sock_write_iter+0x296/0x3d0
>
>

Does this happen on bpf-next? Things have changed around timer freeing
since then.
Or even sharing the reproducer for this will work. I can take a look.

Thanks

