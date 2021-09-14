Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E37340A5F2
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 07:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239503AbhINFd0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 01:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239411AbhINFdZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 01:33:25 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9412C061574
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 22:32:08 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id i12so25312834ybq.9
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 22:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IlW8YMXtWu5GaNddwH5xk275y4kJsGxG64V0LTcHUMs=;
        b=Pje1N4NMtBu2f8rx8ry6hpdIVoGMFL8U7QAf3jLFBzrLOjF+oyHbnWefkUYiANubVn
         UkmkmMXOIONEdyvSnnf4XYfT5zb9PJ3TQvZyu/dBQC5HxWtnbk1Rl4J4/A6kCQ9WwIRp
         aMCLyyoclue07mq83Os4mRQn0qmpe+95faLIP1h4u0budjgSZv0bfwUnM8urHiK+5i/S
         o9kF1ExzPWT8lCpHqh/r4ePG4AVWd0lXBmeDBxSiSDReYhnL66ML+hkWBkussc/aQTz+
         AobZWTWRNX0r152CBROfw+Y5UWLyEi5qymg5C2DMYI+C63bFRkS/BRLv6oDY6lvJTm2R
         J5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IlW8YMXtWu5GaNddwH5xk275y4kJsGxG64V0LTcHUMs=;
        b=TpAnCyJcM9EXVLngrcaea4DDv8OqAuF4Bfajp8CeY5g7BoT1jgaZTSahljbYKxx17H
         Jp7L00AR/91hQKQ+cAqTKcVdQyHFB3SSFzzZdbXqeNXlX0iM7T58+QXlxqODSqaUtH00
         THl3PYexsWhxM9lHnYlh5HiKnk64cDP764XBsPnXMh9ZLtDTvUsM5ny881MX1rJWArwX
         togZyDJ9gneonMQKKPheWzXtteJHdOIu0jrVoQpU8+e1FTF1FM8UxUazPQV0o3ENTDgz
         Io9Gw+HtmOW1+vBFFfLgdDD+EwFX9+pyph8P+KvIUr0HGqdd907gknwwqOHBsepehNVs
         CquA==
X-Gm-Message-State: AOAM530kTDN1tsj4w0rSS7HkvqSolqYOXjy+fXysvrT7sCA+wNx9z7XE
        ZEOAYsYQ3jS7M1WnNY3abVCH1AmDsyPfzHFCKZX50V6h
X-Google-Smtp-Source: ABdhPJxjWCsmUGRzK6mGtX0eoVCubAJYDE2aFljTVeL+MV7tNK9N2xpIjUqQlobYvpHJXx6FL1I7AL/mwoAYdR1vodQ=
X-Received: by 2002:a25:47c4:: with SMTP id u187mr21522147yba.225.1631597528070;
 Mon, 13 Sep 2021 22:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210913155122.3722704-1-yhs@fb.com> <20210913155206.3728212-1-yhs@fb.com>
