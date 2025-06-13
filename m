Return-Path: <bpf+bounces-60594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EFEAD8526
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 10:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A787188E3C3
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 07:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C172DA75D;
	Fri, 13 Jun 2025 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkL1+33J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238F22DA752;
	Fri, 13 Jun 2025 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749801404; cv=none; b=nL/4dR3CFEMT4BlGagoJOE9+Ig/fuBus5uRx0SLwR3kOBOqdFHM5DZsrWFuNor+tG2SuDj3IHsbh+ZX6iQUlUY4diCbqAULX2eD6EndMjCkrHcHM9Yz0rkUpnidt4YZugblCwvbKQzkL4Ws8bw1Ojkw1mzCeQdXLU4S6zNCFTbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749801404; c=relaxed/simple;
	bh=cJwIY7LeFlkdqM3q5CBcb7DUXVjGRhCEix/XOSYGtM4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nOhEx7FStaRldHETwfmcf8H3MyF4kEq+GT+fZd+gjK/6x0TaeL163AK/oJ0cy6kHez8jca8CP7aQxg1uT1i3SJ1QkcKwA9ffDHcqT0KxjEksfo18n5S3dgXayQv/MV25q7xyjcj99hs+h70qFAnQp2Jx6kQ/ddM1Bly55S1pYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkL1+33J; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-236470b2dceso17319225ad.0;
        Fri, 13 Jun 2025 00:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749801402; x=1750406202; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSwG/HIIRb5Ru+o8dgoFYjJtj1lPDuEQqm8MMK/oXl4=;
        b=EkL1+33JRmbfKwJ+JmB4XYCkJI4pNunsu33RVQDKbL8q5Wb1squRZnCMUpRjZ5i0pz
         Qfph2tBRW7s0jhYjXgi0jCNwHKlc3bbCPiYFuW/azbXcdX01JezlSOWNRfXVWpHFzHMS
         kuAhicwe/f/lbc25M/eWM8LG+TOLWuDQX041492hl66BhsGlA9xeSMWyPDaj2d/rWnZw
         HXsJccV6IqrhZkrlLdENnxPjh/GpO1LQsOGuDhnlz6HgLxVD4pJFfr0y7OjnwYfGAJnc
         n1LWFDuaJTOohn27V5lXuMbih/61eibzjYz2R2a0KuqsxxHAxd4ibrbeISgJhqRAgYQo
         0zdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749801402; x=1750406202;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NSwG/HIIRb5Ru+o8dgoFYjJtj1lPDuEQqm8MMK/oXl4=;
        b=U7oG54xFvZrWG7l5hIfItJJE+lmuDFcCvgeAAfhkNTo0CRFY2wShcIMAvCsI2Q1Cg9
         VJDzS1a/e/kjb7fDDUeeCI6CwkeBXLzerh/bztdeezCewOZ+F4EezSbIIgwBUxVcP7wC
         pU/4iCq3Y/jEPPReTrWjwzuXHMINNsU8oHcHY8NkFOUleXH+s+xoxiZIRPBtWS7UszUC
         Y3bNOxzlduCqx4b9b0n6nQQj0uS1sxXx4lHfdthCq6b7TxL8hJEz9NHvg9QqybNISttN
         24yr+mLQpPwq4NJc1ct030Likv+sW5no7VBYnJ54Gr49chovnCYs6mJrOZbQQ+/EH4S6
         SrPg==
X-Forwarded-Encrypted: i=1; AJvYcCU1GsEriLWxSkqdcF2WiqCk7rCBtx6mWPD5UnErBZ6fJIDzThvm7jUWf2x2UtPCUVlXOxGlbN1Q@vger.kernel.org, AJvYcCWtZK/EtDRHdQtwbfubSLsUNIEvqd0Okj1VB4ZN0cgFoD2AxPumBOzBsP7w2I8V5zuGxYDZ9WfUhWxebZa7@vger.kernel.org, AJvYcCXOSVMjrazvHZLFjydTqkcZP0Zzs/TQQJbu3vejUULs4c+w9w7zhTmfYpW6Q+mefzQfZqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8jViKUY5ZzKDGxndXQa8gYSvxCyWddcsyAfrGFaJAmOmXR7+Q
	ldHS6s7d7l2eplFVFpppjxguqs12/Dnj6k9tTXuV7A4RnFnXem7ykC6k
