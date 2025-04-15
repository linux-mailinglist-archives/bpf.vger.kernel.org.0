Return-Path: <bpf+bounces-56015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FEAA8AC03
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 01:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 974AD7A810D
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 23:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D80A2D8DC1;
	Tue, 15 Apr 2025 23:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDZKXGII"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318552D8DA3;
	Tue, 15 Apr 2025 23:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759352; cv=none; b=BoSTYxED4TAFK1wn6qflD4pHofu3bNLrS+EPG3iFBgIh2Axi1eeSaKXVBFZ20H2AeWKhp9W3fIok0kxXdlUnJNwrtCTVDftw2TdzAeG+kDLAarwF6idj2Wn4tO1+2UfewZVtUz95AS9F/xmlITQ2xnU9iScnJWqszM9DN6vwOs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759352; c=relaxed/simple;
	bh=h0R5L6nVvByYez5eHmbu8mdtkQsLFhJhqXTOtvcyBAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANbJmiqqNJR780s2vfxS7h6yNctaI1Jd8/xfgYz7h+SkAdFamIuYXXCiF5f/TtfAlQuyg0IlBX4Gf9SxSHhiG+NSaKTbpjxd249CDPl3vNCYDbuq+CfqQfQDSd3ThfBItPUnavM4pHUUdLl2GyxrCWPjqZwTwJ03hepgEetXjIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDZKXGII; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b03bc416962so4305975a12.0;
        Tue, 15 Apr 2025 16:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744759350; x=1745364150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OD+viivAmrV9Ri8tXcGexdXaVsd+qYre9jyq6k6JI+s=;
        b=iDZKXGIIDp0QdbreRLOwMpP5bdpdNZh5JL8Z4JWjyFkSnrCDYDuNyPogJbYBSfaLcF
         vRMDsuHazPGgUaa2EwUA1s4rtCVZ20SGYE9ZhPoOHMkwRZGF9+oqJt3qIT9KsNjeSYIH
         cEXd0teJL5pBMRDX8roXcYAAI3ox8EKZ7kWkfbqzxIsI9ayj6qXOY462DkyHsBX9Be7K
         a7Op0mI3C9SF6wDlWRCTPUAJKW956INNRWctdFbULdDhwjExpsYBbVy2m8tqo0V8UKQa
         gCglnvl8DWSUxKPSn6YfzSXE2Dggz+AEAZaUb6oKJgE1570KYKnUavyNfUWRD59cjDow
         WMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744759350; x=1745364150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OD+viivAmrV9Ri8tXcGexdXaVsd+qYre9jyq6k6JI+s=;
        b=axGkY02Dobhhc4km3gsSK7kY7FUds94cXY7I411GEvPhElGBO2O8Q0O39Aw7NQGbkj
         F//bQRPZ0J4DhV1JuR5CldZwBlxQ4U5Arbs+4TV2FkraAG4jhubKM2YvlauRynj2bzyB
         YU5uno/kIJDKJ9EDz31rhj/MKPnRsULwvRwKeVxvwbXcqj3QrLjuyzO/nwuZIiH59aFF
         HLJxW5dYDvlQh8D1IAHHlkblaTkzb5n16ejy5N7KSc91Bt46Irh6spY2Msr+vqUvy+03
         WxtmouECSVfy0nTQkKqmmmElbohv3NaEkJtXgaUEDbFVUxYGCn7cTjWSq8VlU9rqBwfh
         fCtg==
X-Forwarded-Encrypted: i=1; AJvYcCUJq/oWpomfA0C7aawQzGPHoad+S9DgVQpp0zI8tcjuz4lngRHtEPowqQCPq1RDssChK5C0hVAhBZC49Ig=@vger.kernel.org, AJvYcCVyRk995dO0JqnGiEJkib8tUjnSPaq5USgaKFqIsYWGxgP92VHhdnyq6OZWub4/7xWvn3ithz3fmyDiIw==@vger.kernel.org, AJvYcCWEFDamiVrs4L2zjE6Z8P22GkM5Nl26i6oFUTK+HLwNtUXQ+9hVWh80wPjofYZuigzKF3YzdS0H@vger.kernel.org
X-Gm-Message-State: AOJu0YwG0dP2WNSVJ37d+IbdHIi16WLtuXGPerCGp4W/aWF2BN0BEWAx
	n4/6fxgdpXpJmFHX/F0OFWAhC3l/eZnTqBVAogElOe58VQpW7+k/00YuGp0KRDeuRXWxcsJTeyE
	de5HSZy0IQQCfKduzORvjDaFBgTU=
