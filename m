Return-Path: <bpf+bounces-59825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D971ACFB4C
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 04:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856BB1898552
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 02:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A682561FFE;
	Fri,  6 Jun 2025 02:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mh6AhvmK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819DB7FD
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 02:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749177350; cv=none; b=cG0uDbv4vonJ2RaeXzFWcYD59RORPE4tyb6MJNZiy8qd++qScvCkaf617GGBZBdw3WGuKXBtLZz+kH+t96gnQ2GfP6XtQEXilMZ8d8RByLMEbo31z6M15Nn1Z+V+oNHWoW9uqNcVBCjMgkhQoU55FXks88w+1EXSAz2QLC3hNfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749177350; c=relaxed/simple;
	bh=a1lNsNCMHoDsolcZgbxfvOvyL+THsd0lBG5KMTnNJnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0ssY5jNH67I1E1tHLQ+NhJ17NsdkoOWKQ6O3oHUw8vkohZLSnAJEZrmeV8JVggRF7UxLgXl3DXIIGuf4ZZHfggI8X2ANsvjNmjpI8m1ZHPVGKpwO+ZQrGrSbjik+Omef2WgD0GPcsp4rvMh5enda4zEMLCc/0swLrUWgmVBudM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mh6AhvmK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a366843fa6so862725f8f.1
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 19:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749177347; x=1749782147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPMR4VbqJGK+mXotOl/ercaDfjEAjgpZz1uSvzMbOow=;
        b=mh6AhvmKq6EPjBYNgrlVrpCWDQqqkj7hdPu7TNv5x75iD04GBip4QS85GXCoyKVHBj
         MrvHJrpuI56No4tAAz5m9/mxpKlPnuV8gP4H5UsJvO9Jo4vQPSyUhWe7G2MxLOUno6Ul
         F4gN7Cjswb87881Zw9b9yUoWjVxdIisYuDAQWv8nHz5BdUhviDsUIEWjL7dnGCnGk5vq
         p4bCHsdNZkaQ3zIQuF+JQM6VxXwhjA6SEgd6lsOK0nhTkwo9MYY5HYxthsybuLnABqHy
         NoCshgLGjxmTEM7qqnZOsTqypIEwQyzgUy1vfkU9/HqLHs8K4xUI1thifGqsVmHKWw+e
         oP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749177347; x=1749782147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPMR4VbqJGK+mXotOl/ercaDfjEAjgpZz1uSvzMbOow=;
        b=DGZvH7p9h/SFmODu9camlrVqmjM6T2/mgodvoVfsm4utQzXD+/H1tsm0nYPWUGxADY
         /Z3Jlsw01f9yU6qHAFEBV95+9SpYdXyrEe9cKkayW7KhC+rcYMSQx4d+NG7SYHqFnJf2
         fdR4XBFq2Zy9yX5qy1fSyzrwNt0Ocxtz05oWhK76jFq5llyHODDjCfghepwENspHe4Eb
         Aq36pMSfPvcLJMyOfpZK/HD8tNSabXJbVZOa8A+SW/LeofaAvxaQhAqLFnVPbzrj17k7
         v/L8JZFwXtvf4TeKymmbd6+1li7vLdfedZltd4aKJSNtzDn8ekHjelUznP8T5Ckstdk9
         ExDA==
X-Gm-Message-State: AOJu0YwQVIuJUOuHTpQzcXUNXyvCKhye9HbIgRO2hZnClJXiPwTV75Rc
	A1hFL/NGZa27ZjTPJeTpu0SCJVMJVf/QwBLqRlrWw+4Kne4wmCdFroC8sVbqlS113zdRgybSP3O
	oedqiybvke382VSxW837XaYt4A7gdyqs=
X-Gm-Gg: ASbGncuu5KcanAPvELbSOMgMJlvhnswH0PPIopR2iTJsYFiyz4PyHxvXUxY/vHeCFjW
	NlPrmXRATaiAId1+lteHq7/Yk0msEseJ+tQrN6bT4VCWqLttLjM0JtDCi7VbHXsmOdi/Yk84U1l
	N6Br5tjMMX11MGgQ0hLPqwc8MJqmOksSN1Isl8jhsjGXcArHg2O0ApilvovdLobg==
