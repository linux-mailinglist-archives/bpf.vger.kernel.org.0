Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444DD59326C
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 17:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiHOPtK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 11:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiHOPtA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 11:49:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADE9EE32;
        Mon, 15 Aug 2022 08:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P5wY5zgg3rjOGWIVZoee4r16o0xMuIGJOZZTb6Q98pw=; b=cGyHTvHgOgGnA3KI+8g9w+XWlt
        N/0YnVmrgyjEAkR/jU/cyKgYsOOyrOu8Y1c+vunhtZQCKA4ZdEtrEwD49WJf/9QWRc//3g8D4YqVp
        DXX/ZDLGBSBuP9I1f9ZuRpaPakNRJqj7bxXP3WgvGEgXg7AlktKH1QKAb4LJ39AIDjEAonl3b6REk
        qgy6llVcH+zA8neTygsz1XUcBAk6uEYaB6363ngNIjhwcJORPC27TiEJcyCaP0gezi2gmdoNUNBAE
        Knszmkl3DyH4Uo25vNxpDvKNEXFPSo/y0WanxovWiil8U7KbOOXE23CDnyeUIjSlNHOrJepfbTzHt
        zIIipRlw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNcKb-005q2a-BO; Mon, 15 Aug 2022 15:48:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8613F9801D4; Mon, 15 Aug 2022 17:48:44 +0200 (CEST)
Date:   Mon, 15 Aug 2022 17:48:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
Message-ID: <Yvpq3JDk8fTgdMv8@worktop.programming.kicks-ass.net>
References: <Yvn9xR7qhXW7FnFL@worktop.programming.kicks-ass.net>
 <YvoVgMzMuQbAEayk@krava>
 <Yvo+EpO9dN30G0XE@worktop.programming.kicks-ass.net>
 <CAADnVQJfvn2RYydqgO-nS_K+C8WJL7BdCnR44MiMF4rnAwWM5A@mail.gmail.com>
 <YvpZJQGQdVaa2Oh4@worktop.programming.kicks-ass.net>
 <CAADnVQKyfrFTZOM9F77i0NbaXLZZ7KbvKBvu7p6kgdnRgG+2=Q@mail.gmail.com>
 <Yvpf67eCerqaDmlE@worktop.programming.kicks-ass.net>
 <CAADnVQKX5xJz5N_mVyf7wg4BT8Q2cNh8ze-SxTRfk6KtcFQ0=Q@mail.gmail.com>
 <YvpmAnFldR0iwAFC@worktop.programming.kicks-ass.net>
 <CAADnVQJuDS22o7fi9wPZx9siAWgu1grQXXB02KfasxZ-RPdRSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJuDS22o7fi9wPZx9siAWgu1grQXXB02KfasxZ-RPdRSw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 08:35:53AM -0700, Alexei Starovoitov wrote:
> On Mon, Aug 15, 2022 at 8:28 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Aug 15, 2022 at 08:17:42AM -0700, Alexei Starovoitov wrote:
> > > It's hiding a fake function from ftrace, since it's not a function
> > > and ftrace infra shouldn't show it tracing logs.
> > > In other words it's a _notrace_ function with nop5.
> >
> > Then make it a notrace function with a nop5 in it. That isn't hard.
> 
> That's exactly what we're trying to do.

All the while claiming ftrace is broken while it is not.

> Jiri's patch is one way to achieve that.

Fairly horrible way.

> What is your suggestion?

Mailed it already.

> Move it from C to asm ?

Would be much better than proposed IMO.

> Make it naked function with explicit inline asm?

Can be made to work but is iffy because the compiler can do horrible
things with placing the asm().
