Return-Path: <bpf+bounces-64204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8904B0FA7B
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 20:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEDC07B067C
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 18:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6D51F418F;
	Wed, 23 Jul 2025 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VwL8NLDa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60419218E91
	for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753296493; cv=none; b=uWT5gs+cK8xg7d866ZbRBkWxv9DuvWslDfBmybWlF3XYMzgzTzsNLuBKb4HIhBTxQBdA24F+4JidSutwzRxhIAnbHVqJnV+20b6dLWXBAa4MfMMLUbdfzN6HO49olwWaiTdggNRwk5NBGOU0ylG8p+570Y30+oyIxs2RSWL8mn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753296493; c=relaxed/simple;
	bh=FCoBU7x1Pxepc9kivj9RdREXASZN+CIWLVELdvS583M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1lR17ZuQinDAWXT90rixtQvrrJcriiUSmhwaxrBjPHNCpjCbS+fwYTJQxdO1lqZxVuPWaev4ErICY8AAodI32V4Ji+w3filcFrLIkwiAzaGEMkEZoxQFm3D+mdqglLbCfJm0NmlQ22rTq0uh3JqqdhdPeBdbGF1xRPo1uW3nW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=VwL8NLDa; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-41b8e837427so71695b6e.3
        for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753296490; x=1753901290; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3wI4hB59yfyzWqJAp8KAClD5pKAf0l/d1LqlOvulBJ8=;
        b=VwL8NLDaDK3BXVDTCKo/exw+dYb0TqAqsMVtlitm6IRnXUCcy5NwFlcPldGcZIBMui
         2e4RotO9QfQ5tAuD9ZVNQhMDKBnb+TWp7AcQvUUEtvf+NYrIWwuUWR5XhpLtfosTai3X
         2PXqymS3ShmByK+vc1BDqeMN3wq/w9O+KO6tIFJUmU/igjJ8Fd3USQuJULBacFAr+Vnk
         jjYri1Zd52eJojNgTqGLhBk1Bfrxavoc/P70a9hVhn7wpkUI/6icYtrlIYg+liZ6c7Qp
         yxJfgnaxOCRinxQndRzsOGnJWQ4+nm/4L9vudRyk63nl8zmfeJxkgmqVwH3g6avpSZvu
         O3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753296490; x=1753901290;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3wI4hB59yfyzWqJAp8KAClD5pKAf0l/d1LqlOvulBJ8=;
        b=A6gmw/0XjdVWIWqeyROdEz1IruVmbJQzz3+G0SAcoA0sT1Yg0KuGOvzYrlV/p9/zpm
         RlCy1TkTq7PfdmGubiBK30dnl5HZ024BNnGeGs8awi5oT2vqUhjZrrJysRE5RF2azu1v
         ZwoSRpD0KOii1gJty295rrRmI0odQUo3W4Na2G+x3oR/GkuUmAIqbGxLhrU/FE+FZ0wn
         s7JSEUPXuLT0w1YoOIwf/hlFI/OsgdmaGqjfXzXSpL9vvVWru5Ld3IzuaDEvF8b2qidy
         mxyFEGH3ElQr23b4tkPb9vHZs+5fBCJp5BDJJIWa6DQlcqeTpih8+gZZNeujCep3W8px
         hZrw==
X-Forwarded-Encrypted: i=1; AJvYcCV0MyzX7yV6aUSUoZNvA+e2555P0UuT48p6BjglMINlN5VK4b7PuqD++ccT3BoFyg3ToTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz94eN17BjKVLd6maaC77XAlKEw4ElsaLdSQqKlIX0XPUoX9UTB
	bq9Ycvjo/+wKJx81zL6b3niX9saOOD6vwqx7haMPz5sikKE6Mn6cAzNrjhZa4O7pFc0=
