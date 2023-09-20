Return-Path: <bpf+bounces-10476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD737A8A0B
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 19:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3273C1C20C5E
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 17:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85BE3E496;
	Wed, 20 Sep 2023 17:08:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F54E15BC
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 17:08:56 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C3EA3
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 10:08:53 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bf3f59905so954172566b.3
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 10:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695229731; x=1695834531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b25lRrq1v+D+BHaytB9804h7OJ3GObmA8rxn7bnc0Ec=;
        b=Ukt7K7D2aM5No/TLXc47fbsaCAmlPmTHYxJ14t6GRJcK3Q/lOQJmRyvBYSMmYfHhIP
         OzhrZ+oH5/5KYv8O2qwSu+aVEXQG0lIDXT6YHBy0hRcI+XdCQunaZ+btHFyLVX9vz4FC
         ta7J9fKhbvrISO/+nuqsjj39ci5xUYcwPHaUzVFhONnKuxmb1TdKsMWgNKh6E2A87u67
         eG4MCnmOW6lXl087YVfIO4t8Rh425OWrxxiWE3Zixi0EA+lNOAVIv6myNZWucvgrIhtB
         3ofGXp4HwdjBi9i49dNfo1YseVs9dAkc9scuo8S+SJDDNbmQDvbFEaebUSBf8o7u7KgE
         Fe1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695229731; x=1695834531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b25lRrq1v+D+BHaytB9804h7OJ3GObmA8rxn7bnc0Ec=;
        b=r3ewWBc/nkP+k+aY7A2BBo1dZj7Znil/haQ0iUox7fms9p6qMuPg5Qj3MBL1xqGq8f
         coqEILNUazvg3zWkSpwLq/D29Rl2KoWzrj6xm7BECcJr80rAMlgIZBdQ4AnbjNikC92f
         jOc7CBd0lXWUfZ0Cqdc0PbSBsWZfOdRdPcFF2XPDxFZkuZchaZdkZ490nmFmFId5OOmr
         ONzVSRNrlcIVD7/Sb3L9KbNjdO61tjL85TJZVcuaQZpcEsc2rpRIik5KizVHIVKRO/4D
         xDgku9AOBN3mYOKdFVIKtsOEU2J9BQwW0HyCeeCT7Kw1BBBLLFw/WCClCRsZoLLGvH1m
         t8pA==
X-Gm-Message-State: AOJu0YzezTg1Fhm++kyL3iYHVSIdS2xHa83Zno2XFVCiXZSTAfhuQjbE
	hR3/WCdCFrwJzv6PIYaLcLTkoAy1v4ynvDw36QLQgdz8
X-Google-Smtp-Source: AGHT+IHI94fLCSwml6C1XxmoLq6Mno0WkEsJR4UT8j5i++Ox/6W9G4Hm3jk9NS36GyDYHkbHvmpBRsX4LIt6s69K45U=
X-Received: by 2002:a17:907:2712:b0:9a1:edfd:73bb with SMTP id
 w18-20020a170907271200b009a1edfd73bbmr2774621ejk.47.1695229731229; Wed, 20
 Sep 2023 10:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912233214.1518551-1-memxor@gmail.com> <20230912233214.1518551-16-memxor@gmail.com>
 <CAEf4BzbY5CW_CFSeZBKDi6zCyFCmWkHcPBmCs65z8Vd-=cEduw@mail.gmail.com> <CAP01T75pXfT2NFKj=R=t_zTMX_1QySgjaQGCa_0Ve6RQZwR9xg@mail.gmail.com>
