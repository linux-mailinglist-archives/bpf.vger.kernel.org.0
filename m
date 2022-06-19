Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B71550D10
	for <lists+bpf@lfdr.de>; Sun, 19 Jun 2022 23:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiFSVKe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Jun 2022 17:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiFSVKe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Jun 2022 17:10:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5DD65B5
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 14:10:32 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so7428944pjm.4
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 14:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wpcr0WyX3XzBDoDEFyZq+WP5AW+MhcXpBJfGQetiVMg=;
        b=eP/Bc5131Aj8C1MZ5GZbSaNORf8df6tLuYkmx0y/H11pwavDc1exHB2/2oEbohC1w+
         kc7TKNeGnikJW8BFpDrseEC8Wwm2zudIqL0gP/4pY3HJeEcq2WGu1qyt9i4VxSDGzyqA
         gg7NioopZY2emixguHJQSqjvdQL3zaUALw3L6EhZXeMuUYMX+NnV/ndiliEeionzx/49
         QRiwl3pjRB/A6llt3M8MbWh9aA0MLJ2Sn0GM1YGPOjBA4lys6qnB2+wjXmpEgXiNqR2A
         WzlJNDG43PU+bAX/0QJcAlSvLmN83jZlCMjreq6OgS1juHY6a9u7kAc9+gO5JoOoP44o
         ypyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wpcr0WyX3XzBDoDEFyZq+WP5AW+MhcXpBJfGQetiVMg=;
        b=BMs6by3xy0tXQ4jO46J6w488v3BfR2Jdkk5O0vYNe45H7s7p/AxzvH1jIsnnPXQd+V
         HZZptaQOheng2nI4Zj7ZDrRuchW2jrGxSlGRuVx/VHwybSUPNyAb4ToCnNnWPH7e9Txa
         X0aIFlPlQvzaLzgClc9s/3uc/li+6dSDtIU4nBgvLlFt1o8LKOF3Ya4cPXhINa+Q08TW
         nY/55/EitZfZ6o4PXOfkvdpkdDQar8N6dcpSBysK7fgMUmR0cvXR5BGVfB0BHEqOcj8x
         RtuFJp6EeyrwNy4v+LSAr8fYt0iN/IYM5QOstnCRpS2WxLxiD1Clznrr/BEVs1xe7+jc
         as1A==
X-Gm-Message-State: AJIora+lc6dv5YwgB3s7VLWICf+hr0xKsUt2oz27PLwutR93qUZXOYM5
        SZsnJAJVhJq17kc6RmQU2v4=
X-Google-Smtp-Source: AGRyM1t2BuOS/PBlFknsMi9G9FJKMKkDcK7qOAwh0EMKL5Yzgbn+BOehD/SDSp6xuAhfo54SIAi8gw==
X-Received: by 2002:a17:902:9f87:b0:16a:1efc:42fe with SMTP id g7-20020a1709029f8700b0016a1efc42femr3928641plq.124.1655673032253;
        Sun, 19 Jun 2022 14:10:32 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:29cb])
        by smtp.gmail.com with ESMTPSA id j5-20020a17090adc8500b001e34b5ed5a7sm9006910pjv.35.2022.06.19.14.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 14:10:31 -0700 (PDT)
Date:   Sun, 19 Jun 2022 14:10:28 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Song Liu <song@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v7 3/5] bpf: Inline calls to bpf_loop when
 callback is known
Message-ID: <20220619211028.tuhgxmtivvwkzo7m@macbook-pro-3.dhcp.thefacebook.com>
References: <20220613205008.212724-1-eddyz87@gmail.com>
 <20220613205008.212724-4-eddyz87@gmail.com>
 <CAADnVQ+rwwCoEPQUg+CS_iXSzqoptrgtW4TpqoM9XkMW9Jj+ag@mail.gmail.com>
 <fb17ffcbdfa6b75813352133c5655f01aefe71ec.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb17ffcbdfa6b75813352133c5655f01aefe71ec.camel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jun 19, 2022 at 11:09:36PM +0300, Eduard Zingerman wrote:
> Hi Daniel, Alexei, 
> 
> > On Fri, 2022-06-17 at 01:12 +0200, Daniel Borkmann wrote:
> > On Thu, 2022-06-16 at 19:14 -0700, Alexei Starovoitov wrote:
> > On Mon, Jun 13, 2022 at 1:50 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > > +
> > > +static bool loop_flag_is_zero(struct bpf_verifier_env *env)
> [...]
> > 
> > Great catch here by Daniel.
> > It needs mark_chain_precision().
> 
> Thanks for the catch regarding precision tracking. Unfortunately I
> struggle to create a test case that demonstrates the issue without the
> call to `mark_chain_precision`. As far as I understand this test case
> should look as follows:
> 
> 
> 	... do something in such a way that:
> 	  - there is a branch where
> 	    BPF_REG_4 is 0, SCALAR_VALUE, !precise
> 	    and this branch is explored first
> 	  - there is a branch where
> 	    BPF_REG_4 is 1, SCALAR_VALUE, !precise
> 
> 	/* create branching point */
> 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 0),
> 	/* load callback address to r2 */
> 	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 5),
> 	BPF_RAW_INSN(0, 0, 0, 0, 0),
> 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
> 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
> 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
> 	BPF_EXIT_INSN(),
> 	/* callback */
> 	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
> 	BPF_EXIT_INSN(),
> 
> The "do something" part would then rely on the state pruning logic to
> skip the verification for the second branch. Namely, the following
> part of the `regsafe` function should consider registers identical:
> 
> /* Returns true if (rold safe implies rcur safe) */
> static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
> 			struct bpf_reg_state *rcur, struct bpf_id_pair *idmap)
> {
> 	...
> 	switch (base_type(rold->type)) {
> 	case SCALAR_VALUE:
> 		...
> 		if (rcur->type == SCALAR_VALUE) {
> here ->			if (!rold->precise && !rcur->precise)
> 				return true;
> 			...
> 		} else {
> 			...
> 		}
> 		...	
> 	}
> 	...	
> }
> 
> However, I don't understand what instructions could mark the register
> as a scalar with particular value, but w/o `precise` mark. I tried
> MOV, JEQ, JNE, MUL, sequence of BPF_ALU64_IMM(MOV, ...) - BPF_STX_MEM
> - BPF_LDX_MEM to no avail.

> The following observations might be relevant:
> - `__mark_reg_known` does not change the state of the `precise` mark;

yes.
Just BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0) and ,1) in the other branch
should do it.
The 'mov' won't make the register precise.

So something like below:

r0 = random_u32
r6 = random_u32
if (r0)
   goto L;

r4 = 0

pruning_point:
if (r6) goto next;
next:
/* load callback address to r2 */
BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 5),
BPF_RAW_INSN(0, 0, 0, 0, 0),
BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
BPF_EXIT_INSN(),

L:
r4 = 1
goto pruning_point

The fallthrough path will proceed with r4=0
and pruning will trigger is_state_visited() with r4=1
which regsafe will incorrectly recognize as equivalent.

