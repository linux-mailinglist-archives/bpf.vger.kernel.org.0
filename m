Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773BD654163
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 13:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbiLVM4E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 07:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbiLVM4B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 07:56:01 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2717EB5E;
        Thu, 22 Dec 2022 04:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1vFrv+zarbZYHT3+ptNBvFlR54/j8sRf1M3avE9pjzs=; b=QGxfGbHTpUd1Ebcww5ZEEaTE6/
        ya/BmPob1YD5pkd7HSuEiNal6es+3RMTQR3x/Hpo8wCXJ74DZ+MHSl58jDGdeB2PIzROPkDQF0Zm8
        4VNF72RFdadMgaSLgmdZFKETvgTKqUuVFyfC+BDOiDWFeMLYBV53PXc+VkMJNQNTko0XlyZA4aeib
        qJfURT8D2Xfe08DoBDUtdTCPayp0cf2uw0GOT1+NQumczRUE+xGxBfeDMDYTUFpmjvmBbBP1m/GI+
        0niJhlZbYwjyNUujI3Uk/rjD4JCdO2HnMHBrg71h/Wx5PzryIpqryc92oLdokDA4tFQZVtm0ejHKn
        MxE8OPLw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1p8L6s-00Dpbg-0L;
        Thu, 22 Dec 2022 12:55:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F8D230006D;
        Thu, 22 Dec 2022 13:55:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE88920C8AA31; Thu, 22 Dec 2022 13:55:39 +0100 (CET)
Date:   Thu, 22 Dec 2022 13:55:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf/perf: Call perf_prepare_sample() before
 bpf_prog_run()
Message-ID: <Y6RTy29ULXp8WJ/Q@hirez.programming.kicks-ass.net>
References: <20221220220144.4016213-1-namhyung@kernel.org>
 <20221220220144.4016213-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220220144.4016213-2-namhyung@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 20, 2022 at 02:01:43PM -0800, Namhyung Kim wrote:
> When the BPF program calls bpf_cast_to_kern_ctx(), it assumes the program will
> access perf sample data directly and call perf_prepare_sample() to make sure
> the sample data is populated.

I don't understand a word of this :/ What are you doing and why?

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  include/linux/bpf.h   | 1 +
>  kernel/bpf/verifier.c | 1 +
>  kernel/events/core.c  | 3 +++
>  3 files changed, 5 insertions(+)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 5fec2d1be6d7..6bd4c21a6dd4 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1341,6 +1341,7 @@ struct bpf_prog {
>  				enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
>  				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
>  				call_get_func_ip:1, /* Do we call get_func_ip() */
> +				call_cast_kctx:1, /* Do we call bpf_cast_to_kern_ctx() */
>  				tstamp_type_access:1; /* Accessed __sk_buff->tstamp_type */
>  	enum bpf_prog_type	type;		/* Type of BPF program */
>  	enum bpf_attach_type	expected_attach_type; /* For some prog types */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index faa358b3d5d7..23a9dc187292 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9236,6 +9236,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  				regs[BPF_REG_0].type = PTR_TO_BTF_ID | PTR_TRUSTED;
>  				regs[BPF_REG_0].btf = desc_btf;
>  				regs[BPF_REG_0].btf_id = meta.ret_btf_id;
> +				env->prog->call_cast_kctx = 1;
>  			} else if (meta.func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
>  				ret_t = btf_type_by_id(desc_btf, meta.arg_constant.value);
>  				if (!ret_t || !btf_type_is_struct(ret_t)) {
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index e47914ac8732..a654a0cb6842 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10332,6 +10332,7 @@ static void bpf_overflow_handler(struct perf_event *event,
>  		.event = event,
>  	};
>  	struct bpf_prog *prog;
> +	struct perf_event_header dummy;
>  	int ret = 0;
>  
>  	ctx.regs = perf_arch_bpf_user_pt_regs(regs);
> @@ -10346,6 +10347,8 @@ static void bpf_overflow_handler(struct perf_event *event,
>  			data->callchain = perf_callchain(event, regs);
>  			data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
>  		}
> +		if (prog->call_cast_kctx)
> +			perf_prepare_sample(&dummy, data, event, regs);
>  
>  		ret = bpf_prog_run(prog, &ctx);
>  	}
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 
