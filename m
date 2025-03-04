Return-Path: <bpf+bounces-53247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC753A4EFF5
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 23:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1111F3A547E
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 22:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986131F55FA;
	Tue,  4 Mar 2025 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFjwgtN5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DCE33998
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741126616; cv=none; b=g0u0HAR7dY2j31+rgG8Nh6YI+92Zm9lCosvTodVU7sNljTNgwabdSoTb5NuUyLCN7HG+9KVbiFgO2LGUZ3iFhxGjFw1bEMMdfsFXts9Ci3tNY6VXIihJL8z+SXbwwnogUo2gTiNj0PftcA7VJwjmJ+Gal+UsjplUqqSK2trEpeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741126616; c=relaxed/simple;
	bh=5I4fzVa8NmYq1zu6tyPG6S9e8DomNX5u7N5KffUIE9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNpcCUjbx3m6XK6j4r8k5GG0aASgqDfDIX1rMvjiH2v1kCK2cLMIF5SqVDGrcG7yxrvUUpQ4oNk10XptwDW8KY5FSfldt2DklhyybP2lgoiTTILd7W5pQDBBDuwgmtlWbC2MjEQu6PtZvaM6ZDHEqWwuXtJaOdU+gb+lg5+NXC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFjwgtN5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22359001f1aso138809335ad.3
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 14:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741126614; x=1741731414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBxsisAI2Eec10Ls415KNkkE1/XEsrmCAc9iTe7Cc3w=;
        b=jFjwgtN5au5JTu3MYS7jh2dOmf2kDhX+p5VEQsltuICvRPfVF0lm7L8/I2hYvRBSnb
         i7SZd7Np1IfHdntRyWFev05266eHfl8aQXXYMHBlKPMULT9G85TX9F5NHIxIKZPW7jo4
         DkvUMQSp2y6BfDHbrWIpVB3AQD3efQLjkJwZrw2ae7LBUt/ful3rne+7jQHKLjfAHO8/
         FVrjcNOKbtvD9Nmi2D9SrhXFSAjbJE4FApGssE3JaCnEQ94JLz/iGdLQJHpC4lPI5odq
         tqK4ZxF4gpGTexA9W7YmQyJtcH4x6oteOzBoYGIbzM1Y9ID2yrFkh8BfSOPby8R9a+rg
         4VtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741126614; x=1741731414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBxsisAI2Eec10Ls415KNkkE1/XEsrmCAc9iTe7Cc3w=;
        b=WemGe2tUuUDlltGQnGPd61HQvokzYfmDILTz2VuNL/D2yPiy+p4I0m9hrBOWuNFJoS
         vfguNuss6uxXqXGQ9yw7WWnKggCCQ9wyfmFWbd5f0uPbmkr0mDtTPXYYvRLLSSXoMlE4
         txB440Ozgc7tK+DEZ27TfirgQyOdJS9dzWZVmm5SI/MepYsmTrjz6SDnbBJdsVrczN8U
         3ubHLwSNb29feFKZiSRvuR3Y0lWk47f7ZMCImBHSzPZjPJSyJdHuvU6xOg7dkF3DKYpv
         H/qNP9BY0H/e17zQfjAPMumGHC6Z2kuT0dMWvgQ091E7EM009Ev7A/JEjj4aIH/9IKv9
         2/lw==
X-Gm-Message-State: AOJu0YzjnvvSxEEIRCRyYpKX+wrJ6Tbp4hxcIewcnxJrkAwTAP15hO4T
	F1LfzTMtcr71FM8lalFPS9jCh6eUj1dwMxSGU7+MBvXwkgY6P+k9m7QUg9AzRdSINSni1eVIZfJ
	yFcyhikMt3peH/gGA+7FdQAo+gKo=
X-Gm-Gg: ASbGnctNDVM6dgBdRp0VYV4Y0wDW9h2WMvbMHnEm56GiZwBKYSxfPM2XZjrFyI/GAzv
	QXDlOeC5VjlAFtWYuzlzFA34RaWXa1wSXsk7czKBidzbQ1Fe1yR1L5x3wqA2v7v9YLOdQY/iHeY
	E5MbaIjyhd5gwumyocI/zFHFjFsJag3/aVFmX1cgTK1g==
