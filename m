Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9041D4F021B
	for <lists+bpf@lfdr.de>; Sat,  2 Apr 2022 15:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355512AbiDBNhW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 2 Apr 2022 09:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355519AbiDBNhV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Apr 2022 09:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C507817E30
        for <bpf@vger.kernel.org>; Sat,  2 Apr 2022 06:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648906528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XkGGLTJPIcXO7KUUGx3jYnOh/Zt0JmIQ5r08GU8D1qI=;
        b=H4j45ifZmmV15YEmcfF91VYDSQHbuCz0VnnZwasHCRMfNZGqckbrlcRYtU54DrsktH6m1U
        vdG/TzhcXCH3g8SYdxLzCKHjqsDG0DAjfEV48DhqlH+N5SHPwCfqJvPFO/hFSqf1ZEaJxi
        SZ9bUXvYIE2gJH8ohgh7fcKqNcWtmig=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-t0hmeEL-OVWc3PBzgpxjyQ-1; Sat, 02 Apr 2022 09:35:27 -0400
X-MC-Unique: t0hmeEL-OVWc3PBzgpxjyQ-1
Received: by mail-ed1-f71.google.com with SMTP id o20-20020aa7dd54000000b00413bc19ad08so2942251edw.7
        for <bpf@vger.kernel.org>; Sat, 02 Apr 2022 06:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=XkGGLTJPIcXO7KUUGx3jYnOh/Zt0JmIQ5r08GU8D1qI=;
        b=0Hj6Qu48/h3in343iujqXFvnhlIGhLXjkHpJYXeENl1gGjEXtiM2zcrtGDgZU4mRMO
         wWsGHYdUPaxOCRKt8WD0m9lSAHYSf9NsT9k4FUdjjdnwKyVck1S9LpHAF7b48QxE6O+z
         6Yho3USzLXhbAwuypVZ8OyZT4QMpfQ+/iHiD1jUc7WpYqjoIJbjrIi+xIjVtNe91aD5D
         nvmVqOWV06cwGSvGtwlFDDBYRBVnm98ndtFRkwAWyMXH9Yjp4qXTDrRT7Y/hibuO1vSc
         mvAXfdOR4ZHhNfZ648Y81N6x2lftI/LppMgSn7WtpIwrowlJ1ijGcT2+xpMdq+fzVcuX
         xr+Q==
X-Gm-Message-State: AOAM53310We7TVfvP5F9xXHPSup+ymWggOl/x1Lq2FxThOkFEJjp++B2
        ATaLUzkZjQ144fGUufO8v51Wu4O3z9KKfP4DK+2zuAYlifjZcvW7U3T2IiIlbq8ZVHL3qiw9RiI
        2tT5Pb71Z4SGy
X-Received: by 2002:a17:906:58d3:b0:6da:bdb2:2727 with SMTP id e19-20020a17090658d300b006dabdb22727mr3822264ejs.549.1648906525843;
        Sat, 02 Apr 2022 06:35:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgxGnbENLbFfnzYO0F/wVLZX9AgBY1loRejYqGH5aMVyl7SIoCEX+jBiAv40nY+zqpkqsKYw==
X-Received: by 2002:a17:906:58d3:b0:6da:bdb2:2727 with SMTP id e19-20020a17090658d300b006dabdb22727mr3822248ejs.549.1648906525457;
        Sat, 02 Apr 2022 06:35:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id dm8-20020a170907948800b006dfe5b317d3sm2097438ejc.75.2022.04.02.06.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 06:35:24 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1784A258B18; Sat,  2 Apr 2022 15:35:24 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Joanne Koong <joannekoong@fb.com>, bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v1 4/7] bpf: Add bpf_dynptr_read and
 bpf_dynptr_write
In-Reply-To: <20220402015826.3941317-5-joannekoong@fb.com>
References: <20220402015826.3941317-1-joannekoong@fb.com>
 <20220402015826.3941317-5-joannekoong@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 02 Apr 2022 15:35:24 +0200
Message-ID: <87ilrrfw0z.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joanne Koong <joannekoong@fb.com> writes:

> From: Joanne Koong <joannelkoong@gmail.com>
>
> This patch adds two helper functions, bpf_dynptr_read and
> bpf_dynptr_write:
>
> long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 offset);
>
> long bpf_dynptr_write(struct bpf_dynptr *dst, u32 offset, void *src, u32 len);
>
> The dynptr passed into these functions must be valid dynptrs that have
> been initialized.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/bpf.h            |  6 ++++
>  include/uapi/linux/bpf.h       | 18 +++++++++++
>  kernel/bpf/helpers.c           | 56 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 18 +++++++++++
>  4 files changed, 98 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index e0fcff9f2aee..cded9753fb7f 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2426,6 +2426,12 @@ enum bpf_dynptr_type {
>  #define DYNPTR_MAX_SIZE	((1UL << 28) - 1)
>  #define DYNPTR_SIZE_MASK	0xFFFFFFF
>  #define DYNPTR_TYPE_SHIFT	29
> +#define DYNPTR_RDONLY_BIT	BIT(28)
> +
> +static inline bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
> +{
> +	return ptr->size & DYNPTR_RDONLY_BIT;
> +}
>  
>  static inline enum bpf_dynptr_type bpf_dynptr_get_type(struct bpf_dynptr_kern *ptr)
>  {
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 6a57d8a1b882..16a35e46be90 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5175,6 +5175,22 @@ union bpf_attr {
>   *		After this operation, *ptr* will be an invalidated dynptr.
>   *	Return
>   *		Void.
> + *
> + * long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 offset)
> + *	Description
> + *		Read *len* bytes from *src* into *dst*, starting from *offset*
> + *		into *dst*.

nit: this should be "starting from *offset* into *src*, no? (same below)

-Toke

