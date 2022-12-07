Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738FB645557
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 09:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiLGISV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 03:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLGISU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 03:18:20 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A546459
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 00:18:18 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id a16so23787738edb.9
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 00:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1QM5txz+DYnNZM0Ct81tkrNg0qe+7/Y9mU+kWI3SlVw=;
        b=pvRdySiGf8r5OxtxwB7zsMMvCvbc08Hj/UXpsjHYVx8MuKDP2irLm3vfNJXytzHp8m
         3pQMvj22RkwVbaSoWddtU+xGgviMN8kSkErFpRd/EgsJZ3Xd9fq0ub5uSbBerJW9ZWhg
         U8bxOzzgImPPQqrsXIgsyGzQxbMBPfB+2I2TiFpFBPejdgn4L2qK9VdzQgVITMssIEJz
         771urp5x+X2aFTksQq/s3wROcMC49h+gyo55XZFthxMCxRuuQwH3ojQ+qfz7wF3XxXyg
         KT/X3dsYSYMtqViVGyEJeUggCsSbrRSjZwJs2LZgS9CRL2JyDnrE+ehFH4CqaEtFkI/8
         zvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QM5txz+DYnNZM0Ct81tkrNg0qe+7/Y9mU+kWI3SlVw=;
        b=Gjkq0uyFb2ccn9VMp0V6eVyXWlJMhyB7G+AQYaBVuQ4yEpmx/z9bPtDefP3qWFPkKh
         +1TWKCcWvpyu6KHKJeHrp+qxHxs+/60VHOCpicWv7rcw8tJkFT8HYH0alHj9uAJAZt9W
         d6bRvG15/ESG4aYdjeTxr97OGENaXUEah0GkvWnVqwweb9EoWPQyuWEnoVIf8Jr5Fzv5
         aNGMJ3IeeNGeBOWeG7qiYNTXvbJe9ZXCVegb3QZUcJf2Q97ENtkcft9sIZByjC12U0ab
         19exNhOBKVZLfYctyG2nj7f8wGs1LZ9AUKbDr3JSgC7lsxWK2A2fbjp7IbOj3u4r9Rk4
         5eWw==
X-Gm-Message-State: ANoB5pkWktMx2vDFvwFp9hZREHtpTFBwHf7hoNeGon54Vp0taCS7KMVV
        ov9atiudZvlbRBFQ2OCGUm4=
X-Google-Smtp-Source: AA0mqf6QC+DgtOS3t6N+T22cRdDtLD+Bl//1gm145IknchTF3znqKedQL2FCTuRnDamerV9TTO1RJw==
X-Received: by 2002:aa7:d417:0:b0:46b:203:f389 with SMTP id z23-20020aa7d417000000b0046b0203f389mr41670421edq.303.1670401096999;
        Wed, 07 Dec 2022 00:18:16 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id g13-20020a170906538d00b007c0d5b181absm5032428ejo.94.2022.12.07.00.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 00:18:16 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 7 Dec 2022 09:18:14 +0100
To:     Namhyung Kim <namhyung@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Sun <sunhao.th@gmail.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next] bpf: Restrict attachment of bpf program to some
 tracepoints
Message-ID: <Y5BMRvsVMQtKvuhu@krava>
References: <20221121213123.1373229-1-jolsa@kernel.org>
 <bcdac077-3043-a648-449d-1b60037388de@iogearbox.net>
 <Y388m6wOktvZo1d4@krava>
 <CAADnVQJ5knvWaxVa=9_Ag3DU_qewGBbHGv_ZH=K+ETUWM1qAmA@mail.gmail.com>
 <Y4CMbTeVud0WfPtK@krava>
 <CAEf4BzZP9z3kdzn=04EvAprG-Ldrsegy5JkzvoBPvcdMG_vvGg@mail.gmail.com>
 <Y4uOSrXBxVwnxZkX@google.com>
 <Y43j3IGvLKgshuhR@krava>
 <CAADnVQLo1JBTg6iquCFj44AEuAhxj-V7a0T1gwejy1oDBDXcbA@mail.gmail.com>
 <Y4/27g8EHQ9F3bDr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4/27g8EHQ9F3bDr@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 06, 2022 at 06:14:06PM -0800, Namhyung Kim wrote:

