Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5489D58727D
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 22:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiHAUvw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 16:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbiHAUvv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 16:51:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2774BE3D;
        Mon,  1 Aug 2022 13:51:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62399611C5;
        Mon,  1 Aug 2022 20:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B779C433D6;
        Mon,  1 Aug 2022 20:51:48 +0000 (UTC)
Date:   Mon, 1 Aug 2022 16:51:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, peterz@infradead.org,
        mingo@kernel.org, ast@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH v3] kprobes: Forbid probing on trampoline and bpf prog
Message-ID: <20220801165146.26fdeca2@gandalf.local.home>
In-Reply-To: <Yug6bx7T4GzqUf2a@krava>
References: <20220801033719.228248-1-chenzhongjin@huawei.com>
        <Yug6bx7T4GzqUf2a@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 1 Aug 2022 22:41:19 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> LGTM cc-ing Steven because it affects ftrace as well

Thanks for the Cc, but I don't quite see how it affects ftrace.

Unless you are just saying how it can affect kprobe_events?

-- Steve


> 
> jirka
> 
> > 
> > v1 -> v2:
> > Check core_kernel_text and is_module_text_address rather than
> > only kprobe_insn.
> > Also fix title and commit message for this. See old patch at [1].
> > ---
> >  kernel/kprobes.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index f214f8c088ed..80697e5e03e4 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -1560,7 +1560,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
> >  	preempt_disable();
> >  
> >  	/* Ensure it is not in reserved area nor out of text */
> > -	if (!kernel_text_address((unsigned long) p->addr) ||
> > +	if (!(core_kernel_text((unsigned long) p->addr) ||
> > +	    is_module_text_address((unsigned long) p->addr)) ||
> >  	    within_kprobe_blacklist((unsigned long) p->addr) ||
> >  	    jump_label_text_reserved(p->addr, p->addr) ||
> >  	    static_call_text_reserved(p->addr, p->addr) ||
> > -- 
> > 2.17.1
> >   

