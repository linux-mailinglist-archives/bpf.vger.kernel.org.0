Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43334B35DF
	for <lists+bpf@lfdr.de>; Sat, 12 Feb 2022 16:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbiBLPg5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 12 Feb 2022 10:36:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiBLPg4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Feb 2022 10:36:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8985252
        for <bpf@vger.kernel.org>; Sat, 12 Feb 2022 07:36:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FAB66091D
        for <bpf@vger.kernel.org>; Sat, 12 Feb 2022 15:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE3CC340E7;
        Sat, 12 Feb 2022 15:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644680210;
        bh=JaI/86Nd/lqbbR8+mAO/i7sRrfTeqN2z9SCqXWE0gX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sRqZcY9fQbLP/RpJxTTfOSMdF4WMyL2I6uRxGSM0pdQL5kdK/buONyRLAFnP9i/Eq
         w/4QdBdr/WqjIzUy9uiVxJlBDq1s6y+jZS3rHNToa7ipxlkhNAHBzz+eiNr/FBzmyr
         SE5LQugF7hVTenFK3fsZ80EQAclOTXYEnqDj98tdRxJUoP8UuNdOrzh/aaZYd+C39C
         84e2xVHKumXnuTLR3WzoVwTdAAlOlI0BDcvKLVqvThGysVhQmGzKx4omoy6ZwA4+ZV
         Ez5G/+/1vIW2Ea6p3ck09maqBwfxvAmAuMq/javaG+VuKJeCBPVBY5Bq/UTbJGi7Kq
         kJN0zYb1UP3JA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 34A84400FE; Sat, 12 Feb 2022 12:36:49 -0300 (-03)
Date:   Sat, 12 Feb 2022 12:36:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH v5 bpf-next 0/2] perf: stop using deprecated bpf APIs
Message-ID: <YgfUEW5pa0eMN3/I@kernel.org>
References: <20220212073054.1052880-1-andrii@kernel.org>
 <YgfToqR6xR5lq0HI@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YgfToqR6xR5lq0HI@kernel.org>
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

Em Sat, Feb 12, 2022 at 12:34:58PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Feb 11, 2022 at 11:30:52PM -0800, Andrii Nakryiko escreveu:
> > libbpf's bpf_prog_load() and bpf__object_next() APIs are deprecated.
> > remove perf's usage of these deprecated functions. After this patch
> > set, the only remaining libbpf deprecated APIs in perf would be
> > bpf_program__set_prep() and bpf_program__nth_fd().
> 
> Not applying to perf/core, I'm checking...

Just some fuzz on the second patch:

⬢[acme@toolbox perf]$ patch -p1 < ~/wb/1.patch
patching file tools/perf/util/bpf-loader.c
Hunk #2 succeeded at 111 with fuzz 1 (offset -1 lines).
Hunk #3 succeeded at 156 (offset -2 lines).
Hunk #4 succeeded at 1563 (offset 8 lines).
Hunk #5 succeeded at 1575 (offset 8 lines).
Hunk #6 succeeded at 1628 (offset 8 lines).
⬢[acme@toolbox perf]$

Applying manually to test on the set of test build containers.

- Arnaldo
 
> ⬢[acme@toolbox perf]$ b4 am -ctsl --cc-trailers 20220212073054.1052880-1-andrii@kernel.org
> Looking up https://lore.kernel.org/r/20220212073054.1052880-1-andrii%40kernel.org
> Grabbing thread from lore.kernel.org/all/20220212073054.1052880-1-andrii%40kernel.org/t.mbox.gz
> Checking for newer revisions on https://lore.kernel.org/all/
> Analyzing 3 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>   [PATCH v5 1/2] perf: Stop using deprecated bpf_load_program() API
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>     + Link: https://lore.kernel.org/r/20220212073054.1052880-2-andrii@kernel.org
>     + Cc: kernel-team@fb.com
>     + Cc: daniel@iogearbox.net
>     + Cc: ast@kernel.org
>     + Cc: bpf@vger.kernel.org
>   [PATCH v5 2/2] perf: Stop using deprecated bpf_object__next() API
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>     + Link: https://lore.kernel.org/r/20220212073054.1052880-3-andrii@kernel.org
>     + Cc: kernel-team@fb.com
>     + Cc: daniel@iogearbox.net
>     + Cc: ast@kernel.org
>     + Cc: bpf@vger.kernel.org
> ---
> Total patches: 2
> ---
> Cover: ./v5_20220211_andrii_perf_stop_using_deprecated_bpf_apis.cover
>  Link: https://lore.kernel.org/r/20220212073054.1052880-1-andrii@kernel.org
>  Base: not specified
>        git am ./v5_20220211_andrii_perf_stop_using_deprecated_bpf_apis.mbx
> ⬢[acme@toolbox perf]$        git am ./v5_20220211_andrii_perf_stop_using_deprecated_bpf_apis.mbx
> Applying: perf: Stop using deprecated bpf_load_program() API
> Applying: perf: Stop using deprecated bpf_object__next() API
> error: patch failed: tools/perf/util/bpf-loader.c:68
> error: tools/perf/util/bpf-loader.c: patch does not apply
> Patch failed at 0002 perf: Stop using deprecated bpf_object__next() API
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> 
> 
> - Arnaldo
>  
> > v4 -> v5:
> >   - add bpf_perf_object__add() and use it where appropriate (Jiri);
> >   - use __maybe_unused in first patch;
> > v3 -> v4:
> >   - Fixed commit title
> >   - Added weak definition for deprecated function
> > v2 -> v3:
> >   - Fixed commit message to use upstream perf
> > v1 -> v2:
> >   - Added missing commit message
> >   - Added more details to commit message and added steps to reproduce
> >     original test case.
> > 
> > Christy Lee (2):
> >   perf: Stop using deprecated bpf_load_program() API
> >   perf: Stop using deprecated bpf_object__next() API
> > 
> >  tools/perf/tests/bpf.c       | 14 ++----
> >  tools/perf/util/bpf-event.c  | 13 +++++
> >  tools/perf/util/bpf-loader.c | 98 +++++++++++++++++++++++++++++-------
> >  3 files changed, 96 insertions(+), 29 deletions(-)
> > 
> > -- 
> > 2.30.2
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