SNIP

> -static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
> +static void *bpf_trace_norecurse_funcs[12] = {
> +	(void *)bpf_trace_run_norecurse1,
> +	(void *)bpf_trace_run_norecurse2,
> +	(void *)bpf_trace_run_norecurse3,
> +	(void *)bpf_trace_run_norecurse4,
> +	(void *)bpf_trace_run_norecurse5,
> +	(void *)bpf_trace_run_norecurse6,
> +	(void *)bpf_trace_run_norecurse7,
> +	(void *)bpf_trace_run_norecurse8,
> +	(void *)bpf_trace_run_norecurse9,
> +	(void *)bpf_trace_run_norecurse10,
> +	(void *)bpf_trace_run_norecurse11,
> +	(void *)bpf_trace_run_norecurse12,
> +};
> +
> +static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog,
> +				void *func, void *data)
>  {
>  	struct tracepoint *tp = btp->tp;
>  
> @@ -2325,13 +2354,12 @@ static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *
>  	if (prog->aux->max_tp_access > btp->writable_size)
>  		return -EINVAL;
>  
> -	return tracepoint_probe_register_may_exist(tp, (void *)btp->bpf_func,
> -						   prog);
> +	return tracepoint_probe_register_may_exist(tp, func, data);
>  }
>  
>  int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
>  {
> -	return __bpf_probe_register(btp, prog);
> +	return __bpf_probe_register(btp, prog, btp->bpf_func, prog);
>  }
>  
>  int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
> @@ -2339,6 +2367,33 @@ int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
>  	return tracepoint_probe_unregister(btp->tp, (void *)btp->bpf_func, prog);
>  }
>  
> +int bpf_probe_register_norecurse(struct bpf_raw_event_map *btp, struct bpf_prog *prog,
> +				 struct bpf_raw_event_data *data)
> +{
> +	void *bpf_func;
> +
> +	data->active = alloc_percpu_gfp(int, GFP_KERNEL);
> +	if (!data->active)
> +		return -ENOMEM;
> +
> +	data->prog = prog;
> +	bpf_func = bpf_trace_norecurse_funcs[btp->num_args];
> +	return __bpf_probe_register(btp, prog, bpf_func, data);

I don't think we can do that, because it won't do the arg -> u64 conversion
that __bpf_trace_##call functions are doing:

	__bpf_trace_##call(void *__data, proto)                                 \
	{                                                                       \
		struct bpf_prog *prog = __data;                                 \
		CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));  \
	}

like for 'old_pid' arg in sched_process_exec tracepoint:

	ffffffff811959e0 <__bpf_trace_sched_process_exec>:
	ffffffff811959e0:       89 d2                   mov    %edx,%edx
	ffffffff811959e2:       e9 a9 07 14 00          jmp    ffffffff812d6190 <bpf_trace_run3>
	ffffffff811959e7:       66 0f 1f 84 00 00 00    nopw   0x0(%rax,%rax,1)
	ffffffff811959ee:       00 00

bpf program could see some trash in args < u64

we'd need to add 'recursion' variant for all __bpf_trace_##call functions

jirka



> +}
> +
> +int bpf_probe_unregister_norecurse(struct bpf_raw_event_map *btp,
> +				   struct bpf_raw_event_data *data)
> +{
> +	int err;
> +	void *bpf_func;
> +
> +	bpf_func = bpf_trace_norecurse_funcs[btp->num_args];
> +	err = tracepoint_probe_unregister(btp->tp, bpf_func, data);
> +	free_percpu(data->active);
> +
> +	return err;
> +}
> +
>  int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
>  			    u32 *fd_type, const char **buf,
>  			    u64 *probe_offset, u64 *probe_addr)
> -- 
> 2.39.0.rc0.267.gcb52ba06e7-goog
> 
