Return-Path: <bpf+bounces-53920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D39A5E3F1
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 19:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B1317495B
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 18:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEFE25744E;
	Wed, 12 Mar 2025 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mup84QEs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C011D54E3
	for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741805606; cv=none; b=FxSdEXznJGUEjJCHTF817zhRmsKKUZpBSFBgSH9imyLUMFtpNhn853o87sVHM1fFUQwgxQBUiG1xhsAAAicMWBuHMyhdq7LB3uO74Goe8hQ9ScphkjYvvKDGOJIi5cYJZmJ2KlivCxEJhZFv/5vpYYfBNJ25VQHXKzp++loLHcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741805606; c=relaxed/simple;
	bh=uepdvr2FLhi0VG8T94c5vb6CIijOSMLM3oEEqJNm7lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbZU9HR1m2KoJVcIQzFH6MkCj3ZTxw6uFj/B93VjH28gVTiSfjEgnBFrekMkPzdjybZUMY5JxW5DV5Rk9pJjSB8bcjf8iMzGoikfTXSSata9X5GiUX0K2dA5fja5C1DCsdkTGRvsoVCQRppEnRRV77v3BU7cWTv4MqNpay+9GXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mup84QEs; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2235189adaeso5011185ad.0
        for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 11:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741805604; x=1742410404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywXMyGxgN836Avuofj4RaLSrzJz9VDsUoYQEETxm7vI=;
        b=mup84QEs+YIx/TGbVdBwh/XPiiTYEEo9/fDp1XIJiObiFUi1yA7l4BbQO79ZLdpq7Q
         r0RhFpvHHspuFeFcy+1e+77rnemt9anDVoGdAV1yEn0MJ6S/m8xYZqjxBZmua0qL/znO
         yxhwGilxyJN3M6+knRmRF4nLMFHOSDxEWDbRvkWGtLjsKHOjZdm3d870xA57Jsjlp6Uz
         R6Xm1Myi/pfvgH0ClQlKBoBomDZ2+kUJAldFB9ZlvxVElommnqli0HISQ4pqBXm1u7SB
         ajds1GWCuQ1av8i4CV9t6Y4Asfw7FCACpAnyX3NxfAJK2oaGVV6jRgRmXfVeJKLWQALK
         xCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741805604; x=1742410404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywXMyGxgN836Avuofj4RaLSrzJz9VDsUoYQEETxm7vI=;
        b=L0HEfT1GXgNuHCL32jxfEEeLYZydfSB2BgMSBRo/S56t40Map9I//48gI9KIenwxHM
         BH2SOVv8m3kvxqbDeGlbf+3lrZ4piwBgiweF2yo3/oQaavXSC1SeOzXgcsp7Dw6KDBmm
         ys5vxma5wXYTZUVPSCJAk7bAOEeWhfWLj88jFnNv2W6hSMYyociriYkUI67UpnrtbGB9
         V7c1cAHskBP28Q9NCehDZGHzbkgCba8siiM8J0z+gH1T1zNdE7ZKZbVCKgrH/7BPDZ3p
         DKOrkGWBEHSCw27gqYZqxZqIBxyiBMpHyhUrA/5DPlOyeUPyaRaTvSRGzodL+jW8QDuW
         eonQ==
X-Gm-Message-State: AOJu0YwBv3jKnx8KU03+bojhUp4ZW/0qHWNpJ8naOA/mEBRsxizJ7d1N
	iUogTQmFNeHKlNGimKgSd2fha3yA3JMk/V6oNoDBgYIOxxuyuz2RjW6z9+x8YHOONQX0QEeZzyc
	tlRjOPqBAifQb2zgjTlO9fh6dHnYuxA2N
X-Gm-Gg: ASbGnctt5CWZ4Xts7pg10g4qScrW+XSPPdRea3kcLYQD+t5XqWzjcZJ/hbx6ptzuT4p
	8Ow4zOMXjokrb9ASBCrs77KSX3N7IVr7Bqw/pPDnIOIWaS7hcmg3wSmRZjH1A0MPzHEvDyR0e/6
	2A0E3rO1NpwUOzb6d7OViKQ/mTRVdDT/ODU9hCrRU9wA==
