Return-Path: <bpf+bounces-10425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 063237A6FF8
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 03:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90419281396
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 01:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE1B17CD;
	Wed, 20 Sep 2023 01:03:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8C9A49
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 01:03:19 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42790BD
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 18:03:17 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-532c66a105bso1429198a12.3
        for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 18:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695171795; x=1695776595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYDyKw2MTXGByz3yz0phakx5pJW7f6EUvrlNZRlMpq8=;
        b=bE0XtSHGbrcf0NvzJhsADlU1gjHFwQ39QCgRg4fY3WAASBTXLjI5ZhYjXOzR9v+yE+
         6pu63F/p/kKwe+Ibo1+HvS2Ld9IN2VvRnlxHuLx/2DOsEZI0k6UoA4+KEP1yHMnOuYjo
         MTOzU5jtUr9N25+dV8hs3rD1Vb1beJD2RqpJoHEHWEHFND6gsTk9dSpb3kII0LDqMd2B
         q4NfKKDpwr+rKEPq/brOvNm+CnAStwj9xcshW0c30B1aRfCTN8KTZFNNsClez9YoEk0w
         xTQNSzUZCuLizKmAAaxTDQTzNygozD3LZGEtFqMQUuuHVts8tQR8vcRx0H3yInS4X3RY
         91rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695171795; x=1695776595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYDyKw2MTXGByz3yz0phakx5pJW7f6EUvrlNZRlMpq8=;
        b=AlDu4qQoloB3qq1CNWHW83BnIGqhLm2ySJLqwTH/QUP3Y4EgXq9U4J6m7vDZDdiGg+
         VVhZ3flKjjoU3rWNe9Rb9trGfrvDTqx2vaEDReKMF9S1RoRmuGEc1YATmdHFZuAKyrPX
         /eUp7E6qUcmcpqb26UI+diPwqAjpmzoUzSRVQYKL2/k0D+cNA7kj3ZjtSApz3FTdv3Xg
         pL8nYlOX3/3J8x1Y5lm7jtJwv9tvNFMxqSjf1E7HyVm5CccmMbumTmsg066GTn9K+2mg
         y6f1ScL9tDwT16ork5+OsYlgTU2BPcxQN1qWeeFv3Qk0XE/N+RxOJa0F4J4UvbbEy/Kt
         8ClA==
X-Gm-Message-State: AOJu0YwsWePbi8BDZKhYVBqggs33ipC+wemGHDwKpDHQOW7vr97p4t0t
	TIbfzjWtNbPjaaYVFgUFFsjEJ3OLrH8HnESjCfc=
X-Google-Smtp-Source: AGHT+IGRmy+2crvofObJcTdiYtgEI3Tp9EDIjr25BUk6LoI9kqZ1F2eHz5xTqrlktuNz5u9lhNe5/GvWkUIvUwX1qL0=
X-Received: by 2002:a05:6402:288:b0:52c:b469:bafd with SMTP id
 l8-20020a056402028800b0052cb469bafdmr691276edv.41.1695171795395; Tue, 19 Sep
 2023 18:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912233214.1518551-1-memxor@gmail.com> <20230912233214.1518551-16-memxor@gmail.com>
 <CAEf4BzbY5CW_CFSeZBKDi6zCyFCmWkHcPBmCs65z8Vd-=cEduw@mail.gmail.com>
In-Reply-To: <CAEf4BzbY5CW_CFSeZBKDi6zCyFCmWkHcPBmCs65z8Vd-=cEduw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 20 Sep 2023 03:02:39 +0200
Message-ID: <CAP01T75pXfT2NFKj=R=t_zTMX_1QySgjaQGCa_0Ve6RQZwR9xg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 15/17] libbpf: Add support for custom
 exception callbacks
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	David Vernet <void@manifault.com>, Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Andrii,