In-Reply-To: <CAP01T75pXfT2NFKj=R=t_zTMX_1QySgjaQGCa_0Ve6RQZwR9xg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Sep 2023 10:08:39 -0700
Message-ID: <CAEf4BzadxZ=Th64ssD2_3aiD8fJA8QHbOSzwPCtmz7umfMrmuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 15/17] libbpf: Add support for custom
 exception callbacks
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	David Vernet <void@manifault.com>, Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 6:03=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Hi Andrii,
>
> On Wed, 20 Sept 2023 at 02:25, Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Sep 12, 2023 at 4:32=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > Add support to libbpf to append exception callbacks when loading a
> > > program. The exception callback is found by discovering the declarati=
on
> > > tag 'exception_callback:<value>' and finding the callback in the valu=
e
> > > of the tag.
> > >
> > > The process is done in two steps. First, for each main program, the
> > > bpf_object__sanitize_and_load_btf function finds and marks its
> > > corresponding exception callback as defined by the declaration tag on
> > > it. Second, bpf_object__reloc_code is modified to append the indicate=
d
> > > exception callback at the end of the instruction iteration (since
> > > exception callback will never be appended in that loop, as it is not
> > > directly referenced).
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  tools/lib/bpf/libbpf.c | 114 +++++++++++++++++++++++++++++++++++++++=
--
> > >  1 file changed, 109 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index afc07a8f7dc7..3a6108e3238b 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -436,9 +436,11 @@ struct bpf_program {
> > >         int fd;
> > >         bool autoload;
> > >         bool autoattach;
> > > +       bool sym_global;
> > >         bool mark_btf_static;
> > >         enum bpf_prog_type type;
> > >         enum bpf_attach_type expected_attach_type;
> > > +       int exception_cb_idx;
> > >
> > >         int prog_ifindex;
> > >         __u32 attach_btf_obj_fd;
> > > @@ -765,6 +767,7 @@ bpf_object__init_prog(struct bpf_object *obj, str=
uct bpf_program *prog,
> > >
> > >         prog->type =3D BPF_PROG_TYPE_UNSPEC;
> > >         prog->fd =3D -1;
> > > +       prog->exception_cb_idx =3D -1;
> > >
> > >         /* libbpf's convention for SEC("?abc...") is that it's just l=
ike
> > >          * SEC("abc...") but the corresponding bpf_program starts out=
 with
> > > @@ -871,14 +874,16 @@ bpf_object__add_programs(struct bpf_object *obj=
, Elf_Data *sec_data,
> > >                 if (err)
> > >                         return err;
> > >
> > > +               if (ELF64_ST_BIND(sym->st_info) !=3D STB_LOCAL)
> > > +                       prog->sym_global =3D true;
> > > +
> > >                 /* if function is a global/weak symbol, but has restr=
icted
> > >                  * (STV_HIDDEN or STV_INTERNAL) visibility, mark its =
BTF FUNC
> > >                  * as static to enable more permissive BPF verificati=
on mode
> > >                  * with more outside context available to BPF verifie=
r
> > >                  */
> > > -               if (ELF64_ST_BIND(sym->st_info) !=3D STB_LOCAL
> > > -                   && (ELF64_ST_VISIBILITY(sym->st_other) =3D=3D STV=
_HIDDEN
> > > -                       || ELF64_ST_VISIBILITY(sym->st_other) =3D=3D =
STV_INTERNAL))
> > > +               if (prog->sym_global && (ELF64_ST_VISIBILITY(sym->st_=
other) =3D=3D STV_HIDDEN
> > > +                   || ELF64_ST_VISIBILITY(sym->st_other) =3D=3D STV_=
INTERNAL))
> > >                         prog->mark_btf_static =3D true;
> > >
> > >                 nr_progs++;
> > > @@ -3142,6 +3147,86 @@ static int bpf_object__sanitize_and_load_btf(s=
truct bpf_object *obj)
> > >                 }
> > >         }
> > >
> > > +       if (!kernel_supports(obj, FEAT_BTF_DECL_TAG))
> > > +               goto skip_exception_cb;
> > > +       for (i =3D 0; i < obj->nr_programs; i++) {
> >
> > I'm not sure why you chose to do these very inefficient three nested
> > for loops, tbh. Can you please send a follow up patch to make this a
> > bit more sane? There is no reason to iterate over BTF multiple times.
> > In general BPF object's BTF can have tons of information (especially
> > with vmlinux.h), so minimizing unnecessary linear searches here is
> > worth doing.
> >
> > How about this structure:
> >
> >
> > for each btf type in btf:
> >    if not decl_tag and not "exception_callback:" one, continue
> >
> >    prog_name =3D <find from decl_tag's referenced func>
> >    subprog_name =3D <find from decl_Tag's name>
> >
> >    prog =3D find_by_name(prog_name);
> >    subprog =3D find_by_name(subprog_name);
> >
> >    <check conditions>
> >
> >    <remember idx; if it's already set, emit human-readable error and
> > exit, don't rely on BPF verifier to complain >
> >
> > Thanks.
> >
>
> Yes, I think this looks better. I will rework and send a follow up fix.
> I was actually under the impression (based on dumping BTF of objects
> in selftests) that usually the count is somewhere like 30 or 100 for
> user BTFs.
> Even when vmlinux.h is included the unused types are dropped from the
> BTF. So I didn't pay much attention to looping over the user BTF over
> and over.
> But I do see in some objects it is up to 500 and I guess it goes
> higher in huge BPF objects that have a lot of programs (or many
> objects linked together).

