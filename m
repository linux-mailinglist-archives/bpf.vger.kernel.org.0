Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213B1634362
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 19:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbiKVSM0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 13:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiKVSMX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 13:12:23 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5140B85ECA
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 10:12:20 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v8so10724589edi.3
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 10:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ana6iOgWXre2caP5mypRX5iFojYFCmNVFEkRjTvdzx4=;
        b=NhnEyQbImxeGx49iqpRL0uDHJRXFajMe7tse5azdvaErr2WUZ90M//9K+qmSr0kMas
         M5ix/E6QTARu8oUPh7GErIOkQH1BrOvSosLevkvFt60khLvnUTrxQgmo3NT3evaw+aNV
         /ScrQT2Aw3rmBXK4taIw55WDwvVWrjJ1priEcDnJMMksJlp8yNxSDlUqmQ3yLc2L9JEg
         914BRrziBYPiawDOuA8YTLhwo8SzTwIgsfg9LLdnYUm+sQtlG7JCR2OUTxd7cEErfwpb
         2ScdohQ3npNU5VHE+YQjHaDx0LPwNCMXNJCx2xRPWFUjnyAVmZ69bN5dpe4xcItCuKH6
         aziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ana6iOgWXre2caP5mypRX5iFojYFCmNVFEkRjTvdzx4=;
        b=S0HQm/UM7DW3sfO4ifaKKWO1F6JCwuH3PLeaBfJxQUnJm8XG2gOBhJyS48csJvfGHw
         e3PSVMDfDf7tgSj0BJBr157dU97lv0L5YA3nmuTw2nhMPaJvbgIbmxWrJMKE/Kj8TI+z
         FITGxseJE5KEE6PLwxbnOklKTXh08N74CzgSi7j1FbS4Osnknf8+Pa2jHb15sbRn3p9L
         EOJ39YpKWyPuygcfiXAz47LtAG5SUH6OfhYUQYwmfI80EtEcsCVcwvT4YzlDEbyfa3OX
         A79mnV1OMiDJtkOea1RWzPMA1bUpc2bAPrHAkugRPWZw2cdUqRAuRLzrjhtME3PurUSn
         RqBQ==
X-Gm-Message-State: ANoB5pn6nJ7Mt5HxLcOFpTIemQB3JCo1C/32y5hMk1JEPWBO2N7Ufcdl
        lJX3g65E5BChHXdck9TsIAg27VWi1ZGdI3yPKnc=
X-Google-Smtp-Source: AA0mqf4ujrCKhZKs427t12UtRvJ64M/XlDBdw3JqWfqnouoHJb370fNAwL8N/a4ou4KPQD6CwsUdfWHCM1hK5uhdblQ=
X-Received: by 2002:a05:6402:4486:b0:461:a7e0:735c with SMTP id
 er6-20020a056402448600b00461a7e0735cmr22624114edb.14.1669140738542; Tue, 22
 Nov 2022 10:12:18 -0800 (PST)
MIME-Version: 1.0
References: <1667577487-9162-1-git-send-email-alan.maguire@oracle.com>
 <1667577487-9162-2-git-send-email-alan.maguire@oracle.com>
 <CAADnVQJ-WXrTj86Qd4PHMFo+fyyn+qWCLMVOHR+upj=fog7zNg@mail.gmail.com>
 <1b17769a-7e22-b8ce-afaf-70314cc31f4f@oracle.com> <CAEf4BzYoG9RSMdEFZKp8JG+cXBxJEygd0tAtOn-hvjoFFDWfTA@mail.gmail.com>
 <7fa26318-1912-c55e-2334-ed5d3b96973e@oracle.com>
In-Reply-To: <7fa26318-1912-c55e-2334-ed5d3b96973e@oracle.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 22 Nov 2022 10:12:05 -0800
Message-ID: <CAEf4BzYXRT9pFmC1RqnNBmvQWGQkd0zs9rbH9z9Ug8FWOArb_Q@mail.gmail.com>
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

