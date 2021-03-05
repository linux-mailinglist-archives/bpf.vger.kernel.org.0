Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08A232F3C9
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 20:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCETZn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Mar 2021 14:25:43 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:46385 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229730AbhCETZU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Mar 2021 14:25:20 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 28FC4580475;
        Fri,  5 Mar 2021 14:25:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 05 Mar 2021 14:25:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=dZss2kULvn4E+OI6cmK2wA39XAH
        /Avv1BVvXuwbPBbg=; b=sGiYaqEgRmspd9aCLgGjZ+RXbMDVXaJm4D4Ci8E5Ia8
        ER9oZVlBr8x+v5g+rKMAnhr4HQjS6buFzZSTrbIWH6BwpkzgTE7O5XqzfDTj5RAx
        WgNKEBRxAB9KGUgJYnz1C/FEBSc9nDZsHgr4CpqzB6CetPvBrt5Ni0r7GjkknW+C
        Q6pNmHypXadhbTAwL0eemVQlPFAC9KSPsutVJCcnLyMJrXsUQEtnY39SzU6gR7L7
        asob1fMR83nij3Z5L/DCvisbADH+SQmN71cANENwawn8+ZxF3ALiulccvUDjgiTM
        F1YLfdiu7iTYlV3wEo+V/XjLczzb/69GtpKU9HhZiCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=dZss2k
        ULvn4E+OI6cmK2wA39XAH/Avv1BVvXuwbPBbg=; b=Am9Y3bdI8nxg5xjSHlyUs+
        22jLMBkcbuRoqCP+0Uwo0diYYglzS9sjJVkQHgFbMWsOmr70Rs+7Uj96BSl5fshj
        a483FkJAqjgJ09W2muPVUubpzlrKYLtHyiTTcqtMCklxXWLZH6lipB6MIKZNhvZq
        hXT5QJD/W8H2UHdTlV5epxRgS67oBWevD+/sRVYCPU/nEs/8hAOdnvzsTcP4VmSw
        3e8H+xkDj92b56wekx5S/vJ1NgUQqrJTFLaIS2pCiK4zfz6BHjOWBNfUUNtudS8V
        WaSKURA5IHsfzoaVvJ6g5Tkxc8cyOlic9gs5Lh/MW0O0eGHkPK1yiN3tnDxYCdJQ
        ==
X-ME-Sender: <xms:n4VCYAgP-pWwuOYHJOxZYQAGF-UGMb7bpyaGzRwap1252GZts47ktA>
    <xme:n4VCYJCyT5jjrAQYASv7mWTWVi26apnxS0dFoOYaQS4dXSKBL9U7pdgKJNQNC5xW-
    A3r2DmsEfsQUt1d4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddtiedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepueduvdejfefflefgueevheefgeefteefteeuudduhfduhfeh
    veelteevudelheejnecukfhppeeiledrudekuddruddthedrieegnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiih
    ii
X-ME-Proxy: <xmx:n4VCYIG_fOiZFJEQ85HWLVRCqc-1vVaRf_TiTm_OUqcGFJdNoWDQXA>
    <xmx:n4VCYBTc-r6pMogBZzpIe5nZ8ehh1MpDSaKSYbZK3cFYJTyRw240Dg>
    <xmx:n4VCYNxwPSkedjzNqv6LDsCJwG32Po2lZnJpdKQYfa5kkBq4Ond0rg>
    <xmx:oIVCYNcpj8ngJtNYLhj8foHKWokPt88YVQMC5KqQiHsNoyTyKtoEgw>
Received: from maharaja.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 95D2A108005C;
        Fri,  5 Mar 2021 14:25:17 -0500 (EST)
Date:   Fri, 5 Mar 2021 11:25:15 -0800
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, jpoimboe@redhat.com, kuba@kernel.org,
        ast@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH] x86: kprobes: orc: Fix ORC walks in kretprobes
Message-ID: <20210305192515.6utyhm5kks4zexwn@maharaja.localdomain>
References: <d72c62498ea0514e7b81a3eab5e8c1671137b9a0.1614902828.git.dxu@dxuuu.xyz>
 <20210305182806.df403dec398875c2c1b2c62d@kernel.org>
 <20210305195809.a9784ecf0b321c14fd18d247@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305195809.a9784ecf0b321c14fd18d247@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 05, 2021 at 07:58:09PM +0900, Masami Hiramatsu wrote:
> On Fri, 5 Mar 2021 18:28:06 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi Daniel,
> > 
> > On Thu,  4 Mar 2021 16:07:52 -0800
> > Daniel Xu <dxu@dxuuu.xyz> wrote:
> > 
> > > Getting a stack trace from inside a kretprobe used to work with frame
> > > pointer stack walks. After the default unwinder was switched to ORC,
> > > stack traces broke because ORC did not know how to skip the
> > > `kretprobe_trampoline` "frame".
> > > 
> > > Frame based stack walks used to work with kretprobes because
> > > `kretprobe_trampoline` does not set up a new call frame. Thus, the frame
> > > pointer based unwinder could walk directly to the kretprobe'd caller.
> > > 
> > > For example, this stack is walked incorrectly with ORC + kretprobe:
> > > 
> > >     # bpftrace -e 'kretprobe:do_nanosleep { @[kstack] = count() }'
> > >     Attaching 1 probe...
> > >     ^C
> > > 
> > >     @[
> > >         kretprobe_trampoline+0
> > >     ]: 1
> > > 
> > > After this patch, the stack is walked correctly:
> > > 
> > >     # bpftrace -e 'kretprobe:do_nanosleep { @[kstack] = count() }'
> > >     Attaching 1 probe...
> > >     ^C
> > > 
> > >     @[
> > >         kretprobe_trampoline+0
> > >         __x64_sys_nanosleep+150
> > >         do_syscall_64+51
> > >         entry_SYSCALL_64_after_hwframe+68
> > >     ]: 12
> > > 
> > > Fixes: fc72ae40e303 ("x86/unwind: Make CONFIG_UNWINDER_ORC=y the default in kconfig for 64-bit")
> > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > 
> > OK, basically good, but this is messy, and doing much more than fixing issue.

Thanks for taking a look!

> BTW, is this a regression? or CONFIG_UNWINDER_ORC has this issue before?
> It seems that the above commit just changed the default unwinder. This means
> OCR stack unwinder has this bug before that commit.

I see your point -- I suppose it depends on point of view. Viewed from
userspace, a change in kernel defaults means that one kernel worked and
the next one didn't -- all without the user doing anything. Consider it
from the POV of a typical linux user who just takes whatever the distro
gives them and doesn't compile their own kernels.

From the kernel point of view, you're also right. ORC didn't regress, it
was always broken for this particular use case. But as a primarily
userspace developer, I would consider this a kernel regression.


> If you choose the CONFIG_UNWINDER_FRAME_POINTER, it might work again.

Yes, I've confirmed that switching to CONFIG_UNWINDER_FRAME_POINTER does
fix the issue. But it's a non-starter for production machines b/c the
perf regression is too significant.

Thanks,
Daniel
