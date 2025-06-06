Return-Path: <bpf+bounces-59913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 118F7AD07F4
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 20:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40AD9188E019
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 18:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C061E834F;
	Fri,  6 Jun 2025 18:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1jqLNHz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BFA42AB0
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 18:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749233976; cv=none; b=nn9wO0gEjovGPvXDPYztG4sCdfmzM0nBPQomtOAa5rNjQOGwGds3WHSXEamEZAhbBMMbnWfeoUH04mQtj79+PAq8SR3mL0OO2kmAoJQogEnbxEwTXkSheHaBPhW0L//XMebVoahU+EDQpVlUPk5oFRylEX2CnHsDxj550LrixD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749233976; c=relaxed/simple;
	bh=fvcIe9FyjpxA73KLYYA0alKcg+V3mhcmigMYwqvTizI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjQibjF+4z3aLAXsNNZxLy/sGb3kt7VZPxN4g/Gz0j7mLCmGUva77rQTJHQIhVFAnyfGZT1NM4S78IFhBxbHYPUQ+TA0UKlRuH58LE9HvsEzRgZp059mU1AogKebiQ9U62S1C2DTyplo+emCDp4/rI6YbMr+WhCJD4uRfgE1HQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1jqLNHz; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-742c46611b6so3108955b3a.1
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 11:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749233974; x=1749838774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldLgSmg7TknrVAAxhCw8o2a0F+gv5t5ihqjim9Ita3M=;
        b=m1jqLNHzJ0+znhDTerr7mgX0yMxrlS5+1yMcCXX7Vqvw840+615w9XE9pFLc1spOHD
         aWtidebRSin2Ga1+BCSR4eUr1RJGT7HEv5ptqnXrBR5aGMPGMviu/9nkvtqlqgISYfRf
         bCuOgr19JXRNEX5nMw42BjtmQqTjABT3Yw22Y2YdTSOvOsnujOfMPh3R7tU5Kgmfg89r
         tJFSl+u58iJD2ZczolzDf+76EJX7ms/EPls7LKKrYqsYIL24cOBM1q8sW2ora8m+eJj8
         hmnxZtO1rL9HxHpmWvVXpuwl1JPCuA91jOLOvWbqUbtn3tJbFOMc0rpWH4DYibthUPTb
         wJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749233974; x=1749838774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldLgSmg7TknrVAAxhCw8o2a0F+gv5t5ihqjim9Ita3M=;
        b=MbcpdCL2+BQkN16+9+UE8z1xsBvqd3DTC1eki8P8Hn8cCmp3oYaVGBNWFQ1ujanIAW
         IjUemPDCaVv2k/ZpBavPcQDYaVcUfIF5NjiwScoQN4OEIbTSud8r6EE1KkrTFOuECkoj
         fjOv8Nv2jmkbd+sCiJb4l8o5AGifdzHnKUl3MMBna/JmzNadNidB2Tjy2cBSEAjW4shE
         wgV7DD/CjA4sEh7l4dVijX8sFh7VFJdTXv+tGPqfGArgiycyT7YuGvxkkCHPaepXv3Lj
         lFSb4hy/z0sDbpp6qVK12tZr7Zsql1Nr8gobLEGw1qhQTkcdPqAo3RtdAike7RYMq9sO
         01ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVyTlGkyfjopadbSyacFUZ1L1jFZ6DK4kV96hT5bRIvB6WH0SVEFjingcRbGNy6lIBqlFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcEMEo+DIwgxHr9xVlbBJrKQJx2fwYmbIzOrRx6dFdMkmjmCuH
	hJa3M9NlG9nntXv5xsz3SpsAgRVkdiNeVTmp2r2tT306oj9Jsd4fWTivEHx1IWzdyJ3axOPTS8A
	5oZ+6+9ZqNI96WiF4HZyZlQ+bg1G17WqHy70e
X-Gm-Gg: ASbGncvVOUwTAE9SA6PpfgQs5Y2Vf7b09bU1E2tP29IEQmCFNhgKkApu4utqs5N2Uno
	IiPjmCFczfqVe1DjjO/C699H1p/tjEnTMV8aggn7iRbhHW2lLJ/4udzux+i3FU89bN9EuJAl/b/
	maZnktF7yIr5uAd7w7oj2VzzcNNeitx1qDNA/M/4l3mQ==
