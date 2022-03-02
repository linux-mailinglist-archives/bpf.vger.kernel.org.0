Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F8F4CAEDF
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 20:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241761AbiCBTm3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 14:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbiCBTm3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 14:42:29 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09A2C4E1F;
        Wed,  2 Mar 2022 11:41:45 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id h17so2479338plc.5;
        Wed, 02 Mar 2022 11:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vjf7RPI2PKTb2kP9VHjBAcKqQnyTyYbCaciuvjfKLdQ=;
        b=Dt6FS/uern+P5cz68+l/TVM/2ptRyGYPwDpkvrmWlwJNRyGimf1HFkiHrhNRYEqIr4
         hMhStkL/cQSxSRpl8KEGVGFH13H5RlSm6EHsDf+7dwiFmollv0lCusMFh0W9nBB2iDlC
         snYE7crbNCuDi/lkJMEbk21nFCiKV0GT1TsosUOJG1bOzqoXaMI0/sWvPKNZdmRNkCVT
         Q0T/wzMMiQTi07QoQB4aBAjDOlNJEViAaVp2HGhBRm+Xy8k4SoN5t2NKH0fmJkDYnns8
         pOKffa6ADQaF6G7FXCWwGo8mDCHKO2C5a9YVfs5hlI+qOOsr65lYAi+2DB2tb37iXAE4
         9cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vjf7RPI2PKTb2kP9VHjBAcKqQnyTyYbCaciuvjfKLdQ=;
        b=KbNdBhRNHXDqLi2ppKTkUDmSBelYIG7qX8bN91Sanm5AO1tSK5AHA22euWnr96B1V0
         8ZHZdxrRmtRF8CpZhNwiq1fRaJ2jxCaxSydiyj1KMmCdFNsonKzBx7bC0pX+cmcWd+6s
         f2KJiZ+4IcwTzHenhOzH2drimbc0X1fGc6GaWzNUr/t7quUzyHE99sp4pE5UowTQ4dcz
         Jo1MiFM/5bIlDq0DP8JnHvMpmpK5RE/lNQdXRXZotBvV5wutOU2wr3nMHC+BL+Swk2SQ
         fQ8N5yBk7/6w5YE0mFXMR1jj9Z3SGTAM+ZTIcZESbt9lxfClaNaK6X01lwIDAs40oRcg
         zVbw==
X-Gm-Message-State: AOAM532wbw32UOj+doLPfBet/LKAI5U4cN9T8/EZafa4ECDVNVOD40jV
        5RyvfXjksv0qVcF6Jydm1ns=
X-Google-Smtp-Source: ABdhPJyEfgPOChikbUCIQi7LbvhSiDjtwB171jmFJnjCe8nZwlmuSPzXITLl3okBRlj/xYFJRcI9ow==
X-Received: by 2002:a17:902:e807:b0:150:2801:86f8 with SMTP id u7-20020a170902e80700b00150280186f8mr27465791plg.64.1646250105307;
        Wed, 02 Mar 2022 11:41:45 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:500::2:156b])
        by smtp.gmail.com with ESMTPSA id bo10-20020a17090b090a00b001bc8405bd55sm5892624pjb.30.2022.03.02.11.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:41:45 -0800 (PST)
Date:   Wed, 2 Mar 2022 11:41:41 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 4/9] bpf: Introduce sleepable tracepoints
Message-ID: <20220302194141.c4gvqz5v4mmmbwsv@ast-mbp.dhcp.thefacebook.com>
References: <20220225234339.2386398-1-haoluo@google.com>
 <20220225234339.2386398-5-haoluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225234339.2386398-5-haoluo@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 25, 2022 at 03:43:34PM -0800, Hao Luo wrote:
> diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
> index e7c2276be33e..c73c7ab3680e 100644
> --- a/include/linux/tracepoint-defs.h
> +++ b/include/linux/tracepoint-defs.h
> @@ -51,6 +51,7 @@ struct bpf_raw_event_map {
>  	void			*bpf_func;
>  	u32			num_args;
>  	u32			writable_size;
> +	u32			sleepable;

It increases the size for all tracepoints. 
See BPF_RAW_TP in include/asm-generic/vmlinux.lds.h
Please switch writeable_size and sleepable to u16.
>  
> -static const struct bpf_func_proto *
> -syscall_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> +/* Syscall helpers that are also allowed in sleepable tracing prog. */
> +const struct bpf_func_proto *
> +tracing_prog_syscall_func_proto(enum bpf_func_id func_id,
> +				const struct bpf_prog *prog)
>  {
>  	switch (func_id) {
>  	case BPF_FUNC_sys_bpf:
>  		return &bpf_sys_bpf_proto;
> -	case BPF_FUNC_btf_find_by_name_kind:
> -		return &bpf_btf_find_by_name_kind_proto;
>  	case BPF_FUNC_sys_close:
>  		return &bpf_sys_close_proto;
> -	case BPF_FUNC_kallsyms_lookup_name:
> -		return &bpf_kallsyms_lookup_name_proto;
>  	case BPF_FUNC_mkdir:
>  		return &bpf_mkdir_proto;
>  	case BPF_FUNC_rmdir:
>  		return &bpf_rmdir_proto;
>  	case BPF_FUNC_unlink:
>  		return &bpf_unlink_proto;
> +	default:
> +		return NULL;
> +	}
> +}

If I read this correctly the goal is to disallow find_by_name_kind
and lookup_name from sleepable tps. Why? What's the harm?
