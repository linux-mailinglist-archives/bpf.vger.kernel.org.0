Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6876ACBCB
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 19:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjCFSAK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 13:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjCFR75 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 12:59:57 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5AE6BDFE;
        Mon,  6 Mar 2023 09:59:29 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id j11so22702835edq.4;
        Mon, 06 Mar 2023 09:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678125557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gg0UTvzcU1lKnHpcVhKw7iDvVBTyYGXF7PrHwEY8/6Q=;
        b=AWuVRoOjGdbqHweJGM2wv9dsJYnV2KA99ZekPDlWIV22UVPJ7irJnxhutnwjlfbzi4
         G6Srdh4pr8EmjT+M+G9ZtcB/bHaNlRt5q4WznslxB1cRVa6/QH6CZl38F5JbjvzxCBPD
         9Co6P0PPv2j8t+jaHXbvbr3EOyAiotLhWFjSnZ37FzPZMfWY+rwodu09vfObD8xucMwR
         TxX1sFjo9+k6K7u8Lccrk22vvQl5m/1C2+kIt5YH2cPb0GvzYpFVOqYEgxTaI4lkCCs9
         bkA4VAEXZGrC4GPx2OvPC8wdt0GD7Iv+4jYflYGH9G9rx02dP9jCUTS4kdYaEIPTcZd5
         FsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678125557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gg0UTvzcU1lKnHpcVhKw7iDvVBTyYGXF7PrHwEY8/6Q=;
        b=2Yh8brrmjUResF1DmCYVsaPCCysbU7ULo8NSa9hfOGjpODe/TzBtLxulFWuOhXlwuD
         vX4X42gQQvoVeLYW4rXWI2dTljL7PLohXVzETmN10q0XSni+HgxaF7vNRzopv1Md6/P2
         M7o/kRqNi2e81hhfLDsd9yBWsMEPPUfa234nb92vuLYEHAnT5A7SO3LRy9mvJ3G3WvaZ
         ESFANWoZCfsAnudS18Mx4EbNcVGgP/9vOSs0zrO42+ZWp6y8iYYsvbZ5RXQaa3qxdxKs
         6KUQ7yqqu/ENDxfTJaf4QJJMYv5ZZfWXdnyNDq97buL7mxQDlfMWMpyV+ugAN8h41mz6
         twnA==
X-Gm-Message-State: AO0yUKXPaxwKJpRgZs6HA7pLlLQCVrE+4VHyROuNU6TgV3ekRXIS50c1
        9Fb35rwqi2hzz4LrIemmXbkd6HXLMTmXigQlHsc=
X-Google-Smtp-Source: AK7set8Wq59e3HTaU+sa0XsSA9hK0YsNyKeE7a/T70uZSpEkRX+TfmNdp0dJEZTeUuA8ME1OcpJrZTvh1ozMxfQCWF4=
X-Received: by 2002:a50:8711:0:b0:4bb:d098:2138 with SMTP id
 i17-20020a508711000000b004bbd0982138mr6268354edb.5.1678125556625; Mon, 06 Mar
 2023 09:59:16 -0800 (PST)
MIME-Version: 1.0
References: <20230306064833.7932-1-imagedong@tencent.com> <20230306064833.7932-2-imagedong@tencent.com>
In-Reply-To: <20230306064833.7932-2-imagedong@tencent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 6 Mar 2023 09:59:04 -0800
Message-ID: <CAEf4Bza4mnLW7oEUp+_ZJntw=vVt=8sZG-OB7h=L910UTbraKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] libbpf: add support to set kprobe/uprobe
 attach mode
To:     menglong8.dong@gmail.com
Cc:     alan.maguire@oracle.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        benbjiang@tencent.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 5, 2023 at 10:48=E2=80=AFPM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> By default, libbpf will attach the kprobe/uprobe BPF program in the
> latest mode that supported by kernel. In this patch, we add the support
> to let users manually attach kprobe/uprobe in legacy or perf mode.
>
> There are 3 mode that supported by the kernel to attach kprobe/uprobe:
>
>   LEGACY: create perf event in legacy way and don't use bpf_link
>   PERF: create perf event with perf_event_open() and don't use bpf_link
>   LINK: create perf event with perf_event_open() and use bpf_link
>
> Users now can manually choose the mode with
> bpf_program__attach_uprobe_opts()/bpf_program__attach_kprobe_opts().
>
> Link: https://lore.kernel.org/bpf/20230113093427.1666466-1-imagedong@tenc=
ent.com/
> Reviewed-by: Biao Jiang <benbjiang@tencent.com>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---

