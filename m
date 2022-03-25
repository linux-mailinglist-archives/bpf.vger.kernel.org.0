Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CA24E7543
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 15:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359357AbiCYOp1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 10:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245230AbiCYOpS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 10:45:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC23453E11;
        Fri, 25 Mar 2022 07:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cTgeBhPIbMY2V/22QHpipzHYQo1f8A2IaNn1vFaLLvc=; b=EEzOp9MMcWXnOV4bnHe7adlGGK
        xzrNIZa61NM4/fZPJ6JyvG9dcjT/gauP0EYpnwcC/yxTaQmbXa/I5RPqc42jIVjG9gzX07iE1VY5V
        gWS4FCAKfVQOziqea/TWGQ2Nf4aYsIOH9BWuurOC38DzprRD/zckDJjR8Yh6IJwvy7yu9hI3wPVhh
        FbTwtVQZZyHyKaRes4s1LUuIoz7mLWmAEGtlD3M3yBTJV3hjlmP+riqZ3YQr3y5SJ75AxW5BxIlS3
        J1VraOkrRotoV6yelwTxVNeVG2+BfME/k3Qy1TYEz6v06MV3K/1ORXzvQ/TzMuwb9Q3UIrVtOzZ4L
        8OZb9Aig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXl9o-00ERDU-FZ; Fri, 25 Mar 2022 14:43:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 320563002BE;
        Fri, 25 Mar 2022 15:43:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12064206DBC36; Fri, 25 Mar 2022 15:43:15 +0100 (CET)
Date:   Fri, 25 Mar 2022 15:43:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel-janitors@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/4] kprobes: rethook: x86: Replace kretprobe
 trampoline with rethook
Message-ID: <Yj3VAsgGA9zJvxgs@hirez.programming.kicks-ass.net>
References: <164821817332.2373735.12048266953420821089.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164821817332.2373735.12048266953420821089.stgit@devnote2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 25, 2022 at 11:22:53PM +0900, Masami Hiramatsu wrote:

> Masami Hiramatsu (3):
>       kprobes: Use rethook for kretprobe if possible
>       rethook: kprobes: x86: Replace kretprobe with rethook on x86
>       x86,kprobes: Fix optprobe trampoline to generate complete pt_regs
> 
> Peter Zijlstra (1):
>       Subject: x86,rethook: Fix arch_rethook_trampoline() to generate a complete pt_regs

You fat-fingered the subject there ^

Other than that:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Hopefully the ftrace return trampoline can also be switched over..
