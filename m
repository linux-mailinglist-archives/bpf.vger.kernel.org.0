Return-Path: <bpf+bounces-19815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B3A831A7E
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 14:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC2621C2250F
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 13:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCE025544;
	Thu, 18 Jan 2024 13:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nk3HbDTc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4BA184C
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705584149; cv=none; b=nQD0vwhvu83bGRQCxFpw94pJ0QIfBb4sxHwWbbIUGYyFS6KObz1C/3xN1R1dbqlHgAg2fUcQ9Fx4Ay8ZHmzHPbHrUOJjcMl5MacwlxBAmTIxoiFj+DlnvmhLI/CHtAU9ExmMtHiIjJUGMukNafVcDpas9DjSEf1CVV96PXmT7bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705584149; c=relaxed/simple;
	bh=f6GpGmFwLmr3i1nXsDRMD/D+s608Tmhwf2/1v2GlDls=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=ImS/1t+UQL22XtMtFiwkSyVF9X6QQoEDY1GF3j28BukB5vlnB9/PFnnNKiIrdnKWbQkHX6Pql4mipm+TCL0GasLukUw4Dge5Zw+ct8te2uyEAIPN24WfrbG59dy/s3Vb7m64xPrW0OhjStBGwYqBF2H+9P6K9fX0sMKeXK/YkS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nk3HbDTc; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6818aa08a33so5187306d6.0
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 05:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705584147; x=1706188947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4F8bx2+kVlZQp+cBFq3wbhFrd3Xu2ACYCFOK8J3izE=;
        b=nk3HbDTcDUhfi/NLsTnkdoPXz+WYPkbQd0COxRaJ22LjNXoKbn6IyG51xuO9XTA4XK
         vf2/7sI0UdoB7AbBCur3Vy8rAHI1JPkj5kiNk3hdjHNqQUpWYBTxRwUTv0ryTNFQQAM0
         hz+Qi89T4wXoPJewsFN7P7z6iTXK534PrI/7IhwXZEJmv/ztUMyEz0uvg6Ncb3OPW2vo
         8kZFyy4pE7ZIm4u3zWO9P12nHWZCzODSiWqqPaGlyYQ72XowNsj0AD1IBXnSaoZgj1gH
         eDkiWCK47W37giF9CWeAUzEN7IcXxgtForC0csDL46plgBqHjbRb3Z/5orTV/UXc5eQP
         ngrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705584147; x=1706188947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4F8bx2+kVlZQp+cBFq3wbhFrd3Xu2ACYCFOK8J3izE=;
        b=dQRX5Ne/bW4qMHMKzc8iCXCzCaTAX8944A4Nq1ONK7bMxmTGwAHV0dQsT7ku8UIHp5
         YrN/DykCexe99RGNLnw1h5zs1D4QAg+TvcLG+rw0w9c/KqY/rfeyvZBHbVmMgfsOCtHM
         66kaFPHyAy5FIirPwHm+AUdlUcOWYMe2a3Q8GdzhHlybc9Gd0H4wVuME/kNBiUfsvypR
         VD2i9CJhT8MOtMixfYMHm8YG6tg0ib/BChYSaCCzrVojkptUaW9gs33Z+72ODLyxqp/P
         JLJLuG2sWJHDav+lONZZmIOKSmn4bHfpvUI3cbaPcyZ9bFqLvPoNtEBdOtqsGGwvs+Wo
         KxrQ==
X-Gm-Message-State: AOJu0YzuZhZqj4TvoYLsqvUR3vkISVVJO/3GHs8HJhhJBbVCLaCPfFR8
	fiC+QLjyU9I3TrUQzfK6FNMp1B8oIYvjR/IH5vQbkl6QvMV7rmyQs8rOowKki5CbB4JO9E4Q5Jb
	2WW88ta1FiuHnNBBjZFyvF/APpM4=
