Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FAC52AE82
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 01:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiEQXZX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 19:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiEQXZW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 19:25:22 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1596377C2
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 16:25:18 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id z18so504459iob.5
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 16:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oIkQsv4V5fX54mMbTzTV5VsXUMi0V+Dd2bbgDbvItN4=;
        b=czqAWTP8BO3aoX3ligQ4xrRZjrip32FeyGNhkRh8ARCdUuL6CFmsUFiUSSThGcNHTw
         TIIYV3D5QB/gQYziRoYtC9nAkgk27DCFgixGUTyDiVs2O9IG06yuOgGj7SuZNruBln8y
         VnglWmoIsyY+R5YpYLfI2QOcSPLF+koBt6CPrxrC0iFo2Qkj2keyF+MUDVFCiYPuhkFO
         b/XpCVX+9gmsbIPUz4fGiirOUzmqQhIbrz1xjI5KJC0u2HJVNgUpYZd3Z9SGEbujLXoO
         x6MM/sc/jHCNbqtiAnzjgatM1GkdMmeF5u8Aos6fcwZQJnguLw53d9xgeeOA61CIqdXo
         PnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oIkQsv4V5fX54mMbTzTV5VsXUMi0V+Dd2bbgDbvItN4=;
        b=38OLwDLvPfNFFWA74MYtmtQqMH+cZ2NXOwx+LKxldCSeNvDT1Xf2v5w8B4O77zQsBt
         LXt0Rc08JlBd1SDTcY+/CYHGvDg2miWyNNi+57pghM9mA5JJk5Ete7+8RPNerb0pGPFs
         nfDpj8s4YJiYk77proAqfw7UXp+gSVuywOe0P1fhksWAoPcrwn2wJcLo0Q6jI1vCTT4P
         WVuQq9DeTQbgsbnnMHu5Z9EBXptKadRgqR9Q0+PXPAl81a83f5in6PvIX49ekIj/N9Jh
         /DR/ypmRRLKG1GR/ne0KBog0AIv5sJVKeTP9nINcRGD3Dz3U3jKCVYxqwvRRaibSXpFU
         UesQ==
X-Gm-Message-State: AOAM533oHAlXc+wbmbZusjoNVoeDiivzRzaYQ8vH5CGwZl0wj30jCsu8
        lDlL4HiSf+O5b86ZSvaH0kyrlKPGo3BPaKmtBlA=
X-Google-Smtp-Source: ABdhPJxrdIZGs5SeS3OADec9o+Gi7S3GDQd54HKsf3kWwfUeC/WFFkuS8Ty+5yXF3iJNWfRXk75HVy/oHqtPcDDn8AA=
X-Received: by 2002:a05:6638:450a:b0:32e:1bd1:735f with SMTP id
 bs10-20020a056638450a00b0032e1bd1735fmr8806202jab.145.1652829917924; Tue, 17
 May 2022 16:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220514031221.3240268-1-yhs@fb.com> <20220514031303.3243922-1-yhs@fb.com>
In-Reply-To: <20220514031303.3243922-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 17 May 2022 16:25:07 -0700
Message-ID: <CAEf4BzaAXz-DxvrjB94vs7Zv_y15-2kbF5528aPvpCru_f7=Aw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 08/18] libbpf: Add enum64 sanitization
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
> When old kernel does not support enum64 but user space btf
> contains non-zero enum kflag or enum64, libbpf needs to
> do proper sanitization so modified btf can be accepted
> by the kernel.
>
> Sanitization for enum kflag can be achieved by clearing
> the kflag bit. For enum64, the type is replaced with an
> union of integer member types and the integer member size
> must be smaller than enum64 size. If such an integer
> type cannot be found, a new type is created and used
> for union members.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/lib/bpf/btf.h             |  3 +-
>  tools/lib/bpf/libbpf.c          | 53 +++++++++++++++++++++++++++++++--
>  tools/lib/bpf/libbpf_internal.h |  2 ++
>  3 files changed, 55 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 7da6970b8c9f..d4fe1300ed33 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -395,9 +395,10 @@ btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
>  #ifndef BTF_KIND_FLOAT
>  #define BTF_KIND_FLOAT         16      /* Floating point       */
>  #endif
> -/* The kernel header switched to enums, so these two were never #defined */
> +/* The kernel header switched to enums, so the following were never #defined */
>  #define BTF_KIND_DECL_TAG      17      /* Decl Tag */
>  #define BTF_KIND_TYPE_TAG      18      /* Type Tag */
> +#define BTF_KIND_ENUM64                19      /* Enum for up-to 64bit values */
>
>  static inline __u16 btf_kind(const struct btf_type *t)
>  {
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 4867a930628b..f54e70b9953d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2114,6 +2114,7 @@ static const char *__btf_kind_str(__u16 kind)
>         case BTF_KIND_FLOAT: return "float";
>         case BTF_KIND_DECL_TAG: return "decl_tag";
>         case BTF_KIND_TYPE_TAG: return "type_tag";
> +       case BTF_KIND_ENUM64: return "enum64";
>         default: return "unknown";
>         }
>  }
> @@ -2642,9 +2643,10 @@ static bool btf_needs_sanitization(struct bpf_object *obj)
>         bool has_func = kernel_supports(obj, FEAT_BTF_FUNC);
>         bool has_decl_tag = kernel_supports(obj, FEAT_BTF_DECL_TAG);
>         bool has_type_tag = kernel_supports(obj, FEAT_BTF_TYPE_TAG);
> +       bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
>
>         return !has_func || !has_datasec || !has_func_global || !has_float ||
> -              !has_decl_tag || !has_type_tag;
> +              !has_decl_tag || !has_type_tag || !has_enum64;
>  }
>
>  static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
> @@ -2655,9 +2657,25 @@ static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
>         bool has_func = kernel_supports(obj, FEAT_BTF_FUNC);
>         bool has_decl_tag = kernel_supports(obj, FEAT_BTF_DECL_TAG);
>         bool has_type_tag = kernel_supports(obj, FEAT_BTF_TYPE_TAG);
> +       bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
> +       int min_int_size = 32, min_enum64_size = 32, min_int_tid = 0;
>         struct btf_type *t;
>         int i, j, vlen;
>
> +       if (!has_enum64) {
> +               for (i = 1; i < btf__type_cnt(btf); i++) {
> +                       t = (struct btf_type *)btf__type_by_id(btf, i);
> +                       if (btf_is_int(t) && t->size < min_int_size) {
> +                               min_int_size = t->size;
> +                               min_int_tid = i;
> +                       } else if (btf_is_enum64(t) && t->size < min_enum64_size) {
> +                               min_enum64_size = t->size;
> +                       }
> +               }
> +               if (min_int_size > min_enum64_size)
> +                       min_int_tid = btf__add_int(btf, "char", 1,  BTF_INT_SIGNED);
> +       }
> +

