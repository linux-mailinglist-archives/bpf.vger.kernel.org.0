Return-Path: <bpf+bounces-69748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D17A2BA0979
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 18:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9012E189F33C
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 16:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA2830597E;
	Thu, 25 Sep 2025 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPGQOCdC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CA63054D8
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817544; cv=none; b=c1VhLH9KStZz2CqvKPuYagIKL9I44v1nne/Y4EIGQfm6UvZE1qw6JvsYKTngKwekW3AF15EUqNT017Uu6jorwc1wMsYW6ZsgU3kNOg34C9w9fyc9GNoK3xZis3b34/zJVf7Fs4tlVU6eTUxkEGn166NpS6mVXLvOHvb/ckLdDms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817544; c=relaxed/simple;
	bh=e2zTOUXdFrzwKW6u+2BZRJvKLeVeKwka9WRmiQrAMKE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gY4iBI57t0nmRDt4khTNGzujhIypzxopQ3q76iLsf5iE34MjVEHJ9N0dfo5iuZoFgNKl4F0SM0pYY0TZbzh8kEGgHdvFHXDtMOiiFQIlL8lW1sWiKfjItUTiALSEKwOnivyjsq13JImXkAwfQ5gUF+SN0c/JqfsVdZZecfBFjjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPGQOCdC; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-41174604d88so437817f8f.2
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 09:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758817541; x=1759422341; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sp90x0HI2604VafoUtGiosJXSBDN/QH7OATIlIgLDsg=;
        b=KPGQOCdC5XPB1/J8eD/D2m2IQe9ey4w1pU0lFDgu0rBjbdlsLfTMCcW8gjxup3EE2d
         vwGRuphi2MRe65mp4c6zCM5ooqfYNJWJl+jm03jOAuzAAQf3aRS5YMhmvPJzobwkev4D
         ujytbH4Xd6O6hXctlcBK6KF62ZdfC13ozys4wdm0r8zBtLDBaZsqcDgCLZd+2DF05oc3
         C82AGnfGksYADjMFOCk2MfC+HJ7C2D9vhEzmkTlJnGCluskTEPpuM7UV0A3H9ygKRdMS
         S1f84YsVcBTeryfm35SuXmfDuEFO4wYv9erN4eylrXd4XGdWdCI6leP+jdBV3z99jk+f
         +uBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758817541; x=1759422341;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sp90x0HI2604VafoUtGiosJXSBDN/QH7OATIlIgLDsg=;
        b=E91i++UoesBT53pJqrPi4RqxkrTO8rhaY3CNgEOyM/JzNgG+9TntD4BzdkVwZnOTro
         p+jp0bGGEn6/IxtskJ+Yq75+EUlgwi2hscnsFdL1jj8JCdC55l7t0q6gjmJXlSYp27QC
         o/zC+hd7qJMbrJQ/JEjAs/aMb/HpWnzKq2GPDq9B66V9YMJxNiAwhIJirSqGrXubSqEd
         l9It9odQpa7fVqWbpeN1l55Z7sdyFGC/FcGseK77QeTrEK7jOnPce9nVoyo+QRb3Y0IB
         jIzFdkgcqWRHZ8EXcfVVGcgrQKRxjYUI9cD1hzHg7apI4XMR6HTWrVVLv4eBMZMww8my
         xe6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJdh1sBwtFz44/i6lzvBsjsym9r+Rb4tH3RDlEEGw6r4eE2l8lKPl+7AIixBEBkOhyjFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/UjoC2ZxA2EnSfM7Efrd4P/TM9fPjS7RP5H1ONkwZ/d+/FVzp
	8DIt9C9tu9XXDMeN6HQQ6HNx+QKMS7zEHmSpuoU3oY2RyJnwZBv63R/ul11NpoWIQbY=
