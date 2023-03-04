Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B936AACA6
	for <lists+bpf@lfdr.de>; Sat,  4 Mar 2023 22:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjCDVJl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Mar 2023 16:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDVJl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Mar 2023 16:09:41 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13832F749
        for <bpf@vger.kernel.org>; Sat,  4 Mar 2023 13:09:40 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cy23so23567814edb.12
        for <bpf@vger.kernel.org>; Sat, 04 Mar 2023 13:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D8nbD3YWgkL7DX+G36E0KV4xZhI7ZUjJcMoDDQRdXKM=;
        b=RlbUgGu9cJxt47xBOIx7uiwgAA8d7TtmPmkArBF2P/2kqLv7hbAy/+jVCxOQnyKoo9
         L+dR16dnfaLxMwsUl+dGWvJpO2zoemrFu7UAEHrBiRqasqu4WVlpfZUVfPlhecGWKaB/
         h8IL7Fv/JJWBNs7r9qxOcx+xXhZRjUKZBn2uwrF5ngCvKCAJwQo9OJ8yZknVScGehODP
         Ma6is3vTwJp3Mf8bBRyXAPGejOeHro899QPgAab1jxKCUxohP33I7dNVQpfYhy2h1p0t
         S3Jru7YrTO86X2YfIp69/P5Op9JS4Mz/EU7qIEkkxwWOaYH8nGuApJWtymdHRrzYyOtH
         4wTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8nbD3YWgkL7DX+G36E0KV4xZhI7ZUjJcMoDDQRdXKM=;
        b=C+Mwu6KXYB0dfzpSK35W4ebmngF1xncOrlXwLmHWE7cdfJJiHqAMw12fpc0e4bfl/i
         Y2c+kji5mX1yLZ26mVajqPiy+5L54Xda5j+PA4tBBLrSEGz3d417WF9FeCgLT3K2d9Xr
         PMbno3HdTe20OiuHLEkIvoe7jmf2Ywf+PxGoQbZvHmmLeZgY0nKzTtocnZKeVtM4RehA
         tL9RUMlEvE+/+ozltBVPQghJyxpTYWNmsysXj2J0xxxWzJ6eUGALF3nGBWk273ZUQklg
         CtchJXr4GDowWuzsjJ4+Zm+pwbz2f+H4Te3hdO0yLsIKJnZL35D6QXOWEx2hkuVFklbT
         97FA==
X-Gm-Message-State: AO0yUKX3HcUPf/cDZJJCAKe0ojjhAdnx+4aKBJHdkO5k5jTqKLNSXn6p
        guWohwIQjD3trCwNG9E+zqx2e5wpopM=
X-Google-Smtp-Source: AK7set/8Vv4u3SfjDqhzeThhavPcx6I9bTvKBXt/UuRz+FZbahvTfn/cHQH1JjipqXyMBEAlD+tV0g==
X-Received: by 2002:a05:6402:345b:b0:4ac:bd72:e7c5 with SMTP id l27-20020a056402345b00b004acbd72e7c5mr5822875edc.20.1677964178405;
        Sat, 04 Mar 2023 13:09:38 -0800 (PST)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id i30-20020a50871e000000b004c44d00a3b5sm2830300edb.20.2023.03.04.13.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 13:09:38 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sat, 4 Mar 2023 22:09:35 +0100
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 16/17] selftests/bpf: add iterators tests
Message-ID: <ZAOzjzkV0Rg1F810@krava>
References: <20230302235015.2044271-1-andrii@kernel.org>
 <20230302235015.2044271-17-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302235015.2044271-17-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 02, 2023 at 03:50:14PM -0800, Andrii Nakryiko wrote:

SNIP

> +
> +SEC("raw_tp")
> +__success
> +int iter_pass_iter_ptr_to_subprog(const void *ctx)
> +{
> +	int arr1[16], arr2[32];
> +	struct bpf_iter it;
> +	int n, sum1, sum2;
> +
> +	MY_PID_GUARD();
> +
> +	/* fill arr1 */
> +	n = ARRAY_SIZE(arr1);
> +	bpf_iter_num_new(&it, 0, n);
> +	fill(&it, arr1, n, 2);
> +	bpf_iter_num_destroy(&it);
> +
> +	/* fill arr2 */
> +	n = ARRAY_SIZE(arr2);
> +	bpf_iter_num_new(&it, 0, n);
> +	fill(&it, arr2, n, 10);
> +	bpf_iter_num_destroy(&it);
> +
> +	/* sum arr1 */
> +	n = ARRAY_SIZE(arr1);
> +	bpf_iter_num_new(&it, 0, n);
> +	sum1 = sum(&it, arr1, n);
> +	bpf_iter_num_destroy(&it);
> +
> +	/* sum arr2 */
> +	n = ARRAY_SIZE(arr2);
> +	bpf_iter_num_new(&it, 0, n);
> +	sum1 = sum(&it, arr2, n);
> +	bpf_iter_num_destroy(&it);
> +
> +	bpf_printk("sum1=%d, sum2=%d", sum1, sum2);

got to remove this to compile it, debug leftover?

jirka

> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";

SNIP
