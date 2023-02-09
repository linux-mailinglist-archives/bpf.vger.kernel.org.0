Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D420B68FCA3
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 02:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjBIB3y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 20:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjBIB3y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 20:29:54 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596AA20D3F
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 17:29:53 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id gr7so2161312ejb.5
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 17:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9jk7Vr0tQojUzDcB9iHmioSmuhJsMDiBZTCzVUr+Z+4=;
        b=U7BemW3pdFHQLb+3KB2TuaU0f+gw+WMMoTmFoB9hWFRbXYWPASGR2bAbJdNkDoaMsx
         u8tyctJoYee4vmJZ4T2Hlmz2caeOme8QXQzQh2VO52hcDIOa4b89di7ZjmN2SsdYlhmC
         /rD/LWgGUEPIM9fNum+LEmv4gN+MTmj7Gnac93488hp+FpCbUt2NDnbFeMB3557XZPV8
         gqBT2cqyNhGXukepD3/u0ruMOcZeCMdFD0gWKVlbavd0A+8fPo+X9sMb2Ibpc9Euwv32
         OeTncF7kgvjp1nLd9C8X3DOGjlLUOcO004UmwaXV14WfnkD2F6FUesJWYxphM4nMlEK3
         xXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jk7Vr0tQojUzDcB9iHmioSmuhJsMDiBZTCzVUr+Z+4=;
        b=y8pG0HZPRSpxpKZyp6/U2gDSqyUWcfIABpI1oow9j5opifIfSMo9JAWhphpwkwrgoV
         eR16ZurqX2Xd3LTaVtgfNSDG5baS4psV5gaARepAyfmJhj77Xzz/i82Q1J7/P4GKEk0D
         j9S8dvfmeqoLXNEJ/BDgo16iNkT0qbI5+4l5KT6AuBeGNMwEvKfzGASiCoBIQeV2Muia
         BwyhEh8tbtaRJU3IT/6hp8+a8WgLkKGs6dbdIr9agEkagXZbJrK9ICd7p6PvFYnj8yrZ
         hG/e+7hZ+WeMUyoj0CkeRLdwVwSP3NlN+lqd8j3v59iBbGxhonkUndT7u0fBU5gROfHr
         5vng==
X-Gm-Message-State: AO0yUKWhza1F5VusrT5HYd9AIBaJJP+zZK2B5l6rSbJHqyyNkt6J42Uz
        HaAD5CrL2V3iSS8r0TMvi+kobhaKpxRi6michJTAgFM6XKk=
X-Google-Smtp-Source: AK7set8jV9IM9vR2R+KuP5KhC/I6sX8FRqf7GjeK6Wxg38p/NPBYVo2EbgEXhpGKeujtszWLcme9tka6tSMj/yasH4U=
X-Received: by 2002:a17:906:5a60:b0:8aa:bdec:d9ae with SMTP id
 my32-20020a1709065a6000b008aabdecd9aemr1343448ejc.12.1675906191937; Wed, 08
 Feb 2023 17:29:51 -0800 (PST)
MIME-Version: 1.0
References: <20230208205642.270567-1-iii@linux.ibm.com> <20230208205642.270567-9-iii@linux.ibm.com>
In-Reply-To: <20230208205642.270567-9-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Feb 2023 17:29:40 -0800
Message-ID: <CAEf4BzYCNNROXcEx5w3St6TLWS3YP4C6_uCWfgfS3t_p5uaxyQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 8/9] libbpf: Add MSan annotations
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 8, 2023 at 12:57 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> MSan runs into a few false positives in libbpf. They all come from the
> fact that MSan does not know anything about the bpf syscall,
> particularly, what it writes to.
>
> Add libbpf_mark_defined() function to mark memory modified by the bpf
> syscall. Use the abstract name (it could be e.g.
> libbpf_msan_unpoison()), because it can be used for valgrind in the
> future as well.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

This is a lot to satisfy MSan, especially mark_map_value_defined which
has to do bpf_obj_get_info_by_fd()... Is there any other way? What
happens if we don't do it?

As for libbpf_mark_defined, wouldn't it be cleaner to teach it to
handle NULL pointer and/or zero size transparently? Also, we can have
libbpf_mark_defined_if(void *ptr, size_t sz, bool cond), so in code we
don't have to have those explicit if conditions. Instead of:

> +       if (!ret && prog_ids)
> +               libbpf_mark_defined(prog_ids,
> +                                   attr.query.prog_cnt * sizeof(*prog_ids));

we can write just

libbpf_mark_defined_if(prog_ids, attr.query.prog_cnt *
sizeof(*prog_ids), ret == 0);

?

Should we also call a helper something like 'libbpf_mark_mem_written',
because that's what we are saying here, right?

>  tools/lib/bpf/bpf.c             | 70 +++++++++++++++++++++++++++++++--
>  tools/lib/bpf/btf.c             |  1 +
>  tools/lib/bpf/libbpf.c          |  1 +
>  tools/lib/bpf/libbpf_internal.h | 14 +++++++
>  4 files changed, 82 insertions(+), 4 deletions(-)
>

[...]

> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index fbaf68335394..4e4622f66fdf 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -577,4 +577,18 @@ static inline bool is_pow_of_2(size_t x)
>  #define PROG_LOAD_ATTEMPTS 5
>  int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attempts);
>
> +#if defined(__has_feature)
> +#if __has_feature(memory_sanitizer)
> +#define LIBBPF_MSAN
> +#endif
> +#endif
> +
> +#ifdef LIBBPF_MSAN

would below work:

#if defined(__has_feature) && __has_feature(memory_sanitizer)

?

> +#define HAVE_LIBBPF_MARK_DEFINED
> +#include <sanitizer/msan_interface.h>
> +#define libbpf_mark_defined __msan_unpoison
> +#else
> +static inline void libbpf_mark_defined(void *s, size_t n) {}
> +#endif
> +
>  #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
> --
> 2.39.1
>
