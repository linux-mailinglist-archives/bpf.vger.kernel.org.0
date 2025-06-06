Return-Path: <bpf+bounces-59822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773B0ACFB30
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 04:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22FDF7A911C
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 02:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE053F9D2;
	Fri,  6 Jun 2025 02:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xin/XJhp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61DB5C96
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 02:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749176282; cv=none; b=l3f99fj8VDvDo6dT4+u4mhP8t9Waqb6nkv4Uc1vaxHl0bIb5gUwuadN8JU3IHig5ZgZY/26Swb1GfJTQSVwJ7wRWvjuCUgsUG6XMKVAgj+2CFID8dEjqQZKHTSiK53HxBuY1ei+Cv2b+ZVwMXfxsn32pkIyokB4+0fqnJq4h0QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749176282; c=relaxed/simple;
	bh=uvOhobty7kNB2sXa+NRz6orLutA7gq+4/Pm9CjdotaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEwEDbHqsp5axVoq3C2ssCFaImJ2IooNDc+9OjMQ9sd5GHAHZxtzB3QO8yz0Rd37KSYizFceBK4LsEYS4Pvua34JxbK3xyRi6GHSj/ukgT/H/R3qOrq3Ap/eaq4uu3jq/TqfVFZPpZReUltOibHgsi+FHEI3BakzyqG6ZE+GSVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xin/XJhp; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a528243636so977783f8f.3
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 19:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749176279; x=1749781079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3g0sqL8IG2IRshvufeKVQAfAmiWFqLWOe7WcG6UXXoY=;
        b=Xin/XJhp+DrwdoO/jP1VNg80GD3hzZFf+VnhoM2N7NxOOlyUOEBI7BnR+l46SFiswd
         dXRew07r0yD+katw5W+/clO+Lwpu+a85xgf1AQaynCoBAHeLvXYNU7goY+++SVAgESC8
         Pd47nXOCZZJd0gxXeDGnCSnBYeEEFKvGy1ZRzlHoNlWAaSawS5NxDBLSiX5BBG4dkKM7
         o7SE2xNubUZpOxORLZiN26eF3c2atcLE8KxIJNqYM4wZDLSQ6yBB/HtLVn8zfxHbMuBT
         xdjUGefvUE157iGpdXT6DPKEWDXA/VVPMhwpxfEAPRfv+QeKrfZtGuWRF6sHCG6s6g1Y
         I6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749176279; x=1749781079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3g0sqL8IG2IRshvufeKVQAfAmiWFqLWOe7WcG6UXXoY=;
        b=vD0LBTgNpm6YLw/GDZnWqzhpGtsGpmf/wglin6aRUoPezQifGWHNC5tta+KJ/4pYGm
         1SrtN5GDNvRzs6p98snSoJa0Zo1l/z6TTSiZaVggormGjILi6niJP1321dVNOZQxx9pv
         1Im8HkSkU+qRh0bQN7GKQS1sy910VFsskWKF+HIkYOH72rjMGWhf4kyo7tUr3kFs1HVp
         XBqdf5KaEMi4V8d/a8PYiodVSIEtLXvp/dvPd10KayTnU0yo5DyN4nR102mMNv56BnT3
         /DirXp4IKKLU608gvT3zwGPuLEY9LfVkthWybR+ZS5K/Pps5JBrfhuy8FMSKs2QUgEHj
         B5dg==
X-Gm-Message-State: AOJu0YyeLOxEatPlNZIc+INSMRKtWycbdLJ6eof9wYuNCu4/7hBzjKU/
	oriCWHkerjc9Qzadm81l4utZ/n1M9MSv2wFeBu7zd6R71nUeApQwtG7bvyHDBnwyp1UcFRE6GX0
	Wl+EAKZtIjwySEHKjzoZn4jFjixEL8lY=
X-Gm-Gg: ASbGncvUl8zeQ2s9BmaPmyUc3ggcBiPnmlCWrmSZMSphBp0lINwH16I3R3MgijVcCmV
	qyLdlHVPMtEF07uQxpal0xFpB6CqxScV1as0zMA7RTYDPlEH7wtPsN9BmCuMfJdVZcfBmCgTt8P
	aaMMyXOkBVtjzilKkMTs//IxQd14AXFPadfLRXxOUuZDaQrifJJWTuZMA9ri5na0QGj2dbqq1d
X-Google-Smtp-Source: AGHT+IFa/Zq4v9+2gWWEnW5m2/DVWjKOrZAnZGZXkQtjTNTsDIpGLSEyXtyPkfJVzR60U4D05zc8pqF9ScKFvD3e97o=
X-Received: by 2002:a05:6000:18a5:b0:3a4:f6f1:faef with SMTP id
 ffacd0b85a97d-3a53188e4acmr1236366f8f.32.1749176278704; Thu, 05 Jun 2025
 19:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605230609.1444980-1-eddyz87@gmail.com> <20250605230609.1444980-3-eddyz87@gmail.com>
 <8bf346133b103ee586f7ffd1a47572f9ee000704.camel@gmail.com>
In-Reply-To: <8bf346133b103ee586f7ffd1a47572f9ee000704.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Jun 2025 19:17:46 -0700
X-Gm-Features: AX0GCFveGPPwT6plWD6Thv0zfvDRIFDgdfg-jJ6IJ1-_fTaK54OkfHWz74mc3HY
Message-ID: <CAADnVQKsfQSM76q88o38GboUrSuts9xEYAMZ=36AUCcrwG34Jg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] veristat: memory accounting for bpf programs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 6:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Thu, 2025-06-05 at 16:06 -0700, Eduard Zingerman wrote:
>
> [...]
>
> > +/*
> > + * Enters new cgroup namespace and mounts cgroupfs at /tmp/veristat-cg=
roup-mount-XXXXXX,
> > + * enables "memory" controller for the root cgroup.
> > + */
> > +static int mount_cgroupfs(void)
> > +{
> > +     char buf[PATH_MAX + 1];
> > +     int err;
> > +
> > +     env.memory_peak_fd =3D -1;
> > +
> > +     err =3D unshare(CLONE_NEWCGROUP);
> > +     if (err < 0) {
> > +             err =3D log_errno("unshare(CLONE_NEWCGROUP)");
> > +             goto err_out;
> > +     }
>
> The `unshare` call is useless. I thought it would grant me a new
> hierarchy with separate cgroup.subtree_control in the root.
> But that's now how things work, hierarchy is shared across namespaces.
> I'll drop this call and just complain if "memory" controller is not enabl=
ed.
>
> The "mount" part can remain, I use it to avoid searching for cgroupfs
> mount point. Alternatively I can inspect /proc/self/mountinfo and
> complain if cgroupfs is not found. Please let me know which way is
> preferred.

I would keep unshare and mount,
and if possible share the code with setup_cgroup_environment()
from cgroup_helpers.c

