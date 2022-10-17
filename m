Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3921E6017A9
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 21:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiJQTaN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 15:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiJQT3v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 15:29:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D506B79EE0;
        Mon, 17 Oct 2022 12:28:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF0CF61218;
        Mon, 17 Oct 2022 19:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F71C433C1;
        Mon, 17 Oct 2022 19:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666034867;
        bh=/sbWL9ZHe0D21fIQ7+2B+ATC4P6VpJMi25hzWD3qixc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lw3Oe2cbqI76PHfUenh39Na+3kNO1A0K441gFbTMVFGlGEiF0RpugA0jyceJUM8eP
         IFll+tuAg2WL91pHS45pMdkaQtTR5SCEHDcHNyRNTQ4WtlR2KdhN/+0qiMdSq1KSCQ
         F7o0xVJIdITYABlxbhY0nuYjN97dPKzFe7SHkJjfeh5mJaOtWBRpHyT7B4oQ4td68a
         FwO0JSyYgdHh8mS6ZAXC/odq+oaGwqMgkR/5r8Sn6NvdpBDS5PHpQhcrECILXcMdvy
         4ngscN6Pe59rYjEKZ2Pr0o94mDOjbhAMqXIEy86hBP7p8wfCkYYFPKcuXQEFBAz3z+
         REME+e8RpHYiw==
From:   SeongJae Park <sj@kernel.org>
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc:     olsajiri@gmail.com, bpf@vger.kernel.org, gor@linux.ibm.com,
        hca@linux.ibm.com, iii@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, namhyung@kernel.org,
        peterz@infradead.org, svens@linux.ibm.com, tip-bot2@linutronix.de,
        tmricht@linux.ibm.com, x86@kernel.org
Subject: Re: [PATCH] bpf: fix sample_flags for bpf_perf_event_output
Date:   Mon, 17 Oct 2022 19:27:44 +0000
Message-Id: <20221017192744.1403-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221007081327.1047552-1-sumanthk@linux.ibm.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,


The commit that this patch is fixing[1] also causes yet another segfault for
'perf-script' of tracepoint records.  For example:

    $ sudo timeout 3 perf record -e exceptions:page_fault_user
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.228 MB perf.data (74 samples) ]
    $ sudo perf script
    Segmentation fault

Reverting this patch and the original bug commit[1] fixes the issue.  I haven't
deep dive yet because I'm not familiar with this area.  Anybody has any idea
about this?

[1] 838d9bb62d13 ("perf: Use sample_flags for raw_data")


Thanks,
SJ

On Fri, 7 Oct 2022 10:13:27 +0200 Sumanth Korikkar <sumanthk@linux.ibm.com> wrote:

> * Raw data is also filled by bpf_perf_event_output.
> * Add sample_flags to indicate raw data.
> * This eliminates the segfaults as shown below:
>   Run ./samples/bpf/trace_output
>   BUG pid 9 cookie 1001000000004 sized 4
>   BUG pid 9 cookie 1001000000004 sized 4
>   BUG pid 9 cookie 1001000000004 sized 4
>   Segmentation fault (core dumped)
> 
> Fixes: 838d9bb62d13 ("perf: Use sample_flags for raw_data")
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>  kernel/trace/bpf_trace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 49fb9ec8366d..1ed08967fb97 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -687,6 +687,7 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
>  
>  	perf_sample_data_init(sd, 0, 0);
>  	sd->raw = &raw;
> +	sd->sample_flags |= PERF_SAMPLE_RAW;
>  
>  	err = __bpf_perf_event_output(regs, map, flags, sd);
>  
> @@ -745,6 +746,7 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
>  	perf_fetch_caller_regs(regs);
>  	perf_sample_data_init(sd, 0, 0);
>  	sd->raw = &raw;
> +	sd->sample_flags |= PERF_SAMPLE_RAW;
>  
>  	ret = __bpf_perf_event_output(regs, map, flags, sd);
>  out:
> -- 
> 2.36.1
