Return-Path: <bpf+bounces-10422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DD17A6FD5
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 02:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C60A2812CF
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 00:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2973610E6;
	Wed, 20 Sep 2023 00:25:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A39193
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 00:25:29 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F7AAB
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 17:25:26 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c00e1d4c08so43079161fa.3
        for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 17:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695169525; x=1695774325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrL1AGtRqiSHEskS2w8WGm7mpbhLkmXxEbQ38EN3Kho=;
        b=Z3F8tL/3ASDawWDX6Ojj1LV1B992xXACiu2va5wmDjsxKBkKgEUl2fMhFUEah0nF1p
         0lcYPnbxzYVhAQkeIV9Lgli4yYFJCUhzocpHxtAzgDU+Ii/+xF/SDZ0iCxCioVeP+Y+n
         nOyXHl2wCOmTPqkoax0Lxjr6g676Y+BtQPKum3r5fwA1c/gHYHfRYG2bt63b0pJ2mZti
         DmwSx8EclferAzGlg4HACQEEbGVJEh3DEiDDXhlQi10l9jO5TK9ZwmK2qwbvUPBq9KKP
         pkSvRGgLoJ7CapDUrGZK7W+fqBvMY6tSZPdYLZP7OBwVMoMbVS5cXyNN5DzSOcMKjrNG
         kK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695169525; x=1695774325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrL1AGtRqiSHEskS2w8WGm7mpbhLkmXxEbQ38EN3Kho=;
        b=gmhLoFHHyaBR/kpogk+BZtlCXRtuFPU6pjsGqWHzpJ3krpqL1g3XfCJQYVcm6frKv1
         s+loWPJSgPXmJY63JgPIXR/CaSrPt3nMAP4kxlw+MCyGwjhens4M/s8FHbDHclxHZUlo
         RQuu1uC369kV0WQndZxeieZxYq3t6sQnR7RoeZKHvZ+FQQQOCbxwNlWrYi1H1sqzzUZD
         twrls1tHJR1395NkEfiDsVzTyy+/OoaKM6s3ug7OiMAcqHIJD7QuCtI94M3KAVR2J9qX
         +kp7kSfsbmzOjorFK1XaC3uUAwoG1Xm9P5Mkza2OTc9RI3A5nGCIFBdxd9j1M+cUs5OY
         S+gA==
X-Gm-Message-State: AOJu0YyccPkxWF3/Tlk9cA+E1nHcqwMc6zcecwwVBw+g2gX/9FVWcSRs
	DtqL09wRDJs72mPl+xLpyIukiww2G95GMRBBUig=
X-Google-Smtp-Source: AGHT+IHZGwrWP4CxC0KAa+DpN3vYoxcCJKM/HEf68Q7Pdmn7qCZJFSovhIH1XODwS7tWY258Rzb+0jnVBIuGChQZ7yQ=
X-Received: by 2002:a2e:994c:0:b0:2c0:240:b564 with SMTP id
 r12-20020a2e994c000000b002c00240b564mr714350ljj.15.1695169524762; Tue, 19 Sep
 2023 17:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912233214.1518551-1-memxor@gmail.com> <20230912233214.1518551-16-memxor@gmail.com>
