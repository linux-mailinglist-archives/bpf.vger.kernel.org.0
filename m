Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E536BF509
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 23:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCQWXl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 18:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjCQWXg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 18:23:36 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1DA4FAB9
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 15:23:35 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id fd5so25772159edb.7
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 15:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679091813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o00kGkLyKpkzx7W0Fkuu/iHFAs1OjQtHhFCy5o2OXOc=;
        b=LFPUy6YHn+t1gqUOAOwgY5tT3faFioBX9sW9HrFI1N38Cx+dNtMssI0xRz5vTmeaNn
         xGsM1QFKdvdB47muxryrCX2SxgiZatE7Z84QV2ay7DZBUUtXgcb9uwyY8iuFPzDubewM
         YugujrV28we3thrywOP24RIuVjYvGOUZVZYoWWvm61RKYb/Tff8zd8lwaM2jNonDMtB/
         ZLKalPIwmPsSPW2uRMScFPJGd+8FkzH7j+kC/h8C7e0OZQ8p8rgLN6lTYzf4aXMpOKLs
         CQmybvPsCBi2gEP9komDJgL03k09rTYI5IfJSqy2+Ayt69R4qIjN4R/eiP9LUNpvTrsQ
         k2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679091813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o00kGkLyKpkzx7W0Fkuu/iHFAs1OjQtHhFCy5o2OXOc=;
        b=QAmUfkBwvlcpkpwCdhH2j29Lik3uiL4Q7dQFILBPBzCaodyrEenAx/K1OiZOCAmdgZ
         /BK018ATlSSUVkN4DdVz1nzvEy5K37mZUxz1n7HUQUDYBVohkCzMFwGdjNA376IgKIYH
         jNApy3UVPN/avfbIbzAhkL13TZPFuFrTk4tXa3Fr+VQgbHimI/fTkaefif76f7pY6VTi
         HxRv7GHYaEzm4uaNu6FaIXqL0Yn/MXjZjTzXfrUAmd/Xm6Zu2aNzzpHPgvxMcdZeoihS
         Lq6kmVWrdlDf7SJW8nCQ6x8vGN+G2B6BxEvHB+ul5lydGa3+/+8FLEsJvCGoef1PL5yg
         WyuQ==
X-Gm-Message-State: AO0yUKUZ3VPGG0uBSl8Kv4MXc3ryCBcdHufd1//T9fTMWQlSow77LyC1
        nhjGyuyDSFsIFDH6+2vSwFdp8Pt2aOI13xZXAfa0OlVK
X-Google-Smtp-Source: AK7set8rd0NPrUQ0vuU3FqN+RPDFMq04djtxajfx+80mCD2ujBrq8vewkd0CQOzmEpV8N6PGZcM6zdNx3RzednKyjG8=
X-Received: by 2002:a17:906:5656:b0:92d:591f:645f with SMTP id
 v22-20020a170906565600b0092d591f645fmr449108ejr.5.1679091813554; Fri, 17 Mar
 2023 15:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230316023641.2092778-1-kuifeng@meta.com> <20230316023641.2092778-5-kuifeng@meta.com>
In-Reply-To: <20230316023641.2092778-5-kuifeng@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Mar 2023 15:23:21 -0700
Message-ID: <CAEf4BzZjEm_cKNnZZrDHci0i-vOvCOvCdWd3KBOeiBC0=FoM7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 4/8] libbpf: Create a bpf_link in bpf_map__attach_struct_ops().
To:     Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
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

On Wed, Mar 15, 2023 at 7:37=E2=80=AFPM Kui-Feng Lee <kuifeng@meta.com> wro=
te:
>
> bpf_map__attach_struct_ops() was creating a dummy bpf_link as a
> placeholder, but now it is constructing an authentic one by calling
> bpf_link_create() if the map has the BPF_F_LINK flag.
>
> You can flag a struct_ops map with BPF_F_LINK by calling
> bpf_map__set_map_flags().
>
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>  tools/lib/bpf/libbpf.c | 90 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 66 insertions(+), 24 deletions(-)
>

[...]

> -               if (!prog)
> -                       continue;
> +       link->link.detach =3D bpf_link__detach_struct_ops;
>
> -               prog_fd =3D bpf_program__fd(prog);
> -               kern_data =3D st_ops->kern_vdata + st_ops->kern_func_off[=
i];
> -               *(unsigned long *)kern_data =3D prog_fd;
> +       if (!(map->def.map_flags & BPF_F_LINK)) {
> +               /* w/o a real link */
> +               link->link.fd =3D map->fd;
> +               link->map_fd =3D -1;
> +               return &link->link;
>         }
>
> -       err =3D bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0=
);
> -       if (err) {
> -               err =3D -errno;
> +       fd =3D bpf_link_create(map->fd, -1, BPF_STRUCT_OPS, NULL);

pass 0, not -1. BPF APIs have a convention that fd=3D0 means "no fd was
provided". And actually kernel should have rejected this -1, so please
check why that didn't happen in your testing, we might be missing some
kernel validation.


> +       if (fd < 0) {
>                 free(link);
> -               return libbpf_err_ptr(err);
> +               return libbpf_err_ptr(fd);
>         }
>
> -       link->detach =3D bpf_link__detach_struct_ops;
> -       link->fd =3D map->fd;
> +       link->link.fd =3D fd;
> +       link->map_fd =3D map->fd;
>
> -       return link;
> +       return &link->link;
>  }
>
>  typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct perf_ev=
ent_header *hdr,
> --
> 2.34.1
>
