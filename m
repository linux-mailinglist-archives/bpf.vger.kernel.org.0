Return-Path: <bpf+bounces-5043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81413754473
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 23:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0E21C208F6
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 21:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A6915AD5;
	Fri, 14 Jul 2023 21:48:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C93A53AF
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 21:48:57 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1A535A5
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 14:48:56 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666edfc50deso1517544b3a.0
        for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 14:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689371335; x=1691963335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNAjAzXiy9B8yfRFpP64QxJGo/FpPrkOHCQJ7KqROZg=;
        b=FrKFuhMbIUTnL1TrH2TsNea2kHk5uHKHBoVMWmw14AfZ1SQY79xsHbBwJGKDTt0us3
         JpuTNCWcRg0MWARWefEFslX/6wNLMO2n+XkaUWky42Jc4O+8Ti71cjnivJEX1R4EoLsv
         /FFONmgcn9GQ041TGxmntI8l3xYlryHUmwON/nbl9HCvZEqDiOR5/WNCSD5x2J1eC77G
         6pXO/nbQTRZmbvadbDcIjmX+s3k8piCDq75rGpjnA+0f0dIgo7GtAzhkF+XHaFKXnwOl
         GqxduXR3TmUiDaeHN8XTOWxWDL7T97U9Yt7SRapIrbo0qnXw5ja36QmKwNFhMQ1YdH76
         c2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689371335; x=1691963335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNAjAzXiy9B8yfRFpP64QxJGo/FpPrkOHCQJ7KqROZg=;
        b=MwJOuRR4kTtlCvqjiA6r2US4DuH8oiy/90FCSZilET6OiMRPb9VDnd8Zaupncr82E8
         016WxVAmfTfUD9YtweVoXVb9HeF5pdkWuaWsV7MrmYO/fJIJWpl8OoyX491ByqYadNOU
         WG0HJ1IkrjZ5HcnjxlCiWb4ZlPcpa4pdzY6qtxRdV/wQvqsgV4StdIjjExY3LcX5GrX9
         AYvRXRwc1X59VUQovl9C48IyZFzoUjKl4DKivbwnGmTu+v9k6oF+qQwCZChNg2Rr34GU
         xdKwe5tSeETk4g7J39e5gshdX2rs9l2G6X+R+LD11K30Xyt2Xls6WKQRa9vJt3aTMoiC
         zm0g==
X-Gm-Message-State: ABy/qLb4caRyDtM9zK4Co2EbbA44c225+UA8ZHHHmPQI0xAz2hnobMJy
	O+56a2uGEDFLvr8V6sB5vKTAi+WkWOI=
X-Google-Smtp-Source: APBJJlGLJOEE59NVyHaVls4bLPUZ52r9bGc/aHjXU3rxr6yY+Ryn3cB2A20uCMIxWPXoeUSG5bcjsA==
X-Received: by 2002:a05:6a20:9189:b0:12f:d350:8a12 with SMTP id v9-20020a056a20918900b0012fd3508a12mr4902164pzd.21.1689371335038;
        Fri, 14 Jul 2023 14:48:55 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:2ff4])
        by smtp.gmail.com with ESMTPSA id c3-20020aa781c3000000b0067978a01246sm7869276pfn.14.2023.07.14.14.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 14:48:54 -0700 (PDT)
Date: Fri, 14 Jul 2023 14:48:51 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf v1 2/3] bpf: Repeat check_max_stack_depth for async
 callbacks
Message-ID: <20230714214851.cfadshwpijm6z2vg@MacBook-Pro-8.local>
References: <20230713003118.1327943-1-memxor@gmail.com>
 <20230713003118.1327943-3-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713003118.1327943-3-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 06:01:17AM +0530, Kumar Kartikeya Dwivedi wrote:
> While the check_max_stack_depth function explores call chains emanating
> from the main prog, which is typically enough to cover all possible call
> chains, it doesn't explore those rooted at async callbacks unless the
> async callback will have been directly called, since unlike non-async
> callbacks it skips their instruction exploration as they don't
> contribute to stack depth.
> 
> It could be the case that the async callback leads to a callchain which
> exceeds the stack depth, but this is never reachable while only
> exploring the entry point from main subprog. Hence, repeat the check for
> the main subprog *and* all async callbacks marked by the symbolic
> execution pass of the verifier, as execution of the program may begin at
> any of them.
> 
> Consider a function with following stack depths:
> main : 256
> async : 256
> foo: 256
> 
> main:
>     rX = async
>     bpf_timer_set_callback(...)
> 
> async:
>     foo()
> 
> Here, async is never seen to contribute to the stack depth of main, so
> it is not descended, but when async is invoked asynchronously when the
> timer fires, it will end up breaching MAX_BPF_STACK limit imposed by the
> verifier.

The fix is correct, but the above paragraph is misleading.
async doesn't and shouldn't contribute to the stack depth of main prog.
Could you rephrase it?

> 
> Fixes: 7ddc80a476c2 ("bpf: Teach stack depth check about async callbacks.")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e682056dd144..02a021c524ab 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5573,16 +5573,17 @@ static int update_stack_depth(struct bpf_verifier_env *env,
>   * Since recursion is prevented by check_cfg() this algorithm
>   * only needs a local stack of MAX_CALL_FRAMES to remember callsites
>   */
> -static int check_max_stack_depth(struct bpf_verifier_env *env)
> +static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx)
>  {
> -	int depth = 0, frame = 0, idx = 0, i = 0, subprog_end;
>  	struct bpf_subprog_info *subprog = env->subprog_info;
>  	struct bpf_insn *insn = env->prog->insnsi;
> +	int depth = 0, frame = 0, i, subprog_end;
>  	bool tail_call_reachable = false;
>  	int ret_insn[MAX_CALL_FRAMES];
>  	int ret_prog[MAX_CALL_FRAMES];
>  	int j;
>  
> +	i = subprog[idx].start;
>  process_func:
>  	/* protect against potential stack overflow that might happen when
>  	 * bpf2bpf calls get combined with tailcalls. Limit the caller's stack
> @@ -5683,6 +5684,22 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
>  	goto continue_func;
>  }
>  
> +static int check_max_stack_depth(struct bpf_verifier_env *env)
> +{
> +	struct bpf_subprog_info *si = env->subprog_info;
> +	int ret;
> +
> +	for (int i = 0; i < env->subprog_cnt; i++) {
> +		if (!i || si[i].is_async_cb) {
> +			ret = check_max_stack_depth_subprog(env, i);
> +			if (ret < 0)
> +				return ret;
> +		}
> +		continue;
> +	}
> +	return 0;
> +}
> +
>  #ifndef CONFIG_BPF_JIT_ALWAYS_ON
>  static int get_callee_stack_depth(struct bpf_verifier_env *env,
>  				  const struct bpf_insn *insn, int idx)
> -- 
> 2.40.1
> 

