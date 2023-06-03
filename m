Return-Path: <bpf+bounces-1753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3558D720CFC
	for <lists+bpf@lfdr.de>; Sat,  3 Jun 2023 03:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC971C21239
	for <lists+bpf@lfdr.de>; Sat,  3 Jun 2023 01:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7024017F5;
	Sat,  3 Jun 2023 01:26:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEDB816
	for <bpf@vger.kernel.org>; Sat,  3 Jun 2023 01:26:57 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36C218D
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 18:26:55 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565ba5667d5so35394317b3.0
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 18:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685755615; x=1688347615;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r9odDFuUUCWNFrJW5Mn1/x9rMGT75lmcR9ka1dMFpE4=;
        b=Jv7XGDxzp2tsB25VC6pyU0066j5ScpxkzYxTx88IAYu/PzkCsqAUGFutIplRdqxDvR
         f7YtpwlbTOjWdwErALUEPDvv8h+xSpcSEmEpUs93NthDTXJfk7c2vrPIfpaCXJlUvfnP
         eefGoRmZZQgMZdWHno/fOIeibRxus2L1wthgWDRr8PQrt8SV3+ApF5GaRFUixWB/bQrx
         7rK3YUvwJmns1RQjS3rzo+u9RW1rIEobxYGlsvB5Krjq8ZhKKpY4xgDim9PbAyqtfRr8
         HNP1pMCv70xFxKHRAXuY/Vxo/yYlTVDWtF+xM9OXVlS3p3DD/ECZKGwK0WXhmlQVz48g
         qv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685755615; x=1688347615;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9odDFuUUCWNFrJW5Mn1/x9rMGT75lmcR9ka1dMFpE4=;
        b=SJSwawza8QXxlTXIdM9rVysymPnybtt3EHUO08UpfNjIrhYqcZBUpm7n+iLgS+Tdpu
         VnLU/ZzisjAaFSmftu++qZ//2zI4kfqjyE/jeia+0fku3nGILZXm39UD8yexvlnoHst7
         QYnShacgRqorkXw2+emNSbN5Z0RWdcj6Sy77orl9udJruD9rhPTO/C4z0UUTnUbVDNRb
         /p07C7mQ8zVRS/90j4xh/QkkSED88cdRyeLFloVUEUmAMJ45guW3lipa1frXjt23E2yp
         ncErm4PbzPO8vRuwGBWV267NI8PQqNOU/fKvVfJzYxa4A7NH4zlv9qDeAplrBkoYHUjq
         wqPw==
X-Gm-Message-State: AC+VfDy0lrH3lPpoGZNGqT4shJPYfKXwbW8698IyMnZ3co9i2pbhRBdx
	HlsAk2xRADTKcs4Z8cApmZWQ6Jc=
X-Google-Smtp-Source: ACHHUZ7cUn6di0z+VHCnYruEupC4/XAPHq4LtCcgEieFZHxLiwblbk1gNYIlx/2RIebcm6SHJgSqMEY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:ad66:0:b0:55d:955b:360 with SMTP id
 l38-20020a81ad66000000b0055d955b0360mr796535ywk.5.1685755614961; Fri, 02 Jun
 2023 18:26:54 -0700 (PDT)
Date: Fri, 2 Jun 2023 18:26:53 -0700
In-Reply-To: <20230602150112.1494194-2-void@manifault.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230602150112.1494194-1-void@manifault.com> <20230602150112.1494194-2-void@manifault.com>
Message-ID: <ZHqW3d2naDAZsmAs@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test for non-NULLable PTR_TO_BTF_IDs
From: Stanislav Fomichev <sdf@google.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 06/02, David Vernet wrote:
> In a recent patch, we taught the verifier that trusted PTR_TO_BTF_ID can
> never be NULL. This prevents the verifier from incorrectly failing to
> load certain programs where it gets confused and thinks a reference
> isn't dropped because it incorrectly assumes that a branch exists in
> which a NULL PTR_TO_BTF_ID pointer is never released.
> 
> This patch adds a testcase that verifies this cannot happen.
> 
> Signed-off-by: David Vernet <void@manifault.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

I hope someone else can look at the actual change. It looks good to
me conceptually, but not sure what other parts it might affect.

> ---
>  .../selftests/bpf/prog_tests/cpumask.c        |  1 +
>  .../selftests/bpf/progs/cpumask_success.c     | 24 +++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c b/tools/testing/selftests/bpf/prog_tests/cpumask.c
> index cdf4acc18e4c..d89191440fb1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cpumask.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
> @@ -70,5 +70,6 @@ void test_cpumask(void)
>  		verify_success(cpumask_success_testcases[i]);
>  	}
>  
> +	RUN_TESTS(cpumask_success);
>  	RUN_TESTS(cpumask_failure);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
> index 2fcdd7f68ac7..602a88b03dbc 100644
> --- a/tools/testing/selftests/bpf/progs/cpumask_success.c
> +++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
> @@ -5,6 +5,7 @@
>  #include <bpf/bpf_tracing.h>
>  #include <bpf/bpf_helpers.h>
>  
> +#include "bpf_misc.h"
>  #include "cpumask_common.h"
>  
>  char _license[] SEC("license") = "GPL";
> @@ -426,3 +427,26 @@ int BPF_PROG(test_global_mask_rcu, struct task_struct *task, u64 clone_flags)
>  
>  	return 0;
>  }
> +
> +SEC("tp_btf/task_newtask")
> +__success
> +int BPF_PROG(test_refcount_null_tracking, struct task_struct *task, u64 clone_flags)
> +{
> +	struct bpf_cpumask *mask1, *mask2;
> +
> +	mask1 = bpf_cpumask_create();
> +	mask2 = bpf_cpumask_create();
> +
> +	if (!mask1 || !mask2)
> +		goto free_masks_return;
> +
> +	bpf_cpumask_test_cpu(0, (const struct cpumask *)mask1);
> +	bpf_cpumask_test_cpu(0, (const struct cpumask *)mask2);
> +
> +free_masks_return:
> +	if (mask1)
> +		bpf_cpumask_release(mask1);
> +	if (mask2)
> +		bpf_cpumask_release(mask2);
> +	return 0;
> +}
> -- 
> 2.40.1
> 

