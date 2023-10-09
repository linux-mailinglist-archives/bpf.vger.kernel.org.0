Return-Path: <bpf+bounces-11719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3D57BE1F2
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 15:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 678C01C20852
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 13:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613BA347C6;
	Mon,  9 Oct 2023 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpcnGmaG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24021339B4;
	Mon,  9 Oct 2023 13:56:56 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB31FF;
	Mon,  9 Oct 2023 06:56:49 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a2244e06c3so8553497b3.1;
        Mon, 09 Oct 2023 06:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696859809; x=1697464609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7R+Ed3OVoVGJyxMBNphIrCQkroRIbnjibwGDxMcagv4=;
        b=SpcnGmaGoqeo3xlZQPFEA608gDNt0hkPZIiQvAI4N7jBruw2B256U9bIAmhUZBVh2J
         yrow0IeFmx7wcpnqest4EqwGurm9uUXDqswsO9/JOD7Jsqxw9/WpJYlX6ff5imMB5Vv0
         wSjyVr5ddSNMsGIm2kFVTpwde4CKPuOPb2g1IgntX3Pz+h2LNWLVP7N3oSs8m/J632e+
         QnPeuIOQyF2v56+83HIAeD2DXTCXE5beI61HLtvfMrKxUz69b/JRYBktgHcqYiOfnHTO
         93IqaJdUavMAmNoZWdoHQvZuvkEaOHq6Q5Y9nBl/i3IrD3PaRPYgTcF3R6d4I7p3NpMS
         Dk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696859809; x=1697464609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7R+Ed3OVoVGJyxMBNphIrCQkroRIbnjibwGDxMcagv4=;
        b=L6R9f2Eo5atH/sVP/HkZps6dxk1XRm+KdbGRYa33eX0QXaRt3SNxNHVCZ2IqLzTPhg
         NmqTXlKTLpe83lC00laJdJ7RKNKCT19jnzhqAB+oBKwE1Lj+mD7KUOTPYR+/ZLQh9rpp
         duIJuTXnL5rSlFMY9IshKvtz1zqbyzbv90nMYK0aLogZoeDLqZgSudtrzwdvNuMNC9EN
         RqbB4LKtBKsrYlG0laz4TH5ix+/k/ZkSrffLEaHbEuVodS+sWXJMcKrNKRIIw2RiZQTM
         uYwoiWTLXdBaafEXmYuqOMXJ2HZjgJEsudRHD8jblv2UZMUZ0+GygZPVMtvDUTawPNYY
         GyTA==
X-Gm-Message-State: AOJu0YxyQzqjtDitBRH3PLRT5VH2Efyk4BMSsm8y5/JNkKkip3TFFK7p
	7jBg/bq/5vF1LVMwxpTl5njjOtn9yRWTCJ2iMTA=
X-Google-Smtp-Source: AGHT+IEu5gcpHJZ81LmqyGwxblojiM/y116gIKH4I7qOS/xlUVmyIFarciyB7EASKhQWdTNoirmWT2vqnZibHQs+aOc=
X-Received: by 2002:a25:aba8:0:b0:d43:a0d8:8daf with SMTP id
 v37-20020a25aba8000000b00d43a0d88dafmr10377767ybi.6.1696859807950; Mon, 09
 Oct 2023 06:56:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231007075148.1759-1-andrew.kanner@gmail.com>
In-Reply-To: <20231007075148.1759-1-andrew.kanner@gmail.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 9 Oct 2023 15:56:36 +0200
Message-ID: <CAJ8uoz2VL0mtQxG6DdUFEK7FWN+MWXUtrEFEsYue4DLBO-WNtw@mail.gmail.com>
Subject: Re: [PATCH bpf v4] net/xdp: fix zero-size allocation warning in xskq_create()
To: Andrew Kanner <andrew.kanner@gmail.com>
Cc: martin.lau@linux.dev, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	aleksander.lobakin@intel.com, xuanzhuo@linux.alibaba.com, ast@kernel.org, 
	hawk@kernel.org, john.fastabend@gmail.com, daniel@iogearbox.net, 
	linux-kernel-mentees@lists.linuxfoundation.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+fae676d3cf469331fc89@syzkaller.appspotmail.com, 
	syzbot+b132693e925cbbd89e26@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 7 Oct 2023 at 09:52, Andrew Kanner <andrew.kanner@gmail.com> wrote:
>
> Syzkaller reported the following issue:
>  ------------[ cut here ]------------
>  WARNING: CPU: 0 PID: 2807 at mm/vmalloc.c:3247 __vmalloc_node_range (mm/vmalloc.c:3361)
>  Modules linked in:
>  CPU: 0 PID: 2807 Comm: repro Not tainted 6.6.0-rc2+ #12
>  Hardware name: Generic DT based system
>  unwind_backtrace from show_stack (arch/arm/kernel/traps.c:258)
>  show_stack from dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
>  dump_stack_lvl from __warn (kernel/panic.c:633 kernel/panic.c:680)
>  __warn from warn_slowpath_fmt (./include/linux/context_tracking.h:153 kernel/panic.c:700)
>  warn_slowpath_fmt from __vmalloc_node_range (mm/vmalloc.c:3361 (discriminator 3))
>  __vmalloc_node_range from vmalloc_user (mm/vmalloc.c:3478)
>  vmalloc_user from xskq_create (net/xdp/xsk_queue.c:40)
>  xskq_create from xsk_setsockopt (net/xdp/xsk.c:953 net/xdp/xsk.c:1286)
>  xsk_setsockopt from __sys_setsockopt (net/socket.c:2308)
>  __sys_setsockopt from ret_fast_syscall (arch/arm/kernel/entry-common.S:68)
>
> xskq_get_ring_size() uses struct_size() macro to safely calculate the
> size of struct xsk_queue and q->nentries of desc members. But the
> syzkaller repro was able to set q->nentries with the value initially
> taken from copy_from_sockptr() high enough to return SIZE_MAX by
> struct_size(). The next PAGE_ALIGN(size) is such case will overflow
> the size_t value and set it to 0. This will trigger WARN_ON_ONCE in
> vmalloc_user() -> __vmalloc_node_range().
>
> The issue is reproducible on 32-bit arm kernel.
>
> Reported-and-tested-by: syzbot+fae676d3cf469331fc89@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000c84b4705fb31741e@google.com/T/
> Link: https://syzkaller.appspot.com/bug?extid=fae676d3cf469331fc89
> Reported-by: syzbot+b132693e925cbbd89e26@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000e20df20606ebab4f@google.com/T/
> Fixes: 9f78bf330a66 ("xsk: support use vaddr as ring")
> Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>

Thanks Andrew for fixing this.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> ---
>
> Notes (akanner):
>     v4:
>       - add explanation about SIZE_MAX, suggested by Martin KaFai Lau
>         <martin.lau@linux.dev>
>     v3: https://lore.kernel.org/all/20231005193548.515-1-andrew.kanner@gmail.com/T/
>       - free kzalloc-ed memory before return, the leak was noticed by
>         Daniel Borkmann <daniel@iogearbox.net>
>     v2: https://lore.kernel.org/all/20231002222939.1519-1-andrew.kanner@gmail.com/raw
>       - use unlikely() optimization for the case with SIZE_MAX return from
>         struct_size(), suggested by Alexander Lobakin
>         <aleksander.lobakin@intel.com>
>       - cc-ed 4 more maintainers, mentioned by cc_maintainers patchwork
>         test
>
>     v1: https://lore.kernel.org/all/20230928204440.543-1-andrew.kanner@gmail.com/T/
>       - RFC notes:
>         It was found that net/xdp/xsk.c:xsk_setsockopt() uses
>         copy_from_sockptr() to get the number of entries (int) for cases
>         with XDP_RX_RING / XDP_TX_RING and XDP_UMEM_FILL_RING /
>         XDP_UMEM_COMPLETION_RING.
>
>         Next in xsk_init_queue() there're 2 sanity checks (entries == 0)
>         and (!is_power_of_2(entries)) for which -EINVAL will be returned.
>
>         After that net/xdp/xsk_queue.c:xskq_create() will calculate the
>         size multipling the number of entries (int) with the size of u64,
>         at least.
>
>         I wonder if there should be the upper bound (e.g. the 3rd sanity
>         check inside xsk_init_queue()). It seems that without the upper
>         limit it's quiet easy to overflow the allocated size (SIZE_MAX),
>         especially for 32-bit architectures, for example arm nodes which
>         were used by the syzkaller.
>
>         In this patch I added a naive check for SIZE_MAX which helped to
>         skip zero-size allocation after overflow, but maybe it's not quite
>         right. Please, suggest if you have any thoughts about the
>         appropriate limit for the size of these xdp rings.
>
>         PS: the initial number of entries is 0x20000000 in syzkaller
>         repro: syscall(__NR_setsockopt, (intptr_t)r[0], 0x11b, 3,
>         0x20000040, 0x20);
>
>         Link:
>         https://syzkaller.appspot.com/text?tag=ReproC&x=10910f18280000
>
>  net/xdp/xsk_queue.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/net/xdp/xsk_queue.c b/net/xdp/xsk_queue.c
> index f8905400ee07..d2c264030017 100644
> --- a/net/xdp/xsk_queue.c
> +++ b/net/xdp/xsk_queue.c
> @@ -34,6 +34,16 @@ struct xsk_queue *xskq_create(u32 nentries, bool umem_queue)
>         q->ring_mask = nentries - 1;
>
>         size = xskq_get_ring_size(q, umem_queue);
> +
> +       /* size which is overflowing or close to SIZE_MAX will become 0 in
> +        * PAGE_ALIGN(), checking SIZE_MAX is enough due to the previous
> +        * is_power_of_2(), the rest will be handled by vmalloc_user()
> +        */
> +       if (unlikely(size == SIZE_MAX)) {
> +               kfree(q);
> +               return NULL;
> +       }
> +
>         size = PAGE_ALIGN(size);
>
>         q->ring = vmalloc_user(size);
> --
> 2.39.3
>
>