X-Google-Smtp-Source: AGHT+IEMc/kqfJyXyFgesQ4zKwZropK975y1JMx6tYP14NJND2aHcLC5Gpz/k2CaLQDK0e8p8lWXcYloDh44YSUY1Jo=
X-Received: by 2002:a17:902:f60f:b0:223:807f:7f92 with SMTP id
 d9443c01a7336-225c25b4cb2mr10585705ad.20.1741805604486; Wed, 12 Mar 2025
 11:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311215420.456512-1-mykyta.yatsenko5@gmail.com> <20250311215420.456512-2-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250311215420.456512-2-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 12 Mar 2025 11:53:12 -0700
X-Gm-Features: AQ5f1Jpi7MUgRI-wHxAb_Nni2-d__oyfqIPTqPSHE_ilEqw5ksHa3Ykgsro6jnk
Message-ID: <CAEf4BzYRrHmDUBX=yqAtNbUJ7C9En_YrDSOY=zcbkoLVNZcC9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/4] bpf: BPF token support for BPF_BTF_GET_FD_BY_ID
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	olsajiri@gmail.com, yonghong.song@linux.dev, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 2:54=E2=80=AFPM Mykyta Yatsenko
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
>  include/uapi/linux/bpf.h                      |  1 +
>  kernel/bpf/syscall.c                          | 20 +++++++++++++++++--
>  tools/include/uapi/linux/bpf.h                |  1 +
>  .../bpf/prog_tests/libbpf_get_fd_by_id_opts.c |  3 +--
>  4 files changed, 21 insertions(+), 4 deletions(-)
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
> index 57a438706215..188f7296cf9f 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5137,15 +5137,31 @@ static int bpf_btf_load(const union bpf_attr *att=
r, bpfptr_t uattr, __u32 uattr_
>         return btf_new_fd(attr, uattr, uattr_size);
>  }
>
> -#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD btf_id
> +#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD token_fd
>
>  static int bpf_btf_get_fd_by_id(const union bpf_attr *attr)
>  {
> +       struct bpf_token *token =3D NULL;
> +
>         if (CHECK_ATTR(BPF_BTF_GET_FD_BY_ID))
>                 return -EINVAL;

as I mentioned in another email, we used to implicitly reject any
open_flags set because of BPF_BTF_GET_FD_BY_ID_LAST_FIELD btf_id, but
now that we do support some flags in open_flags, we need to validate
that there are no other flags. So you need something like:

if (attr->open_flags & ~BPF_F_TOKEN_FD)
    return -EINVAL;


pw-bot: cr

>
> -       if (!capable(CAP_SYS_ADMIN))
> +       if (attr->open_flags & BPF_F_TOKEN_FD) {
> +               token =3D bpf_token_get_from_fd(attr->token_fd);
> +               if (IS_ERR(token))
> +                       return PTR_ERR(token);
> +               if (!bpf_token_allow_cmd(token, BPF_BTF_GET_FD_BY_ID)) {
> +                       bpf_token_put(token);
> +                       token =3D NULL;
> +               }
> +       }
> +
> +       if (!bpf_token_capable(token, CAP_SYS_ADMIN)) {
> +               bpf_token_put(token);
>                 return -EPERM;
> +       }
> +
> +       bpf_token_put(token);
>
>         return btf_get_fd_by_id(attr->btf_id);
>  }
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index bb37897c0393..73c23daacabf 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1652,6 +1652,7 @@ union bpf_attr {
>                 };
>                 __u32           next_id;
>                 __u32           open_flags;
> +               __s32           token_fd;
>         };
>
>         struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
> diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_o=
pts.c b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
> index a3f238f51d05..976ff38a6d43 100644
> --- a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
> +++ b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
> @@ -75,9 +75,8 @@ void test_libbpf_get_fd_by_id_opts(void)
>         if (!ASSERT_EQ(ret, -EINVAL, "bpf_link_get_fd_by_id_opts"))
>                 goto close_prog;
>
> -       /* BTF get fd with opts set should not work (no kernel support). =
*/
>         ret =3D bpf_btf_get_fd_by_id_opts(0, &fd_opts_rdonly);
> -       ASSERT_EQ(ret, -EINVAL, "bpf_btf_get_fd_by_id_opts");
> +       ASSERT_EQ(ret, -ENOENT, "bpf_btf_get_fd_by_id_opts");
>
>  close_prog:
>         if (fd >=3D 0)
> --
> 2.48.1
>

