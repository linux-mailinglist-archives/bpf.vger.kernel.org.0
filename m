Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8ACD547A07
	for <lists+bpf@lfdr.de>; Sun, 12 Jun 2022 14:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiFLMMn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Jun 2022 08:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbiFLMMm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Jun 2022 08:12:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C35ACE3D;
        Sun, 12 Jun 2022 05:12:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C541FB80B83;
        Sun, 12 Jun 2022 12:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1A0C34115;
        Sun, 12 Jun 2022 12:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655035957;
        bh=tJ6ormyXu3bEZSfGwqsCn6ejLsjtXmfFrOIK6saj4Hs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mmNRwDkNf3uFe+JZOrNGzK68RSUQJl+SxuTxli03bUp/V76M57g4ULz+lrHOfVovu
         VYzFUm00V6lRRT1WpL+a8GkONo5C+n/Ziv8EP73dy9qkOpQZYHKXRrhoNByd1tn52V
         YNJoZmoCD6Xpv+1VM0Hgkv02fs/I/7nBS9zXv0WC+gEgj0WifOdCccgSL5ABq0QMQ5
         Kl7VsTUnhZP5U6Fem3NNV/FNxjUh0YHXbp++LWxbl9+XOPmlBSwKlJ3/6LAHjn5DJR
         v667gjz8R5MJ7iUkcYoCmxwtKOXem6jylsLEBlEGRnHByZYcg4fjVezQmVTDM4QfPM
         a2zoiyfITP1RQ==
Date:   Sun, 12 Jun 2022 21:12:32 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Dmitry Dolgov <9erthalion6@gmail.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] perf/kprobe: maxactive for fd-based kprobe
Message-Id: <20220612211232.3b82015bfabd194893cf0418@kernel.org>
In-Reply-To: <CAADnVQLLq+=gc1r+5pxrf3=VL29yZG=_9z6Th-rzcpC+xxsoyA@mail.gmail.com>
References: <20220609192936.23985-1-9erthalion6@gmail.com>
        <20220609193028.zhxpxscawnd3sep6@erthalion.local>
        <CAADnVQLLq+=gc1r+5pxrf3=VL29yZG=_9z6Th-rzcpC+xxsoyA@mail.gmail.com>
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

On Sat, 11 Jun 2022 11:28:36 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Thu, Jun 9, 2022 at 1:14 PM Dmitry Dolgov <9erthalion6@gmail.com> wrote:
> >
> > > On Thu, Jun 09, 2022 at 09:29:36PM +0200, Dmitrii Dolgov wrote:
> > >
> > > Enable specifying maxactive for fd based kretprobe. This will be useful
> > > for tracing tools like bcc and bpftrace (see for example discussion [1]).
> > > Use highest 12 bit (bit 52-63) to allow maximal maxactive of 4095.
> > >
> > > The original patch [2] seems to be fallen through the cracks and wasn't
> > > applied. I've merely rebased the work done by Song Liu and verififed it
> > > still works.
> > >
> > > [1]: https://github.com/iovisor/bpftrace/issues/835
> > > [2]: https://lore.kernel.org/all/20191007223111.1142454-1-songliubraving@fb.com/
> >
> > I've recently stumbled upon this seemingly lost topic, and wanted to raise it
> > again. Please let me know if there is a more appropriate way to do so.
> 
> With kretprobe using rethook the maxactive limit is no longer used.
> So we probably don't need this patch.
> 
> Masami, wdyt?

No, rethook is just a library version of kretprobe return hook,
so the maxactive is still alive. I would like to make the rethook
to use(share with) function graph's per-task shadow stack. When
that is done, the maxactive will be removed.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