In-Reply-To: <20230912233214.1518551-16-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Sep 2023 17:25:13 -0700
Message-ID: <CAEf4BzbY5CW_CFSeZBKDi6zCyFCmWkHcPBmCs65z8Vd-=cEduw@mail.gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 12, 2023 at 4:32=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Add support to libbpf to append exception callbacks when loading a
> program. The exception callback is found by discovering the declaration
> tag 'exception_callback:<value>' and finding the callback in the value
> of the tag.
>
> The process is done in two steps. First, for each main program, the
> bpf_object__sanitize_and_load_btf function finds and marks its
> corresponding exception callback as defined by the declaration tag on
> it. Second, bpf_object__reloc_code is modified to append the indicated
> exception callback at the end of the instruction iteration (since
> exception callback will never be appended in that loop, as it is not
> directly referenced).
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 114 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 109 insertions(+), 5 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index afc07a8f7dc7..3a6108e3238b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -436,9 +436,11 @@ struct bpf_program {
>         int fd;
>         bool autoload;
>         bool autoattach;
> +       bool sym_global;
>         bool mark_btf_static;
>         enum bpf_prog_type type;
>         enum bpf_attach_type expected_attach_type;
> +       int exception_cb_idx;
>
>         int prog_ifindex;
>         __u32 attach_btf_obj_fd;
> @@ -765,6 +767,7 @@ bpf_object__init_prog(struct bpf_object *obj, struct =
bpf_program *prog,
>
>         prog->type =3D BPF_PROG_TYPE_UNSPEC;
>         prog->fd =3D -1;
> +       prog->exception_cb_idx =3D -1;
>
>         /* libbpf's convention for SEC("?abc...") is that it's just like
>          * SEC("abc...") but the corresponding bpf_program starts out wit=
h
> @@ -871,14 +874,16 @@ bpf_object__add_programs(struct bpf_object *obj, El=
f_Data *sec_data,
>                 if (err)
>                         return err;
>
> +               if (ELF64_ST_BIND(sym->st_info) !=3D STB_LOCAL)
> +                       prog->sym_global =3D true;
> +
>                 /* if function is a global/weak symbol, but has restricte=
d
>                  * (STV_HIDDEN or STV_INTERNAL) visibility, mark its BTF =
FUNC
>                  * as static to enable more permissive BPF verification m=
ode
>                  * with more outside context available to BPF verifier
>                  */
> -               if (ELF64_ST_BIND(sym->st_info) !=3D STB_LOCAL
> -                   && (ELF64_ST_VISIBILITY(sym->st_other) =3D=3D STV_HID=
DEN
> -                       || ELF64_ST_VISIBILITY(sym->st_other) =3D=3D STV_=
INTERNAL))
> +               if (prog->sym_global && (ELF64_ST_VISIBILITY(sym->st_othe=
r) =3D=3D STV_HIDDEN
> +                   || ELF64_ST_VISIBILITY(sym->st_other) =3D=3D STV_INTE=
RNAL))
>                         prog->mark_btf_static =3D true;
>
>                 nr_progs++;
> @@ -3142,6 +3147,86 @@ static int bpf_object__sanitize_and_load_btf(struc=
t bpf_object *obj)
>                 }
>         }
>
> +       if (!kernel_supports(obj, FEAT_BTF_DECL_TAG))
> +               goto skip_exception_cb;
> +       for (i =3D 0; i < obj->nr_programs; i++) {

I'm not sure why you chose to do these very inefficient three nested
for loops, tbh. Can you please send a follow up patch to make this a
bit more sane? There is no reason to iterate over BTF multiple times.
In general BPF object's BTF can have tons of information (especially
with vmlinux.h), so minimizing unnecessary linear searches here is
worth doing.

How about this structure:


for each btf type in btf:
   if not decl_tag and not "exception_callback:" one, continue

   prog_name =3D <find from decl_tag's referenced func>
   subprog_name =3D <find from decl_Tag's name>

   prog =3D find_by_name(prog_name);
   subprog =3D find_by_name(subprog_name);

   <check conditions>

   <remember idx; if it's already set, emit human-readable error and
exit, don't rely on BPF verifier to complain >

Thanks.

