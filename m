Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998904C0C3D
	for <lists+bpf@lfdr.de>; Wed, 23 Feb 2022 06:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbiBWFjj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Feb 2022 00:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbiBWFjj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 00:39:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3522B4EF45
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 21:39:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E78CDB81E7B
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 05:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AD7C36AE2
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 05:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645594749;
        bh=PQpchWfACQ1TWX40AHF3FmaOgudN2afj5FOlxTJoQME=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j8rthoDtHsaDBOMIF/EBptWWnPd3VNgavXELsPD1nFez83JdJ2VgfuUSPWdio/isi
         DUzRlaBNsMLkCHb3kx6NsbcG8wY61jq1inGOesxBHj+FPXWxBwkDu6pfAF/kknoW2+
         JD+t/4uBwakarEtwSkMOVqImqSNTkyg8ZVz7rU/kAdMFWHucXiZ6CpWO+cDyx+AusB
         tR0FxQuVWN7X39PZlCsjOQjboMc8hDrtDmLM04wWwPKmCdGtHaOzhpqDX6EB0iBKQd
         b8ccY+JJYDFIa0sl2cbU/sHRuVjvYdYnhQvwFpjahlOD8OsLSFIFJy4onVdQpgozdM
         RwvNuyX0iPtqA==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-2d66f95f1d1so198442607b3.0
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 21:39:09 -0800 (PST)
X-Gm-Message-State: AOAM530dvkWGkS2txp9b3fPTcOcUkS5EXi/M2/h5cnNe9+rPp0amrjjh
        FWcPByfGMbb6Ts3j+PhL67POTMkufBamm2PSMWQ=
X-Google-Smtp-Source: ABdhPJzklCHCzLqoUIZSbn9MOa+MbdBkmAkpO3udiez8eIHsafTA3CbS3TILEWQB/uwltd/arD61Kt6ib44OgFmKqWE=
X-Received: by 2002:a81:83d6:0:b0:2ca:93ad:e4d6 with SMTP id
 t205-20020a8183d6000000b002ca93ade4d6mr26035730ywf.472.1645594748728; Tue, 22
 Feb 2022 21:39:08 -0800 (PST)
MIME-Version: 1.0
References: <20220222074524.1027060-1-xukuohai@huawei.com> <20220222074524.1027060-3-xukuohai@huawei.com>
In-Reply-To: <20220222074524.1027060-3-xukuohai@huawei.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 22 Feb 2022 21:38:57 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7x9M6VXrDkfAnTzZD4ztxGwVOtNuPNQ95EUcm2QgpJyQ@mail.gmail.com>
Message-ID: <CAPhsuW7x9M6VXrDkfAnTzZD4ztxGwVOtNuPNQ95EUcm2QgpJyQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Update btf_dump case for
 conflict FWD and STRUCT name
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Shuah Khan <shuah@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 21, 2022 at 11:41 PM Xu Kuohai <xukuohai@huawei.com> wrote:
>
> Update btf_dump test case for conflict FWD and STRUCT name.
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  tools/testing/selftests/bpf/prog_tests/btf_dump.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> index 9e26903f9170..2539a8f8b098 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> @@ -150,6 +150,8 @@ static void test_btf_dump_incremental(void)
>          *
>          * enum { VAL = 1 };
>          *
> +        * struct s;
> +        *
>          * struct s { int x; };
>          *
>          */
> @@ -161,8 +163,11 @@ static void test_btf_dump_incremental(void)
>         id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
>         ASSERT_EQ(id, 2, "int_id");
>
> +       id = btf__add_fwd(btf, "s", BTF_FWD_STRUCT);
> +       ASSERT_EQ(id, 3, "fwd_id");
> +
>         id = btf__add_struct(btf, "s", 4);
> -       ASSERT_EQ(id, 3, "struct_id");
> +       ASSERT_EQ(id, 4, "struct_id");
>         err = btf__add_field(btf, "x", 2, 0, 0);
>         ASSERT_OK(err, "field_ok");
>
> @@ -178,6 +183,8 @@ static void test_btf_dump_incremental(void)
>  "      VAL = 1,\n"
>  "};\n"
>  "\n"
> +"struct s;\n"
> +"\n"
>  "struct s {\n"
>  "      int x;\n"
>  "};\n\n", "c_dump1");
> @@ -199,7 +206,7 @@ static void test_btf_dump_incremental(void)
>         fseek(dump_buf_file, 0, SEEK_SET);
>
>         id = btf__add_struct(btf, "s", 4);
> -       ASSERT_EQ(id, 4, "struct_id");
> +       ASSERT_EQ(id, 5, "struct_id");
>         err = btf__add_field(btf, "x", 1, 0, 0);
>         ASSERT_OK(err, "field_ok");
>         err = btf__add_field(btf, "s", 3, 32, 0);
> --
> 2.30.2
>
