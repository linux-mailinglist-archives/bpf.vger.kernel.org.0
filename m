Return-Path: <bpf+bounces-18220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7967481773B
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 17:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42DB81C25CD1
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 16:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B80042392;
	Mon, 18 Dec 2023 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="l9fLFPJN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0F63D556
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EC7ED3F2C1
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 16:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1702916304;
	bh=QB+Jj19JnPHT/m+V2bxDFjIga4gzUMzhCmv6eWWgIMU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type;
	b=l9fLFPJNHDnmfOMT/+eHidUP9CuxxE9iyKMYEd7PF7DNXJcFMkhPJV3p716tiTg/s
	 EwPwBvJn3n8J2LfEfqWd3xgqQFUWF64mco9gHumHGZxMqoZRIQPg2hZlT5iMkBJbjm
	 s0IAJwLIK28EPG7jXkNx+KCoRyApj80yYNgREZsCQ3MrxzN2KSUapmdthUtaGTKDKi
	 rzkq/lrfW/B0V24aiiONjTzDJJ1x3li+v+V7SxRwtCbI33o6rCaqp/6jYGBrM1Cc2B
	 Q/1XJvp4tc4HfEsi9qyAarjxBK4AKecYHieKlIHSi/u3XUNO8LpkMuoVHdRaHayd+c
	 6klH+f7oakTLQ==
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50e3478a2c0so1128985e87.0
        for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 08:18:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702916303; x=1703521103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QB+Jj19JnPHT/m+V2bxDFjIga4gzUMzhCmv6eWWgIMU=;
        b=j/AuwAACbKPi5xOLhchssol2O8oQuUwTAZAc7YlSOgR0vKIFnIhLdmHmbroL7KdWns
         1FrpJLE15Ff1yA4IKlCuGyoyNqqvuUlQdlLrTvboBZy+GSckwg6VDy1pNaam+NjjKEyG
         gayqlPi6PTTBrDjQt+GGQMMqHhZjxlnuvNY4EfPZ5G4W1CRsLLWctXs52Kaq1frKmf8Z
         Sdcb2AciW92uVY/5JXj7KdDJ0vj0gqWK1wiIZGqQBL2CXk5cPs6lYZV+sBcuCNpHC37H
         vmIxBkaGlqVerQ95NMeFAWAw2pW55z2NnxW0D3gl/p+3dpMqogM3N/cZdIXl9il+3wr6
         o8Fg==
X-Gm-Message-State: AOJu0Yxneq69LHlYi4B9uPJgZGf+l64WCGbCyDg14lXhs1fBj7tRgXac
	PT5DR8O/UFMuRscrnpwv5yN+cxGsiERz1B44PT6xGuzpV09FPHyOl9Q9Nongln4zmXTiVjzZ4ms
	8eZYcOvUcc4EZ5KgGmPWpFKxr3ZPmm7swJR3Qvw==
X-Received: by 2002:a50:9fab:0:b0:553:4bd4:1d52 with SMTP id c40-20020a509fab000000b005534bd41d52mr1350504edf.75.1702916283144;
        Mon, 18 Dec 2023 08:18:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/014KPPmX/2dQoNTubOi4CoRRFxNtgfqu+tmEfmjToiKyFQxTOvuQxDG5OCH2haGP47bAYA==
X-Received: by 2002:a50:9fab:0:b0:553:4bd4:1d52 with SMTP id c40-20020a509fab000000b005534bd41d52mr1350484edf.75.1702916282769;
        Mon, 18 Dec 2023 08:18:02 -0800 (PST)
Received: from amikhalitsyn (ip5b408b16.dynamic.kabel-deutschland.de. [91.64.139.22])
        by smtp.gmail.com with ESMTPSA id t16-20020a056402241000b00552743342c8sm4566692eda.59.2023.12.18.08.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:18:02 -0800 (PST)
