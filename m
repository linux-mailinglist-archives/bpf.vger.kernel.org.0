Return-Path: <bpf+bounces-56548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073F2A99BEC
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 01:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4351A4637BC
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 23:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC6321CC68;
	Wed, 23 Apr 2025 23:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbOzq2xJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D0A19F137
	for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745450395; cv=none; b=flbH2+/NUdD1I01Ev28hZreF1m03TV02SMIyAgpO+e01sjlccAqsMYWsBgVpGdEEbvThTITfKzy1+A0i/K5Qv9PdN3uoERYP8gAty+agobfLRNNwdBflnpPrqa0KnPxpyvKtmunRjhPlsXNMM/SNBFAg/ag5YAc7a3jjD59cyLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745450395; c=relaxed/simple;
	bh=Fx4wq+8gviXQNjMYUkNPDA/I5oj+ctcAnof7ti8GEeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dsXo6iekgRwgJqYL2mae96AORZHE0IHZptkvDKE1obiszqBFqX+c0M0K9fOxTeV6S1RLNQvVaSOFyU/zGNYk6O5+dtNPXcnd1A+IvcoD/5HFG1isDE+YSc3wWzxgARbOvbs/FpgvSJcYWo61ZFZe0tKjBJg03hcUXgGRFmpw0Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbOzq2xJ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736c277331eso1563855b3a.1
        for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 16:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745450393; x=1746055193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n22/4VN9xzWIBA1S4uaACxNQrz1+QRwMwOUiK0l1tw0=;
        b=jbOzq2xJIct7FRnztV7ENHwGn942a3jkLfI/qJiS9MLwvLh8dokyFFF8Np9w20ivVa
         IOM7QWtyhA+TezCCOLSAptUnaSV+4w8hEWpUgmYT2BQ37TCD82A+pA8KzWu/jZ4dNxRM
         AHHfrE1X8PK/gAz4ycxla4BFnAezJSeO4rv6w+gOnLvZXf1RtJx2ucpNImAhGoQaLX0K
         528p3ajeMlR7lq4QoidZjfwVHePp5Ctfxvg7bRrno/NMcMHPamn09wu17sv1BQ4X1tuy
         zmb8vT1l04PxtG5UtOtME+s6VcDJKYSg0WYAO6JkbimK51zJyNI/DYWJz78OF1keovJ9
         USzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745450393; x=1746055193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n22/4VN9xzWIBA1S4uaACxNQrz1+QRwMwOUiK0l1tw0=;
        b=YxnDk9G0l89f3H7ztF19lz42PDgDWM8hfvxgIBhWW66GXFR8FfQ0IWjMVIKk0Ycfzj
         HzYSvQZa9wQEj5a0kL+JPt2yyTUJfwRLJqCwc420/NxzSVZHVCihtio6Ebf/UoEfAPj6
         AXhdARXPKtz9zsAMdvFupLQuFHd0AbGI0huEoLEZMiC6ZvXNhiWej1FKimAirSKHCyjM
         woLP2kGf5CbG5OMW24OALhzuL+l1fcUZ9xoZRNdXas4mPyqZmT5RHKN1ultA3B8y8tIg
         ickvtP6TZ7G72UV6TAMTpgDqsonEFjxC9TiA6WzTWLLKppo3uA6Xe25Q5dWk5XqlYJ9X
         gxYA==
X-Gm-Message-State: AOJu0YzwjIqatFGiR8TvGMlwr1RCKiMnjH8AWhvcc/yTJCtnBWV0fdiQ
	G/LUGj2NIGaMShR0j1L7LwhHRxQB8V2BNMfbT2cKvNtM5pe8R5kQdA8pRoXe6mvqzwDcI6Kfatp
	1JLV58xvr3/MSJ+SH6KdoGBwhc/w=
