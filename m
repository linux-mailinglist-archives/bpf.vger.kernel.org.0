Return-Path: <bpf+bounces-44924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4B09CD5E7
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 04:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF5328183D
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 03:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B093515B10D;
	Fri, 15 Nov 2024 03:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSQcnopm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C395A14F9D9
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 03:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731641447; cv=none; b=Q01L1ZZhwQ7+zsjz0ZeQT5D/guchNHZu32OSAss3DqSlcinxnmBFIIyrK65RCKA/Yt4r0rtm5RSYAAcKjKp9YagftPn3NfYA6r5w6ihj3XJdx1A1O/nSEeWBAU15bdeYw7ndWw7IZQo5vMnxFf/jiNJ4nXq6ijSqtF2AuLJmlWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731641447; c=relaxed/simple;
	bh=x6YMwpLv2Qvb6BIQxCAnausJEQy3zrvEXJ8kqYv3DT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJXbWpBS4iEWHrQm3iY1pcYtBXsMW/iVhxpQZb+D8mns/grz7luXXnQZ0dLEUz+/HgfdfxiIzCb6lj1E49A2fbpIPoTkxpS+mWg1URyI2DQUVbDdmeLl/+BLKC/BdegHPrnMxctWB/KGpjAg2BG5sNdjrbVFAPYHi6w7RDpYIpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSQcnopm; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ea14c863c1so354147a91.0
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 19:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731641445; x=1732246245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+TEM9TJ09P/OndWInPb8TT7J/8dUOAZSVSdyxaL0jk=;
        b=nSQcnopm2lriRvZaMhWxHImgONJr9/df5QDm7DG816EAwGsbXCdpPR1Hl3lWDjB3zR
         bbF5XL0KVGx2EOw/chfNCYbsWUCgUoN39enoygCJr+uiE2EClJiRN8CNncL8qKe2uvJj
         ihwDvVimS119mVdmxCPqV1Tq8OtMkaUJpxm2QAX1uYlQVt0dAOrA6CLPeDz4/sC/8nWf
         euqlPvBjRYamoDOqiMBqNqO/bM9C14QVL3xSWIWpzsdfdO8kShaH8v/ihTyFNcwx9kDm
         yrN6n1pPjOZeOOYtOJ0nZnYfIDBOz07mBhHXdFBvnZi2BmOIsbxxtJc2cvlvnommc/GJ
         vHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731641445; x=1732246245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+TEM9TJ09P/OndWInPb8TT7J/8dUOAZSVSdyxaL0jk=;
        b=TShnRhW/dxWixxFg6t2vY9rFhSK0QqRoqpDzIG8JBrIepo3oxAuwwRvW9WRsU+4NbZ
         EpmrqBuBZWNYo0NPgN8PT7Jb9zK3bjLp+WiHX7paMqW+aPgqi90agg0i0J0BJUCQ8lVR
         uY2OhvKRhexfAaqjLtX8hlEpLGBtUuqgXafSBeWrjnVSkOzsb31QmVRdckgStzXne7qI
         y4CEZBnI9GPSH8ln/JIfd6B5N1Ah7v22mt4mzloHXapXA+wLzCJw+bQXEsAk2sohnOeX
         DYjIULxGZoxQE3jB2bup4mzxvTZIM8uGP2RhVVUO/CBO7zIWVfDyVoh9m06Sd0lq1Fas
         skiQ==
X-Gm-Message-State: AOJu0YxERWL2kEdClZiN1zrE5Tt9wK2jJlcEH8lyWZiJHi18AE/MnKEU
	ejfxzTQiHTCTXt6kNSR1XmmUG1NewCFxt1Ewd+BajuEcDp4zRgJHJk0GS6ijGZz7QdTh4/J6EYK
	82kk8cYpQem79qeEdWPhIgZZ0T4kbqQ==
X-Google-Smtp-Source: AGHT+IHlTNgbIweNtEyyEmF2D3CI86bt2FUaKjfQNT06yR+rmehgDWiv0wQdkB0L/R1uy9MmRt42TU8BRBYJLdKQJx0=
X-Received: by 2002:a17:90b:4ecd:b0:2e2:cd5e:7eef with SMTP id
 98e67ed59e1d1-2ea15585ba3mr1423413a91.27.1731641444961; Thu, 14 Nov 2024
 19:30:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115003853.864397-1-ihor.solodrai@pm.me>
