Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2F448C3D3
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 13:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353100AbiALMQB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 07:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238443AbiALMP4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 07:15:56 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B6CC06173F
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 04:15:56 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d19so3968936wrb.0
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 04:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=c4f4pDYXfFWREBJBRTNM/W2HATBzJ8RVOK3jt20fjgo=;
        b=g8xQ13zdyz4q3Sp+AJham8sbwe6VKLijJWnS5GVQrqd8oyA3vPvL3p/+1+FPE07crX
         x09oSXs/G/50tltlF2qk5xqeo4eh3/VpJz1DFeS4Is/Oi+XNO4QGl7dJ+DgKgjjR5lA4
         ab1SV/Kf3RO2XMyzyFOZC5cVSkLE6LHhI7NsEC17dDKGvpbwdd29JKhw8VqwczW9L8JK
         UAEYxmCESm2V3rQAxXIINMI5g5BFphpYu3JWnu57nBPyRn/iqcHSNR2dYEBJ3ZiN6JIL
         jOWrKnowiiIXQs/qIHuZxjPntSi4yLcREP9jqap+aFZQM+cNGpQvmCbD4KL5uUA7ueFV
         V+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c4f4pDYXfFWREBJBRTNM/W2HATBzJ8RVOK3jt20fjgo=;
        b=48JJDd3ZlppT7lByss/Rfd1W9vxphxiUxgjkC1OtQOb7aXJiUv5Ka8MOwEhQd8CcZT
         tSgmRKlBTzXlrHEZG1YYPSDMxOoE+Y+vl8MUhscMmPP0JP9FVU1HKYZC5zfLgXWKS1LF
         DImEYJdLaKqa1jCPslfXp/vsWmmxSwLXPdlKFFvvI89ShLTeH4sejkJRNrdJwMGcLOfW
         d0+iuyjYyB4Stl5ZHkXYjnALiWCZDuP76eNoKG3Zp8d/xbPw4+EeTbc1SaUeJYb8TUA+
         Oy/FoNsZkCXUMm9k9gp1bfNElrmMVN4SOKn0O2CtIIguiRSXydunQCWtSxTYH5c3w6HX
         DJow==
X-Gm-Message-State: AOAM5301Oa2J012bgiegKVhiMsP2gxR9y5BMwlr/S8EqumteI0pLYo63
        JrVrcYDYImx33tHIRmyHvYFieA==
X-Google-Smtp-Source: ABdhPJxJ3wN3F+l0IWenVagr9jeuJSHfQHEUceg+lvZFjFouykC7Y0AlsWRmkrgvPOGk2PayhGW9ig==
X-Received: by 2002:a5d:4e44:: with SMTP id r4mr7910749wrt.593.1641989754663;
        Wed, 12 Jan 2022 04:15:54 -0800 (PST)
Received: from [192.168.1.8] ([149.86.64.198])
        by smtp.gmail.com with ESMTPSA id w17sm5062077wmc.14.2022.01.12.04.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 04:15:54 -0800 (PST)
Message-ID: <6586be41-1ceb-c9d3-f9ea-567f51dbab49@isovalent.com>
Date:   Wed, 12 Jan 2022 12:15:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v6] bpf/scripts: raise an exception if the correct number
 of helpers are not generated
Content-Language: en-GB
To:     Usama Arif <usama.arif@bytedance.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, joe@cilium.io,
        fam.zheng@bytedance.com, cong.wang@bytedance.com,
        alexei.starovoitov@gmail.com, song@kernel.org
References: <20220112114953.722380-1-usama.arif@bytedance.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220112114953.722380-1-usama.arif@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-01-12 11:49 UTC+0000 ~ Usama Arif <usama.arif@bytedance.com>
> Currently bpf_helper_defs.h and the bpf helpers man page are auto-generated
> using function documentation present in bpf.h. If the documentation for the
> helper is missing or doesn't follow a specific format for e.g. if a function
> is documented as:
>  * long bpf_kallsyms_lookup_name( const char *name, int name_sz, int flags, u64 *res )
> instead of
>  * long bpf_kallsyms_lookup_name(const char *name, int name_sz, int flags, u64 *res)
> (notice the extra space at the start and end of function arguments)
> then that helper is not dumped in the auto-generated header and results in
> an invalid call during eBPF runtime, even if all the code specific to the
> helper is correct.
> 
> This patch checks the number of functions documented within the header file
> with those present as part of #define __BPF_FUNC_MAPPER and raises an
> Exception if they don't match. It is not needed with the currently documented
> upstream functions, but can help in debugging when developing new helpers
> when there might be missing or misformatted documentation.
> 
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Looks cleaner with the check in a dedicated function. Thanks a lot!

> ---
>  scripts/bpf_doc.py | 50 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index a6403ddf5de7..76c96df095e3 100755
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py

> @@ -295,6 +320,25 @@ class PrinterRST(Printer):
>  
>          print('')
>  
> +def helper_number_check(desc_unique_helpers, define_unique_helpers):
> +    """
> +    Checks the number of functions documented within the header file
> +    with those present as part of #define __BPF_FUNC_MAPPER and raise an
> +    Exception if they don't match.
> +    """
> +    nr_desc_unique_helpers = len(desc_unique_helpers)
> +    nr_define_unique_helpers = len(define_unique_helpers)
> +    if nr_desc_unique_helpers != nr_define_unique_helpers:
> +        helper_exception = '''
> +The number of unique helpers in description (%d) don\'t match the number of unique helpers defined in __BPF_FUNC_MAPPER (%d)

Nit: don't -> doesn't
(but probably not worth a respin)
