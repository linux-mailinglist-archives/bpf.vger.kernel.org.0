Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788AA632C77
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 19:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiKUS6q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 13:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKUS6o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 13:58:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191E9D06DB;
        Mon, 21 Nov 2022 10:58:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6184B815D2;
        Mon, 21 Nov 2022 18:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9FFC433C1;
        Mon, 21 Nov 2022 18:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669057120;
        bh=x2kjn+umraLvWowScajj2AvmSYcR0Fqmq4xaPX+pe94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iOMKdNcSlRyOCJchBO2WzK9oeAsk1onnUAZUg5I4TruvB+l+guZr63u31qZeLK36P
         +OOt+OUp/em/W4hhxJ09M+qkV9XfQY5lS59C5rqoW1N7PWYAxkyWmbKDjNidzliZDH
         HckrpsVrSvLsmWMy9c2Z4fEzdApre4pBC/14J5Oo4lALEtvx2rN4qxhpQszes6pY/n
         kacnpWSCMIect4aQRcMv/DsNLFScJ6HjvVPCDwYIH3CeIyiXEKCuYBVdPXhsKUvT1u
         nk/egHKPzlAg8lUJd12XkVlkVkufh1jjc/2pWeF4WtZYRWs6C8W1R+v5DuNPspWOlg
         z5cEdA2mgni5Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1D7624034E; Mon, 21 Nov 2022 15:58:38 -0300 (-03)
Date:   Mon, 21 Nov 2022 15:58:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] perf trace: Cleanup and remove unused bpf map
Message-ID: <Y3vKXoPAyNPi8BZr@kernel.org>
References: <20221121075237.127706-1-leo.yan@linaro.org>
 <CAP-5=fVHpzT1Q0U=e_svzQ2+a0iSoYppL8hRmOTAHZ0_nk2Z_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVHpzT1Q0U=e_svzQ2+a0iSoYppL8hRmOTAHZ0_nk2Z_g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Nov 21, 2022 at 09:05:14AM -0800, Ian Rogers escreveu:
> On Sun, Nov 20, 2022 at 11:52 PM Leo Yan <leo.yan@linaro.org> wrote:
> >
> > The initial purpose of this series is to cleanup the unused bpf map
> > 'syscalls' in the eBPF program augmented_raw_syscalls and perf trace
> > tool.  The relality is perf trace tool initializes system call table
> > based on map 'syscalls' and wrongly returns syscall pointer for
> > non-existed system calls based on the previous initialization.
> >
> > So the patch set firstly addresses the issue for handling non-existed
> > system calls, then it removes unused local variable and bpf map in
> > augmented_raw_syscalls.c.
> >
> > Patch 01 is a minor refactoring to use macro to replace number, patch 02
> > is to return error if a system call doesn't exist, especially when we
> > cannot find corresponding trace point in sysfs node, patch 03 is to fix
> > the issue that trace__syscall_info() returns a syscall pointer even the
> > system call doesn't exist, the corrected result is to always return NULL
> > pointer for non-existed system call.
> >
> > The last two patches remove the unused local variable and bpf map
> > 'syscalls'.
> >
> > This patch set has been tested with mainline kernel on Arm64 Ampere
> > Altra platform.
> >
> > Leo Yan (5):
> >   perf trace: Use macro RAW_SYSCALL_ARGS_NUM to replace number
> >   perf trace: Return error if a system call doesn't exist
> >   perf trace: Handle failure when trace point folder is missed
> >   perf augmented_raw_syscalls: Remove unused variable 'syscall'
> >   perf trace: Remove unused bpf map 'syscalls'
> 
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> >  tools/perf/builtin-trace.c                    | 131 +++---------------
> >  .../examples/bpf/augmented_raw_syscalls.c     |  18 ---
> >  2 files changed, 18 insertions(+), 131 deletions(-)
> >
> > --
> > 2.34.1
> >

-- 

- Arnaldo
