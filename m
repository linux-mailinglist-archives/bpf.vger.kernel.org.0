Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8F632F3AB
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 20:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhCETRO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Mar 2021 14:17:14 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:38569 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229730AbhCETQw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Mar 2021 14:16:52 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id AA1FE580443;
        Fri,  5 Mar 2021 14:16:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 05 Mar 2021 14:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=NP5/0z6U9MabMnDzBsftOLQMOaI
        iy/zFJbTiSkFYAjQ=; b=T/TmheAxg2012Zv5MmrurVINsgQw1jKBGLN4Vc5uVHT
        gybC7zQcRA+Gibehb6GuOpvQYvdjn7za3QrXOd8ux8jNWNQFk1sWcmbk3dLQEd9t
        uOP8pGVbFPNJuACItoJSrtT/Vq7jHgElBQBcZeKwBA9H0nHc8eY0AUWYMydBs4Bq
        bHZoONNharyrPOYJl78Xmc1Mckg1hANRLnIPArLRK5XufU9h2dCM3XNVbCmuAPEo
        TN+2FS1T30e2DUkR9WMvYxugxMzZDL9uRn9VyTvdSFwQ7UjRaFl9yKqifF0QAQSV
        wr9a+Feu2ScreeCXSBf76NYXk0hd/lZhL+or8Yl2Erg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=NP5/0z
        6U9MabMnDzBsftOLQMOaIiy/zFJbTiSkFYAjQ=; b=PGOW+2pbKHWuBapMs7vRjH
        HmOhsWlV6RY1SUUmq1+pAX8poner15OvoVeb3Nw98hV9QF7D7VM5Derz94r7C/dN
        59B0MAveazQHCsyyi2CkCR/rEElUvL7sT7rcrbzVykg+BgxkhMdo/va0WAmsLnjO
        lQGgiYcUm54JnPu7teFhjuxn3aFb9WfGtN07ZAXuWmn6Kde7rjhE6fprJ/MaaQR6
        tRGN4JAZhcYmbSrpQ+XGxZKwxUAhX9/yjNZB1qiN/TNFVQEbLmP7vjApTtck9Hu/
        2Pk1QtHDyswU6si/ulJfne3CQjsqaaKUJq1Q969j7KSyTUWi8Qj1F/z0A9qZJAJg
        ==
X-ME-Sender: <xms:o4NCYKH7JwI_yKZX1GWcoog9Yx5g7LoMLicD3Fi8FjEVxo16ABBvpw>
    <xme:o4NCYLXlerXBbk7qNhwbE6qf_NWowFp1lMi8gm47ZMbg5bksi6kXN0nGrwAN8MdQt
    dlF-4GtEecmFPk9gA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddtiedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepueduvdejfefflefgueevheefgeefteefteeuudduhfduhfeh
    veelteevudelheejnecukfhppeeiledrudekuddruddthedrieegnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiih
    ii
X-ME-Proxy: <xmx:o4NCYELE8F9iolE6plXlgfT1jQpSt6z3sEMTVkenCKCwnLbqyzC7gw>
    <xmx:o4NCYEFIkpf2L04_J_Ut8v2cwM70wLMIvGvqNiDUSvv9xAsJWFesKg>
    <xmx:o4NCYAXuYiyPp5X4u787F9KRXxjI44T0c_-ETJ3oOESv5mCorwwDhA>
    <xmx:o4NCYET7Pdsgi6VISgfekKD2tgtIdY9PnUC3LX18tGuW0aZWjpKH0w>
Received: from maharaja.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3D6CD24005D;
        Fri,  5 Mar 2021 14:16:47 -0500 (EST)
Date:   Fri, 5 Mar 2021 11:16:45 -0800
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
        mingo@redhat.com, ast@kernel.org, tglx@linutronix.de,
        kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH -tip 0/5] kprobes: Fix stacktrace in kretprobes
Message-ID: <20210305191645.njvrsni3ztvhhvqw@maharaja.localdomain>
References: <161495873696.346821.10161501768906432924.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161495873696.346821.10161501768906432924.stgit@devnote2>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Masami,

On Sat, Mar 06, 2021 at 12:38:57AM +0900, Masami Hiramatsu wrote:
> Hello,
> 
> Here is a series of patches for kprobes and stacktracer to fix the kretprobe
> entries in the kernel stack. This was reported by Daniel Xu. I thought that
> was in the bpftrace, but it is actually more generic issue.
> So I decided to fix the issue in arch independent part.
> 
> While fixing the issue, I found a bug in ia64 related to kretprobe, which is
> fixed by [1/5]. [2/5] and [3/5] is a kind of cleanup before fixing the main
> issue. [4/5] is the patch to fix the stacktrace, which involves kretprobe
> internal change. And [5/5] removing the stacktrace kretprobe fixup code in
> ftrace. 
> 
> Daniel, can you also check that this fixes your issue too? I hope it is.

Unfortunately, this patch series does not fix the issue I reported.

I think the reason your tests work is because you're using ftrace and
the ORC unwinder is aware of ftrace trampolines (see
arch/x86/kernel/unwind_orc.c:orc_ftrace_find).

bpftrace kprobes go through perf event subsystem (ie not ftrace) so
naturally orc_ftrace_find() does not find an associated trampoline. ORC
unwinding fails in this case because
arch/x86/kernel/kprobes/core.c:trampoline_handler sets

    regs->ip = (unsigned long)&kretprobe_trampoline;

and `kretprobe_trampoline` is marked

    STACK_FRAME_NON_STANDARD(kretprobe_trampoline);

so it doesn't have a valid ORC entry. Thus, ORC immediately bails when
trying to unwind past the first frame.

The only way I can think of to fix this issue is to make the ORC
unwinder aware of kretprobe (ie the patch I sent earlier). I'm hoping
you have another idea if my patch isn't acceptable.

Thanks,
Daniel
