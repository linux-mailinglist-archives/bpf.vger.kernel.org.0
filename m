Return-Path: <bpf+bounces-2745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E74733769
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 19:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87332816F1
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 17:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4541C76D;
	Fri, 16 Jun 2023 17:24:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55556182D2
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 17:24:46 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0400A1FD7;
	Fri, 16 Jun 2023 10:24:44 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-982acf0a4d2so127831566b.3;
        Fri, 16 Jun 2023 10:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686936282; x=1689528282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7Dmblrf98v5F9PiIVILoa0Q0q5eJ3iJuoHt9mYNAGs=;
        b=dFPxTYb0l41dkCrWfXrEfH9iDb34LrVvFoHx3zTfUf219o16I/IsLF+EgIIEa4q3y6
         3aUfu6hr56O3kFRBtKLZeZy3SuVrHdeg4iGgG/eTBrc55AQON3o+tA4LI2YvZgnM8+st
         37ZUL3omjw6L2a9DXI+jWQR4kHXiUMce1qHUJYR3/yErJeOOUNfezWiIL3US7uICWi2h
         p3oQ1f1y/J94j8n2CVvrGkhT9rHrDOx03/sCbVaxhcPWwMElGw5TvPewMzrApeZlaXTk
         WtsRypUJZWnW3+MdYg1zZo0P2VcxAV1dvGnF2LvtTlSbCQ25Jw3bEmJ/D88zp57eqrYP
         /xEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686936282; x=1689528282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7Dmblrf98v5F9PiIVILoa0Q0q5eJ3iJuoHt9mYNAGs=;
        b=f6xv9BbvVEKOy34EJH1ArAKGHC0320vsyguTZ8BAm3yQ7Xd4motIkEiicgWaANdJFN
         bTywXmrjNybWsU1MbtGMdfMx9e1t/wwqhawDd0mviPVk8wlq17msQuGlOBhb+lvGtN6J
         JuF1IUA89RrlFwM9Z6z/FdfLwoML3Dnu2id1hhh/uV8TcjTwHrD93kdRcOg2Sij+EH2a
         wGPM1+QqZ8I9dmtzFz/eQrASCjoGF408kcKkxqs3k1uuAAlWCNL1l7T+Xzq0MK5hh4sv
         Sg2CxNKDSYn5xSl7SvdJfZ700+cmQQy+8zY7InGEAbXhcuaJ+uk82sjymXNQ4T66AL/c
         CKPw==
X-Gm-Message-State: AC+VfDygSnp1hAGyH8W8rAb1Zuz5EEpNmm1IlQbGlxm2SF5h7vMFTDHM
	Jo2i9d1TW3OGiLS3GAY6/F3WWJQxDT4I5C28IoU5O1LTRyA=
X-Google-Smtp-Source: ACHHUZ5ybQz+rufPveJqnjeqV2vGKjxfumnZdPNNEuT/r9TOR5wGZgvsSF+pAwWaTGJunog2ysHMVWSNvtuLfBlGwGY=
X-Received: by 2002:a17:907:c25:b0:974:5403:ebb with SMTP id
 ga37-20020a1709070c2500b0097454030ebbmr3026259ejc.54.1686936282301; Fri, 16
 Jun 2023 10:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612151608.99661-1-laoar.shao@gmail.com> <20230612151608.99661-2-laoar.shao@gmail.com>
In-Reply-To: <20230612151608.99661-2-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Jun 2023 10:24:30 -0700
Message-ID: <CAEf4BzaKg88jxQEUAT5-BPYbbi6yERDUeHu0qJb4pqSF2JEGig@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 01/10] bpf: Support ->fill_link_info for kprobe_multi
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 12, 2023 at 8:16=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> With the addition of support for fill_link_info to the kprobe_multi link,
> users will gain the ability to inspect it conveniently using the
> `bpftool link show`. This enhancement provides valuable information to th=
e
> user, including the count of probed functions and their respective
> addresses. It's important to note that if the kptr_restrict setting is no=
t
> permitted, the probed address will not be exposed, ensuring security.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/uapi/linux/bpf.h       |  5 +++++
>  kernel/trace/bpf_trace.c       | 28 ++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  5 +++++
>  3 files changed, 38 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index a7b5e91..23691ea 100644
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
> +                       __u32 flags;
> +               } kprobe_multi;
>         };
>  } __attribute__((aligned(8)));
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 2bc41e6..742047c 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2548,9 +2548,36 @@ static void bpf_kprobe_multi_link_dealloc(struct b=
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
> +       if (ucount < kmulti_link->cnt)
> +               return -EINVAL;
> +       info->kprobe_multi.flags =3D kmulti_link->fp.flags;

besides what Jiri said, flags should always be returned, just like
cnt. So structure code instead around uaddrs being optional, that will
everything more straightforward (i.e., fill out everything but uaddrs
and then at the end fill out addrs if uaddrs is not zero)

> +       if (!kallsyms_show_value(current_cred()))
> +               return 0;
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
> @@ -2890,6 +2917,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_at=
tr *attr, struct bpf_prog *pr
>                 return err;
>         }
>
> +       link->fp.flags =3D flags;
>         return bpf_link_settle(&link_primer);
>
>  error:
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index a7b5e91..23691ea 100644
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
> +                       __u32 flags;
> +               } kprobe_multi;
>         };
>  } __attribute__((aligned(8)));
>
> --
> 1.8.3.1
>