On Tue, Nov 22, 2022 at 9:36 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On 09/11/2022 22:43, Andrii Nakryiko wrote:
> > On Mon, Nov 7, 2022 at 8:37 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >>
> >> On 05/11/2022 22:54, Alexei Starovoitov wrote:
> >>> On Fri, Nov 4, 2022 at 8:58 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >>>>
> >>>> Not all kernel modules can be built in-tree when the core
> >>>> kernel is built. This presents a problem for split BTF, because
> >>>> split module BTF refers to type ids in the base kernel BTF, and
> >>>> if that base kernel BTF changes (even in minor ways) those
> >>>> references become invalid.  Such modules then cannot take
> >>>> advantage of BTF (or at least they only can until the kernel
> >>>> changes enough to invalidate their vmlinux type id references).
> >>>> This problem has been discussed before, and the initial approach
> >>>> was to allow BTF mismatch but fail to load BTF.  See [1]
> >>>> for more discussion.
> >>>>
> >>>> Generating standalone BTF for modules helps solve this problem
> >>>> because the BTF generated is self-referential only.  However,
> >>>> tooling is geared towards split BTF - for example bpftool assumes
> >>>> a module's BTF is defined relative to vmlinux BTF.  To handle
> >>>> this, dynamic remapping of standalone BTF is done on module
> >>>> load to make it appear like split BTF - type ids and string
> >>>> offsets are remapped such that they appear as they would in
> >>>> split BTF.  It just so happens that the BTF is self-referential.
> >>>> With this approach, existing tooling works with standalone
> >>>> module BTF from /sys/kernel/btf in the same way as before;
> >>>> no knowledge of split versus standalone BTF is required.
> >>>>
> >>>> Currently, the approach taken is to assume that the BTF
> >>>> associated with a module is split BTF.  If however the
> >>>> checking of types fails, we fall back to interpreting it as
> >>>> standalone BTF and carrying out remapping.  As discussed in [1]
> >>>> there are some heuristics we could use to identify standalone
> >>>> versus split module BTF, but for now the simplistic fallback
> >>>> method is used.
> >>>>
> >>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >>>>
> >>>> [1] https://lore.kernel.org/bpf/YfK18x%2FXrYL4Vw8o@syu-laptop/
> >>>> ---
> >>>>  kernel/bpf/btf.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>>>  1 file changed, 132 insertions(+)
> >>>>
> >>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> >>>> index 5579ff3..5efdcaf 100644
> >>>> --- a/kernel/bpf/btf.c
> >>>> +++ b/kernel/bpf/btf.c
> >>>> @@ -5315,11 +5315,120 @@ struct btf *btf_parse_vmlinux(void)
> >>>>
> >>>>  #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> >>>>
> >>>> +static u32 btf_name_off_renumber(struct btf *btf, u32 name_off)
> >>>> +{
> >>>> +       return name_off + btf->start_str_off;
> >>>> +}
> >>>> +
> >>>> +static u32 btf_id_renumber(struct btf *btf, u32 id)
> >>>> +{
> >>>> +       /* no need to renumber void */
> >>>> +       if (id == 0)
> >>>> +               return id;
> >>>> +       return id + btf->start_id - 1;
> >>>> +}
> >>>> +
> >>>> +/* Renumber standalone BTF to appear as split BTF; name offsets must
> >>>> + * be relative to btf->start_str_offset and ids relative to btf->start_id.
> >>>> + * When user sees BTF it will appear as normal module split BTF, the only
> >>>> + * difference being it is fully self-referential and does not refer back
> >>>> + * to vmlinux BTF (aside from 0 "void" references).
> >>>> + */
> >>>> +static void btf_type_renumber(struct btf_verifier_env *env, struct btf_type *t)
> >>>> +{
> >>>> +       struct btf_var_secinfo *secinfo;
> >>>> +       struct btf *btf = env->btf;
> >>>> +       struct btf_member *member;
> >>>> +       struct btf_param *param;
> >>>> +       struct btf_array *array;
> >>>> +       struct btf_enum64 *e64;
> >>>> +       struct btf_enum *e;
> >>>> +       int i;
> >>>> +
> >>>> +       t->name_off = btf_name_off_renumber(btf, t->name_off);
> >>>> +
> >>>> +       switch (BTF_INFO_KIND(t->info)) {
> >>>> +       case BTF_KIND_INT:
> >>>> +       case BTF_KIND_FLOAT:
> >>>> +       case BTF_KIND_TYPE_TAG:
> >>>> +               /* nothing to renumber here, no type references */
> >>>> +               break;
> >>>> +       case BTF_KIND_PTR:
> >>>> +       case BTF_KIND_FWD:
> >>>> +       case BTF_KIND_TYPEDEF:
> >>>> +       case BTF_KIND_VOLATILE:
> >>>> +       case BTF_KIND_CONST:
> >>>> +       case BTF_KIND_RESTRICT:
> >>>> +       case BTF_KIND_FUNC:
> >>>> +       case BTF_KIND_VAR:
> >>>> +       case BTF_KIND_DECL_TAG:
> >>>> +               /* renumber the referenced type */
> >>>> +               t->type = btf_id_renumber(btf, t->type);
> >>>> +               break;
> >>>> +       case BTF_KIND_ARRAY:
> >>>> +               array = btf_array(t);
> >>>> +               array->type = btf_id_renumber(btf, array->type);
> >>>> +               array->index_type = btf_id_renumber(btf, array->index_type);
> >>>> +               break;
> >>>> +       case BTF_KIND_STRUCT:
> >>>> +       case BTF_KIND_UNION:
> >>>> +               member = (struct btf_member *)(t + 1);
> >>>> +               for (i = 0; i < btf_type_vlen(t); i++) {
> >>>> +                       member->type = btf_id_renumber(btf, member->type);
> >>>> +                       member->name_off = btf_name_off_renumber(btf, member->name_off);
> >>>> +                       member++;
> >>>> +               }
> >>>> +               break;
> >>>> +       case BTF_KIND_FUNC_PROTO:
> >>>> +               param = (struct btf_param *)(t + 1);
> >>>> +               for (i = 0; i < btf_type_vlen(t); i++) {
> >>>> +                       param->type = btf_id_renumber(btf, param->type);
> >>>> +                       param->name_off = btf_name_off_renumber(btf, param->name_off);
> >>>> +                       param++;
> >>>> +               }
> >>>> +               break;
> >>>> +       case BTF_KIND_DATASEC:
> >>>> +               secinfo = (struct btf_var_secinfo *)(t + 1);
> >>>> +               for (i = 0; i < btf_type_vlen(t); i++) {
> >>>> +                       secinfo->type = btf_id_renumber(btf, secinfo->type);
> >>>> +                       secinfo++;
> >>>> +               }
> >>>> +               break;
> >>>> +       case BTF_KIND_ENUM:
> >>>> +               e = (struct btf_enum *)(t + 1);
> >>>> +               for (i = 0; i < btf_type_vlen(t); i++) {
> >>>> +                       e->name_off = btf_name_off_renumber(btf, e->name_off);
> >>>> +                       e++;
> >>>> +               }
> >>>> +               break;
> >>>> +       case BTF_KIND_ENUM64:
> >>>> +               e64 = (struct btf_enum64 *)(t + 1);
> >>>> +               for (i = 0; i < btf_type_vlen(t); i++) {
> >>>> +                       e64->name_off = btf_name_off_renumber(btf, e64->name_off);
> >>>> +                       e64++;
> >>>> +               }
> >>>> +               break;
> >>>> +       }
> >>>> +}
> >>>> +
> >>>> +static void btf_renumber(struct btf_verifier_env *env, struct btf *base_btf)
> >>>> +{
> >>>> +       struct btf *btf = env->btf;
> >>>> +       int i;
> >>>> +
> >>>> +       btf->start_id = base_btf->nr_types;
> >>>> +       btf->start_str_off = base_btf->hdr.str_len;
> >>>> +
> >>>> +       for (i = 0; i < btf->nr_types; i++)
> >>>> +               btf_type_renumber(env, btf->types[i]);
> >>>> +}
> >>>> +
> >>>>  static struct btf *btf_parse_module(const char *module_name, const void *data, unsigned int data_size)
> >>>>  {
> >>>>         struct btf_verifier_env *env = NULL;
> >>>>         struct bpf_verifier_log *log;
> >>>>         struct btf *btf = NULL, *base_btf;
> >>>> +       bool standalone = false;
> >>>>         int err;
> >>>>
> >>>>         base_btf = bpf_get_btf_vmlinux();
> >>>> @@ -5367,9 +5476,32 @@ static struct btf *btf_parse_module(const char *module_name, const void *data, u
> >>>>                 goto errout;
> >>>>
> >>>>         err = btf_check_all_metas(env);
> >>>> +       if (err) {
> >>>> +               /* BTF may be standalone; in that case meta checks will
> >>>> +                * fail and we fall back to standalone BTF processing.
> >>>> +                * Later on, once we have checked all metas, we will
> >>>> +                * retain start id from  base BTF so it will look like
> >>>> +                * split BTF (but is self-contained); renumbering is done
> >>>> +                * also to give the split BTF-like appearance and not
> >>>> +                * confuse pahole which assumes split BTF for modules.
> >>>> +                */
> >>>> +               btf->base_btf = NULL;
> >>>> +               if (btf->types)
> >>>> +                       kvfree(btf->types);
> >>>> +               btf->types = NULL;
> >>>> +               btf->types_size = 0;
> >>>> +               btf->start_id = 0;
> >>>> +               btf->nr_types = 0;
> >>>> +               btf->start_str_off = 0;
> >>>> +               standalone = true;
> >>>> +               err = btf_check_all_metas(env);
> >>>> +       }
> >>>
> >>> Interesting idea!
> >>> Instead of failing the first time, how about we make
> >>> such standalone module BTFs explicit?
> >>> Some flag or special type?
> >>> Then the kernel just checks that and renumbers right away.
> >>>
> >>
> >> I was thinking that might be one way to do it, perhaps even
> >> a .BTF_standalone section name or somesuch as a signal we
> >> are dealing with standalone BTF. However I _think_
> >> we can actually determine the module BTF is standalone
> >> without needing to change anything in the toolchain (I
> >> think adding flags would require that).
> >
> > Why not just extend btf_header to contains extra information where we
> > can record whether it is stand-alone or split, what's the checksum of
> > base BTF, etc, etc. Yes, we'll need to teach libbpf and some tools
> > about this v2 of btf_header, but it's also an opportunity to make BTF
> > a bit more self-describing. E.g., right now there is a pretty big
> > problem that when we add new BTF_KIND_XXX, no existing tooling will be
> > able to do anything with BTF that contains that new kind, even if that
> > kind is completely optional and uninteresting for most tools (e.g., if
> > some particular tool didn't care about DECL_TAG). So with v2 we can
> > record a small table that records each kind's size: extra info size
> > and per-element size (for types that have vlen>0).
> >
> > More upfront work, but solves few existing problems and we can reserve
> > space for future fields as well.
> >
> > WDYT?
> >
>
> Sorry Andrii, missed this reply. With respect to self-describing BTF,
> I've got a patch series that I was planning on sending out soon which
> approaches this by describing BTF kind encodings in BTF. The handy thing
> about that is as you say it allows us to parse BTF even if we don't
> actually use features, so when new kinds are added we can skip past
> them, but if a new libbpf comes along we can potentially unlock these
> features. This is particularly valuable for kernel/module BTF since
> the kernel might be around for a while and we would rather encode
> BTF optimistically. The other useful thing is it won't itself require
> any BTF format changes; it's simply a matter of adding a libbpf call
> to pahole which says "encode BTF kinds", and that part is done using
> basic BTF kinds like typedefs+structs. The benefit of doing this in
> BTF is that we don't need to worry about header incompatibility etc.
> Just adds a few hundred bytes to overall kernel BTF too, since kind
> encodings are only needed for vmlinux (or standalone) BTF. We also
> end up with BTF kind structures in vmlinux.h, which could potentially
> simplify BTF introspection in BPF programs in the future also.
>
> The handy thing about this approach is also that the kernel code
> that parses the BTF kind descriptions is easy to backport, so we
> could even look at backporting that patch to stable kernels such
> that they would be an a position to parse newer BTF kinds even
> if they could not use them. Because that parsing is based around
> interpreting existing BTF kinds, it is minimally invasive.
>
> I'll send it out as an RFC shortly to provide additional context.

I'm not clear how that handles kinds with multiple entities (like
fields for STRUCTs, args for FUNC_PROTO, etc), but I'll look at RFC.
I think a small table of kind ID -> prefix size + per-element size
mappings is useful for any tool that works with BTF, because it allows
you to skip unknown stuff. And it works not just for vmlinux BTF.

>
> Alan