Right. And I think it's just more straightforward to follow as well.

>
> > > +               struct bpf_program *prog =3D &obj->programs[i];
> > > +               int j, k, n;
> > > +
> > > +               if (prog_is_subprog(obj, prog))
> > > +                       continue;
> > > +               n =3D btf__type_cnt(obj->btf);
> > > +               for (j =3D 1; j < n; j++) {
> > > +                       const char *str =3D "exception_callback:", *n=
ame;
> > > +                       size_t len =3D strlen(str);
> > > +                       struct btf_type *t;
> > > +
> > > +                       t =3D btf_type_by_id(obj->btf, j);
> > > +                       if (!btf_is_decl_tag(t) || btf_decl_tag(t)->c=
omponent_idx !=3D -1)
> > > +                               continue;
> > > +
> > > +                       name =3D btf__str_by_offset(obj->btf, t->name=
_off);
> > > +                       if (strncmp(name, str, len))
> > > +                               continue;
> > > +
> > > +                       t =3D btf_type_by_id(obj->btf, t->type);
> > > +                       if (!btf_is_func(t) || btf_func_linkage(t) !=
=3D BTF_FUNC_GLOBAL) {
> > > +                               pr_warn("prog '%s': exception_callbac=
k:<value> decl tag not applied to the main program\n",
> > > +                                       prog->name);
> > > +                               return -EINVAL;
> > > +                       }
> > > +                       if (strcmp(prog->name, btf__str_by_offset(obj=
->btf, t->name_off)))
> > > +                               continue;
> > > +                       /* Multiple callbacks are specified for the s=
ame prog,
> > > +                        * the verifier will eventually return an err=
or for this
> > > +                        * case, hence simply skip appending a subpro=
g.
> > > +                        */
> > > +                       if (prog->exception_cb_idx >=3D 0) {
> > > +                               prog->exception_cb_idx =3D -1;
> > > +                               break;
> > > +                       }
> >
> > you check this condition three times and handle it in three different
> > ways, it's bizarre. Why?
> >
>
> I agree it looks confusing. The first check happens when for a given
> main program, we are going through all types and we already saw a
> exception cb satisfying the conditions previously.
> The second one is to catch multiple subprogs that are static and have
> the same name. So in the loop with k as iterator, if we already found
> a satisfying subprog, we still continue to catch other cases by
> matching on the name and linkage.

btw, given that we expect callback to be global, you should ignore
static subprogs, even if they have the same name. I think it is valid
during static linking to have static func with a conflicting name with
some other global func or static func. So we shouldn't error out on
static funcs there. Let's add the test for this condition.

> The third one is to just check whether the loop over subprogs for a
> given main prog actually set the exception_cb_idx or not, otherwise we
> could not find a subprog with the target name in the decl tag string.
>
> I hope this clears up some confusion. But I will rework it as you
> suggested. It's very late here today but I can send it out tomorrow.

I wasn't confused, but to me that was a sign that this code needs a
bit more thought :) thanks for agreeing to follow up and improve it