In-Reply-To: <20241115003853.864397-1-ihor.solodrai@pm.me>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Nov 2024 19:30:32 -0800
Message-ID: <CAEf4BzY=5gw5nwx2jA5wzLcuc3=h1vALO=gkk1y=DrzHxdXzgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: set test path for token/obj_priv_implicit_token_envvar
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 4:39=E2=80=AFPM Ihor Solodrai <ihor.solodrai@pm.me>=
 wrote:
>
> token/obj_priv_implicit_token_envvar test may fail in an environment
> where the process executing tests can not write to the root path.
>
> Example:
> https://github.com/libbpf/libbpf/actions/runs/11844507007/job/33007897936
>
> Change default path used by the test to /tmp/bpf-token-fs, and make it
> runtime configurable via an environment variable.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---
>  tools/testing/selftests/bpf/prog_tests/token.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testi=
ng/selftests/bpf/prog_tests/token.c
> index fe86e4fdb89c..39f5414b674b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/token.c
> +++ b/tools/testing/selftests/bpf/prog_tests/token.c
> @@ -828,8 +828,11 @@ static int userns_obj_priv_btf_success(int mnt_fd, s=
truct token_lsm *lsm_skel)
>         return validate_struct_ops_load(mnt_fd, true /* should succeed */=
);
>  }
>
> +static const char* token_bpffs_custom_dir() {
> +       return getenv("BPF_SELFTESTS_BPF_TOKEN_DIR") ? : "/tmp/bpf-token-=
fs";

reformatted it to kernel C style, applied to bpf-next

> +}
> +
>  #define TOKEN_ENVVAR "LIBBPF_BPF_TOKEN_PATH"
> -#define TOKEN_BPFFS_CUSTOM "/bpf-token-fs"
>
>  static int userns_obj_priv_implicit_token(int mnt_fd, struct token_lsm *=
lsm_skel)
>  {
> @@ -892,6 +895,7 @@ static int userns_obj_priv_implicit_token(int mnt_fd,=
 struct token_lsm *lsm_skel
>
>  static int userns_obj_priv_implicit_token_envvar(int mnt_fd, struct toke=
n_lsm *lsm_skel)
>  {
> +       const char *custom_dir =3D token_bpffs_custom_dir();
>         LIBBPF_OPTS(bpf_object_open_opts, opts);
>         struct dummy_st_ops_success *skel;
>         int err;
> @@ -909,10 +913,10 @@ static int userns_obj_priv_implicit_token_envvar(in=
t mnt_fd, struct token_lsm *l
>          * BPF token implicitly, unless pointed to it through
>          * LIBBPF_BPF_TOKEN_PATH envvar
>          */
> -       rmdir(TOKEN_BPFFS_CUSTOM);
> -       if (!ASSERT_OK(mkdir(TOKEN_BPFFS_CUSTOM, 0777), "mkdir_bpffs_cust=
om"))
> +       rmdir(custom_dir);
> +       if (!ASSERT_OK(mkdir(custom_dir, 0777), "mkdir_bpffs_custom"))
>                 goto err_out;
> -       err =3D sys_move_mount(mnt_fd, "", AT_FDCWD, TOKEN_BPFFS_CUSTOM, =
MOVE_MOUNT_F_EMPTY_PATH);
> +       err =3D sys_move_mount(mnt_fd, "", AT_FDCWD, custom_dir, MOVE_MOU=
NT_F_EMPTY_PATH);
>         if (!ASSERT_OK(err, "move_mount_bpffs"))
>                 goto err_out;
>
> @@ -925,7 +929,7 @@ static int userns_obj_priv_implicit_token_envvar(int =
mnt_fd, struct token_lsm *l
>                 goto err_out;
>         }
>
> -       err =3D setenv(TOKEN_ENVVAR, TOKEN_BPFFS_CUSTOM, 1 /*overwrite*/)=
;
> +       err =3D setenv(TOKEN_ENVVAR, custom_dir, 1 /*overwrite*/);
>         if (!ASSERT_OK(err, "setenv_token_path"))
>                 goto err_out;
>
> @@ -951,11 +955,11 @@ static int userns_obj_priv_implicit_token_envvar(in=
t mnt_fd, struct token_lsm *l
>         if (!ASSERT_ERR(err, "obj_empty_token_path_load"))
>                 goto err_out;
>
> -       rmdir(TOKEN_BPFFS_CUSTOM);
> +       rmdir(custom_dir);
>         unsetenv(TOKEN_ENVVAR);
>         return 0;
>  err_out:
> -       rmdir(TOKEN_BPFFS_CUSTOM);
> +       rmdir(custom_dir);
>         unsetenv(TOKEN_ENVVAR);
>         return -EINVAL;
>  }
> --
> 2.47.0
>
>

