Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD6C6236BC
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 23:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiKIWnW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 17:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiKIWnS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 17:43:18 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31C72FC30
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 14:43:13 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id m22so560071eji.10
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 14:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=trrj9G/34+zXwU6+GfP7J/ph16g8YC6mWnlKqg/4d6E=;
        b=fkvHbYjA2E1lgMsb00V66gC+XvKZ5FlcQD++bklAdoj2+9v++tf8hlTuDkcYjfa/87
         xVwp24HASnRy/Ibgh2i8lpqsXsjXfqtI1GAzRhpYaBhHWf+0bl/25GaYHvjsKrmMCp8F
         y7Id8qQF3jZZhHwZpZj/F0gRzmWTpfx+HYLzzFRWhJRLj4j637mN+sURqqNB6+1aF2xV
         yOGt89pdV7Py5injRrf7otVb0Tf+47XwSzvrY0lmlaqbj9mz0LT609IWF1E0CIPMP4+b
         i5J1Ift4X0vQU2gICFu7Lx7an+T5nr/dFlVE5knc70LwA331R87B+AgU0jh+q9fQMO8b
         6wsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trrj9G/34+zXwU6+GfP7J/ph16g8YC6mWnlKqg/4d6E=;
        b=P8iySui27owpRNibzaWjy9hm6bxUMekWjtPprVESsHBv3uNDXDAFr4VGVeS6g7ihRx
         Preiu8GDeOT65i5eRIEzhurWpEbFHQKnA9+goifcfQvQnHS2UCmJ3O/qeTnfigprwBZS
         aJXpIy80uGB1ONIiQOnNecT9pz5LrjZcZZoQt/ullgyyblnalpxVmwvU0+LR425avd/X
         Gai/P6Y79NDklRLHvkvSlOnJ570evQ6QEuDLva94+df8zIHZ8aQIh+cG510fZJ8wXJuN
         VGbiTsINcvpIU0KYs59ar7Jb+2Fqudpx50apmnuoTeUPU65aROAcjr1RzZgbUeyJBAsL
         N5sw==
X-Gm-Message-State: ACrzQf2NPOlzJ4L2rIIb0r85vRjkzSgwDDX/7AFn/Rb8JRGF2q35g0Za
        iY7FKR1JZTVkvLo6jrOZq7yKGgglfDD8PLXphvF8PDE65N4=
X-Google-Smtp-Source: AMsMyM44l6qNPlxIYC/4bo5Et+B0OiiKgEOCLTwmXMRENE4AuPI7lvkwoT9jI2SNZOfIgF3BKf11EgjSzxa6HJuWVz0=
X-Received: by 2002:a17:906:b050:b0:78d:99ee:4e68 with SMTP id
 bj16-20020a170906b05000b0078d99ee4e68mr1858293ejb.302.1668033792241; Wed, 09
 Nov 2022 14:43:12 -0800 (PST)
MIME-Version: 1.0
References: <1667577487-9162-1-git-send-email-alan.maguire@oracle.com>
 <1667577487-9162-2-git-send-email-alan.maguire@oracle.com>
 <CAADnVQJ-WXrTj86Qd4PHMFo+fyyn+qWCLMVOHR+upj=fog7zNg@mail.gmail.com> <1b17769a-7e22-b8ce-afaf-70314cc31f4f@oracle.com>
In-Reply-To: <1b17769a-7e22-b8ce-afaf-70314cc31f4f@oracle.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 9 Nov 2022 14:43:00 -0800
Message-ID: <CAEf4BzYoG9RSMdEFZKp8JG+cXBxJEygd0tAtOn-hvjoFFDWfTA@mail.gmail.com>
Subject: Re: [RFC bpf-next 1/2] bpf: support standalone BTF in modules
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
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