On Wed, 20 Sept 2023 at 02:25, Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Sep 12, 2023 at 4:32=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Add support to libbpf to append exception callbacks when loading a
> > program. The exception callback is found by discovering the declaration
> > tag 'exception_callback:<value>' and finding the callback in the value
> > of the tag.
> >
> > The process is done in two steps. First, for each main program, the
> > bpf_object__sanitize_and_load_btf function finds and marks its
> > corresponding exception callback as defined by the declaration tag on
> > it. Second, bpf_object__reloc_code is modified to append the indicated
> > exception callback at the end of the instruction iteration (since
> > exception callback will never be appended in that loop, as it is not
> > directly referenced).
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 114 +++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 109 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index afc07a8f7dc7..3a6108e3238b 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -436,9 +436,11 @@ struct bpf_program {
> >         int fd;
> >         bool autoload;
> >         bool autoattach;
> > +       bool sym_global;
> >         bool mark_btf_static;
> >         enum bpf_prog_type type;
> >         enum bpf_attach_type expected_attach_type;
> > +       int exception_cb_idx;
> >
> >         int prog_ifindex;
> >         __u32 attach_btf_obj_fd;
> > @@ -765,6 +767,7 @@ bpf_object__init_prog(struct bpf_object *obj, struc=
t bpf_program *prog,
> >
> >         prog->type =3D BPF_PROG_TYPE_UNSPEC;
> >         prog->fd =3D -1;
> > +       prog->exception_cb_idx =3D -1;
> >
> >         /* libbpf's convention for SEC("?abc...") is that it's just lik=
e
> >          * SEC("abc...") but the corresponding bpf_program starts out w=
ith
> > @@ -871,14 +874,16 @@ bpf_object__add_programs(struct bpf_object *obj, =
Elf_Data *sec_data,
> >                 if (err)
> >                         return err;
> >
> > +               if (ELF64_ST_BIND(sym->st_info) !=3D STB_LOCAL)
> > +                       prog->sym_global =3D true;
> > +
> >                 /* if function is a global/weak symbol, but has restric=
ted
> >                  * (STV_HIDDEN or STV_INTERNAL) visibility, mark its BT=
F FUNC
> >                  * as static to enable more permissive BPF verification=
 mode
> >                  * with more outside context available to BPF verifier
> >                  */
> > -               if (ELF64_ST_BIND(sym->st_info) !=3D STB_LOCAL
> > -                   && (ELF64_ST_VISIBILITY(sym->st_other) =3D=3D STV_H=
IDDEN
> > -                       || ELF64_ST_VISIBILITY(sym->st_other) =3D=3D ST=
V_INTERNAL))
> > +               if (prog->sym_global && (ELF64_ST_VISIBILITY(sym->st_ot=
her) =3D=3D STV_HIDDEN
> > +                   || ELF64_ST_VISIBILITY(sym->st_other) =3D=3D STV_IN=
TERNAL))
> >                         prog->mark_btf_static =3D true;
> >
> >                 nr_progs++;
> > @@ -3142,6 +3147,86 @@ static int bpf_object__sanitize_and_load_btf(str=
uct bpf_object *obj)
> >                 }
> >         }
> >
> > +       if (!kernel_supports(obj, FEAT_BTF_DECL_TAG))
> > +               goto skip_exception_cb;
> > +       for (i =3D 0; i < obj->nr_programs; i++) {
>
> I'm not sure why you chose to do these very inefficient three nested
> for loops, tbh. Can you please send a follow up patch to make this a
> bit more sane? There is no reason to iterate over BTF multiple times.
> In general BPF object's BTF can have tons of information (especially
> with vmlinux.h), so minimizing unnecessary linear searches here is
> worth doing.
>
> How about this structure:
>
>
> for each btf type in btf:
>    if not decl_tag and not "exception_callback:" one, continue
>
>    prog_name =3D <find from decl_tag's referenced func>
>    subprog_name =3D <find from decl_Tag's name>
>
>    prog =3D find_by_name(prog_name);
>    subprog =3D find_by_name(subprog_name);
>
>    <check conditions>
>
>    <remember idx; if it's already set, emit human-readable error and
> exit, don't rely on BPF verifier to complain >
>
> Thanks.
>

Yes, I think this looks better. I will rework and send a follow up fix.
I was actually under the impression (based on dumping BTF of objects
in selftests) that usually the count is somewhere like 30 or 100 for
user BTFs.
Even when vmlinux.h is included the unused types are dropped from the
BTF. So I didn't pay much attention to looping over the user BTF over
and over.
But I do see in some objects it is up to 500 and I guess it goes
higher in huge BPF objects that have a lot of programs (or many
objects linked together).

