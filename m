Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6934356A5
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 02:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhJUAHW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 20:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJUAHV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 20:07:21 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C88C06161C;
        Wed, 20 Oct 2021 17:05:06 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so3589482pjb.3;
        Wed, 20 Oct 2021 17:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DJt7lhYi4fhHKDW9Hf2SKDLfs1y2zkAh3j1RrAI1z/k=;
        b=jOGkmaT61ymJEiZJfnoS80k6E14isokbplin6CC1rCz+tYd+r6Nu+/kQS8o/3Btgj2
         tx8Dk6IfZtqr44B+tI3bJnddF8HzVSrrIGUAnnVLxdeh9piF4vE6tqbMVtMgrtXYGLVN
         ypPnfx+dMMkumoWAuRjFG0rSy1ftqC66jDMztjiGJH50ldB8XluYnclvHZMxGYAt5zBM
         1FcdguLDywv+BT7XPLdnwmaNU19yb9+QRYnwH6fMEBCGP/thSeTWs510+G9J2JxvLFCU
         4GxlNpkgp3Fgm9rbcdSo5Ht6bi7juW1M1sfOnQ14KqV1AOBaKjOohLux82b5iF4ziOtb
         +eFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DJt7lhYi4fhHKDW9Hf2SKDLfs1y2zkAh3j1RrAI1z/k=;
        b=0FdP3rWW0qoeFQq257ZIzsy6XMlcRdBxN8zgWfF57IRWP/FVhuGygX3xeaBQKT+MAs
         sRGwo47RVuMO3xmeTu5p/wsLiJ+Osh+36xTcLnRRShZIkvpFZjhns7aJ2HGlsaFnWVwL
         s9H2Zo/jeej2Kij/Ix4NhQuU0h1j8sgNNysZS8LgdR7urCvOllUaBXa+p2SEEV1HPMbW
         tDmVf/Um6LJ5a632mlO6zFp/4TfZqa2EgfIJjUWSRtpiNIRvF6Ra8IIIKxEL9miOXAou
         Ua/XOi7y3mqZdYEVlEM05+O8Fuzb23bMR/Ho1zfY7lOssNmrJ3wH/LW6f8qvYsm2vFo2
         nw0A==
X-Gm-Message-State: AOAM530/2vFWkIpsO9GFu3te14viRu584tFk6/Fo215KA/KJifTua7TZ
        RCLSchv+7UK6HD/sResvw8s=
X-Google-Smtp-Source: ABdhPJxu+xSz00BD5P6rgkAQ/rJIhaGUs5hbEv+rs3HKhjh5+uesFxoFaQ779boP6QQrTdZgcRHb0A==
X-Received: by 2002:a17:90a:f68a:: with SMTP id cl10mr2334628pjb.39.1634774705888;
        Wed, 20 Oct 2021 17:05:05 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:8c95])
        by smtp.gmail.com with ESMTPSA id b10sm3624707pfi.122.2021.10.20.17.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 17:05:05 -0700 (PDT)
Date:   Wed, 20 Oct 2021 17:05:02 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        daniel@iogearbox.net, bpf@vger.kernel.org, andrii@kernel.org
Subject: Re: [PATCH v2 14/14] bpf,x86: Respect X86_FEATURE_RETPOLINE*
Message-ID: <20211021000502.ltn5o6ji6offwzeg@ast-mbp.dhcp.thefacebook.com>
References: <20211020104442.021802560@infradead.org>
 <20211020105843.345016338@infradead.org>
 <YW/4/7MjUf3hWfjz@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW/4/7MjUf3hWfjz@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 20, 2021 at 01:09:51PM +0200, Peter Zijlstra wrote:
> > -	RETPOLINE_RCX_BPF_JIT();
> > +	emit_indirect_jump(&prog, 1 /* rcx */, ip + (prog - start));
> >  
> >  	/* out: */
> >  	*pprog = prog;
> 
> Alexei; could the above not be further improved with something like the
> below?

sorry for delay. I was traveling last week
and Daniel is on PTO this week.

> Despite several hours trying and Song helping, I can't seem to run
> anything bpf, that stuff is cursed. So I've no idea if the below
> actually works, but it seems reasonable.

It's certainly delicate.

> @@ -446,25 +440,8 @@ static void emit_bpf_tail_call_indirect(
>  {
>  	int tcc_off = -4 - round_up(stack_depth, 8);
>  	u8 *prog = *pprog, *start = *pprog;
> -	int pop_bytes = 0;
> -	int off1 = 42;
> -	int off2 = 31;
> -	int off3 = 9;
> -
> -	/* count the additional bytes used for popping callee regs from stack
> -	 * that need to be taken into account for each of the offsets that
> -	 * are used for bailing out of the tail call
> -	 */
> -	pop_bytes = get_pop_bytes(callee_regs_used);
> -	off1 += pop_bytes;
> -	off2 += pop_bytes;
> -	off3 += pop_bytes;
> -
> -	if (stack_depth) {
> -		off1 += 7;
> -		off2 += 7;
> -		off3 += 7;
> -	}
> +	static int out_label = -1;

Interesting idea!
All insn emits trying to do the right thing from the start.
Here the logic assumes that there will be at least two passes over image.
I think that is correct, but we never had such assumption.
A comment is certainly must have.
The race is possible too. Not sure whether READ_ONCE/WRITE_ONCE
are really warranted though. Might be overkill.

Nice that Josh's test_verifier is passing, but it doesn't provide
a ton of coverage. test_progs has a lot more.
Once you have a git branch with all the changes I can give it a go.
Also you can rely on our BPF CI.
Just cc your patchset to bpf@vger and add [PATCH bpf-next] to a subject.
In patchwork there will be "bpf/vmtest-bpf-next" link that
builds kernel, selftests and runs everything.
It's pretty much the same as selftests/bpf/vmtest.sh, but with the latest
clang nightly and other deps like pahole.