X-Gm-Gg: ASbGncs4Ek26Nh+kMHBzFS5yorLQI0aP//Vvd8zztWE7+pI5s1M70gmQ3soNQIxEvpE
	KB1QSPkQp9Q4Ps5dz79QNa4eCClql4bZbB40j1TSvQkcze6ew0gyJgqT0usUArV0uGAk2QcdsSC
	lA30wW0GZM6prQTBDRVBPsUQNaBWmPo9CzOQpDKmAYDx5hSULAGuvGqp4tldVDzjyTzcVBNhkhP
	+73lp0lN8R4TcU/u1a3Fhru4KE+GAFAtOayYfx5kwuCWlXxiFrKpWVzCaawk3xoIq7xeD0dTQWT
	haZyDxSv5yGS9vzzAmim7LPtx25wnIK0/ckuw1wXFa/HhMM5xsifostfAbXUdIQUMx0ujPi2vNu
	Tdk9WZJuCMU0BMfRVpM0j1hwwHsa3ZXm5dmGa/GTHeLw6GBaHvQG/H1Ogww==
X-Google-Smtp-Source: AGHT+IE6mWeX6t2AH8HBB+UpOYdjBBRGFMRn/aYCb3judhabM8SWtsPgFs4uiI3dBuK0IPElmXVzNA==
X-Received: by 2002:a05:6000:4387:b0:3ec:1fff:3b25 with SMTP id ffacd0b85a97d-40e3a2eef9emr4065514f8f.0.1758817541137;
        Thu, 25 Sep 2025 09:25:41 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fac4a5e41sm3950563f8f.0.2025.09.25.09.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 09:25:40 -0700 (PDT)
