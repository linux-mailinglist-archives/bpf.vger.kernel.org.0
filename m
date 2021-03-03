Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C7E32C1FB
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449766AbhCCWxx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:53:53 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41497 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1387407AbhCCT6p (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Mar 2021 14:58:45 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 43DE85C0063;
        Wed,  3 Mar 2021 14:57:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 03 Mar 2021 14:57:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=HZlbfd46lkwmol3NQrqYW8RLu0H
        uj779eapAkCJw284=; b=JqVuS4cbzrIoT3OiQm+re8VcffHRtoM2z8sg/dbxLY7
        uCky4aMJ6y8nqtJfbu69dGS8zvd9u5Gh6I8+1K5V75JwmFRnWZy2w8HUFRKzW+B3
        EcRdzuaULTQlsbhk8qymvydGfVrW9lnt4RqecSwRtBTGiuXqLDVIcm8a7OKCtb+8
        wkcdSIEAo2g3QgOW+ooiS6IkDsue+CmEVrwx9WDURhD/O2DVHIeePpfzfa+SJgSv
        pJ4hy7aaH5GJ70tNX+4EPwzVYlBWOeWteyJOIfyRCr14+IwhliWXw9EYNijRnujq
        AwIIegRhSsLeB9KdRwgTvulDmLl/J8TpyshCu7uex3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=HZlbfd
        46lkwmol3NQrqYW8RLu0Huj779eapAkCJw284=; b=Go3gDb41rOQkf8pS8JfKRp
        8RToCWlE3Lz+eISJZLOCa1kqO3w2A2tiy5B7ahB6+tnqQ1oQBGRJhkZUW9VanP9I
        3IPc5aeiMIDZJ1DLaUu3aZ2J5XYvPxG1l4/5Ar/Uw8sB3bzfpsgnoOZIj7iVjQ8A
        L/yPl5b2xGkkSQ9xzLEXfL4APDGpNWLVmaBxVAXMfPbgm2NnWhYPCHtfepjRvb1V
        RE9DwkQlg+bK4zebWZoOG9PcdFoQ9bCePZw3HRxyW1E32we2E0REWyCw5I4uGJ21
        qBuKhLksw3o43pcoc1oBsOuczbH83A0uV41cIcbx4HtPxc/QofCIyGm+SYmG5NEw
        ==
X-ME-Sender: <xms:Leo_YLqyoval5sS3MnfJEjXQo2Pder40mgsl-6dSPhrBUubDFeGaVA>
    <xme:Leo_YFm2xqeXzHh7t-aMlJl3R5UpTgyON3mfqd_8s3RPV990lyy1AS1jN8vdeHRAO
    Lw7s3Ps19a4WNJtQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddtvddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepgfeijefhfeefgfejhfeguedthfejhffggfdthfejueeujeef
    feevhefgieeiteeinecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepieelrd
    dukedurddutdehrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:Leo_YFGPoOArWvXlngsBmRZcEyy-QVEv9l2PG3Znrsa2acwZEGRTCA>
    <xmx:Leo_YGq4dgNkLeyXZimAi_Y0Py-Qs1_pm2WrYseVpQKqd90oG0KrPQ>
    <xmx:Leo_YJ7K8h9swdR6hwlBl_SzA797_yDVAeXGD3xn4xHaOPSeRRhwjQ>
    <xmx:Luo_YF06d7JVOzbDVSVVA8ZKAsk6HFi1qHtVqW7IgVwz4mfM2Vj1lw>
Received: from maharaja.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 174F2108005C;
        Wed,  3 Mar 2021 14:57:32 -0500 (EST)
Date:   Wed, 3 Mar 2021 11:57:30 -0800
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>, kuba@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Broken kretprobe stack traces
Message-ID: <20210303195730.czt64mdfmpfie4ys@maharaja.localdomain>
References: <1fed0793-391c-4c68-8d19-6dcd9017271d@www.fastmail.com>
 <20210303134828.39922eb167524bc7206c7880@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303134828.39922eb167524bc7206c7880@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 03, 2021 at 01:48:28PM +0900, Masami Hiramatsu wrote:
> Hi Daniel,
> 
> On Tue, 02 Mar 2021 17:15:13 -0800
> "Daniel Xu" <dxu@dxuuu.xyz> wrote:
> 
> > Hi Masami,
> > 
> > Jakub reported a bug with kretprobe stack traces -- wondering if you've gotten
> > any bug reports related to stack traces being broken for kretprobes.
> 
> Yeah, stack dumper must check the stack entry is kretprobe'd and skip it.
> For example, ftrace checks it as below.
> 
> /sys/kernel/debug/tracing # echo r vfs_read > kprobe_events 
> /sys/kernel/debug/tracing # echo stacktrace > events/kprobes/r_vfs_read_0/trigger 
> /sys/kernel/debug/tracing # echo 1 > events/kprobes/r_vfs_read_0/enable 
> /sys/kernel/debug/tracing # head -20 trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 15685/336094   #P:8
> #
> #                                _-----=> irqs-off
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| /     delay
> #           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
> #              | |         |   ||||      |         |
>               sh-132     [006] ...1    38.920352: <stack trace>
>  => kretprobe_dispatcher
>  => __kretprobe_trampoline_handler
>  => trampoline_handler
>  => [unknown/kretprobe'd]
>  => [unknown/kretprobe'd]
>  => __x64_sys_read
>  => do_syscall_64
>  => entry_SYSCALL_64_after_hwframe
> 
> 
> > 
> > I think (can't prove) this used to work:
> 
> I'm not sure the bpftrace had correctly handled it or not.
> 
> > 
> >     # bpftrace -e 'kretprobe:__tcp_retransmit_skb { @[kstack()] = count() }'
> >     Attaching 1 probe...
> >     ^C
> > 
> >     @[
> >         kretprobe_trampoline+0
> >     ]: 1
> 
> Would you know how the bpftrace stacktracer rewinds the stack entries?
> FYI, ftrace does it in trace_seq_print_sym()@kernel/trace/trace_output.c

Thanks for the hint, I'll take a look.

bpftrace generates a bpf program that calls into the kernel's
bpf_get_stackid():

https://github.com/torvalds/linux/blob/f69d02e37a85645aa90d18cacfff36dba370f797/include/uapi/linux/bpf.h#L1296

so it could be a bug with bpf.

<...>

