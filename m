Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C5E650E8E
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 16:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbiLSPXg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 10:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiLSPXf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 10:23:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F09640D;
        Mon, 19 Dec 2022 07:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=buA/ZEow5OjkGUtOsIBYGacja4Fo6Mielfu3hKR75DQ=; b=rSDogOt/lnBUdJPhFbObGx09xp
        7+7Lm9V4wk39bJ33dkaYKYPcjA/jGvBtO81NJyi45vPdIP8EIp36MRebWL+fX4l9MACM5oyOSBu1L
        jEE4s9Crb6UWcLQ4Le5715Un6OSyT6k2qlt1I4tyIg2P7enmiODLda2ROQ0qY3OxMqSPf04J+m6lm
        0vzGuKDqdfA3DKxWlNAR/BkZ29HNxKuW+aI+rUziQ9pbQJLD4N89a3R/aNuHrtHgjgQacB+yAZany
        q0E4JEUhpfLFgyy/7syixwTzSApzhhnF8TtotbVqWkqym25vDx14u6RPdsTZ8qswdpOezuXDnd1uq
        YafjDnOA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7HzM-000pwx-0T; Mon, 19 Dec 2022 15:23:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 93BB630029B;
        Mon, 19 Dec 2022 16:23:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E957120A1AB9C; Mon, 19 Dec 2022 16:23:23 +0100 (CET)
Date:   Mon, 19 Dec 2022 16:23:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH -tip v4 0/2] x86/kprobes: Fix to check not-kprobe's int3
 correctly
Message-ID: <Y6CB698Owg87wIbs@hirez.programming.kicks-ass.net>
References: <167146050052.1374301.10407562178447545337.stgit@devnote3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167146050052.1374301.10407562178447545337.stgit@devnote3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 19, 2022 at 11:35:00PM +0900, Masami Hiramatsu (Google) wrote:
> Masami Hiramatsu (Google) (2):
>       x86/kprobes: Fix kprobes instruction boudary check with CONFIG_RETHUNK
>       x86/kprobes: Fix optprobe optimization check with CONFIG_RETHUNK
> 

Thanks, I'll go queue these in x86/urgent after -rc1 happens.
