Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9495052AEC6
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 01:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiEQXl2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 19:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiEQXlK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 19:41:10 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CD81EC77
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 16:41:08 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id f9so414523ils.7
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 16:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LxJm6aQ3xGF5u8LDsiP8FxunEEUm5Xaza2NNGau4aCw=;
        b=W6aLdnrkHIszd5vge9eCmZTayPxO6BfQybf6Pph/41A7PL4ra9ziZRrfnzUookjtIw
         U/BjXqc2LhnXO3pxeD9UmctToH+92jZZwvDNGOmKwr0F4WdGJJmeJAFWJweQKgzh9sXR
         V0ABwdlTxXfszBDY5icb8V+dN6N8VmO5IFHDVwy1zDGlMhP3rX8F5i7XyKLHL5yGs8E2
         0TmDCnmh+clfa8CdMkFu2gCKaCx6Zh+c5Kbf7MIPMGjT06PYzmpy+8PtXnoO/7H4leIS
         d4FVZL4vF+6t6dnHTW5QLdnQWqEEv04Ds2ee3JJVz+Huzg1hNWCw2AU853gJZhWbxo0d
         TzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LxJm6aQ3xGF5u8LDsiP8FxunEEUm5Xaza2NNGau4aCw=;
        b=T0qEhaQx0wjjtCCqudEeCc3EH+bTBMGlvwXJ8nzBjV6oUE3QT3lNJmt5g5q+gvFXiw
         y2ZvJWpcTmeIbNfLPeLOZdtuNw52JUI1cXp1rD/bRjHIPuchzMUs0+3v6wgb/i3TOo0q
         ICBT2+g2xR8oOcpaldLZ2KJxoJw37GwUJrBhlEoyuVWbgCkHPGeo2kLLtQXNsDEjZCPh
         AMOkltzCkVIK6jl1DWdBUz+EBgp+z8qS2eh2AHrh6FCwMXgKEcmaYYUAS/wZgbEBlFIc
         2tjFQDodFxpNLexSD8UbSZiWCNfCILlL/FnFBTpObz/uofiJa7R8dd8p2leA8Ih3ISUK
         J9nA==
X-Gm-Message-State: AOAM532n/Prc5XKyj/U11gDZZSLKWbj7PHDc7gAdi+wz4GJKdIHZ/IAf
        /geEMpkQcjuRZ/aelUCIUtJlgDjBQwNwdsbDatM=
X-Google-Smtp-Source: ABdhPJw6dEvYtW2ubTkL+5RO0MJeJn0GsxBffpsi13jv4elI52iIZXQqNCMK6RYZkdEAGzVYHczvxPzARiCjX1YpddM=
X-Received: by 2002:a05:6e02:1c01:b0:2d1:262e:8d5f with SMTP id
 l1-20020a056e021c0100b002d1262e8d5fmr5372424ilh.98.1652830868003; Tue, 17 May
 2022 16:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220514031221.3240268-1-yhs@fb.com> <20220514031329.3245856-1-yhs@fb.com>
In-Reply-To: <20220514031329.3245856-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 17 May 2022 16:40:57 -0700
Message-ID: <CAEf4BzY5_-vc6+t0bfZ0y_0Rsi9Og9fa6EtSuQ=OyGYFFQvHwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 13/18] selftests/bpf: Test new enum kflag and
 enum64 API functions
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Fri, May 13, 2022 at 8:13 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add tests to use the new enum kflag and enum64 API functions
> in selftest btf_write.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/testing/selftests/bpf/btf_helpers.c     |  21 +++-
>  .../selftests/bpf/prog_tests/btf_write.c      | 114 +++++++++++++-----
>  2 files changed, 105 insertions(+), 30 deletions(-)

[...]

> @@ -307,6 +308,48 @@ static void gen_btf(struct btf *btf)
>         ASSERT_EQ(t->type, 1, "tag_type");
>         ASSERT_STREQ(btf_type_raw_dump(btf, 20),
>                      "[20] TYPE_TAG 'tag1' type_id=1", "raw_dump");
> +
> +       /* ENUM64 */
> +       id = btf__add_enum64(btf, "e1", 8, true);
> +       ASSERT_EQ(id, 21, "enum64_id");
> +       err = btf__add_enum64_value(btf, "v1", -1);
> +       ASSERT_OK(err, "v1_res");
> +       err = btf__add_enum64_value(btf, "v2", 0x123456789); /* 4886718345 */
> +       ASSERT_OK(err, "v2_res");
> +       t = btf__type_by_id(btf, 21);
> +       ASSERT_STREQ(btf__str_by_offset(btf, t->name_off), "e1", "enum64_name");
> +       ASSERT_EQ(btf_kind(t), BTF_KIND_ENUM64, "enum64_kind");
> +       ASSERT_EQ(btf_vlen(t), 2, "enum64_vlen");
> +       ASSERT_EQ(t->size, 8, "enum64_sz");
> +       v64 = btf_enum64(t) + 0;
> +       ASSERT_STREQ(btf__str_by_offset(btf, v64->name_off), "v1", "v1_name");
> +       ASSERT_EQ(v64->val_hi32, 0xffffffff, "v1_val");
> +       ASSERT_EQ(v64->val_lo32, 0xffffffff, "v1_val");
> +       v64 = btf_enum64(t) + 1;
> +       ASSERT_STREQ(btf__str_by_offset(btf, v64->name_off), "v2", "v2_name");
> +       ASSERT_EQ(v64->val_hi32, 0x1, "v2_val");
> +       ASSERT_EQ(v64->val_lo32, 0x23456789, "v2_val");
> +       ASSERT_STREQ(btf_type_raw_dump(btf, 21),
> +                    "[21] ENUM64 'e1' size=8 vlen=2\n"

we should emit and validate kflag for enum/enum64. Or maybe
"encoding=SIGNED|UNSIGNED" to match INT's output, not sure which one
is best, but we probably want to make sure that kflag is reflected in
bpftool and selftests output, right?

> +                    "\t'v1' val=-1\n"
> +                    "\t'v2' val=4886718345", "raw_dump");
> +
> +       id = btf__add_enum64(btf, "e1", 8, false);
> +       ASSERT_EQ(id, 22, "enum64_id");
> +       err = btf__add_enum64_value(btf, "v1", 0xffffffffFFFFFFFF); /* 18446744073709551615 */
> +       ASSERT_OK(err, "v1_res");
> +       t = btf__type_by_id(btf, 22);
> +       ASSERT_STREQ(btf__str_by_offset(btf, t->name_off), "e1", "enum64_name");
> +       ASSERT_EQ(btf_kind(t), BTF_KIND_ENUM64, "enum64_kind");
> +       ASSERT_EQ(btf_vlen(t), 1, "enum64_vlen");
> +       ASSERT_EQ(t->size, 8, "enum64_sz");
> +       v64 = btf_enum64(t) + 0;
> +       ASSERT_STREQ(btf__str_by_offset(btf, v64->name_off), "v1", "v1_name");
> +       ASSERT_EQ(v64->val_hi32, 0xffffffff, "v1_val");
> +       ASSERT_EQ(v64->val_lo32, 0xffffffff, "v1_val");
> +       ASSERT_STREQ(btf_type_raw_dump(btf, 22),
> +                    "[22] ENUM64 'e1' size=8 vlen=1\n"
> +                    "\t'v1' val=18446744073709551615", "raw_dump");
>  }
>
>  static void test_btf_add()

[...]
