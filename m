Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257F76EFB1B
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 21:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjDZTbi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 15:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjDZTbh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 15:31:37 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936C41BC9
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:31:36 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94f6c285d92so1435875866b.3
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682537495; x=1685129495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAuhENIDW+mPHz/TqlUb/yS++0lqkXi8gSsihTMP/ZM=;
        b=CD4lHdl14j+WXSbBjD+J77TFPyxabpS4U7PYXQDwKKtyB6z2CRafgkj0Fnzu3q+QUk
         d61dTAdvfwiBCeR0nMMjdn5ZPRP6OrAgFeWaRgsWtAIyGcvnQoNjyKwx6De6SueDPQ5n
         Ha5uIwyG6Wmi6TOcdeY9TcONSYBrlYOyrQUhFFmxdVGhj2WI4mGZE8ykEtLHLMz60ieV
         Ps+ruvtPKPNT8xyZwpKsxOicKx2+JVwO+0xJquSOxoqvygH9i6W7Tu8PxbZVZV+n9hUx
         jDOlk8AKPi6SpYPSpOep2oV0xVmXNet/zUMGUif6bJshAWEUyGl1Gv+OgL3YCyjLEPWk
         783A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682537495; x=1685129495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAuhENIDW+mPHz/TqlUb/yS++0lqkXi8gSsihTMP/ZM=;
        b=HVZ/4DGs7G2Q4Jh+/J2HXkzI+Q5bJ4DEe+cEiiaee5sfqEV8zsH+5MDH8gOgEurQuS
         duys6RJqIHiCfE1dkBu/bzu8suniGO0GaDy0G/9ofe4+h6HLWnzwaPspOx9zDjoAfb6u
         +DwZ3uiyTV9T6XFfjxgg5pvL2NMedrerRaCZgjdz51kq+y625gcSDmvGiMT5DeHPkjOp
         icJNFYoi7ZiuLstG5w+mslcwiOUibP796TBq5asW76CjbNEisBtQn4pbAZZfhnD5kpaR
         09sLgkEhtg+3lGbuxRol4IlQzSn0HmR+pZehfayvhGjykCZyY1kcbUzrZRJ2K++GeuQU
         vHpg==
X-Gm-Message-State: AAQBX9cHCVfd1v/mL6kxwbPkdArwbJBgcOMMuwZJnpwh3bgpYiBwPlnj
        vLxJb1QaJWIfZx/vPrJKrlobqo2+7chOWc+TFZs=
X-Google-Smtp-Source: AKy350aX2OhHoSjfqkoPft3MioA3VNNYBqNQseRWXPDQf+l2iUdK7x33aBifGspbpaJEFucetCUGO3ui6q15C55u+GQ=
X-Received: by 2002:a17:906:830d:b0:94f:4d4d:23 with SMTP id
 j13-20020a170906830d00b0094f4d4d0023mr21276922ejx.68.1682537494975; Wed, 26
 Apr 2023 12:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230424160447.2005755-1-jolsa@kernel.org> <20230424160447.2005755-12-jolsa@kernel.org>
In-Reply-To: <20230424160447.2005755-12-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Apr 2023 12:31:22 -0700
Message-ID: <CAEf4BzbgOP2gvwh_oWb-V6UfgGwo4Wwzja_cEdJfvzB8VqL5zw@mail.gmail.com>
Subject: Re: [RFC/PATCH bpf-next 11/20] libbpf: Add support for
 uprobe.multi/uprobe.multi program sections
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 24, 2023 at 9:06=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support for uprobe.multi/uprobe.multi program sections
> to allow auto attach of multi_uprobe programs.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index c786bc142791..70353aaac86e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8628,6 +8628,7 @@ static int attach_tp(const struct bpf_program *prog=
, long cookie, struct bpf_lin
>  static int attach_raw_tp(const struct bpf_program *prog, long cookie, st=
ruct bpf_link **link);
>  static int attach_trace(const struct bpf_program *prog, long cookie, str=
uct bpf_link **link);
>  static int attach_kprobe_multi(const struct bpf_program *prog, long cook=
ie, struct bpf_link **link);
> +static int attach_uprobe_multi(const struct bpf_program *prog, long cook=
ie, struct bpf_link **link);
>  static int attach_lsm(const struct bpf_program *prog, long cookie, struc=
t bpf_link **link);
>  static int attach_iter(const struct bpf_program *prog, long cookie, stru=
ct bpf_link **link);
>
> @@ -8643,6 +8644,8 @@ static const struct bpf_sec_def section_defs[] =3D =
{
>         SEC_DEF("uretprobe.s+",         KPROBE, 0, SEC_SLEEPABLE, attach_=
uprobe),
>         SEC_DEF("kprobe.multi+",        KPROBE, BPF_TRACE_KPROBE_MULTI, S=
EC_NONE, attach_kprobe_multi),
>         SEC_DEF("kretprobe.multi+",     KPROBE, BPF_TRACE_KPROBE_MULTI, S=
EC_NONE, attach_kprobe_multi),
> +       SEC_DEF("uprobe.multi+",        KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_NONE, attach_uprobe_multi),
> +       SEC_DEF("uretprobe.multi+",     KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_NONE, attach_uprobe_multi),
>         SEC_DEF("ksyscall+",            KPROBE, 0, SEC_NONE, attach_ksysc=
all),
>         SEC_DEF("kretsyscall+",         KPROBE, 0, SEC_NONE, attach_ksysc=
all),
>         SEC_DEF("usdt+",                KPROBE, 0, SEC_NONE, attach_usdt)=
,
> @@ -10611,6 +10614,41 @@ static int attach_kprobe_multi(const struct bpf_=
program *prog, long cookie, stru
>         return libbpf_get_error(*link);
>  }
>
> +static int attach_uprobe_multi(const struct bpf_program *prog, long cook=
ie, struct bpf_link **link)
> +{
> +       LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
> +       char *probe_type =3D NULL, *binary_path =3D NULL, *func_name =3D =
NULL;
> +       int n, ret =3D -EINVAL;
> +
> +       *link =3D NULL;
> +
> +       n =3D sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.*?]+",

Arnaldo recently brought to my attention that Go doesn't do mangling,
so their function names are crazy, e.g.:

"go/doc/comment.(*parseDoc).code"

So we should think about making no assumptions about pattern inside
`%m[a-zA-Z0-9_.*?]`

> +                  &probe_type, &binary_path, &func_name);
> +       switch (n) {
> +       case 1:
> +               /* handle SEC("u[ret]probe") - format is valid, but auto-=
attach is impossible. */
> +               ret =3D 0;
> +               break;
> +       case 2:
> +               pr_warn("prog '%s': section '%s' missing ':function[+offs=
et]' specification\n",
> +                       prog->name, prog->sec_name);
> +               break;
> +       case 3:
> +               opts.retprobe =3D strcmp(probe_type, "uretprobe.multi");
> +               *link =3D bpf_program__attach_uprobe_multi_opts(prog, bin=
ary_path, func_name, &opts);
> +               ret =3D libbpf_get_error(*link);
> +               break;
> +       default:
> +               pr_warn("prog '%s': invalid format of section definition =
'%s'\n", prog->name,
> +                       prog->sec_name);
> +               break;
> +       }
> +       free(probe_type);
> +       free(binary_path);
> +       free(func_name);
> +       return ret;
> +}
> +
>  static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
>                                          const char *binary_path, uint64_=
t offset)
>  {
> --
> 2.40.0
>
