Return-Path: <bpf+bounces-31056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3113B8D67CF
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 19:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4AF28B5C9
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 17:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96B2176242;
	Fri, 31 May 2024 17:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyW4jm2k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA577156242
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717175466; cv=none; b=FFr3eIXrtlhhTf/Jf+K/f1N5Oz79bw+T6EICMWrP+0h8Sfp8Kl0/RVHXFH+7Eqj8UBbVY4AcXvtdhv12RZFdnKOSDAYqnKayv8SBs39z94706+1f5zgw3MU6WySI2op1eyhBaFzhmQqXEh7isfiyJId7LFBfwQFQuRp/kYPdb/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717175466; c=relaxed/simple;
	bh=bTt7imYbyKD/I8HgrwYnIWUEqxdQXWx2Um9hNR1HECE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=STt2E8+2OoqczhBglubiofSuy9ED7kVvWUJgZ/qq3AwN5CmeHzN2HFKRSl17Z6SICpCUbEFIl9X7pjCK2aeOnnvHtmNz/3nBeAqaumqyi7WIupntArHfC4x1Zafx9c8DM8rufYI1Q4Xjsw5ASpRT2qZCyGWFNvrxiE1BtrCnI/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyW4jm2k; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35dc984b3d2so1504801f8f.1
        for <bpf@vger.kernel.org>; Fri, 31 May 2024 10:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717175463; x=1717780263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTt7imYbyKD/I8HgrwYnIWUEqxdQXWx2Um9hNR1HECE=;
        b=hyW4jm2kn2NPK14eQ5rD5BIS7HToasFxfR3nu93L5+qhrUFcw8dwg7DbzMTnaxLoiJ
         HVDjGkfpdcqgm5JP0t5H1dr6Bh1MXHXy8gLIiAKArUqXWgH6yqnmRRei5nHr14Kdimiq
         dyb4CzY/Qi84m6WCzTIF08Djhy7R3JZkebpVPMBYLJNLSQBlZceUStXN3kvDfHU23f2T
         FVgjkpe5+2ffZiuHS8lxNDr5otvgxd4HiL6tJL+H7bT8inivPt6m/BkjnmRQhhB9iBgX
         Z7rBaSO/OPhFK3IwF74le2fVUCoGxZexysIRgKBELQ79m1RTd1xJl+LClomE57rH54eL
         gz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717175463; x=1717780263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTt7imYbyKD/I8HgrwYnIWUEqxdQXWx2Um9hNR1HECE=;
        b=FL9TTLtgoT1037nT9wlWqdW75spdld69vpT8jA5ALskOlbuqJSyOMu9b6lh/YupIyn
         O96f9J2Mve1gnR7FmK6wiO8Jqrj+92qO2MNOcGbAssXgq4xrZMvfuZ8cY7Lko6bZ4Iwb
         rUhnqEQRARQirhk/dcwx5PtGR54H2D0SsGmLhKGNek8jpbTgdiMbndehMBcKdaiJcBwA
         nh6LvUJqsXnQ4AuO3vrj54JgblNhxTEWSzPVOY/to+SOHeSh4XcuTVAy8ZkhEsGvQR+0
         7PthMDAEtNSQTaz5Q2duJsy1sYfB2/TieFsHNVV+1pFnoKDv86glGuiYE7atO7PXDxmc
         fkIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX846qWOExinRbUsAY8Qm+Hd1vbNkM4jQkWdbCZMayVWEjrXAyRiqD4YRlcelN1M2RUs12BKdOrYwG8/NDRNhjF1QXt
X-Gm-Message-State: AOJu0Yxe+640fOYJt5r/tbNc/D/gyPu9K43wtJeViSjSpTBf53oRbg6g
	Xk5gweIkGSdh3QP2Kdp+L9yJaY4YKgkg87Phjqf4HQR2ahoe85ZkIMzyB7irVBMARcrqvme9AQ3
	miLs5YBq+fieNXr+6N1gh28rKIILsGKvF
X-Google-Smtp-Source: AGHT+IFrq3ehfzM7EwfxZrwx5pCAHRiaYf3A2Z2YOJUrYXSsH992ZIM6oVrHeHEDM4kT7mG/PlEuAFEGh3N+JFehS/k=
X-Received: by 2002:adf:e58a:0:b0:354:fb6c:219a with SMTP id
 ffacd0b85a97d-35e0f25978cmr2056782f8f.9.1717175463104; Fri, 31 May 2024
 10:11:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zlb-ojvGgdGZRvR8@gardel-login> <Zlhupe1tXj8ZS1go@krava>
 <ZliKX5EOU9eWhd2U@gardel-login> <Zll5SJcJxvu_yXgt@krava>
