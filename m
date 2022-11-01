Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95356614760
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 11:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiKAKDD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 06:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiKAKDA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 06:03:00 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCBA192A7;
        Tue,  1 Nov 2022 03:02:59 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b2so35774354eja.6;
        Tue, 01 Nov 2022 03:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A4s6tcopyRikT9TW1CRD7BAOi3J91tdy3Cpmpht2rIU=;
        b=F8dM+GOE7N344dgaq77wNUPjNEQfpq6Jc63tHAEntePI68dsDslJD89x9PIGTLlMpF
         Cj66lr1Y9UtbbG9Ji7g+Wo6Vx1UO1YvxY3xNnmSl1KODPWhR3E91+/M8tGnUyt6Ax80v
         0WguA/j60EpaN979yWnW/9BL5Ub683j/7TxwN4LR1nhIct4+LW9Nmv5ZGmgpE1IlvJLv
         z10ewA2k9tmCscaDL6SmGtB74rp4eg1SYMfYeEAf17PvtArHNH7LHSruJB9ay+CoC2Nd
         rTj4wMfBIxRFANTsCP9OZ9ovBQLBULBx4AI6L5p/eXyTto4ZtUIAm2IbXYeJROQ4JIT3
         TqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4s6tcopyRikT9TW1CRD7BAOi3J91tdy3Cpmpht2rIU=;
        b=BoVp68eDsTUSZOiIjFNyr9EPztV+1Q+54GXx5p7eekdh7zqDeEB3YJtgr64z2pCMAj
         CXjZj2yICeXEsCmi6byIs4GsiDdJlBSsctzZ5jt2LrSYZN7KL6X+qESK1CM12aiNi+ID
         VJM5WqxYcm0+ChgNnrJPoZtvhK3WLHn+P5kLUd3RzXV7DRDN0bQli+xuJz6MysjOf5A+
         +fBU1AkKwUIhSNB6wemWa/ti5uYUjSmoL2CsZSOaqJY4Hn952tcx+uMm206winy9a36S
         Ge6XWp0+eDb+5kUs72TrytjjD0Krqkm1bzL3dAqPns5QXaBcL89jbDVV101X52hYSvgG
         xzMA==
X-Gm-Message-State: ACrzQf3Kqm/q49qO2vMrYOtsgNg0/hMpn2kvgMyRLENavYr6v+5MVf3S
        9/3wlSoinpTX8qL4nROvM/Q=
X-Google-Smtp-Source: AMsMyM6sKlJCkouxCIxa6TGXcxP+jDm3HMb1PE8LzsfE/JB+WVgkxvvCA/fEOuOOG44IkHiK+9gDIw==
X-Received: by 2002:a17:906:fe45:b0:791:9624:9ea4 with SMTP id wz5-20020a170906fe4500b0079196249ea4mr17343592ejb.147.1667296977730;
        Tue, 01 Nov 2022 03:02:57 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id kw9-20020a170907770900b0078de26f66b9sm4004598ejc.114.2022.11.01.03.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 03:02:56 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 1 Nov 2022 11:02:54 +0100
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add bpf_perf_event_read_sample() helper
Message-ID: <Y2DuzmnUm6NIh25a@krava>
References: <20221101052340.1210239-1-namhyung@kernel.org>
 <20221101052340.1210239-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101052340.1210239-3-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 31, 2022 at 10:23:39PM -0700, Namhyung Kim wrote:
