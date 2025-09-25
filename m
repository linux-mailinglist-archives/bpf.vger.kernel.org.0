Return-Path: <bpf+bounces-69722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E29EEBA0178
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 16:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01AFD19C4F7C
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 14:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C996B2E1EE2;
	Thu, 25 Sep 2025 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfiu3FKo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64838F54
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812220; cv=none; b=G2RVLa+KB/Yhvc62EACmz4YP1fFsRbxK26Ms797Z84yiStYnrdtuHoNqhttWDyRh3CrUOwq0qpjGNUxu7MJdvozN3p8t1RFFtZMzmO0LuNNVv0vpSqhLGj2R5xSMRGVDTl+Yi9NXQIqbEeThfrPg2ksuHqAt+DolRM9J5QbJdR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812220; c=relaxed/simple;
	bh=iXjdYy/Oe5sVP96M1v1HO37ho1pc8PIfeIRa6Jk7gsk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HnKqm0f/wkIVfeZ74mlDJruLwyJ3JvHW9HG4MCxTGP3EBHgbwoSn6NaSRMfdOhJPxTejhWxsRwBBZShCuIBLd5zSdAToUmK0PW6MI4qm0sIWbauJwoeHW1RM0guS52u+S1ZTp+lBfd/ZwgQgg6MyV+cLzVHLW6qlXD12c6g14cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfiu3FKo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso6886965e9.3
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 07:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758812217; x=1759417017; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vQLgyQTTgUDea9nF4s1X9HICWryIv9j0DFy7IvOKWt0=;
        b=hfiu3FKoJ0+bIORChplDlPZzuM2+HuuaqZoAvJA1CH6hy48Ts8+VvMEUjcvVHAusxX
         sBTqceF1dmm13bGbmx6jAB2ZJZO36bE7c1Po6DvSJa4dsoAQqPBaZ5IBHQLXOxTeHTGK
         4l6GAcwpCTzFHJfV8NXjDAmtVZVQSj5eIDFW+74DRzPo/F8kUuxxSyTUGHG9sKscMehg
         thw1CtLyj7/vShcVFIYbb+kR84kshDsFHefOgKyFntSf+7pKS/FM2N70BZuHI07d8IiS
         00jS8yTBdPnbguET0tHlwX0wX5t3tMAaZFjxX7aonbabNGlxIIRNvnOk4j17fgTErD8b
         Hdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758812217; x=1759417017;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vQLgyQTTgUDea9nF4s1X9HICWryIv9j0DFy7IvOKWt0=;
        b=k0sq+wXCUhLum/85cQIPogc2rIiViXNyEKPqOfW93mIxXgERtrBW3wBgHmUJU9//hg
         GJHfEpHv923WPBRLgB2OgAk6hWD/GeR1sBW4h7Oto8eTUn45ZVAwbDHprNbXKCRqPN+d
         bFRbwrqyz+EID4iUUzjmuu4nBhmx+E0ZcPaAnpTA34tcdKfptFo1mIblu7L8SRcNuB/g
         tehD0iUstF5H6vke+ZD0Z2fXsziEbH0hh4PAvkJkZJYnG5a9ybKfdv4mMPKxeZ6fwAzY
         xBEbAh6D9E6zslkwqj0cK5i317D9SpdDjrQ04UHExYpZRw3FibPMi9tQ2jYVvGDc3pAU
         43BA==
X-Forwarded-Encrypted: i=1; AJvYcCUq4i6Sk+e24CSDgy8rzQCUGyLEzecZFfdZ2ZurK4jBGBTAZKvP3PrYb3WPBiSceQ9p0TA=@vger.kernel.org
X-Gm-Message-State: AOJu0YztyLsRScWcz7u6Mo7uaFOxCigPKf3acZEmfz0M4irwKUwdXLPh
	JYoKFf2FkNe2ksq72FO25XIRCLZYXq0U1XICpgf/GIG1w/2Mo1zAosbV
X-Gm-Gg: ASbGnctpnqjhwzGq23A+ujYD/KAf54qdkI8+qaXPcjh5E9uaZM1s+Ue8WUaGTpmZVew
	oY0tBTX3wst3HG+T3oYlmAcd+oWxtS7++0w32cQV5/fEHJE3MEEKIJIhEEtA32FNq9T+xv3sdTo
	4H9FW5al7mnNJ2XsxsJtfN74a2evVUqepGc9PJc/a/b/dstIdJdWuEFuyPmkpBXqtt8+XdqDMh7
	bHIlSChy7djqx3x166TG62nmGOk6WXnp8+IBSBFEVUajylYJVauk/yxnIyh+qIKndwRzgeRqJFC
	o9vYq+EMsOUjxDZruRxuAWmyS2oBUwcJetvZwNPpjXLg3f18QDZy9zsQVptCSVYYBMYv0hLcgAP
	LwP9yMzBFuGPB3nvT1b9iwB0V710VVU4bPQun8fd2cfBheU2u27W8w3VWnA==
