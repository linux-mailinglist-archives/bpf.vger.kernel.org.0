Return-Path: <bpf+bounces-53742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E132A59A82
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 16:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE9E188E612
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 15:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A9422E415;
	Mon, 10 Mar 2025 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nad7nJ78"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE69C22E3F4
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622238; cv=none; b=BYy5E8dPD5RdjcBMHECIrVwAXMXEkNwvqSbEE3K9lejO+1Kc688MCx0k704S/zt/6PoOFuq7LfZXVYOQMuHzdSOP08C1oThPRqYl7BVdJVsBaNKf5FVo/V2qgxavaQ+IpP4TkpsF+Sv8W1VikhPcBKxs20F/C4spESHfb9Gjw1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622238; c=relaxed/simple;
	bh=ZnWBolZ9mgr0354kBHx3ezMjZj3xyL740u/tFqoPJuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bm4W87t/CSdC3w/fm0qsnX3eFmxWhKtIUH8xsZrVG1QF+Gw7+BgD8JYAFYVqrzPGoNCQ6J+MC0Q86UE6/5Djn6ZbTU99S+aXv7vP7xu9v5XrOXqPbUSj3m81VAZIyTOZwO+0Y7Px7gUJeGz60Qo4IuDu0GOEoj+rl4QeGQpBAFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nad7nJ78; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22435603572so43684945ad.1
        for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741622236; x=1742227036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfDY9iQaXwU4VfDLVOW8mAyFKA2HYB/3pD3Bbfn9vuc=;
        b=Nad7nJ788ayVd1R6qQMMVfp/ge6zwgMDINR8c7jOKkRVwqMj3wZH72B/RfOxk3ltEJ
         PADTRs6v5PRjo4mItyz6bADDo9Z5zODctnopMF4aYcw2Kc8HBFNQNYw800vjLcFwBG87
         W4N8vz3vYx+XNULxpydxYuAQY26z4abikZZOp2on/6wrj3hBI1knfDOQV+SlJvOoKUV4
         HniitepcLJJAqYns76KY5YlLX2T5eb0V6Qa//zvX8HzUFZiXHwHkPyBaKh7zGl7Ky5lN
         H7Lt+BZ7NeirOSkRGTt+/f83e7lecq7/pDDa2Mxi/xxIjtLfAN48jO+OgtE02eB7Tnoa
         mZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741622236; x=1742227036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfDY9iQaXwU4VfDLVOW8mAyFKA2HYB/3pD3Bbfn9vuc=;
        b=HtJ51mf06NjxVteYvxX5MHaXP15OW7SY16YuCIvqGWhlvjuCK4Gq3E4ZbAIp+n/HhA
         zOpvLtxpakzPG62PU7dwKbsd3+qS8v3RgEPzhRh6tlK74w+T/1JgARectZ7UQJmCa8qD
         Gr0Kjq87EvHlmkReyGKo3hr0iLn+LQ9F/0UcyhW3pVFCk+MHZodBTRUHN8bHc9LgrBks
         DmH5Ngvao+bk1VhFgtNU8vmQ53bLJloTpZ0w6kOBpQxWFL3w48MRbQKN7+vMREsW9O5Z
         iZz24RpV6BHxbRR7XuJPhnQ9fhVQkE69T6d5ZcyXHHa6K71u/ZQf5759M1IIHjjHA4Y8
         dPOw==
X-Gm-Message-State: AOJu0YxgbXBrDgG3hqeUONmLXUWKXzac0ZEdRE8hWQsgvQ+eaqP88Usj
	RYxsJ+V5jD151O77MQ8idn4W8Toj7gNZ4BR/FHygdbXLhh3ruQfwu+Bvtoo8U6HQSDmivqE2d+v
	mqz+yojyKgzwThn/ffUaK0dnzZDM=
X-Gm-Gg: ASbGncv3EreSE9vahWyckY9LIK8Mj4x9nsiVBfR2iok2/iuyDscJz0CTJPpv10t2eWt
	LdkseztFN7VvshvbdR/Sd57rhwb0uGDbvMml9hiFR03FGX8ULD+WurD1vquXrkuBUFMBq6LKiKE
	AO5HjreIyAyvDLCLClUkco/fZ/WOG8QWmucukB73JGKQ==
X-Google-Smtp-Source: AGHT+IEhQ+uASdYPK5qUdr1BEVGo34oNsBD31IK0svXg698SSVs+hhQDLJ7JRCA5suEGVWDX+1EPUeXeD7A8YVhSCLI=
X-Received: by 2002:a17:902:ce0a:b0:220:cb1a:da5 with SMTP id
 d9443c01a7336-22428c075e3mr262400145ad.40.1741622235977; Mon, 10 Mar 2025
 08:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310001319.41393-1-mykyta.yatsenko5@gmail.com> <20250310001319.41393-2-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250310001319.41393-2-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 10 Mar 2025 08:57:02 -0700
X-Gm-Features: AQ5f1JouxV4_ff0wHPTcEujhVcLlxOkSnqw47vOed0Lvr9T0vab0nyCSNjPqPUg
Message-ID: <CAEf4BzbwD62Q1W6KQnjzAvKULcihKG0VtYdJRr1wD0RS9=eJAw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: BPF token support for BPF_BTF_GET_FD_BY_ID
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	olsajiri@gmail.com, yonghong.song@linux.dev, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 5:13=E2=80=AFPM Mykyta Yatsenko
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
>  kernel/bpf/syscall.c                          | 21 ++++++++++++++++---
>  tools/include/uapi/linux/bpf.h                |  1 +
>  .../bpf/prog_tests/libbpf_get_fd_by_id_opts.c |  3 +--
>  4 files changed, 21 insertions(+), 5 deletions(-)
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
> index 57a438706215..eb3a31aefa70 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5137,17 +5137,32 @@ static int bpf_btf_load(const union bpf_attr *att=
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
>
> -       if (!capable(CAP_SYS_ADMIN))
> -               return -EPERM;
> +       if (attr->open_flags & BPF_F_TOKEN_FD) {
> +               token =3D bpf_token_get_from_fd(attr->token_fd);
> +               if (IS_ERR(token))
> +                       return PTR_ERR(token);
> +               if (!bpf_token_allow_cmd(token, BPF_BTF_GET_FD_BY_ID))
> +                       goto out;

Look at map_create() and its handling of BPF token. If
bpf_token_allow_cmd() returns false, we still perform
bpf_token_capable(token, <cap>) check (where token will be NULL, so
it's effectively just capable() check). While here you will just
return -EPERM *even if the process actually has real CAP_SYS_ADMIN*
capability.

Instead, do:

bpf_token_put(token);
token =3D NULL;

and carry on the rest of the logic

pw-bot: cr


> +       }
> +
> +       if (!bpf_token_capable(token, CAP_SYS_ADMIN))
> +               goto out;
> +
> +       bpf_token_put(token);
>
>         return btf_get_fd_by_id(attr->btf_id);
> +out:
> +       bpf_token_put(token);
> +       return -EPERM;
>  }
>
>  static int bpf_task_fd_query_copy(const union bpf_attr *attr,
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

Why would your patch change this behavior? and if it does, should it?
This looks fishy.

>
>  close_prog:
>         if (fd >=3D 0)
> --
> 2.48.1
>

