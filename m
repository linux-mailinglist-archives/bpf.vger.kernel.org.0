Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C4E61DF31
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 23:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiKEWyZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Nov 2022 18:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKEWyY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Nov 2022 18:54:24 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1387BCBF
        for <bpf@vger.kernel.org>; Sat,  5 Nov 2022 15:54:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id kt23so21611210ejc.7
        for <bpf@vger.kernel.org>; Sat, 05 Nov 2022 15:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=emvdjz3s0Ywp9ld1c57Qurqv5hyD4Ww5fxdpB9K8ENc=;
        b=UcUvqNqq4/Cpbs3fB5gkOJ4Vvtgx14gLLQaVrJRf/bi2rHWjx+7VYEjX7ftZu9uslc
         qwPQqi4vR9oSfxFCCslcjhRh3hPenG1Yp1DtYd0KjFuGUxGcjt8Hs5fyZCgr8sEVI5hn
         PP+EtHreb4PCJa23rmOE8uclJXUxu48z+cwhW6Gh6RRokud6zqWNesUMd0lyX6QnYFiL
         vrpxQUydkw4SmeKYvZaw/fz31zJtHAkhLKS1ZAKD9CBwsbWvQgspq1odWd6BU95GxqFF
         unb7AuiGm7wlU8IhwWADzLrs5gZjHHChlldr6SmQxSIjePUb9BfbE5wm2vLypk5vYRnG
         YKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emvdjz3s0Ywp9ld1c57Qurqv5hyD4Ww5fxdpB9K8ENc=;
        b=RapBp92wRYNvmXDULBxp/8xknR1rnhSAEIFxcEW3AIx+JVPBixnAsMsPdsopYHbm9v
         9VrbAWz9ekJPpExXFlKYN1pCfaCe15NtxOHMlpjANyR4ZlgHKbEMAIOb1uuxxDHIzk/8
         KFWpe9oCfMHt8WKQZC6l9Sk1gYnsnhWZL+YTEqNWxHlkbuQQCg7afpPJfkpCv0kn9KIc
         Y5KOSVP8J2GnOjOabeQeXCMdS+DpyTmEd9HoBzw+A7bm8Us61pDcWgRCK3k0oo1Ulj6o
         aGsYUOK7r/cjE4MgQsl9qiQvfIrWO3zaOadjYLQTDBVAdGjkkpKRj1/vzbvPws6JGZPS
         3oww==
X-Gm-Message-State: ACrzQf3NKkQRsBwE9TpynIFQOS7PO2IzE5uSQ0Y7GuCMV2vWH+6O0x9T
        GDHd6bb9ReV1N+SrVZXuwcNCma3/k5KA/KY1e3OF3AGC
X-Google-Smtp-Source: AMsMyM4t43jpJPMDUEY8YfPOTx03ywnPHqVrA61zDKbJ7EL/eZGFPIzk6TWWjGFpLpfv5Oaf3V2GWQKvX4KhIXNggPc=
X-Received: by 2002:a17:906:fe45:b0:788:15a5:7495 with SMTP id
 wz5-20020a170906fe4500b0078815a57495mr41385631ejb.633.1667688861148; Sat, 05
 Nov 2022 15:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <1667577487-9162-1-git-send-email-alan.maguire@oracle.com> <1667577487-9162-2-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1667577487-9162-2-git-send-email-alan.maguire@oracle.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 5 Nov 2022 15:54:09 -0700
Message-ID: <CAADnVQJ-WXrTj86Qd4PHMFo+fyyn+qWCLMVOHR+upj=fog7zNg@mail.gmail.com>
Subject: Re: [RFC bpf-next 1/2] bpf: support standalone BTF in modules
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        bpf <bpf@vger.kernel.org>
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

