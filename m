Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5396894B5
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 11:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjBCKEI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 05:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjBCKEH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 05:04:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E29EC23D9D;
        Fri,  3 Feb 2023 02:03:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D936BC14;
        Fri,  3 Feb 2023 02:04:25 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.90.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B2013F8D6;
        Fri,  3 Feb 2023 02:03:41 -0800 (PST)
Date:   Fri, 3 Feb 2023 10:03:38 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com
Subject: Re: [PATCH 5/8] ftrace: Make DIRECT_CALLS work WITH_ARGS and
 !WITH_REGS
Message-ID: <Y9zb+uKqQN9gJJBI@FVFF77S0Q05N>
References: <20230201163420.1579014-1-revest@chromium.org>
 <20230201163420.1579014-6-revest@chromium.org>
 <Y9vcua0+JzjmTICO@FVFF77S0Q05N.cambridge.arm.com>
 <Y9vrWUM8ypNNwHyv@FVFF77S0Q05N.cambridge.arm.com>
 <CABRcYm+nwsyyKEhvz9dr8sDiOWfha-YxOkGMFSx4mH9O+HAiYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABRcYm+nwsyyKEhvz9dr8sDiOWfha-YxOkGMFSx4mH9O+HAiYg@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 02, 2023 at 07:19:58PM +0100, Florent Revest wrote:
> On Thu, Feb 2, 2023 at 5:57 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 84f717f8959e..3d2156e335d7 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -241,6 +241,12 @@ enum {
> >         FTRACE_OPS_FL_DIRECT                    = BIT(17),
> >  };
> >
> > +#ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> > +#define FTRACE_OPS_FL_SAVE_ARGS                        FTRACE_OPS_FL_SAVE_REGS
> > +#else
> > +#define FTRACE_OPS_FL_SAVE_ARGS                        0
> 
> Mh, could we (theoretically) be in a situation where an arch supports
> WITH_ARGS but it also has two ftrace_caller trampolines: one that
> saves the args and the other that saves nothing ? (For example if x86
> migrates their WITH_REGS to WITH_ARGS only)

I don't think so -- the point of WITH_ARGS is that we always have to
save/restore the args, and when WITH_ARGS is selected they're unconditionally
available (though not necessarily a full pt_regs), which is what other code
assumes when WITH_ARGS is selected.

> Wouldn't it make sense then to define FTRACE_OPS_FL_SAVE_ARGS as an
> extra bit to tell ftrace that we need the args, similarly to
> FTRACE_OPS_FL_SAVE_REGS ?
> 
> If that can't happen or if we want to leave this up for later, the
> patch lgtm and I can squash it into my patch 5 in v2. ;)

I think that can't happen, and for now the above should be fine.

Thanks,
Mark.
