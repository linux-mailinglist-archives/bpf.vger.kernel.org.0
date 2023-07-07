Return-Path: <bpf+bounces-4396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7E074A9EC
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 06:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060B12815E3
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 04:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3211FB2;
	Fri,  7 Jul 2023 04:29:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BC81876
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 04:29:54 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CF110F3
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 21:29:49 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so18524305e9.2
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 21:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688704187; x=1691296187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmmN30y6+2gNfZUWr/UldNIz1oGHyFQipQWCz38ps6A=;
        b=eORAGG2+zQ0zv7it2r+x2Zy9kJmNDJPFv+s+xsUBZnVKy/eRkzYM6iWDxpA7NBOzHd
         au+ACnDd3Ercl9Gew3nfrh/EWzgWQAa8zHeM+Wrxw9gxi7YKfsrVbFp6dJfU4UXtXfvj
         G17LGawwITNdqXISFFH6d1V1yDWJi4LihM0T/hkb3H64eqY+uid3KRsGcYeznPrEoRt9
         x7gHeSEqvTeNrIPVo3GgXSba5bgZFptsMmSwR3q5gpPa8NG+D7jgL+ExE/raT4HQgSbv
         AXwLh5Kirtybc+BiwyOsC8/OJdfZ4ub80Gvaw6cz7COLIUs7doOFd41ClQ99/Opd/aLE
         U2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688704187; x=1691296187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmmN30y6+2gNfZUWr/UldNIz1oGHyFQipQWCz38ps6A=;
        b=NFGpPmTRhjEwmD3IT1Gp1g/5vD+Xjlvf6DsoYhF3vCjSCsHpB6eDz3BtLpqbKjfaBe
         IMfHSzakcYgF7gG4SDjfm4Ot8fxKZTigs7GP3RfoDHQwExKxP4RDPqKbiwyMgyjeABtz
         xV2YazHq+YOAxVlT9gsIcuWZ5WKpRqzNduGTK4T7mhCeLeqWgrNHmaTbHADR3lHyROow
         za8HLmKK2O8N6rAwEeJFrRm8wvovc0hsf/dPZiNT5GjA2OhjyeiRM8XuPRcVCvAU266A
         nIVpBq35b8kl0RlG2mzW92rD4vDGFO6aIyRuBDSE9s4aJnt8ks84sGoLu6owOhNjluRY
         Upkg==
X-Gm-Message-State: ABy/qLbsP0woDGup6Y3YGc1tA23yACh53PLx7bUkIQ6rHLjjgXAoSutx
	/dk5YIQy+MPKJCGVyJds5g6gvlRAzPHXb5TNhG8=
X-Google-Smtp-Source: APBJJlHP71bUJgZ54j4AiJroJ4ON0vrTcSDf2SHkkdcIV9AMEeoTCSWdsdYzkUv/oCY6IcKt9ACXx4QeSR+mdWtN+dU=
X-Received: by 2002:a7b:c415:0:b0:3fb:fa26:45a8 with SMTP id
 k21-20020a7bc415000000b003fbfa2645a8mr1852188wmi.28.1688704187221; Thu, 06
 Jul 2023 21:29:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-17-jolsa@kernel.org>
In-Reply-To: <20230630083344.984305-17-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 21:29:35 -0700
Message-ID: <CAEf4Bzb=NjO5eqYcx8oa3nOoPXt83MA54Om=aUqn4aTJFCSHmg@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 16/26] libbpf: Add uprobe multi link support to bpf_program__attach_usdt
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

