Return-Path: <bpf+bounces-3315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C31773C0A7
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 22:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56AA81C2129F
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 20:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CAE11CA7;
	Fri, 23 Jun 2023 20:41:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C3411C80
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 20:41:24 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196A730DA
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 13:40:55 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f883420152so1376332e87.1
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 13:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687552840; x=1690144840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9GSl7BGNkipSVlyQ1RnpLvPoBbTZROZPSRrEIltL9g=;
        b=ICZAqZBjtYjtrhmRk//ZgeV4yfgPJbdoEWNUrxJ6YjMjnOSenLWX7kQmS0x55ZPa/l
         HWnuL6IDbJepcpKpGUNU1Vgi4skXxgevaHHMvsJD/mkijFlXydVhYIQsXrmHmYI7lxlw
         A4rwrWHzvmKLpU6Tyzq7NXjsJk+4sl1+pEp7idKhncZlEzVP2a3KUzDQXmr2oIFJkwN7
         ++DfSsm6TleEEOhDov4hS/Pm4Zez5rTwZcClm/bu19yUrVKC12SHuj2zaT2kdV0Oqlc4
         3IpSaijX4UqoLIMSJGcr5a5dxfOlfVgl7p3+xJGVJ3NyksJwvsuKDOUwD9sW+vVrGMsN
         JsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687552840; x=1690144840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9GSl7BGNkipSVlyQ1RnpLvPoBbTZROZPSRrEIltL9g=;
        b=TkKRKM9gyrrH5VXitLgL0HTX7MMYoYRP2B07r+L+rxyNiCesKMKkJ+lscYUlMjfF64
         NcxwWXK+yDm/b0qAQ5LmbtMweeQI2U4dVNite2KyyPyeBmM8qlUtJaVjCQTwiL120tAC
         kB55nAK4e3wndfhJfJHC/7OemKOYUEUuMPopSr4NmmunDhb4w9ajZyvbu4W9Z0+HbT03
         xOv6XxWqJW2s5j/eVqqMit77g/YAyDqlur+Uneb6ZdlLOzaVsW3jWzDNTSUE0BiIZNrr
         ZZBuw+uRKNXZZ9UXMe+bCsj1lUw+Zs5B1NZ0lPYb31qfBk05pKfU4UYpDBaRacM+ZJCJ
         GYtA==
X-Gm-Message-State: AC+VfDzOQnW+g+OLoszIEDUFnO2k/pMjmeT7c5k7WUJwGmj0TzZKtWiW
	3dqf4XjJblHTZg5kV3suC53CuMcp3uGOi2sdHuw=
X-Google-Smtp-Source: ACHHUZ7Qw7J1iHVVFLPnyVEXet3ykGgmah6XHhbXwrdt9ToEhsfd195cRmcGchHo4rz1F1Y/i7upXl4cnCL/zsHZp7g=
X-Received: by 2002:ac2:5d28:0:b0:4f8:4255:16ca with SMTP id
 i8-20020ac25d28000000b004f8425516camr13339101lfb.38.1687552839658; Fri, 23
 Jun 2023 13:40:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620083550.690426-1-jolsa@kernel.org> <20230620083550.690426-15-jolsa@kernel.org>
