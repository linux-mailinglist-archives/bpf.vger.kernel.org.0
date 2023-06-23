Return-Path: <bpf+bounces-3319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B9F73C31E
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 23:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0901A281E0C
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 21:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEE8156D9;
	Fri, 23 Jun 2023 21:45:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B0A154AC
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 21:45:37 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F798EA;
	Fri, 23 Jun 2023 14:45:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fa7eb35a13so8807865e9.0;
        Fri, 23 Jun 2023 14:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687556734; x=1690148734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aXV+xHVk/DmJ1RMVZY3EixPNi5+HVg53fJKj2ymUCk=;
        b=cJ8zZRYEvROfR/jBArFmBVlS65/N0J//p+UXwl+hN8KJRSJ660YXAy/02mwx7sGOYK
         KxU5i6VyQqq8qTpwDPnuCbk20LZ2jZqxnJRnRnN1qnhiShsh8H/v77ZQLE8yVbYMPkcb
         TcxqunMMwg6RTjMGyEGh6feCK+iFSdg2oX2Z5BofwCJpiboujLCOHnMsGVh6gy51usj3
         HpgH8Jkx2EPEamlI6axrtTbEhl1yq/Xj7DzlqKQ908IunOmkh9tEzL8pJ7P+4+243mgZ
         jxsptnfuTH8/2NrAXWvJKxGC8EyXOk4iv2iLuRa/CLRCvr0TGfEhaIxYORxmwK55wBts
         viIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687556734; x=1690148734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5aXV+xHVk/DmJ1RMVZY3EixPNi5+HVg53fJKj2ymUCk=;
        b=CUTOH8PV9mCd/EtGA6adYqplGbrQtAzk9tG+5TublhgU0i8DVf+mTcEgbvBtZPR76Q
         sV5yuKtjry45WVFemYpBi9NPwbyx0DBaK7lgw69Kjbsm3AYG0ZzxLxwSG2/31pQPcqWN
         H6GVXQnnXfrltb7bhxGHJDp8Nv3pRYzfOhD87J876BPKsOE/iGQ7krAixKPHoDMaa9kS
         x++S1HGIjlArVfIZIG/vZPZ5TldQExICCZP2TBrIb3MR7DLnPiu6GBC1LK8nMsEA+thz
         0isQSf27RgUY/OqUzsFgPIeLTNULMRFe4k/x0V2WBqyu2dX3zYvaBubtHGu9Dt5VX3um
         zNXw==
X-Gm-Message-State: AC+VfDytIfQUG9QjjN2tcGhikaI4yIGITHEicquMCLcNCXWGqwoB4EBE
	fyKdJlskVmhVDZj8f++rw6dsuoPh8xIUVdm2OaA=
X-Google-Smtp-Source: ACHHUZ7F30e6JNtaOYSLN3pSoOzjsGPCa06IW/QELyfYwLSQHt1FfrpywlO3veKvQ741qjfEKg2x8IxRSxYcpx/nbuE=
X-Received: by 2002:a7b:c356:0:b0:3f8:f6fe:26bf with SMTP id
 l22-20020a7bc356000000b003f8f6fe26bfmr15912987wmj.12.1687556734345; Fri, 23
 Jun 2023 14:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230623141546.3751-1-laoar.shao@gmail.com> <20230623141546.3751-2-laoar.shao@gmail.com>
In-Reply-To: <20230623141546.3751-2-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Jun 2023 14:45:22 -0700
Message-ID: <CAEf4BzaYmAmkm9HL1BPoddPtq=A2caqPm0QR_yQn44GA7TZVVQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 01/11] bpf: Support ->fill_link_info for kprobe_multi
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

On Fri, Jun 23, 2023 at 7:16=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
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
> index 2bc41e6..2123197b 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2459,6 +2459,7 @@ struct bpf_kprobe_multi_link {
>         u32 cnt;
>         u32 mods_cnt;
>         struct module **mods;
> +       u32 flags;
>  };
>
>  struct bpf_kprobe_multi_run_ctx {
> @@ -2548,9 +2549,35 @@ static void bpf_kprobe_multi_link_dealloc(struct b=
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
> +       info->kprobe_multi.count =3D kmulti_link->cnt;
> +       info->kprobe_multi.flags =3D kmulti_link->flags;
> +
> +       if (!uaddrs)
> +               return 0;
> +       if (ucount < kmulti_link->cnt)
> +               return -EINVAL;

it would be probably sane behavior to copy ucount items and return -E2BIG

> +       if (!kallsyms_show_value(current_cred()))
> +               return 0;

at least we should zero out kmulti_link->cnt elements. Otherwise it's
hard for user-space know whether returned data is garbage or not?


> +       if (copy_to_user(uaddrs, kmulti_link->addrs, ucount * sizeof(u64)=
))

s/ucount/kmulti_link->cnt/ ?

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
> @@ -2862,6 +2889,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_at=
tr *attr, struct bpf_prog *pr
>         link->addrs =3D addrs;
>         link->cookies =3D cookies;
>         link->cnt =3D cnt;
> +       link->flags =3D flags;
>
>         if (cookies) {
>                 /*
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

