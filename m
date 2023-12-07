Return-Path: <bpf+bounces-17008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7D5808A6A
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 15:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1E01F21364
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 14:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5568441C99;
	Thu,  7 Dec 2023 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f74yDgsX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6812126
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 06:24:09 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b842c1511fso646645b6e.1
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 06:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701959048; x=1702563848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9TuAMdfm0hoAxPKfLlxKhbJoucMUQeoAAOfeLtobyM=;
        b=f74yDgsXdhAz8Pr1z3yr9Tmf21LGPL+dOh4ZRheexWEdpZDeUywsYySQKUh2Cx9yq5
         goBJR3pjoC+F2RzF7ejJsUu4DwiwTcjQ7niUxDvcgrOwiy7Q9UyorR2tRb+Aqg8LU94w
         8GxlTPZRfoTGUFrccwC55IsugilFRy6+utEQSBmoug8dgs24v27twVtTJy2AMHQ3Eg/d
         TKFkgFl6rKKwpAC9mixkdaHdJWg2BwCCbHQ4mSRuOb//lrtltYVFutAI6AjDVwEzOPmR
         C6iAGbNLb4CLMaS6ELuBdH7NmKV4BG64x1mUzvMJ0GdxggvBQE8uko0q9LRc4HrdAMpu
         rpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701959048; x=1702563848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9TuAMdfm0hoAxPKfLlxKhbJoucMUQeoAAOfeLtobyM=;
        b=deEfX94+VFoa+4dyjpYF9APDD3qyim/5Nd2GFCyWnf5U7ZIqa6MDFkfLeUpefSXGAb
         EkqJXbPjTJAIp/3F0PTFlPiKibX6Rjyv112MiPtptYGeadS8ZRbnHFThUD3b5l8ALbR3
         0TexasbusGoBl+o2R4bzUDc6s1vUGNZQklukEQnXKhqOYlmKTFxBtF5XqMhjEm70w29/
         R+XO3jDlWgC7azFBpnoL0ugJvu2imW3WLH+Sl29ShEP1mLtHJPvvsU3gQ5pUf0J3KHvj
         Uazc9hWoa+hJsRib0MUTFksRfQbd8aH3dOavFmxwlk1Usfv69wj6V0GdaCn8pOk4BN+O
         WCWg==
X-Gm-Message-State: AOJu0YzeMsP5PFUIGvdGMI/X+wF1ErlTC2fRNMO3ELyXfmBxjGTQ4w/+
	vy5tYZH1olF7fxpnOU3XWNOBicxpWZXOWpqVOA8=
X-Google-Smtp-Source: AGHT+IEQAWJqDas2BUD7+PrAhsInu/GCc5oX9XPqqU4T7GbrgWqQCgJI6xRTCvcoQpcQLLf1HL51fmGm8bRGCemQ/1U=
X-Received: by 2002:a05:6358:9217:b0:16b:c403:1689 with SMTP id
 d23-20020a056358921700b0016bc4031689mr4070850rwb.9.1701959048276; Thu, 07 Dec
 2023 06:24:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZW+KYViDT3HWtKI1@CMGLRV3> <CACYkzJ5iyiUi_3r439ZMRnjM2f9Wd0XYoGJYQY=aXJ4QmX7e-A@mail.gmail.com>
In-Reply-To: <CACYkzJ5iyiUi_3r439ZMRnjM2f9Wd0XYoGJYQY=aXJ4QmX7e-A@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 7 Dec 2023 22:23:31 +0800
Message-ID: <CALOAHbDjdNhtkTdimkQaqrPOX2gOxao9Z_udjyPsfhPfu=+vKA@mail.gmail.com>
Subject: Re: BPF LSM prevent program unload
To: KP Singh <kpsingh@kernel.org>
Cc: Frederick Lawler <fred@cloudflare.com>, revest@chromium.org, jackmanb@chromium.org, 
	bpf@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 10:01=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> On Tue, Dec 5, 2023 at 9:39=E2=80=AFPM Frederick Lawler <fred@cloudflare.=
com> wrote:
> >
> > Hi,
> >
> > IIUC, LSMs are supposed to give us the ability to design policy around
> > unprivileged users and in addition to privileged users. As we expand
> > our usage of BPF LSM's, there are cases where we want to restrict
> > privileged users from unloading our progs. For instance, any privileged
> > user that wants to remove restrictions we've placed on privileged users=
.
> >
> > We currently have a loader application doesn't leverage BPF skeletons. =
We
> > instead load BPF object files, and then pin the progs to a mount point =
that
> > is a bpf filesystem. On next run, if we have new policies, load in new
> > policies, and finally unload the old.
> >
> > Here are some conditions a privileged user may unload programs:
> >
> >         umount /sys/fs/bpf
> >         rm -rf /sys/fs/bpf/lsm
> >         rm /sys/fs/bpf/lsm/some_prog
> >         unlink /sys/fs/bpf/lsm/some_prog
> >
> > This works because once we remove the last reference, the programs and
> > pinned maps are cleaned up.
> >
> > Moving individual pins or moving the mount entirely with mount --move
> > do not perform any clean up operations. Lastly, bpftool doesn't current=
ly
> > have the ability to unload LSM's AFAIK.
> >
> > The few ideas I have floating around are:
> >
> > 1. Leverage some LSM hooks (BPF or otherwise) to restrict on the functi=
ons
> >    security_sb_umount(), security_path_unlink(), security_inode_unlink(=
).
> >
> >    Both security_path_unlink() and security_inode_unlink() handle the
> >    unlink/remove case, but not the umount case.
>
> IMHO this is the best option. Here:
>
> * BPF LSM Program =3D MAC Policy
> * Removing / detaching / updating programs =3D Updating MAC policy

What happens if a privileged user terminates the BPF LSM task and
deletes any pinned BPF files that might exist?
We can apply specific capabilities to restrict access, but it's
important to note that privileged users might also possess these
capabilities.

>
> The decision around who can update MAC policy can be governed by the
> policy itself a.k.a. implemented with BPF LSM programs.  So we can
> update hooks (as suggested here inode_unlink, sb_unmount, path_unlink)
> to only allow this action for a subset of users (e.g. CAP_MAC_ADMIN or
> even further restricted)
>
> While, I think this may be doable with existing LSM hooks but we need
> to probably have to cover multiple hook points needed to prevent one
> action which makes a good case for another LSM hook, perhaps something
> in the link->ops->detach path like
> https://elixir.bootlin.com/linux/latest/source/kernel/bpf/syscall.c#L5074
>
> What do you think?
>
> - KP
>
> >
> > 3. Leverage SELinux/Apparmor to possibly handle these cases.
> >
> > 4. Introduce a security_bpf_prog_unload() to target hopefully the
> >    umount and unlink cases at the same time.
>
>
>
> >
> > 5. Possible moonshot idea: introduce a interface to pin _specifically_
> >    BPF LSM's to the kernel, and avoid the bpf sysfs problems all
> >    together.
> >
> > We're making the assumption this problem has been thought about before,
> > and are wondering if there's anything obvious we're missing here.
> >
> > Fred
> >
>


--=20
Regards
Yafang

