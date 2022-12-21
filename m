Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910C06536D6
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 20:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbiLUTMO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 14:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbiLUTMN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 14:12:13 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B7324F35
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 11:12:12 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id k18-20020a170902c41200b001896d523dc8so11847359plk.19
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 11:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IdWNyhuQ7xmni9ae5mp7X5i0jkYWEYVODzjI4c27ZeA=;
        b=hW9BLIdcC3cxo/UPvXN1p8TUshtgsaWZ3P38lWMjyiLfvJkQ08dkV1kVzNkXCYdjYU
         9FJ4akDulEuh+5c77+QdgaZMLVWitMXHb/4i+GYL6EDERpNklZ1ReGHZn8e2Ty/tSsAQ
         bnvQPyQnWGKvMJuVMNe8OWw6cBI60B1yJ34o1A9+zlCBDwzWLSyM9peiCWmaXVoo23Ll
         bcZwmcpg6YcmoEhKPZ8N5GHHO+TpHRql5LskCG+lZfEZMLF39+HdXt/0vBUe0EhMBFMN
         PEyn58fSjN+6oDbW54ipF4SWh0cC+650695jXXiZIhOvp9BqL2Gb3FZunN2HI6QDEPED
         p6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IdWNyhuQ7xmni9ae5mp7X5i0jkYWEYVODzjI4c27ZeA=;
        b=qOi71Hgm+4jdOFai3Pmlf7n9n67OvCD1S9t4yoDLFbvkMVgSJgaMMguigIz4w28PtH
         vW0S4YRguCZJbwZT0jiCwc9d3LiLOZ+3pM7dLDxrC0fzrKb/Cwx2niRbv2+p79jncZVT
         w+F9nNYkiQNR3GrwlVjY5bz/+LHfhyoT9tUIyzNteLqt+Xsof9wQoD/UQVHdC012g6Cc
         uEOYaTvwvs08PPe/ZGDpUkRGMT0RGLZ7G2zSdjzRoBmwOfjX+H9kedu707IYBjNEpGqE
         J+Dlofw1lZxtGDa9qSP/3wjhmukcSHRMKKaxcVA314kk8kCFPVKAEBbpwtASOnpdXdOW
         7kEA==
X-Gm-Message-State: AFqh2koTxsgkgnW6O3twdOEjKm8wP7fZOy7rmj5bv1l1oD2+/iH7yGXm
        8qtqT/K5NgbdsX0u3bcrIEq3z+o=
X-Google-Smtp-Source: AMrXdXvoT5/KB3MHppckfPipUSeejIIjiAJvoLXNGSTnHH5Lj7JlCejql7IioAR7yzGjlmqcZpHUFQA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:1111:b0:219:cc70:4722 with SMTP id
 gi17-20020a17090b111100b00219cc704722mr276147pjb.206.1671649932106; Wed, 21
 Dec 2022 11:12:12 -0800 (PST)
Date:   Wed, 21 Dec 2022 11:12:10 -0800
In-Reply-To: <20221221180049.853365-1-andrii@kernel.org>
Mime-Version: 1.0
References: <20221221180049.853365-1-andrii@kernel.org>
Message-ID: <Y6NaisLF0WoSbTgo@google.com>
Subject: Re: [PATCH bpf-next] libbpf: start v1.2 development cycle
From:   sdf@google.com
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/21, Andrii Nakryiko wrote:
> Bump current version for new development cycle to v1.2.

> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>   tools/lib/bpf/libbpf.map       | 3 +++
>   tools/lib/bpf/libbpf_version.h | 2 +-
>   2 files changed, 4 insertions(+), 1 deletion(-)

> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 71bf5691a689..11c36a3c1a9f 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -382,3 +382,6 @@ LIBBPF_1.1.0 {
>   		user_ring_buffer__reserve_blocking;
>   		user_ring_buffer__submit;
>   } LIBBPF_1.0.0;
> +
> +LIBBPF_1.2.0 {
> +} LIBBPF_1.1.0;
> diff --git a/tools/lib/bpf/libbpf_version.h  
> b/tools/lib/bpf/libbpf_version.h
> index e944f5bce728..1fd2eeac5cfc 100644
> --- a/tools/lib/bpf/libbpf_version.h
> +++ b/tools/lib/bpf/libbpf_version.h
> @@ -4,6 +4,6 @@
>   #define __LIBBPF_VERSION_H

>   #define LIBBPF_MAJOR_VERSION 1
> -#define LIBBPF_MINOR_VERSION 1
> +#define LIBBPF_MINOR_VERSION 2

>   #endif /* __LIBBPF_VERSION_H */
> --
> 2.30.2

