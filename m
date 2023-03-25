Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6DD6C8A95
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 04:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjCYDJ5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 23:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCYDJ4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 23:09:56 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFB51285F
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 20:09:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5419fb7d6c7so35636627b3.11
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 20:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679713794;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ie3SRm2stlT5gVULGGPaFZxV6q0LgXNfQPMhRVWJWQ0=;
        b=rSnLqsCxWNRnjPetQarTFmIEqWuQC+4+kxzt3mKXIW/LhDKauijg9DIj+kXmtziM2+
         xG23BnH2e/TmTwUqW8ZWch2lb10m6gEiII34RoWoirCBrHROHU3VxC3vd/54nnP5dFmG
         U4i+OWxMOQlo0ps/xrBglVvsZSN2CDXK+NSO0O9xFAAumc/ksRenK2PgAsLE5Y7GbxhK
         GoMJgpK/anlUmjS9mPN6KxDwSjtw8Y0CT5GpfmzMI8pATCRfaYmMK1gq+OtEcwNq7R5b
         pgF/OXDgDyf5eSHHMl3P+2a2akeweib5E4qlwVeP43myIcHfz+B7vsSvQJpnO2eaVa7V
         SK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679713794;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ie3SRm2stlT5gVULGGPaFZxV6q0LgXNfQPMhRVWJWQ0=;
        b=UGCVjQ9Yi9UDfxw6ujjijmZg6CrTA2gfql3nesjlm5vjeD/rz/OmEDfIgDAmcFRx04
         86w6mi0644ig/cSAL4v0DwirWI9PjWufSs+4Gt6U9ti9b3pQTo6bfp0h9NxC3AqmfOsT
         211VTNZrehnsKt2mWQ191zRBQJzEp4/EiB719XWsAp04PxsAVL20037sLe6z7Ch9S5aa
         aNJc9wQSXzr/UuXonnDbCGoHX8IzwwcUTRVIBBpjrnIGjHzWGw5tlykxNLiYzmNKO0PE
         3uZ5bNal0uba0ItIIgDJ7UWbsr3ww7NNlEw1xVKyZ3//vQKhF0d9sOy5LWgVGuV6jTXC
         Fb4A==
X-Gm-Message-State: AAQBX9eXO2fHQzGpP79UMt6swHbA5CCf0mSuxHNdU7oNnHt4rLRVLJy7
        DRlX4NAklkwBgZsSqqVh4N/Aa94=
X-Google-Smtp-Source: AKy350boHO9215MkROgu2mN5k9H14cfOPAgRYyIvah7ptUoTmwqxfJCixdFAhjUgB7SxHEMguKIdBqA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:1004:b0:b75:968e:f282 with SMTP id
 w4-20020a056902100400b00b75968ef282mr2734898ybt.11.1679713794535; Fri, 24 Mar
 2023 20:09:54 -0700 (PDT)
Date:   Fri, 24 Mar 2023 20:09:53 -0700
In-Reply-To: <20230325010845.46000-1-inwardvessel@gmail.com>
Mime-Version: 1.0
References: <20230325010845.46000-1-inwardvessel@gmail.com>
Message-ID: <ZB5mAffV69GUEIZU@google.com>
Subject: Re: [PATCH bpf-next] libbpf: synchronize access to print function pointer
From:   Stanislav Fomichev <sdf@google.com>
To:     JP Kobryn <inwardvessel@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/24, JP Kobryn wrote:
> This patch prevents races on the print function pointer, allowing the
> libbpf_set_print() function to become thread safe.

Why does it have to be thread-safe? The rest of the APIs aren't, so
why can't use solve it on your side by wrapping those calls with a
mutex?

(is there some context I'm missing?)

> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>   tools/lib/bpf/libbpf.c | 9 ++++++---
>   tools/lib/bpf/libbpf.h | 3 +++
>   2 files changed, 9 insertions(+), 3 deletions(-)

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index f6a071db5c6e..15737d7b5a28 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -216,9 +216,10 @@ static libbpf_print_fn_t __libbpf_pr = __base_pr;

>   libbpf_print_fn_t libbpf_set_print(libbpf_print_fn_t fn)
>   {
> -	libbpf_print_fn_t old_print_fn = __libbpf_pr;
> +	libbpf_print_fn_t old_print_fn;
> +
> +	old_print_fn = __atomic_exchange_n(&__libbpf_pr, fn, __ATOMIC_RELAXED);

> -	__libbpf_pr = fn;
>   	return old_print_fn;
>   }

> @@ -227,8 +228,10 @@ void libbpf_print(enum libbpf_print_level level,  
> const char *format, ...)
>   {
>   	va_list args;
>   	int old_errno;
> +	libbpf_print_fn_t print_fn;

> -	if (!__libbpf_pr)
> +	print_fn = __atomic_load_n(&__libbpf_pr, __ATOMIC_RELAXED);
> +	if (!print_fn)
>   		return;

>   	old_errno = errno;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 1615e55e2e79..4478809ff9ca 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -99,6 +99,9 @@ typedef int (*libbpf_print_fn_t)(enum  
> libbpf_print_level level,
>   /**
>    * @brief **libbpf_set_print()** sets user-provided log callback  
> function to
>    * be used for libbpf warnings and informational messages.
> + *
> + * This function is thread safe.
> + *
>    * @param fn The log print function. If NULL, libbpf won't print  
> anything.
>    * @return Pointer to old print function.
>    */
> --
> 2.39.2

