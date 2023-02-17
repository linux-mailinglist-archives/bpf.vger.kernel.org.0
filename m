Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF5269A852
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 10:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjBQJkL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 04:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjBQJkK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 04:40:10 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6FC62FDA
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 01:40:06 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id a27so419576qto.4
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 01:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jpSzPdY13Il5SaouygMm1b6s+UAYDpRVGx0e+G8WO+g=;
        b=jaw4JPbZBSYXko5Em0pEqfCsdlutRLf6RXeObnFtOFX/ufYK4DjEJsICJ0qi9Wm5OZ
         mgrVB5qRpHJhu39+dUbH1KlcPF5dw1EBKEp2KWOJDhmGPsc5wDbHHHvcHoXbXtOvKL9S
         p+wFZzxdc9zl/hTwpwKULbSC2sj7l4oVEkJvFW0Cz0t7w1oG82x9EA40OVueLOzazTRY
         jPCrRDS0Ih0wXlFUbJdhLomPQt1zwwTIoqJECGS8h+q6OAKc8ZWSj70bT222y6PgAl0v
         JJPUnipb9zT62UaMk6GQh0x2Ly32BwpGu3AMOslWI47vC0J6HaG211gFP1FKmhfnv5cc
         t+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpSzPdY13Il5SaouygMm1b6s+UAYDpRVGx0e+G8WO+g=;
        b=a/9XfodUx69xVEOboerArLYcTkuOe4DlhHBDTFFv7FONWiQNfXEdAql/Wir3tfvA4s
         sGCmp28aN5kjLYKGuyrTAvui8a/tmWp5H+0tStIOhtruH/jfbUsd6gcx6KxqrctAqi7A
         CjhMBiw5cVJhu7BWTaO8Fweh2d4arCWAYieC8W9kKsXhWDXhoZE81B4eBJoubewZjh7S
         +tp/r6RBrD/7YCkXZ5eGF7C+gRqDW+OeZnVDBiDij5GzcuUfQuLFHAGIDrXxB/JtebI1
         3CNjXKJxK1IAsuuyfDZrksXJHcQ7XCwojALAs4sf9YbSUXS3wc2Dt/Hl2q/YADAKvm7a
         BLVA==
X-Gm-Message-State: AO0yUKXjnKi2pjO0qATatkgyLNIIzDxOtBcTWe9ReOHXPWtdIQ/E6JPo
        9KueWhXuhejcA/IM+qH3XT8=
X-Google-Smtp-Source: AK7set+/IarrZDe9+LKdRI4YafohHeYsMHAbIsTlC57rPIBDMDuy8pXnOcpCXu6ReoIaHEcqiCzc+Q==
X-Received: by 2002:ac8:5a87:0:b0:3b8:6a9f:9144 with SMTP id c7-20020ac85a87000000b003b86a9f9144mr800282qtc.46.1676626805457;
        Fri, 17 Feb 2023 01:40:05 -0800 (PST)
Received: from krava ([213.208.157.36])
        by smtp.gmail.com with ESMTPSA id 5-20020a05620a048500b00706c1f7a608sm2955935qkr.89.2023.02.17.01.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 01:40:05 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 17 Feb 2023 10:40:00 +0100
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH RFC bpf-next v2 4/4] bpf: Support 64-bit pointers to
 kfuncs
Message-ID: <Y+9LcD0U0ftB91/t@krava>
References: <20230215235931.380197-1-iii@linux.ibm.com>
 <20230215235931.380197-5-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215235931.380197-5-iii@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 16, 2023 at 12:59:31AM +0100, Ilya Leoshkevich wrote:

SNIP

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 71158a6786a1..47d390923610 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2115,8 +2115,8 @@ static int add_subprog(struct bpf_verifier_env *env, int off)
>  struct bpf_kfunc_desc {
>  	struct btf_func_model func_model;
>  	u32 func_id;
> -	s32 imm;
>  	u16 offset;
> +	unsigned long addr;
>  };
>  
>  struct bpf_kfunc_btf {
> @@ -2166,6 +2166,19 @@ find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
>  		       sizeof(tab->descs[0]), kfunc_desc_cmp_by_id_off);
>  }
>  
> +int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id, u16 offset,
> +		       u8 **func_addr)
> +{
> +	const struct bpf_kfunc_desc *desc;
> +
> +	desc = find_kfunc_desc(prog, func_id, offset);
> +	if (!desc)
> +		return -EFAULT;

should we warn here? this should alwayss succeed, right?

jirka

> +
> +	*func_addr = (u8 *)desc->addr;
> +	return 0;
> +}
> +

SNIP