Message-ID: <9df66167c205e341bd5896376e06950aa7bd7240.camel@gmail.com>
Subject: Re: [bug report] [regression?] bpf lsm breaks /proc/*/attr/current
 with security= on commandline
From: Filip Hejsek <filip.hejsek@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>,
  "Serge E. Hallyn"	 <serge@hallyn.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	regressions@lists.linux.dev
Date: Thu, 25 Sep 2025 18:25:39 +0200
In-Reply-To: <CAHC9VhQ-c65UJS+dRaRFn_D=Sq++QXePTsCkN+cV5BVQEbf9fQ@mail.gmail.com>
References: <e5d594d0aee93da67a22a42d0e2b4e6e463ab894.camel@gmail.com>
	 <CAHC9VhRu=-J5xdKgYOJ1eqQ6EiMoEJ3M+cjDU8AHrts-=DoTvg@mail.gmail.com>
	 <cd35aa283cf010188a3b0e318f2c16655224767c.camel@gmail.com>
	 <CAHC9VhQ-c65UJS+dRaRFn_D=Sq++QXePTsCkN+cV5BVQEbf9fQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-25 at 11:28 -0400, Paul Moore wrote:
> On Thu, Sep 25, 2025 at 10:56=E2=80=AFAM Filip Hejsek <filip.hejsek@gmail=
.com> wrote:
> > On Wed, 2025-09-24 at 17:24 -0400, Paul Moore wrote:
> > > On Sat, Sep 13, 2025 at 1:01=E2=80=AFPM Filip Hejsek <filip.hejsek@gm=
ail.com> wrote:
> > > >=20
> > > > Hello,
> > > >=20
> > > > TLDR: because of bpf lsm, putting security=3Dselinux on commandline
> > > >       results in /proc/*/attr/current returning errors.
> > > >=20
> > > > When the legacy security=3D commandline option is used, the specifi=
ed lsm
> > > > is added to the end of the lsm list. For example, security=3Dapparm=
or
> > > > results in the following order of security modules:
> > > >=20
> > > >    capability,landlock,lockdown,yama,bpf,apparmor
> > > >=20
> > > > In particular, the bpf lsm will be ordered before the chosen major =
lsm.
> > > >=20
> > > > This causes reads and writes of /proc/*/attr/current to fail, becau=
se
> > > > the bpf hook overrides the apparmor/selinux hook.
> > >=20
> > > What kernel are you using?
> >=20
> > I'm using Arch Linux kernel, which is very close to mainline. I have
> > also tested my own build from git sources (I used a stripped down
> > config which I based on config from Arch). Example in QEMU:
> >=20
> > $ qemu-system-x86_64 -nodefaults -accel kvm -cpu host -smp cpus=3D2 -m =
1G -display none -kernel ~/git/linux/arch/x86/boot/bzImage -initrd ./initra=
mfs.img -serial mon:stdio -append 'console=3DttyS0 security=3Dselinux'
> > :: mounting '' on real root
> > mount: /new_root: no valid filesystem type specified.
> > ERROR: Failed to mount '' on real root
> > You are now being dropped into an emergency shell.
> > sh: can't access tty; job control turned off
> > [rootfs ~]# uname -a
> > Linux archlinux 6.17.0-rc7-00020-gcec1e6e5d1ab #3 SMP PREEMPT_DYNAMIC T=
hu Sep 25 16:28:02 CEST 2025 x86_64 GNU/Linux
> > [rootfs ~]# mount -t securityfs securityfs /sys/kernel/security
> > [rootfs ~]# cat /proc/cmdline
> > console=3DttyS0 security=3Dselinux
> > [rootfs ~]# cat /sys/kernel/security/lsm; echo
> > capability,landlock,lockdown,yama,bpf,selinux
> > [rootfs ~]# cat /proc/self/attr/current
> > cat: read error: Invalid argument
> >=20
> > (Note: In this example, uname reports archlinux, but that's only
> > because I based the config on Arch config, it's not actually an Arch
> > kernel.)
> >=20
> > Maybe the different behavior is caused by a different config? You can
> > find the Arch config at [1]. Based on Fedora package sources, I think
> > their config has
> >=20
> >    CONFIG_LSM=3D"lockdown,yama,integrity,selinux,bpf,landlock,ipe"
> >=20
> > while the Arch config has
> >=20
> >    CONFIG_LSM=3D"landlock,lockdown,yama,integrity,bpf"
>=20
> That's interesting, you're running a LSM that isn't normally run in
> your distro and you're not properly initializing it (no policy load).
> Both are acceptable, but you're definitely operating in the
> corner-iest of corner cases ;)
>=20
> I'd have to look at the relevant code, but I suspect that with
> "selinux" missing from the CONFIG_LSM list and you manually specifying
> it on the kernel command line with "security=3Dselinux" you are getting
> it placed at the very end as opposed to what I saw (I have "selinux"
> in my CONFIG_LSM list).  It's further complicated by the fact that the
> procfs call into the LSM's security_getprocattr() hook is going to
> pass a 0/zero into the hook as the @lsmid which means "first
> available".
>=20
> Considering that the "security=3D" parameter is a legacy option, I'd
> encourage you to try the "lsm=3D" parameter (make sure you specify the
> full list of LSMs you want, in order) to see if that works.

Yes, that works.

The problem isn't that there wouldn't be any working configuration. The
problem is that a userspace program (in my case CRIU) was broken and I
had to spend time figuring out what the cause of the issue was. I'm not
the only one who encountered this issue [1]. I know that at least
Manjaro Linux used to ship a grub config with security=3Dapparmor at some
point (and maybe still does). I no longer use Manjaro Linux, but I
still had this parameter left in my grub config.

[1]: https://github.com/checkpoint-restore/criu/issues/2033

So in reporting this issue, I was just hoping to help future users
avoid the same problem. If you think this is a waste of time, feel free
to ignore this (and sorry I didn't make this clear in the first email).

Lastly, I will offer a few thoughts:
 * The fact that the security parameter can break programs like this is
   highly non-obvious and undocumented.
 * The BPF LSM hook which causes this breakage is useless, because a
   BPF program cannot be attached to it. I think it would make sense to
   just remove it.
 * Switching to using /proc/*/attr/<lsm>/* solves the problem from the
   userspace side. Unfortunately, selinux does not have its
   subdirectory in attr.

Kind regards,
Filip Hejsek

