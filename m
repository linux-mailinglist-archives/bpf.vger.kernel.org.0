Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF1A5AB75F
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 19:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbiIBRVB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 13:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbiIBRVA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 13:21:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6110C12FA
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 10:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5q4ON7dgvqGPsNeX1sW9LxtFM0ApP0M/CrDWxGZ8U/o=; b=vUIlXVyn5PNluVKf58t/ytQ13M
        yZ86Gl1rJAxcVePVLgCAF1T7x4MEzW/pTIpXDgSZIo/2xKKCVRgb71aqmY8pxpXL5K4OcNpqVMPtq
        Xt0A0xF3dbJ4BTNAqDxOP2vHnGt7F2Qbnkkwrc3EI3XNJTXFPuwxB9ARGPlgu03N6xRAquvcPGkIT
        zsdh/ylcAyZJCXIHVSh6sTdyZzNoT2kMjaQ3o7vfW9RuqLWTOnIPGuWuTOblk8XiUBAFMxlCOP2Up
        JyqJSRytdfb5k0LW8mygKjFpI6MX6GH4HYqpqnAlo4o3u/19/VtImHmG92AqXk0GtbSl1I9DnFfXB
        VY69eHmw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oUALS-007CS0-Ce; Fri, 02 Sep 2022 17:20:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6F43630029C;
        Fri,  2 Sep 2022 19:20:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B3C02B9048DE; Fri,  2 Sep 2022 19:20:40 +0200 (CEST)
Date:   Fri, 2 Sep 2022 19:20:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCHv2 bpf-next 2/2] bpf: Move bpf_dispatcher function out of
 ftrace locations
Message-ID: <YxI7aC4L495CwZWE@hirez.programming.kicks-ass.net>
References: <20220901134150.418203-1-jolsa@kernel.org>
 <20220901134150.418203-3-jolsa@kernel.org>
 <YxHli+6C5rylF3EH@hirez.programming.kicks-ass.net>
 <YxI1EtYjkLaooFm8@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxI1EtYjkLaooFm8@krava>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 02, 2022 at 06:53:38PM +0200, Jiri Olsa wrote:
> > Are you sure you want the notrace x86_64 only?
> > 
> > That is, perhaps something like this...
> > 
> > +#ifdef CONFIG_X86_64
> > +#define BPF_DISPATCHER_ATTRIBUTES	   __attribute__((patchable_function_entry(5)))
> > +#else
> > +#define BPF_DISPATCHER_ATTRIBUTES
> > +#endif
> > +
> >  #define DEFINE_BPF_DISPATCHER(name)					\
> > +	notrace BPF_DISPATCHER_ATTRIBUTES				\
> >  	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
> > 
> 
> that's also an option.. but I don't this it's big deal that the function
> is traceable on other arches, because the dispatcher image is generated
> only on x86, so no other arch is touching that function entry, so it's
> safe for ftrace to attach

It just seems like a pointless difference.

From a code-gen POV you don't strictly need the notrace; without it
it'll generate:

bpf_dispatcher_name_func:
	nop
	nop
	nop
	nop
	nop
	call __fentry__
	RET

It'll just function 'weird', but it'll 'work'.
