Return-Path: <bpf+bounces-17006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E368089BA
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 15:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9094B282975
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 14:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBED41230;
	Thu,  7 Dec 2023 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxlFeUcX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B814041206
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 14:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341E9C433CA
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 14:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701957706;
	bh=YTXuOMMriKdd+onoC0Y8SgFcupio3Xhu6mWmw4u/O1o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jxlFeUcXh5QApExKUA9TfaInxYNHMpTRswKpOfNqUGsWBSRw/bo9e1oPwCCOh3DYF
	 31SpJ2Xqat664LxLlevqxSAdIfY79mE9R4wNbB1gUCPpztTft6qet/i3uj08RomW+F
	 VMJLaBtjLlH8OOGv0sRmG48rlzQpd6P0VLwlV2OK7xFFAsR88gm4K7ygyefMneXJFq
	 8fcpYrRFS8ezaDIFq7xktF32/L4G4c5K5j7JE/S6sPfl8dtORa2VfTIr7+4CUpWxQ8
	 nmvN1kgDg53kTEZ1WUZPur4xEvNVcdaEn+0ocMcCbY4N9IuktC1gV8jqiIyNWxdJDd
	 kt0Grbb5zMCeA==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-54d048550dfso1341323a12.0
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 06:01:46 -0800 (PST)
X-Gm-Message-State: AOJu0YwNcfhok33Tt+KdWimQdzDTQAF8ytORcT/f2ApPVABOICeg5+TX
	s21T5BAPOZlxjn5UjfeLUMdDZqtXCUYMOOeOgs5uow==
X-Google-Smtp-Source: AGHT+IHXsr8cFuX1wbbSnTIa9j+VFSA9qydtwDsaGfzsyOoECoCG7hybz5j494zlyvwOZxOLmg+gCE+NPMkgL17iX3I=
X-Received: by 2002:a50:f69c:0:b0:54c:47cc:cae6 with SMTP id
 d28-20020a50f69c000000b0054c47cccae6mr1000659edn.44.1701957704591; Thu, 07
 Dec 2023 06:01:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZW+KYViDT3HWtKI1@CMGLRV3>
In-Reply-To: <ZW+KYViDT3HWtKI1@CMGLRV3>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 7 Dec 2023 15:01:33 +0100
X-Gmail-Original-Message-ID: <CACYkzJ5iyiUi_3r439ZMRnjM2f9Wd0XYoGJYQY=aXJ4QmX7e-A@mail.gmail.com>
Message-ID: <CACYkzJ5iyiUi_3r439ZMRnjM2f9Wd0XYoGJYQY=aXJ4QmX7e-A@mail.gmail.com>
Subject: Re: BPF LSM prevent program unload
To: Frederick Lawler <fred@cloudflare.com>
Cc: revest@chromium.org, jackmanb@chromium.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 9:39=E2=80=AFPM Frederick Lawler <fred@cloudflare.co=
m> wrote:
>
> Hi,
>
> IIUC, LSMs are supposed to give us the ability to design policy around
> unprivileged users and in addition to privileged users. As we expand
> our usage of BPF LSM's, there are cases where we want to restrict
> privileged users from unloading our progs. For instance, any privileged
> user that wants to remove restrictions we've placed on privileged users.
>
> We currently have a loader application doesn't leverage BPF skeletons. We
> instead load BPF object files, and then pin the progs to a mount point th=
at
> is a bpf filesystem. On next run, if we have new policies, load in new
> policies, and finally unload the old.
>
> Here are some conditions a privileged user may unload programs:
>
>         umount /sys/fs/bpf
>         rm -rf /sys/fs/bpf/lsm
>         rm /sys/fs/bpf/lsm/some_prog
>         unlink /sys/fs/bpf/lsm/some_prog
>
> This works because once we remove the last reference, the programs and
> pinned maps are cleaned up.
>
> Moving individual pins or moving the mount entirely with mount --move
> do not perform any clean up operations. Lastly, bpftool doesn't currently
> have the ability to unload LSM's AFAIK.
>
> The few ideas I have floating around are:
>
> 1. Leverage some LSM hooks (BPF or otherwise) to restrict on the function=
s
>    security_sb_umount(), security_path_unlink(), security_inode_unlink().
>
>    Both security_path_unlink() and security_inode_unlink() handle the
>    unlink/remove case, but not the umount case.

IMHO this is the best option. Here:

* BPF LSM Program =3D MAC Policy
* Removing / detaching / updating programs =3D Updating MAC policy

The decision around who can update MAC policy can be governed by the
policy itself a.k.a. implemented with BPF LSM programs.  So we can
update hooks (as suggested here inode_unlink, sb_unmount, path_unlink)
to only allow this action for a subset of users (e.g. CAP_MAC_ADMIN or
even further restricted)

While, I think this may be doable with existing LSM hooks but we need
to probably have to cover multiple hook points needed to prevent one
action which makes a good case for another LSM hook, perhaps something
in the link->ops->detach path like
https://elixir.bootlin.com/linux/latest/source/kernel/bpf/syscall.c#L5074

What do you think?

- KP

>
> 3. Leverage SELinux/Apparmor to possibly handle these cases.
>
> 4. Introduce a security_bpf_prog_unload() to target hopefully the
>    umount and unlink cases at the same time.



>
> 5. Possible moonshot idea: introduce a interface to pin _specifically_
>    BPF LSM's to the kernel, and avoid the bpf sysfs problems all
>    together.
>
> We're making the assumption this problem has been thought about before,
> and are wondering if there's anything obvious we're missing here.
>
> Fred
>

