Return-Path: <bpf+bounces-35113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8357B937C8D
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 20:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F70E1F21BEA
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 18:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366641474DA;
	Fri, 19 Jul 2024 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjmtCsLq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D442746B
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 18:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721414350; cv=none; b=hPggcx6jcFdj0QSCcuhaFukM9Cy/da5SXoG9Hw921buWx1DWL1ribO2r6ItvhyeaeXuuA6XxwBZtRBwY9mnqBQO4RABHJ9NPDU6M0dtE5SJbVzIS+RSo3cDKUGktsBylL0em/x58hVl11ez545wxX5iUKLIOzS1ekyAmsw8u8kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721414350; c=relaxed/simple;
	bh=9bFXhL7RVJmmM37R6zGBaUpjRi3UGb/cUwBiMABi5mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJHOlYtGsRiDhMX0WZAgMnrDiw/dfk+LLnAwLf6D7qvRA2TU50bCh6ROzaOPd1TzcE9md/eisUX9g4gzq9sm4feeDpenkd0TfS4uDb2W6Use02UP4x0coIi0MtvvMfvTX7fvdBYFtWggcLZkdHExI/q3PGpvp6U76dG802wbBG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjmtCsLq; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-260209df55dso963994fac.2
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 11:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721414348; x=1722019148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QfZ/0xpEwO/Ptg1Fe//qpbm2saU2tRhymDSPE90wEQ=;
        b=bjmtCsLquQ34xeRukf7HRIS6F4bPVIhkAA4HolsnCTzcRyOFnGbsHjTqWx6oreFSAj
         YtQBv/fEPsR3S/KXkQOcdJJ+g2EQ0dfGhXqCfsiuLWKNG/zCK6X4eYLT5RekN1VbI/+q
         93LdGSNXvSiP1flImHYA0pW9QVHdepRibNgk+lyHgpOyW3sX2XuvQfz11QtmhXSrry+o
         jlIFqc3iDTmqwv0YexzXNcuXhh3H0mTI2pEoNzGfqinatGiOLw6i7CdI4JlBY4Ikw2k7
         VbezXBFstVMf77RSd3TOg/LDelxdrePN0anRwiSyRsYKSHlpVdZiHFXeF5QyZLOLuv4o
         bfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721414348; x=1722019148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QfZ/0xpEwO/Ptg1Fe//qpbm2saU2tRhymDSPE90wEQ=;
        b=piSOF454Q3ejtVrOGm+5P01BS05yW+FXQB5J+fz7zaqkNKOsE3Mbd26Ue+SDxIpooh
         rHC/nUlXV6tmC2dkb8LimDR1xFEc5+63D+I/5mVBqCdWoEhaQR1U9UC1ULV85VsmzMOB
         ZHAOjiJtgidyxyb/N4NzT9Z2oT2aes4ARE8W3VVN8HHRCI9pcmZnz61X6K/ZDgBMPCOX
         NyPlh31MfjB7Uz9AAvokvbxqMuU1BRgSOX3YCtK28DZPSq6LcLlIfeJrNjpO8Y5gSKec
         uOcg8WmYVGwEKWxg3PzxiqrtTIAuNHbwr+TCuOSScJtvcB65N4ANDqMnjvYyDCZ8o3lb
         o0yg==
X-Gm-Message-State: AOJu0YwkQLSjiP2oELol9rI4Jzufm+oyQbYuAwQ9Obizux/SX7IieS1y
	SviKY13+ujY+EycoBcOimrGtl2NLAvhzZ8m8hDhPgcIhMg/0OgbTtGH+6gULaxiynyc8G3xlNEu
	4rPTT+cWhSUlrdC7AE8VUChaR30JQDBD4
X-Google-Smtp-Source: AGHT+IFIP5GDQZpHKQvOuL2idsfEz0nc1KFfFkfvW5zS/rE3datxO1wf3qJBSpthGb1ybKTQuyi06FRuG8Nscf0MS58=
X-Received: by 2002:a05:6870:ac11:b0:260:eb3a:1be with SMTP id
 586e51a60fabf-260eb3a294fmr6417819fac.34.1721414348486; Fri, 19 Jul 2024
 11:39:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ABBF5150-2913-4BE5-80B2-AC8432C4526D@dtucker.co.uk>