In-Reply-To: <20230620083550.690426-15-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Jun 2023 13:40:27 -0700
Message-ID: <CAEf4Bza6=rxq8R3WGyqVf_KT3hX_SEKXZ5usk-QiCTRr=UgU5w@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 14/24] libbpf: Add uprobe multi link support to bpf_program__attach_usdt
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 1:38=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support for usdt_manager_attach_usdt to use uprobe_multi
> link to attach to usdt probes.
>
> The uprobe_multi support is detected before the usdt program is
> loaded and its expected_attach_type is set accordingly.
>
> If uprobe_multi support is detected the usdt_manager_attach_usdt
> gathers uprobes info and calls bpf_program__attach_uprobe_opts to
> create all needed uprobes.
>
> If uprobe_multi support is not detected the old behaviour stays.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c |  12 ++++-
>  tools/lib/bpf/usdt.c   | 120 ++++++++++++++++++++++++++++++-----------
>  2 files changed, 99 insertions(+), 33 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 3d570898459e..9c7a67c5cbe8 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -363,6 +363,8 @@ enum sec_def_flags {
>         SEC_SLEEPABLE =3D 8,
>         /* BPF program support non-linear XDP buffer */
>         SEC_XDP_FRAGS =3D 16,
> +       /* Setup proper attach type for usdt probes. */
> +       SEC_USDT =3D 32,
>  };
>
>  struct bpf_sec_def {
> @@ -6799,6 +6801,10 @@ static int libbpf_prepare_prog_load(struct bpf_pro=
gram *prog,
>         if (prog->type =3D=3D BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
>                 opts->prog_flags |=3D BPF_F_XDP_HAS_FRAGS;
>
> +       /* special check for usdt to use uprobe_multi link */
> +       if ((def & SEC_USDT) && kernel_supports(NULL, FEAT_UPROBE_LINK))
> +               prog->expected_attach_type =3D BPF_TRACE_UPROBE_MULTI;

this is quite ugly. I think KPROBE programs do not have enforcement
for expected_attach_type during BPF_PROG_LOAD, so we can set
BPF_TRACE_UPROBE_MULTI unconditionally, right?

> +
>         if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
>                 int btf_obj_fd =3D 0, btf_type_id =3D 0, err;
>                 const char *attach_name;
> @@ -6867,7 +6873,6 @@ static int bpf_object_load_prog(struct bpf_object *=
obj, struct bpf_program *prog
>         if (!insns || !insns_cnt)
>                 return -EINVAL;
>
> -       load_attr.expected_attach_type =3D prog->expected_attach_type;
>         if (kernel_supports(obj, FEAT_PROG_NAME))
>                 prog_name =3D prog->name;
>         load_attr.attach_prog_fd =3D prog->attach_prog_fd;
> @@ -6903,6 +6908,9 @@ static int bpf_object_load_prog(struct bpf_object *=
obj, struct bpf_program *prog
>                 insns_cnt =3D prog->insns_cnt;
>         }
>
> +       /* allow prog_prepare_load_fn to change expected_attach_type */
> +       load_attr.expected_attach_type =3D prog->expected_attach_type;
> +
>         if (obj->gen_loader) {
>                 bpf_gen__prog_load(obj->gen_loader, prog->type, prog->nam=
e,
>                                    license, insns, insns_cnt, &load_attr,
> @@ -8703,7 +8711,7 @@ static const struct bpf_sec_def section_defs[] =3D =
{
>         SEC_DEF("uretprobe.multi.s+",   KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_SLEEPABLE, attach_uprobe_multi),
>         SEC_DEF("ksyscall+",            KPROBE, 0, SEC_NONE, attach_ksysc=
all),
>         SEC_DEF("kretsyscall+",         KPROBE, 0, SEC_NONE, attach_ksysc=
all),
> -       SEC_DEF("usdt+",                KPROBE, 0, SEC_NONE, attach_usdt)=
,
> +       SEC_DEF("usdt+",                KPROBE, 0, SEC_USDT, attach_usdt)=
,

btw, given you are touching USDT stuff, can you please also add
sleepable USDT (usdt.s+) ?


>         SEC_DEF("tc",                   SCHED_CLS, 0, SEC_NONE),
>         SEC_DEF("classifier",           SCHED_CLS, 0, SEC_NONE),
>         SEC_DEF("action",               SCHED_ACT, 0, SEC_NONE),
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index f1a141555f08..33f0a2b4cc1c 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -808,6 +808,16 @@ struct bpf_link_usdt {
>                 long abs_ip;
>                 struct bpf_link *link;
>         } *uprobes;
> +
> +       bool has_uprobe_multi;
> +
> +       struct {
> +               char *path;
> +               unsigned long *offsets;
> +               unsigned long *ref_ctr_offsets;
> +               __u64 *cookies;

you shouldn't need to persist this, this can be allocated and freed
inside usdt_manager_attach_usdt(), you only need the link pointer


> +               struct bpf_link *link;
> +       } uprobe_multi;
>  };
>
>  static int bpf_link_usdt_detach(struct bpf_link *link)
> @@ -816,19 +826,23 @@ static int bpf_link_usdt_detach(struct bpf_link *li=
nk)
>         struct usdt_manager *man =3D usdt_link->usdt_man;
>         int i;
>
> -       for (i =3D 0; i < usdt_link->uprobe_cnt; i++) {
> -               /* detach underlying uprobe link */
> -               bpf_link__destroy(usdt_link->uprobes[i].link);
> -               /* there is no need to update specs map because it will b=
e
> -                * unconditionally overwritten on subsequent USDT attache=
s,
> -                * but if BPF cookies are not used we need to remove entr=
y
> -                * from ip_to_spec_id map, otherwise we'll run into false
> -                * conflicting IP errors
> -                */
> -               if (!man->has_bpf_cookie) {
> -                       /* not much we can do about errors here */
> -                       (void)bpf_map_delete_elem(bpf_map__fd(man->ip_to_=
spec_id_map),
> -                                                 &usdt_link->uprobes[i].=
abs_ip);
> +       if (usdt_link->has_uprobe_multi) {
> +               bpf_link__destroy(usdt_link->uprobe_multi.link);
> +       } else {
> +               for (i =3D 0; i < usdt_link->uprobe_cnt; i++) {
> +                       /* detach underlying uprobe link */
> +                       bpf_link__destroy(usdt_link->uprobes[i].link);
> +                       /* there is no need to update specs map because i=
t will be
> +                        * unconditionally overwritten on subsequent USDT=
 attaches,
> +                        * but if BPF cookies are not used we need to rem=
ove entry
> +                        * from ip_to_spec_id map, otherwise we'll run in=
to false
> +                        * conflicting IP errors
> +                        */
> +                       if (!man->has_bpf_cookie) {
> +                               /* not much we can do about errors here *=
/
> +                               (void)bpf_map_delete_elem(bpf_map__fd(man=
->ip_to_spec_id_map),
> +                                                         &usdt_link->upr=
obes[i].abs_ip);
> +                       }
>                 }

you can avoid shifting all this by keeping uprobe_cnt to zero

bpf_link__destory(usdt_link->uprobe_multi.link) will work fine for NULL

so just do both clean ups sequentially, knowing that only one of them
will actually do anything

>         }
>
> @@ -868,9 +882,15 @@ static void bpf_link_usdt_dealloc(struct bpf_link *l=
ink)
>  {
>         struct bpf_link_usdt *usdt_link =3D container_of(link, struct bpf=
_link_usdt, link);
>
> -       free(usdt_link->spec_ids);
> -       free(usdt_link->uprobes);
> -       free(usdt_link);
> +       if (usdt_link->has_uprobe_multi) {
> +               free(usdt_link->uprobe_multi.offsets);
> +               free(usdt_link->uprobe_multi.ref_ctr_offsets);
> +               free(usdt_link->uprobe_multi.cookies);
> +       } else {
> +               free(usdt_link->spec_ids);
> +               free(usdt_link->uprobes);
> +               free(usdt_link);
> +       }

similar to the above, just do *all* the clean up unconditionally and
rely on free() handling NULLs just fine

>  }
>
>  static size_t specs_hash_fn(long key, void *ctx)
> @@ -943,11 +963,13 @@ struct bpf_link *usdt_manager_attach_usdt(struct us=
dt_manager *man, const struct
>                                           const char *usdt_provider, cons=
t char *usdt_name,
>                                           __u64 usdt_cookie)
>  {
> +       LIBBPF_OPTS(bpf_uprobe_multi_opts, opts_multi);
>         int i, fd, err, spec_map_fd, ip_map_fd;
>         LIBBPF_OPTS(bpf_uprobe_opts, opts);
>         struct hashmap *specs_hash =3D NULL;
>         struct bpf_link_usdt *link =3D NULL;
>         struct usdt_target *targets =3D NULL;
> +       struct bpf_link *uprobe_link;
>         size_t target_cnt;
>         Elf *elf;
>
> @@ -1003,16 +1025,29 @@ struct bpf_link *usdt_manager_attach_usdt(struct =
usdt_manager *man, const struct
>         link->usdt_man =3D man;
>         link->link.detach =3D &bpf_link_usdt_detach;
>         link->link.dealloc =3D &bpf_link_usdt_dealloc;
> +       link->has_uprobe_multi =3D bpf_program__expected_attach_type(prog=
) =3D=3D BPF_TRACE_UPROBE_MULTI;

just use kernel_supports(), it's cleaner (and result is cached, so
it's not less efficient)

>
> -       link->uprobes =3D calloc(target_cnt, sizeof(*link->uprobes));
> -       if (!link->uprobes) {
> -               err =3D -ENOMEM;
> -               goto err_out;
> +       if (link->has_uprobe_multi) {
> +               link->uprobe_multi.offsets =3D calloc(target_cnt, sizeof(=
*link->uprobe_multi.offsets));
> +               link->uprobe_multi.ref_ctr_offsets =3D calloc(target_cnt,=
 sizeof(*link->uprobe_multi.ref_ctr_offsets));
> +               link->uprobe_multi.cookies =3D calloc(target_cnt, sizeof(=
*link->uprobe_multi.cookies));
> +
> +               if (!link->uprobe_multi.offsets ||
> +                   !link->uprobe_multi.ref_ctr_offsets ||
> +                   !link->uprobe_multi.cookies) {
> +                       err =3D -ENOMEM;
> +                       goto err_out;
> +               }
> +       } else {
> +               link->uprobes =3D calloc(target_cnt, sizeof(*link->uprobe=
s));
> +               if (!link->uprobes) {
> +                       err =3D -ENOMEM;
> +                       goto err_out;
> +               }
>         }
>

[...]

