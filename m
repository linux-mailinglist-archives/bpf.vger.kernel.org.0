Return-Path: <bpf+bounces-16902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC17180766F
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 18:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9775E281D01
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 17:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F055675A1;
	Wed,  6 Dec 2023 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acY/7kCz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E3BD4D
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 09:21:29 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54c967010b2so2386087a12.0
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 09:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701883287; x=1702488087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSA+fB9LW2M1GgTqkoHBcyVSf9fgRLm/r7tsv5DOrcQ=;
        b=acY/7kCzbYQ4wWeb1/jKPMdDXyDVia2SiwRJMEed1Gn+lUrh2lgSWNrZzDl1D1QYp/
         u6VU7I0O8enOSJ30XBs2aZw3AqkuJ/iyuokCK4y3/KQHXlaXDLQ80RqERcNuqxvA5mIQ
         Bkzp8IIk6CQvIprUHqWtVrmDggLngeR1JyW/ivmgDYGOkYMvfW/Hjm33734Ggd+W2UvF
         a3M+h5144+ktnHFf+i+FrPHQrDDs8HQbtI8D8Mexm85/y0B/finvNmrHjZLKjcCeDaki
         YA6pUhzB4UjEYy3e4Z1wIYqObqneA8kDbJEdFntLg6NMMHwv2epSs3DZMuZGIUdWhYUC
         gjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701883287; x=1702488087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSA+fB9LW2M1GgTqkoHBcyVSf9fgRLm/r7tsv5DOrcQ=;
        b=QOH3GaxWQpwOOYsT/2mGjO9lkboTbJ6nh3MHycXnvPloiunsKpjQL1fDZKrNaVGlz6
         ykoS34yWNdu7673fPhKZwUXRIC2orSekNwVnEj12yH29m2THnKWIqKZDUgI0VMzlWjIW
         iv3etFcjc5yScasGpJNrUufIq5HxacNX1GN6ZFDCo/5Wp7+uE34aHf7jGJfG/r0li+bB
         tZbu/tkHLvaWcXm3Mv2hSXMlrtlezEQP7BtO0ZzBv+MFNcD/NrnE/mTFXvM94BdQJnAb
         YSxuQjzuDLXBWVkVlBMLrydTcB1Z8FGY1X9bh3wyeY/8ZVeX8bwhNWGfSnZnCJyGzKJM
         bdlw==
X-Gm-Message-State: AOJu0Yz+67GTORwJJHvzXHB9Nrdk4LGVIcpWaj2+MdK/Q2/v7DlCQjG1
	xg9VifZBam82pMllzUVHiAGO23t10sa8ovnSLH/VHoN7IwE=
X-Google-Smtp-Source: AGHT+IGM/nEE6emPRcAeElkp0a5oyv075IQUmolRGuBUAL5NL37rwQ1w5kqWp/BQ/LNPHZ9llYi7iYmp8cX+bsCsu0U=
X-Received: by 2002:a17:906:101:b0:a18:81a3:a1fe with SMTP id
 1-20020a170906010100b00a1881a3a1femr3502108eje.1.1701883287221; Wed, 06 Dec
 2023 09:21:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206073624.149124-1-jiejiang@chromium.org>
In-Reply-To: <20231206073624.149124-1-jiejiang@chromium.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Dec 2023 09:21:15 -0800
Message-ID: <CAEf4BzZvuFcBMvejMoQVCPaRsDQRXmqAvVxJ-o3G=0Ojf0RhtA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Support uid and gid when mounting bpffs
To: Jie Jiang <jiejiang@chromium.org>
Cc: bpf@vger.kernel.org, vapier@chromium.org, brauner@kernel.org, 
	andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 11:36=E2=80=AFPM Jie Jiang <jiejiang@chromium.org> w=
rote:
>
> Parse uid and gid in bpf_parse_param() so that they can be passed in as
> the `data` parameter when mount() bpffs. This will be useful when we
> want to control which user/group has the control to the mounted bpffs,
> otherwise a separate chown() call will be needed.
>
> Signed-off-by: Jie Jiang <jiejiang@chromium.org>
> ---
> v1 -> v2: Add additional validation in bpf_parse_param() for if the
>   requested uid/gid is representable in the fs's idmapping.
>
>  kernel/bpf/inode.c | 52 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 50 insertions(+), 2 deletions(-)
>