On Mon, Nov 7, 2022 at 8:37 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On 05/11/2022 22:54, Alexei Starovoitov wrote:
> > On Fri, Nov 4, 2022 at 8:58 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >>
> >> Not all kernel modules can be built in-tree when the core
> >> kernel is built. This presents a problem for split BTF, because
> >> split module BTF refers to type ids in the base kernel BTF, and
> >> if that base kernel BTF changes (even in minor ways) those
> >> references become invalid.  Such modules then cannot take
> >> advantage of BTF (or at least they only can until the kernel
> >> changes enough to invalidate their vmlinux type id references).
> >> This problem has been discussed before, and the initial approach
> >> was to allow BTF mismatch but fail to load BTF.  See [1]
> >> for more discussion.
> >>
> >> Generating standalone BTF for modules helps solve this problem
> >> because the BTF generated is self-referential only.  However,
> >> tooling is geared towards split BTF - for example bpftool assumes
> >> a module's BTF is defined relative to vmlinux BTF.  To handle
> >> this, dynamic remapping of standalone BTF is done on module
> >> load to make it appear like split BTF - type ids and string
> >> offsets are remapped such that they appear as they would in
> >> split BTF.  It just so happens that the BTF is self-referential.
> >> With this approach, existing tooling works with standalone
> >> module BTF from /sys/kernel/btf in the same way as before;
> >> no knowledge of split versus standalone BTF is required.
> >>
> >> Currently, the approach taken is to assume that the BTF
> >> associated with a module is split BTF.  If however the
> >> checking of types fails, we fall back to interpreting it as
> >> standalone BTF and carrying out remapping.  As discussed in [1]
> >> there are some heuristics we could use to identify standalone
> >> versus split module BTF, but for now the simplistic fallback
> >> method is used.
> >>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >>
> >> [1] https://lore.kernel.org/bpf/YfK18x%2FXrYL4Vw8o@syu-laptop/
> >> ---
> >>  kernel/bpf/btf.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 132 insertions(+)
> >>
> >> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> >> index 5579ff3..5efdcaf 100644
> >> --- a/kernel/bpf/btf.c
> >> +++ b/kernel/bpf/btf.c
> >> @@ -5315,11 +5315,120 @@ struct btf *btf_parse_vmlinux(void)
> >>
> >>  #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> >>
> >> +static u32 btf_name_off_renumber(struct btf *btf, u32 name_off)
> >> +{
> >> +       return name_off + btf->start_str_off;
> >> +}
> >> +
> >> +static u32 btf_id_renumber(struct btf *btf, u32 id)
> >> +{
> >> +       /* no need to renumber void */
> >> +       if (id == 0)
> >> +               return id;
> >> +       return id + btf->start_id - 1;
> >> +}
> >> +
> >> +/* Renumber standalone BTF to appear as split BTF; name offsets must
> >> + * be relative to btf->start_str_offset and ids relative to btf->start_id.
> >> + * When user sees BTF it will appear as normal module split BTF, the only
> >> + * difference being it is fully self-referential and does not refer back
> >> + * to vmlinux BTF (aside from 0 "void" references).
> >> + */
> >> +static void btf_type_renumber(struct btf_verifier_env *env, struct btf_type *t)
> >> +{
> >> +       struct btf_var_secinfo *secinfo;
> >> +       struct btf *btf = env->btf;
> >> +       struct btf_member *member;
> >> +       struct btf_param *param;
> >> +       struct btf_array *array;
> >> +       struct btf_enum64 *e64;
> >> +       struct btf_enum *e;
> >> +       int i;
> >> +
> >> +       t->name_off = btf_name_off_renumber(btf, t->name_off);
> >> +
> >> +       switch (BTF_INFO_KIND(t->info)) {
> >> +       case BTF_KIND_INT:
> >> +       case BTF_KIND_FLOAT:
> >> +       case BTF_KIND_TYPE_TAG:
> >> +               /* nothing to renumber here, no type references */
> >> +               break;
> >> +       case BTF_KIND_PTR:
> >> +       case BTF_KIND_FWD:
> >> +       case BTF_KIND_TYPEDEF:
> >> +       case BTF_KIND_VOLATILE:
> >> +       case BTF_KIND_CONST:
> >> +       case BTF_KIND_RESTRICT:
> >> +       case BTF_KIND_FUNC:
> >> +       case BTF_KIND_VAR:
> >> +       case BTF_KIND_DECL_TAG:
> >> +               /* renumber the referenced type */
> >> +               t->type = btf_id_renumber(btf, t->type);
> >> +               break;
> >> +       case BTF_KIND_ARRAY:
> >> +               array = btf_array(t);
> >> +               array->type = btf_id_renumber(btf, array->type);
> >> +               array->index_type = btf_id_renumber(btf, array->index_type);
> >> +               break;
> >> +       case BTF_KIND_STRUCT:
> >> +       case BTF_KIND_UNION:
> >> +               member = (struct btf_member *)(t + 1);
> >> +               for (i = 0; i < btf_type_vlen(t); i++) {
> >> +                       member->type = btf_id_renumber(btf, member->type);
> >> +                       member->name_off = btf_name_off_renumber(btf, member->name_off);
> >> +                       member++;
> >> +               }
> >> +               break;
> >> +       case BTF_KIND_FUNC_PROTO:
> >> +               param = (struct btf_param *)(t + 1);
> >> +               for (i = 0; i < btf_type_vlen(t); i++) {
> >> +                       param->type = btf_id_renumber(btf, param->type);
> >> +                       param->name_off = btf_name_off_renumber(btf, param->name_off);
> >> +                       param++;
> >> +               }
> >> +               break;
> >> +       case BTF_KIND_DATASEC:
> >> +               secinfo = (struct btf_var_secinfo *)(t + 1);
> >> +               for (i = 0; i < btf_type_vlen(t); i++) {
> >> +                       secinfo->type = btf_id_renumber(btf, secinfo->type);
> >> +                       secinfo++;
> >> +               }
> >> +               break;
> >> +       case BTF_KIND_ENUM:
> >> +               e = (struct btf_enum *)(t + 1);
> >> +               for (i = 0; i < btf_type_vlen(t); i++) {
> >> +                       e->name_off = btf_name_off_renumber(btf, e->name_off);
> >> +                       e++;
> >> +               }
> >> +               break;
> >> +       case BTF_KIND_ENUM64:
> >> +               e64 = (struct btf_enum64 *)(t + 1);
> >> +               for (i = 0; i < btf_type_vlen(t); i++) {
> >> +                       e64->name_off = btf_name_off_renumber(btf, e64->name_off);
> >> +                       e64++;
> >> +               }
> >> +               break;
> >> +       }
> >> +}
> >> +
> >> +static void btf_renumber(struct btf_verifier_env *env, struct btf *base_btf)
> >> +{
> >> +       struct btf *btf = env->btf;
> >> +       int i;
> >> +
> >> +       btf->start_id = base_btf->nr_types;
> >> +       btf->start_str_off = base_btf->hdr.str_len;
> >> +
> >> +       for (i = 0; i < btf->nr_types; i++)
> >> +               btf_type_renumber(env, btf->types[i]);
> >> +}
> >> +
> >>  static struct btf *btf_parse_module(const char *module_name, const void *data, unsigned int data_size)
> >>  {
> >>         struct btf_verifier_env *env = NULL;
> >>         struct bpf_verifier_log *log;
> >>         struct btf *btf = NULL, *base_btf;
> >> +       bool standalone = false;
> >>         int err;
> >>
> >>         base_btf = bpf_get_btf_vmlinux();
> >> @@ -5367,9 +5476,32 @@ static struct btf *btf_parse_module(const char *module_name, const void *data, u
> >>                 goto errout;
> >>
> >>         err = btf_check_all_metas(env);
> >> +       if (err) {
> >> +               /* BTF may be standalone; in that case meta checks will
> >> +                * fail and we fall back to standalone BTF processing.
> >> +                * Later on, once we have checked all metas, we will
> >> +                * retain start id from  base BTF so it will look like
> >> +                * split BTF (but is self-contained); renumbering is done
> >> +                * also to give the split BTF-like appearance and not
> >> +                * confuse pahole which assumes split BTF for modules.
> >> +                */
> >> +               btf->base_btf = NULL;
> >> +               if (btf->types)
> >> +                       kvfree(btf->types);
> >> +               btf->types = NULL;
> >> +               btf->types_size = 0;
> >> +               btf->start_id = 0;
> >> +               btf->nr_types = 0;
> >> +               btf->start_str_off = 0;
> >> +               standalone = true;
> >> +               err = btf_check_all_metas(env);
> >> +       }
> >
> > Interesting idea!
> > Instead of failing the first time, how about we make
> > such standalone module BTFs explicit?
> > Some flag or special type?
> > Then the kernel just checks that and renumbers right away.
> >
>
> I was thinking that might be one way to do it, perhaps even
> a .BTF_standalone section name or somesuch as a signal we
> are dealing with standalone BTF. However I _think_
> we can actually determine the module BTF is standalone
> without needing to change anything in the toolchain (I
> think adding flags would require that).

Why not just extend btf_header to contains extra information where we
can record whether it is stand-alone or split, what's the checksum of
base BTF, etc, etc. Yes, we'll need to teach libbpf and some tools
about this v2 of btf_header, but it's also an opportunity to make BTF
a bit more self-describing. E.g., right now there is a pretty big
problem that when we add new BTF_KIND_XXX, no existing tooling will be
able to do anything with BTF that contains that new kind, even if that
kind is completely optional and uninteresting for most tools (e.g., if
some particular tool didn't care about DECL_TAG). So with v2 we can
record a small table that records each kind's size: extra info size
and per-element size (for types that have vlen>0).

More upfront work, but solves few existing problems and we can reserve
space for future fields as well.

WDYT?

>
> If the BTF consists of string offsets all within base BTF
> string range, and it contains a definition for a BTF_KIND_INT
> called "int", we can infer safely it is standalone BTF I think.
> The nice thing is we are guaranteed such an int definition will
> be there in every module, thanks to the module init function
> signature. These tests could be put into a btf_is_standalone()
> function, and it would avoid the need to fall back from interpreting
> as split BTF, which was messy and polluted logs. If that makes sense,
> I'll respin with that change.
>
> > And combining this with what we discussed in the other thread
> > to load vmlinux's BTF through the module...
> > We'd need two flags in BTF to address both cases.
> > One to load base vmlinux BTF from a module and
> > another to load standalone module BTF.
> > Maybe add another BTF_KIND and it will be first in all types ?
> > Or use DATASEC with a special name ?
> >
>
> I'm wondering if we can minimize impact on existing tools for
> vmlinux BTF when loaded as a module; even if the module is
> called vmlinux_btf, we could special-case how it appears
> in /sys/kernel/btf such that it is still represented as
> /sys/kernel/btf/vmlinux I suspect, rather than as its module
> name "vmlinux_btf". If only part of the core kernel BTF was
> in vmlinux_btf (CONFIG_DEBUG_INFO_BTF=y and say
> CONFIG_DEBUG_INFO_BTF_VARS=m as per [1]) the vmlinux_btf
> name would be used to for the extras.
>
> One pain point is that if vmlinux_btf was loaded after other
> modules we'd need to iterate over them to (re)-load
> their BTF, so I think CONFIG_DEBUG_INFO_BTF=m would possibly require
> CONFIG_DEBUG_INFO_BTF_MISMATCH=y, otherwise late loading of vmlinux_btf
> might block other modules loading, as their split BTF would be invalid
> without the base BTF. Even standalone modules would need that to
> get their BTF renumbering right. But that all seems doable.
>
> Alan
>
> [1] https://lore.kernel.org/bpf/20221104231103.752040-10-stephen.s.brennan@oracle.com/T/#u