On Fri, Jun 30, 2023 at 1:37=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support for usdt_manager_attach_usdt to use uprobe_multi
> link to attach to usdt probes.
>
> The uprobe_multi support is detected before the usdt program is
> loaded and its expected_attach_type is set accordingly.
>
> If uprobe_multi support is detected the usdt_manager_attach_usdt
> gathers uprobes info and calls bpf_program__attach_uprobe to
> create all needed uprobes.
>
> If uprobe_multi support is not detected the old behaviour stays.
>
> Also adding usdt.s program section for sleepable usdt probes.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 13 +++++--
>  tools/lib/bpf/usdt.c   | 78 ++++++++++++++++++++++++++++++++++--------
>  2 files changed, 75 insertions(+), 16 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 4f61f9dc1748..e234c2e860f9 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -365,6 +365,8 @@ enum sec_def_flags {
>         SEC_SLEEPABLE =3D 8,
>         /* BPF program support non-linear XDP buffer */
>         SEC_XDP_FRAGS =3D 16,
> +       /* Setup proper attach type for usdt probes. */
> +       SEC_USDT =3D 32,
>  };
>
>  struct bpf_sec_def {
> @@ -6807,6 +6809,10 @@ static int libbpf_prepare_prog_load(struct bpf_pro=
gram *prog,
>         if (prog->type =3D=3D BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
>                 opts->prog_flags |=3D BPF_F_XDP_HAS_FRAGS;
>
> +       /* special check for usdt to use uprobe_multi link */
> +       if ((def & SEC_USDT) && kernel_supports(NULL, FEAT_UPROBE_MULTI_L=
INK))

please pass prog->obj to kernel_supports(), it will be especially
important later with BPF token stuff

> +               prog->expected_attach_type =3D BPF_TRACE_UPROBE_MULTI;
> +
>         if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
>                 int btf_obj_fd =3D 0, btf_type_id =3D 0, err;
>                 const char *attach_name;
> @@ -6875,7 +6881,6 @@ static int bpf_object_load_prog(struct bpf_object *=
obj, struct bpf_program *prog
>         if (!insns || !insns_cnt)
>                 return -EINVAL;
>
> -       load_attr.expected_attach_type =3D prog->expected_attach_type;
>         if (kernel_supports(obj, FEAT_PROG_NAME))
>                 prog_name =3D prog->name;
>         load_attr.attach_prog_fd =3D prog->attach_prog_fd;
> @@ -6911,6 +6916,9 @@ static int bpf_object_load_prog(struct bpf_object *=
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
> @@ -8711,7 +8719,8 @@ static const struct bpf_sec_def section_defs[] =3D =
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
> +       SEC_DEF("usdt.s+",              KPROBE, 0, SEC_USDT|SEC_SLEEPABLE=
, attach_usdt),

spaces around |

>         SEC_DEF("tc",                   SCHED_CLS, 0, SEC_NONE),
>         SEC_DEF("classifier",           SCHED_CLS, 0, SEC_NONE),
>         SEC_DEF("action",               SCHED_ACT, 0, SEC_NONE),
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index 9fa883ebc0bd..6ff66a8eaf85 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -809,6 +809,8 @@ struct bpf_link_usdt {
>                 long abs_ip;
>                 struct bpf_link *link;
>         } *uprobes;
> +
> +       struct bpf_link *multi_link;
>  };
>
>  static int bpf_link_usdt_detach(struct bpf_link *link)
> @@ -817,6 +819,9 @@ static int bpf_link_usdt_detach(struct bpf_link *link=
)
>         struct usdt_manager *man =3D usdt_link->usdt_man;
>         int i;
>
> +       /* When having multi_link, uprobe_cnt is 0 */

misplaced comment, move down to for() loop?

> +       bpf_link__destroy(usdt_link->multi_link);
> +
>         for (i =3D 0; i < usdt_link->uprobe_cnt; i++) {
>                 /* detach underlying uprobe link */
>                 bpf_link__destroy(usdt_link->uprobes[i].link);
> @@ -944,11 +949,13 @@ struct bpf_link *usdt_manager_attach_usdt(struct us=
dt_manager *man, const struct
>                                           const char *usdt_provider, cons=
t char *usdt_name,
>                                           __u64 usdt_cookie)
>  {
> +       unsigned long *offsets =3D NULL, *ref_ctr_offsets =3D NULL;
>         int i, err, spec_map_fd, ip_map_fd;
>         LIBBPF_OPTS(bpf_uprobe_opts, opts);
>         struct hashmap *specs_hash =3D NULL;
>         struct bpf_link_usdt *link =3D NULL;
>         struct usdt_target *targets =3D NULL;
> +       __u64 *cookies =3D NULL;
>         struct elf_fd elf_fd;
>         size_t target_cnt;
>
> @@ -995,10 +1002,21 @@ struct bpf_link *usdt_manager_attach_usdt(struct u=
sdt_manager *man, const struct
>         link->link.detach =3D &bpf_link_usdt_detach;
>         link->link.dealloc =3D &bpf_link_usdt_dealloc;
>
> -       link->uprobes =3D calloc(target_cnt, sizeof(*link->uprobes));
> -       if (!link->uprobes) {
> -               err =3D -ENOMEM;
> -               goto err_out;
> +       if (kernel_supports(NULL, FEAT_UPROBE_MULTI_LINK)) {

see how we feature-detect has_sema_refcnt and has_bpf_cookie, let's do
the same with UPROBE_MULTI_LINK, detect once, remember, consistently
use it (it also matters later for BPF token)

> +               offsets =3D calloc(target_cnt, sizeof(*offsets));
> +               cookies =3D calloc(target_cnt, sizeof(*cookies));
> +               ref_ctr_offsets =3D calloc(target_cnt, sizeof(*ref_ctr_of=
fsets));
> +
> +               if (!offsets || !ref_ctr_offsets || !cookies) {
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
>         for (i =3D 0; i < target_cnt; i++) {
> @@ -1039,20 +1057,48 @@ struct bpf_link *usdt_manager_attach_usdt(struct =
usdt_manager *man, const struct
>                         goto err_out;
>                 }
>
> -               opts.ref_ctr_offset =3D target->sema_off;
> -               opts.bpf_cookie =3D man->has_bpf_cookie ? spec_id : 0;
> -               uprobe_link =3D bpf_program__attach_uprobe_opts(prog, pid=
, path,
> -                                                             target->rel=
_ip, &opts);
> -               err =3D libbpf_get_error(uprobe_link);
> +               if (kernel_supports(NULL, FEAT_UPROBE_MULTI_LINK)) {
> +                       offsets[i] =3D target->rel_ip;
> +                       ref_ctr_offsets[i] =3D target->sema_off;
> +                       cookies[i] =3D spec_id;
> +               } else {
> +                       opts.ref_ctr_offset =3D target->sema_off;
> +                       opts.bpf_cookie =3D man->has_bpf_cookie ? spec_id=
 : 0;
> +                       uprobe_link =3D bpf_program__attach_uprobe_opts(p=
rog, pid, path,
> +                                                                     tar=
get->rel_ip, &opts);
> +                       err =3D libbpf_get_error(uprobe_link);
> +                       if (err) {
> +                               pr_warn("usdt: failed to attach uprobe #%=
d for '%s:%s' in '%s': %d\n",
> +                                       i, usdt_provider, usdt_name, path=
, err);
> +                               goto err_out;
> +                       }
> +
> +                       link->uprobes[i].link =3D uprobe_link;
> +                       link->uprobes[i].abs_ip =3D target->abs_ip;
> +                       link->uprobe_cnt++;
> +               }
> +       }
> +
> +       if (kernel_supports(NULL, FEAT_UPROBE_MULTI_LINK)) {

same as above, we should feature-detect once per usdt_manager while we
have associated bpf_object

> +               LIBBPF_OPTS(bpf_uprobe_multi_opts, opts_multi,
> +                       .cnt =3D target_cnt,
> +                       .offsets =3D offsets,
> +                       .ref_ctr_offsets =3D ref_ctr_offsets,
> +                       .cookies =3D cookies,
> +               );
> +
> +               link->multi_link =3D bpf_program__attach_uprobe_multi(pro=
g, pid, path,
> +                                                                   NULL,=
 &opts_multi);
> +               err =3D libbpf_get_error(link->multi_link);

let's not use libbpf_get_error() in new code, there is no need, just
`err =3D -errno` and `if (!link->multi_link)`

>                 if (err) {
> -                       pr_warn("usdt: failed to attach uprobe #%d for '%=
s:%s' in '%s': %d\n",
> -                               i, usdt_provider, usdt_name, path, err);
> +                       pr_warn("usdt: failed to attach uprobe multi for =
'%s:%s' in '%s': %d\n",
> +                               usdt_provider, usdt_name, path, err);
>                         goto err_out;
>                 }
>
> -               link->uprobes[i].link =3D uprobe_link;
> -               link->uprobes[i].abs_ip =3D target->abs_ip;
> -               link->uprobe_cnt++;
> +               free(offsets);
> +               free(ref_ctr_offsets);
> +               free(cookies);
>         }
>
>         free(targets);
> @@ -1061,6 +1107,10 @@ struct bpf_link *usdt_manager_attach_usdt(struct u=
sdt_manager *man, const struct
>         return &link->link;
>
>  err_out:
> +       free(offsets);
> +       free(ref_ctr_offsets);
> +       free(cookies);
> +
>         if (link)
>                 bpf_link__destroy(&link->link);
>         free(targets);
> --
> 2.41.0
>

