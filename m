Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B887360F61F
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 13:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbiJ0LYN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 07:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiJ0LYN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 07:24:13 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FAE836E7;
        Thu, 27 Oct 2022 04:24:12 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id jb18so732618wmb.4;
        Thu, 27 Oct 2022 04:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hjZhiiyHr6e7gEr5aYAyXoXMrTUnFkMEXcIg3TOETvs=;
        b=UmrKbRdbOVixvxTz4Cdf6Hlo+Y/TO+OnYi3Cy7dVmeAt2wXTcSHDcOrkO+a3GUAqGz
         5AmUJXdpOsnwlI/d8njnXdArLn6V0cHk9GhB0SyGc62yKmWrvKayFzsj/7DM19AqhvZG
         OVI8PlUnbNYApaN8hO84RkPKrOTL4zTr5OZR5l2qzDg+KSeLeD6s23CD0+ExJwCR36Aj
         Qx+cHjTvBGt2hQfLgsztyQRNZyLIiW6Ryl+ELH3/DCUsFMpWJ7QIL3af7qb/7XeogDLY
         6u+km5qbYSgAyzmmtERuWjFDpcNDZO2DPB4zson/NcXdAeUISYxfye9TQ+ucRvSCeJ5j
         KmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjZhiiyHr6e7gEr5aYAyXoXMrTUnFkMEXcIg3TOETvs=;
        b=oqGTtEWfNLTIMJvtyfqNcHYcpnRUT0m1nIo8/8P74BnDQS3FhcJ4nZCIGse81uNcWO
         QQbpMLl+A1w2H/OufsMnJ91XtboJ9D7/d2byjET+XTKxhzdYkDwQsJUVQBesAgTvNRNL
         lFbVDQhplmqDubh2CFFaRZpjZIVHkOSzkHK7CCwDzJ5PWRW1mPeVKwxu3f/bm+4byvpU
         ZlWXAWmTLD7lJDr2wSmw8RDhgE1YGJp0tkUqly/x2I9a7vOPHGvFweWxVq6h2PW70SQs
         HU+iQJTfwr7SFXloqp9uKrtXVlGWEQMyr3xod7Dn/feBl2NoU4Np63PZX5jT5ZnWuvEA
         Wxjg==
X-Gm-Message-State: ACrzQf3HQKVRHbCLUSYF0v5Rrh8WWtqJhjbWEkIniiqK+SohX1uAgmVa
        ihv6bTK30v60TpqfEI4nR1Y=
X-Google-Smtp-Source: AMsMyM50TgO9W02U87sguwHzv7Ais2cNd+MxlSFxMM7s2w6ywfRK1tmKZVefAWo34IBBm+FOugdPYA==
X-Received: by 2002:a7b:c3c4:0:b0:3c4:785a:36d7 with SMTP id t4-20020a7bc3c4000000b003c4785a36d7mr5603776wmj.138.1666869850590;
        Thu, 27 Oct 2022 04:24:10 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id j21-20020a05600c42d500b003b492753826sm1173625wme.43.2022.10.27.04.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 04:24:10 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 27 Oct 2022 13:24:08 +0200
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andrii@kernel.org, ast@kernel.org, bpf <bpf@vger.kernel.org>,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, martin.lau@linux.dev, sdf@google.com,
        song@kernel.org, yhs@fb.com
