Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D316261BE
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiKKTHh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKKTHg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:07:36 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7E022BE3
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:07:35 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id t25so14658892ejb.8
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0NG/SPBkBMAdK8ZvnWhMnvWe583K0D4bdlQoDWDMww=;
        b=pCcp6QN+6hZH+lYfo/FtyNR8xKD9UBXX/8y/a4uaykMrIAXzhqh7A+sa31WKVlLVvb
         Y2ivsCAzH4h5gJsTNuiQpR16RdU3CfB37Un5x+Ya2ccYU4H4xaydgaVu/tzQLwtm3AZm
         +1LcxZZTBay8MLMmH7ppiuwgmyE34i0qvtjs9omOrgtBnfDyXv7z+mz6HwJVN3sHoxPl
         DBc6uLSm/Jx4G+Yi2HwvLCtUvM/PeevgQnKXE598HbpsstozN4SJL1GXfyPl2B/VDiSG
         w/HnC0UVxsqLpCVd4fzKoFYI8YLOmttT9qTxCOg8dX7Jau5JQGAD2DiuZDL78CztePjp
         o7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z0NG/SPBkBMAdK8ZvnWhMnvWe583K0D4bdlQoDWDMww=;
        b=K2u0vEsxgOJ4KHt2Z7hD4wgut4ijAAXbc5jEeKL3e66qJabTBaKinUgtGOfPboAjC/
         iCq5Dzo9QXG1QuyXe4Nm3aydstM//rAxpFwoBZKNTI9ufyd141tyIWwpL/7hZCl3xvPB
         PXq/xz64cSnnyS25vgr8gz2lv/cXqQBQrLsFKGNAGtnz7En/aG11AkqvVjHGTMR2ruNX
         CNVszEDkT5l5PgoBImkJ7NCf9/LNEpXs1SZQn/xMnP/LPrtXTiFqzd3X+pTkOqHcSZW6
         acJdMM6rLsL/cEWYxBEPZuQQaD5ry6niBU6Wtgx3g1tiWObQbt/5oqLLi5jAunOKGQwz
         8eyw==
X-Gm-Message-State: ANoB5pmTT7byIZv3AUKAqIlUQR4w+u3bbsHUS2TCGQua4EBnb6TpADP/
        TqTLCzfxVMGY3UE5X5CZUAtlnc2Cm5irEho25Rg=
X-Google-Smtp-Source: AA0mqf7PPOqNNs6asop9Kic1CTIsCsUQkguCcs0+ynp5HdjyY4tPvanmCrdb7Rdpac+jcJq4QtdeswSa5U6ZUJEjDxA=
X-Received: by 2002:a17:906:cd0f:b0:78d:99ee:4e68 with SMTP id
 oz15-20020a170906cd0f00b0078d99ee4e68mr2934253ejb.302.1668193654297; Fri, 11
 Nov 2022 11:07:34 -0800 (PST)
MIME-Version: 1.0
References: <20221110144320.1075367-1-eddyz87@gmail.com> <20221110144320.1075367-4-eddyz87@gmail.com>
In-Reply-To: <20221110144320.1075367-4-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Nov 2022 11:07:22 -0800
Message-ID: <CAEf4Bzb1P1+hn=k498F3FPjT_jJMOhC-HcVfUkRso0kSgC5SOQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: Tests for
 BTF_KIND_DECL_TAG dump in C format
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
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

On Thu, Nov 10, 2022 at 6:43 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Covers the following cases:
> - `__atribute__((btf_decl_tag("...")))` could be applied to structs
>   and unions;
> - decl tag applied to an empty struct is printed on a single line;
> - decl tags with the same name could be applied to several structs;
> - several decl tags could be applied to the same struct;
> - attribute `packed` works fine with decl tags (it is a separate
>   branch in `tools/lib/bpf/btf_dump.c:btf_dump_emit_attributes`;
> - decl tag could be attached to typedef;
> - decl tag could be attached to a struct field;
> - decl tag could be attached to a struct field and a struct itself
>   simultaneously;
> - decl tag could be attached to a global variable;
> - decl tag could be attached to a func proto parameter;
> - btf__add_decl_tag could be interleaved with btf_dump__dump_type calls.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/btf_dump.c       | 79 +++++++++++++++++++
>  .../bpf/progs/btf_dump_test_case_decl_tag.c   | 65 +++++++++++++++
>  2 files changed, 144 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
>

[...]

> +       /* First, BTF corresponding to the following C code:
> +        *
> +        * typedef void (*fn)(int a __btf_decl_tag("a_tag"));
> +        *
> +        */
> +       id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
> +       ASSERT_EQ(id, 1, "int_id");
> +       id = btf__add_func_proto(btf, 0);
> +       ASSERT_EQ(id, 2, "func_proto_id");
> +       err = btf__add_func_param(btf, "a", 1);
> +       ASSERT_OK(err, "func_param_ok");
> +       id = btf__add_decl_tag(btf, "a_tag", 2, 0);
> +       ASSERT_EQ(id, 3, "decl_tag_a");
> +       id = btf__add_ptr(btf, 2);
> +       ASSERT_EQ(id, 4, "proto_ptr");
> +       id = btf__add_typedef(btf, "fn", 4);
> +       ASSERT_EQ(id, 5, "typedef");

can you please also add decl_tag for func_proto itself (comp_idx == -1)

> +
> +       err = btf_dump_all_types(btf, d);
> +       ASSERT_OK(err, "btf_dump_all_types #1");
> +       fflush(dump_buf_file);
> +       dump_buf[dump_buf_sz] = 0; /* some libc implementations don't do this */
> +
> +       ASSERT_STREQ(dump_buf,
> +                    "#if __has_attribute(btf_decl_tag)\n"
> +                    "#define __btf_decl_tag(x) __attribute__((btf_decl_tag(x)))\n"
> +                    "#else\n"
> +                    "#define __btf_decl_tag(x)\n"
> +                    "#endif\n"
> +                    "\n"
> +                    "typedef void (*fn)(int a __btf_decl_tag(\"a_tag\"));\n\n",
> +                    "decl tags for fn");
> +

[...]

> +struct tag_on_field_and_struct {
> +       int x __btf_decl_tag("t1");
> +} __btf_decl_tag("t2");
> +
> +struct root_struct {
> +       struct empty_with_tag a;
> +       struct one_tag b;
> +       struct same_tag c;
> +       struct two_tags d;
> +       struct packed e;
> +       td_with_tag f;
> +       struct tags_on_fields g;
> +       struct tag_on_field_and_struct h;
> +};
> +
> +SEC(".data") int global_var __btf_decl_tag("var_tag") = (int)777;

do you need explicit SEC(".data")? I'd expect global_var is put into
.data anyways. If it's about __attribute__((unused)), then we can do
that more explicitly here instead of through SEC()? Or just make sure
global_var is used in f() internally

> +
> +/* ------ END-EXPECTED-OUTPUT ------ */
> +
> +int f(struct root_struct *s)
> +{
> +       return 0;
> +}
> --
> 2.34.1
>