In-Reply-To: <Zll5SJcJxvu_yXgt@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 31 May 2024 10:10:51 -0700
Message-ID: <CAADnVQ+KddRh_tm1w1FLWhakZoNAKQCnCBJqEAJO22HGLP-vbQ@mail.gmail.com>
Subject: Re: bpf kernel code leaks internal error codes to userspace
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Lennart Poettering <mzxreary@0pointer.net>, bpf <bpf@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 12:16=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Thu, May 30, 2024 at 04:17:03PM +0200, Lennart Poettering wrote:
> > On Do, 30.05.24 14:18, Jiri Olsa (olsajiri@gmail.com) wrote:
> >
> > > > It seems that the bpf code in the kernel sometimes leaks
> > > > kernel-internal error codes, i.e. those from include/linux/errno.h
> > > > into userspace (as opposed to those from
> > > > include/uapi/asm-generic/errno.h which are public userspace facing
> > > > API).
> > > >
> > > > According to the comments from that internal header file: "These
> > > > should never be seen by user programs."
> > > >
> > > > Specifically, this is about ENOTSUPP, which userspace simply cannot
> > > > handle, there's no error 524 defined in glibc or anywhere else.
> > > >
> > > > We ran into this in systemd recently:
> > > >
> > > > https://github.com/systemd/systemd/issues/32170#issuecomment-207692=
8761
> > > >
> > > > (a google search reveals others were hit by this too)
> > > >
> > > > We commited a work-around for this for now:
> > > >
> > > > https://github.com/systemd/systemd/pull/33067
> > > >
> > > > But it really sucks to work around this in userspace, this is a ker=
nel
> > > > internal definition after all, conflicting with userspace (where
> > > > ENOTSUPP is just an alias for EOPNOTSUPP), hence not really fixable=
.
> > > >
> > > > ENOSUPP is kinda useless anyway, since EOPNOTSUPP is pretty much
> > > > equally expressive, and something userspace can actually handle.
> > > >
> > > > Various kernel subsystems have been fixed over the years in similar
> > > > situations. For example:
> > > >
> > > > https://patchwork.kernel.org/project/linux-wireless/patch/202312110=
85121.3841b71c867d.Idf2ad01d9dfe8d6d6c352bf02deb06e49701ad1d@changeid/
> > > >
> > > > or
> > > >
> > > > https://patchwork.kernel.org/project/linux-media/patch/af5b2e8ac669=
5383111328267a689bcf1c0ecdb1.1702369869.git.sean@mess.org/
> > > >
> > > > or
> > > >
> > > > https://patchwork.ozlabs.org/project/linux-mtd/patch/20231129064311=
.272422-1-acelan.kao@canonical.com/
> > > >
> > > > I think BPF should really fix that, too.
> > >
> > > hm, I don't think we can change that, user space already depends
> > > on those values and we'd break it with new value
> >
> > Are you sure about that? To be able to handle this situation that
> > userspace program whose existance you are indicating would have had to
> > go the extra mile to literally handle error code 524 that is not known
> > to userspace otherwise and handle it. If somebody goes the extra mile
> > to do that, what makes you think that they didn't just handle it as
> > equivalent to regular EOPNOSTUPP? In systemd at least that's what we
> > are doing.
>
> cilium/ebpf [1] library is checking return values just for ENOTSUPP(524)
> on multiple places, libbpf has one place to check on that value for
> program type detection AFAICS
>
> jirka
>
>
> [1] https://github.com/cilium/ebpf/

fwiw both libraries can be changed to check for both error codes
ENOTSUPP and EOPNOTSUPP,
but, as noted earlier, the problem is not limited to bpf.
cilium library mentions
commit cb9a19fe4aa5 ("uprobes: Introduce prepare_uprobe()")
back from 2012.
Where installing uprobe would return ENOTSUPP to user space.

On bpf side we've switched to EOPNOTSUPP for any new code long ago,
but didn't adjust old code, because the damage was done before bpf existed.

$ git grep EOPNOTSUPP kernel/bpf|wc -l
56
$ git grep ENOTSUPP kernel/bpf|wc -l
61