Subject: Re: WARNING in bpf_bprintf_prepare
Message-ID: <Y1pqWPRmP0M+hcXf@krava>
References: <CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 27, 2022 at 10:27:28AM +0800, Hao Sun wrote:
> Hi,
> 
> The following warning can be triggered with the C reproducer in the link.
> Syzbot also reported this several days ago, Jiri posted a patch that
> uses bpf prog `active` field to fix this by 05b24ff9b2cfab (bpf:
> Prevent bpf program recursion...) according to syzbot dashboard
> (https://syzkaller.appspot.com/bug?id=179313fb375161d50a98311a28b8e2fc5f7350f9).
> But this warning can still be triggered on 247f34f7b803
> (Linux-v6.1-rc2) that already merged the patch, so it seems that this
> still is an issue.
> 
> HEAD commit: 247f34f7b803 Linux 6.1-rc2
> git tree: upstream
> console output: https://pastebin.com/raw/kNw8JCu5
> kernel config: https://pastebin.com/raw/sE5QK5HL
> C reproducer: https://pastebin.com/raw/X96ASi27

hi,
right, that fix addressed that issue for single bpf program,
and it won't prevent if there are multiple programs hook on
contention_begin tracepoint and calling bpf_trace_printk,

I'm not sure we can do something there.. will check

do you run just the reproducer, or you load the server somehow?
I cannot hit the issue so far

thanks,
jirka

> 
> ------------[ cut here ]------------
> WARNING: CPU: 6 PID: 6850 at kernel/bpf/helpers.c:770
> try_get_fmt_tmp_buf kernel/bpf/helpers.c:770 [inline]
> WARNING: CPU: 6 PID: 6850 at kernel/bpf/helpers.c:770
> bpf_bprintf_prepare+0xf6a/0x1170 kernel/bpf/helpers.c:818
> Modules linked in:
> CPU: 6 PID: 6850 Comm: a.out Not tainted 6.1.0-rc2-dirty #23
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:try_get_fmt_tmp_buf kernel/bpf/helpers.c:770 [inline]
> RIP: 0010:bpf_bprintf_prepare+0xf6a/0x1170 kernel/bpf/helpers.c:818
> Code: c6 e8 ba 51 00 07 83 c0 01 48 98 48 01 c5 48 89 6c 24 08 e8 b8
> 0a eb ff 8d 6b 02 83 44 24 10 01 e9 2d f5 ff ff e8 a6 0a eb ff <0f> 0b
> 65 ff 0d 85 bf 7c 7e bf 01 00 00 00 41 bc f0 ff ff ff e8 2d
> RSP: 0018:ffffc90015a96c20 EFLAGS: 00010046
> RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff88814f8057c0
> RDX: 0000000000000000 RSI: ffff88814f8057c0 RDI: 0000000000000002
> RBP: ffffc90015a96d50 R08: ffffffff818681ba R09: 0000000000000003
> R10: 0000000000000005 R11: fffffbfff1a25ab2 R12: 0000000000000003
> R13: 0000000000000004 R14: ffffc90015a96e08 R15: 0000000000000003
> FS:  00007f012f4d2440(0000) GS:ffff8880b9d80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f012f19ac28 CR3: 0000000148da3000 CR4: 0000000000350ee0
> Call Trace:
>  <TASK>
>  ____bpf_trace_printk kernel/trace/bpf_trace.c:385 [inline]
>  bpf_trace_printk+0xab/0x420 kernel/trace/bpf_trace.c:376
>  bpf_prog_0605f9f479290f07+0x2f/0x33
>  bpf_dispatcher_nop_func include/linux/bpf.h:963 [inline]
>  __bpf_prog_run include/linux/filter.h:600 [inline]
>  bpf_prog_run include/linux/filter.h:607 [inline]
>  __bpf_trace_run kernel/trace/bpf_trace.c:2254 [inline]
>  bpf_trace_run2+0x14d/0x3d0 kernel/trace/bpf_trace.c:2293
>  __bpf_trace_contention_begin+0xb5/0xf0 include/trace/events/lock.h:95
>  __traceiter_contention_begin+0x56/0x90 include/trace/events/lock.h:95
>  trace_contention_begin include/trace/events/lock.h:95 [inline]
>  __pv_queued_spin_lock_slowpath+0x542/0xff0 kernel/locking/qspinlock.c:405
>  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:591 [inline]
>  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
>  queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
>  do_raw_spin_lock+0x204/0x2d0 kernel/locking/spinlock_debug.c:115
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
>  _raw_spin_lock_irqsave+0x41/0x50 kernel/locking/spinlock.c:162
>  ____bpf_trace_printk kernel/trace/bpf_trace.c:390 [inline]
>  bpf_trace_printk+0xcf/0x420 kernel/trace/bpf_trace.c:376
>  </TASK>
> 
> Regards
> Hao Sun