On Fri, Nov 4, 2022 at 8:58 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> Not all kernel modules can be built in-tree when the core
> kernel is built. This presents a problem for split BTF, because
> split module BTF refers to type ids in the base kernel BTF, and
> if that base kernel BTF changes (even in minor ways) those
> references become invalid.  Such modules then cannot take
> advantage of BTF (or at least they only can until the kernel
> changes enough to invalidate their vmlinux type id references).
> This problem has been discussed before, and the initial approach
> was to allow BTF mismatch but fail to load BTF.  See [1]
> for more discussion.
>
> Generating standalone BTF for modules helps solve this problem
> because the BTF generated is self-referential only.  However,
> tooling is geared towards split BTF - for example bpftool assumes
> a module's BTF is defined relative to vmlinux BTF.  To handle
> this, dynamic remapping of standalone BTF is done on module
> load to make it appear like split BTF - type ids and string
> offsets are remapped such that they appear as they would in
> split BTF.  It just so happens that the BTF is self-referential.
> With this approach, existing tooling works with standalone
> module BTF from /sys/kernel/btf in the same way as before;
> no knowledge of split versus standalone BTF is required.
>
> Currently, the approach taken is to assume that the BTF
> associated with a module is split BTF.  If however the
> checking of types fails, we fall back to interpreting it as
> standalone BTF and carrying out remapping.  As discussed in [1]
> there are some heuristics we could use to identify standalone
> versus split module BTF, but for now the simplistic fallback
> method is used.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>
> [1] https://lore.kernel.org/bpf/YfK18x%2FXrYL4Vw8o@syu-laptop/
> ---
>  kernel/bpf/btf.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 132 insertions(+)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 5579ff3..5efdcaf 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5315,11 +5315,120 @@ struct btf *btf_parse_vmlinux(void)
>
>  #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>
> +static u32 btf_name_off_renumber(struct btf *btf, u32 name_off)
> +{
> +       return name_off + btf->start_str_off;
> +}
> +
> +static u32 btf_id_renumber(struct btf *btf, u32 id)
> +{
> +       /* no need to renumber void */
> +       if (id == 0)
> +               return id;
> +       return id + btf->start_id - 1;
> +}
> +
> +/* Renumber standalone BTF to appear as split BTF; name offsets must
> + * be relative to btf->start_str_offset and ids relative to btf->start_id.
> + * When user sees BTF it will appear as normal module split BTF, the only
> + * difference being it is fully self-referential and does not refer back
> + * to vmlinux BTF (aside from 0 "void" references).
> + */
> +static void btf_type_renumber(struct btf_verifier_env *env, struct btf_type *t)
> +{
> +       struct btf_var_secinfo *secinfo;
> +       struct btf *btf = env->btf;
> +       struct btf_member *member;
> +       struct btf_param *param;
> +       struct btf_array *array;
> +       struct btf_enum64 *e64;
> +       struct btf_enum *e;
> +       int i;
> +
> +       t->name_off = btf_name_off_renumber(btf, t->name_off);
> +
> +       switch (BTF_INFO_KIND(t->info)) {
> +       case BTF_KIND_INT:
> +       case BTF_KIND_FLOAT:
> +       case BTF_KIND_TYPE_TAG:
> +               /* nothing to renumber here, no type references */
> +               break;
> +       case BTF_KIND_PTR:
> +       case BTF_KIND_FWD:
> +       case BTF_KIND_TYPEDEF:
> +       case BTF_KIND_VOLATILE:
> +       case BTF_KIND_CONST:
> +       case BTF_KIND_RESTRICT:
> +       case BTF_KIND_FUNC:
> +       case BTF_KIND_VAR:
> +       case BTF_KIND_DECL_TAG:
> +               /* renumber the referenced type */
> +               t->type = btf_id_renumber(btf, t->type);
> +               break;
> +       case BTF_KIND_ARRAY:
> +               array = btf_array(t);
> +               array->type = btf_id_renumber(btf, array->type);
> +               array->index_type = btf_id_renumber(btf, array->index_type);
> +               break;
> +       case BTF_KIND_STRUCT:
> +       case BTF_KIND_UNION:
> +               member = (struct btf_member *)(t + 1);
> +               for (i = 0; i < btf_type_vlen(t); i++) {
> +                       member->type = btf_id_renumber(btf, member->type);
> +                       member->name_off = btf_name_off_renumber(btf, member->name_off);
> +                       member++;
> +               }
> +               break;
> +       case BTF_KIND_FUNC_PROTO:
> +               param = (struct btf_param *)(t + 1);
> +               for (i = 0; i < btf_type_vlen(t); i++) {
> +                       param->type = btf_id_renumber(btf, param->type);
> +                       param->name_off = btf_name_off_renumber(btf, param->name_off);
> +                       param++;
> +               }
> +               break;
> +       case BTF_KIND_DATASEC:
> +               secinfo = (struct btf_var_secinfo *)(t + 1);
> +               for (i = 0; i < btf_type_vlen(t); i++) {
> +                       secinfo->type = btf_id_renumber(btf, secinfo->type);
> +                       secinfo++;
> +               }
> +               break;
> +       case BTF_KIND_ENUM:
> +               e = (struct btf_enum *)(t + 1);
> +               for (i = 0; i < btf_type_vlen(t); i++) {
> +                       e->name_off = btf_name_off_renumber(btf, e->name_off);
> +                       e++;
> +               }
> +               break;
> +       case BTF_KIND_ENUM64:
> +               e64 = (struct btf_enum64 *)(t + 1);
> +               for (i = 0; i < btf_type_vlen(t); i++) {
> +                       e64->name_off = btf_name_off_renumber(btf, e64->name_off);
> +                       e64++;
> +               }
> +               break;
> +       }
> +}
> +
> +static void btf_renumber(struct btf_verifier_env *env, struct btf *base_btf)
> +{
> +       struct btf *btf = env->btf;
> +       int i;
> +
> +       btf->start_id = base_btf->nr_types;
> +       btf->start_str_off = base_btf->hdr.str_len;
> +
> +       for (i = 0; i < btf->nr_types; i++)
> +               btf_type_renumber(env, btf->types[i]);
> +}
> +
>  static struct btf *btf_parse_module(const char *module_name, const void *data, unsigned int data_size)
>  {
>         struct btf_verifier_env *env = NULL;
>         struct bpf_verifier_log *log;
>         struct btf *btf = NULL, *base_btf;
> +       bool standalone = false;
>         int err;
>
>         base_btf = bpf_get_btf_vmlinux();
> @@ -5367,9 +5476,32 @@ static struct btf *btf_parse_module(const char *module_name, const void *data, u
>                 goto errout;
>
>         err = btf_check_all_metas(env);
> +       if (err) {
> +               /* BTF may be standalone; in that case meta checks will
> +                * fail and we fall back to standalone BTF processing.
> +                * Later on, once we have checked all metas, we will
> +                * retain start id from  base BTF so it will look like
> +                * split BTF (but is self-contained); renumbering is done
> +                * also to give the split BTF-like appearance and not
> +                * confuse pahole which assumes split BTF for modules.
> +                */
> +               btf->base_btf = NULL;
> +               if (btf->types)
> +                       kvfree(btf->types);
> +               btf->types = NULL;
> +               btf->types_size = 0;
> +               btf->start_id = 0;
> +               btf->nr_types = 0;
> +               btf->start_str_off = 0;
> +               standalone = true;
> +               err = btf_check_all_metas(env);
> +       }

Interesting idea!
Instead of failing the first time, how about we make
such standalone module BTFs explicit?
Some flag or special type?
Then the kernel just checks that and renumbers right away.

And combining this with what we discussed in the other thread
to load vmlinux's BTF through the module...
We'd need two flags in BTF to address both cases.
One to load base vmlinux BTF from a module and
another to load standalone module BTF.
Maybe add another BTF_KIND and it will be first in all types ?
Or use DATASEC with a special name ?