X-Gm-Gg: ASbGncuTxP7qDhRmF2OWmM5sSL8lPU0HZj6CHVrMaSZVz6Bub/qjAXnLbQwDza/3fDY
	PakeNBxf+52giPy64yXIdtm3BvXnX8L2fASQkCUMuyyS6HwiUScHoYQ75aeHw+Di95pbqbnqNg7
	E//zaeJE+y0FCDkTRlhrqHXDia4Bvivicn6KkpuA==
X-Google-Smtp-Source: AGHT+IFQsC/LtlCHl7jX6jCGG1cUKpJ83xO1W3hXxizLj/9OZJRvgT/SxBeX8k1UK5SbPpc6U6ToeYujQXggHIyGXiA=
X-Received: by 2002:a17:90b:58c3:b0:2ff:702f:7172 with SMTP id
 98e67ed59e1d1-3085efeadd5mr1689216a91.33.1744759350389; Tue, 15 Apr 2025
 16:22:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c9816983-7162-47e6-8758-2daaa8c8ccc3@linux.ibm.com> <d79d19b3-8dc5-4d2c-900e-a273ce317e24@linux.ibm.com>
In-Reply-To: <d79d19b3-8dc5-4d2c-900e-a273ce317e24@linux.ibm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 15 Apr 2025 16:22:18 -0700
X-Gm-Features: ATxdqUHDtDXg02nyYEfqX04Fjl1FO8dOnsI6GySbXtdgeBeUPsKA4XM8rGso4Mg
Message-ID: <CAEf4BzbiP2RY1FyRtCJBcmC6_ngjSFua_Vt0zAcZ=AGc-u_7aw@mail.gmail.com>
Subject: Re: [mainline]Kernel Warnings at kernel/bpf/syscall.c:3374
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, Saket Kumar Bhaskar <skb99@linux.ibm.com>, 
	Hari Bathini <hbathini@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, linux-next@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 9:51=E2=80=AFPM Venkat Rao Bagalkote
<venkat88@linux.ibm.com> wrote:
>
> + LKML, netdev
>
> On 10/04/25 10:17 am, Venkat Rao Bagalkote wrote:
> > Hello!!
> >
> >
> > I am observing below kernel warnings on IBM Power9 server, while
> > running bpf selftest on mainline kernel.
> >
> > This issue never seen before good commit[1], and seen intermetently
> > after bad commit[2], and this is not reproducible everytime.
> >
> > So likely issue got introduced b/w these two commits.
> >
> > [1]GoodCommit: 7f2ff7b6261742ed52aa973ccdf99151b7cc3a50
> > [2]Bad Commit: 08733088b566b58283f0f12fb73f5db6a9a9de30
> >
> >
> > Traces:
> >
> >
> > [34208.591723] ------------[ cut here ]------------
> > [34208.591738] WARNING: CPU: 9 PID: 375502 at
> > kernel/bpf/syscall.c:3374 bpf_tracing_link_release+0x90/0xa0

This seems to be due to an error returned from
bpf_trampoline_unlink_prog(), which can happen for a multitude of
reasons. If you can reproduce this reasonably easily, it would be nice
if you can help understand where exactly it's coming from. You could
try using retsnoop ([0]) for this. Or bpftrace, if you can't use
retsnoop for some reason.

  [0] https://github.com/anakryiko/retsnoop

