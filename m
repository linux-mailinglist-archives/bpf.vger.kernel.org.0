Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D02575607
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 21:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiGNT6J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 15:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiGNT6I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 15:58:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CFD57210;
        Thu, 14 Jul 2022 12:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B2jr/3frCctEW27dermWNQ8i6KyhP3JVqMfQDwDHZjA=; b=hVEJYr2zXRgYx3w9ib5XzoVw7E
        ZV2JiN5sj/13QkpVpG/ACognSo+jlqrTarcO1tRkTrzOUsQPB1oF6O6l99lS0E0mSqlgA22KCmgGS
        Q4VyJELFwkzbFSPFWSM7dVwIMPuwFEz4LzcMINsHrBlLazs2MfdaMVqN/bVdlnBZKyzvMEmFNV7pj
        galy+XGL2wdd1o5PTwGKusUYLLaksZTB9F+s5jTVZiRSP1EEl0p3rBdLTYiW7pUhwpKABHFW/sipu
        H73e6Te3KaWCVf1FGd4mPYUqQRV5xhpXc6uxSgAsnwblVlN+CVpQr/ZoNosj7leAnjEUFZ8i2z05E
        8LY8HkkA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oC4y6-009duX-5C; Thu, 14 Jul 2022 19:57:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB2F1980185; Thu, 14 Jul 2022 21:57:48 +0200 (CEST)
Date:   Thu, 14 Jul 2022 21:57:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitrii Dolgov <9erthalion6@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        songliubraving@fb.com, rostedt@goodmis.org, mingo@redhat.com,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v4 1/1] perf/kprobe: maxactive for fd-based kprobe
Message-ID: <YtB1PK+NUF5RL9Er@worktop.programming.kicks-ass.net>
References: <20220714193403.13211-1-9erthalion6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714193403.13211-1-9erthalion6@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 14, 2022 at 09:34:03PM +0200, Dmitrii Dolgov wrote:
> From: Song Liu <songliubraving@fb.com>
> 
> Enable specifying maxactive for fd based kretprobe. This will be useful
> for tracing tools like bcc and bpftrace (see for example discussion [1]).
> Use highest 4 bit (bit 59-63) to allow specifying maxactive by log2.

What's maxactive? This doesn't really tell me much. Why are the top 4
bits the best to use?

> 
> The original patch [2] seems to be fallen through the cracks and wasn't
> applied. I've merely rebased the work done by Song Liu, verififed it
> still works, and modified to allow specifying maxactive by log2 per
> suggestion from the discussion thread.

That just doesn't belong in a Changelog.

> 
> Note that changes in rethook implementation may render maxactive
> obsolete.

Then why bother creating an ABI for it?

> 
> [1]: https://github.com/iovisor/bpftrace/issues/835
> [2]: https://lore.kernel.org/all/20191007223111.1142454-1-songliubraving@fb.com/
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Lots of question and not a single answer in sight... 
