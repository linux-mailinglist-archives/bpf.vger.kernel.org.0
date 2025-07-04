Return-Path: <bpf+bounces-62408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23FBAF99A0
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 19:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742E13A6EEB
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 17:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DA7285CBB;
	Fri,  4 Jul 2025 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Say9bs4V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75681F30AD;
	Fri,  4 Jul 2025 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751649980; cv=none; b=N+ZszUJwQUY///t2O7I6MlvKJlPBrBP28lUYg8EkIwrJVuf50O3XmhWnR+Oed801x3gpEPZllH/HrDQ54atl+AcAFOiPHYJPk1GrUnoyI71NY9vQgjAeGUrROw63BcNei4IDH/R2XygsJ7+pbVZaUy28TbPQjXBwd7FtENKQ9d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751649980; c=relaxed/simple;
	bh=6w8Jch+CGal6tp097EXOO9iJTFvm4oUl5cQc7yMxYtw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KKKtRVRoUB/LNqPfH/L+O61R0YcFage8j/w5ASeZfAqRSiZDca7l2q2qFKAQ9GetP9nSYzm5dvno9HMqAxlZHV6HpSaUQL73ZdNpD/8NFfhwg0x9hku+bG2BBYMUJmmLvvjYDqyhvhm5yURPv3uMv29CaphJZy3m0KL86qezG20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Say9bs4V; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-236377f00easo14995155ad.1;
        Fri, 04 Jul 2025 10:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751649978; x=1752254778; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8TQkwWm2pAX+sxlRu7VhyoT2lfaopJmQ+d3grkNJeyI=;
        b=Say9bs4V0qQrNR18dilmPbzmAhiGIvTqF//pDMnUCryWTFm4+0yaP79tPer+Kdh5Jn
         8lwx/9GrmnEaFHNgjd2QKlE0rlYaPs8Gx56FzYECg55nFACY+Ij9VBBEObNAneJvg+Va
         EWSk+QxkWdncZSeNG0JJhq58cH/tzPjZ3FUR0CPhizTDNotmzH/s0V8U4kXNbw3jouLm
         kF/Fut+MM+0J+mhW6niCX0U2mLA8lav85ws8QtYY9ZiKfzb7qA/sMGfiEXpuQGaK1ft1
         Xo8klH9rMM7bRktS3w/rHIBEfVobOODKNUfYRExiFuVYb9U7pX1LLPVbDTWNuUt2qYHL
         +VYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751649978; x=1752254778;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8TQkwWm2pAX+sxlRu7VhyoT2lfaopJmQ+d3grkNJeyI=;
        b=Bxo5wEVI1DdwWvi/iaDKnPOqmCk4SZOT3pNekIuBV7kfTIkdM8Hkoyd3gfwTK89Sob
         VSJ2pC6fDo1SzalJU/4t2cpIPCOw9/SitDjKfqj5hI5AlpDZLwIG0eRM/okkBwx0K1Bt
         bC2KjmFOYr+2D86nabwINMqbSI5JLGjUSGyoc3e/JhVFcaTA1w3Zi98jLG35kkdHYFZq
         i4ut5q3WudBIp4w0lxwiyyhfhqb889zGMveKxlN7fAbTZQ8LZvTZF8xi4asUyo29Brqm
         kLXBsfzz0OWQm+xXUQaKgbf1Xn2qC7xvpYRjsQepF20UaRazLk5BpPKspdd0ZbtBKHKJ
         0UKw==
X-Forwarded-Encrypted: i=1; AJvYcCUTNTGJiYtnE92vXtXoRYC0MhuMDZ9a8pwobRYRaNwRIyPp1/qLlYTpkOzZPGi+VQHXMgVG61Kh@vger.kernel.org, AJvYcCUUk1LcdPr09XYXB40dhEGrVCzZls2kEW+lJtJCii5qXDu1FJfTY0k/MeFHOhwIFYKcWbHQxq5YcuF74UnV@vger.kernel.org, AJvYcCVSfJctrxbYFALABkxCjlWPQTLOkCs3V7WytOCcLtubaI+PJTb4k5TWHlnivxWayyx6i/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyak35FoToobU6RHQgZZ+mhm4Nh0vKvHhFIqplPZz39yzrTfo15
	uPuBEms3N6m76KhYFK7acT0cqzjSTRHrQA7BxFP9MCDVWf/2KD+kwO/o