> > +               struct bpf_program *prog =3D &obj->programs[i];
> > +               int j, k, n;
> > +
> > +               if (prog_is_subprog(obj, prog))
> > +                       continue;
> > +               n =3D btf__type_cnt(obj->btf);
> > +               for (j =3D 1; j < n; j++) {
> > +                       const char *str =3D "exception_callback:", *nam=
e;
> > +                       size_t len =3D strlen(str);
> > +                       struct btf_type *t;
> > +
> > +                       t =3D btf_type_by_id(obj->btf, j);
> > +                       if (!btf_is_decl_tag(t) || btf_decl_tag(t)->com=
ponent_idx !=3D -1)
> > +                               continue;
> > +
> > +                       name =3D btf__str_by_offset(obj->btf, t->name_o=
ff);
> > +                       if (strncmp(name, str, len))
> > +                               continue;
> > +
> > +                       t =3D btf_type_by_id(obj->btf, t->type);
> > +                       if (!btf_is_func(t) || btf_func_linkage(t) !=3D=
 BTF_FUNC_GLOBAL) {
> > +                               pr_warn("prog '%s': exception_callback:=
<value> decl tag not applied to the main program\n",
> > +                                       prog->name);
> > +                               return -EINVAL;
> > +                       }
> > +                       if (strcmp(prog->name, btf__str_by_offset(obj->=
btf, t->name_off)))
> > +                               continue;
> > +                       /* Multiple callbacks are specified for the sam=
e prog,
> > +                        * the verifier will eventually return an error=
 for this
> > +                        * case, hence simply skip appending a subprog.
> > +                        */
> > +                       if (prog->exception_cb_idx >=3D 0) {
> > +                               prog->exception_cb_idx =3D -1;
> > +                               break;
> > +                       }
>
> you check this condition three times and handle it in three different
> ways, it's bizarre. Why?
>

I agree it looks confusing. The first check happens when for a given
main program, we are going through all types and we already saw a
exception cb satisfying the conditions previously.
The second one is to catch multiple subprogs that are static and have
the same name. So in the loop with k as iterator, if we already found
a satisfying subprog, we still continue to catch other cases by
matching on the name and linkage.
The third one is to just check whether the loop over subprogs for a
given main prog actually set the exception_cb_idx or not, otherwise we
could not find a subprog with the target name in the decl tag string.

I hope this clears up some confusion. But I will rework it as you
suggested. It's very late here today but I can send it out tomorrow.

>
> > +
> > +                       name +=3D len;
> > +                       if (str_is_empty(name)) {
> > +                               pr_warn("prog '%s': exception_callback:=
<value> decl tag contains empty value\n",
> > +                                       prog->name);
> > +                               return -EINVAL;
> > +                       }
> > +
> > +                       for (k =3D 0; k < obj->nr_programs; k++) {
> > +                               struct bpf_program *subprog =3D &obj->p=
rograms[k];
> > +
> > +                               if (!prog_is_subprog(obj, subprog))
> > +                                       continue;
> > +                               if (strcmp(name, subprog->name))
> > +                                       continue;
> > +                               /* Enforce non-hidden, as from verifier=
 point of
> > +                                * view it expects global functions, wh=
ereas the
> > +                                * mark_btf_static fixes up linkage as =
static.
> > +                                */
> > +                               if (!subprog->sym_global || subprog->ma=
rk_btf_static) {
> > +                                       pr_warn("prog '%s': exception c=
allback %s must be a global non-hidden function\n",
> > +                                               prog->name, subprog->na=
me);
> > +                                       return -EINVAL;
> > +                               }
> > +                               /* Let's see if we already saw a static=
 exception callback with the same name */
> > +                               if (prog->exception_cb_idx >=3D 0) {
> > +                                       pr_warn("prog '%s': multiple su=
bprogs with same name as exception callback '%s'\n",
> > +                                               prog->name, subprog->na=
me);
> > +                                       return -EINVAL;
> > +                               }
> > +                               prog->exception_cb_idx =3D k;
> > +                               break;
> > +                       }
> > +
> > +                       if (prog->exception_cb_idx >=3D 0)
> > +                               continue;
> > +                       pr_warn("prog '%s': cannot find exception callb=
ack '%s'\n", prog->name, name);
> > +                       return -ENOENT;
> > +               }
> > +       }
> > +skip_exception_cb:
> > +
> >         sanitize =3D btf_needs_sanitization(obj);
> >         if (sanitize) {
> >                 const void *raw_data;
> > @@ -6270,10 +6355,10 @@ static int
> >  bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *mai=
n_prog,
> >                        struct bpf_program *prog)
> >  {
> > -       size_t sub_insn_idx, insn_idx, new_cnt;
> > +       size_t sub_insn_idx, insn_idx;
> >         struct bpf_program *subprog;
> > -       struct bpf_insn *insns, *insn;
> >         struct reloc_desc *relo;
> > +       struct bpf_insn *insn;
> >         int err;
> >
> >         err =3D reloc_prog_func_and_line_info(obj, main_prog, prog);
> > @@ -6582,6 +6667,25 @@ bpf_object__relocate(struct bpf_object *obj, con=
st char *targ_btf_path)
> >                                 prog->name, err);
> >                         return err;
> >                 }
> > +
> > +               /* Now, also append exception callback if it has not be=
en done already. */
> > +               if (prog->exception_cb_idx >=3D 0) {
> > +                       struct bpf_program *subprog =3D &obj->programs[=
prog->exception_cb_idx];
> > +
> > +                       /* Calling exception callback directly is disal=
lowed, which the
> > +                        * verifier will reject later. In case it was p=
rocessed already,
> > +                        * we can skip this step, otherwise for all oth=
er valid cases we
> > +                        * have to append exception callback now.
> > +                        */
> > +                       if (subprog->sub_insn_off =3D=3D 0) {
> > +                               err =3D bpf_object__append_subprog_code=
(obj, prog, subprog);
> > +                               if (err)
> > +                                       return err;
> > +                               err =3D bpf_object__reloc_code(obj, pro=
g, subprog);
> > +                               if (err)
> > +                                       return err;
> > +                       }
> > +               }
> >         }
> >         /* Process data relos for main programs */
> >         for (i =3D 0; i < obj->nr_programs; i++) {
> > --
> > 2.41.0
> >