In-Reply-To: <20210913155206.3728212-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 Sep 2021 22:31:57 -0700
Message-ID: <CAEf4BzZ7_fmqro9HwaQFELbu=YJHtu-phYy=DBOhuXygrLfV7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 08/11] selftests/bpf: add BTF_KIND_TAG unit tests
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 13, 2021 at 8:52 AM Yonghong Song <yhs@fb.com> wrote:
>
> Test good and bad variants of BTF_KIND_TAG encoding.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/btf.c | 223 +++++++++++++++++++
>  tools/testing/selftests/bpf/test_btf.h       |   3 +
>  2 files changed, 226 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
> index ad39f4d588d0..21b122f72a55 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> @@ -3661,6 +3661,227 @@ static struct btf_raw_test raw_tests[] = {
>         .err_str = "Invalid type_size",
>  },
>
> +{
> +       .descr = "tag test #1, struct/member, well-formed",
> +       .raw_types = {
> +               BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
> +               BTF_STRUCT_ENC(0, 2, 8),                        /* [2] */
> +               BTF_MEMBER_ENC(NAME_TBD, 1, 0),
> +               BTF_MEMBER_ENC(NAME_TBD, 1, 32),
> +               BTF_TAG_ENC(NAME_TBD, 2, -1),
> +               BTF_TAG_ENC(NAME_TBD, 2, 0),
> +               BTF_TAG_ENC(NAME_TBD, 2, 1),
> +               BTF_END_RAW,
> +       },
> +       BTF_STR_SEC("\0m1\0m2\0tag1\0tag2\0tag3"),
> +       .map_type = BPF_MAP_TYPE_ARRAY,
> +       .map_name = "tag_type_check_btf",
> +       .key_size = sizeof(int),
> +       .value_size = 8,
> +       .key_type_id = 1,
> +       .value_type_id = 2,
> +       .max_entries = 1,
> +},
> +{
> +       .descr = "tag test #2, union/member, well-formed",
> +       .raw_types = {
> +               BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
> +               BTF_STRUCT_ENC(NAME_TBD, 2, 4),                 /* [2] */

this is not a union. Other tests open-code union, but it's probably a
good idea to add BTF_UNION_ENC

> +               BTF_MEMBER_ENC(NAME_TBD, 1, 0),
> +               BTF_MEMBER_ENC(NAME_TBD, 1, 0),
> +               BTF_TAG_ENC(NAME_TBD, 2, -1),
> +               BTF_TAG_ENC(NAME_TBD, 2, 0),
> +               BTF_TAG_ENC(NAME_TBD, 2, 1),
> +               BTF_END_RAW,
> +       },
> +       BTF_STR_SEC("\0t\0m1\0m2\0tag1\0tag2\0tag3"),
> +       .map_type = BPF_MAP_TYPE_ARRAY,
> +       .map_name = "tag_type_check_btf",
> +       .key_size = sizeof(int),
> +       .value_size = 4,
> +       .key_type_id = 1,
> +       .value_type_id = 2,
> +       .max_entries = 1,
> +},

[...]

> +{
> +       .descr = "tag test #7, invalid vlen",
> +       .raw_types = {
> +               BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
> +               BTF_VAR_ENC(NAME_TBD, 1, 0),                    /* [2] */
> +               BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_TAG, 1, 1), 2), (0),

here you have both kflag and vlen specified, so it's not clear which
one is rejected. Please keep kflag at 0 for this one.

> +               BTF_END_RAW,
> +       },
> +       BTF_STR_SEC("\0local\0tag1"),
> +       .map_type = BPF_MAP_TYPE_ARRAY,
> +       .map_name = "tag_type_check_btf",
> +       .key_size = sizeof(int),
> +       .value_size = 4,
> +       .key_type_id = 1,
> +       .value_type_id = 1,
> +       .max_entries = 1,
> +       .btf_load_err = true,
> +       .err_str = "vlen != 0",
> +},
> +{
> +       .descr = "tag test #8, invalid kflag",
> +       .raw_types = {
> +               BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
> +               BTF_VAR_ENC(NAME_TBD, 1, 0),                    /* [2] */
> +               BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_TAG, 1, 0), 2), (-1),
> +               BTF_END_RAW,
> +       },
> +       BTF_STR_SEC("\0local\0tag1"),
> +       .map_type = BPF_MAP_TYPE_ARRAY,
> +       .map_name = "tag_type_check_btf",
> +       .key_size = sizeof(int),
> +       .value_size = 4,
> +       .key_type_id = 1,
> +       .value_type_id = 1,
> +       .max_entries = 1,
> +       .btf_load_err = true,
> +       .err_str = "Invalid btf_info kind_flag",
> +},
> +{
> +       .descr = "tag test #9, var, invalid component_idx",
> +       .raw_types = {
> +               BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
> +               BTF_VAR_ENC(NAME_TBD, 1, 0),                    /* [2] */
> +               BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_TAG, 0, 0), 2), (0),

