Return-Path: <bpf+bounces-11011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B177B0FC8
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 02:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 70772B209CE
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 00:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5787E2;
	Thu, 28 Sep 2023 00:12:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FCE163;
	Thu, 28 Sep 2023 00:12:24 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DB2A1;
	Wed, 27 Sep 2023 17:12:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53447d0241eso7874856a12.3;
        Wed, 27 Sep 2023 17:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695859941; x=1696464741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cG8qI9UEWecof70/2Tn43TAoZCjHVNKlDtltSF7LHLU=;
        b=G+KyrdyhPEzs52BqZCIK1VlXE5c8C+AkEoLrN8lUdlPoqe3zuKagjpnIIujkOpH0Ge
         fRIcwfMdvKauPiSHyQIWW+wWgUivbCn4hLUHBllgeRPo85MAB+ubrwGan/rJZJendwN1
         Z+wYfcyW1GQJFF2gmP/LUBQOP1c3CaNQcv7YFoO68ayheJ4oS0z+hI1TsIQeTShG823r
         GQC0hpQV8wyBOA4r8D1Yh+zVJQnDmg5W9P9Pbo5WEqh7Hy+LdFszJM/QoF19kPnPTmL6
         GPJQCdWsxBUMtxFlxK3FO6EwjfgbkbJEbZbt/xQsyvnL96X/pB6E9XNjjeTr5CA/3Uwb
         SSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695859942; x=1696464742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cG8qI9UEWecof70/2Tn43TAoZCjHVNKlDtltSF7LHLU=;
        b=i3MiEOu/bdTFHvDe1VSI/DtmPO+UNqfVdhkbHtn3NPNiP7DqpaX59rqRDpjiwsAyic
         oUQkLEUzB1t5Is8PTXS9xFqDgDFL0hGEZF+9dckdjVM3jl914l/WThBptj7EH3m086Xl
         F2oFpdYqbBq+o5DKSQFtZKv52xAIs78uSyeK+PdZW+9/l6BavSBJgI1rhSCGPwvhJlmK
         DvcZATBaAULtYQigaoA174AfndgvdK3UJaRfr8+Qn/1GdOmxUQfJ/I+ZXTkwogp4GvTD
         XBsmu8GmfijVgLWJ+QHpqaPiOqqC6UjyPo7Jq1zp644IJnn4ZNmAitKZkrJdJ34fDIym
         CacA==
X-Gm-Message-State: AOJu0YzbfTnhFCS8mHpUSnaOHtWXu19+3JVk8Komwg2S6xdU8+k1ol7B
	wuLOJlH8WM1W/q+tkNKlgfBqDL2W7l4qIIHUs+g=
X-Google-Smtp-Source: AGHT+IFtIVo9uRImSXHtgqpcdX+V5UCB9VOEGpHSXvzUZYz4u1hn4ceXqpOpryc5gvd4g9wT4NCOPOXuOJ72NZut36M=
X-Received: by 2002:a17:906:d3:b0:9a1:cb2c:b55c with SMTP id
 19-20020a17090600d300b009a1cb2cb55cmr3102544eji.35.1695859941436; Wed, 27 Sep
 2023 17:12:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926055913.9859-1-daniel@iogearbox.net> <20230926055913.9859-3-daniel@iogearbox.net>
In-Reply-To: <20230926055913.9859-3-daniel@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Sep 2023 17:12:10 -0700
Message-ID: <CAEf4BzbBArMVTHqiS0zmgnFr0rBm-ZAXFs9dkffa7-0Axw2XSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/8] meta, bpf: Add bpf link support for meta device
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@kernel.org, 
	razor@blackwall.org, ast@kernel.org, andrii@kernel.org, 
	john.fastabend@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 10:59=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> This adds BPF link support for meta device (BPF_LINK_TYPE_META). Similar
