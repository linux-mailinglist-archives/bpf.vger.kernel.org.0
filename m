Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1B450F849
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 11:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbiDZJPx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Apr 2022 05:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347523AbiDZJO0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Apr 2022 05:14:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FA71869EF
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 01:50:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09443B81CF0
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 08:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1B5C385A0;
        Tue, 26 Apr 2022 08:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650963052;
        bh=1RBQ9WprmBfrD085ZEjj9+AkzvCZBrPluRIDik/Sgr4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MqGr6GA/0oSmg7Y/VCr2+cHhhbQ/B69jjuujOpWrLcZawaYN+udh5Pp2vtptC3OxC
         5E99TzQ54+B7OcGTpYGpMQ5lxBzPqY14X3bbZjX3BMkhvJFwc8AFzky+21Rh+MFUod
         pBD2vOBT66vzBaqp5WwW+sbCX2PYEOwSfcsDl0bhE1xLA2bXSdpJgdUPpAVf7gM6R0
         Nkq2k92Q8KFiQxJPEeBGcCZNyA688dv1pGztgqpmUpCC++YaC5Fv/SCS/JQGsVJ/nQ
         aG4ZgcunWbAwSXGhPU3UMVvIpaUkklj3ResvCEIT75NyEV2T16fMSNX7FMg1Q1UnG4
         bVFYE6twgId7g==
Date:   Tue, 26 Apr 2022 17:50:48 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Adam Zabrocki <pi3@pi3.com.pl>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Solar Designer <solar@openwall.com>, bpf@vger.kernel.org,
        rostedt@goodmis.org
Subject: Re: [PATCH bpf] x86/kprobes: Fix KRETPROBES when
 CONFIG_KRETPROBE_ON_RETHOOK is set
Message-Id: <20220426175048.f2bf5526b7ff543ba5087c85@kernel.org>
In-Reply-To: <008a7004-ede5-8ffe-062c-ca77649ce3a7@iogearbox.net>
References: <20220422164027.GA7862@pi3.com.pl>
        <008a7004-ede5-8ffe-062c-ca77649ce3a7@iogearbox.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 25 Apr 2022 16:42:12 +0200
Daniel Borkmann <daniel@iogearbox.net> wrote:

> On 4/22/22 6:40 PM, Adam Zabrocki wrote:
> > [PATCH bpf] x86/kprobes: Fix KRETPROBES when CONFIG_KRETPROBE_ON_RETHOOK is set
> > 
> > The recent kernel change "kprobes: Use rethook for kretprobe if possible",
> > introduced a potential NULL pointer dereference bug in the KRETPROBE
> > mechanism. The official Kprobes documentation defines that "Any or all
> > handlers can be NULL". Unfortunately, there is a missing return handler
> > verification to fulfill these requirements and can result in a NULL pointer
> > dereference bug.
> > 
> > This patch adds such verification in kretprobe_rethook_handler() function.
> > 
> > Fixes: 73f9b911faa7 ("kprobes: Use rethook for kretprobe if possible")
> > Signed-off-by: Adam Zabrocki <pi3@pi3.com.pl>
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> I don't mind if this fix gets routed via bpf tree if all parties are okay with
> it (Masami? Steven?). Just noting that there is currently no specific dependency
> in bpf tree for it, but if it's easier to route this way, happy to take it.

Yeah, I and Steve talked about it and he suggested this to be merged
via BPF tree since the original commit came from the BPF tree.

Thank you,

> 
> > ---
> >   kernel/kprobes.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index dbe57df2e199..dd58c0be9ce2 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -2126,7 +2126,7 @@ static void kretprobe_rethook_handler(struct rethook_node *rh, void *data,
> >   	struct kprobe_ctlblk *kcb;
> >   
> >   	/* The data must NOT be null. This means rethook data structure is broken. */
> > -	if (WARN_ON_ONCE(!data))
> > +	if (WARN_ON_ONCE(!data) || !rp->handler)
> >   		return;
> >   
> >   	__this_cpu_write(current_kprobe, &rp->kp);
> > 
> 
> Thanks,
> Daniel


-- 
Masami Hiramatsu <mhiramat@kernel.org>
