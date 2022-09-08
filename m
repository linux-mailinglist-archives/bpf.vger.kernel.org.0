Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8165B115C
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 02:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiIHAgR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 20:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiIHAgA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 20:36:00 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70CA6442
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 17:35:59 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 123so6870684pfy.2
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 17:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=qS7Nr2aPRKYdHonwcp55VJpdXDzkV9ZnHgvSujOYftA=;
        b=kdp6GVSuOIKJlBhEYonpQvS2lDEFACcFy9+zS2R7AdvjyC18SYSxD8p2Izwmlb2WZ4
         1P5MN0K52mdbaJqPTMaP/Lr3yYGAG+kIoo+sKBITO+ATP0ub1hWXLjQ919Je2xQuFQF0
         R9RsDZhevRVHA/i5nN4e/YPyXkzPd69Rr/fawAroEknVXSRNCg6mxQMR+KXBs7nsUhhB
         zr9iCqQcTwx9lp30xcngC1arnVeM3W3uy+WuTI7D97NbQxfIVz6O1kBbGk0VDTET8XYU
         0zsCH1hEU8cOynYA88z7FJxvEllAUsflNsz+pH7YRwXkN2mE1ydPDXrdZK28G21iezwv
         DEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=qS7Nr2aPRKYdHonwcp55VJpdXDzkV9ZnHgvSujOYftA=;
        b=kQFd2Z2ONAg2N35F32nBInpyy30YW4g0CEClj0FHkYym4UbetU4vjoGv0oaWoHpXNZ
         Ahl769kV84MnjbbNkrh8G5N0hmFXyTc7uIrRKcytG2nxJ5HxMa6EoIwLcHVRsb7Ptg2S
         mDA3IQel9Iov4JA85TQTBB01KIwvrJdYqgU9fIbCws8EE9dGAQvrrl7rR89KoE80agI2
         rrXmDvKaFe0lZA8eDdJzPo0hGkKLEZ1BkjcCF7TA71ZAx+We0w1UFYXTB8IECe5V8Oa8
         8CuP98oxbe11WBTSihxU0xYZo64hURQS5WjXwNTW5t7qwMru++Y5Di6YBmpOPDZ2GuJi
         TdBw==
X-Gm-Message-State: ACgBeo19+sNnBqy2F39mtsEG3rTny6dqczXfeiS6VXyLNboWW5p4Gc2n
        BntVVDrgxJDTr75OQa2OwLoQlotFLj4=
X-Google-Smtp-Source: AA6agR7Uj+BkX/SJB3E0QmRaTJkEd4Z7bn/qv1vSPWOtjBmDejwJsZ8RRJAQT9yW74EYc7Yr3SVEPw==
X-Received: by 2002:a05:6a00:2353:b0:53d:d073:fc65 with SMTP id j19-20020a056a00235300b0053dd073fc65mr6390868pfj.14.1662597359345;
        Wed, 07 Sep 2022 17:35:59 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:66c4])
        by smtp.gmail.com with ESMTPSA id u1-20020a632341000000b0042a6dde1d66sm9745392pgm.43.2022.09.07.17.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 17:35:58 -0700 (PDT)
Date:   Wed, 7 Sep 2022 17:35:57 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: Re: [PATCH RFC bpf-next v1 18/32] bpf: Support bpf_spin_lock in
 local kptrs
Message-ID: <20220908003557.uqiiwfjmjoq2sp3j@macbook-pro-4.dhcp.thefacebook.com>
References: <20220904204145.3089-1-memxor@gmail.com>
 <20220904204145.3089-19-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904204145.3089-19-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 04, 2022 at 10:41:31PM +0200, Kumar Kartikeya Dwivedi wrote:
> diff --git a/include/linux/poison.h b/include/linux/poison.h
> index d62ef5a6b4e9..753e00b81acf 100644
> --- a/include/linux/poison.h
> +++ b/include/linux/poison.h
> @@ -81,4 +81,7 @@
>  /********** net/core/page_pool.c **********/
>  #define PP_SIGNATURE		(0x40 + POISON_POINTER_DELTA)
>  
> +/********** kernel/bpf/helpers.c **********/
> +#define BPF_PTR_POISON		((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
> +

That was part of Dave's patch set as well.
Please keep his SOB and authorship and keep it as separate patch.