> +               struct bpf_program *prog =3D &obj->programs[i];
> +               int j, k, n;
> +
> +               if (prog_is_subprog(obj, prog))
> +                       continue;
> +               n =3D btf__type_cnt(obj->btf);
> +               for (j =3D 1; j < n; j++) {
> +                       const char *str =3D "exception_callback:", *name;
> +                       size_t len =3D strlen(str);
> +                       struct btf_type *t;
> +
> +                       t =3D btf_type_by_id(obj->btf, j);
> +                       if (!btf_is_decl_tag(t) || btf_decl_tag(t)->compo=
nent_idx !=3D -1)
> +                               continue;
> +
> +                       name =3D btf__str_by_offset(obj->btf, t->name_off=
);
> +                       if (strncmp(name, str, len))
> +                               continue;
> +
> +                       t =3D btf_type_by_id(obj->btf, t->type);
> +                       if (!btf_is_func(t) || btf_func_linkage(t) !=3D B=
TF_FUNC_GLOBAL) {
> +                               pr_warn("prog '%s': exception_callback:<v=
alue> decl tag not applied to the main program\n",
> +                                       prog->name);
> +                               return -EINVAL;
> +                       }
> +                       if (strcmp(prog->name, btf__str_by_offset(obj->bt=
f, t->name_off)))
> +                               continue;
> +                       /* Multiple callbacks are specified for the same =
prog,
> +                        * the verifier will eventually return an error f=
or this
> +                        * case, hence simply skip appending a subprog.
> +                        */
> +                       if (prog->exception_cb_idx >=3D 0) {
> +                               prog->exception_cb_idx =3D -1;
> +                               break;
> +                       }

you check this condition three times and handle it in three different
ways, it's bizarre. Why?


> +
> +                       name +=3D len;
> +                       if (str_is_empty(name)) {
> +                               pr_warn("prog '%s': exception_callback:<v=
alue> decl tag contains empty value\n",
> +                                       prog->name);
> +                               return -EINVAL;
> +                       }
> +
> +                       for (k =3D 0; k < obj->nr_programs; k++) {
> +                               struct bpf_program *subprog =3D &obj->pro=
grams[k];
> +
> +                               if (!prog_is_subprog(obj, subprog))
> +                                       continue;
> +                               if (strcmp(name, subprog->name))
> +                                       continue;
> +                               /* Enforce non-hidden, as from verifier p=
oint of
> +                                * view it expects global functions, wher=
eas the
> +                                * mark_btf_static fixes up linkage as st=
atic.
> +                                */
> +                               if (!subprog->sym_global || subprog->mark=
_btf_static) {
> +                                       pr_warn("prog '%s': exception cal=
lback %s must be a global non-hidden function\n",
> +                                               prog->name, subprog->name=
);
> +                                       return -EINVAL;
> +                               }
> +                               /* Let's see if we already saw a static e=
xception callback with the same name */
> +                               if (prog->exception_cb_idx >=3D 0) {
> +                                       pr_warn("prog '%s': multiple subp=
rogs with same name as exception callback '%s'\n",
> +                                               prog->name, subprog->name=
);
> +                                       return -EINVAL;
> +                               }
> +                               prog->exception_cb_idx =3D k;
> +                               break;
> +                       }
> +
> +                       if (prog->exception_cb_idx >=3D 0)
> +                               continue;
> +                       pr_warn("prog '%s': cannot find exception callbac=
k '%s'\n", prog->name, name);
> +                       return -ENOENT;
> +               }
> +       }
> +skip_exception_cb:
> +
>         sanitize =3D btf_needs_sanitization(obj);
>         if (sanitize) {
>                 const void *raw_data;
> @@ -6270,10 +6355,10 @@ static int
>  bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_=
prog,
>                        struct bpf_program *prog)
>  {
> -       size_t sub_insn_idx, insn_idx, new_cnt;
> +       size_t sub_insn_idx, insn_idx;
>         struct bpf_program *subprog;
> -       struct bpf_insn *insns, *insn;
>         struct reloc_desc *relo;
> +       struct bpf_insn *insn;
>         int err;
>
>         err =3D reloc_prog_func_and_line_info(obj, main_prog, prog);
> @@ -6582,6 +6667,25 @@ bpf_object__relocate(struct bpf_object *obj, const=
 char *targ_btf_path)
>                                 prog->name, err);
>                         return err;
>                 }
> +
> +               /* Now, also append exception callback if it has not been=
 done already. */
> +               if (prog->exception_cb_idx >=3D 0) {
> +                       struct bpf_program *subprog =3D &obj->programs[pr=
og->exception_cb_idx];
> +
> +                       /* Calling exception callback directly is disallo=
wed, which the
> +                        * verifier will reject later. In case it was pro=
cessed already,
> +                        * we can skip this step, otherwise for all other=
 valid cases we
> +                        * have to append exception callback now.
> +                        */
> +                       if (subprog->sub_insn_off =3D=3D 0) {
> +                               err =3D bpf_object__append_subprog_code(o=
bj, prog, subprog);
> +                               if (err)
> +                                       return err;
> +                               err =3D bpf_object__reloc_code(obj, prog,=
 subprog);
> +                               if (err)
> +                                       return err;
> +                       }
> +               }
>         }
>         /* Process data relos for main programs */
>         for (i =3D 0; i < obj->nr_programs; i++) {
> --
> 2.41.0
>

