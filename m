Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1DB520BAE
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 05:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbiEJDIj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 23:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiEJDIf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 23:08:35 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B8B1D570B
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 20:04:36 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q76so13536255pgq.10
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 20:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4Jant71sQRUgLiQHQAFDf7E+ia1Oql9fYYqCtBcIvJQ=;
        b=BoBjLlC/uuUZuyH5Dg9kZ4ei6ikMANV+AZ+0dca0JXi0F5/R8Hp2zpWs4YrPqTFjKl
         2/6BSJ/K5xI/ExABZcxwXo2KJqLF5VG49xlQ08icCHodiToc6oWFr7MH/KmRzVNmsW2f
         wQAmq3+91uYm73Wer+Q1Su3yt+rTf9XRtpjE67VZo3PnKPH3ZCZGl5sxeEhWgONA0RLP
         72dbX5YakVcPV076+jaivoB7YuIShk0MPvs3yGF6utig+7kjvUEEmQkTUq6dordBIid6
         dxGxf8DHTWMkU71RSvUjHkB/9ZRgZnK2v65RlixPq51TthSxS3nR+XL+11BHVNB4+ipD
         Qs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Jant71sQRUgLiQHQAFDf7E+ia1Oql9fYYqCtBcIvJQ=;
        b=IT6FCxHPOHm2YTD3hJ66luXVb/Or/GwcaBA1ulZq0SxjexCiG0Qk3h5fhGMEzgToJ0
         nmRLimP4CfZr0/l5SPQeecFjTAzh6sjukSbTp9hEJ4TyIxab8UVAtrb8cHo5Up9e+bQn
         rBw7UbUCv85whg/yjajsSZ1rrAtfnH+is/FMx0ky6SheymElHt3V05dGd0RAQk8E6Ehb
         drAetvze/3c5EWNGZgvlLnByfddJuFk73VVwAIpnO00/yuHfXoO8FsNs1KRavFDmlSXn
         /JlOvSa7uYqXwieT0UZToyP2qXDLSR5O1K/jhUgX1fkpa7tqb5zf2gpp07diJLOD3IOV
         NH7Q==
X-Gm-Message-State: AOAM531svn52NXe9fh3pMM0vsbhF7oskt4YDYKhvcuAAzAId0sPx7KE1
        ZG41kkurPZX2Ln/Pv7yu5WU=
X-Google-Smtp-Source: ABdhPJxeVV7VNSqk24whSg9dO+y70HzOAbyA4BsbGsqgCKQU40JIR00+qkU3oxyxjsCi13HWOC4c1g==
X-Received: by 2002:a05:6a00:2408:b0:4f7:a8cb:9b63 with SMTP id z8-20020a056a00240800b004f7a8cb9b63mr18802740pfh.33.1652151875670;
        Mon, 09 May 2022 20:04:35 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::4:e8e5])
        by smtp.gmail.com with ESMTPSA id c20-20020aa78814000000b0050dc76281cfsm9349711pfo.169.2022.05.09.20.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 20:04:35 -0700 (PDT)
Date:   Mon, 9 May 2022 20:04:33 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: move bpf_prog to bpf.h
Message-ID: <20220510030433.msgh5boc6xrh6pdv@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <cover.1651532419.git.delyank@fb.com>
 <616c50d61de26eacd49fbb641d3122a85ca478fc.1651532419.git.delyank@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <616c50d61de26eacd49fbb641d3122a85ca478fc.1651532419.git.delyank@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 02, 2022 at 11:09:38PM +0000, Delyan Kratunov wrote:
> In order to add a version of bpf_prog_run_array which accesses the
> bpf_prog->aux member, we need bpf_prog to be more than a forward
> declaration inside bpf.h.
> 
> Given that filter.h already includes bpf.h, this merely reorders
> the type declarations for filter.h users. bpf.h users now have access to
> bpf_prog internals.
> 
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  include/linux/bpf.h    | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/filter.h | 34 ----------------------------------
>  2 files changed, 36 insertions(+), 34 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index be94833d390a..57ec619cf729 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -5,6 +5,7 @@
>  #define _LINUX_BPF_H 1
>  
>  #include <uapi/linux/bpf.h>
> +#include <uapi/linux/filter.h>

because of struct sock_filter ?
Pls fwd declare it instead.

