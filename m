Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170846BD446
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 16:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjCPPrT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 11:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjCPPrH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 11:47:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959872F7B4;
        Thu, 16 Mar 2023 08:46:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0994B62079;
        Thu, 16 Mar 2023 15:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC840C433EF;
        Thu, 16 Mar 2023 15:45:47 +0000 (UTC)
Date:   Thu, 16 Mar 2023 11:45:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
        mark.rutland@arm.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com, lihuafei1@huawei.com
Subject: Re: [PATCH v2 04/10] ftrace: Store direct called addresses in their
 ops
Message-ID: <20230316114544.5db09039@gandalf.local.home>
In-Reply-To: <CABRcYmLLbRGZXWwEpyLW1YFz87tTPA8pCL7oLd4K6Hp9Etr5LA@mail.gmail.com>
References: <20230207182135.2671106-1-revest@chromium.org>
        <20230207182135.2671106-5-revest@chromium.org>
        <20230315194334.58eb56ab@gandalf.local.home>
        <CABRcYmLLbRGZXWwEpyLW1YFz87tTPA8pCL7oLd4K6Hp9Etr5LA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 16 Mar 2023 16:40:48 +0100
Florent Revest <revest@chromium.org> wrote:

> > > @@ -5466,6 +5467,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> > >                       entry->direct = addr;
> > >               }
> > >       }
> > > +     WRITE_ONCE(ops->direct_call, addr);  
> >
> > I'm curious about the use of WRITE_ONCE(). It should not go outside the
> > mutex barrier.  
> 
> This WRITE_ONCE was originally suggested by Mark here:
> https://lore.kernel.org/all/Y9vW99htjOphDXqY@FVFF77S0Q05N.cambridge.arm.com/#t
> 
> My understanding is that it's not so much about avoiding re-ordering
> but rather about avoiding store tearing since a ftrace_caller
> trampoline could concurrently read ops->direct_call. Does that make
> sense ?

Yes, but a comment needs to be added:

     /* Prevent store tearing on some archs */
     WRITE_ONCE(ops->direct_call, addr);  

Or something to that affect. Otherwise I can see it confusing others in the
future. And probably me too, as I'll forget why it was a WRITE_ONCE() by
next month. ;-)

-- Steve