>
> >
> > > +
> > > +                       name +=3D len;
> > > +                       if (str_is_empty(name)) {
> > > +                               pr_warn("prog '%s': exception_callbac=
k:<value> decl tag contains empty value\n",
> > > +                                       prog->name);
> > > +                               return -EINVAL;
> > > +                       }
> > > +
> > > +                       for (k =3D 0; k < obj->nr_programs; k++) {
> > > +                               struct bpf_program *subprog =3D &obj-=
>programs[k];
> > > +
> > > +                               if (!prog_is_subprog(obj, subprog))
> > > +                                       continue;
> > > +                               if (strcmp(name, subprog->name))
> > > +                                       continue;
> > > +                               /* Enforce non-hidden, as from verifi=
er point of
> > > +                                * view it expects global functions, =
whereas the
> > > +                                * mark_btf_static fixes up linkage a=
s static.
> > > +                                */
> > > +                               if (!subprog->sym_global || subprog->=
mark_btf_static) {
> > > +                                       pr_warn("prog '%s': exception=
 callback %s must be a global non-hidden function\n",
> > > +                                               prog->name, subprog->=
name);
> > > +                                       return -EINVAL;
> > > +                               }
> > > +                               /* Let's see if we already saw a stat=
ic exception callback with the same name */
> > > +                               if (prog->exception_cb_idx >=3D 0) {
> > > +                                       pr_warn("prog '%s': multiple =
subprogs with same name as exception callback '%s'\n",
> > > +                                               prog->name, subprog->=
name);
> > > +                                       return -EINVAL;
> > > +                               }
> > > +                               prog->exception_cb_idx =3D k;
> > > +                               break;
> > > +                       }
> > > +
> > > +                       if (prog->exception_cb_idx >=3D 0)
> > > +                               continue;
> > > +                       pr_warn("prog '%s': cannot find exception cal=
lback '%s'\n", prog->name, name);
> > > +                       return -ENOENT;
> > > +               }
> > > +       }
> > > +skip_exception_cb:
> > > +
> > >         sanitize =3D btf_needs_sanitization(obj);
> > >         if (sanitize) {
> > >                 const void *raw_data;
> > > @@ -6270,10 +6355,10 @@ static int
> > >  bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *m=
ain_prog,
> > >                        struct bpf_program *prog)
> > >  {
> > > -       size_t sub_insn_idx, insn_idx, new_cnt;
> > > +       size_t sub_insn_idx, insn_idx;
> > >         struct bpf_program *subprog;
> > > -       struct bpf_insn *insns, *insn;
> > >         struct reloc_desc *relo;
> > > +       struct bpf_insn *insn;
> > >         int err;
> > >
> > >         err =3D reloc_prog_func_and_line_info(obj, main_prog, prog);
> > > @@ -6582,6 +6667,25 @@ bpf_object__relocate(struct bpf_object *obj, c=
onst char *targ_btf_path)
> > >                                 prog->name, err);
> > >                         return err;
> > >                 }
> > > +
> > > +               /* Now, also append exception callback if it has not =
been done already. */
> > > +               if (prog->exception_cb_idx >=3D 0) {
> > > +                       struct bpf_program *subprog =3D &obj->program=
s[prog->exception_cb_idx];
> > > +
> > > +                       /* Calling exception callback directly is dis=
allowed, which the
> > > +                        * verifier will reject later. In case it was=
 processed already,
> > > +                        * we can skip this step, otherwise for all o=
ther valid cases we
> > > +                        * have to append exception callback now.
> > > +                        */
> > > +                       if (subprog->sub_insn_off =3D=3D 0) {
> > > +                               err =3D bpf_object__append_subprog_co=
de(obj, prog, subprog);
> > > +                               if (err)
> > > +                                       return err;
> > > +                               err =3D bpf_object__reloc_code(obj, p=
rog, subprog);
> > > +                               if (err)
> > > +                                       return err;
> > > +                       }
> > > +               }
> > >         }
> > >         /* Process data relos for main programs */
> > >         for (i =3D 0; i < obj->nr_programs; i++) {
> > > --
> > > 2.41.0
> > >