X-Google-Smtp-Source: AGHT+IE18JOG2gIJ4VvduVbUavrAvxsCwH/WNOVhhosgoegPuVjkz1EAyPFeHXmN1kd1KWRLim0011fCP2eab+rRf7M=
X-Received: by 2002:a05:6a00:cc2:b0:747:bd28:1ca1 with SMTP id
 d2e1a72fcca58-74827e52521mr7085114b3a.3.1749233973815; Fri, 06 Jun 2025
 11:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605230609.1444980-1-eddyz87@gmail.com> <20250605230609.1444980-3-eddyz87@gmail.com>
 <3dd16f19-63a4-4090-abd0-9b84fb07346b@gmail.com> <efe0cc259f70b11ffd3e398441efd0de5aa98c3e.camel@gmail.com>
In-Reply-To: <efe0cc259f70b11ffd3e398441efd0de5aa98c3e.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Jun 2025 11:19:21 -0700
X-Gm-Features: AX0GCFtpmVXfwsVZrzLmsx31ssZ6dMoFTo7WQfI0nmJEAkI7_kXsGU5a7jvGRkM
Message-ID: <CAEf4BzY2CzZy8DMe==F7OmvEO2gkGG___SaZgu8dGDJd4LG4_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] veristat: memory accounting for bpf programs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 10:03=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2025-06-06 at 17:53 +0100, Mykyta Yatsenko wrote:
>
> [...]
>
> > > +/*
> > > + * Creates a cgroup at /tmp/veristat-cgroup-mount-XXXXXX/accounting-=
<pid>,
> > > + * moves current process to this cgroup.
> > > + */
> > > +static int create_stat_cgroup(void)
> > > +{
> > > +   char buf[PATH_MAX + 1];
> > > +   int err;
> > > +
> > > +   if (!env.cgroup_fs_mount[0])
> > > +           return -1;
> > > +
> > > +   env.memory_peak_fd =3D -1;
> > > +
> > > +   snprintf_trunc(buf, sizeof(buf), "%s/accounting-%d", env.cgroup_f=
s_mount, getpid());
> > > +   err =3D mkdir(buf, 0777);
> > > +   if (err < 0) {
> > > +           err =3D log_errno("mkdir(%s)", buf);
> > > +           goto err_out;
> > > +   }
> > > +   strcpy(env.stat_cgroup, buf);
> > > +
> > > +   snprintf_trunc(buf, sizeof(buf), "%s/cgroup.procs", env.stat_cgro=
up);
> > > +   err =3D write_one_line(buf, "%d\n", getpid());
> > > +   if (err < 0) {
> > > +           err =3D log_errno("echo %d > %s", getpid(), buf);
> > > +           goto err_out;
> > > +   }
> > > +
> > > +   snprintf_trunc(buf, sizeof(buf), "%s/memory.peak", env.stat_cgrou=
p);
> > > +   env.memory_peak_fd =3D open(buf, O_RDWR | O_APPEND);
> >
> > Why is it necessary to open in RW|APPEND mode? Won't O_RDONLY cut it?
>
> With current implementation -- not necessary, O_RDONLY should be sufficie=
nt.
>
> > > +   if (env.memory_peak_fd < 0) {
> > > +           err =3D log_errno("open(%s)", buf);
> > > +           goto err_out;
> > > +   }
> > > +
> > > +   return 0;
> > > +
> > > +err_out:
> > > +   destroy_stat_cgroup();
> > > +   return err;
> > > +}
>
> [...]
>
> > > +/* Current value of /tmp/veristat-cgroup-mount-XXXXXX/accounting-<pi=
d>/memory.peak */
> > > +static long cgroup_memory_peak(void)
> > > +{
> > > +   long err, memory_peak;
> > > +   char buf[32];
> > > +
> > > +   if (env.memory_peak_fd < 0)
> > > +           return -1;
> > > +
> > > +   err =3D pread(env.memory_peak_fd, buf, sizeof(buf) - 1, 0);
> > > +   if (err <=3D 0) {
> > > +           log_errno("read(%s/memory.peak)", env.stat_cgroup);
> > > +           return -1;
> > > +   }
> > > +
> > > +   buf[err] =3D 0;
> >
> > nit: maybe rename err to len here?
>
> Sure, will rename.
>
> > > +   errno =3D 0;
> > > +   memory_peak =3D strtoll(buf, NULL, 10);
> > > +   if (errno) {
> > > +           log_errno("unrecognized %s/memory.peak format: %s", env.s=
tat_cgroup, buf);
> > > +           return -1;
> > > +   }
> > > +
> > > +   return memory_peak;
> > > +}
> > > +
>
> [...]
>
> > > @@ -1332,7 +1551,16 @@ static int process_prog(const char *filename, =
struct bpf_object *obj, struct bpf
> > >     if (env.force_reg_invariants)
> > >             bpf_program__set_flags(prog, bpf_program__flags(prog) | B=
PF_F_TEST_REG_INVARIANTS);
> > >
> > > -   err =3D bpf_object__load(obj);
> > > +   err =3D bpf_object__prepare(obj);
> > > +   if (!err) {
> > > +           cgroup_err =3D create_stat_cgroup();
> > > +           mem_peak_a =3D cgroup_memory_peak();
> > > +           err =3D bpf_object__load(obj);
> > > +           mem_peak_b =3D cgroup_memory_peak();
> > > +           destroy_stat_cgroup();
> >
> > What if we do create_stat_cgroup/destory_stat_cgroup in
> > handle_verif_mode along with mount/umount_cgroupfs.
> > It may speed things up a little bit here and moving all cgroup
> > preparations into the single place seems reasonable.
> > Will memory counter behave differently? We are checking the difference
> > around bpf_object__load, from layman's
> > perspective it should be the same.
>
> The memory.peak file accounts for peak memory consumption, so one
> would need to reset this counter between program verifications.
> Doc [1] describes such mechanism:
>
>     memory.peak
>
>       A read-write single value file which exists on non-root cgroups.
>
>       The max memory usage recorded for the cgroup and its descendants
>       since either the creation of the cgroup or the most recent reset
>       for that FD.
>
>       A write of any non-empty string to this file resets it to the
>       current memory usage for subsequent reads through the same file
>       descriptor.
>
>     memory.reclaim
>
>       A write-only nested-keyed file which exists for all cgroups.
>
>       This is a simple interface to trigger memory reclaim in the target
>       cgroup.
>
>       Example:
>
>         echo "1G" > memory.reclaim
>
>       Please note that the kernel can over or under reclaim from the
>       target cgroup. If less bytes are reclaimed than the specified
>       amount, -EAGAIN is returned.
>
> As mentioned in cover letter, I tried using a combination of the above,
> while creating a cgroup only once. For reasons I don't understand this
> did not produce stable measurements. E.g. depending on a program being

Looking at memory_peak_write() in mm/memcontrol.c it looks reasonable
and should have worked (we do reset pc->local_watermark). But note if
(usage > peer_ctx->value) logic and /* initial write, register watcher
*/ comment. I'm totally guessing and speculating, but maybe you didn't
close and re-open the file in between and so you had stale "watcher"
with already recorded high watermark?..

I'd try again but be very careful what cgroup and at what point this
is being reset...

> verified in isolation or as part of a batch results vary from 5mb to 2mb.
>
> [1] https://docs.kernel.org/admin-guide/cgroup-v2.html
>
> > > +           if (!cgroup_err && mem_peak_a >=3D 0 && mem_peak_b >=3D 0=
)
> > > +                   mem_peak =3D mem_peak_b - mem_peak_a;
> > > +   }
> > >     env.progs_processed++;
> > >
> > >     stats->file_name =3D strdup(base_filename);
> > > @@ -1341,6 +1569,7 @@ static int process_prog(const char *filename, s=
truct bpf_object *obj, struct bpf
>
> [...]
>
> > Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
>
> Thank you. I will have to send a v2 avoiding mount operations and
> controllers file modification.
>