X-Gm-Gg: ASbGncup/wovWq/5ezL13CS06AnDBX9Tg+Oup3CAx6ie1FG8AgtnLtsm3JlbmL4Lbdg
	Rh2CW0mwFRzHhHd3hqIofxU4Y4/EAsE0Wl0md/Nc7+JdoxugAX/ur/lyzREYYTR51R5ShcwIZ8T
	4uBM6hyMEojnVtXsn5zWjWuG+eHc2Dfvjq+oUosQ==
X-Google-Smtp-Source: AGHT+IFPOMEGqqRHbcm1g5+n6fUdR0LY3PaBhkUgEi3LHwMj8OHX8RCmsUlhlE2pt00vPbGxkk9iz57/FtIhbdNtIQ8=
X-Received: by 2002:a17:90b:3906:b0:2fe:b907:5e5a with SMTP id
 98e67ed59e1d1-309ee39451amr256588a91.10.1745450392977; Wed, 23 Apr 2025
 16:19:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411011523.1838771-1-yonghong.song@linux.dev> <20250411011528.1839359-1-yonghong.song@linux.dev>
In-Reply-To: <20250411011528.1839359-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Apr 2025 16:19:40 -0700
X-Gm-Features: ATxdqUHk-uMB63D4g21pofsBLnmy3S-43n_x3tYYaChv6GBk3C3xOTgJTe7f2_o
Message-ID: <CAEf4BzYs-qgxGPpZ7R-W7xUOP69bq_DJZ3A1J20DqqzqgvHv1g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/4] cgroup: Add bpf prog revisions to struct cgroup_bpf
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 6:15=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> One of key items in mprog API is revision for prog list. The revision
> number will be increased if the prog list changed, e.g., attach, detach
> or replace.
>
> Add 'revisions' field to struct cgroup_bpf, representing revisions for
> all cgroup related attachment types. The initial revision value is
> set to 1, the same as kernel mprog implementations.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf-cgroup-defs.h | 1 +
>  kernel/cgroup/cgroup.c          | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-d=
efs.h
> index 0985221d5478..a3cbbd00731a 100644
> --- a/include/linux/bpf-cgroup-defs.h
> +++ b/include/linux/bpf-cgroup-defs.h
> @@ -62,6 +62,7 @@ struct cgroup_bpf {
>          * when BPF_F_ALLOW_MULTI the list can have up to BPF_CGROUP_MAX_=
PROGS
>          */
>         struct hlist_head progs[MAX_CGROUP_BPF_ATTACH_TYPE];
> +       atomic64_t revisions[MAX_CGROUP_BPF_ATTACH_TYPE];

for cgroups all the attachment and detachment happens under
cgroup_mutex, so I don't think we need atomic64_t, just plain u64 will
work

>         u8 flags[MAX_CGROUP_BPF_ATTACH_TYPE];
>
>         /* list of cgroup shared storages */
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index ac2db99941ca..dea7d12c8927 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -2053,7 +2053,7 @@ static int cgroup_reconfigure(struct fs_context *fc=
)
>  static void init_cgroup_housekeeping(struct cgroup *cgrp)
>  {
>         struct cgroup_subsys *ss;
> -       int ssid;
> +       int i, ssid;
>
>         INIT_LIST_HEAD(&cgrp->self.sibling);
>         INIT_LIST_HEAD(&cgrp->self.children);
> @@ -2071,6 +2071,9 @@ static void init_cgroup_housekeeping(struct cgroup =
*cgrp)
>         for_each_subsys(ss, ssid)
>                 INIT_LIST_HEAD(&cgrp->e_csets[ssid]);
>
> +       for (i =3D 0; i < ARRAY_SIZE(cgrp->bpf.revisions); i++)
> +               atomic64_set(&cgrp->bpf.revisions[i], 1);
> +
>         init_waitqueue_head(&cgrp->offline_waitq);
>         INIT_WORK(&cgrp->release_agent_work, cgroup1_release_agent);
>  }
> --
> 2.47.1
>

