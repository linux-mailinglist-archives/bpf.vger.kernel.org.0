Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DACA550613
	for <lists+bpf@lfdr.de>; Sat, 18 Jun 2022 18:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiFRQPb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Jun 2022 12:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFRQPa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Jun 2022 12:15:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208F1DEBC;
        Sat, 18 Jun 2022 09:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D70EAB80A72;
        Sat, 18 Jun 2022 16:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9251EC3411A;
        Sat, 18 Jun 2022 16:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655568926;
        bh=7vFxdzXkY61Nhm0MoNJS1NLYQ7b1iI0WqVBgi/6YBI8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jB4kKNL0t0GsI8WiEiDWPJ/j5PNbcTajkm1jR6l8GmJyqMAgtev8zbZS9d9WuJmc9
         mQ7YGHgqCJWfUyoWkDynXg8kzgbdxSms76Ex9uvYhssDjrc9UfbdGhG/lg8QmgrewS
         pAfk4VeYDkMUxHEq6A6u4YdUN2VMuadlhU3iGWvz272gqxVrrAzKY9gqR7MJMnEDlY
         TVots0PaQ4MTYZ3fAyv2vtU4r010+pXL5kGfgghKM34RIuUhnSYsPtektABiPr4Jid
         wLfJ/uOXFCxLHrxHwg4Hv7SRSAFLFL8+MWav55OtwdEitd6muIiC35xs4ikpPuE40K
         ndTocSu/yogaQ==
Date:   Sun, 19 Jun 2022 01:15:21 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Dmitry Dolgov <9erthalion6@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] perf/kprobe: maxactive for fd-based kprobe
Message-Id: <20220619011521.4fc56a8bdac451a4f4f6cd13@kernel.org>
In-Reply-To: <20220615200029.ngyayghtnma3ywnb@erthalion.local>
References: <20220609192936.23985-1-9erthalion6@gmail.com>
        <20220609193028.zhxpxscawnd3sep6@erthalion.local>
        <CAADnVQLLq+=gc1r+5pxrf3=VL29yZG=_9z6Th-rzcpC+xxsoyA@mail.gmail.com>
        <20220612211232.3b82015bfabd194893cf0418@kernel.org>
        <20220615200029.ngyayghtnma3ywnb@erthalion.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 15 Jun 2022 22:00:29 +0200
Dmitry Dolgov <9erthalion6@gmail.com> wrote:

> > On Sun, Jun 12, 2022 at 09:12:32PM +0900, Masami Hiramatsu wrote:
> > On Sat, 11 Jun 2022 11:28:36 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >
> > > On Thu, Jun 9, 2022 at 1:14 PM Dmitry Dolgov <9erthalion6@gmail.com> wrote:
> > > >
> > > > > On Thu, Jun 09, 2022 at 09:29:36PM +0200, Dmitrii Dolgov wrote:
> > > > >
> > > > > Enable specifying maxactive for fd based kretprobe. This will be useful
> > > > > for tracing tools like bcc and bpftrace (see for example discussion [1]).
> > > > > Use highest 12 bit (bit 52-63) to allow maximal maxactive of 4095.
> > > > >
> > > > > The original patch [2] seems to be fallen through the cracks and wasn't
> > > > > applied. I've merely rebased the work done by Song Liu and verififed it
> > > > > still works.
> > > > >
> > > > > [1]: https://github.com/iovisor/bpftrace/issues/835
> > > > > [2]: https://lore.kernel.org/all/20191007223111.1142454-1-songliubraving@fb.com/
> > > >
> > > > I've recently stumbled upon this seemingly lost topic, and wanted to raise it
> > > > again. Please let me know if there is a more appropriate way to do so.
> > >
> > > With kretprobe using rethook the maxactive limit is no longer used.
> > > So we probably don't need this patch.
> > >
> > > Masami, wdyt?
> >
> > No, rethook is just a library version of kretprobe return hook,
> > so the maxactive is still alive. I would like to make the rethook
> > to use(share with) function graph's per-task shadow stack. When
> > that is done, the maxactive will be removed.
> 
> Thanks for clarification! Does it mean that the possibility of setting
> maxactive still makes sense, until the rethook changes you've mentioned
> will land?

Yes, unfortunatelly, there is no magic. We need a shadow stack without
runtime allocation for this purpose. Thus what we can do is to use
a per-task pre-allocated shadow stack page or make a common pool of nodes
for variable-length shadow-stack. Both has pros and cons (depends on the
system configuration).

> 
> On a side note, is it possible to somehow follow/review/test the work
> about rethook and function graph's shadow stack?

Hmm, good question. It should work theoletically, but it is easy to be
tested by ftrace tracefs interface on x86. Just enable function-graph
tracer and add a kretprobe event on some fucntion. E.g.

echo function-graph > current_tracer
echo r:test vfs_read >> kprobe_events
echo 1 > events/kprobes/enable

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
