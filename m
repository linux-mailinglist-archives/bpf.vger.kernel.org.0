Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD378557E0E
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 16:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiFWOrg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 10:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiFWOrf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 10:47:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5F545ACC;
        Thu, 23 Jun 2022 07:47:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5B49B82422;
        Thu, 23 Jun 2022 14:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FEBC3411B;
        Thu, 23 Jun 2022 14:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655995652;
        bh=af0iae8HaeTxr0L0VH0dFIhG0wCfGGbdqwmTEFpdFTg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=isfNEgjoQSlvl5pmOxC5JC5kNZFflOZ8+t8uffUf5JRSNNaMJVds+1CLACz/XFx+Q
         i4X1bniywgiDrRHQ4VB+k7m6SVCMrhr9rdyWvwgzdpezpzTLkaPMLd8/DrX85offbZ
         VdUw8xh6iqhPky0Bi+HGqzAj131hNXvG94fxdP2HGH8SJYUXP5qftHG304H2hvR+ur
         SKgESQ3lVpaxZkYsmNy8FP0jMO421F1lTy4MQuHicvJc0M7RjrRPu85O+via6YgYeU
         m+U2DUKGERZR3hEWgiCnWcAAe06fPdy/muDE8tdgli/0VrbDkPEOget5LO44s6N4GZ
         ucgnbwEhVM/5w==
Date:   Thu, 23 Jun 2022 23:47:27 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Dmitry Dolgov <9erthalion6@gmail.com>
Cc:     linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        songliubraving@fb.com, rostedt@goodmis.org, peterz@infradead.org,
        mingo@redhat.com, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 1/1] perf/kprobe: maxactive for fd-based kprobe
Message-Id: <20220623234727.db1dda76c11d660200b2b804@kernel.org>
In-Reply-To: <20220622085421.k2kikjndluxfmf7q@ddolgov.remote.csb>
References: <20220615211559.7856-1-9erthalion6@gmail.com>
        <20220619013137.6d10a232246be482a5c0db82@kernel.org>
        <20220622085421.k2kikjndluxfmf7q@ddolgov.remote.csb>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 22 Jun 2022 10:54:21 +0200
Dmitry Dolgov <9erthalion6@gmail.com> wrote:

> > On Sun, Jun 19, 2022 at 01:31:37AM +0900, Masami Hiramatsu wrote:
> > On Wed, 15 Jun 2022 23:15:59 +0200
> > Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
> >
> > > From: Song Liu <songliubraving@fb.com>
> > >
> > > Enable specifying maxactive for fd based kretprobe. This will be useful
> > > for tracing tools like bcc and bpftrace (see for example discussion [1]).
> > > Use highest 12 bit (bit 52-63) to allow maximal maxactive of 4095.
> >
> > I'm not sure what environment you are considering to use this
> > feature, but is 4095 enough, and are you really need to specify
> > the maxactive by linear digit?
> > I mean you may need the logarithm of maxactive? In this case, you
> > only need 4 bits for 2 - 65546 (1 = 2^0 will be used for the default
> > value).
> 
> From what I see it's capped by KRETPROBE_MAXACTIVE_MAX anyway, which
> value is 4096. Do I miss something, is it possible to use maxactive with
> larger values down the line?

Ah, I forgot to cap the maxactive in trace_kprobe. Yes, kretprobe's
maxactive has no limitation check (it depends on how much memory you
can allocate in the kernel.) If you think that is not enough, you
can expand the maximum number. Unless a huge system which runs
a ten thoudsands of similar process/threads, 4096 will be a good
number. So, it up to you. But personally I think the maxactive
should be specified by log2. 

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