I fixed few small issues I pointed out below and applied to bpf-next. Thank=
s!

> v4:
> - rename eBPF to BPF in the doc
> - use OPTS_GET() to get the value of 'force_ioctl_attach'
> - error out on attach mode is not supported
> v2:
> - rename no_link to force_ioctl_attach
> - rename probe_mode to probe_attach_mode
> - add more doc for probe_attach_mode
> - return -ENOTSUP when necessray in bpf_program__attach_uprobe_opts and
>   bpf_program__attach_kprobe_opts
> ---
>  tools/lib/bpf/libbpf.c | 47 +++++++++++++++++++++++++++++++++++++++++-
>  tools/lib/bpf/libbpf.h | 31 +++++++++++++++++++++++++---
>  2 files changed, 74 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index dacaae31b76a..77df4d275d22 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9747,7 +9747,8 @@ struct bpf_link *bpf_program__attach_perf_event_opt=
s(const struct bpf_program *p
>         link->link.dealloc =3D &bpf_link_perf_dealloc;
>         link->perf_event_fd =3D pfd;
>
> -       if (kernel_supports(prog->obj, FEAT_PERF_LINK)) {
> +       if (kernel_supports(prog->obj, FEAT_PERF_LINK) && !OPTS_GET(opts,=
 force_ioctl_attach,
> +                                                                   false=
)) {

too ugly, I added local variable for OPTS_GET() result

>                 DECLARE_LIBBPF_OPTS(bpf_link_create_opts, link_opts,
>                         .perf_event.bpf_cookie =3D OPTS_GET(opts, bpf_coo=
kie, 0));
>
> @@ -10106,6 +10107,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_=
program *prog,
>                                 const struct bpf_kprobe_opts *opts)
>  {
>         DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
> +       enum probe_attach_mode attach_mode;
>         char errmsg[STRERR_BUFSIZE];
>         char *legacy_probe =3D NULL;
>         struct bpf_link *link;
> @@ -10116,11 +10118,32 @@ bpf_program__attach_kprobe_opts(const struct bp=
f_program *prog,
>         if (!OPTS_VALID(opts, bpf_kprobe_opts))
>                 return libbpf_err_ptr(-EINVAL);
>
> +       attach_mode =3D OPTS_GET(opts, attach_mode, PROBE_ATTACH_MODE_DEF=
AULT);
>         retprobe =3D OPTS_GET(opts, retprobe, false);
>         offset =3D OPTS_GET(opts, offset, 0);
>         pe_opts.bpf_cookie =3D OPTS_GET(opts, bpf_cookie, 0);
>
>         legacy =3D determine_kprobe_perf_type() < 0;
> +       switch (attach_mode) {
> +       case PROBE_ATTACH_MODE_LEGACY:
> +               legacy =3D true;
> +               pe_opts.force_ioctl_attach =3D true;
> +               break;
> +       case PROBE_ATTACH_MODE_PERF:
> +               if (legacy)
> +                       return libbpf_err_ptr(-ENOTSUP);
> +               pe_opts.force_ioctl_attach =3D true;
> +               break;
> +       case PROBE_ATTACH_MODE_LINK:
> +               if (legacy || !kernel_supports(prog->obj, FEAT_PERF_LINK)=
)
> +                       return libbpf_err_ptr(-ENOTSUP);
> +               break;
> +       case PROBE_ATTACH_MODE_DEFAULT:
> +               break;
> +       default:
> +               return libbpf_err_ptr(-ENOTSUP);

this should have been -EINVAL, I changed it; same for another instance belo=
w

> +       }
> +
>         if (!legacy) {
>                 pfd =3D perf_event_open_probe(false /* uprobe */, retprob=
e,
>                                             func_name, offset,

[...]
