Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3C9413D3B
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 00:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbhIUWDq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 18:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbhIUWDp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Sep 2021 18:03:45 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187A9C061574;
        Tue, 21 Sep 2021 15:02:13 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id f130so2531093qke.6;
        Tue, 21 Sep 2021 15:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WhCxARdt+0VuGG91Is80C1i8fSQ2/1E8RokaYuG/3bY=;
        b=EkF/UZiTcxOb9BhopCFEcwzqz4XvvCN6dfXJrWGHwk4wySsZgNUbW3PA01VxCpLZWO
         WIoZtJBlZFdWsq9G1yjAtnpATeP39Xb1y7sVcAweRGEEYjXSSCT6u32NtnXw+GXsW3+4
         ajvZDpjYKaOQCMXQ7iT1PYPmqDxm26Sot74GB6mYENnPqMAIzfmWwKQ7azAIaJ12wSi0
         IJoP8biWSz0bZs+feLbuLX3tjAHhyx/CMpH/N7QmXmkVSR+CP18dWprwJu/Cr0Zz4Kd6
         oncu7y0ercBihXwDrI40LW26r/c8tlnqO+7R0A8qHcYxmV5Ojs93P08c4uFjZFNopWs4
         1hLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WhCxARdt+0VuGG91Is80C1i8fSQ2/1E8RokaYuG/3bY=;
        b=PNhDDXwTRCyDeSSdWxgvhikTKvg+2Dw0NwkxEp4Qx9AG3WkpkWmULlAp9C8/BeEt3r
         ea3bawjkWFsVWdJ5+WY/Oeii2BDNfJAS6F5/dxkmVkWamOCBNpIGxGA7K6Da1/f6h/vS
         zhrPhkZCM1mSRMhNbpZbGC4X7XqsbI+hrn8i/bzYsbdVclIXt+k3LoKdDBYzen0P3nTv
         nc3YW3J3pdUsMVnbagu0z2DLNIM53WBPW2MBh+ArXi+kThU8LY7kTOtCnAQRKz6USIGG
         uhIFcXhCFf1dzXnvjkZEpIv/wNxdb8TAQO8L99zJaJjPf4HeBe4tlEuTH14mHjFvcAVO
         MnJw==
X-Gm-Message-State: AOAM530tJ559BTVkAPzyZJcgmxi61y8VO7PirYFII7lT7SIEUnEYtB9j
        V1iVA3SSAMqMDTZd7HY5LzzVunUp+TQlsO2uxFUFyxx0
X-Google-Smtp-Source: ABdhPJy9Ou0vqrHy/ccYJ2TxK6SRdQ0/Mko4SEa+ADNh8TfaXLeijb41Gf1gAQBQriaCvwHtA16KrT+mPSUT6QxVtjA=
X-Received: by 2002:a25:1884:: with SMTP id 126mr24460137yby.114.1632261732233;
 Tue, 21 Sep 2021 15:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210920003545.3524231-1-yhs@fb.com> <20210920003555.3525533-1-yhs@fb.com>