X-Google-Smtp-Source: AGHT+IEzGD5aTIxkgOT3hW9heRIa+e6bI+J2eP+kb7/6OWm0dTSB2R32Wm5QMktzASbLVZB/YT64hQ==
X-Received: by 2002:a05:600c:1553:b0:46e:39e4:1721 with SMTP id 5b1f17b1804b1-46e39e41ae1mr1183735e9.12.1758812216424;
        Thu, 25 Sep 2025 07:56:56 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bede2csm36381395e9.17.2025.09.25.07.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 07:56:55 -0700 (PDT)
Message-ID: <cd35aa283cf010188a3b0e318f2c16655224767c.camel@gmail.com>
Subject: Re: [bug report] [regression?] bpf lsm breaks /proc/*/attr/current
 with security= on commandline
From: Filip Hejsek <filip.hejsek@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>,
  "Serge E. Hallyn"	 <serge@hallyn.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	regressions@lists.linux.dev
Date: Thu, 25 Sep 2025 16:56:55 +0200
In-Reply-To: <CAHC9VhRu=-J5xdKgYOJ1eqQ6EiMoEJ3M+cjDU8AHrts-=DoTvg@mail.gmail.com>
References: <e5d594d0aee93da67a22a42d0e2b4e6e463ab894.camel@gmail.com>
	 <CAHC9VhRu=-J5xdKgYOJ1eqQ6EiMoEJ3M+cjDU8AHrts-=DoTvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-24 at 17:24 -0400, Paul Moore wrote:
> On Sat, Sep 13, 2025 at 1:01=E2=80=AFPM Filip Hejsek <filip.hejsek@gmail.=
com> wrote:
> >=20
> > Hello,
> >=20
> > TLDR: because of bpf lsm, putting security=3Dselinux on commandline
> >       results in /proc/*/attr/current returning errors.
> >=20
> > When the legacy security=3D commandline option is used, the specified l=
sm
> > is added to the end of the lsm list. For example, security=3Dapparmor
> > results in the following order of security modules:
> >=20
> >    capability,landlock,lockdown,yama,bpf,apparmor
> >=20
> > In particular, the bpf lsm will be ordered before the chosen major lsm.
> >=20
> > This causes reads and writes of /proc/*/attr/current to fail, because
> > the bpf hook overrides the apparmor/selinux hook.
>=20
> What kernel are you using?

I'm using Arch Linux kernel, which is very close to mainline. I have
also tested my own build from git sources (I used a stripped down
config which I based on config from Arch). Example in QEMU:

$ qemu-system-x86_64 -nodefaults -accel kvm -cpu host -smp cpus=3D2 -m 1G -=
display none -kernel ~/git/linux/arch/x86/boot/bzImage -initrd ./initramfs.=
img -serial mon:stdio -append 'console=3DttyS0 security=3Dselinux'
:: mounting '' on real root
mount: /new_root: no valid filesystem type specified.
ERROR: Failed to mount '' on real root
You are now being dropped into an emergency shell.
sh: can't access tty; job control turned off
[rootfs ~]# uname -a
Linux archlinux 6.17.0-rc7-00020-gcec1e6e5d1ab #3 SMP PREEMPT_DYNAMIC Thu S=
ep 25 16:28:02 CEST 2025 x86_64 GNU/Linux
[rootfs ~]# mount -t securityfs securityfs /sys/kernel/security
[rootfs ~]# cat /proc/cmdline
console=3DttyS0 security=3Dselinux
[rootfs ~]# cat /sys/kernel/security/lsm; echo
capability,landlock,lockdown,yama,bpf,selinux
[rootfs ~]# cat /proc/self/attr/current
cat: read error: Invalid argument

(Note: In this example, uname reports archlinux, but that's only
because I based the config on Arch config, it's not actually an Arch
kernel.)

Maybe the different behavior is caused by a different config? You can
find the Arch config at [1]. Based on Fedora package sources, I think
their config has

   CONFIG_LSM=3D"lockdown,yama,integrity,selinux,bpf,landlock,ipe"

while the Arch config has

   CONFIG_LSM=3D"landlock,lockdown,yama,integrity,bpf"

.

[1]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/raw/=
main/config?ref_type=3Dheads

>   Things appear to work correctly on my
> kernel that is tracking upstream (Fedora Rawhide + some unrelated
> bits):
>=20
> % uname -a
> Linux dev-rawhide-1.lan 6.17.0-0.rc7.250923gd1ab3.57.1.secnext.fc44.x86_6=
4 #1 SM
> P PREEMPT_DYNAMIC Tue Sep 23 10:07:14 EDT 2025 x86_64 GNU/Linux
> % cat /proc/cmdline
> BOOT_IMAGE=3D(hd0,gpt4)/boot/vmlinuz-6.17.0-0.rc7.250923gd1ab3.57.1.secne=
xt.fc44.x
> 86_64 root=3DUUID=3D285029fa-4431-45e9-af1b-298ab0caf16a ro console=3Dtty=
S0 mitigation
> s=3Doff security=3Dselinux
> % cat /sys/kernel/security/lsm; echo ""
> lockdown,capability,yama,selinux,bpf,landlock,ipe,ima,evm
> % id -Z
> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> % cat /proc/self/attr/current; echo ""
> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
>=20
> I even ran it against the LSM initialization rework that has been
> proposed, but has not yet been accepted/merged, and that worked the
> same as above.
>=20
> Is this a distro kernel with a lot of "special" patches which aren't
> present upstream?