> The bpf_perf_event_read_sample() helper is to get the specified sample
> data (by using PERF_SAMPLE_* flag in the argument) from BPF to make a
> decision for filtering on samples.  Currently PERF_SAMPLE_IP and
> PERF_SAMPLE_DATA flags are supported only.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  include/uapi/linux/bpf.h       | 23 ++++++++++++++++
>  kernel/trace/bpf_trace.c       | 49 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 23 ++++++++++++++++
>  3 files changed, 95 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 94659f6b3395..cba501de9373 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5481,6 +5481,28 @@ union bpf_attr {
>   *		0 on success.
>   *
>   *		**-ENOENT** if the bpf_local_storage cannot be found.
> + *
> + * long bpf_perf_event_read_sample(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 sample_flags)
> + *	Description
> + *		For an eBPF program attached to a perf event, retrieve the
> + *		sample data associated to *ctx*	and store it in the buffer
> + *		pointed by *buf* up to size *size* bytes.
> + *
> + *		The *sample_flags* should contain a single value in the
> + *		**enum perf_event_sample_format**.
> + *	Return
> + *		On success, number of bytes written to *buf*. On error, a
> + *		negative value.
> + *
> + *		The *buf* can be set to **NULL** to return the number of bytes
> + *		required to store the requested sample data.
> + *
> + *		**-EINVAL** if *sample_flags* is not a PERF_SAMPLE_* flag.
> + *
> + *		**-ENOENT** if the associated perf event doesn't have the data.
> + *
> + *		**-ENOSYS** if system doesn't support the sample data to be
> + *		retrieved.
>   */
>  #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
>  	FN(unspec, 0, ##ctx)				\
> @@ -5695,6 +5717,7 @@ union bpf_attr {
>  	FN(user_ringbuf_drain, 209, ##ctx)		\
>  	FN(cgrp_storage_get, 210, ##ctx)		\
>  	FN(cgrp_storage_delete, 211, ##ctx)		\
> +	FN(perf_event_read_sample, 212, ##ctx)		\
>  	/* */
>  
>  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index ce0228c72a93..befd937afa3c 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -28,6 +28,7 @@
>  
>  #include <uapi/linux/bpf.h>
>  #include <uapi/linux/btf.h>
> +#include <uapi/linux/perf_event.h>
>  
>  #include <asm/tlb.h>
>  
> @@ -1743,6 +1744,52 @@ static const struct bpf_func_proto bpf_read_branch_records_proto = {
>  	.arg4_type      = ARG_ANYTHING,
>  };
>  
> +BPF_CALL_4(bpf_perf_event_read_sample, struct bpf_perf_event_data_kern *, ctx,
> +	   void *, buf, u32, size, u64, flags)
> +{

I wonder we could add perf_btf (like we have tp_btf) program type that
could access ctx->data directly without helpers

> +	struct perf_sample_data *sd = ctx->data;
> +	void *data;
> +	u32 to_copy = sizeof(u64);
> +
> +	/* only allow a single sample flag */
> +	if (!is_power_of_2(flags))
> +		return -EINVAL;
> +
> +	/* support reading only already populated info */
> +	if (flags & ~sd->sample_flags)
> +		return -ENOENT;
> +
> +	switch (flags) {
> +	case PERF_SAMPLE_IP:
> +		data = &sd->ip;
> +		break;
> +	case PERF_SAMPLE_ADDR:
> +		data = &sd->addr;
> +		break;

AFAICS from pe_prog_convert_ctx_access you should be able to read addr
directly from context right? same as sample_period.. so I think if this
will be generic way to read sample data, should we add sample_period
as well?


> +	default:
> +		return -ENOSYS;
> +	}
> +
> +	if (!buf)
> +		return to_copy;
> +
> +	if (size < to_copy)
> +		to_copy = size;

should we fail in here instead? is there any point in returning
not complete data?

jirka


> +
> +	memcpy(buf, data, to_copy);
> +	return to_copy;
> +}
> +
> +static const struct bpf_func_proto bpf_perf_event_read_sample_proto = {
> +	.func           = bpf_perf_event_read_sample,
> +	.gpl_only       = true,
> +	.ret_type       = RET_INTEGER,
> +	.arg1_type      = ARG_PTR_TO_CTX,
> +	.arg2_type      = ARG_PTR_TO_MEM_OR_NULL,
> +	.arg3_type      = ARG_CONST_SIZE_OR_ZERO,
> +	.arg4_type      = ARG_ANYTHING,
> +};
> +
>  static const struct bpf_func_proto *
>  pe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  {
> @@ -1759,6 +1806,8 @@ pe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		return &bpf_read_branch_records_proto;
>  	case BPF_FUNC_get_attach_cookie:
>  		return &bpf_get_attach_cookie_proto_pe;
> +	case BPF_FUNC_perf_event_read_sample:
> +		return &bpf_perf_event_read_sample_proto;
>  	default:
>  		return bpf_tracing_func_proto(func_id, prog);
>  	}
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 94659f6b3395..cba501de9373 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -5481,6 +5481,28 @@ union bpf_attr {
>   *		0 on success.
>   *
>   *		**-ENOENT** if the bpf_local_storage cannot be found.
> + *
> + * long bpf_perf_event_read_sample(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 sample_flags)
> + *	Description
> + *		For an eBPF program attached to a perf event, retrieve the
> + *		sample data associated to *ctx*	and store it in the buffer
> + *		pointed by *buf* up to size *size* bytes.
> + *
> + *		The *sample_flags* should contain a single value in the
> + *		**enum perf_event_sample_format**.
> + *	Return
> + *		On success, number of bytes written to *buf*. On error, a
> + *		negative value.
> + *
> + *		The *buf* can be set to **NULL** to return the number of bytes
> + *		required to store the requested sample data.
> + *
> + *		**-EINVAL** if *sample_flags* is not a PERF_SAMPLE_* flag.
> + *
> + *		**-ENOENT** if the associated perf event doesn't have the data.
> + *
> + *		**-ENOSYS** if system doesn't support the sample data to be
> + *		retrieved.
>   */
>  #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
>  	FN(unspec, 0, ##ctx)				\
> @@ -5695,6 +5717,7 @@ union bpf_attr {
>  	FN(user_ringbuf_drain, 209, ##ctx)		\
>  	FN(cgrp_storage_get, 210, ##ctx)		\
>  	FN(cgrp_storage_delete, 211, ##ctx)		\
> +	FN(perf_event_read_sample, 212, ##ctx)		\
>  	/* */
>  
>  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
> -- 
> 2.38.1.273.g43a17bfeac-goog
> 