In-Reply-To: <20210920003555.3525533-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Sep 2021 15:02:01 -0700
Message-ID: <CAEf4BzZ2kros1tWOscUOt5nmDd=GZfvtTsn7K7b==QgM-4gsKA@mail.gmail.com>
Subject: Re: [PATCH dwarves 2/2] btf_encoder: generate BTF_KIND_TAG from llvm annotations
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 19, 2021 at 5:36 PM Yonghong Song <yhs@fb.com> wrote:
>
> The following is an example with latest upstream clang:
>   $ cat t.c
>   #define __tag1 __attribute__((btf_tag("tag1")))
>   #define __tag2 __attribute__((btf_tag("tag2")))
>
>   struct t {
>           int a:1 __tag1;
>           int b __tag2;
>   } __tag1 __tag2;
>
>   int g __tag1 __attribute__((section(".data..percpu")));
>
>   int __tag1 foo(struct t *a1, int a2 __tag2) {
>     return a1->b + a2 + g;
>   }
>
>   $ clang -O2 -g -c t.c
>   $ pahole -JV t.o
>   Found per-CPU symbol 'g' at address 0x0
>   Found 1 per-CPU variables!
>   Found 1 functions!
>   File t.o:
>   [1] INT int size=4 nr_bits=32 encoding=SIGNED
>   [2] PTR (anon) type_id=3
>   [3] STRUCT t size=8
>         a type_id=1 bitfield_size=1 bits_offset=0
>         b type_id=1 bitfield_size=0 bits_offset=32
>   [4] TAG tag1 type_id=3 component_idx=0
>   [5] TAG tag2 type_id=3 component_idx=1
>   [6] TAG tag1 type_id=3 component_idx=-1
>   [7] TAG tag2 type_id=3 component_idx=-1
>   [8] FUNC_PROTO (anon) return=1 args=(2 a1, 1 a2)
>   [9] FUNC foo type_id=8
>   [10] TAG tag2 type_id=9 component_idx=1
>   [11] TAG tag1 type_id=9 component_idx=-1
>   search cu 't.c' for percpu global variables.
>   Variable 'g' from CU 't.c' at address 0x0 encoded
>   [12] VAR g type=1 linkage=1
>   [13] TAG tag1 type_id=12 component_idx=-1
>   [14] DATASEC .data..percpu size=4 vlen=1
>         type=12 offset=0 size=4
>   $ ...
>
> With additional option --skip_encoding_btf_tag, pahole doesn't
> generate BTF_KIND_TAGs any more.
>   $ pahole -JV --skip_encoding_btf_tag t.o
>   Found per-CPU symbol 'g' at address 0x0
>   Found 1 per-CPU variables!
>   Found 1 functions!
>   File t.o:
>   [1] INT int size=4 nr_bits=32 encoding=SIGNED
>   [2] PTR (anon) type_id=3
>   [3] STRUCT t size=8
>         a type_id=1 bitfield_size=1 bits_offset=0
>         b type_id=1 bitfield_size=0 bits_offset=32
>   [4] FUNC_PROTO (anon) return=1 args=(2 a1, 1 a2)
>   [5] FUNC foo type_id=4
>   search cu 't.c' for percpu global variables.
>   Variable 'g' from CU 't.c' at address 0x0 encoded
>   [6] VAR g type=1 linkage=1
>   [7] DATASEC .data..percpu size=4 vlen=1
>         type=6 offset=0 size=4
>   $ ...
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  btf_encoder.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>

[...]

> @@ -1244,6 +1266,10 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, struct
>                         goto out;
>                 }
>
> +               list_for_each_entry(annot, &var->annots, node) {
> +                       btf_encoder__add_tag(encoder, annot->value, id, annot->component_idx);

check errors?

> +               }
> +
>                 /*
>                  * add a BTF_VAR_SECINFO in encoder->percpu_secinfo, which will be added into
>                  * encoder->types later when we add BTF_VAR_DATASEC.
> @@ -1359,6 +1385,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>  int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu)
>  {
>         uint32_t type_id_off = btf__get_nr_types(encoder->btf);
> +       struct llvm_annotation *annot;
>         uint32_t core_id;
>         struct function *fn;
>         struct tag *pos;
> @@ -1396,6 +1423,20 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu)
>                 encoder->has_index_type = true;
>         }
>
> +       cu__for_each_type(cu, core_id, pos) {
> +               struct namespace *ns;
> +               int btf_type_id;
> +
> +               if (pos->tag != DW_TAG_structure_type && pos->tag != DW_TAG_union_type)
> +                       continue;
> +
> +               btf_type_id = type_id_off + core_id;
> +               ns = tag__namespace(pos);
> +               list_for_each_entry(annot, &ns->annots, node) {
> +                       btf_encoder__add_tag(encoder, annot->value, btf_type_id, annot->component_idx);

same, this can fail

> +               }
> +       }
> +
>         cu__for_each_function(cu, core_id, fn) {
>                 int btf_fnproto_id, btf_fn_id;
>                 const char *name;
> @@ -1436,6 +1477,10 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu)
>                         printf("error: failed to encode function '%s'\n", function__name(fn));
>                         goto out;
>                 }
> +
> +               list_for_each_entry(annot, &fn->annots, node) {
> +                       btf_encoder__add_tag(encoder, annot->value, btf_fn_id, annot->component_idx);

and here as well

> +               }
>         }
>
>         if (!encoder->skip_encoding_vars)
> --
> 2.30.2
>
