Return-Path: <bpf+bounces-3313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E7373C0A5
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 22:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F981C2133A
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 20:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF728125A5;
	Fri, 23 Jun 2023 20:41:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8955711C80
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 20:41:10 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BBD30CB
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 13:40:38 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f90a7325f6so12914265e9.3
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 13:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687552826; x=1690144826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MZi6V+v1MYQf5Qxzp71SXPVh+NM+M1Z7D/xVoOkD4k=;
        b=ct1xuMZUNl7JkmtxBsZlCZsjc9cJ4MKl/m7p3p3Dbamtf9NnOgqFNII03iqXkec00f
         k89gmeRBsEWnGwpkhrOLqu1do/KLTv7Pc7CX7O9nsBy83G01jyxXOC5602+H84mcC4Cv
         D6BXrY0fM/LeWMKMegNHM5tHlSSoA3dwCqSETEum3WCkeKRNUql0uCUSOySE2BzBhsJC
         Hv2m/ViKqgTQ8caqRMmCMqQkhSoy4frLC1u3mf3esRwKVbgzxrxghTzabaIual3VWh2P
         prb5jb20Ewrj2ycjdnmgX8LbPTlCw2YEQm6BSl3ndBfxhKah1IMcYEZ83TCx2elmtfBW
         y3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687552826; x=1690144826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MZi6V+v1MYQf5Qxzp71SXPVh+NM+M1Z7D/xVoOkD4k=;
        b=GFwCCvbTWZGuNGA4YozLEa+QMJVoF5lmfbhfDhXEUI7MTAYP93tNOkkCgxkE0RgIB4
         9vM2xEdJBBM5dCZ7cbWcqxeX4qfqf4OOvjghYOb0owNyvQgQHjkMmw3PdubbBNR901dX
         wv0V9c1uPm3naW3Oe6LgM6wOi0B7AEsxKEaDi6gQbOQjscNwEUQU3f4jTWLbGP8we7wI
         ylOMZdaf5f6w6+cfa2Q1oBXsbsAzGaD9Ixwcofw8aM9wh0weSpBpdwel1OA/scOu0Fa8
         0R4yRgZ6pElPaaS4dVJCQYeEITn3+F9ZJCax64Z4dWg9FfHXUL1yXI9jll6txRgbAgEu
         W7Tw==
X-Gm-Message-State: AC+VfDwUHGBjvxLBdoVYo0wAJfWIviR46dNH2W3uhPdS/v4LZOS1GqGm
	nN8fyxgmMHCzKAl/l+yXnd0YMmTKbE2Nbfw1OrM=
X-Google-Smtp-Source: ACHHUZ6wUcpruv4QOgPdLJVJv/mkXQ0M/AtmtaktcL46l0csU6BFy8cgnFiGYaGj8XJpQPNdWHzK2s6BmjVF3INQ8og=
X-Received: by 2002:a7b:c3d3:0:b0:3f9:b7cf:262f with SMTP id
 t19-20020a7bc3d3000000b003f9b7cf262fmr9843217wmj.4.1687552825980; Fri, 23 Jun
 2023 13:40:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620083550.690426-1-jolsa@kernel.org> <20230620083550.690426-13-jolsa@kernel.org>
In-Reply-To: <20230620083550.690426-13-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Jun 2023 13:40:13 -0700
Message-ID: <CAEf4BzYg8objHgvCtWegVk6JpGxYO6+F4GcSaeEFG5m+Y7Jv-Q@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 12/24] libbpf: Add support for
 u[ret]probe.multi[.s] program sections
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

On Tue, Jun 20, 2023 at 1:37=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support for several uprobe_multi program sections
> to allow auto attach of multi_uprobe programs.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index d972cea4c658..e42080258ec7 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8652,6 +8652,7 @@ static int attach_tp(const struct bpf_program *prog=
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
> @@ -8667,6 +8668,10 @@ static const struct bpf_sec_def section_defs[] =3D=
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
> +       SEC_DEF("uprobe.multi.s+",      KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_SLEEPABLE, attach_uprobe_multi),
> +       SEC_DEF("uretprobe.multi.s+",   KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_SLEEPABLE, attach_uprobe_multi),
>         SEC_DEF("ksyscall+",            KPROBE, 0, SEC_NONE, attach_ksysc=
all),
>         SEC_DEF("kretsyscall+",         KPROBE, 0, SEC_NONE, attach_ksysc=
all),
>         SEC_DEF("usdt+",                KPROBE, 0, SEC_NONE, attach_usdt)=
,
> @@ -10728,6 +10733,41 @@ static int attach_kprobe_multi(const struct bpf_=
program *prog, long cookie, stru
>         return libbpf_get_error(*link);
>  }
>
> +static int attach_uprobe_multi(const struct bpf_program *prog, long cook=
ie, struct bpf_link **link)
> +{
> +       char *probe_type =3D NULL, *binary_path =3D NULL, *func_name =3D =
NULL;
> +       LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
> +       int n, ret =3D -EINVAL;
> +
> +       *link =3D NULL;
> +
> +       n =3D sscanf(prog->sec_name, "%m[^/]/%m[^:]:%ms",
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

message copy/pasted? We don't support +offset part, and it's not
"function", but "pattern" or something along those lines?

> +                       prog->name, prog->sec_name);
> +               break;
> +       case 3:
> +               opts.retprobe =3D strcmp(probe_type, "uretprobe.multi");

=3D=3D 0


> +               *link =3D bpf_program__attach_uprobe_multi_opts(prog, -1,=
 binary_path, func_name, &opts);
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
> 2.41.0
>

