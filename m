Return-Path: <bpf+bounces-7727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BB177BCE8
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 17:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8352928109A
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 15:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B62C2CF;
	Mon, 14 Aug 2023 15:24:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C60C2C6
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 15:24:48 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB5DE7E
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 08:24:46 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe1e7440f1so1326088e87.0
        for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 08:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1692026685; x=1692631485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ziw3r3Tja22DqMHkyIjj75Auq4FVBkHVssPtrJPa9M=;
        b=M4xjxW1e/fZPcoLMcHB5mqTpLyc8P97Cwp0PNoQ5QHbNxHlZjpjwVZ2popwEFDtpxf
         U5Ul0NNV0zQj+zAeghcawTCMiNcV8jaHf8Dc06XeIjlDfkLHGyLSUJdxnvwloecVMliq
         5gJKkB4paIGj4gkGU6+wcAG54AO1g6LOfL5DY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692026685; x=1692631485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ziw3r3Tja22DqMHkyIjj75Auq4FVBkHVssPtrJPa9M=;
        b=bxG7q5vpiHI+oqIvuQVMt+CPFFZKzGPyOPaXW3qEf8+4bpi65F3UxtYcSsNOtfspIK
         eQ5HsZfPWQVZ2pQJcUs1e6QKqnyRaN2KsxYMc1k+i7GKI4FjUx5npZB9dviRC+R9ZMZl
         ILisbnrwhRnBRjOG+tYLvqA+6H1FSZcGPqmo9G0lmpFfTvYkO1hgSxe+inNEAIqcHd/k
         052YMgWIU5nMKRK2isoEpXkHzngagrqof1zGzbmwQDpNz9aS7fTgHYt3ZBUSRLQXPYbU
         Y9sCqlgl3BCjdv2Q4oThvg7m6QRrX8ZHun1k/yMd5503F5KOi1CRv9kQd2j+IrK/Dwk1
         8e7A==
X-Gm-Message-State: AOJu0YypgJbZU1WQJdwU/9OHYonDVi24KVxi7r9CP1JZsdrSj8f3n1ak
	ot5jz0BCjyVuO5/SuJIAb60kDfKfqntG2d5/fuq7sA==
X-Google-Smtp-Source: AGHT+IFn8sdfqQhKIdKAAladZMLCbd6oLeRv8zsgX68V2UY+4U1l5/lbKnQBzr49lekz0v7RK+2H2fint5J5svOfdqk=
X-Received: by 2002:ac2:5f16:0:b0:4fe:5f0c:9db6 with SMTP id
 22-20020ac25f16000000b004fe5f0c9db6mr5252512lfq.5.1692026685009; Mon, 14 Aug
 2023 08:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230814-devcg_guard-v1-0-654971ab88b1@aisec.fraunhofer.de> <20230814-devcg_guard-v1-4-654971ab88b1@aisec.fraunhofer.de>
In-Reply-To: <20230814-devcg_guard-v1-4-654971ab88b1@aisec.fraunhofer.de>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 14 Aug 2023 17:24:33 +0200
Message-ID: <CAJqdLroV3uPnDOhTjVRiYHHFFXoj+fK0Na+mSac7zPYxkwbAsg@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] fs: allow mknod in non-initial userns using
 cgroup device guard
To: =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Cc: Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Quentin Monnet <quentin@isovalent.com>, Alexander Viro <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gyroidos@aisec.fraunhofer.de, stgraber@ubuntu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

+CC St=C3=A9phane Graber <stgraber@ubuntu.com>


On Mon, Aug 14, 2023 at 4:26=E2=80=AFPM Michael Wei=C3=9F
<michael.weiss@aisec.fraunhofer.de> wrote:
>
> If a container manager restricts its unprivileged (user namespaced)
> children by a device cgroup, it is not necessary to deny mknod
> anymore. Thus, user space applications may map devices on different
> locations in the file system by using mknod() inside the container.
>
> A use case for this, we also use in GyroidOS, is to run virsh for
> VMs inside an unprivileged container. virsh creates device nodes,
> e.g., "/var/run/libvirt/qemu/11-fgfg.dev/null" which currently fails
> in a non-initial userns, even if a cgroup device white list with the
> corresponding major, minor of /dev/null exists. Thus, in this case
> the usual bind mounts or pre populated device nodes under /dev are
> not sufficient.
>
> To circumvent this limitation, we allow mknod() in fs/namei.c if a
> bpf cgroup device guard is enabeld for the current task using
> devcgroup_task_is_guarded() and check CAP_MKNOD for the current user
> namespace by ns_capable() instead of the global CAP_MKNOD.
>
> To avoid unusable device nodes on file systems mounted in
> non-initial user namespace, may_open_dev() ignores the SB_I_NODEV
> for cgroup device guarded tasks.
>
> Signed-off-by: Michael Wei=C3=9F <michael.weiss@aisec.fraunhofer.de>
> ---
>  fs/namei.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index e56ff39a79bc..ef4f22b9575c 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3221,6 +3221,9 @@ EXPORT_SYMBOL(vfs_mkobj);
>
>  bool may_open_dev(const struct path *path)
>  {
> +       if (devcgroup_task_is_guarded(current))
> +               return !(path->mnt->mnt_flags & MNT_NODEV);
> +
>         return !(path->mnt->mnt_flags & MNT_NODEV) &&
>                 !(path->mnt->mnt_sb->s_iflags & SB_I_NODEV);
>  }
> @@ -3976,9 +3979,19 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inod=
e *dir,
>         if (error)
>                 return error;
>
> -       if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout &&
> -           !capable(CAP_MKNOD))
> -               return -EPERM;
> +       /*
> +        * In case of a device cgroup restirction allow mknod in user
> +        * namespace. Otherwise just check global capability; thus,
> +        * mknod is also disabled for user namespace other than the
> +        * initial one.
> +        */
> +       if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout) {
> +               if (devcgroup_task_is_guarded(current)) {
> +                       if (!ns_capable(current_user_ns(), CAP_MKNOD))
> +                               return -EPERM;
> +               } else if (!capable(CAP_MKNOD))
> +                       return -EPERM;
> +       }
>
>         if (!dir->i_op->mknod)
>                 return -EPERM;
>
> --
> 2.30.2
>