nit: could have used BTF_TAG_ENC?

> +               BTF_END_RAW,
> +       },
> +       BTF_STR_SEC("\0local\0tag"),
> +       .map_type = BPF_MAP_TYPE_ARRAY,
> +       .map_name = "tag_type_check_btf",
> +       .key_size = sizeof(int),
> +       .value_size = 4,
> +       .key_type_id = 1,
> +       .value_type_id = 1,
> +       .max_entries = 1,
> +       .btf_load_err = true,
> +       .err_str = "Invalid component_idx",
> +},
> +{
> +       .descr = "tag test #10, struct member, invalid component_idx",
> +       .raw_types = {
> +               BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
> +               BTF_STRUCT_ENC(0, 2, 8),                        /* [2] */
> +               BTF_MEMBER_ENC(NAME_TBD, 1, 0),
> +               BTF_MEMBER_ENC(NAME_TBD, 1, 32),
> +               BTF_TAG_ENC(NAME_TBD, 2, 2),
> +               BTF_END_RAW,
> +       },
> +       BTF_STR_SEC("\0m1\0m2\0tag"),
> +       .map_type = BPF_MAP_TYPE_ARRAY,
> +       .map_name = "tag_type_check_btf",
> +       .key_size = sizeof(int),
> +       .value_size = 8,
> +       .key_type_id = 1,
> +       .value_type_id = 2,
> +       .max_entries = 1,
> +       .btf_load_err = true,
> +       .err_str = "Invalid component_idx",
> +},
> +{
> +       .descr = "tag test #11, func parameter, invalid component_idx",
> +       .raw_types = {
> +               BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
> +               BTF_FUNC_PROTO_ENC(0, 2),                       /* [2] */
> +                       BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
> +                       BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
> +               BTF_FUNC_ENC(NAME_TBD, 2),                      /* [3] */
> +               BTF_TAG_ENC(NAME_TBD, 3, 2),
> +               BTF_END_RAW,
> +       },
> +       BTF_STR_SEC("\0arg1\0arg2\0f\0tag"),
> +       .map_type = BPF_MAP_TYPE_ARRAY,
> +       .map_name = "tag_type_check_btf",
> +       .key_size = sizeof(int),
> +       .value_size = 4,
> +       .key_type_id = 1,
> +       .value_type_id = 1,
> +       .max_entries = 1,
> +       .btf_load_err = true,
> +       .err_str = "Invalid component_idx",
> +},
> +

please also add invalid negative component_idx test (e.g., -2)

>  }; /* struct btf_raw_test raw_tests[] */
>
>  static const char *get_next_str(const char *start, const char *end)
> @@ -6801,6 +7022,8 @@ static int btf_type_size(const struct btf_type *t)
>                 return base_size + sizeof(struct btf_var);
>         case BTF_KIND_DATASEC:
>                 return base_size + vlen * sizeof(struct btf_var_secinfo);
> +       case BTF_KIND_TAG:
> +               return base_size + sizeof(struct btf_tag);
>         default:
>                 fprintf(stderr, "Unsupported BTF_KIND:%u\n", kind);
>                 return -EINVAL;
> diff --git a/tools/testing/selftests/bpf/test_btf.h b/tools/testing/selftests/bpf/test_btf.h
> index e2394eea4b7f..0619e06d745e 100644
> --- a/tools/testing/selftests/bpf/test_btf.h
> +++ b/tools/testing/selftests/bpf/test_btf.h
> @@ -69,4 +69,7 @@
>  #define BTF_TYPE_FLOAT_ENC(name, sz) \
>         BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0), sz)
>
> +#define BTF_TAG_ENC(value, type, component_idx)        \
> +       BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_TAG, 0, 0), type), (component_idx)
> +
>  #endif /* _TEST_BTF_H */
> --
> 2.30.2
>
