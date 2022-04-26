Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339AB50EF56
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 05:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiDZDmr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Apr 2022 23:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243042AbiDZDmq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 23:42:46 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFC0F32B9
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 20:39:40 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t13so15003515pgn.8
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 20:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3rKP+RLeOc5jJqeu5rFp26JtWTspauLmlH0CDP1PP2w=;
        b=BQZI+jLYa6gFFTZ36nSh5zXccyl8hwcrEFV4tzaLDbAMgf0ZV9+GuptLWqeXyRBi9m
         hwl8EFiSxnqp1AM1JmXhysXQZKX1+WQK9hVBOyVbeJYJw+TNp5nnIArIdzoC9Pv8GNu3
         vE0NhD2oigjkbryWVEXONNXKqMErlIRQGAQVLPWt/X9AnMbBTmXRm1/D3IKriUWB+w+i
         ay6NFVK8LrrtSLM3a0nn5o9gfUjLhV7ON7ndDekJN+7z+KKABP3+YjrR5HWFOum64S2o
         gDt6SGCXxQF7TZGvrmHdXXd8/yFE2mB6f/ciNuPiBzuxp8eOro1kZLy4vC7qi0AyyATD
         FVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3rKP+RLeOc5jJqeu5rFp26JtWTspauLmlH0CDP1PP2w=;
        b=wpVQ9FYMH81e5yu2VPcc84lSrtF1S8D9EWhg9MzVHbHmcvjyEhBod33JqcF+x8gfVt
         VnMCdq14nODJkurhrF8bV5QO7UP9W3aF4MijCL7QW7k78W9KZM6Q9T4AUmZYYZNiamyk
         yGRzqzI4Zv4WBF1W3U3h0sVfDiXt3nb5AbF2fFRZmjuj+1QkjGsS83gLUqStzH5DrpQi
         mnahCTW7as3lis5hPXaaOASWlK5J3d7+vUZxkYBJ3n4yl6i85IVM85wEf7GGyM+blRFw
         WMHu9sKBz+rQM761YU9ejMpOIHUwxizKmlQFDHGWdBIRyn5GCRfLvwEhiqVTB9t9rYVB
         o7ZQ==
X-Gm-Message-State: AOAM531MheQosNifeUE2ZryT+YfsoIRcr7gtFZGXLn946G52BWdox2yU
        cgBELnL++W1ZOFcxWUTuErbHg5DEXf4=
X-Google-Smtp-Source: ABdhPJyEB7XyrxfyKDquvcQAkB7n5TDf2zs4BGWTliG3052kT+s9sOxwkgIj/cdXT+GnPuBZKGpSvA==
X-Received: by 2002:a05:6a00:140b:b0:4e1:2cbd:30ba with SMTP id l11-20020a056a00140b00b004e12cbd30bamr22394885pfu.46.1650944380029;
        Mon, 25 Apr 2022 20:39:40 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::5:438a])
        by smtp.gmail.com with ESMTPSA id 12-20020a17090a030c00b001cd4989ff50sm841356pje.23.2022.04.25.20.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 20:39:39 -0700 (PDT)
Date:   Mon, 25 Apr 2022 20:39:37 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v6 13/13] selftests/bpf: Add test for strict BTF
 type check
Message-ID: <20220426033937.jjcua6zchnka5dco@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220424214901.2743946-1-memxor@gmail.com>
 <20220424214901.2743946-14-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424214901.2743946-14-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 25, 2022 at 03:19:01AM +0530, Kumar Kartikeya Dwivedi wrote:
>  
> diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
> index 2e03decb11b6..743ed34c1238 100644
> --- a/tools/testing/selftests/bpf/verifier/calls.c
> +++ b/tools/testing/selftests/bpf/verifier/calls.c
> @@ -138,6 +138,26 @@
>  		{ "bpf_kfunc_call_memb_release", 8 },
>  	},
>  },
> +{
> +	"calls: invalid kfunc call: don't match first member type when passed to release kfunc",
> +	.insns = {
> +	BPF_MOV64_IMM(BPF_REG_0, 0),
> +	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> +	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
> +	BPF_EXIT_INSN(),
> +	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
> +	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> +	BPF_MOV64_IMM(BPF_REG_0, 0),
> +	BPF_EXIT_INSN(),
> +	},
> +	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
> +	.result = REJECT,
> +	.errstr = "kernel function bpf_kfunc_call_memb1_release args#0 expected pointer",
> +	.fixup_kfunc_btf_id = {
> +		{ "bpf_kfunc_call_memb_acquire", 1 },
> +		{ "bpf_kfunc_call_memb1_release", 5 },
> +	},
> +},

Please add negative C tests as well.
Consider using SEC("?tc") logic added by commit 0d7fefebea552
and put a bunch of bpf progs that should fail to load in one .c