X-Google-Smtp-Source: AGHT+IFbpTfla3etcMgKCzGPh3UTy5uOh4Wmwwa2gQ4C3oJrKh55YNVG6lwVLd2fwXmoShKqwZC9DHRap+7DiX3HYHY=
X-Received: by 2002:a0c:fcc4:0:b0:681:81b4:3d66 with SMTP id
 i4-20020a0cfcc4000000b0068181b43d66mr2450239qvq.2.1705584146953; Thu, 18 Jan
 2024 05:22:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118095416.989152-1-jolsa@kernel.org> <20240118095416.989152-3-jolsa@kernel.org>
In-Reply-To: <20240118095416.989152-3-jolsa@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 18 Jan 2024 21:21:50 +0800
Message-ID: <CALOAHbDhZtZ+DARrWscFias1fn2LMFT5N3ojqPBxUJUJ1qRkJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/8] bpf: Store cookies in kprobe_multi
 bpf_link_info data
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 5:54=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Storing cookies in kprobe_multi bpf_link_info data. The cookies
> field is optional and if provided it needs to be an array of
> __u64 with kprobe_multi.count length.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

LGTM.
Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/trace/bpf_trace.c       | 15 +++++++++++++++
>  tools/include/uapi/linux/bpf.h |  1 +
>  3 files changed, 17 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index b823d367a83c..199cb93dca7f 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6563,6 +6563,7 @@ struct bpf_link_info {
>                         __u32 count; /* in/out: kprobe_multi function cou=
nt */
>                         __u32 flags;
>                         __u64 missed;
> +                       __aligned_u64 cookies;
>                 } kprobe_multi;
>                 struct {
>                         __aligned_u64 path;
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 7ac6c52b25eb..c98c20abaf99 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2679,6 +2679,7 @@ static void bpf_kprobe_multi_link_dealloc(struct bp=
f_link *link)
>  static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *l=
ink,
>                                                 struct bpf_link_info *inf=
o)
>  {
> +       u64 __user *ucookies =3D u64_to_user_ptr(info->kprobe_multi.cooki=
es);
>         u64 __user *uaddrs =3D u64_to_user_ptr(info->kprobe_multi.addrs);
>         struct bpf_kprobe_multi_link *kmulti_link;
>         u32 ucount =3D info->kprobe_multi.count;
> @@ -2686,6 +2687,8 @@ static int bpf_kprobe_multi_link_fill_link_info(con=
st struct bpf_link *link,
>
>         if (!uaddrs ^ !ucount)
>                 return -EINVAL;
> +       if (ucookies && !ucount)
> +               return -EINVAL;
>
>         kmulti_link =3D container_of(link, struct bpf_kprobe_multi_link, =
link);
>         info->kprobe_multi.count =3D kmulti_link->cnt;
> @@ -2699,6 +2702,18 @@ static int bpf_kprobe_multi_link_fill_link_info(co=
nst struct bpf_link *link,
>         else
>                 ucount =3D kmulti_link->cnt;
>
> +       if (ucookies) {
> +               if (kmulti_link->cookies) {
> +                       if (copy_to_user(ucookies, kmulti_link->cookies, =
ucount * sizeof(u64)))
> +                               return -EFAULT;
> +               } else {
> +                       for (i =3D 0; i < ucount; i++) {
> +                               if (put_user(0, ucookies + i))
> +                                       return -EFAULT;
> +                       }
> +               }
> +       }
> +
>         if (kallsyms_show_value(current_cred())) {
>                 if (copy_to_user(uaddrs, kmulti_link->addrs, ucount * siz=
eof(u64)))
>                         return -EFAULT;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index b823d367a83c..199cb93dca7f 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6563,6 +6563,7 @@ struct bpf_link_info {
>                         __u32 count; /* in/out: kprobe_multi function cou=
nt */
>                         __u32 flags;
>                         __u64 missed;
> +                       __aligned_u64 cookies;
>                 } kprobe_multi;
>                 struct {
>                         __aligned_u64 path;
> --
> 2.43.0
>


--=20
Regards
Yafang

