Return-Path: <bpf+bounces-4348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF0874A760
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 01:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1281C20EC6
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 23:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283CA16429;
	Thu,  6 Jul 2023 23:03:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E934463BA
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 23:03:36 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F481992
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 16:03:35 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbf1b82de7so10839995e9.1
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 16:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688684614; x=1691276614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwlJ7R3+FTndgMwFMfoF8vADExfTIhg1xMvDSFste6w=;
        b=h2CtaO4z5P4FnWJMVYvNV2GhyrPRIXi5whWJacZ6rQ6kUMQE/s40qRzKcf13dkLQXq
         scssgBQmozIEuHslN4KmHlMp/kB+rZkemjaSKJuOcLYlCQsH5C5YEPIrHTXKQoS3hqBu
         Eduiatj2HM3pgyH1p5UZSXv6IPBRy1DJGg9Ws2R7vIB6Tx6Z1zOyBnsVf6sZ6ieIw/8B
         RYIKjxr3p5a+CsurH5oKBGJgPl4x4iumszY+ScsLleyJMRyxJ6PaIF5CPN0B3AOhjcjJ
         er3d4g4zCUwo+k3dT3AySBtRcmcih6pcxD4ZGe/YNUmfA2PDBA/nkK+GJ+TaU/8zWMK8
         XgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688684614; x=1691276614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwlJ7R3+FTndgMwFMfoF8vADExfTIhg1xMvDSFste6w=;
        b=XzPr4GyNQCtDtmUKKETiPqPMN8JqeYA0zYglT+/7KQqsFgWwdpZ/cczHJyZLiXMZ3k
         jBo/VZge88yxpSsB2LA97qIINkEwjZaR3Wk169myay+3S/mNUg6jWUENdLOzbnSMNNK/
         Ln3QTdkw/Kj/tY9rattpvEcXk0CGYSQknsVhwE6Wu7O427Ewdr/pCzWOMajVUermie+u
         2H4JYrpn29oCX2INynwLHelwfZoGsHh5JQbxOvqdtkxaytTnJwkrgQTjekx7ceKVHyX5
         m8q794yrIbLvTmgOI6IaWpCljuF0vMgUUtPEjWOCV3+btoF70bTCXaTdoNltemUI0Der
         RKWA==
X-Gm-Message-State: ABy/qLbvhc+lXgkHQSEPh3HqhBjjT0Y4I5+TJoKcoUpw2Q1/iFSHEsoH
	V0bA4csnaaeRyKpjDgGOjSErvMPoiJssUe61s+c=
X-Google-Smtp-Source: APBJJlHXDDfP84qMB0mD8QoBIh3dUjghHsQFP2tS8n9QEhlafS4VEK0QOcgiIm8CMaYzXZM62knabLLdtgBAujDeGM4=
X-Received: by 2002:a7b:c399:0:b0:3f6:d90:3db with SMTP id s25-20020a7bc399000000b003f60d9003dbmr3130984wmj.3.1688684614083;
 Thu, 06 Jul 2023 16:03:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-8-jolsa@kernel.org>
In-Reply-To: <20230630083344.984305-8-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 16:03:22 -0700
Message-ID: <CAEf4BzYa+Mok-Bj2E+9EbWGPtGaMTsZ=1_VkkGzGw3yrdr+G+g@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 07/26] libbpf: Move elf_find_func_offset*
 functions to elf object
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

On Fri, Jun 30, 2023 at 1:35=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding new elf object that will contain elf related functions.
> There's no functional change.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/Build        |   2 +-
>  tools/lib/bpf/elf.c        | 198 +++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.c     | 186 +---------------------------------
>  tools/lib/bpf/libbpf_elf.h |  11 +++
>  4 files changed, 211 insertions(+), 186 deletions(-)
>  create mode 100644 tools/lib/bpf/elf.c
>  create mode 100644 tools/lib/bpf/libbpf_elf.h
>
> diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
> index b8b0a6369363..2d0c282c8588 100644
> --- a/tools/lib/bpf/Build
> +++ b/tools/lib/bpf/Build
> @@ -1,4 +1,4 @@
>  libbpf-y :=3D libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o \
>             netlink.o bpf_prog_linfo.o libbpf_probes.o hashmap.o \
>             btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core=
.o \
> -           usdt.o zip.o
> +           usdt.o zip.o elf.o
> diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> new file mode 100644
> index 000000000000..2b62b4af28ce
> --- /dev/null
> +++ b/tools/lib/bpf/elf.c
> @@ -0,0 +1,198 @@
> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +
> +#include <libelf.h>
> +#include <gelf.h>
> +#include <fcntl.h>
> +#include <linux/kernel.h>

do you know why we need linux/kernel.h include? is it to get __u32 and
other typedefs?

> +
> +#include "libbpf_elf.h"
> +#include "libbpf_internal.h"
> +#include "str_error.h"
> +
> +#define STRERR_BUFSIZE  128
> +

[...]

