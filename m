Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749B84559DA
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 12:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343837AbhKRLQo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 06:16:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343635AbhKRLOm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 06:14:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637233902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wQoCpbOmLQC2qjtu8zi9d/IIbXBQfWB0jOPsEK2wrk4=;
        b=GzDNEWJ6WhrkoVGS/DOWAwwV7WOhyZWnRvX34jRGbmpMlQTUxiFdN94zcuGPbhMJzavzn8
        4uKcXwwwRok/CtU6oPgEBqyVX0z8h1NCLd5RLBD38CmJq2PbZYg5dicdk2p6l5WIG0Gzr5
        K8Ngbt33i56PmsUY5GhhsqkZ+yPHX3g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-269-X1UIXhm1N2ONL6s2N5e4Vw-1; Thu, 18 Nov 2021 06:11:39 -0500
X-MC-Unique: X1UIXhm1N2ONL6s2N5e4Vw-1
Received: by mail-ed1-f69.google.com with SMTP id t9-20020aa7d709000000b003e83403a5cbso2994871edq.19
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 03:11:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=wQoCpbOmLQC2qjtu8zi9d/IIbXBQfWB0jOPsEK2wrk4=;
        b=RSloFVIATQBptx3FL7nT1IEdNOi3ziaY9msvUDOPAmNkyNb2eLUoFCmkDEeCp6CvGq
         wR2N/0CudxUggy94svBJOZYhjRlf2vvGtgJs8rHk4Ih6e9/pKBfLWZvYGfngT9fN+R7e
         r+iWsjzuW1vy5WQ4MKN231aWIoYJHfFIlld4a6HIJ3s3hX1FHA3dPR+GWdDkC5Z3JVt8
         7Cby5DhHCyAeHt+LDPVTduxJL0ituUEuch7uNtyQ9i1NnpWDfNfM/mZ6yH6BvKveL6or
         6Bow/q6nVlV/yZuwYny8o2tHToBDGWuRlT7mvbyGWMYVmAKTpO7Wa2pL0I2etq5KfvxR
         EZfg==
X-Gm-Message-State: AOAM530Xg/mI9pGrTTpoNl7pQMWOjqi/T+0smrpp5xuzHXKhmkmtVwuc
        WbkbaDVDI5LLoKxYNFonEv/Y3/U5yIwj/r5R5OpKQG2Nz5pGNcEeY9jJd8So3l2pAiheVBueRRN
        nsgsXgPuX6FdJ
X-Received: by 2002:a05:6402:27d3:: with SMTP id c19mr10267367ede.390.1637233898246;
        Thu, 18 Nov 2021 03:11:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymyxCj2gBqeCCONyztNo/LTqBJ4cHCsbXDkqcBUCBXCUfVVKPCk79ecu2HJCdBOff1s1C5fQ==
X-Received: by 2002:a05:6402:27d3:: with SMTP id c19mr10267321ede.390.1637233897929;
        Thu, 18 Nov 2021 03:11:37 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id jx10sm1129464ejc.102.2021.11.18.03.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:11:37 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 80620180270; Thu, 18 Nov 2021 12:11:36 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Joanne Koong <joannekoong@fb.com>, bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, Kernel-team@fb.com, Joanne Koong <joannekoong@fb.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Add bpf_for_each helper
In-Reply-To: <20211118010404.2415864-2-joannekoong@fb.com>
References: <20211118010404.2415864-1-joannekoong@fb.com>
 <20211118010404.2415864-2-joannekoong@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 18 Nov 2021 12:11:36 +0100
Message-ID: <87wnl5en13.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joanne Koong <joannekoong@fb.com> writes:

> This patch adds the kernel-side and API changes for a new helper
> function, bpf_for_each:
>
> long bpf_for_each(u32 nr_interations, void *callback_fn,
> void *callback_ctx, u64 flags);
>
> bpf_for_each invokes the "callback_fn" nr_iterations number of times
> or until the callback_fn returns 1.
>
> A few things to please note:
> ~ The "u64 flags" parameter is currently unused but is included in
> case a future use case for it arises.
> ~ In the kernel-side implementation of bpf_for_each (kernel/bpf/bpf_iter.=
c),
> bpf_callback_t is used as the callback function cast.
> ~ A program can have nested bpf_for_each calls but the program must
> still adhere to the verifier constraint of its stack depth (the stack dep=
th
> cannot exceed MAX_BPF_STACK))
> ~ The next patch will include the tests and benchmark
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>

Great to see this! One small nit, below, but otherwise:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


> ---
>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       | 23 +++++++++++++++++++++++
>  kernel/bpf/bpf_iter.c          | 32 ++++++++++++++++++++++++++++++++
>  kernel/bpf/helpers.c           |  2 ++
>  kernel/bpf/verifier.c          | 28 ++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 23 +++++++++++++++++++++++
>  6 files changed, 109 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 6deebf8bf78f..d9b69a896c91 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2107,6 +2107,7 @@ extern const struct bpf_func_proto bpf_get_socket_p=
tr_cookie_proto;
>  extern const struct bpf_func_proto bpf_task_storage_get_proto;
>  extern const struct bpf_func_proto bpf_task_storage_delete_proto;
>  extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
> +extern const struct bpf_func_proto bpf_for_each_proto;
>  extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
>  extern const struct bpf_func_proto bpf_sk_setsockopt_proto;
>  extern const struct bpf_func_proto bpf_sk_getsockopt_proto;
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index bd0c9f0487f6..ea5098920ed2 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4750,6 +4750,28 @@ union bpf_attr {
>   *		The number of traversed map elements for success, **-EINVAL** for
>   *		invalid **flags**.
>   *
> + * long bpf_for_each(u32 nr_iterations, void *callback_fn, void *callbac=
k_ctx, u64 flags)
> + *	Description
> + *		For **nr_iterations**, call **callback_fn** function with
> + *		**callback_ctx** as the context parameter.
> + *		The **callback_fn** should be a static function and
> + *		the **callback_ctx** should be a pointer to the stack.
> + *		The **flags** is used to control certain aspects of the helper.
> + *		Currently, the **flags** must be 0.
> + *
> + *		long (\*callback_fn)(u32 index, void \*ctx);
> + *
> + *		where **index** is the current index in the iteration. The index
> + *		is zero-indexed.
> + *
> + *		If **callback_fn** returns 0, the helper will continue to the next
> + *		iteration. If return value is 1, the helper will skip the rest of
> + *		the iterations and return. Other return values are not used now.

The code will actually return for any non-zero value, though? So
shouldn't the documentation reflect this? Or, alternatively, should the
verifier enforce that the function can only return 0 or 1?

