Return-Path: <bpf+bounces-59896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4116AD0728
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 19:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7F9188B844
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 17:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BA528A1F9;
	Fri,  6 Jun 2025 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGRxtxt0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70ED289371
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 17:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749229428; cv=none; b=WxqDczx6Q79Q//5+zRnggjhrI25ZsMmh6ww0ZUadjwgfZOSPQ2usNmAABHT/Q0yI95x3IAcIS04LCWz4uSizcBWTsm7MjuCQgPo3uuieMJ9urfF2xB5631cJmQhx6JmBA+aFFGAdMbHNgYtbnKQ0eSI1ovdJe8RcufkbIT5adOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749229428; c=relaxed/simple;
	bh=qEImhkaJ7GLgdGLXf2Ew5YolnI5XHp6SrkSsK0gFk30=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IsqG+kmSaRi/l148Ev1fHpl37RxvepKbnqAeK2m21NPsfObqiXq8L1RZT6ljjdACr9MeGpZRK9gchEVdOXeJK4mc+xWXif8Icc6DiGRQuA3qhjnu5Tq4EPbdOf7+nWX5Yw3mth9xbaay1eC0SFqTyVZyelwL1SJMMEkAk0NWPeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGRxtxt0; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7482377b086so979379b3a.1
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 10:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749229426; x=1749834226; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5z9/VSGextZfTY0qbpGtrbHUZngDfdst5gligRDVd4M=;
        b=XGRxtxt0nMZHID2DVgrn7XTq6cDgQ6uNYPMGgjVEuuDiNgY6mLOS2YuudW6XVooDF0
         uhGqAJck9tshScn8CIUJBY+q5IpA/+NTC0JmWwsjrJvstQo65AjQc20hjzaTOA3SXoD3
         SECbgCQDK95hdqwxiKij9Zyi4mL8//7jD981omjH0TZcCpBICmA1fg3PlLenSFUXPvSS
         O5d0wQCI3kpPRlJhi1iCXhcQ7uIRizvUaySGaNF5r9+T3W1Ij8wwqXusyLc0W1IS1uGF
         +2tp9wBVhl8aXAmv01kQ0Vov6oOO/l3S1PjVnYCRybiIME90+Pck8OtKekRKF2t8pA72
         xXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749229426; x=1749834226;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5z9/VSGextZfTY0qbpGtrbHUZngDfdst5gligRDVd4M=;
        b=My6Y3LzsPEmfv0FfZY3fOQ4kXLAAjq9EzX6xbHZuKVYMbj4AyDpIe9ojCXAGCQAsdL
         p0o1SjjrXUAR9KnMEZBbGtbYQ7kteTFW3iQh0rU59Pm2viiGNfu5eJfHCWniAc4FH7Il
         AD6ptPlWevRU7kZAuHkgJvPquxe2kJNAAPyHaI6nEzv7BvauIzQgs+tgKApTimym6gl+
         iZy3c1camKC4y1F0H0pAGFhI5t3z4tlnDyv3jbkr3Gvq1COi79injac095c+M0acQ2Bg
         C4LU1SIFbffuXILrzQ7KhL4AcjNQBPp5ZmuoJToHc7gidm0a9A9HD+DuhuiJvZNyfbhy
         Sf1A==
X-Forwarded-Encrypted: i=1; AJvYcCV3bwIQvPp78C/372b/g982Uy/ulasVV/CvUNWgswHckBhfyjSt8k8PZNy2eNwASJlBBnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI7GgRV3Yohbpu21itDcl1kmB4vJIdjCKepVpP+6WJBlvnwDjN
	waFzbTdtz/DMBbliQKbu1UdblAYniuVriloC8bKo9Ae6SXvzzfJsuYEw
X-Gm-Gg: ASbGncvT6ocRMknG5H9ee2uYIcJAWKge9Bs0pf2wYSe4XbB5O+LEiB7r90QOpTpr8Os
	k85mVG+8NgI4HjmD/M4v70nN2jKo8hTzvsFR+EOBob7UQ0vb6IZNXm3XlOjy1lyWv8ydxRwJcA+
	m60CNHA/MC8NsmGez7e1TTSTxldlr6mvFSS5F+lNbQKUlSIo3QfdDfgCs2JrirHDeWDm2rh7oOZ
	2X2JO1PTk/hpcREi7tVTjnVU7giR1TuvLBFbgns8vEY3HxuAlg7KLjUSVpoV6YJwMhEnODRFRFx
	Nd/JMe8Wy1q5CcBwn9rPW1Ylv4XJ89Pxk9tscNcLfT9z/zc=
X-Google-Smtp-Source: AGHT+IGxslJZOQ08d+hHOamBCoKip7MKXQOdV5a5gPa9BgnqlsfJbnRBL46E/S4KSgdDi7wA7rOVlA==
X-Received: by 2002:a05:6a00:2343:b0:746:2a0b:3dc8 with SMTP id d2e1a72fcca58-74827f10ac0mr5315326b3a.17.1749229425658;
        Fri, 06 Jun 2025 10:03:45 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0bd815sm1543472b3a.109.2025.06.06.10.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 10:03:45 -0700 (PDT)
Message-ID: <efe0cc259f70b11ffd3e398441efd0de5aa98c3e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] veristat: memory accounting for bpf
 programs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev
Date: Fri, 06 Jun 2025 10:03:42 -0700
In-Reply-To: <3dd16f19-63a4-4090-abd0-9b84fb07346b@gmail.com>
References: <20250605230609.1444980-1-eddyz87@gmail.com>
	 <20250605230609.1444980-3-eddyz87@gmail.com>
	 <3dd16f19-63a4-4090-abd0-9b84fb07346b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-06-06 at 17:53 +0100, Mykyta Yatsenko wrote:

