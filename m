Return-Path: <bpf+bounces-2170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16001728B83
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 01:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0ED281809
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 23:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729032DBD2;
	Thu,  8 Jun 2023 23:05:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0A622D64
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 23:05:48 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0FB2D7E
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 16:05:46 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-97668583210so178713566b.1
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 16:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686265544; x=1688857544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oNLn/XW1Zsa0ogmjHmUOQ8Jaj9X5V+Myktp/8sghmM=;
        b=Qp83yI56sKdFOMTXVSf/4Gs6n8Ra9aF5dVH4y/USRzRQCGOiVQEs8Ba9k5Cy9S9pWY
         IQlFM7FOPJz1/P5vWzla6y55AK8YaZvNOlpH+eDIsZvk3ue+uvExN/k1AdIzfE5jbEVd
         L6ps4nLXwyrmYlfPGGpttW52bG3JdGKvqo8zCQZ1eIGi2RFE/kto1DcNS9LYEH4L679t
         EfjYzKIMpOeD0PoJ8tQhhqBDO3EhJnES/x7ROrttWK063ldPoEwmcYAvQ2SiGXXKbLxX
         Ceyg0n+WeXb6M7cqTGE3rzkgD0P48xeX+RD5wki6S7kIY7YmxuuHwVgCi/nSyR2jgmAt
         G1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686265544; x=1688857544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oNLn/XW1Zsa0ogmjHmUOQ8Jaj9X5V+Myktp/8sghmM=;
        b=N7iOg0oNiySBNWb48/4TEYXjV63RmbVE+LDFfsYR4dBCHXARvUlJ1SoXsxHtkvevOT
         baONkWqc6Ic0iB6kjkiqr1Qw9TVgylDLUpDVK6Gko+jYAKjHk/iJU7HXtPMsVG4n6MQS
         Y93y9EEGUQdvgx00q8G9m8KohCqlJvlgFT2FXCKdRzZTJTktaCp2oZ7ZEKBxBVAJwhRp
         gfsmMwlkrti4Kay3IkgUyjRRMgJ8UCad8Ym/+HL9Q/NVONyCJ9xoYQG7nKjqguJ5xZgS
         5KnXebp6t/iHOK/V/5YnODf4pEUVGmj50JQCxovy4s1OTHZm8JK1uQXkp22fcGoiI3WJ
         gQ5w==
X-Gm-Message-State: AC+VfDx7NrA+X5IxK34g6aMLMIn+YDuQQ22AGjuIUfgXoBE2yjUOH2xR
	xOkm0B5OtHsn9AM/X+xSnljx0ySJjj/nL6AalkA=
X-Google-Smtp-Source: ACHHUZ7pTfzPTUlOGlDqmOGo/NfddnEd6D27hxT4n2BbMEAdsJMixoLkS6xx5oIf33CrD+XBz/DY83Htb3qWDfqYPmY=
X-Received: by 2002:a17:907:26c3:b0:974:6026:a316 with SMTP id
 bp3-20020a17090726c300b009746026a316mr499981ejc.19.1686265544394; Thu, 08 Jun
 2023 16:05:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608103523.102267-1-laoar.shao@gmail.com> <20230608103523.102267-2-laoar.shao@gmail.com>
In-Reply-To: <20230608103523.102267-2-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Jun 2023 16:05:32 -0700
Message-ID: <CAEf4BzY8Vi4Y6kf7hOmhWQkKOV=R7tBzb4dgCuicni3bBFWb9A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 01/11] bpf: Support ->fill_link_info for kprobe_multi
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 8, 2023 at 3:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> With the addition of support for fill_link_info to the kprobe_multi link,
> users will gain the ability to inspect it conveniently using the
> `bpftool link show` command. This enhancement provides valuable informati=
on
> to the user, including the count of probed functions and their respective
> addresses. It's important to note that if the kptr_restrict setting is se=
t
> to 2, the probed addresses will not be exposed, ensuring security.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/uapi/linux/bpf.h       |  5 +++++
>  kernel/trace/bpf_trace.c       | 30 ++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  5 +++++
>  3 files changed, 40 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index a7b5e91..d99cc16 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6438,6 +6438,11 @@ struct bpf_link_info {
>                         __s32 priority;
>                         __u32 flags;
>                 } netfilter;
> +               struct {
> +                       __aligned_u64 addrs; /* in/out: addresses buffer =
ptr */
> +                       __u32 count;
> +                       __u8  retprobe;

from kernel API side it's probably better to just expose flags?
retprobe is determined by BPF_F_KPROBE_MULTI_RETURN flag

> +               } kprobe_multi;
>         };
>  } __attribute__((aligned(8)));
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 2bc41e6..738efcf 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2548,9 +2548,39 @@ static void bpf_kprobe_multi_link_dealloc(struct b=
pf_link *link)
>         kfree(kmulti_link);
>  }
>
> +static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *l=
ink,
> +                                               struct bpf_link_info *inf=
o)
> +{
> +       u64 __user *uaddrs =3D u64_to_user_ptr(info->kprobe_multi.addrs);
> +       struct bpf_kprobe_multi_link *kmulti_link;
> +       u32 ucount =3D info->kprobe_multi.count;
> +
> +       if (!uaddrs ^ !ucount)
> +               return -EINVAL;
> +
> +       kmulti_link =3D container_of(link, struct bpf_kprobe_multi_link, =
link);
> +       if (!uaddrs) {
> +               info->kprobe_multi.count =3D kmulti_link->cnt;
> +               return 0;
> +       }
> +
> +       if (!ucount)
> +               return 0;
> +       if (ucount !=3D kmulti_link->cnt)
> +               return -EINVAL;

should this just check that kmulti_link->cnt is <=3D ucount?...

> +       info->kprobe_multi.retprobe =3D kmulti_link->fp.exit_handler ?
> +                                     true : false;
> +       if (kptr_restrict =3D=3D 2)
> +               return 0;

use kallsyms_show_value() instead of hard-coding this?

> +       if (copy_to_user(uaddrs, kmulti_link->addrs, ucount * sizeof(u64)=
))
> +               return -EFAULT;
> +       return 0;
> +}
> +
>  static const struct bpf_link_ops bpf_kprobe_multi_link_lops =3D {
>         .release =3D bpf_kprobe_multi_link_release,
>         .dealloc =3D bpf_kprobe_multi_link_dealloc,
> +       .fill_link_info =3D bpf_kprobe_multi_link_fill_link_info,
>  };
>
>  static void bpf_kprobe_multi_cookie_swap(void *a, void *b, int size, con=
st void *priv)
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index a7b5e91..d99cc16 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6438,6 +6438,11 @@ struct bpf_link_info {
>                         __s32 priority;
>                         __u32 flags;
>                 } netfilter;
> +               struct {
> +                       __aligned_u64 addrs; /* in/out: addresses buffer =
ptr */
> +                       __u32 count;
> +                       __u8  retprobe;
> +               } kprobe_multi;
>         };
>  } __attribute__((aligned(8)));
>
> --
> 1.8.3.1
>

