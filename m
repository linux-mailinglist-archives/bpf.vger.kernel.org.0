Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786F84C2103
	for <lists+bpf@lfdr.de>; Thu, 24 Feb 2022 02:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiBXBfX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Feb 2022 20:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiBXBfW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 20:35:22 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAF9159EBB
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 17:34:52 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id f14so1062716ioz.1
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 17:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r9YVWV6IDFHTO66hG7iP4KMlQzTgzuLzdMWKX4BYZ3w=;
        b=XwiRK3CfIoMhM6YWu+fWI3Qj0Elel34VFVMikson/0N3lMCnZIkaxv3+q21H/7FMza
         S32/Pl+AtOQTN21nPCejaa88eNY51eT37r9KyMNe7zd1TPcdowJrKuhjfmLm9kBWXiRY
         9iHMJAH2J55bj4eIH0T/0RRJfcE829E2q0zNSKQ88UpzmBWyodfBgARqijSsVZOLEhEX
         VCg+qtMRZjhx60zZhWYqRhwK+GbxfO/ZWTvfnSEQBFMGCBwepE8oTqh78SlxdMQxOjAf
         E2VY9GMJAXa+eIGGynQsJPFzGKK6jTrPbBpOzhgKXVlmB7FEDlCaNZGbTvTLY+D2cRYi
         Yr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r9YVWV6IDFHTO66hG7iP4KMlQzTgzuLzdMWKX4BYZ3w=;
        b=5f3RSZmR7rIta+ZykqHS/tgBls3qeStDaXswu/lcCWb/xG+vZvOKOcR1rnSFcVf9fb
         asQfBAQ67qKoj3sygBIBYuebqElngjwfHIogKKnU5wHcgqAEcu1LXO0tgmfPppCOdYXb
         XfRxgXlKxZkKY1/5KJeANp919fI0erLq2zh3nO4Fism1zFiHuxRe+Lnobv4oM9Ttl0Ed
         1T9BoXkkfBtY9lq/+DG2KYDGneQjlNNR1E6+RXtzXn4/yHxsw2HvyvYq5TMCmUmKc9CY
         dc8LULATXG39Jcwtyi0VXIurbhTlrOGTZ76SCF2C9ixZuHQnxi4FySb4WakDmWJMGKau
         Awjg==
X-Gm-Message-State: AOAM530FtDpO2bACOfJpRZTbAEJc/3/kIdgOsrYAsHy2lnSMvRRo0fIh
        xZ4fo/7Fklkc7bkffmETLJzdYIgpTzgHfuhzD4g=
X-Google-Smtp-Source: ABdhPJzsjg+s/pkahqc+h/Gayr8diyFBP3QRVuNj5+IfWuLlk8VmnUZOyWln1KgdyyR9YfdFdhQfeXURpRg7ph8271g=
X-Received: by 2002:a02:aa85:0:b0:314:c152:4c89 with SMTP id
 u5-20020a02aa85000000b00314c1524c89mr260056jai.93.1645666492350; Wed, 23 Feb
 2022 17:34:52 -0800 (PST)
MIME-Version: 1.0
References: <f562455d7b3cf338e59a7976f4690ec5a0057f7f.camel@fb.com>
In-Reply-To: <f562455d7b3cf338e59a7976f4690ec5a0057f7f.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 23 Feb 2022 17:34:41 -0800
Message-ID: <CAEf4BzbLKKpUX-wxNpTw9xY1+k18cSsi7WP8S5=qNm_jkNbSGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpftool: bpf skeletons assert type sizes
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 23, 2022 at 2:02 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> When emitting type declarations in skeletons, bpftool will now also emit
> static assertions on the size of the data/bss/rodata/etc fields. This
> ensures that in situations where userspace and kernel types have the same
> name but differ in size we do not silently produce incorrect results but
> instead break the build.
>
> This was reported in [1] and as expected the repro in [2] fails to build
> on the new size assert after this change.
>
>   [1]: Closes: https://github.com/libbpf/libbpf/issues/433
>   [2]: https://github.com/fuweid/iovisor-bcc-pr-3777
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> Acked-by: Hengqi Chen <hengqi.chen@gmail.com>
> Tested-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
> v3 -> v4:
>  - rebase
>  - style fixes
>

I added a few tweaks (see below) and applied to bpf-next. Thanks!

> v2 -> v3:
>  - group all static asserts in one function at the end of the file
>  - only use macros in C++ mode
>
> v1 -> v2:
>  - drop the stdint approach in favor of static asserts right after the structs
>
>  tools/bpf/bpftool/gen.c | 133 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 111 insertions(+), 22 deletions(-)
>
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index f8c1413523a3..a42545bcb12d 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -209,15 +209,38 @@ static int codegen_datasec_def(struct bpf_object *obj,
>         return 0;
>  }
>
> +static const struct btf_type *find_type_for_map(struct bpf_object *obj,
> +                                               const char *map_ident)

this doesn't need entire bpf_object, it's enough to pass struct btf
directly, I changed it to take just btf

> +{
> +       struct btf *btf = bpf_object__btf(obj);
> +       int n = btf__type_cnt(btf), i;
> +       char sec_ident[256];
> +

[...]

> +/* Emit type size asserts for all top-level fields in memory-mapped internal maps.
> + */
> +static void codegen_asserts(struct bpf_object *obj, const char *obj_name)
> +{
> +       struct btf *btf = bpf_object__btf(obj);
> +       struct bpf_map *map;
> +       struct btf_var_secinfo *sec_var;
> +       int i, vlen;
> +       const struct btf_type *sec;
> +       char map_ident[256], var_ident[256];
> +
> +       codegen("\
> +               \n\
> +                                                                           \n\
> +               #ifdef __cplusplus                                          \n\
> +               #define _Static_assert static_assert                        \n\
> +               #endif                                                      \n\

I moved this _Static_assert business inside the <skel>__type_asserts()
function. I also thought that if in the future we want to add some
other asserts, then having a more generic "<skel>__assert()" name
would be more appropriate, so I renamed it to just "<skel>__assert".

> +                                                                           \n\
> +               __attribute__((unused)) static void                         \n\
> +               %1$s__type_asserts(struct %1$s *s)                          \n\
> +               {                                                           \n\
> +               ", obj_name);
> +

[...]

> +                       var_ident[0] = '\0';
> +                       strncat(var_ident, var_name, sizeof(var_ident) - 1);
> +                       sanitize_identifier(var_ident);
> +
> +                       printf("\t_Static_assert(sizeof(s->%1$s->%2$s) == %3$lld, \"unexpected size of '%2$s'\");\n",
> +                              map_ident, var_ident, var_size);

__s64 isn't %lld on each supported architecture. I just used long and
%ld instead of __s64 to avoid compilation warnings.

> +               }
> +       }
> +       codegen("\
> +               \n\
> +               }                                                           \n\
> +                                                                           \n\
> +               #ifdef __cplusplus                                          \n\
> +               #undef _Static_assert                                       \n\
> +               #endif                                                      \n\
> +               ");
> +}
> +
> +

[...]