> as with tcx or XDP, the BPF link for meta contains the device.
>
> The bpf_mprog API has been reused for its implementation. For details, se=
e
> also commit e420bed0250 ("bpf: Add fd-based tcx multi-prog infra with lin=
k
> support").
>
> This is now the second user of bpf_mprog after tcx, and in meta case the
> implementation is also a bit more straight forward since it does not need
> to deal with miniq.
>
> The UAPI extensions for the BPF_LINK_CREATE command are similar as for tc=
x,
> that is, relative_{fd,id} and expected_revision.
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  drivers/net/meta.c             | 211 ++++++++++++++++++++++++++++++++-
>  include/net/meta.h             |   7 ++
>  include/uapi/linux/bpf.h       |  11 ++
>  kernel/bpf/syscall.c           |   2 +-
>  tools/include/uapi/linux/bpf.h |  11 ++
>  5 files changed, 240 insertions(+), 2 deletions(-)
>

[...]

> diff --git a/include/net/meta.h b/include/net/meta.h
> index 20fc61d05970..f1abe1d6d02d 100644
> --- a/include/net/meta.h
> +++ b/include/net/meta.h
> @@ -7,6 +7,7 @@
>
>  #ifdef CONFIG_META
>  int meta_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog);
> +int meta_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
>  int meta_prog_detach(const union bpf_attr *attr, struct bpf_prog *prog);
>  int meta_prog_query(const union bpf_attr *attr, union bpf_attr __user *u=
attr);
>  #else
> @@ -16,6 +17,12 @@ static inline int meta_prog_attach(const union bpf_att=
r *attr,
>         return -EINVAL;
>  }
>
> +static inline int meta_link_attach(const union bpf_attr *attr,
> +                                  struct bpf_prog *prog)
> +{
> +       return -EINVAL;
> +}
> +
>  static inline int meta_prog_detach(const union bpf_attr *attr,
>                                    struct bpf_prog *prog)
>  {
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 00a875720e84..fd069f285fbc 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1068,6 +1068,7 @@ enum bpf_link_type {
>         BPF_LINK_TYPE_NETFILTER =3D 10,
>         BPF_LINK_TYPE_TCX =3D 11,
>         BPF_LINK_TYPE_UPROBE_MULTI =3D 12,
> +       BPF_LINK_TYPE_META =3D 12,

it's not just some completely universal "meta" device, it's
specifically networking meta-device, is that right? so at least in
UAPI I think we should stay away from using super-generic "meta"
words, and do something like "net_meta" or "meta_net" or whatnot, but
indicate that this is networking stuff. WDYT?


>         MAX_BPF_LINK_TYPE,
>  };
>
> @@ -1653,6 +1654,13 @@ union bpf_attr {
>                                 __u32           flags;
>                                 __u32           pid;
>                         } uprobe_multi;
> +                       struct {
> +                               union {
> +                                       __u32   relative_fd;
> +                                       __u32   relative_id;
> +                               };
> +                               __u64           expected_revision;
> +                       } meta;
>                 };
>         } link_create;
>
> @@ -6564,6 +6572,9 @@ struct bpf_link_info {
>                         __u32 ifindex;
>                         __u32 attach_type;
>                 } tcx;
> +               struct {
> +                       __u32 ifindex;
> +               } meta;
>         };
>  } __attribute__((aligned(8)));
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 51baf4355c39..b689da4de280 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4969,7 +4969,7 @@ static int link_create(union bpf_attr *attr, bpfptr=
_t uattr)
>                     attr->link_create.attach_type =3D=3D BPF_TCX_EGRESS)
>                         ret =3D tcx_link_attach(attr, prog);
>                 else
> -                       ret =3D -EINVAL;
> +                       ret =3D meta_link_attach(attr, prog);
>                 break;
>         case BPF_PROG_TYPE_NETFILTER:
>                 ret =3D bpf_nf_link_attach(attr, prog);
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 00a875720e84..fd069f285fbc 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1068,6 +1068,7 @@ enum bpf_link_type {
>         BPF_LINK_TYPE_NETFILTER =3D 10,
>         BPF_LINK_TYPE_TCX =3D 11,
>         BPF_LINK_TYPE_UPROBE_MULTI =3D 12,
> +       BPF_LINK_TYPE_META =3D 12,
>         MAX_BPF_LINK_TYPE,
>  };
>
> @@ -1653,6 +1654,13 @@ union bpf_attr {
>                                 __u32           flags;
>                                 __u32           pid;
>                         } uprobe_multi;
> +                       struct {
> +                               union {
> +                                       __u32   relative_fd;
> +                                       __u32   relative_id;
> +                               };
> +                               __u64           expected_revision;
> +                       } meta;
>                 };
>         } link_create;
>
> @@ -6564,6 +6572,9 @@ struct bpf_link_info {
>                         __u32 ifindex;
>                         __u32 attach_type;
>                 } tcx;
> +               struct {
> +                       __u32 ifindex;
> +               } meta;
>         };
>  } __attribute__((aligned(8)));
>
> --
> 2.34.1
>