X-Google-Smtp-Source: AGHT+IGrdZqddvvOeV89oDZTgyRifmXZ37tMIrAO3rckrw9J3aYOgZd3EqpzmBgGRHJQXoztZj81dxQ9Kv/xQXqfQQE=
X-Received: by 2002:a05:6a00:2e9f:b0:736:6d4d:ffa6 with SMTP id
 d2e1a72fcca58-73682c52f85mr861012b3a.15.1741126613861; Tue, 04 Mar 2025
 14:16:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304211500.213073-1-mykyta.yatsenko5@gmail.com> <20250304211500.213073-2-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250304211500.213073-2-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Mar 2025 14:16:42 -0800
X-Gm-Features: AQ5f1JpH-50C-AVJ7d2jC1tl6c4lVFdDjseeDf4GvvtCyDxjptSQRgrP7KY4RFI
Message-ID: <CAEf4BzYRLGgESZfstAz7FWcC2BSTLtQwU97Fo8+Xo_Gkby_Tmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: BPF token support for BPF_BTF_GET_FD_BY_ID
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 1:15=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Currently BPF_BTF_GET_FD_BY_ID requires CAP_SYS_ADMIN, which does not
> allow running it from user namespace. This creates a problem when
> freplace program running from user namespace needs to query target
> program BTF.
> This patch relaxes capable check from CAP_SYS_ADMIN to CAP_BPF and adds
> support for BPF token that can be passed in attributes to syscall.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/uapi/linux/bpf.h |  1 +
>  kernel/bpf/syscall.c     | 12 ++++++++----
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index bb37897c0393..73c23daacabf 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1652,6 +1652,7 @@ union bpf_attr {
>                 };
>                 __u32           next_id;
>                 __u32           open_flags;
> +               __s32           token_fd;
>         };
>
>         struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 57a438706215..487054cb4704 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4750,6 +4750,9 @@ static int bpf_prog_get_info_by_fd(struct file *fil=
e,
>
>         info.verified_insns =3D prog->aux->verified_insns;
>
> +       if (prog->aux->btf)
> +               info.btf_id =3D btf_obj_id(prog->aux->btf);
> +

please split this change into its own patch

>         if (!bpf_capable()) {
>                 info.jited_prog_len =3D 0;
>                 info.xlated_prog_len =3D 0;
> @@ -4895,8 +4898,6 @@ static int bpf_prog_get_info_by_fd(struct file *fil=
e,
>                 }
>         }
>
> -       if (prog->aux->btf)
> -               info.btf_id =3D btf_obj_id(prog->aux->btf);
>         info.attach_btf_id =3D prog->aux->attach_btf_id;
>         if (attach_btf)
>                 info.attach_btf_obj_id =3D btf_obj_id(attach_btf);
> @@ -5137,14 +5138,17 @@ static int bpf_btf_load(const union bpf_attr *att=
r, bpfptr_t uattr, __u32 uattr_
>         return btf_new_fd(attr, uattr, uattr_size);
>  }
>
> -#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD btf_id
> +#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD token_fd
>
>  static int bpf_btf_get_fd_by_id(const union bpf_attr *attr)
>  {
> +       struct bpf_token *token;
> +
>         if (CHECK_ATTR(BPF_BTF_GET_FD_BY_ID))
>                 return -EINVAL;
>
> -       if (!capable(CAP_SYS_ADMIN))
> +       token =3D attr->token_fd ? bpf_token_get_from_fd(attr->token_fd) =
: NULL;

see how we use BPF_F_TOKEN_FD flag in other places, we should do the same h=
ere

pw-bot: cr

> +       if (!bpf_token_capable(token, CAP_BPF))

we probably should keep it CAP_SYS_ADMIN, just do
s/capable/bpf_token_capable/ change

>                 return -EPERM;
>
>         return btf_get_fd_by_id(attr->btf_id);
> --
> 2.48.1
>

