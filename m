Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0187853983F
	for <lists+bpf@lfdr.de>; Tue, 31 May 2022 22:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbiEaUxL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 May 2022 16:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiEaUxK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 May 2022 16:53:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C776C9CF6C
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 13:53:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F946B816BC
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 20:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CF5C385A9
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 20:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654030387;
        bh=SIKiMIhX6zaeAfKcIC1xmmxQdYwS/OEkbsev44kKWkI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TkTDo9PaHvBW1VUs79vNcYnrCeliNzfaJVKRDyF1od0UvZMsVrMpLeXClc2pipEvQ
         ilablzY6wJxkfIZrHBSttNniPsOYuPdEnK4WFZfJl5m843gSZ3Pb94d+siICJ6t2Lr
         Ys4ZRtB370xTUC9R1SPEtQXsjHCUdNZX+2bAvgnpPt3TvvboCTEjZuhtx1tsDFxN8+
         bon69poppm37tcU2wMPYruvLhVHc1vhZ8OGBz+sA94zvgxXey/nr997IdFZstXwDNW
         xxJkgJ9kC9l6Sd0a/F+xdRkydKSg8ZvgMW0RtKJtKRlrjZnPyuAv/STO/2s6wSTIUp
         VlGSELxLeqCcQ==
Received: by mail-yb1-f171.google.com with SMTP id t31so13074989ybi.2
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 13:53:07 -0700 (PDT)
X-Gm-Message-State: AOAM533xeXmg8dwYM4iGHTd0xEcXVrV773IJ6XyvPsMJvC8wkcGo73KE
        lkNC8YYz6gpHX9GNOZZ0anYzsDxaQfyYczswz6g=
X-Google-Smtp-Source: ABdhPJylY7fXbs6GRRTXEsXvEv4AZOMnc1fOTSDC4SHpox6k/kf8tFlavSmGBFFVzJHyGUYlFAi4gLVcmJo2XMXUyTs=
X-Received: by 2002:a25:8303:0:b0:65c:c9f7:3dbc with SMTP id
 s3-20020a258303000000b0065cc9f73dbcmr12534844ybk.259.1654030386232; Tue, 31
 May 2022 13:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220529223646.862464-1-eddyz87@gmail.com> <20220529223646.862464-3-eddyz87@gmail.com>
In-Reply-To: <20220529223646.862464-3-eddyz87@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 31 May 2022 13:52:55 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7wwt+J=oHXeB_8s8Tu63dzgODh56aCFPv-Vp43bofutA@mail.gmail.com>
Message-ID: <CAPhsuW7wwt+J=oHXeB_8s8Tu63dzgODh56aCFPv-Vp43bofutA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: allow BTF specs and func
 infos in test_verifier tests
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, May 29, 2022 at 3:37 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> The BTF and func_info specification for test_verifier tests follows
> the same notation as in prog_tests/btf.c tests. E.g.:
>
>   ...
>   .func_info = { { 0, 6 }, { 8, 7 } },
>   .func_info_cnt = 2,
>   .btf_strings = "\0int\0",
>   .btf_types = {
>     BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),
>     BTF_PTR_ENC(1),
>   },
>   ...
>
> The BTF specification is loaded only when specified.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

This can be very useful! Thanks!

> ---
>  tools/testing/selftests/bpf/prog_tests/btf.c |   1 -
>  tools/testing/selftests/bpf/test_btf.h       |   2 +
>  tools/testing/selftests/bpf/test_verifier.c  | 110 ++++++++++++++++---
>  3 files changed, 95 insertions(+), 18 deletions(-)

[...]

>
> -static int load_btf(void)
> +static char bpf_vlog[UINT_MAX >> 8];
> +
> +static int load_btf_spec(__u32 *types, int types_len,
> +                        const char *strings, int strings_len)
>  {
>         struct btf_header hdr = {
>                 .magic = BTF_MAGIC,
>                 .version = BTF_VERSION,
>                 .hdr_len = sizeof(struct btf_header),
> -               .type_len = sizeof(btf_raw_types),
> -               .str_off = sizeof(btf_raw_types),
> -               .str_len = sizeof(btf_str_sec),
> +               .type_len = types_len,
> +               .str_off = types_len,
> +               .str_len = strings_len,
>         };
>         void *ptr, *raw_btf;
>         int btf_fd;
>
> -       ptr = raw_btf = malloc(sizeof(hdr) + sizeof(btf_raw_types) +
> -                              sizeof(btf_str_sec));
> +       raw_btf = malloc(sizeof(hdr) + types_len + strings_len);
>
> +       ptr = raw_btf;
>         memcpy(ptr, &hdr, sizeof(hdr));
>         ptr += sizeof(hdr);
> -       memcpy(ptr, btf_raw_types, hdr.type_len);
> +       memcpy(ptr, types, hdr.type_len);
>         ptr += hdr.type_len;
> -       memcpy(ptr, btf_str_sec, hdr.str_len);
> +       memcpy(ptr, strings, hdr.str_len);
>         ptr += hdr.str_len;
>
> -       btf_fd = bpf_btf_load(raw_btf, ptr - raw_btf, NULL);
> -       free(raw_btf);
> +       LIBBPF_OPTS(bpf_btf_load_opts, opts,
> +                   .log_buf = bpf_vlog,
> +                   .log_size = sizeof(bpf_vlog),
> +                   .log_level = (verbose
> +                                 ? VERBOSE_LIBBPF_LOG_LEVEL
> +                                 : DEFAULT_LIBBPF_LOG_LEVEL),
> +       );

Please move the local variable definition to the beginning of the function.

> +
> +       btf_fd = bpf_btf_load(raw_btf, ptr - raw_btf, &opts);
>         if (btf_fd < 0)
> -               return -1;
> -       return btf_fd;
> +               printf("Failed to load BTF spec: '%s'\n", strerror(errno));
> +
> +       free(raw_btf);
> +
> +       return btf_fd < 0 ? -1 : btf_fd;
> +}
> +

[...]

> +
>  static void do_test_single(struct bpf_test *test, bool unpriv,
>                            int *passes, int *errors)
>  {
> -       int fd_prog, expected_ret, alignment_prevented_execution;
> +       int fd_prog, btf_fd, expected_ret, alignment_prevented_execution;
>         int prog_len, prog_type = test->prog_type;
>         struct bpf_insn *prog = test->insns;
>         LIBBPF_OPTS(bpf_prog_load_opts, opts);
> @@ -1366,8 +1424,10 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
>         __u32 pflags;
>         int i, err;
>
> +       fd_prog = -1;

This is not really necessary.

>         for (i = 0; i < MAX_NR_MAPS; i++)
>                 map_fds[i] = -1;
> +       btf_fd = -1;
>
>         if (!prog_type)
>                 prog_type = BPF_PROG_TYPE_SOCKET_FILTER;

[...]

> @@ -1540,6 +1614,8 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
>  fail_log:
>         (*errors)++;
>         printf("%s", bpf_vlog);
> +       if (!string_ends_with_nl(bpf_vlog, sizeof(bpf_vlog)))
> +               printf("\n");

This seems like overkill. Can we just print "\n" in all cases?

>         goto close_fds;
>  }
>
> --
> 2.25.1
>
