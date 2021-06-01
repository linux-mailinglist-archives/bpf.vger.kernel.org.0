Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E04A3970BD
	for <lists+bpf@lfdr.de>; Tue,  1 Jun 2021 11:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhFAJ6h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Jun 2021 05:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhFAJ6h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Jun 2021 05:58:37 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56EAC061574
        for <bpf@vger.kernel.org>; Tue,  1 Jun 2021 02:56:55 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h3so7774632wmq.3
        for <bpf@vger.kernel.org>; Tue, 01 Jun 2021 02:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lq+IMIbz1x5UyUnhsbuQ10eUjKDO0crdmsP5x3LTuRI=;
        b=ZgewtA1AaicYsdtC1e467XpacETeXln3zv24IQDrLp7r4AzNy2zHJh8Jy+orwvJZ4y
         aBMD3dzfH/cLVn+Na/JPDMbJL4LnSSw/JMsDtUZcqxVtLiqhcnisHHJFmDAOdC+keGF2
         clXxpqzQdBLte8Ldb+tACOVECZLLLpHnkoyV09n5Qq8PnawVtcWtGsX8I9uKSt8h3QaW
         VbAmjkxGCYoexj4HSRTxOVqT5ZwaPnMcrui9k9gTa+OJcDJ/OosDc+xbXuNdSfx7zaOV
         L/ULXHcPAMavXnqXXlGsG+HsvGlZSXbC1YCq/u9n8YU1fNFoxvrQHFNTflJCqgGLeEWZ
         uIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lq+IMIbz1x5UyUnhsbuQ10eUjKDO0crdmsP5x3LTuRI=;
        b=jcmzYY3nD+8+MW3gyOk8EepTRBPG/EHl5EiOXMVRzChzoRSzHdkuxDplV7SqvfPlDC
         8XwYwUei5cg3qhtplIcDYIBopaUIU2hyPPXtcff7q8n3/1+2UWMdjNI7Yq6yVAQefcQ4
         Mkg8VqGgvK1ckfro9xdWWw3TxVlil7X7v8wF+7MvMH45JX7s6Hd4q60+TdTAnXacch9X
         AsZNBkMwDX4EruTxsCAO5b7I5XfpXBgVrLW1qFCEE2CV96i6+H+xCi/rj1Bp863U+fAz
         knmsgfD6LOUz19/fbiyuF2wujy6GhILrF9XxZDEfguX+b4X+ol739rdKcK8A+++MRwAv
         vGAw==
X-Gm-Message-State: AOAM530Y4QfUN09ZQFWJLbXA/Ylr5Dg1/mTLJMMH0pnGpIFe8H+FD/Hg
        VXXFmPhXtf4hVOsL3LSSwhg=
X-Google-Smtp-Source: ABdhPJy/Bi1oO7OGyq+isrvSOLwPCCh9Z6VzLK8BcBElOkOleEKA3Gfeyll3CqCwV6MDGYZ+WUVrrQ==
X-Received: by 2002:a1c:c912:: with SMTP id f18mr25604251wmb.62.1622541414474;
        Tue, 01 Jun 2021 02:56:54 -0700 (PDT)
Received: from [10.108.8.69] ([149.199.80.129])
        by smtp.gmail.com with ESMTPSA id c64sm2103909wma.15.2021.06.01.02.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 02:56:54 -0700 (PDT)
Subject: Re: [PATCH v2 bpf-next] bpf: tnums: Provably sound, faster, and more
 precise algorithm for tnum_mul
To:     hv90@scarletmail.rutgers.edu, ast@kernel.org
Cc:     bpf@vger.kernel.org, ecree@solarflare.com,
        Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>,
        Matan Shachnai <m.shachnai@rutgers.edu>,
        Srinivas Narayana <srinivas.narayana@rutgers.edu>,
        Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
References: <20210531020157.7386-1-harishankar.vishwanathan@rutgers.edu>
From:   Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <d87f07f1-a6c6-e3f2-a778-03fab216d453@gmail.com>
Date:   Tue, 1 Jun 2021 10:56:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210531020157.7386-1-harishankar.vishwanathan@rutgers.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 31/05/2021 03:01, hv90@scarletmail.rutgers.edu wrote:
> From: Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>
> 
> This patch introduces a new algorithm for multiplication of tristate
> numbers (tnums) that is provably sound. It is faster and more precise when
> compared to the existing method.
> 
> Like the existing method, this new algorithm follows the long
> multiplication algorithm. The idea is to generate partial products by
> multiplying each bit in the multiplier (tnum a) with the multiplicand
> (tnum b), and adding the partial products after appropriately bit-shifting
> them. The new algorithm, however, uses just a single loop over the bits of
> the multiplier (tnum a) and accumulates only the uncertain components of
> the multiplicand (tnum b) into a mask-only tnum. The following paper
> explains the algorithm in more detail: https://arxiv.org/abs/2105.05398.
> 
> A natural way to construct the tnum product is by performing a tnum
> addition on all the partial products. This algorithm presents another
> method of doing this: decompose each partial product into two tnums,
> consisting of the values and the masks separately. The mask-sum is
> accumulated within the loop in acc_m. The value-sum tnum is generated
> using a.value * b.value. The tnum constructed by tnum addition of the
> value-sum and the mask-sum contains all possible summations of concrete
> values drawn from the partial product tnums pairwise. We prove this result
> in the paper.
> 
> Our evaluations show that the new algorithm is overall more precise
> (producing tnums with less uncertain components) than the existing method.
> As an illustrative example, consider the input tnums A and B. The numbers
> in the paranthesis correspond to (value;mask).
> 
> A                = 000000x1 (1;2)
> B                = 0010011x (38;1)
> A * B (existing) = xxxxxxxx (0;255)
> A * B (new)      = 0x1xxxxx (32;95)
> 
> Importantly, we present a proof of soundness of the new algorithm in the
> aforementioned paper. Additionally, we show that this new algorithm is
> empirically faster than the existing method.
> 
> Co-developed-by: Matan Shachnai <m.shachnai@rutgers.edu>
> Signed-off-by: Matan Shachnai <m.shachnai@rutgers.edu>
> Co-developed-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
> Signed-off-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
> Co-developed-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
> Signed-off-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
> Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
