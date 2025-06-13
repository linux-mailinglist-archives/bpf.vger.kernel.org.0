Return-Path: <bpf+bounces-60558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05013AD7FA6
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 02:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678243B496E
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 00:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227331A76AE;
	Fri, 13 Jun 2025 00:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjJzqbqP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4051419DF60
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 00:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749774692; cv=none; b=PwDMdfwVhhMHR2M5Wa7zKg10r8DA+lwIFsfybuDlawn4T2W0ssppsC60lbxEf9X/mO947DNkHCf9eZFKEHy0TRmsTYkR44HXiYeOEts5sEr2nphQ1LwjtyCp1CWNxviPWQza8pD0SUv+A2TWNGAtIX9cjEoFmgPFAMeiKuiBW/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749774692; c=relaxed/simple;
	bh=ySBCRAvDcI4dAIi2IBS1PJLr0y69G4hCyDnWPQfLVHA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HyhzoofIQcEKhPFh5+bizv79zlV0qgHpqpBuWLG4DpbtXWX4kRVJzW5qW0gjzxLPJmLTT/H460uZEDyIkkF3zjeM1TbYp/TXHPc3Jg650x6fmHe9NlkBmunw+yvMkWqDvmqUc9ABkkkARQoUKG6SwyFiZKmfqvXydHqeWo7Q3lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjJzqbqP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-236470b2dceso15161235ad.0
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 17:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749774690; x=1750379490; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dZsojV1popn1Sw35hqoNeLysnk1NgNBziKN6UhicCsQ=;
        b=GjJzqbqP6wmo+EHoyIEjPELCMHaxxlStQ1uZC5nZRzo2hr953cXoNu7oQ66MZvSW/U
         pQsOM9c/mjPZ73+QT0/duMbEa5pshKRaPO/8rqudt6mEjUVfnNuYcepFAnud/roVCtXk
         jFVZQMxfR3+rOIfbxebBG0pVjEbTLsJqnzhGbg+dTW578S/duvSe+CPF+Bhz2VHIWn2Y
         /ftz3DihZkRwEZ44sJfGHGkXWKn87xlpj62bbDjNI/1BU0JPUe4Qm9ya8Emhh5PLBZBO
         uts7uieGebNzNOCOh11WzVvQzZQYpJHd6V2VTYd2/lJlBF79LlzECJURBVFQDV5nlV8+
         0EOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749774690; x=1750379490;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dZsojV1popn1Sw35hqoNeLysnk1NgNBziKN6UhicCsQ=;
        b=HvW9TusiKNts7lin2+0bbldopEAUDsGrs1J122v17XyxBsxxi+kAxdSBb9/NGji+/Z
         Sbp3CrTIISWOJeZN1um/EtdTxevvO0s9w2dKN+bjLGe2E842gpCQu2/dO1jvweP3+tLq
         C5BfCOwbBDKttXbTrJg+EkXyroVZd7go3t3n/GT5SIZi0ZUGd95DoGanhZvL6CTdWaIY
         Iylwi27MbOau41FAde9+rezv+3XXdj4arDTU8pPhrsM5iFWblOwiS5uLl+0m+rPTpsfW
         h4AW64uwjGt2zJD0vW2yve4WTcXqJJRa87svXvavwYBVVOINLPaXAks35ozEQCWTjRiT
         w9EA==
X-Gm-Message-State: AOJu0Yzw858j5Fp7AXSe7eFpvnzOo6VyJpbp0lh791LapkAjQeg6/Eby
	efLuUQKOQTWVtz7XYhSWnEC4aW6GP1kgJjPNRltz4lyVSdN+qcBEYTMZ
X-Gm-Gg: ASbGncumm1BwVgSgr78m3wRJGSehtu7heYYbWJlJAzV5ppCfe2kLk10U5QF7PZjdVxB
	I8Z9SgiDtcDQWJt3B4VgeY9F32y+x9bQ+aVcGmSKBSBEDGl5+tHDr8hs4qYAgdBzcbPxjhq4Axs
	qWxzdhOvfZBAUlqwh5B3F3S6H386ijf1kHiMMzESDj7qp2o7HG48xnXv4z84vaGEmrnS/tq9+mA
	mh6tLgx2QrGNb3zH6FTBj2fNU0Mb6/oJo31cXkX7LXYhS/ZRM5BG+Jk4X0+aCsSDemtGygvv97C
	BRh02W6nNEca9aMOKiJGrJC0ctoTV5eqiu7Cx/nmhsd0Lv9I/tUrzAHCBaM=