we do this search even if bpf_object's BTF doesn't have enum64, which
seems overly pessimistic. How about we just lazily (but
unconditionally) add new BTF_KIND_INT on first encountered enum64 and
remember it's id (see below)

>         for (i = 1; i < btf__type_cnt(btf); i++) {
>                 t = (struct btf_type *)btf__type_by_id(btf, i);
>
> @@ -2717,7 +2735,20 @@ static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
>                         /* replace TYPE_TAG with a CONST */
>                         t->name_off = 0;
>                         t->info = BTF_INFO_ENC(BTF_KIND_CONST, 0, 0);
> -               }
> +               } else if (!has_enum64 && btf_is_enum(t)) {
> +                       /* clear the kflag */
> +                       t->info = btf_type_info(btf_kind(t), btf_vlen(t), false);
> +               } else if (!has_enum64 && btf_is_enum64(t)) {
> +                       /* replace ENUM64 with a union */
> +                       struct btf_member *m = btf_members(t);
> +

so here we just

if (enum64_placeholder_id == 0) {
    enum64_placeholder_id = btf__add_int(btf, "enum64_placeholder", t->size, 0);
    if (enum64_placeholder_id < 0) /* pr_warn and exit with error */
}

and then just use enum64_placeholder_id for each field type?

It seems much simpler than trying to find matching int (especially
given potentially non-8-byte size), so it seems better to just add our
own type.

Please make sure to re-initialize t and m after that because
btf__add_int() invalidates underlying memory, so you need to re-fetch
btf__type_by_id().

> +                       vlen = btf_vlen(t);
> +                       t->info = BTF_INFO_ENC(BTF_KIND_UNION, 0, vlen);
> +                       for (j = 0; j < vlen; j++, m++) {
> +                               m->type = min_int_tid;
> +                               m->offset = 0;
> +                       }
> +                }
>         }
>  }
>
> @@ -3563,6 +3594,10 @@ static enum kcfg_type find_kcfg_type(const struct btf *btf, int id,
>                 if (strcmp(name, "libbpf_tristate"))
>                         return KCFG_UNKNOWN;
>                 return KCFG_TRISTATE;
> +       case BTF_KIND_ENUM64:
> +               if (strcmp(name, "libbpf_tristate"))
> +                       return KCFG_UNKNOWN;
> +               return KCFG_TRISTATE;
>         case BTF_KIND_ARRAY:
>                 if (btf_array(t)->nelems == 0)
>                         return KCFG_UNKNOWN;
> @@ -4746,6 +4781,17 @@ static int probe_kern_bpf_cookie(void)
>         return probe_fd(ret);
>  }
>
> +static int probe_kern_btf_enum64(void)
> +{
> +       static const char strs[] = "\0enum64";
> +       __u32 types[] = {
> +               BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 0), 8),
> +       };
> +
> +       return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
> +                                            strs, sizeof(strs)));
> +}
> +
>  enum kern_feature_result {
>         FEAT_UNKNOWN = 0,
>         FEAT_SUPPORTED = 1,
> @@ -4811,6 +4857,9 @@ static struct kern_feature_desc {
>         [FEAT_BPF_COOKIE] = {
>                 "BPF cookie support", probe_kern_bpf_cookie,
>         },
> +       [FEAT_BTF_ENUM64] = {
> +               "BTF_KIND_ENUM64 support", probe_kern_btf_enum64,
> +       },
>  };
>
>  bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index 4abdbe2fea9d..10c16acfa8ae 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -351,6 +351,8 @@ enum kern_feature_id {
>         FEAT_MEMCG_ACCOUNT,
>         /* BPF cookie (bpf_get_attach_cookie() BPF helper) support */
>         FEAT_BPF_COOKIE,
> +       /* BTF_KIND_ENUM64 support and BTF_KIND_ENUM kflag support */
> +       FEAT_BTF_ENUM64,
>         __FEAT_CNT,
>  };
>
> --
> 2.30.2
>
