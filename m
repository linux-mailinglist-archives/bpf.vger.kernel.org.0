Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E5E5B3D64
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 18:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiIIQs7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 12:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiIIQsf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 12:48:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF41B147392;
        Fri,  9 Sep 2022 09:48:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EF936206C;
        Fri,  9 Sep 2022 16:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DC4C433D7;
        Fri,  9 Sep 2022 16:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662742091;
        bh=ge3azleKQIYkuBpckfP09X8CM/yhfPnFKDBRDnymxcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDV9HYWYLd1v1kgyhgCQejDbaPW92W0Utf0XCxm2+tvUKsJhAKOvjGG1YLDluFZbU
         nhLs5YTc49Wyd9uA15+OBxrjarumGAZXjzB3pWodWArcTnJNyq9lY90CWzTlu2yOgq
         ql2CH3aU35iOya3eebqIkozYrEVrKFvBl6nd5qo2/D89qeUpWuPXfMNgKOKo7Zl8MW
         7adx0uI2zeiFhIqhlqXdDB/3JsVp4R3JOzgjWbM7pujYjomxKF0KLWY1/gpf6Sf2Ub
         s02wtbv69TC8gyqE9AdCXqwSS8ZQG+Vqcz2ZnihiQDksM3YF+9r7Ck7hCu6kkUXSQ6
         R+/vefyXp2R/A==
Date:   Fri, 9 Sep 2022 09:48:09 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>, X86 ML <x86@kernel.org>
Subject: Re: [PATCH] x86,retpoline: Be sure to emit INT3 after JMP *%\reg
Message-ID: <20220909164809.k5vkeujwpvywkpmt@treble>
References: <166260087224.759381.4170102827490658262.stgit@devnote2>
 <166260088298.759381.11727280480035568118.stgit@devnote2>
 <20220908050855.w77mimzznrlp6pwe@treble>
 <Yxm2QU1NJIkIyrrU@hirez.programming.kicks-ass.net>
 <Yxm+QkFPOhrVSH6q@hirez.programming.kicks-ass.net>
 <CAADnVQKWTaXFqYri9VG3ux-CJEBsjAP5PetH6Q1ccS8HoeP28g@mail.gmail.com>
 <Yxr2TaWaN8VjJ60D@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yxr2TaWaN8VjJ60D@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 09, 2022 at 10:16:13AM +0200, Peter Zijlstra wrote:
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -419,7 +419,9 @@ static void emit_indirect_jump(u8 **ppro
>  		OPTIMIZER_HIDE_VAR(reg);
>  		emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
>  	} else {
> -		EMIT2(0xFF, 0xE0 + reg);
> +		EMIT2(0xFF, 0xE0 + reg);	/* jmp *%\reg */
> +		if (IS_ENABLED(CONFIG_RETPOLINE) || IS_ENABLED(CONFIG_SLS))
> +			EMIT1(0xCC);		/* int3 */
>  	}

Hm, if you have retpolines disabled at runtime, why would you want this.

-- 
Josh
