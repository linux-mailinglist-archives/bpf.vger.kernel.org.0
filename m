Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02F33F5581
	for <lists+bpf@lfdr.de>; Tue, 24 Aug 2021 03:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhHXBjV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Aug 2021 21:39:21 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:34905 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229742AbhHXBjU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Aug 2021 21:39:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 03729580A5A;
        Mon, 23 Aug 2021 21:38:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 23 Aug 2021 21:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=dFqaz1Q3a610k9Y8rYvakut5ujj
        GIsTJnwq/BHLcbMo=; b=KjseD1wOTfSI7Lan/5f2jTPgDIDp8BRWB3nOUZSCYMp
        0qu5IAlzKjhLYL0fCy8BHXOKV7q8hKpvNrCOFQKsyMYb6mKYxJAQyanMDpZ0ga3U
        BzuJFVG8ZASq/X7bmKXyUTF+kY5Pyeolvih0oMhLF0faWMAZstsS1KA60DXpm4o8
        AtUEZxX7K8NHe5TFBFGW2ubgiAZrjdJ0W8gbIjAzxz1sk9rO38hw3dkP+MVEMWwT
        SOrRNrJYEfCjy6CZ2KvP+0PUKfwlBqJwR/O1Q6wgNRtd7TsUvBoAVDjY0I3xGvto
        tQXDk1dIs4wRn75W3L4pr6UpGYdkMDe/XqqFuQqIeZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=dFqaz1
        Q3a610k9Y8rYvakut5ujjGIsTJnwq/BHLcbMo=; b=KSH9PIFajgA3Q7S+5Ww3L0
        iuREWp+3Dc2G/J6rAaHW1CfjuNmVyihw0Qu761q4LNsyWuDfJ7sdhpNcHUkC530w
        SOIUGdkL09P1Zh3Rd48mgymUTb21Syg6wpznA2LqXkJL9qwFrsAI7sjvG0M9FiLb
        /UTPSxCginBawwtpShlxHa3Jr+u0CsqeaTE/YZ55eNfpfwyfqQ2Vorz45Rzl6kh0
        9Z071cwZkALaE0haOm4qDiZlEuWii13oo1oiwXaIClEFQUVGzOwWIzlcXuNVadgK
        TNIjZNIGoEx8C5XIDW+5PDC20hS8yK/G/W6+nPD1Yv0Z4In58ASVwHa/iJc5unHw
        ==
X-ME-Sender: <xms:nE0kYdV2dfPQwhASKsXxNu2Fm1hyG6MoSoS2FUJTeC8SYH9rBeAx5w>
    <xme:nE0kYdkSGbx2Wa2vUkedALWXM7BGSR3-jGeJzIZhWLpFoosRwTYYeCLNfFoi4kU1M
    8XGdLUKkN2h2I727Q>
X-ME-Received: <xmr:nE0kYZZUCCP_5DYUoUC5w5V9c8v7w56Iys8PZEluQMwrBvECnjHg0ogfbw4rZXyf6PJ8g7s7G5OpGnobzDeaQvpX_f5gVvlXALkt0HZ_GWdZqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtiedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenogfvvgigthfqnhhlhidqqdgigeduledqvdekudculdef
    tddtmdenucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepff
    grnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhn
    peettddtjeehlefgiedtkeejteekgeejieejhffhgeelvdeiledvueejheetkedthfenuc
    ffohhmrghinheplhhkmhhlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighi
    ii
X-ME-Proxy: <xmx:nE0kYQU0trlJ6XL22HQjUoD116KRickuzwNbmrL02htBRJi7VJuSzA>
    <xmx:nE0kYXloMEynw2Sqo7UmKLfz9SWCF-SPgcFittI68k6nQAmRjAp2eg>
    <xmx:nE0kYdfN66xUFGm8l-zgGhri2UOkfwbHF4M5eC_jdo9nnb6_av_t0A>
    <xmx:nE0kYQCAJKKKEkS84fLLfsR7ba_OrKRQmj54uXe4j6f-wsBPpCISLg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Aug 2021 21:38:35 -0400 (EDT)
Date:   Mon, 23 Aug 2021 18:38:34 -0700
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <kernel-team@fb.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bpf_task_pt_regs() helper
Message-ID: <20210824013834.6bnpn4vdyynvwqme@kashmir.localdomain>
References: <cover.1629329560.git.dxu@dxuuu.xyz>
 <6d269f13f2ff742e319a8c19112ef40f0b4c2f46.1629329560.git.dxu@dxuuu.xyz>
 <CAEf4BzZAs5P4m0Ct5OpV0FZJ7nosYo5QDraEScphUmprta_77w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZAs5P4m0Ct5OpV0FZJ7nosYo5QDraEScphUmprta_77w@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 19, 2021 at 01:27:16PM -0700, Andrii Nakryiko wrote:
> On Wed, Aug 18, 2021 at 4:42 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > The motivation behind this helper is to access userspace pt_regs in a
> > kprobe handler.
> >
> > uprobe's ctx is the userspace pt_regs. kprobe's ctx is the kernelspace
> > pt_regs. bpf_task_pt_regs() allows accessing userspace pt_regs in a
> > kprobe handler. The final case (kernelspace pt_regs in uprobe) is
> > pretty rare (usermode helper) so I think that can be solved later if
> > necessary.
> >
> > More concretely, this helper is useful in doing BPF-based DWARF stack
> > unwinding. Currently the kernel can only do framepointer based stack
> > unwinds for userspace code. This is because the DWARF state machines are
> > too fragile to be computed in kernelspace [0]. The idea behind
> > DWARF-based stack unwinds w/ BPF is to copy a chunk of the userspace
> > stack (while in prog context) and send it up to userspace for unwinding
> > (probably with libunwind) [1]. This would effectively enable profiling
> > applications with -fomit-frame-pointer using kprobes and uprobes.
> >
> > [0]: https://lkml.org/lkml/2012/2/10/356
> > [1]: https://github.com/danobi/bpf-dwarf-walk
> >
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> 
> Seems like a really useful thing. Few notes:
> 
> 1. Given this is user pt_regs, should we call it bpf_get_user_pt_regs()?

I'm not 100% sure, but it seems to me that task_pt_regs() works for
kernel threads too. I see in arch/x86/kernel/smpboot.c that
task_pt_regs() is being used on the idle thread (which I think is a
kernel thread).

> 2. Would it be safe to enable it for all types of programs, not just
> kprobe/tp/raw_tp/perf? Why limit the list?

Oh I didn't realize I put a limit on it. I'll look closer.

> 3. It seems like it's the sixth declaration of BTF_ID for task_struct,
> maybe it's time to consolidate them?

Ok, will consolidate.

[...]

Thanks,
Daniel