In-Reply-To: <ABBF5150-2913-4BE5-80B2-AC8432C4526D@dtucker.co.uk>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Jul 2024 11:38:56 -0700
Message-ID: <CAEf4Bzb0p2bsbAfWVPs1eWN17eY1BfujXObiqGzGoOQCZTFhRg@mail.gmail.com>
Subject: Re: Question: How is BPF Token supposed to work?
To: Dave Tucker <dave@dtucker.co.uk>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 6:46=E2=80=AFAM Dave Tucker <dave@dtucker.co.uk> wr=
ote:
>
> Hi,
>
>
> I=E2=80=99m attempting to implement BPF Token support in Aya using the im=
plementation in
> libbpf and the kernel selftests as a reference. However, I=E2=80=99m hitt=
ing issues.
>
> I'm performing the following operations:
>
> 1. Creating a bpffs (using fsopen, fsconfig, fsmount) for my UID/GID 1000=
 with
>    =E2=80=9Cany=E2=80=9D prog/map/cmd allowed:
>
>    $ mount | grep /tmp/bpffs
>    none on /tmp/bpffs type bpf (rw,relatime,uid=3D1000,gid=3D1000,delegat=
e_cmds=3Dany,delegate_maps=3Dany,delegate_progs=3Dany,delegate_attachs=3Dan=
y)
>
> 2. I=E2=80=99m creating a new userns with bwrap:
>
>    bwrap --unshare-user --unshare-ipc --unshare-pid --unshare-net \
>        --unshare-uts --unshare-cgroup --uid 0 --gid 0 \
>        --bind /var/lib/images/fedora / --dev-bind /dev /dev \
>        --bind /tmp/bpffs /sys/fs/bpf --bind ${PWD} /home/dave \
>        --cap-add CAP_BPF --proc /proc -- /bin/bash
>

I'm not familiar with all the above. But see [0] for exact sequence of
steps necessary. FS object has to be created in child userns, passed
to privileged root userns, which will actually instantiate it, and
then pass that FS FD back to child userns.

This is mandatory so that bpffs captures unprivileged userns as owning
userns (but privileged root userns with CAP_SYS_ADMIN is necessary to
actually create/finalize such bpffs).

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20240124022127.2=
379740-17-andrii@kernel.org/

> 3. I=E2=80=99m then executing my BPF application inside the userns:
>
>    ./xdp-test
>
>
> However, what I=E2=80=99m observing is that my program is failing to load=
.
> strace confirms I=E2=80=99m getting -EINVAL from BPF_TOKEN_CREATE.
>
> $ strace ./xdp-test
> ...
> open("/sys/fs/bpf", O_RDONLY|O_LARGEFILE|O_DIRECTORY) =3D 9
> bpf(BPF_TOKEN_CREATE, {token_create=3D{flags=3D0, bpffs_fd=3D9}}, 152) =
=3D -1 EPERM (Operation not permitted)
> =E2=80=A6
>
> I believe I have CAP_BPF inside the userns also:
>
> $ getpcaps 2 # pid of bash
> 2: cap_bpf=3Deip
>
> My machine is running on Kernel 6.9.4.
>
> The only difference I can see between my code and the selftest is that th=
e
> selftest os performing the fsopen from within the userns, which looks lik=
e it
> is deliberate in order to check you can=E2=80=99t set delegation options =
from within
> the userns.

not just to check, but it's mandatory to capture owning userns


>
> It=E2=80=99s quite possible there=E2=80=99s a bug in my implementation bu=
t before I try the
> same operations with libbpf directly I=E2=80=99d really appreciate a sani=
ty check
> that I=E2=80=99m using BPF Token in the correct way first.
>
> TL;DR
>
> If I create a bpffs in the init user ns, then bind mount it into a userns=
,
> will BPF Token work?
>
>

No, it won't. Also note that we currently disallow creating BPF token
in root userns.

> Thanks in advance,
>
> -- Dave
>
>