LGTM, but I want to point out that this will conflict with the BPF
token series ([0]), so depending which one goes in first, the other
will have to be rebased.

Acked-by: Andrii Nakryiko <andrii@kernel.org>


  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D805707&=
state=3D*

>
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 1aafb2ff2e953..5bc79535d3357 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -599,8 +599,15 @@ EXPORT_SYMBOL(bpf_prog_get_type_path);
>   */
>  static int bpf_show_options(struct seq_file *m, struct dentry *root)
>  {
> -       umode_t mode =3D d_inode(root)->i_mode & S_IALLUGO & ~S_ISVTX;
> -
> +       struct inode *inode =3D d_inode(root);
> +       umode_t mode =3D inode->i_mode & S_IALLUGO & ~S_ISVTX;
> +
> +       if (!uid_eq(inode->i_uid, GLOBAL_ROOT_UID))
> +               seq_printf(m, ",uid=3D%u",
> +                          from_kuid_munged(&init_user_ns, inode->i_uid))=
;
> +       if (!gid_eq(inode->i_gid, GLOBAL_ROOT_GID))
> +               seq_printf(m, ",gid=3D%u",
> +                          from_kgid_munged(&init_user_ns, inode->i_gid))=
;
>         if (mode !=3D S_IRWXUGO)
>                 seq_printf(m, ",mode=3D%o", mode);
>         return 0;
> @@ -625,15 +632,21 @@ static const struct super_operations bpf_super_ops =
=3D {
>  };
>
>  enum {
> +       OPT_UID,
> +       OPT_GID,
>         OPT_MODE,
>  };
>
>  static const struct fs_parameter_spec bpf_fs_parameters[] =3D {
> +       fsparam_u32     ("gid",                         OPT_GID),
>         fsparam_u32oct  ("mode",                        OPT_MODE),
> +       fsparam_u32     ("uid",                         OPT_UID),
>         {}
>  };
>
>  struct bpf_mount_opts {
> +       kuid_t uid;
> +       kgid_t gid;
>         umode_t mode;
>  };
>
> @@ -641,6 +654,8 @@ static int bpf_parse_param(struct fs_context *fc, str=
uct fs_parameter *param)
>  {
>         struct bpf_mount_opts *opts =3D fc->fs_private;
>         struct fs_parse_result result;
> +       kuid_t uid;
> +       kgid_t gid;
>         int opt;
>
>         opt =3D fs_parse(fc, bpf_fs_parameters, param, &result);
> @@ -662,12 +677,43 @@ static int bpf_parse_param(struct fs_context *fc, s=
truct fs_parameter *param)
>         }
>
>         switch (opt) {
> +       case OPT_UID:
> +               uid =3D make_kuid(current_user_ns(), result.uint_32);
> +               if (!uid_valid(uid))
> +                       goto bad_value;
> +
> +               /*
> +                * The requested uid must be representable in the
> +                * filesystem's idmapping.
> +                */
> +               if (!kuid_has_mapping(fc->user_ns, uid))
> +                       goto bad_value;
> +
> +               opts->uid =3D uid;
> +               break;
> +       case OPT_GID:
> +               gid =3D make_kgid(current_user_ns(), result.uint_32);
> +               if (!gid_valid(gid))
> +                       goto bad_value;
> +
> +               /*
> +                * The requested gid must be representable in the
> +                * filesystem's idmapping.
> +                */
> +               if (!kgid_has_mapping(fc->user_ns, gid))
> +                       goto bad_value;
> +
> +               opts->gid =3D gid;
> +               break;
>         case OPT_MODE:
>                 opts->mode =3D result.uint_32 & S_IALLUGO;
>                 break;
>         }
>
>         return 0;
> +
> +bad_value:
> +       return invalfc(fc, "Bad value for '%s'", param->key);
>  }
>
>  struct bpf_preload_ops *bpf_preload_ops;
> @@ -750,6 +796,8 @@ static int bpf_fill_super(struct super_block *sb, str=
uct fs_context *fc)
>         sb->s_op =3D &bpf_super_ops;
>
>         inode =3D sb->s_root->d_inode;
> +       inode->i_uid =3D opts->uid;
> +       inode->i_gid =3D opts->gid;
>         inode->i_op =3D &bpf_dir_iops;
>         inode->i_mode &=3D ~S_IALLUGO;
>         populate_bpffs(sb->s_root);
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>

