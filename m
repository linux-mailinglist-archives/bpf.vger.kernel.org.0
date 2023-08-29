Return-Path: <bpf+bounces-8918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B88978C669
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 15:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B3128120A
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 13:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523241774F;
	Tue, 29 Aug 2023 13:47:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28027174C5
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 13:47:52 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB8F18F
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 06:47:35 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b73261babdso16253681fa.1
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 06:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1693316851; x=1693921651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTFpH+tPN6fRS5ps0ggd0sHJSF5U3bOMN6MYvOwDdro=;
        b=R+IWy5tQVKu3xhhlv2LyLotP94ITkvR56SNW6cYD7KSKHoy4MHc41gcPbrK6ClBT0S
         cn4Y2aA4LLoSvs2xxQ7s1L/mgTfS333ia+5RNnIY1huk8aFO0yYVxwZg1vjdUArHf9FU
         UNlMdsopWGezXyFx9M+LYktOT3yCegh+QAuTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693316851; x=1693921651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTFpH+tPN6fRS5ps0ggd0sHJSF5U3bOMN6MYvOwDdro=;
        b=lcghZ4XqU32SWRluCnlIOcLWrzV4CCYAHRXeV7rN/8POCAWEt0inWcAxjyc1hQCD4O
         wT9KEjovTUaPFEoVEzhV517wpMbYV+8A7A5inSMot0weAG4pAzLTFOc9QjFilWu7IeNi
         q5b81vk3CcYolodIIyM9TU0XUgvPQ0zkFpInU2jcW94LrYspZaBnvp7oq01sFFwLLhXL
         wAogIBNjC2Fx1of6iZ1CWPr7V11Jw0EmFw5wHHeswAdfLilAJf+aImOGLQiNfZoHCMBn
         qgwia7o/GhbPAhMtfApqtWuedMcH8OGtDa2PgWeLGkLB3eo89N/GUnhS+RHi11cKQJR4
         UQqA==
X-Gm-Message-State: AOJu0YxbKs/6UWM1M6RBwE735NvNsctE4+vqvUiEhrWqdKHuwdOT6Vk2
	pVvuZlMkDhBaMirfWxzVCk4rOJQMlk51Wk3wyS8Z7NqTjiMzVmuD1phVkw==
X-Google-Smtp-Source: AGHT+IETQlqCI9cp5f0SRdp69H8dlulsvy8kF9bvN+xEcCMAj1pWWrmos+5hn//qoDG05pY/itt+GE8B8tv1BlCOiZM=
X-Received: by 2002:ac2:5329:0:b0:500:7fc1:3875 with SMTP id
 f9-20020ac25329000000b005007fc13875mr15406545lfh.5.1693316158221; Tue, 29 Aug
 2023 06:35:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230814-devcg_guard-v1-0-654971ab88b1@aisec.fraunhofer.de>
 <20230814-devcg_guard-v1-1-654971ab88b1@aisec.fraunhofer.de>
 <20230815-feigling-kopfsache-56c2d31275bd@brauner> <20230817221102.6hexih3uki3jf6w3@macbook-pro-8.dhcp.thefacebook.com>
In-Reply-To: <20230817221102.6hexih3uki3jf6w3@macbook-pro-8.dhcp.thefacebook.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 29 Aug 2023 15:35:46 +0200
Message-ID: <CAJqdLrpx4v4To=XSK0gyM4Ks2+c=Jrni2ttw4ZViKv-jK=tJKQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] bpf: add cgroup device guard to flag a cgroup
 device prog
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Quentin Monnet <quentin@isovalent.com>, Alexander Viro <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gyroidos@aisec.fraunhofer.de, paul@paul-moore.com, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 12:11=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Aug 15, 2023 at 10:59:22AM +0200, Christian Brauner wrote:
> > On Mon, Aug 14, 2023 at 04:26:09PM +0200, Michael Wei=C3=9F wrote:
> > > Introduce the BPF_F_CGROUP_DEVICE_GUARD flag for BPF_PROG_LOAD
> > > which allows to set a cgroup device program to be a device guard.
> >
> > Currently we block access to devices unconditionally in may_open_dev().
> > Anything that's mounted by an unprivileged containers will get
> > SB_I_NODEV set in s_i_flags.
> >
> > Then we currently mediate device access in:
> >
> > * inode_permission()
> >   -> devcgroup_inode_permission()
> > * vfs_mknod()
> >   -> devcgroup_inode_mknod()
> > * blkdev_get_by_dev() // sget()/sget_fc(), other ways to open block dev=
ices and friends
> >   -> devcgroup_check_permission()
> > * drivers/gpu/drm/amd/amdkfd // weird restrictions on showing gpu info =
afaict
> >   -> devcgroup_check_permission()
> >
> > All your new flag does is to bypass that SB_I_NODEV check afaict and le=
t
> > it proceed to the devcgroup_*() checks for the vfs layer.
> >
> > But I don't get the semantics yet.
> > Is that a flag which is set on BPF_PROG_TYPE_CGROUP_DEVICE programs or
> > is that a flag on random bpf programs? It looks like it would be the
> > latter but design-wise I would expect this to be a property of the
> > device program itself.
>
> Looks like patch 4 attemps to bypass usual permission checks with:
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

Dear colleagues,

> which pretty much sounds like authoritative LSM that was brought up in th=
e past
> and LSM folks didn't like it.

Thanks for pointing this out, Alexei!
I've searched through the LKML archives and found a thread about this:
https://lore.kernel.org/all/CAEf4BzaBt0W3sWh_L4RRXEFYdBotzVEnQdqC7BO+PNWtD7=
eSUA@mail.gmail.com/

As far as I understand, disagreement here is about a practice of
skipping kernel-built capability checks based
on LSM hooks, right?

+CC Paul Moore <paul@paul-moore.com>

>
> If vfs folks are ok with this special bypass of permissions in vfs_mknod(=
)
> we can talk about kernel->bpf api details.
> The way it's done with BPF_F_CGROUP_DEVICE_GUARD flag is definitely no go=
,
> but no point going into bpf details now until agreement on bypass is made=
.

+CC Miklos Szeredi <miklos@szeredi.hu>
+CC Amir Goldstein <amir73il@gmail.com>

Kind regards,
Alex

