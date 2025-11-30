Return-Path: <bpf+bounces-75776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7610C94BA6
	for <lists+bpf@lfdr.de>; Sun, 30 Nov 2025 06:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20FF43456A4
	for <lists+bpf@lfdr.de>; Sun, 30 Nov 2025 05:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC6C221721;
	Sun, 30 Nov 2025 05:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkJVO5qe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE0E4A33
	for <bpf@vger.kernel.org>; Sun, 30 Nov 2025 05:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764482276; cv=none; b=u8DOalBov5JSE0aG4atAHP+AdvnRgBFY73uvRdgaRZ3xU+o4hVwegkXucarZHk13mT+Dz8zEtj2uITzVNn8yt5m6tUU/Jtt5zJ58ZHXzQKaBpBV8Xq7GY6OMQkFFnVWV43Hdv7RngUPRjfpfham2JPdZRzRNKMWewqp31k9Xr1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764482276; c=relaxed/simple;
	bh=y/V6YGTy0Xg26qGvu6WFCjDjbOX4pALl8+bPZqS7yYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkgiChsg2KT8ikX8gVo1rEL5GwwLXpkSDA2MuM/evq/2LSOSmSghMiehy817g4xD/fQpeEMX1gD4YKJChUkjhfL9r43Me7A7a2FrcQeACf6AhO6u8cIDmW6hezMOyMHMkxvILY1utQryYJOQwafAp4bNplvWpazRY7H0hcBoinI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkJVO5qe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86DAC113D0
	for <bpf@vger.kernel.org>; Sun, 30 Nov 2025 05:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764482275;
	bh=y/V6YGTy0Xg26qGvu6WFCjDjbOX4pALl8+bPZqS7yYs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NkJVO5qe3Jlu2qaz9D7ddtKnkv2RTIyq3Ut+jEXCkJUcq752zZ6mVaYmrPoZD7DVy
	 izM+ZZ4HXMoh9H9sIVCcORoosQxcqVhU24Z1sqUAdiDrVXetAvsVObKXvT4yk1tJI7
	 6Ut+BIIKjA6vlWUDUxmzj00MJv74Lf4InXUOKUiYmQ75ygkbpmE8FA/KGFyY4c1Upt
	 cIB0LbUzamzLO/RlL4VEX+cp1DytNX/yhRDIejLyq1v813+Wd5HPVxfF1/7ygLvK9a
	 3GMfLo1KMiv3c8yqdpy43fxcYHvButPLgGpBAhn4RdrOALUue091jduaMZsYPSJN/Y
	 05+NKGdv5YHrg==
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b28f983333so290715585a.3
        for <bpf@vger.kernel.org>; Sat, 29 Nov 2025 21:57:55 -0800 (PST)
X-Gm-Message-State: AOJu0YwIje7DPbKOsdFm+bRNgYacf6X4AKyCHA0RcdI5c1CmjjERkXOK
	NpTFsHoYHdlrj5uGifIyIWTW1tV+exiHUp6ztBJvt56N3WhoHXM/qdkrkdJxHrGFK4FOpwfHTBj
	aLIJLCorRv3l47QRZq+WkwQ9gsQOPI5A=
X-Google-Smtp-Source: AGHT+IFX9ti/YGM2wNkpqH1mHFpdR7rJ6F1OFilKov+vd9c6JxxpqKeJGuLSikskghjjNFFxB+A7AedDgirfMxKcRGY=
X-Received: by 2002:a05:620a:404f:b0:8b2:6eba:c43f with SMTP id
 af79cd13be357-8b4ebdad55emr2897925185a.70.1764482274849; Sat, 29 Nov 2025
 21:57:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127005011.1872209-1-song@kernel.org> <20251127005011.1872209-3-song@kernel.org>
 <20251130042357.GP3538@ZenIV>
In-Reply-To: <20251130042357.GP3538@ZenIV>
From: Song Liu <song@kernel.org>
Date: Sat, 29 Nov 2025 21:57:43 -0800
X-Gmail-Original-Message-ID: <CAPhsuW69nUeMf+89vwsBrwo4sv3P8xOypSfhafEu12HJKqAb+w@mail.gmail.com>
X-Gm-Features: AWmQ_bmorwSd_NK34tMunlhrcdnxJkMisQtvI_WBgJhAqliKdNyFHEuNMdtzn0M
Message-ID: <CAPhsuW69nUeMf+89vwsBrwo4sv3P8xOypSfhafEu12HJKqAb+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add bpf_kern_path and bpf_path_put kfuncs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, kernel-team@meta.com, brauner@kernel.org, jack@suse.cz, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	Shervin Oloumi <enlightened@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 8:23=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Wed, Nov 26, 2025 at 04:50:06PM -0800, Song Liu wrote:
> > Add two new kfuncs to fs/bpf_fs_kfuncs.c that wrap kern_path() for use
> > by BPF LSM programs:
> >
> > bpf_kern_path():
> > - Resolves a pathname string to a struct path
>
> > These kfuncs enable BPF LSM programs to resolve pathnames provided by
> > hook arguments (e.g., dev_name from sb_mount) and validate or inspect
> > the resolved paths. The verifier enforces proper resource management
> > through acquire/release tracking.
>
> Oh, *brilliant*.  Thank you for giving a wonderful example of the reasons
> why this is fundamentally worthless.
>
> OK, your "BPF LSM" has been called and it got that dev_name.  You decide
> that you want to know what it resolves to (which, BTW, requries a really
> non-trivial amount of parsing other arguments - just to figure out whethe=
r
> it *is* a pathname of some sort).  Thanks to your shiny new kfuncs you
> can do that!  You are a proud holder of mount/dentry pair.  You stare at
> those and decide whether it's OK to go on.  Then you... drop that pair
> and let mount(2) proceed towards the point where it will (if you parsed
> the arguments correctly) repeat that pathname resolution and get a mount/=
dentry
> pair of its own, that may very well be different from what you've got the
> first time around.
>
> Your primitive is a walking TOCTOU bug - it's impossible to use safely.

Good point. AFAICT, the sample TOCTOU bug applies to other LSMs that
care about dev_name in sb_mount, namely, aa_bind_mount() for apparmor
and tomoyo_mount_acl() for tomoyo.

What would you recommend to do this properly? How about we add a new
LSM hook that works on the actual mount/dentry pair? Something like:

diff --git i/fs/namespace.c w/fs/namespace.c
index d82910f33dc4..3d5dc167f15f 100644
--- i/fs/namespace.c
+++ w/fs/namespace.c
@@ -2984,6 +2984,10 @@ static int do_loopback(const struct path *path,
const char *old_name,
        if (err)
                return err;

+       err =3D security_mount_loopback(old_path, path, recurse);
+       if (err)
+               return err;
+
        if (mnt_ns_loop(old_path.dentry))
                return -EINVAL;

(Or s/security_mount_loopback/some_other_name).

In other words, do you think we should go [1] by Shervin Oloumi?
CCing Shervin here.

We will also need something similar to cover move mount operation
via path_mount()=3D>do_move_mount_old()=3D>do_move_mount().

Thanks,
Song

[1] https://lore.kernel.org/linux-security-module/20250110021008.2704246-1-=
enlightened@chromium.org/