X-Google-Smtp-Source: AGHT+IEBXegsNoYhc2Be0o8GAdHnqp61kUe0dSmM/OHpWTRSzW2EhqdoNfo7uHsV9jd3RajLbnEKnhNf6J+wCHSIILA=
X-Received: by 2002:a05:6000:220d:b0:3a4:f744:e013 with SMTP id
 ffacd0b85a97d-3a531cb8521mr1063191f8f.30.1749177346628; Thu, 05 Jun 2025
 19:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605230609.1444980-1-eddyz87@gmail.com> <20250605230609.1444980-3-eddyz87@gmail.com>
 <8bf346133b103ee586f7ffd1a47572f9ee000704.camel@gmail.com>
 <CAADnVQKsfQSM76q88o38GboUrSuts9xEYAMZ=36AUCcrwG34Jg@mail.gmail.com> <d4bc026d37fc75f986abe276f2650feff0d4ad70.camel@gmail.com>
In-Reply-To: <d4bc026d37fc75f986abe276f2650feff0d4ad70.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Jun 2025 19:35:35 -0700
X-Gm-Features: AX0GCFtjZvZ-v0cxCatcqZcyMBFsoX5I4YqW3O7tKvJPjAYlMfDgzTq-wIU1brU
Message-ID: <CAADnVQ+N2A9+vuR5kc1m6h8-q7Kx4Y4dvhS6fn2tfLSKEWWOVg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] veristat: memory accounting for bpf programs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 7:33=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Thu, 2025-06-05 at 19:17 -0700, Alexei Starovoitov wrote:
> > On Thu, Jun 5, 2025 at 6:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > On Thu, 2025-06-05 at 16:06 -0700, Eduard Zingerman wrote:
> > >
> > > [...]
> > >
> > > > +/*
> > > > + * Enters new cgroup namespace and mounts cgroupfs at /tmp/verista=
t-cgroup-mount-XXXXXX,
> > > > + * enables "memory" controller for the root cgroup.
> > > > + */
> > > > +static int mount_cgroupfs(void)
> > > > +{
> > > > +     char buf[PATH_MAX + 1];
> > > > +     int err;
> > > > +
> > > > +     env.memory_peak_fd =3D -1;
> > > > +
> > > > +     err =3D unshare(CLONE_NEWCGROUP);
> > > > +     if (err < 0) {
> > > > +             err =3D log_errno("unshare(CLONE_NEWCGROUP)");
> > > > +             goto err_out;
> > > > +     }
> > >
> > > The `unshare` call is useless. I thought it would grant me a new
> > > hierarchy with separate cgroup.subtree_control in the root.
> > > But that's now how things work, hierarchy is shared across namespaces=
.
> > > I'll drop this call and just complain if "memory" controller is not e=
nabled.
> > >
> > > The "mount" part can remain, I use it to avoid searching for cgroupfs
> > > mount point. Alternatively I can inspect /proc/self/mountinfo and
> > > complain if cgroupfs is not found. Please let me know which way is
> > > preferred.
> >
> > I would keep unshare and mount,
>
> But what would be the purpose of the unshare?
> I thought that it provides a new isolated new independent
> cgroup.subtree_control, but that is not the case.
> Outside from that the feature gains nothing from entering new namespace.
>
> > and if possible share the code with setup_cgroup_environment()
> > from cgroup_helpers.c
>
> setup_cgroup_environment() does the following:
>  a. creates a directory for cgroupfs mount
>  b. creates a new mount namespace
>  c. mounts a new empty root
>  d. mounts cgroupfs inside new root
>  e. creates a cgroup
>  f. enables controllers
>
> Of these only (a) and (d) are needed for veristat (and (f) is deligated t=
o init).
> Also my current version does unshare for cgroup namespace, while
> setup_cgroup_environment() does not do that.
>
> Things that might be reusable:
> - get_root_cgroup
> - remove_cgroup
> - join_root_cgroup
> - join_cgroup
>
> These rely on CGROUP_MOUNT_PATH and CGROUP_WORK_DIR being constants,
> I'll need to modify these helpers to parameterize this.

ok. ignore that suggestion then.
do what is simplest.

