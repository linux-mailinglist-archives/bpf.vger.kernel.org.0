Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1432A52AEB6
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 01:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiEQXiV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 19:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiEQXiU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 19:38:20 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32753527DF
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 16:38:19 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id a10so511000ioe.9
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 16:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wiw3WO8x8zxnY1TW5c7zBMjLoNOqIGACb7hWnzednpA=;
        b=QNNd2z95cdFl3TqbmhzGTvl8/Z63N/rDipkf/DN/Tf7c82+19ZgBBlxpI4jnr2YxwE
         kiCQBvTLLtrgh9DbqxMrSCEX/6h40IwQpx9u9HdQB1bgJldEYK7Z8moMp/PCPjv3JmIN
         AFcxxnQR03o47/pFyUGZowoqlq2uFTcGyhnlU78rZdADONxUxu9DGzySXq5bDWtAXCTX
         fi4s3TbvWX7P8UDRX9MshWjxt37X8Uuvx7XjG6rbRnlX74YqdA3e2PjQ102CyjBqPDtO
         8noMeEbuSVeyiV2oQ4xtjJI/sJ4mZnW6/BMSbTLvRGLqYFKAe79eX+9AEl93Clg99idw
         0Tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wiw3WO8x8zxnY1TW5c7zBMjLoNOqIGACb7hWnzednpA=;
        b=mwb+3r79S0dGcOV2xy8k8I+n5tgIDfIoYokZPCUepvM94EztHZyTBc3iFWs/ovDK5M
         sUh8SXr4x7iSS5Z+S003eAc+LZWPrG9Kh6rZzQK6pfy0QaOthx3dtwrVWTPgC8Eryf2y
         N2tMyYarHXQGr9QgsjKwDE4sC+Gyq30mclSyf5c6C/VV6A3NdIqSs1duaW6Wbitntt+d
         ns6FL2m7z0ijSKftQNDYRFGN3thttQd0fiScj0v+72m6FifkCaQ2UvQ5Sw/sJCVopy/W
         tgpN/GxhzdQWkH2G47yql2asdYN3YNsbYgbF9AtntPdIYTkPMkgBkrvJkjss4eSKTJhX
         pA+Q==
X-Gm-Message-State: AOAM53218clZJCWTPOyW0g/bIoAnNEjcbfR1G2dQlGwRsFFLfPWrwXbQ
        QiRFgtw1NxWfqK35RnWbAuwsQv4XYSB1A+7FnfRQOGS3
X-Google-Smtp-Source: ABdhPJyJuCVBXbXA949L0nPiDJMXmy9xfCqnl7mXwK7I/+CgQiFsceRhvxox9vOoAMuHfCFOEFWZ0VvR3T97nAJ0kmk=
X-Received: by 2002:a05:6638:2393:b0:32e:319d:c7cc with SMTP id
 q19-20020a056638239300b0032e319dc7ccmr6777210jat.103.1652830698558; Tue, 17
 May 2022 16:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220514031221.3240268-1-yhs@fb.com> <20220514031319.3245326-1-yhs@fb.com>
In-Reply-To: <20220514031319.3245326-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 17 May 2022 16:38:07 -0700
Message-ID: <CAEf4BzZcPVsKzx+abjJruRAeg++iod6YnTfBWGhUkyit6VsGPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 11/18] bpftool: Add btf enum64 support
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
> Add BTF_KIND_ENUM64 support.
> For example, the following enum is defined in uapi bpf.h.
>   $ cat core.c
>   enum A {
>         BPF_F_INDEX_MASK                = 0xffffffffULL,
>         BPF_F_CURRENT_CPU               = BPF_F_INDEX_MASK,
>         BPF_F_CTXLEN_MASK               = (0xfffffULL << 32),
>   } g;
> Compiled with
>   clang -target bpf -O2 -g -c core.c
> Using bpftool to dump types and generate format C file:
>   $ bpftool btf dump file core.o
>   ...
>   [1] ENUM64 'A' size=8 vlen=3
>         'BPF_F_INDEX_MASK' val=4294967295ULL
>         'BPF_F_CURRENT_CPU' val=4294967295ULL
>         'BPF_F_CTXLEN_MASK' val=4503595332403200ULL
>   $ bpftool btf dump file core.o format c
>   ...
>   enum A {
>         BPF_F_INDEX_MASK = 4294967295ULL,
>         BPF_F_CURRENT_CPU = 4294967295ULL,
>         BPF_F_CTXLEN_MASK = 4503595332403200ULL,
>   };
>   ...
>
> The 64bit value is represented properly in BTF and C dump.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/bpf/bpftool/btf.c        | 49 ++++++++++++++++++++++++++++++++--
>  tools/bpf/bpftool/btf_dumper.c | 29 ++++++++++++++++++++
>  tools/bpf/bpftool/gen.c        |  1 +
>  3 files changed, 77 insertions(+), 2 deletions(-)
>
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index a2c665beda87..9e5db870fe53 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -40,6 +40,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
>         [BTF_KIND_FLOAT]        = "FLOAT",
>         [BTF_KIND_DECL_TAG]     = "DECL_TAG",
>         [BTF_KIND_TYPE_TAG]     = "TYPE_TAG",
> +       [BTF_KIND_ENUM64]       = "ENUM64",
>  };
>
>  struct btf_attach_point {
> @@ -228,10 +229,54 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
>                         if (json_output) {
>                                 jsonw_start_object(w);
>                                 jsonw_string_field(w, "name", name);
> -                               jsonw_uint_field(w, "val", v->val);
> +                               if (btf_kflag(t))
> +                                       jsonw_int_field(w, "val", v->val);
> +                               else
> +                                       jsonw_uint_field(w, "val", v->val);
>                                 jsonw_end_object(w);
>                         } else {
> -                               printf("\n\t'%s' val=%u", name, v->val);
> +                               if (btf_kflag(t))
> +                                       printf("\n\t'%s' val=%d", name, v->val);
> +                               else
> +                                       printf("\n\t'%s' val=%u", name, v->val);
> +                       }
> +               }
> +               if (json_output)
> +                       jsonw_end_array(w);
> +               break;
> +       }
> +       case BTF_KIND_ENUM64: {
> +               const struct btf_enum64 *v = btf_enum64(t);
> +               __u16 vlen = btf_vlen(t);
> +               int i;
> +
> +               if (json_output) {
> +                       jsonw_uint_field(w, "size", t->size);
> +                       jsonw_uint_field(w, "vlen", vlen);
> +                       jsonw_name(w, "values");
> +                       jsonw_start_array(w);
> +               } else {
> +                       printf(" size=%u vlen=%u", t->size, vlen);
> +               }
> +               for (i = 0; i < vlen; i++, v++) {
> +                       const char *name = btf_str(btf, v->name_off);
> +                       __u64 val = ((__u64)v->val_hi32 << 32) | v->val_lo32;
> +
> +                       if (json_output) {
> +                               jsonw_start_object(w);
> +                               jsonw_string_field(w, "name", name);

forgot emitting kflag itself (both in bpftool and in selftests), let's
add that for both enum and enum64?

> +                               if (btf_kflag(t))
> +                                       jsonw_int_field(w, "val", val);
> +                               else
> +                                       jsonw_uint_field(w, "val", val);
> +                               jsonw_end_object(w);
> +                       } else {
> +                               if (btf_kflag(t))
> +                                       printf("\n\t'%s' val=%lldLL", name,
> +                                              (unsigned long long)val);
> +                               else
> +                                       printf("\n\t'%s' val=%lluULL", name,
> +                                              (unsigned long long)val);
>                         }
>                 }
>                 if (json_output)

[...]
