Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99146AE4AF
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 16:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCGP3C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 10:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjCGP27 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 10:28:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0033C7EE6
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 07:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678202833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d7tFpiKXqynWtvnyoZW3Uouf3NrvbrWsNMhlga+8JZ4=;
        b=QzR9SSIMLL8kSpYwF/TnYOVQWTg+GArjpMSBlDGtLMYeR6mqMA6fFvIaAJFx6XNgxTzwiK
        PZXGmNUyk2tgIzFPBEL+po1Cyfjsd4QeT6CC5bPfgLlJS34h2kpn0WN/3Em4m/TFSZy55t
        +z6J4b6ZJDRLox8UC1PAz2eLHK02xk8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-qaMVuW3lNoCCPPa-RxrDwg-1; Tue, 07 Mar 2023 10:27:11 -0500
X-MC-Unique: qaMVuW3lNoCCPPa-RxrDwg-1
Received: by mail-qt1-f197.google.com with SMTP id x4-20020ac85384000000b003bfbb485e2dso7304004qtp.22
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 07:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678202824;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d7tFpiKXqynWtvnyoZW3Uouf3NrvbrWsNMhlga+8JZ4=;
        b=e7hqJ9U9AVXQ7sFse4e4hhKyawAGxLowQ2Ge34L6GPwT7ldacMaWvtMu4RllZBrA3S
         APk+/xqAlkLxnRAq11iyyKALiroHjZE3XSicUke55elgJH9QWZiF45/gOrOa949ptN4G
         9slw1ap5AvythkeImGE3Uwm6Un640mowCCVEYHtmggxYcHKfaVvitisTg6VAzXj4jOal
         CKPO61BM0Azn+Hrshgzt07XGWKAA1+9lr42u8d3BNQ+XruCVm/P62w0U52YzgDdoKc2i
         dFbwEAuzR+lEZtL0rgSzBEEjA+5AhkR2r0ObWttxgnVaiRWt6HGc0Pw2d1Tti9mhi+54
         M7Pw==
X-Gm-Message-State: AO0yUKXB1hzXfJsYverC1gJsPZ1joYeEhdCu5rd7UqRwEpXoddtg6tW2
        D1OGeREE7fQHcL9FVVqOmHF9Wp7wv5qdqKdyktY/q2nQWhPMtbJuzZGwD5KcRnbrSl9h3wmN8C6
        EeghuXKwCDqhBgt+VaAVd
X-Received: by 2002:a05:622a:134b:b0:3b6:3260:fa1d with SMTP id w11-20020a05622a134b00b003b63260fa1dmr24994770qtk.45.1678202824722;
        Tue, 07 Mar 2023 07:27:04 -0800 (PST)
X-Google-Smtp-Source: AK7set9E77kRVz6L/w5+ZV6JnWce7W5sJvJS0bvPmMpm2NcunH+obLSA1UxzvjjWrf8oYrOuYT2pSA==
X-Received: by 2002:a05:622a:134b:b0:3b6:3260:fa1d with SMTP id w11-20020a05622a134b00b003b63260fa1dmr24994738qtk.45.1678202824456;
        Tue, 07 Mar 2023 07:27:04 -0800 (PST)
Received: from [192.168.1.19] (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id v25-20020ac87499000000b003bfc0cca1b7sm9718293qtq.49.2023.03.07.07.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 07:27:03 -0800 (PST)
Subject: Re: [PATCH bpf-next] bpf: Increase size of BTF_ID_LIST without
 CONFIG_DEBUG_INFO_BTF again
To:     Nathan Chancellor <nathan@kernel.org>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, ndesaulniers@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
References: <20230307-bpf-kfuncs-warray-bounds-v1-1-00ad3191f3a6@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <58eb6412-9d32-1175-94fa-af620ab80f4e@redhat.com>
Date:   Tue, 7 Mar 2023 07:26:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230307-bpf-kfuncs-warray-bounds-v1-1-00ad3191f3a6@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 3/7/23 7:14 AM, Nathan Chancellor wrote:
> After commit 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and
> bpf_dynptr_slice_rdwr"), clang builds without CONFIG_DEBUG_INFO_BTF
> warn:
>
>    kernel/bpf/verifier.c:10298:24: warning: array index 16 is past the end of the array (that has type 'u32[16]' (aka 'unsigned int[16]')) [-Warray-bounds]
>                                       meta.func_id == special_kfunc_list[KF_bpf_dynptr_slice_rdwr]) {
>                                                       ^                  ~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/bpf/verifier.c:9150:1: note: array 'special_kfunc_list' declared here
>    BTF_ID_LIST(special_kfunc_list)
>    ^
>    include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_LIST'
>    #define BTF_ID_LIST(name) static u32 __maybe_unused name[16];
>                              ^
>    1 warning generated.
>
> A warning of this nature was previously addressed by
> commit beb3d47d1d3d ("bpf: Fix a BTF_ID_LIST bug with
> CONFIG_DEBUG_INFO_BTF not set") but there have been new kfuncs added
> since then.
>
> Quadruple the size of the CONFIG_DEBUG_INFO_BTF=n definition so that
> this problem is unlikely to show up for some time.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1810
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

This has a better commit message, let's use this one.

FWIW, gcc 13 -Warray-bounds, did not catch this.

Reviewed-by: Tom Rix <trix@redhat.com>

> ---
>   include/linux/btf_ids.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index 3a4f7cd882ca..00950cc03bff 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -204,7 +204,7 @@ extern struct btf_id_set8 name;
>   
>   #else
>   
> -#define BTF_ID_LIST(name) static u32 __maybe_unused name[16];
> +#define BTF_ID_LIST(name) static u32 __maybe_unused name[64];
>   #define BTF_ID(prefix, name)
>   #define BTF_ID_FLAGS(prefix, name, ...)
>   #define BTF_ID_UNUSED
>
> ---
> base-commit: 36e5e391a25af28dc1f4586f95d577b38ff4ed72
> change-id: 20230307-bpf-kfuncs-warray-bounds-c2040e8ee7ee
>
> Best regards,