X-Gm-Gg: ASbGncs9bElT5r35wSh3y/PaMib3oJg0eyl2gerxUl6HG9CQRQxeBrbmPvNM2NlqLGd
	6JZR4CMaJVvHNykpntXiKgo35/NKLuOFRz9IGlBN7yrlWLaJw/Tguz98p+iCn+H1NrSZ8GiO9wX
	ryGjwyAtZrmyVqmsDRi+392a/iwm5PI8I2/GGQlt9ZjuQ9H5YxA1G2Qr1gTC9P3WYzmu39ztIU/
	ebnK04WmIB1qNscwidbjJ5sNmmFdFhIGAz+QccJfFzhQY94tFyitBvCX9iSn16z8seZx1dlvAaP
	sf14BilHOvRaPXVo7wfiw4oYZNRxN1E8dytMA29atey8ZZaidYZCQ8xJRWv73zJlGu9AafOSqDe
	aEKULZg==
X-Google-Smtp-Source: AGHT+IGZxCh1c5zWoCjl8yPtFj986MoTn9NO+VZD8RF7HlOmlOLWNy7+3tZzbcYIjKGbgGb2wYxu4w==
X-Received: by 2002:a05:6808:23c9:b0:40c:5b59:6b8d with SMTP id 5614622812f47-426c662c1c7mr3643017b6e.26.1753296490276;
        Wed, 23 Jul 2025 11:48:10 -0700 (PDT)
Received: from 861G6M3 ([2a09:bac1:76a0:540::2d4:56])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd15c4172sm3344636b6e.11.2025.07.23.11.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 11:48:09 -0700 (PDT)
Date: Wed, 23 Jul 2025 13:48:07 -0500
From: Chris Arges <carges@cloudflare.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team <kernel-team@cloudflare.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>, tariqt@nvidia.com,
	saeedm@nvidia.com, Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Rzeznik <arzeznik@cloudflare.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [BUG] mlx5_core memory management issue
Message-ID: <aIEuZy6fUj_4wtQ6@861G6M3>
References: <CAFzkdvi4BTXb5zrjpwae2dF5--d2qwVDCKDCFnGyeV40S_6o3Q@mail.gmail.com>
 <dhqeshvesjhyxeimyh6nttlkrrhoxwpmjpn65tesani3tmne5v@msusvzdhuuin>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dhqeshvesjhyxeimyh6nttlkrrhoxwpmjpn65tesani3tmne5v@msusvzdhuuin>

On 2025-07-04 12:37:36, Dragos Tatulea wrote:
> On Thu, Jul 03, 2025 at 10:49:20AM -0500, Chris Arges wrote:
> > When running iperf through a set of XDP programs we were able to crash
> > machines with NICs using the mlx5_core driver. We were able to confirm
> > that other NICs/drivers did not exhibit the same problem, and suspect
> > this could be a memory management issue in the driver code.
> > Specifically we found a WARNING at include/net/page_pool/helpers.h:277
> > mlx5e_page_release_fragmented.isra. We are able to demonstrate this
> > issue in production using hardware, but cannot easily bisect because
> > we don’t have a simple reproducer.
> >
> Thanks for the report! We will investigate.
> 
> > I wanted to share stack traces in
> > order to help us further debug and understand if anyone else has run
> > into this issue. We are currently working on getting more crashdumps
> > and doing further analysis.
> > 
> > 
> > The test setup looks like the following:
> >   ┌─────┐
> >   │mlx5 │
> >   │NIC  │
> >   └──┬──┘
> >      │xdp ebpf program (does encap and XDP_TX)
> >      │
> >      ▼
> >   ┌──────────────────────┐
> >   │xdp.frags             │
> >   │                      │
> >   └──┬───────────────────┘
> >      │tailcall
> >      │BPF_REDIRECT_MAP (using CPUMAP bpf type)
> >      ▼
> >   ┌──────────────────────┐
> >   │xdp.frags/cpumap      │
> >   │                      │
> >   └──┬───────────────────┘
> >      │BPF_REDIRECT to veth (*potential trigger for issue)
> >      │
> >      ▼
> >   ┌──────┐
> >   │veth  │
> >   │      │
> >   └──┬───┘
> >      │
> >      │
> >      ▼
> > 
> > Here an mlx5 NIC has an xdp.frags program attached which tailcalls via
> > BPF_REDIRECT_MAP into an xdp.frags/cpumap. For our reproducer we can
> > choose a random valid CPU to reproduce the issue. Once that packet
> > reaches the xdp.frags/cpumap program we then do another BPF_REDIRECT
> > to a veth device which has an XDP program which redirects to an
> > XSKMAP. It wasn’t until we added the additional BPF_REDIRECT to the
> > veth device that we noticed this issue.
> > 
> Would it be possible to try to use a single program that redirects to
> the XSKMAP and check that the issue reproduces?
> 
> > When running with 6.12.30 to 6.12.32 kernels we are able to see the
> > following KASAN use-after-free WARNINGs followed by a page fault which
> > crashes the machine. We have not been able to test earlier or later
> > kernels. I’ve tried to map symbols to lines of code for clarity.
> >
> Thanks for the KASAN reports, they are very useful. Keep us posted
> if you have other updates. A first quick look didn't reveal anything
> obvious from our side but we will keep looking.
> 
> Thanks,
> Dragos

