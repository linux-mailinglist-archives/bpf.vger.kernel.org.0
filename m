Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738C6587464
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 01:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbiHAX3a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 19:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbiHAX32 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 19:29:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED4F422E1;
        Mon,  1 Aug 2022 16:29:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63D27B81250;
        Mon,  1 Aug 2022 23:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFF6C433D6;
        Mon,  1 Aug 2022 23:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659396565;
        bh=+tAKH5U9MjYkNE752i6vdc4km3iU4Hah9sUp7Z5hwiQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MIcSVcE/eFcKum0Ze1NoWJMNTpuglLoqZPMH5tSjiCHZ3VR5SIrf90902toEB42yR
         dbzqkfoo7S7IaqZKw3A5uM0lV6nCdRPhlegwNjinUathfxIpiUZEVJD24UgqTjES9H
         xMaFKga15S9s6sAPZ72xQrSX8rhQg+ooaHG/zBS0IyeToajmZyssvlImIYspxQFuVQ
         f2bN5FbxSwTPu9axy3im8eOLhASBtXggy/JLEYJIKovVMyV4gBXyflbOp6Oq7agqpo
         zkJPROBImOnKljAblSWk31Q/yCNduUis3kwBj4U4okqPtWZuhX9P41VWqr2SD73geW
         GIgyN36NpwYgg==
Date:   Tue, 2 Aug 2022 08:29:19 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, peterz@infradead.org,
        mingo@kernel.org, ast@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH v3] kprobes: Forbid probing on trampoline and bpf prog
Message-Id: <20220802082919.449c691237155cee9e190713@kernel.org>
In-Reply-To: <20220801165146.26fdeca2@gandalf.local.home>
References: <20220801033719.228248-1-chenzhongjin@huawei.com>
        <Yug6bx7T4GzqUf2a@krava>
        <20220801165146.26fdeca2@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 1 Aug 2022 16:51:46 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 1 Aug 2022 22:41:19 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > LGTM cc-ing Steven because it affects ftrace as well
> 
> Thanks for the Cc, but I don't quite see how it affects ftrace.
> 
> Unless you are just saying how it can affect kprobe_events?

Maybe kprobe_events can probe the ftrace trampoline buffer if
CONFIG_KPROBE_EVENTS_ON_NOTRACE=y.

> 
> -- Steve
> 
> 
> > 
> > jirka
> > 
> > > 
> > > v1 -> v2:
> > > Check core_kernel_text and is_module_text_address rather than
> > > only kprobe_insn.
> > > Also fix title and commit message for this. See old patch at [1].
> > > ---
> > >  kernel/kprobes.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > index f214f8c088ed..80697e5e03e4 100644
> > > --- a/kernel/kprobes.c
> > > +++ b/kernel/kprobes.c
> > > @@ -1560,7 +1560,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
> > >  	preempt_disable();
> > >  
> > >  	/* Ensure it is not in reserved area nor out of text */
> > > -	if (!kernel_text_address((unsigned long) p->addr) ||
> > > +	if (!(core_kernel_text((unsigned long) p->addr) ||
> > > +	    is_module_text_address((unsigned long) p->addr)) ||
> > >  	    within_kprobe_blacklist((unsigned long) p->addr) ||
> > >  	    jump_label_text_reserved(p->addr, p->addr) ||
> > >  	    static_call_text_reserved(p->addr, p->addr) ||
> > > -- 
> > > 2.17.1
> > >   
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