X-Gm-Gg: ASbGncupbnCMdrbUaMAB6Sv0Nig9NrIx1O+6jODWAeiSJ04iSCOKS2d3lvfVWGGLwq7
	HRACmgQro6ZObBB7NCzTbwv2km+CN0mpf93Nu71vn5euIoUWVhoYpO0UytSrZSfZozIgtQKcAXe
	iR9htT1w/NjQR+OAuP0cYUxHLqZXwkmlz5WgIJeRgP3v1aT6HLsPdEKAn8qLOLnNcnopVYKLNDU
	qWQRI/MC3iqwYpc8rDr9J1QHhFqOErdeiv5Ka4+rvfhEZvB3lu8nc5RWuFcQHJe6w/eU8T/1rJ2
	x0lvBBbjH3n0v/mswC5GIpLNU2vYMEGi2tDwORLXQ7N2SZ/DiVDy4nyFYQk=
X-Google-Smtp-Source: AGHT+IHEyrz/ILDe7jbPjp6tJmahDSX4yonGX0uC2t43TAZnuhuFxHsNqcfzDcBA7S2p5LMYscMdKg==
X-Received: by 2002:a17:902:c94a:b0:234:ef42:5d65 with SMTP id d9443c01a7336-2365dd4028bmr30650795ad.52.1749801402274;
        Fri, 13 Jun 2025 00:56:42 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88be1fsm8920275ad.8.2025.06.13.00.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 00:56:41 -0700 (PDT)
Message-ID: <3c89e1105e611812ae86fb6aafd346be4445e055.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING in do_check
From: Eduard Zingerman <eddyz87@gmail.com>
To: syzbot <syzbot+a36aac327960ff474804@syzkaller.appspotmail.com>, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, 	sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com, 	yonghong.song@linux.dev
Date: Fri, 13 Jun 2025 00:56:39 -0700
In-Reply-To: <684bcf65.050a0220.be214.029b.GAE@google.com>
References: <684bcf65.050a0220.be214.029b.GAE@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-06-13 at 00:12 -0700, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    1c66f4a3612c bpf: Fix state use-after-free on push_stack(=
)..
> git tree:       bpf-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1346ed7058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D73696606574e3=
967
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Da36aac327960ff4=
74804
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e0775=
7-1~exp1~20250514183223.118), Debian LLD 20.1.6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1392610c580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11a9ee0c58000=
0
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2ddb1df1c757/dis=
k-1c66f4a3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6a318fc92af0/vmlinu=
x-1c66f4a3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/76c58dddcb6c/b=
zImage-1c66f4a3.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+a36aac327960ff474804@syzkaller.appspotmail.com
>=20
> ------------[ cut here ]------------

Fwiw, here is a repro converted to selftest.
I'll take detailed look on Friday:

SEC("socket")
__naked void syzbot_repro(void)
{
        asm volatile (
        "r8 =3D 0xff80;"
        "r1 =3D 0xff110001085a0800 ll;"
        "r2 =3D 20;"
        "r3 =3D 0;"
        "call %[bpf_ktime_get_ns];"
"1:"
        "w9 =3D w10;"
        "if r9 >=3D 0xff4ad400 goto 2f;"
        "may_goto +13;"
        "r2 =3D 0;"
        "*(u8 *)(r10 -16) =3D r9;"
"2:"
        "if r9 s< 0x1004 goto 3f;"
        "lock *(u32 *)(r10 -16) +=3D r10;"
        "r6 =3D r8;"
        "r8 +=3D -8;"
        "r4 =3D r10;"
"3:"
        "r6 +=3D -16;"
        "r2 =3D 8;"
        "r2 =3D 0xff110001085a05d8 ll;"
        "r5 =3D 8;"
        "if w8 & 0x76 goto 1b;"
        "r8 =3D r9;"
        "if w8 !=3D 0x0 goto +0;"
        "call %[bpf_get_prandom_u32];"
        "r0 =3D 0;"
        "exit;"
        :
        : __imm(bpf_get_prandom_u32),
          __imm(bpf_ktime_get_ns)
        : __clobber_all);
}

[...]

