Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CE3546C2A
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 20:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344108AbiFJSKB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 14:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244636AbiFJSKB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 14:10:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6BC2CCA1
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 11:09:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C6BEB836B6
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 18:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCEDC3411C
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 18:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654884596;
        bh=4zs2LH0TNNauGy4SO+Ot65Xl7qedE1AsIJRljzoY0is=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I3nGDf/AgA+ZgtVfxQcH0L+U4/w05X91/xqxO9PTqiEulAV09Fx4kx5n65E7kqpf9
         aspBjlHKpOMyegmWjiszpJG8kFFYfxNsBHTnqdXnijZf2ZUEfaz4HmxtFM+J0qs/xz
         X/m8nze3P6isUWyeXZzodJHP1VJilVYfIyIgtkXIkmW5f1BPZ29q4wL4uNbdO09es+
         WH/39lI/r0W8O3ljbluAquqtWSELKox0dsYOk6gaL529oAV6IP62r1+iT3lS0gfvh7
         cx7FP6tUVfY8b7Y0vdora3t2hDgtoRaQbQJMsa4X/seXONlqGZEexqDRAnb7Cwd9Nd
         v9hpEYiwT+CJg==
Received: by mail-yb1-f173.google.com with SMTP id t1so2151270ybd.2
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 11:09:56 -0700 (PDT)
X-Gm-Message-State: AOAM532eOPJ9WNRbb9k7/zDPA1mQZ+8nI58wNbq5jKlyAQYm0z8x5m+N
        TeOO525kyuO473otBg0i7Q2/v0lCq0z2oLk9zJk=
X-Google-Smtp-Source: ABdhPJyHEm++9YIZ2o3+bWMZ5NwMsBRLXvjAUJ6spCacdpvIuYDyFQHpDfL9Cu1WQrptYtltwLd6v/qztrmFl+du7ko=
X-Received: by 2002:a25:4705:0:b0:65d:43f8:5652 with SMTP id
 u5-20020a254705000000b0065d43f85652mr45036110yba.389.1654884595205; Fri, 10
 Jun 2022 11:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220608192630.3710333-1-eddyz87@gmail.com> <20220608192630.3710333-3-eddyz87@gmail.com>
In-Reply-To: <20220608192630.3710333-3-eddyz87@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 10 Jun 2022 11:09:44 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4+BVYjodLT2tH3emqXzZxv1D7c3Tu5YuYtpB-1Vwtn5w@mail.gmail.com>
Message-ID: <CAPhsuW4+BVYjodLT2tH3emqXzZxv1D7c3Tu5YuYtpB-1Vwtn5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/5] selftests/bpf: allow BTF specs and func
 infos in test_verifier tests
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 8, 2022 at 12:27 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
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
[...]
> +
> +static int load_btf_for_test(struct bpf_test *test)
> +{
> +       int types_num = 0;
> +
> +       while (types_num < MAX_BTF_TYPES &&
> +              test->btf_types[types_num] != BTF_END_RAW)
> +               ++types_num;
> +
> +       int types_len = types_num * sizeof(test->btf_types[0]);
> +
> +       return load_btf_spec(test->btf_types, types_len,
> +                            test->btf_strings, sizeof(test->btf_strings));

IIUC, strings_len is always 256. Is this expected?

Thanks,
Song

>  }
>
>  static int create_map_spin_lock(void)
> @@ -793,8 +839,6 @@ static int create_map_kptr(void)
>         return fd;
>  }
[...]
