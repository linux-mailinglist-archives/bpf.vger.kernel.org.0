Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABC76AA098
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 21:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjCCU2b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 15:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjCCU2a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 15:28:30 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6C8EC7D
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 12:28:29 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u5so3952316plq.7
        for <bpf@vger.kernel.org>; Fri, 03 Mar 2023 12:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l1gebp45jFNTUhHAPec8zP7ETEVCzs4rZqnHg5dMbjU=;
        b=pntKUMEgvPjY7b9HEa+yY4zRPGpPF3K5W7drObfyXnU6KND/f3I5AFP45VwtTcSbrp
         StthhQWVgSlBs4lvTCtWDanMwGrJuBxwVVbpG0Iexm6ctKoI1VdeVLR2n6TuFC8V9tyU
         kd2KcgfM4Aw30s02u3sPddmM54hdlR1WN2+LKfdmVd8vmCu2f18Y/hY++vpVw08h95lQ
         EsbM+ZqJ8pMXmQnAZHNRzfx4J/u3ldh7I+VzXw57oVNCWuSkrcetOsRaJ0GOjvjwPvQq
         NZL2g/F8mrmUUyIqpv0b6vTqeZ/lUcgvw40R7IoXkOu2Nrxn7teqogKW3grOBnEOSeDa
         9g5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1gebp45jFNTUhHAPec8zP7ETEVCzs4rZqnHg5dMbjU=;
        b=dGo2jPOsfyV3wSOP3Gfg3/2zs6oT1XqQNWo0DjSEwnzuASpnIN1+Et/1w2b5IkjBbD
         i6WI7nolQQCtuTU80GkgEdJm3yJlNioUnT7iUzcaw/njHoU46vctRuKlHtphLPjIeVBu
         jtvuP0i+GpgZJJ4BQ5SmUWjSwFCwsyryPGmbbQ6Zz19ZSSQfNW87zIPYVVKGPw/Hw4T1
         oF07M0ZZDK4c6eZhLx1y9vrjF1mnfcG6TDYGBFKlukLUiAZJzhMvGnpq/iDhSn7egmgp
         hOORraUzq6PboqxOSfpELRP8kbwCi3emm13q6Mh0d4rudLKItMw0cBoxlK1O8QFI7DnX
         tz8g==
X-Gm-Message-State: AO0yUKUSEPxpOOl3GQq/BKnI4aOOx7zw8nAuBHcO4hghWPbDBsh2CS6t
        DZ6MNPnTXsF2GlSdbI560SM=
X-Google-Smtp-Source: AK7set8v7F+4VPfc03d7TB4hE0h/mRMbvOk/6OlKV9N1mXQwmhUO3YMe2yhyIbDCLO9AXswbtzJmGQ==
X-Received: by 2002:a17:90a:19d3:b0:233:b849:7e8f with SMTP id 19-20020a17090a19d300b00233b8497e8fmr2914619pjj.47.1677875308707;
        Fri, 03 Mar 2023 12:28:28 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:c3d9])
        by smtp.gmail.com with ESMTPSA id t10-20020a17090a4e4a00b002371e2ac56csm1847192pjl.32.2023.03.03.12.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 12:28:28 -0800 (PST)
Date:   Fri, 3 Mar 2023 12:28:25 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com, jose.marchesi@oracle.com
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Disassembler tests for
 verifier.c:convert_ctx_access()
Message-ID: <20230303202825.7y2icy3hto6xoveb@MacBook-Pro-6.local>
References: <20230302225507.3413720-1-eddyz87@gmail.com>
 <20230302225507.3413720-4-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302225507.3413720-4-eddyz87@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 03, 2023 at 12:55:07AM +0200, Eduard Zingerman wrote:
> Function verifier.c:convert_ctx_access() applies some rewrites to BPF
> instructions that read or write BPF program context. This commit adds
> machinery to allow test cases that inspect BPF program after these
> rewrites are applied.
> 
> An example of a test case:
> 
>   {
>         // Shorthand for field offset and size specification
> 	N(CGROUP_SOCKOPT, struct bpf_sockopt, retval),
> 
>         // Pattern generated for field read
> 	.read  = "$dst = *(u64 *)($ctx + bpf_sockopt_kern::current_task);"
> 		 "$dst = *(u64 *)($dst + task_struct::bpf_ctx);"
> 		 "$dst = *(u32 *)($dst + bpf_cg_run_ctx::retval);",
> 
>         // Pattern generated for field write
> 	.write = "*(u64 *)($ctx + bpf_sockopt_kern::tmp_reg) = r9;"
> 		 "r9 = *(u64 *)($ctx + bpf_sockopt_kern::current_task);"
> 		 "r9 = *(u64 *)(r9 + task_struct::bpf_ctx);"
> 		 "*(u32 *)(r9 + bpf_cg_run_ctx::retval) = $src;"
> 		 "r9 = *(u64 *)($ctx + bpf_sockopt_kern::tmp_reg);" ,
>   },
> 
> For each test case, up to three programs are created:
> - One that uses BPF_LDX_MEM to read the context field.
> - One that uses BPF_STX_MEM to write to the context field.
> - One that uses BPF_ST_MEM to write to the context field.
> 
> The disassembly of each program is compared with the pattern specified
> in the test case.
> 
> Kernel code for disassembly is reused (as is in the bpftool).
> To keep Makefile changes to the minimum, symbolic links to
> `kernel/bpf/disasm.c` and `kernel/bpf/disasm.h ` are added.
...
> +static regex_t *compile_regex(char *pat)
> +{
> +	regex_t *re;
> +	int err;
> +
> +	re = malloc(sizeof(regex_t));
> +	if (!re) {
> +		PRINT_FAIL("Can't alloc regex\n");
> +		return NULL;
> +	}
> +
> +	err = regcomp(re, pat, REG_EXTENDED);

Fancy. What is the cost of running this in test_progs?
How many seconds does it add to run time?