X-Google-Smtp-Source: AGHT+IFRfmAR/6gzgY58OsBYA0kDEQMKgNs5d0qe9g1glXrqpP4cuB1Wj7JtX5TcrqxiBy8UfOkUiw==
X-Received: by 2002:a17:903:11c9:b0:235:be0:db4c with SMTP id d9443c01a7336-2365dc13c5fmr14615525ad.41.1749774690487;
        Thu, 12 Jun 2025 17:31:30 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a183asm3347265ad.53.2025.06.12.17.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 17:31:30 -0700 (PDT)
Message-ID: <bb0a4b1d12c8d3e7a5aba2cfce1f07143a7e2b71.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] veristat: memory accounting for bpf
 programs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
Date: Thu, 12 Jun 2025 17:31:28 -0700
In-Reply-To: <CAEf4BzbTxyGXi=ZNU_yebe2a=zgNoeafRTK9pixJMihUwwo0Pg@mail.gmail.com>
References: <20250612130835.2478649-1-eddyz87@gmail.com>
	 <20250612130835.2478649-3-eddyz87@gmail.com>
	 <CAEf4BzbTxyGXi=ZNU_yebe2a=zgNoeafRTK9pixJMihUwwo0Pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-12 at 17:01 -0700, Andrii Nakryiko wrote:

[...]

> > +static void destroy_stat_cgroup(void)
> > +{
> > +       char buf[PATH_MAX];
> > +       int err;
> > +
> > +       close(env.memory_peak_fd);
> > +
> > +       if (env.orig_cgroup[0]) {
> > +               snprintf_trunc(buf, sizeof(buf), "%s/cgroup.procs", env=
.orig_cgroup);
> > +               err =3D write_one_line(buf, "%d\n", getpid());
> > +               if (err < 0)
> > +                       log_errno("moving self to original cgroup %s\n"=
, env.orig_cgroup);
> > +       }
> > +
> > +       if (env.stat_cgroup[0]) {
> > +               err =3D rmdir(env.stat_cgroup);
>=20
> We need to enter the original cgroup to successfully remove the one we
> created, is that right? Otherwise, why bother reentering if we are on
> our way out, no?

Yes, cgroup can't be removed if there are member processes.
I chose to organize this way because there would be a message printed
with a name of stale group.

>=20
> > +               if (err < 0)
> > +                       log_errno("deletion of cgroup %s", env.stat_cgr=
oup);
> > +       }
> > +
> > +       env.memory_peak_fd =3D -1;
> > +       env.orig_cgroup[0] =3D 0;
> > +       env.stat_cgroup[0] =3D 0;
> > +}
> > +
> > +/*
> > + * Creates a cgroup at /sys/fs/cgroup/veristat-accounting-<pid>,
> > + * moves current process to this cgroup.
> > + */
> > +static void create_stat_cgroup(void)
> > +{
> > +       char cgroup_fs_mount[PATH_MAX + 1];
> > +       char buf[PATH_MAX + 1];
> > +       int err;
> > +
> > +       env.memory_peak_fd =3D -1;
> > +
> > +       if (!output_stat_enabled(MEMORY_PEAK))
> > +               return;
> > +
> > +       err =3D scanf_one_line("/proc/self/mounts", 2, "%*s %" STR(PATH=
_MAX) "s cgroup2 %s",
>=20
> let's just hard-code 1024 or something and not do that STR() magic,
> please (same below).
>=20
> > +                            cgroup_fs_mount, buf);
> > +       if (err !=3D 2) {
> > +               if (err < 0)
> > +                       log_errno("reading /proc/self/mounts");
> > +               else if (!env.quiet)
> > +                       fprintf(stderr, "Can't find cgroupfs v2 mount p=
oint.\n");
> > +               goto err_out;
> > +       }
> > +
> > +       /* cgroup-v2.rst promises the line "0::<group>" for cgroups v2 =
*/
> > +       err =3D scanf_one_line("/proc/self/cgroup", 1, "0::%" STR(PATH_=
MAX) "s", buf);
>=20
> do you think just hard-coding /sys/fs/cgroup would not work in
> practice? It just feels like we are trying to be a bit too flexible
> here...

Idk, removing this saves 10 lines.
On machines I have access to (one CentOS, one Fedora) the mount point
is /sys/fs/cgroup.

>=20
> > +       if (err !=3D 1) {
> > +               if (err < 0)
> > +                       log_errno("reading /proc/self/cgroup");
> > +               else if (!env.quiet)
> > +                       fprintf(stderr, "Can't infer veristat process c=
group.");
> > +               goto err_out;
> > +       }
> > +
>=20
> [...]

Ack for other points, thank you for taking a look.

