Return-Path: <bpf+bounces-65008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AEBB1A703
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 18:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34F777A65EF
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 16:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DE821D3CA;
	Mon,  4 Aug 2025 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdL7rdIN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8C320E717;
	Mon,  4 Aug 2025 16:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754323541; cv=none; b=Z1ejNAIdexBWM+fYQXZf2NDUXkkKRiCMONykXMLby0rp48OJaQADvgLoMJbEc0p2fomFWxWxSWsODYNZEFKN4jvLAcHURVFcGS3dNFLMysguC/vtA7uYoEpYMu2q9HnfSEC3hc0vJ0gVDz3o7U1IXiXi8Xoz9UMY17Q5ElFjzuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754323541; c=relaxed/simple;
	bh=w6hGYGC3II4i9iuYZbykD/+X28Lmmg0NpPPifNuhPik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kj9dL4Fm3SbMbofmrksuN/8JSkWL9oC7SzLjlXsKOSy/4pT0dCcV/k9IC8kqaWA0SPRLsN1HwATNbSC++2zZLPrDyEQ1I0shkWgNTWX+hK7RW/R2EelZ1ynD+g2bZuMqEcjc8vSOw1RR2l8Iyq5UOo/BP78oZLBQP2QxKtdeAXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdL7rdIN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b7825e2775so3811682f8f.2;
        Mon, 04 Aug 2025 09:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754323536; x=1754928336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7+oeokmlaudv1ps5czXfANuTraCLZZuupDEe37pTYU=;
        b=OdL7rdINsexa6i4UxtkdvIX7F2GbpZ5aThjLZnJPUSX2tVy1EvkgJ8y5uon2QL+XJe
         CvBK4jrvQmYnWQ9+H5XOUaBulJZdqMuhMthST41UAIvILFRiFkfB7ihJpZMNCcwf4+Ol
         A+7aEPZdsaTtxeKSUozKMw0JRQzL8QyOSPlaGWQnHkoYoc02bmg8ZNQZ9YsmmZBYJfGK
         xHrhjnLeJRvepdL6l99N/ReCgJUZNPGXUQmB2L1TpmS6MmP5JAnWqUb6RNw8eoKinPA2
         XD8jMbdoLP4DkSR6YdSai5pdbr+L97t34N5mLRL4qOdu8nHivaLRDjPNaNH2od2mCFNa
         k28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754323536; x=1754928336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7+oeokmlaudv1ps5czXfANuTraCLZZuupDEe37pTYU=;
        b=XiL5d9zDi3ynGiP79LIQ9hedXCqjlzesu2848gp/bWgKJ2Zma7u5eXnZ1V/KYeeQvr
         he0S3oSAXgV+nW76gcwh1XAfXneyEQa5RqS/Z38mx/YqXtdD7GSr6k3ZV5g4LfpngGII
         M3XNlBOgl7tSiWQx23Z+1f/EUs5zIjz7WvQqov4lYxj2o9jEmezLXDf/50PBapzdAA8E
         Lyc/6XgNX3uppZSKNwjt3FjoyZW1aYW2Rbmj6udzqO9Ao/EyuBm2XFz/gdJTVpOfqsCO
         p4cCSZnFPRHa6BObXnumSJQGd8aLsyv11k0Cw2J+V3onlgnVR3sw6Dweq1GwBM0h/El1
         em7A==
X-Forwarded-Encrypted: i=1; AJvYcCUSJzDzgIV0V8gD7Z1tdVmHu8RKbhkDWVQOHm974GwdX/KAwYt/HQp36Rzj6U4q88jGJ2o=@vger.kernel.org, AJvYcCVq39SgdEehkv5oqM2Jcz0uqSUBvy9iWgcGxjux0m3IBf/KCLZfaem/ZBjdtCbsGSpSIaviFnirMlFbLGl3@vger.kernel.org
X-Gm-Message-State: AOJu0YzL9dT6KDnGxWQs2zNBnhlOcUiiBuMYkNQRqLy22mE+ICDAFuy+
	1GSU1qtFOB05dUhcEYF/XT8gnEhL2mHlZZaALbapyUzU5WZLjMKiMM8LkcKt0PQXdlLiR9z9hMU
	zjokD19U+qAiw4hQ9Uv49yOGvtZETRUHCTrW2
X-Gm-Gg: ASbGnctbLINzINb0VdmyCGb4Th5ZioHTWLGiwBcd2g1dwt+NBvIm1RT0zfzwEMCyuCD
	t4XZoxLJ5GMXjwiHFiSX5h1MNvN/bW/GMfo50GUB8ZD8Y1Waf7dlGrScPe5IsotCwCdh9ovAr2t
	3Pa48vYt8XdDDAdCV8RoU7+L4DQrH7Pzt/SSbyIDeIfFmcBcM+YSUwjTGWe6QwGJYqfMWTzM6nO
	dUHgjDcYVWJnCE2r0dtn1eb2GxxlGzbG2kp
X-Google-Smtp-Source: AGHT+IHvowHFKmKbQ+dChrjxFN+0wXZhCpPZg0QXgCMih+bPsO1/WG3RPvsRUQl86mMJEyJd+ODkgasppDI1rQ32+LY=
X-Received: by 2002:a05:6000:1a86:b0:3b7:948a:1361 with SMTP id
 ffacd0b85a97d-3b8d946ad02mr7241822f8f.6.1754323535406; Mon, 04 Aug 2025
 09:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68904050.050a0220.7f033.0001.GAE@google.com>
In-Reply-To: <68904050.050a0220.7f033.0001.GAE@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Aug 2025 09:05:23 -0700
X-Gm-Features: Ac12FXxfBkkCIu9IvjOck4e7jHLqxeFvVBZLLkHntpQxtnfcPiV70EIpFgf8EuQ
Message-ID: <CAADnVQL_OnKvm2-=FxzrFqh5NxWNory09GKX5vT+Qrcj_RuJVA@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING in do_misc_fixups
To: syzbot <syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 10:08=E2=80=AFPM syzbot
<syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    a6923c06a3b2 Merge tag 'bpf-fixes' of git://git.kernel.or=
g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1561dcf058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df89bb9497754f=
485
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Da9ed3d913293985=
2d0df
> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (=
GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D165d0aa2580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D117bd83458000=
0
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/f=
a3fbcfdac58/non_bootable_disk-a6923c06.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9862ca8219e0/vmlinu=
x-a6923c06.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/042ebe320cfd/I=
mage-a6923c06.gz.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> verifier bug: not inlined functions bpf_probe_read_kernel_str#115 is miss=
ing func(1)
> WARNING: CPU: 1 PID: 3594 at kernel/bpf/verifier.c:22838 do_misc_fixups+0=
x1784/0x1ab4 kernel/bpf/verifier.c:22838

This is an odd config with BPF_SYSCALL=3Dy and BPF_EVENTS=3Dn.
One approach to mitigate this is to add a check that fn->func is valid
in get_helper_proto().