X-Gm-Gg: ASbGncvT1FJTLZTjE0abunOeRRRdQgsZTw2Ayebo4/8mjAFHaC79yDDonAH7tlqlWOF
	H6+FzyAYLaS2y8rcVKzD57QWKIJo8pl1/St1MhI0srWwR3eVSzz1tifl8qZ4nC+9X5kSoyG8NX8
	12Vj3/Zo0HtZnF9wcQKVNJhgzC+mptdrGBhTOCptvMm2NBy6wTP29yaPWBPHippksZ9pUcrUlu0
	MjKyZks5+8BRHIzTIeRcp4LdWCzUsFUKxpGaoySanfnx2Jy4mYgKVeONm1Z99bfC7y48dA2fbNp
	5VJphbDWfS4y4tz4TGeegf4g/UstLJEH7Mgr4IF83HGexAwLT5qDxPLw5w==
X-Google-Smtp-Source: AGHT+IHfE5j1gVzR8dRf3OQCjqJsk0P0OE57zXb6PqfrR3GMThnF3Lv++Zf3UvoEDqRY8BplT+ZWjw==
X-Received: by 2002:a17:903:1a03:b0:234:a139:11fa with SMTP id d9443c01a7336-23c85d9e22emr50608265ad.3.1751649977877;
        Fri, 04 Jul 2025 10:26:17 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431a194sm24375505ad.34.2025.07.04.10.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 10:26:17 -0700 (PDT)
Message-ID: <df2cdc5f4fa16a4e3e08e6a997af3722f3673d38.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING in reg_bounds_sanity_check
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: syzbot <syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com>, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, 	sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com, 	yonghong.song@linux.dev
Date: Fri, 04 Jul 2025 10:26:14 -0700
In-Reply-To: <aGgL_g3wA2w3yRrG@mail.gmail.com>
References: <68649190.a70a0220.3b7e22.20e8.GAE@google.com>
	 <aGa3iOI1IgGuPDYV@Tunnel>
	 <865f2345eaa61afbd26d9de0917e3b1d887c647d.camel@gmail.com>
	 <aGgL_g3wA2w3yRrG@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-04 at 19:14 +0200, Paul Chaignon wrote:
> On Thu, Jul 03, 2025 at 11:54:27AM -0700, Eduard Zingerman wrote:
> > On Thu, 2025-07-03 at 19:02 +0200, Paul Chaignon wrote:
> > > On Tue, Jul 01, 2025 at 06:55:28PM -0700, syzbot wrote:
> > > > Hello,
> > > >=20
> > > > syzbot found the following issue on:
> > > >=20
> > > > HEAD commit:    cce3fee729ee selftests/bpf: Enable dynptr/test_prob=
e_read_..
> > > > git tree:       bpf-next
> > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D147793d=
4580000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D79da270=
cec5ffd65
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc711ce17d=
d78e5d4fdcf
> > > > compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d3=
9e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1594e=
48c580000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1159388=
c580000
> > > >=20
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/f286a7ef49=
40/disk-cce3fee7.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/e2f2ebe1fdc3/=
vmlinux-cce3fee7.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/6e307066=
3778/bzImage-cce3fee7.xz
> > > >=20
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com
> > > >=20
> > > > ------------[ cut here ]------------
> > > > verifier bug: REG INVARIANTS VIOLATION (false_reg1): range bounds v=
iolation u64=3D[0x0, 0x0] s64=3D[0x0, 0x0] u32=3D[0x1, 0x0] s32=3D[0x0, 0x0=
] var_off=3D(0x0, 0x0)(1)
> > > > WARNING: CPU: 1 PID: 5833 at kernel/bpf/verifier.c:2688 reg_bounds_=
sanity_check+0x6e6/0xc20 kernel/bpf/verifier.c:2682
> > >=20
> > > I'm unsure how to handle this one.
> > >=20
> > > One example repro is as follows.
> > >=20
> > >   0: call bpf_get_netns_cookie
> > >   1: if r0 =3D=3D 0 goto <exit>
> > >   2: if r0 & Oxffffffff goto <exit>
> > >=20
> > > The issue is on the path where we fall through both jumps.
> > >=20
> > > That path is unreachable at runtime: after insn 1, we know r0 !=3D 0,=
 but