> > [34208.591750] Modules linked in: bpf_testmod(OE) 8021q(E) garp(E)
> > mrp(E) vrf(E) tun(E) rpadlpar_io(E) rpaphp(E) vfat(E) fat(E) isofs(E)
> > ext4(E) crc16(E) mbcache(E) jbd2(E) nft_masq(E) veth(E) bridge(E)
> > stp(E) llc(E) overlay(E) bonding(E) nft_fib_inet(E) nft_fib_ipv4(E)
> > nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E)
> > nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) rfkill(E)
> > ip_set(E) mlx5_ib(E) ib_uverbs(E) ib_core(E) mlx5_core(E) mlxfw(E)
> > psample(E) tls(E) ibmveth(E) pseries_rng(E) sg(E) vmx_crypto(E) drm(E)
> > fuse(E) dm_mod(E) drm_panel_orientation_quirks(E) xfs(E) lpfc(E)
> > nvmet_fc(E) nvmet(E) sr_mod(E) sd_mod(E) cdrom(E) nvme_fc(E)
> > nvme_fabrics(E) ibmvscsi(E) nvme_core(E) scsi_transport_srp(E)
> > scsi_transport_fc(E) [last unloaded: bpf_test_modorder_x(OE)]
> > [34208.591838] CPU: 9 UID: 0 PID: 375502 Comm: test_progs-no_a
> > Tainted: G        W  OE       6.15.0-rc1-ga24588245776 #1 VOLUNTARY
> > [34208.591848] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MO=
DULE
> > [34208.591852] Hardware name: IBM,8375-42A POWER9 (architected)
> > 0x4e0202 0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
> > [34208.591857] NIP:  c00000000049c830 LR: c00000000049c7cc CTR:
> > 0000000000000070
> > [34208.591863] REGS: c00000000eb07a60 TRAP: 0700   Tainted: G
> > W  OE        (6.15.0-rc1-ga24588245776)
> > [34208.591869] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR:
> > 84002482  XER: 00000000
> > [34208.591882] CFAR: c00000000049c7d4 IRQMASK: 0
> > [34208.591882] GPR00: c00000000049c7cc c00000000eb07d00
> > c000000001da8100 fffffffffffffff2
> > [34208.591882] GPR04: 0000000000014ed8 c00000103965d480
> > c0000003415ca800 c0000000b247c900
> > [34208.591882] GPR08: 0000000000000000 0000000000000000
> > c0000000b247c900 0000000000002000
> > [34208.591882] GPR12: c00000000eb078a8 c000000017ff5300
> > 0000000000000000 0000000000000000
> > [34208.591882] GPR16: 0000000000000000 0000000000000000
> > 0000000000000000 0000000000000000
> > [34208.591882] GPR20: 0000000000000000 0000000000000000
> > 0000000000000000 0000000000000000
> > [34208.591882] GPR24: 0000000000000000 0000000000000000
> > 0000000000000000 c0000003893d6780
> > [34208.591882] GPR28: c00000000369a6a0 0000000000000fa4
> > c00000000135d988 c0000000c224bf00
> > [34208.591945] NIP [c00000000049c830] bpf_tracing_link_release+0x90/0xa=
0
> > [34208.591953] LR [c00000000049c7cc] bpf_tracing_link_release+0x2c/0xa0
> > [34208.591960] Call Trace:
> > [34208.591963] [c00000000eb07d00] [c00000000049c7cc]
> > bpf_tracing_link_release+0x2c/0xa0 (unreliable)
> > [34208.591973] [c00000000eb07d30] [c00000000049c614]
> > bpf_link_free+0x94/0x160
> > [34208.591981] [c00000000eb07d70] [c00000000049c780]
> > bpf_link_release+0x50/0x70
> > [34208.591989] [c00000000eb07d90] [c0000000006ee75c] __fput+0x11c/0x3c0
> > [34208.591997] [c00000000eb07de0] [c0000000006e46bc] sys_close+0x4c/0xa=
0
> > [34208.592003] [c00000000eb07e10] [c0000000000325a4]
> > system_call_exception+0x114/0x300
> > [34208.592012] [c00000000eb07e50] [c00000000000d05c]
> > system_call_vectored_common+0x15c/0x2ec
> > [34208.592020] --- interrupt: 3000 at 0x7fff9c40d8a4
> > [34208.592030] NIP:  00007fff9c40d8a4 LR: 00007fff9c40d8a4 CTR:
> > 0000000000000000
> > [34208.592035] REGS: c00000000eb07e80 TRAP: 3000   Tainted: G
> > W  OE        (6.15.0-rc1-ga24588245776)
> > [34208.592041] MSR:  800000000280f033
> > <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48002886  XER: 00000000
> > [34208.592057] IRQMASK: 0
> > [34208.592057] GPR00: 0000000000000006 00007fffcce2d650
> > 00007fff9c527100 0000000000000066
> > [34208.592057] GPR04: 0000000000000000 0000000000000007
> > 0000000000000004 00007fff9ce5efc0
> > [34208.592057] GPR08: 00007fff9ce57908 0000000000000000
> > 0000000000000000 0000000000000000
> > [34208.592057] GPR12: 0000000000000000 00007fff9ce5efc0
> > 0000000000000000 0000000000000000
> > [34208.592057] GPR16: 0000000000000000 0000000000000000
> > 0000000000000000 0000000000000000
> > [34208.592057] GPR20: 0000000000000000 0000000000000000
> > 0000000000000000 00007fff9ce4f470
> > [34208.592057] GPR24: 0000000010610b6c 00007fff9ce50000
> > 00007fffcce2e098 0000000000000001
> > [34208.592057] GPR28: 00007fffcce2e250 00007fffcce2e088
> > 0000000000000000 0000000000000066
> > [34208.592118] NIP [00007fff9c40d8a4] 0x7fff9c40d8a4
> > [34208.592122] LR [00007fff9c40d8a4] 0x7fff9c40d8a4
> > [34208.592127] --- interrupt: 3000
> > [34208.592130] Code: 4bfffc28 60000000 60000000 60000000 38210030
> > e8010010 ebe1fff8 7c0803a6 4e800020 60000000 60000000 60000000
> > <0fe00000> 4bffffa4 60000000 60000000
> > [34208.592152] ---[ end trace 0000000000000000 ]---
> >
> >
> > If you happen to fix this issue, please add below tag.
> >
> >
> > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> >
> >
> > Regards,
> >
> > Venkat.
> >
>

