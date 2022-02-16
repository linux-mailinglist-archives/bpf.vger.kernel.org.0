Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8D04B7C84
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 02:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245410AbiBPBUB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 20:20:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240360AbiBPBUA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 20:20:00 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70B4F65EF
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 17:19:49 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id z18so373378iln.2
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 17:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqLQ1mfw9yhsSXPgW7TSG6FhUByX1er4jV3NI0iArhI=;
        b=oKAEpS8HF5ewccULBlcqJq1qvnu7wBgk4RA4GQbZsuo6/Kpw3i3iW8WK49xMoJKwiT
         FYPOiKEOh8Rc5on8fFy1BXGqeHSHR5+NSWf+0d8CdujneTdfWxA4UQoqWlcvE4JD8i2y
         9NiM68jRa5Aa/jLxrYHvT3nDUy80cz1cnVbvCViuIh71JOyehTtUGoiN2mpZsOBlCKet
         ipXI+RkU5xCrxaCxIhjd2vP1S0fa+XXNKXDXB4HlTJJDNTHAKgpCpyYHi2DwzWosswS4
         eb58crvgjJarRNI1GzhLjEfQPQ74cu93Rv+LBbKuDGMUJiLeLyRjgCQmup7c1aRgxmCZ
         TJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqLQ1mfw9yhsSXPgW7TSG6FhUByX1er4jV3NI0iArhI=;
        b=Dr7ds2Ks2J85WDw/QQ2P7yBwrkyuxOQPB9al9LpywGojpVf+7gJwflYVSVoV+nyrOt
         BFrIbkEg/FBJE4Z4KmnO1Kd1X5W0NOygrsXSCfEDOz/q6vVuF0HXG+damxHnFb497TlS
         Y7j3pyYrJToKD7Ie+KC/qnk7w7PQdcP9/nU4qbE58ht59yWI2DFAYmNO0e9rYqXsu2eR
         gMifWxT2Q9Qgr9vYWdqhKF0bxG7Nvs02VZzqzM3HTpoWCl7aGy31RX36ZmoJajxesRFt
         hvpb8Cykn4oPWMg03l1aicN8vZlAlA569dyAcifB8ibqOxZHuOX1HccH3tzywzPbBvOx
         AYxQ==
X-Gm-Message-State: AOAM533A0svJN9ZHEeVNfoX+O95gXXfeVUFLk5e5ZEFNodULlv1Gcz24
        7CQYRn1bVhN5X9PimmicbjsqCMCPrcUotmAFG9ZTSrKnNP8=
X-Google-Smtp-Source: ABdhPJz9unY90AlifrQpk8SQr742Gxvn0q0goyF5hr7LBl+YA2RvHJu48gszmxkL4gTmveQ6h35seBYAwvxGgNxwJX8=
X-Received: by 2002:a92:d208:0:b0:2c1:1a3c:7b01 with SMTP id
 y8-20020a92d208000000b002c11a3c7b01mr278130ily.71.1644974388810; Tue, 15 Feb
 2022 17:19:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644970147.git.delyank@fb.com> <b73550a69ea8c02fd93c862f9cfe38f7e1813e7a.1644970147.git.delyank@fb.com>
In-Reply-To: <b73550a69ea8c02fd93c862f9cfe38f7e1813e7a.1644970147.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Feb 2022 17:19:37 -0800
Message-ID: <CAEf4BzahTxY+djRkD6cjbGwkv_oevshpN-OpRMdYQ2P0_a1dOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/1] bpftool: bpf skeletons assert type sizes
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

On Tue, Feb 15, 2022 at 4:12 PM Delyan Kratunov <delyank@fb.com> wrote:
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
> ---

LGTM with a trivial styling nits. But this doesn't apply cleanly to
bpf-next (see [0]). Can you please rebase and resend. Also for
single-patch submissions we don't require cover letter, to please just
put all the description into one patch without cover letter.

  [0] https://github.com/kernel-patches/bpf/pull/2563#issuecomment-1040929960

>  tools/bpf/bpftool/gen.c | 134 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 112 insertions(+), 22 deletions(-)

[...]

> +
> +       bpf_object__for_each_map(map, obj) {
> +               if (!bpf_map__is_internal(map))
> +                       continue;
> +               if (!(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
> +                       continue;
> +               if (!get_map_ident(map, map_ident, sizeof(map_ident)))
> +                       continue;
> +
> +               sec = find_type_for_map(obj, map_ident);
> +

nit: unnecessary empty line between assignment and "error checking"

> +               if (!sec) {
> +                       /* best effort, couldn't find the type for this map */
> +                       continue;
> +               }
> +
> +               sec_var = btf_var_secinfos(sec);
> +               vlen =  btf_vlen(sec);
> +
> +               for (i = 0; i < vlen; i++, sec_var++) {
> +                       const struct btf_type *var = btf__type_by_id(btf, sec_var->type);
> +                       const char *var_name = btf__name_by_offset(btf, var->name_off);
> +                       __u32 var_type_id = var->type;
> +                       __s64 var_size = btf__resolve_size(btf, var_type_id);
> +
> +                       if (var_size < 0)
> +                               continue;
> +
> +                       /* static variables are not exposed through BPF skeleton */
> +                       if (btf_var(var)->linkage == BTF_VAR_STATIC)
> +                               continue;
> +
> +                       var_ident[0] = '\0';
> +                       strncat(var_ident, var_name, sizeof(var_ident) - 1);
> +                       sanitize_identifier(var_ident);
> +
> +                       printf("\t_Static_assert(");
> +                       printf("sizeof(s->%1$s->%2$s) == %3$lld, ",
> +                              map_ident, var_ident, var_size);
> +                       printf("\"unexpected size of '%1$s'\");\n", var_ident);

nit: I'd keep this as one printf, it makes it a bit easier to follow.

> +               }
> +       }

[...]
