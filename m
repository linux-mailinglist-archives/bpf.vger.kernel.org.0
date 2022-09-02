Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380325AA939
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 09:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbiIBH5H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 03:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbiIBH5C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 03:57:02 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A244BA17F
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 00:56:46 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y3so2279976ejc.1
        for <bpf@vger.kernel.org>; Fri, 02 Sep 2022 00:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=VtdMeaj+iwWz/QJBcbHznA0xsmO663UXPTTFJYGR/sE=;
        b=I6BqFTHJ4pUp6U0rdH9R4f6asgO1vjLfdONNdLwjGo25o+0n2iEwgJLF80vsYBBwyt
         DMtekXYWzOTtoyOPOxCrNiccDkzmhbIxhsMlrNDVbwaUibFpzl68RP5Zilf6pjkfjOjU
         sS62S1kquh+5U2ff+Ab6bZbhwZE2Xg7cImWk9Qb+1In74XVX/tP0OOk6niUf5QEKiuko
         vD2WTzCWg+1myOL8Ss+LDM10eDoqtYVYG5ff2ucFDfTanR/qKtxO9S3MtiGfZoNEslz5
         APPDHbaK3t/HYtA8HCYPGnlotyQ8UT0zfskvuuyVICJ3HDEaLPDrvdi1NtMMhfn4+z5c
         qEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=VtdMeaj+iwWz/QJBcbHznA0xsmO663UXPTTFJYGR/sE=;
        b=RjF9Z2jOLnbD/Qq2aD6GXcE+E8LMaGZUhRdNRQd3Bng6fpHN/XlxsSvqJQKf8Cs7lu
         lGa3p605+hBXiY9cBS0n8akSefNGZUOpLEAnmLsgkKYql+eqA4h0W5MZ4AasBaldwMPZ
         3X1hnzffh30uQUmHsMmRL8LdCf/JsWQgAy6HsPj9LxOK6xG7U2HJehed5dUxjTBXKHl3
         +W767kWDQp7dD8PnFGxNZAZGpDbUqJ2ltq3K1LTcR5XA61tsz3WeX6LPvoVU35MytK78
         GmcRT1Lb7zLUJ3EmfteI5NBZ00PnUDjNiYcu2m+oHCf+VBe0Q8EWDCEULbJvbZH8sWTs
         gIfg==
X-Gm-Message-State: ACgBeo22ab4m4P4su5TB0T/ZDoMr9SB92JCMqAw6X6ysKa5/kttYssfc
        oiQux5NoQc95VRHFhsyMlpk=
X-Google-Smtp-Source: AA6agR50beTiMlI/DQkk2KwOUYmmk1TUb+ua/De4F8ragNW7DiMYN8P2KKv4FY6Oi3hPMH7jZzvNEA==
X-Received: by 2002:a17:907:8a0a:b0:730:a118:75de with SMTP id sc10-20020a1709078a0a00b00730a11875demr27986367ejc.189.1662105404317;
        Fri, 02 Sep 2022 00:56:44 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id u3-20020aa7d883000000b004482dd03fe8sm869468edq.91.2022.09.02.00.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 00:56:43 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 2 Sep 2022 09:56:41 +0200
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v4 3/8] bpf: Update descriptions for helpers
 bpf_get_func_arg[_cnt]()
Message-ID: <YxG3OVk72IaSEJd6@krava>
References: <20220831152641.2077476-1-yhs@fb.com>
 <20220831152657.2078805-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831152657.2078805-1-yhs@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 31, 2022 at 08:26:57AM -0700, Yonghong Song wrote:
> Now instead of the number of arguments, the number of registers
> holding argument values are stored in trampoline. Update
> the description of bpf_get_func_arg[_cnt]() helpers. Previous
> programs without struct arguments should continue to work
> as usual.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/uapi/linux/bpf.h       | 9 +++++----
>  tools/include/uapi/linux/bpf.h | 9 +++++----
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 962960a98835..f9f43343ef93 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5079,12 +5079,12 @@ union bpf_attr {
>   *
>   * long bpf_get_func_arg(void *ctx, u32 n, u64 *value)
>   *	Description
> - *		Get **n**-th argument (zero based) of the traced function (for tracing programs)
> + *		Get **n**-th argument register (zero based) of the traced function (for tracing programs)

I'm bit worried about the confusion between args/regs we create with
this, but I don't any have better idea how to solve this

keeping extra stack values for nr_args and nr_regs and have new helpers
to get reg values.. but then bpf_get_func_arg still does not return the
full argument value.. also given that the struct args should be rare,
I guess it's fine ;-)

jirka

>   *		returned in **value**.
>   *
>   *	Return
>   *		0 on success.
> - *		**-EINVAL** if n >= arguments count of traced function.
> + *		**-EINVAL** if n >= argument register count of traced function.
>   *
>   * long bpf_get_func_ret(void *ctx, u64 *value)
>   *	Description
> @@ -5097,10 +5097,11 @@ union bpf_attr {
>   *
>   * long bpf_get_func_arg_cnt(void *ctx)
>   *	Description
> - *		Get number of arguments of the traced function (for tracing programs).
> + *		Get number of registers of the traced function (for tracing programs) where
> + *		function arguments are stored in these registers.
>   *
>   *	Return
> - *		The number of arguments of the traced function.
> + *		The number of argument registers of the traced function.
>   *
>   * int bpf_get_retval(void)
>   *	Description
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index f4ba82a1eace..f13fa71822f4 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -5079,12 +5079,12 @@ union bpf_attr {
>   *
>   * long bpf_get_func_arg(void *ctx, u32 n, u64 *value)
>   *	Description
> - *		Get **n**-th argument (zero based) of the traced function (for tracing programs)
> + *		Get **n**-th argument register (zero based) of the traced function (for tracing programs)
>   *		returned in **value**.
>   *
>   *	Return
>   *		0 on success.
> - *		**-EINVAL** if n >= arguments count of traced function.
> + *		**-EINVAL** if n >= argument register count of traced function.
>   *
>   * long bpf_get_func_ret(void *ctx, u64 *value)
>   *	Description
> @@ -5097,10 +5097,11 @@ union bpf_attr {
>   *
>   * long bpf_get_func_arg_cnt(void *ctx)
>   *	Description
> - *		Get number of arguments of the traced function (for tracing programs).
> + *		Get number of registers of the traced function (for tracing programs) where
> + *		function arguments are stored in these registers.
>   *
>   *	Return
> - *		The number of arguments of the traced function.
> + *		The number of argument registers of the traced function.
>   *
>   * int bpf_get_retval(void)
>   *	Description
> -- 
> 2.30.2
> 