[...]

> > +/*
> > + * Creates a cgroup at /tmp/veristat-cgroup-mount-XXXXXX/accounting-<p=
id>,
> > + * moves current process to this cgroup.
> > + */
> > +static int create_stat_cgroup(void)
> > +{
> > +	char buf[PATH_MAX + 1];
> > +	int err;
> > +
> > +	if (!env.cgroup_fs_mount[0])
> > +		return -1;
> > +
> > +	env.memory_peak_fd =3D -1;
> > +
> > +	snprintf_trunc(buf, sizeof(buf), "%s/accounting-%d", env.cgroup_fs_mo=
unt, getpid());
> > +	err =3D mkdir(buf, 0777);
> > +	if (err < 0) {
> > +		err =3D log_errno("mkdir(%s)", buf);
> > +		goto err_out;
> > +	}
> > +	strcpy(env.stat_cgroup, buf);
> > +
> > +	snprintf_trunc(buf, sizeof(buf), "%s/cgroup.procs", env.stat_cgroup);
> > +	err =3D write_one_line(buf, "%d\n", getpid());
> > +	if (err < 0) {
> > +		err =3D log_errno("echo %d > %s", getpid(), buf);
> > +		goto err_out;
> > +	}
> > +
> > +	snprintf_trunc(buf, sizeof(buf), "%s/memory.peak", env.stat_cgroup);
> > +	env.memory_peak_fd =3D open(buf, O_RDWR | O_APPEND);
>
> Why is it necessary to open in RW|APPEND mode? Won't O_RDONLY cut it?

With current implementation -- not necessary, O_RDONLY should be sufficient=
.

> > +	if (env.memory_peak_fd < 0) {
> > +		err =3D log_errno("open(%s)", buf);
> > +		goto err_out;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_out:
> > +	destroy_stat_cgroup();
> > +	return err;
> > +}

[...]

> > +/* Current value of /tmp/veristat-cgroup-mount-XXXXXX/accounting-<pid>=
/memory.peak */
> > +static long cgroup_memory_peak(void)
> > +{
> > +	long err, memory_peak;
> > +	char buf[32];
> > +
> > +	if (env.memory_peak_fd < 0)
> > +		return -1;
> > +
> > +	err =3D pread(env.memory_peak_fd, buf, sizeof(buf) - 1, 0);
> > +	if (err <=3D 0) {
> > +		log_errno("read(%s/memory.peak)", env.stat_cgroup);
> > +		return -1;
> > +	}
> > +
> > +	buf[err] =3D 0;
>
> nit: maybe rename err to len here?

Sure, will rename.

> > +	errno =3D 0;
> > +	memory_peak =3D strtoll(buf, NULL, 10);
> > +	if (errno) {
> > +		log_errno("unrecognized %s/memory.peak format: %s", env.stat_cgroup,=
 buf);
> > +		return -1;
> > +	}
> > +
> > +	return memory_peak;
> > +}
> > +

[...]

> > @@ -1332,7 +1551,16 @@ static int process_prog(const char *filename, st=
ruct bpf_object *obj, struct bpf
> >   	if (env.force_reg_invariants)
> >   		bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_TEST_=
REG_INVARIANTS);
> >  =20
> > -	err =3D bpf_object__load(obj);
> > +	err =3D bpf_object__prepare(obj);
> > +	if (!err) {
> > +		cgroup_err =3D create_stat_cgroup();
> > +		mem_peak_a =3D cgroup_memory_peak();
> > +		err =3D bpf_object__load(obj);
> > +		mem_peak_b =3D cgroup_memory_peak();
> > +		destroy_stat_cgroup();
>
> What if we do create_stat_cgroup/destory_stat_cgroup in=20
> handle_verif_mode along with mount/umount_cgroupfs.
> It may speed things up a little bit here and moving all cgroup=20
> preparations into the single place seems reasonable.
> Will memory counter behave differently? We are checking the difference=
=20
> around bpf_object__load, from layman's
> perspective it should be the same.

The memory.peak file accounts for peak memory consumption, so one
would need to reset this counter between program verifications.
Doc [1] describes such mechanism:

    memory.peak

      A read-write single value file which exists on non-root cgroups.

      The max memory usage recorded for the cgroup and its descendants
      since either the creation of the cgroup or the most recent reset
      for that FD.

      A write of any non-empty string to this file resets it to the
      current memory usage for subsequent reads through the same file
      descriptor.

    memory.reclaim

      A write-only nested-keyed file which exists for all cgroups.
   =20
      This is a simple interface to trigger memory reclaim in the target
      cgroup.
   =20
      Example:
   =20
        echo "1G" > memory.reclaim
   =20
      Please note that the kernel can over or under reclaim from the
      target cgroup. If less bytes are reclaimed than the specified
      amount, -EAGAIN is returned.

As mentioned in cover letter, I tried using a combination of the above,
while creating a cgroup only once. For reasons I don't understand this
did not produce stable measurements. E.g. depending on a program being
verified in isolation or as part of a batch results vary from 5mb to 2mb.

[1] https://docs.kernel.org/admin-guide/cgroup-v2.html

> > +		if (!cgroup_err && mem_peak_a >=3D 0 && mem_peak_b >=3D 0)
> > +			mem_peak =3D mem_peak_b - mem_peak_a;
> > +	}
> >   	env.progs_processed++;
> >  =20
> >   	stats->file_name =3D strdup(base_filename);
> > @@ -1341,6 +1569,7 @@ static int process_prog(const char *filename, str=
uct bpf_object *obj, struct bpf

[...]

> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

Thank you. I will have to send a v2 avoiding mount operations and
controllers file modification.