Ok, we can reproduce this problem!

I tried to simplify this reproducer, but it seems like what's needed is:
- xdp program attached to mlx5 NIC
- cpumap redirect
- device redirect (map or just bpf_redirect)
- frame gets turned into an skb
Then from another machine send many flows of UDP traffic to trigger the problem.

I've put together a program that reproduces the issue here:
- https://github.com/arges/xdp-redirector

In general the failure manifests with many different WARNs such as:
include/net/page_pool/helpers.h:277 mlx5e_page_release_fragmented.isra.0+0xf7/0x150 [mlx5_core]
Then the machine crashes.

I was able to get a crashdump which shows:
```
PID: 0        TASK: ffff8c0910134380  CPU: 76   COMMAND: "swapper/76"
 #0 [fffffe10906d3ea8] crash_nmi_callback at ffffffffadc5c4fd
 #1 [fffffe10906d3eb0] default_do_nmi at ffffffffae9524f0
 #2 [fffffe10906d3ed0] exc_nmi at ffffffffae952733
 #3 [fffffe10906d3ef0] end_repeat_nmi at ffffffffaea01bfd
    [exception RIP: io_serial_in+25]
    RIP: ffffffffae4cd489  RSP: ffffb3c60d6049e8  RFLAGS: 00000002
    RAX: ffffffffae4cd400  RBX: 00000000000025d8  RCX: 0000000000000000
    RDX: 00000000000002fd  RSI: 0000000000000005  RDI: ffffffffb10a9cb0
    RBP: 0000000000000000   R8: 2d2d2d2d2d2d2d2d   R9: 656820747563205b
    R10: 000000002d2d2d2d  R11: 000000002d2d2d2d  R12: ffffffffb0fa5610
    R13: 0000000000000000  R14: 0000000000000000  R15: ffffffffb10a9cb0
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
--- <NMI exception stack> ---
 #4 [ffffb3c60d6049e8] io_serial_in at ffffffffae4cd489
 #5 [ffffb3c60d6049e8] serial8250_console_write at ffffffffae4d2fcf
 #6 [ffffb3c60d604a80] console_flush_all at ffffffffadd1cf26
 #7 [ffffb3c60d604b00] console_unlock at ffffffffadd1d1df
 #8 [ffffb3c60d604b48] vprintk_emit at ffffffffadd1dda1
 #9 [ffffb3c60d604b98] _printk at ffffffffae90250c
#10 [ffffb3c60d604bf8] report_bug.cold at ffffffffae95001d
#11 [ffffb3c60d604c38] handle_bug at ffffffffae950e91
#12 [ffffb3c60d604c58] exc_invalid_op at ffffffffae9512b7
#13 [ffffb3c60d604c70] asm_exc_invalid_op at ffffffffaea0123a
    [exception RIP: mlx5e_page_release_fragmented+85]
    RIP: ffffffffc25f75c5  RSP: ffffb3c60d604d20  RFLAGS: 00010293
    RAX: 000000000000003f  RBX: ffff8bfa8f059fd0  RCX: ffffe3bf1992a180
    RDX: 000000000000003d  RSI: ffffe3bf1992a180  RDI: ffff8bf9b0784000
    RBP: 0000000000000040   R8: 00000000000001d2   R9: 0000000000000006
    R10: ffff8c06de22f380  R11: ffff8bfcfe6cd680  R12: 00000000000001d2
    R13: 000000000000002b  R14: ffff8bf9b0784000  R15: 0000000000000000
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
#14 [ffffb3c60d604d20] mlx5e_free_rx_wqes at ffffffffc25f7e2f [mlx5_core]
#15 [ffffb3c60d604d58] mlx5e_post_rx_wqes at ffffffffc25f877c [mlx5_core]
#16 [ffffb3c60d604dc0] mlx5e_napi_poll at ffffffffc25fdd27 [mlx5_core]
#17 [ffffb3c60d604e20] __napi_poll at ffffffffae6a8ddb
#18 [ffffb3c60d604e90] __napi_poll at ffffffffae6a8db5
#19 [ffffb3c60d604e98] net_rx_action at ffffffffae6a95f1
#20 [ffffb3c60d604f98] handle_softirqs at ffffffffadc9d4bf
#21 [ffffb3c60d604fe8] irq_exit_rcu at ffffffffadc9e057
#22 [ffffb3c60d604ff0] common_interrupt at ffffffffae952015
--- <IRQ stack> ---
#23 [ffffb3c60c837de8] asm_common_interrupt at ffffffffaea01466
    [exception RIP: cpuidle_enter_state+184]
    RIP: ffffffffae955c38  RSP: ffffb3c60c837e98  RFLAGS: 00000202
    RAX: ffff8c0cffc00000  RBX: ffff8c0911002400  RCX: 0000000000000000
    RDX: 00003c630b2d073a  RSI: ffffffe519600d10  RDI: 0000000000000000
    RBP: 0000000000000001   R8: 0000000000000002   R9: 0000000000000001
    R10: ffff8c0cffc330c4  R11: 071c71c71c71c71c  R12: ffffffffb05ff820
    R13: 00003c630b2d073a  R14: 0000000000000001  R15: 0000000000000000
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
#24 [ffffb3c60c837ed0] cpuidle_enter at ffffffffae64b4ad
#25 [ffffb3c60c837ef0] do_idle at ffffffffadcfa7c6
#26 [ffffb3c60c837f30] cpu_startup_entry at ffffffffadcfaa09
#27 [ffffb3c60c837f40] start_secondary at ffffffffadc5ec77
#28 [ffffb3c60c837f50] common_startup_64 at ffffffffadc24d5d
```

Assuming (this is x86_64):
RDI=ffff8bf9b0784000 (rq)
RSI=ffffe3bf1992a180 (frag_page)

```
static void mlx5e_page_release_fragmented(struct mlx5e_rq *rq,
                                          struct mlx5e_frag_page *frag_page)
{
        u16 drain_count = MLX5E_PAGECNT_BIAS_MAX - frag_page->frags;
        struct page *page = frag_page->page;

        if (page_pool_unref_page(page, drain_count) == 0)
                page_pool_put_unrefed_page(rq->page_pool, page, -1, true);
}
```

crash> struct mlx5e_frag_page ffffe3bf1992a180
struct mlx5e_frag_page {
  page = 0x26ffff800000000,
  frags = 49856
}

This means that drain_count could be an unexpected number (assuming that we
expect it to be less than MLX5E_PAGECNT_BIAS_MAX).

Let me know what additional experiments would be useful here.

--chris