> > > with the sign extension on the jset, we would only fallthrough insn 2
> > > if r0 =3D=3D 0. Unfortunately, is_branch_taken() isn't currently able=
 to
> > > figure this out, so the verifier walks all branches. As a result, we =
end
> > > up with inconsistent register ranges on this unreachable path:
> > >=20
> > >   0: if r0 =3D=3D 0 goto <exit>
> > >     r0: u64=3D[0x1, 0xffffffffffffffff] var_off=3D(0, 0xfffffffffffff=
fff)
> > >   1: if r0 & 0xffffffff goto <exit>
> > >     r0 before reg_bounds_sync: u64=3D[0x1, 0xffffffffffffffff] var_of=
f=3D(0, 0)
> > >     r0 after reg_bounds_sync:  u64=3D[0x1, 0] var_off=3D(0, 0)
> > >=20
> > > I suspect there isn't anything specific to these two conditions, and
> > > anytime we start walking an unreachable path, we may end up with
> > > inconsistent register ranges. The number of times syzkaller is curren=
tly
> > > hitting this (180 in 1.5 days) suggests there are many different ways=
 to
> > > reproduce.
> > >=20
> > > We could teach is_branch_taken() about this case, but we probably won=
't
> > > be able to cover all cases. We could stop warning on this, but then w=
e
> > > may also miss legitimate cases (i.e., invariants violations on reacha=
ble
> > > paths). We could also teach reg_bounds_sync() to stop refining the
> > > bounds before it gets inconsistent, but I'm unsure how useful that'd =
be.
> >=20
> > Hi Paul,
> >=20
> > In general, I think that reg_bounds_sync() can be used as a substitute
> > for is_branch_taken() -> whenever an impossible range is produced,
> > the branch should be deemed impossible at runtime and abandoned.
> > If I recall correctly Andrii considered this too risky some time ago,
> > so this warning is in place to catch bugs.
>=20
> Hi Eduard,
>=20
> Yeah, that feels risky enough that I didn't even dare mention it as a
> possibility :)
>=20
> >=20
> > Which leaves only the option to refine is_branch_taken().
> >=20
> > I think is_branch_taken() modification should not be too complicated.
> > For JSET it only checks tnum, but does not take ranges into account.
> > Reasoning about ranges is something along the lines:
> > - for unsigned range a =3D b & CONST -> a is in [b_min & CONST, b_max &=
 CONST];
> > - for signed ranged same thing, but consider two unsigned sub-ranges;
> > - for non CONST cases, I think same reasoning can apply, but more
> >   min/max combinations need to be explored.
> > - then check if zero is a member or 'a' range.
> >=20
> > Wdyt?
>=20
> I might be missing something, but I'm not sure that works. For the
> unsigned range, if we have b & 0x2 with b in [2; 10], then we'd end up
> with a in [2; 2] and would conclude that the jump is never taken. But
> b=3D8 proves us wrong.

I see, what is really needed is an 'or' joined mask of all 'b' values.
I need to think how that can be obtained (or approximated).

> >=20
> > > The number of times syzkaller is currently hitting this (180 in 1.5
> > > days) suggests there are many different ways to reproduce.
> >=20
> > It is a bit inconvenient to read syzbot BPF reports at the moment,
> > because it us hard to figure out how the program looks like.
> > Do you happen to know how complicated would it be to modify syzbot
> > output to:
> > - produce a comment with BPF program
> > - generating reproducer with a flag, allowing to print level 2
> >   verifier log
> > ?
>=20
> I have the same thought sometimes. Right now, I add verifier logs to a
> syz or C reproducer to see the program. Producing the BPF program in a
> comment would likely be tricky as we'd need to maintain a disassembler
> in syzkaller.

So, it operates on raw bytes, not on logical instructions?

> Adding verifier logs to reproducers that contain bpf(PROG_LOAD)
> calls seems easier. Then I guess we'd get that output in the strace
> or console logs of syzbot.

The log level 2 might be huge, so it shouldn't be enabled by default.
But not having to modify the reproducer before investigation would be
helpful.

