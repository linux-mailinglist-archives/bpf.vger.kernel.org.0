Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAE167AD9A
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 10:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbjAYJRG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 04:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjAYJRF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 04:17:05 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CFA42DCF;
        Wed, 25 Jan 2023 01:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v4+Ubjw7AoXhgXeA4YKb/blLYieE36zolgnmCKDWMaQ=; b=PWZuXTBiSc8LCj9cdn0+AnFvjN
        zB0glAj0lJcTES3hfB7UtJlzSluJ8M4Yvt4oh6waOtOum2+4ZBzbPnjNSXADhOfB7s9Vbqpmc1P49
        j658tOcZkbmVBMSgCorIbPwiBerE4zHleGY4BJQ9/NNhoXk/wYH4ZU+MCeaettZlSCheoGSW2GMVr
        2+9lrL7caIC1r3xxRVoPDsFyYiSSvNfuOhO8nlzJYKbQPxAhGsQB+ajtO4ioX1QpSXst9aobE1kU6
        vrpdN3L4Ct2CFXS+UyK2hr4kfk8ys3R2p0VrT0loTxqhh85S1kHg3OT+LKst/Ibf6YxvnrGA+tuQ3
        Z+5eQ3CA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pKbt0-0026uI-0x;
        Wed, 25 Jan 2023 09:16:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F593300137;
        Wed, 25 Jan 2023 10:16:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D728A2C5B6905; Wed, 25 Jan 2023 10:16:35 +0100 (CET)
Date:   Wed, 25 Jan 2023 10:16:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/2] perf/tracing: Use stage6 of tracing to not duplicate
 macros
Message-ID: <Y9Dzczg7xZTTAnyp@hirez.programming.kicks-ass.net>
References: <20230124202238.563854686@goodmis.org>
 <20230124202515.716458410@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124202515.716458410@goodmis.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 24, 2023 at 03:22:39PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The perf events are created by the same macro magic as tracefs trace
> events are. But to hook into perf, it has its own code. It duplicates many
> of the same macros as the tracefs macros and this is an issue because it
> misses bug fixes as well as any new enhancements that come with the other
> trace macros.
> 
> As the trace macros have been put into their own staging files, have perf
> take advantage of this and use the tracefs stage 6 macros that the "fast
> assign" portion of the trace event macro uses.
> 
> Link: https://lore.kernel.org/lkml/1671181385-5719-1-git-send-email-quic_linyyuan@quicinc.com/
> 
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Ingo Molnar <mingo@elte.hu>
> Reported-by: Linyu Yuan <quic_linyyuan@quicinc.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
