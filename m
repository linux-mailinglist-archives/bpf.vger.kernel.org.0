Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAE5DF816F
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2019 21:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfKKUjy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Nov 2019 15:39:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44308 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfKKUjy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Nov 2019 15:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FrCEhSv8hbilrcVPSwF7OcJ4QNJOEonjfUoYBbUvopo=; b=MMa3Yel7lVOwUWWPEWEoFF+sC
        OHXYXFLJjc+MKTFb85UH/Z8ZbU0p/e7kRnzLRMt4tdvZrCIXVVeaFFbIL6/BD3pL5v3y4hW0tcy61
        ZjdJeGNTo0jBToend7GpjurqxE4v6FWA+DRWrsJ8U6REqN8fV2S/w0yEgxKIz0jAN/bOdPsxNJ/5j
        S01elhAoX5KZr0Rm8lzLE1Ch82C6dBaAgeUOI/okNHojIJqJSjnb8j3otlX8iuv4iNzpBvfQqgpI+
        t3QxU0FcoY9vnEPu6rJr+klSlanwcLmBPBl7Wl+7qb5EMjc2PWuSKa5Gl10cwz/eEDZ70LqOZI7Vw
        jJUEryOqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUGTG-0005Bz-R5; Mon, 11 Nov 2019 20:39:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 53502306CAC;
        Mon, 11 Nov 2019 21:38:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FE0320302EF6; Mon, 11 Nov 2019 21:39:31 +0100 (CET)
Date:   Mon, 11 Nov 2019 21:39:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        kernel-team@fb.com
Subject: Re: [PATCH -v5 00/17] Rewrite x86/ftrace to use text_poke (and more)
Message-ID: <20191111203931.GU4131@hirez.programming.kicks-ass.net>
References: <20191111131252.921588318@infradead.org>
 <20191111194726.udayafzpqxeqjyrj@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111194726.udayafzpqxeqjyrj@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 11, 2019 at 11:47:28AM -0800, Alexei Starovoitov wrote:

> One more question.
> What is the reason you stick to int3 style poking when 8 byte write is atomic?
> Can text_poke() patch nop5 by combining the call/jmp5 insn with extra 3 bytes
> after the nop and write 8 ?

I think that question came up a while back (in one of the many
static_call threads IIRC), and it basically boils down to there being
far too many x86 uarchs to be sure of anything.

Instruction fetch width is not always (well) specified and aligning
instructions on i-fetch boundaries (or ensuring they don't cross) was
deemed too fragile (also, it wastes space).

This scheme is blessed by the hardware folks, and while it might be
a little cumbersome, it isn't too horrible. Also, actually using that
exception turns out to be beneficial for tracing text changes, see also
this thread:

  https://lkml.kernel.org/r/20191025130000.13032-2-adrian.hunter@intel.com
