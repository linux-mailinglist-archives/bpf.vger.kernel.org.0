Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5A5632566
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 15:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiKUORz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 09:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiKUOR2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 09:17:28 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49725E2D;
        Mon, 21 Nov 2022 06:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EMCl5oMpuM9wnhlFxFjEmmZ528S5z63LS0hMgcGZHmk=; b=M69cgxbdLRliIML9yojGFTMxmC
        0YAcv+2L0fAKvbtNm6X/YNgoSrZttGWKCYIznxjkBN9FEIneyU7+xW3++eB5/Wq7+ZNBWQpH/+zIu
        FaqQEF7Y9ycVEsIzALqF4Eg2UDyFpPd3+T6pUtfFSTRtadPYBTbxHpfcl86pJfkMZR+iwpBsrDJnu
        +Hg6o0hlif6PXUmAKQxnwfEFLbB6Faq+Mt0jb/ErHx271JdMCZ3AzF+u1fbMVNLTw5IQnJLraClcg
        f+wjEmK44Va1Qty1+/rK5T5uZ3z6F+Quj1bzGVuf34NvbVAj2MrK/vrKZngvR1c49uHbz26gr661a
        56AjpqjA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ox7bT-0038SQ-VA; Mon, 21 Nov 2022 14:16:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A7268300244;
        Mon, 21 Nov 2022 15:16:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8CB112D412ED1; Mon, 21 Nov 2022 15:16:54 +0100 (CET)
Date:   Mon, 21 Nov 2022 15:16:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     Chris Mason <clm@meta.com>, Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Florent Revest <revest@chromium.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Brendan Jackman <jackmanb@google.com>, markowsky@google.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Xu Kuohai <xukuohai@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 0/1] BPF tracing for arm64 using fprobe
Message-ID: <Y3uIVknDWTS0bMTT@hirez.programming.kicks-ass.net>
References: <CAADnVQ+BWpzqOV8dGCR=A3dR3u60CkBkqSXEQHe2kVqFzsgnHw@mail.gmail.com>
 <20221117121617.4e1529d3@gandalf.local.home>
 <d24cded7-87b1-89f5-fc2a-5346669f6d57@meta.com>
 <20221117174030.0170cd36@gandalf.local.home>
 <Y3e0KtnQrudxiZbz@FVFF77S0Q05N.cambridge.arm.com>
 <20221118114519.2711d890@gandalf.local.home>
 <43d5d1f5-c01d-c0db-b421-386331c2b8c1@meta.com>
 <20221118130608.5ba89bd8@gandalf.local.home>
 <2ab2b854-723a-5f15-8c18-0b5730d1b535@meta.com>
 <CACYkzJ613nhXViBpDuGWeEWzjfSJjbB1=KNpYtNDC6Xn7yizbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACYkzJ613nhXViBpDuGWeEWzjfSJjbB1=KNpYtNDC6Xn7yizbw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 02:47:10PM +0100, KP Singh wrote:

> > > How do I know that a function return was modified by BPF? If I'm debugging
> 
> You can list the BPF programs that are loaded in the kernel with
> 
> # bpftool prog list

Only when you have access to the machine; most cases it's people sending
random splats by email.

> Also, the BPF programs show up in call stacks when you are debugging.

Only when it splats inside the BPF part, not when it splats after
because BPF changed semantics of a function.


