Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F55452065A
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 23:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiEIVIZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 17:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiEIVIY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 17:08:24 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311D2266F27
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 14:04:29 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso459719pjg.0
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 14:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tkRR9zwU/rZNLr39saNXLKyItk/mmddUXgJskmDljrk=;
        b=EGH7++qZLRx3XdmCrdXBoyhbomJm6F1/y6qodlIYRJtWO2EwNqEl74NkJc8CTJLFaB
         E/fnn2XwJ0leOA0SgkF6Wymoh8H9/EK5lecmN/onauNh05xCKFV0WYjEPhQx9NVg0kKR
         jqRncy2uETKMQA4VWY+HolEg8fR9D1ggVWyS7a11K2ssRonJ9Ub85reK6/MgcudmZ/+p
         kLVZhejB0A2Ho8K0Z12FA2qeDj4WgNknTRLho17HC8yDhOjqS64k/rl/5VxHPj9a4wjV
         weOOW4tJovaf5+f1DXL6cPhSjkFH2JqAXGEDojZJ7tEYjGVIMCb23O33ycXvLEBc/Awf
         twEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tkRR9zwU/rZNLr39saNXLKyItk/mmddUXgJskmDljrk=;
        b=3P7bE7BeQa/cQhfd5rju97Tpy630cQJ+szyazN2ZgnmhlbAm2tIEqv9RUhRORhg7Ye
         lbC07qTj9ljP4ZwndTRYWoBDAkEXfoDKLgGPLTAzDQ63ZyEVQ7212YTzMkwMJItd2BV/
         Ee4oB1yD7fD/Ww+rfDRgGnuNJrkZP+VjACz0JiMhs5Q4rgaVv47ij3avjHE+TjHrwGXz
         xjIeIxKrlcS5qcwzWSl8BPPcM1uViQZqLrvurZpPx4cfB7TG31VD6Tb7pwT48KZ9RDFy
         3prNwWZoQyIRNIGajQKi/1JQ+2/vBkciaQedHz2xBUcMedhX7pgpbYECFmlyv543p13j
         mG8Q==
X-Gm-Message-State: AOAM531iDTyfFLhvK6QNvPDZKDf2yMY555UPu9piuckzDszBBJgxTibR
        pwV0gAjIcV5yYLCtlr5YMNc=
X-Google-Smtp-Source: ABdhPJwPS/a63ksfgwYi7jMjNfWTMYQC/oR4R/iDt7Z1Djv2iqOfiI+TKjJOdbh3rMy7JpagGY5Caw==
X-Received: by 2002:a17:90a:fd10:b0:1d9:2a41:6fe6 with SMTP id cv16-20020a17090afd1000b001d92a416fe6mr28070594pjb.196.1652130268668;
        Mon, 09 May 2022 14:04:28 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::4:e8e5])
        by smtp.gmail.com with ESMTPSA id i21-20020aa79095000000b0050dc76281ddsm9037256pfa.183.2022.05.09.14.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 14:04:27 -0700 (PDT)
Date:   Mon, 9 May 2022 14:04:25 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v7 2/5] bpf, x86: Create bpf_tramp_run_ctx on
 the caller thread's stack
Message-ID: <20220509210425.igjjopd4virbtn3u@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220508032117.2783209-1-kuifeng@fb.com>
 <20220508032117.2783209-3-kuifeng@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508032117.2783209-3-kuifeng@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, May 07, 2022 at 08:21:14PM -0700, Kui-Feng Lee wrote:
>  
> +	/* Prepare struct bpf_tramp_run_ctx.
> +	 * sub rsp, sizeof(struct bpf_tramp_run_ctx)
> +	 */
> +	EMIT4(0x48, 0x83, 0xEC, sizeof(struct bpf_tramp_run_ctx));
> +
>  	if (fentry->nr_links)
>  		if (invoke_bpf(m, &prog, fentry, regs_off,
>  			       flags & BPF_TRAMP_F_RET_FENTRY_RET))
> @@ -2098,6 +2121,11 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>  	}
>  
>  	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> +		/* pop struct bpf_tramp_run_ctx
> +		 * add rsp, sizeof(struct bpf_tramp_run_ctx)
> +		 */
> +		EMIT4(0x48, 0x83, 0xC4, sizeof(struct bpf_tramp_run_ctx));
> +
>  		restore_regs(m, &prog, nr_args, regs_off);
>  
>  		/* call original function */
> @@ -2110,6 +2138,11 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>  		im->ip_after_call = prog;
>  		memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
>  		prog += X86_PATCH_SIZE;
> +
> +		/* Prepare struct bpf_tramp_run_ctx.
> +		 * sub rsp, sizeof(struct bpf_tramp_run_ctx)
> +		 */
> +		EMIT4(0x48, 0x83, 0xEC, sizeof(struct bpf_tramp_run_ctx));
>  	}
>  
>  	if (fmod_ret->nr_links) {
> @@ -2133,6 +2166,11 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>  			goto cleanup;
>  		}
>  
> +	/* pop struct bpf_tramp_run_ctx
> +	 * add rsp, sizeof(struct bpf_tramp_run_ctx)
> +	 */
> +	EMIT4(0x48, 0x83, 0xC4, sizeof(struct bpf_tramp_run_ctx));
> +

What is the point of all of these additional sub/add rsp ?
It seems unconditionally increasing stack_size by sizeof(struct bpf_tramp_run_ctx)
will achieve the same and above 4 extra insns won't be needed.