Date: Mon, 18 Dec 2023 17:18:00 +0100
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: Michael =?ISO-8859-1?Q?Wei=DF?= <michael.weiss@aisec.fraunhofer.de>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Mikhalitsyn
 <alexander@mihalicyn.com>, Alexei Starovoitov <ast@kernel.org>, Paul Moore
 <paul@paul-moore.com>, Daniel Borkmann <daniel@iogearbox.net>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Quentin Monnet <quentin@isovalent.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Amir
 Goldstein <amir73il@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <gyroidos@aisec.fraunhofer.de>
Subject: Re: [RFC PATCH v3 3/3] devguard: added device guard for mknod in
 non-initial userns
Message-Id: <20231218171800.474cc21166642d49120ba4e4@canonical.com>
In-Reply-To: <61b39199-022d-4fd8-a7bf-158ee37b3c08@aisec.fraunhofer.de>
References: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
	<20231213143813.6818-4-michael.weiss@aisec.fraunhofer.de>
	<20231215-golfanlage-beirren-f304f9dafaca@brauner>
	<61b39199-022d-4fd8-a7bf-158ee37b3c08@aisec.fraunhofer.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Dec 2023 14:26:53 +0100
Michael Wei=DF <michael.weiss@aisec.fraunhofer.de> wrote:

> On 15.12.23 13:31, Christian Brauner wrote:
> > On Wed, Dec 13, 2023 at 03:38:13PM +0100, Michael Wei=DF wrote:
> >> devguard is a simple LSM to allow CAP_MKNOD in non-initial user
> >> namespace in cooperation of an attached cgroup device program. We
> >> just need to implement the security_inode_mknod() hook for this.
> >> In the hook, we check if the current task is guarded by a device
> >> cgroup using the lately introduced cgroup_bpf_current_enabled()
> >> helper. If so, we strip out SB_I_NODEV from the super block.
> >>
> >> Access decisions to those device nodes are then guarded by existing
> >> device cgroups mechanism.
> >>
> >> Signed-off-by: Michael Wei=DF <michael.weiss@aisec.fraunhofer.de>
> >> ---
> >=20
> > I think you misunderstood me... My point was that I believe you don't
> > need an additional LSM at all and no additional LSM hook. But I might be
> > wrong. Only a POC would show.
>=20
> Yeah sorry, I got your point now.
>=20
> >=20
> > Just write a bpf lsm program that strips SB_I_NODEV in the existing
> > security_sb_set_mnt_opts() call which is guranteed to be called when a
> > new superblock is created.
>=20
> This does not work since SB_I_NODEV is a required_iflag in
> mount_too_revealing(). This I have already tested when writing the
> simple LSM here. So maybe we need to drop SB_I_NODEV from required_flags
> there, too. Would that be safe?
>=20
> >=20
> > Store your device access rules in a bpf map or in the sb->s_security
> > blob (This is where I'm fuzzy and could use a bpf LSM expert's input.).
> >=20
> > Then make that bpf lsm program kick in everytime a
> > security_inode_mknod() and security_file_open() is called and do device
> > access management in there. Actually, you might need to add one hook
> > when the actual device that's about to be opened is know.=20
> > This should be where today the device access hooks are called.
> >=20
> > And then you should already be done with this. The only thing that you
> > need is the capable check patch.
> >=20
> > You don't need that cgroup_bpf_current_enabled() per se. Device
> > management could now be done per superblock, and not per task. IOW, you
> > allowlist a bunch of devices that can be created and opened. Any task
> > that passes basic permission checks and that passes the bpf lsm program
> > may create device nodes.
> >=20
> > That's a way more natural device management model than making this a per
> > cgroup thing. Though that could be implemented as well with this.
> >=20
> > I would try to write a bpf lsm program that does device access
> > management with your capable() sysctl patch applied and see how far I
> > get.
> >=20
> > I don't have the time otherwise I'd do it.
> I'll give it a try but no promises how fast this will go.

Hi Michael,

thanks for your work on this!

If you don't mind I'm ready to help you with writing the PoC for this bpf-b=
ased approach,
as I have touched eBPF earlier I guess I can save some your time. (I'll pos=
t it here and you will incude it
in your patch series.)

Kind regards,
Alex

>=20



