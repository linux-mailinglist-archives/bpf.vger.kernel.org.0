Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE354C478B
	for <lists+bpf@lfdr.de>; Fri, 25 Feb 2022 15:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241629AbiBYOdH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Feb 2022 09:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241786AbiBYOci (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Feb 2022 09:32:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5C716F96F;
        Fri, 25 Feb 2022 06:32:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5F87B831F8;
        Fri, 25 Feb 2022 14:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A86AC340E7;
        Fri, 25 Feb 2022 14:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645799523;
        bh=R7UNX1EqDtGkiEAz9dtDTaaeHOPhPEl39fh/58YEnQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bgqJcWqvGAoXF08p/LH3hYFTePdjznND7PCmsKaczhezQ+3/BhmYy/L6t1T3YP+Zh
         CP639+Wia/zVanM9JURiQcBx12XkW2vlkFuXE05vLd2RyQy9DqdvF7X0Cz/RPR4qT4
         zbi2lRlOzacRqog1z/0kYCRGeIV0WEUh62DA6oU/HdJcCmL1cd/Np0LYwerbDkOcza
         c7Wa8DGFFTziPBEguzqM2Wc3MfN+gz3Tc49xqyiRGrTVLkHA31okY0nD4NuaBUjjWv
         GV4aykR+tloz1ZM4Spw82lY5Q/EVTEJXoHEdEH48Pr4Hw6pom6KqSo9WN+lD8kXqJt
         qEk2CvhgMWGeA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2C484403C8; Fri, 25 Feb 2022 11:32:00 -0300 (-03)
Date:   Fri, 25 Feb 2022 11:32:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 3/3] perf tools: Rework prologue generation code
Message-ID: <YhjoYEoF7FJSwKO2@kernel.org>
References: <20220217131916.50615-1-jolsa@kernel.org>
 <20220217131916.50615-4-jolsa@kernel.org>
 <CAEf4BzYP7=JuyuY=xZe71urpxat4ba-JnqeSTcHF=CYmsQbofQ@mail.gmail.com>
 <Yg9geQ0LJjhnrc7j@krava>
 <CAEf4BzZaFWhWf73JbfO7gLi82Nn4ma-qmaZBPij=giNzzoSCTQ@mail.gmail.com>
 <YhJF00d9baPtXjzH@krava>
 <CAEf4BzaiBO3_617kkXZdYJ8hS8YF--ZLgapNbgeeEJ-pY0H88g@mail.gmail.com>
 <YhjIOX5BDYh4SRZB@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhjIOX5BDYh4SRZB@krava>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Feb 25, 2022 at 01:14:49PM +0100, Jiri Olsa escreveu:
> On Wed, Feb 23, 2022 at 02:29:56PM -0800, Andrii Nakryiko wrote:
> 
> SNIP
> 
> > > and R3 is loaded in the prologue code (first 15 instructions)
> > > and it also sets 'err' (R2) with the result of the reading:
> > >
> > >            0: (bf) r6 = r1
> > >            1: (79) r3 = *(u64 *)(r6 +96)
> > >            2: (bf) r7 = r10
> > >            3: (07) r7 += -8
> > >            4: (7b) *(u64 *)(r10 -8) = r3
> > >            5: (b7) r2 = 8
> > >            6: (bf) r1 = r7
> > >            7: (85) call bpf_probe_read_user#-60848
> > >            8: (55) if r0 != 0x0 goto pc+2
> > >            9: (61) r3 = *(u32 *)(r10 -8)
> > >           10: (05) goto pc+3
> > >           11: (b7) r2 = 1
> > >           12: (b7) r3 = 0
> > >           13: (05) goto pc+1
> > >           14: (b7) r2 = 0
> > >           15: (bf) r1 = r6
> > >
> > >           16: (b7) r1 = 100
> > >           17: (6b) *(u16 *)(r10 -8) = r1
> > >           18: (18) r1 = 0x6c25203a6f697270
> > >           20: (7b) *(u64 *)(r10 -16) = r1
> > >           21: (bf) r1 = r10
> > >           22: (07) r1 += -16
> > >           23: (b7) r2 = 10
> > >           24: (85) call bpf_trace_printk#-54848
> > >           25: (b7) r0 = 1
> > >           26: (95) exit
> > >
> > >
> > > I'm still scratching my head how to workaround this.. we do want maps
> > > and all the other updates to the code, but verifier won't let it pass
> > > without the prologue code
> > 
> > ugh, perf cornered itself into supporting this crazy scheme and now
 
> well, it just used the interface that was provided at the time

At the time it was where experimentation was done with tooling for eBPF,
Wangnan tried to provide a compact way to give access to parameters.

The problem now is for libbpf to remove something that is used and that
was documented to some extent in the perf tools examples so there _may_
be some usage of it, we just can't know.

Its like Linux removing some syscall that is "crazy" and wait for
somebody to complain of the breakage caused when they update to a new
version.
 
> > there is no good solution. I'm still questioning the value of
> > supporting this going forward. Is there an evidence that anyone is
> > using this functionality at all? Is it worth it trying to carry it on
> > just because we have some example that exercises this feature?
 
> yea we discussed this again and I think we can somehow mark this
> feature in perf as deprecated and remove it after some time,
> because even with the workaround below it'll be pita ;-)
> 
> or people will come and scream and we will find some other solution

:-\ if you have some "ugly" way to keep the feature, can't we go with
it?
 
> I already sent the rest of the changes (prog/map priv) separately
> and will send some RFC for the deprecation

I'll look at it now.

Thanks for your work on this, Jiri.

- Araldo
 
> thanks,
> jirka
> 
> > 
> > Anyways, one way to solve this is to add bpf_program__set_insns() that
> > could be called from prog_init_fn callback (which I just realized
> > hasn't landed yet, I'll send v4 today) to prepend a simple preamble
> > like this:
> > 
> > r1 = 0;
> > r2 = 0;
> > r3 = 0;
> > f4 = 0;
> > r5 = 0; /* how many input arguments we support? */
> > 
> > This will make all input arguments initialized, libbpf will be able to
> > adjust all the relocations and stuff. Once this "prototype program" is
> > loaded, perf can grab final instructions and replace first X
> > instructions with desired preamble.
> > 
> > But... ugliness and horror, yeah :(
> > 
> > 
> > >
> > > jirka

-- 

- Arnaldo