>  #include <linux/workqueue.h>
>  #include <linux/file.h>
> @@ -22,6 +23,7 @@
>  #include <linux/sched/mm.h>
>  #include <linux/slab.h>
>  #include <linux/percpu-refcount.h>
> +#include <linux/stddef.h>
>  #include <linux/bpfptr.h>
>  #include <linux/btf.h>
>  
> @@ -1068,6 +1070,40 @@ struct bpf_prog_aux {
>  	};
>  };
>  
> +struct bpf_prog {
> +	u16			pages;		/* Number of allocated pages */
> +	u16			jited:1,	/* Is our filter JIT'ed? */
> +				jit_requested:1,/* archs need to JIT the prog */
> +				gpl_compatible:1, /* Is filter GPL compatible? */
> +				cb_access:1,	/* Is control block accessed? */
> +				dst_needed:1,	/* Do we need dst entry? */
> +				blinding_requested:1, /* needs constant blinding */
> +				blinded:1,	/* Was blinded */
> +				is_func:1,	/* program is a bpf function */
> +				kprobe_override:1, /* Do we override a kprobe? */
> +				has_callchain_buf:1, /* callchain buffer allocated? */
> +				enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
> +				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
> +				call_get_func_ip:1, /* Do we call get_func_ip() */
> +				tstamp_type_access:1; /* Accessed __sk_buff->tstamp_type */
> +	enum bpf_prog_type	type;		/* Type of BPF program */
> +	enum bpf_attach_type	expected_attach_type; /* For some prog types */
> +	u32			len;		/* Number of filter blocks */
> +	u32			jited_len;	/* Size of jited insns in bytes */
> +	u8			tag[BPF_TAG_SIZE];
> +	struct bpf_prog_stats __percpu *stats;
> +	int __percpu		*active;
> +	unsigned int		(*bpf_func)(const void *ctx,
> +					    const struct bpf_insn *insn);
> +	struct bpf_prog_aux	*aux;		/* Auxiliary fields */
> +	struct sock_fprog_kern	*orig_prog;	/* Original BPF program */
> +	/* Instructions for interpreter */
> +	union {
> +		DECLARE_FLEX_ARRAY(struct sock_filter, insns);
> +		DECLARE_FLEX_ARRAY(struct bpf_insn, insnsi);
> +	};
> +};
> +
>  struct bpf_array_aux {
>  	/* Programs with direct jumps into programs part of this array. */
>  	struct list_head poke_progs;
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index ed0c0ff42ad5..d0cbb31b1b4d 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -559,40 +559,6 @@ struct bpf_prog_stats {
>  	struct u64_stats_sync syncp;
>  } __aligned(2 * sizeof(u64));
>  
> -struct bpf_prog {
> -	u16			pages;		/* Number of allocated pages */
> -	u16			jited:1,	/* Is our filter JIT'ed? */
> -				jit_requested:1,/* archs need to JIT the prog */
> -				gpl_compatible:1, /* Is filter GPL compatible? */
> -				cb_access:1,	/* Is control block accessed? */
> -				dst_needed:1,	/* Do we need dst entry? */
> -				blinding_requested:1, /* needs constant blinding */
> -				blinded:1,	/* Was blinded */
> -				is_func:1,	/* program is a bpf function */
> -				kprobe_override:1, /* Do we override a kprobe? */
> -				has_callchain_buf:1, /* callchain buffer allocated? */
> -				enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
> -				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
> -				call_get_func_ip:1, /* Do we call get_func_ip() */
> -				tstamp_type_access:1; /* Accessed __sk_buff->tstamp_type */
> -	enum bpf_prog_type	type;		/* Type of BPF program */
> -	enum bpf_attach_type	expected_attach_type; /* For some prog types */
> -	u32			len;		/* Number of filter blocks */
> -	u32			jited_len;	/* Size of jited insns in bytes */
> -	u8			tag[BPF_TAG_SIZE];
> -	struct bpf_prog_stats __percpu *stats;
> -	int __percpu		*active;
> -	unsigned int		(*bpf_func)(const void *ctx,
> -					    const struct bpf_insn *insn);
> -	struct bpf_prog_aux	*aux;		/* Auxiliary fields */
> -	struct sock_fprog_kern	*orig_prog;	/* Original BPF program */
> -	/* Instructions for interpreter */
> -	union {
> -		DECLARE_FLEX_ARRAY(struct sock_filter, insns);
> -		DECLARE_FLEX_ARRAY(struct bpf_insn, insnsi);
> -	};
> -};
> -
>  struct sk_filter {
>  	refcount_t	refcnt;
>  	struct rcu_head	rcu;
> -- 
> 2.35.1
