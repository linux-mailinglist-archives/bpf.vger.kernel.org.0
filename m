Return-Path: <bpf+bounces-41163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3676D993A0E
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 00:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F9C1C23E7B
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 22:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8949B18CBE1;
	Mon,  7 Oct 2024 22:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjQZk2TG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A334E1865ED;
	Mon,  7 Oct 2024 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728339500; cv=none; b=TxJLRxIRqcpg+dIzq5Iu0tCxfMftoVJbwcBE/giyBbaaOxrCSMmq1ux9gED8un+SVlgu7sf1lX6AJivv8oPtkEgsHbveW7Lqc9H7x8ZFV8sRAkIjA1YuKmwv/tIIiEXeKT9Olhgre9IpqoEULm4qnMbEeFSHxeyF+LbX0FCYEfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728339500; c=relaxed/simple;
	bh=sC3KyJ5dwliQ0WLK59LNP+zHAObgaZ0x+APBvMZDukA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BRG50KPGXjIU7ruV0rjfkZK/NFyFfrObG862KV/qVnZrDRQSNtwksSBpI6cBepnZcUoC1IGHEpJPa9hoZUCv/28vxboxU/S3fDDTSXh+ywKkpJjHjQm/7MJVePZ2hXsFoWTtnjjrcNMtCkftgWPaie0+5j5uyMuBNPOJTYAGQx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjQZk2TG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20b9b35c7c3so51972625ad.3;
        Mon, 07 Oct 2024 15:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728339498; x=1728944298; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0gNABxy0rUT0bU4IMMnsUy1TKuFw6aYam8xfxXyLF0=;
        b=cjQZk2TG66RF6HDMYgryFdcSDpS4UF2ZaAnp0SepbmIDsLQr9Z3xk1ICEXzxkJSLy1
         +pp0PfY6wRjFfrGQm6IDV+TvQpFecNwAu57vlOIAopSGzntWqVwV+SD5HI/HSvZEuH81
         aS9vRxntDWnwP9PPepInXuMMK1hnB5bGWb+I0AhLu6JUg/ODI9gvVBbr4eT0/MxLCjvN
         D4DiA1tCpzTdrkVyCHXDZaWZXy0qgJxKI8WESAPdBH5qZG/YitarJxjjaO/pkggJvlcD
         4JZ1vDbpptkBHcsXGTUey/hNd5/c+W5iVjDi+X4l9pyKrWdPksxdXU7x/jFeUpF2YqM+
         ocIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728339498; x=1728944298;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F0gNABxy0rUT0bU4IMMnsUy1TKuFw6aYam8xfxXyLF0=;
        b=RJWjl7UgzwniNgy83rUDOyeX75mgvKbGGOGC3ddQNCdqxonKym7fNxNAb5d7cXPjSh
         kQ1uKGIR6cxaa5nmSIxUu7b+XcvGlDGQuztKFNV9egKLG+aHIpADjVf0DqoPjzC0NKw0
         JCcDGyewUyIHDsFZvQptsUZLFUK4D6FQlUET9Z4aLnH+oCHcOTcC/EUitVyiU1YtQCIX
         HjSdZQjR6IUGCTHOGJhqKOjMfB8AbwvnKHkUngRVKzeBmfj+JsrblDEHGHpiRQW45eB8
         NJRo6fQfTp+u9vxFkUHnnvmF2euS2J9eV3tvVXffIjls1vEWUgZa27rh0nkJ5pThpt8V
         sgSw==
X-Forwarded-Encrypted: i=1; AJvYcCUeRbFEk1DctWqEe6HtbB+ulSw9TRAOx1zIJ72wjeQBSnCCSjde5de4i0w6JTrfzUqeTa4=@vger.kernel.org, AJvYcCWip1gOCptG9KX8ZbwY1/Y2UyOocrPT+UPJADDWXH+/1kNx/Qitbhwz/inEUFo4canVwq+kplyo/whdd7v6@vger.kernel.org
X-Gm-Message-State: AOJu0YyE1i77rLnCU3n3uwjOzMWVfMumA9gTqmJLHBhu9+aJMFy8ifZu
	KuUaYYwoy6P3H074t8v3ZfIMFbyKTlWpOjoF66Pf6jtO/V78VJI8
X-Google-Smtp-Source: AGHT+IFRRv+1E9ZHnVx/W3MEPFuZs1gMqlh5PNFQYbZHrW7DmwoJoGQHXtc2xpJOyXd2iIRfP6tsKg==
X-Received: by 2002:a17:903:228f:b0:20b:9fa3:233c with SMTP id d9443c01a7336-20bff04b2c8mr194798405ad.40.1728339497779;
        Mon, 07 Oct 2024 15:18:17 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20a907341sm6049568a91.0.2024.10.07.15.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 15:18:17 -0700 (PDT)
Message-ID: <cfec3ec1b7092e1dde01eb1896ec7fba7ed714f4.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING in push_jmp_history
From: Eduard Zingerman <eddyz87@gmail.com>
To: syzbot <syzbot+7e46cdef14bf496a3ab4@syzkaller.appspotmail.com>, 
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net,  haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org,  linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me,  song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Date: Mon, 07 Oct 2024 15:18:12 -0700
In-Reply-To: <670429f6.050a0220.49194.0517.GAE@google.com>
References: <670429f6.050a0220.49194.0517.GAE@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-07 at 11:35 -0700, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    c02d24a5af66 Add linux-next specific files for 20241003
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1738270798000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D94f9caf16c0af=
42d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D7e46cdef14bf496=
a3ab4
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10b82707980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16f4c32798000=
0

When I try this reproducer the bpf syscall never exits (waited for 5 minute=
s).
Here is the reproducer as a selftest:

SEC("kprobe")
__success
__naked void syzbot_bug(void)
{
	asm volatile (
	"   r2 =3D *(u32 *)(r1 +140)\n"		// 0
	"   r3 =3D *(u32 *)(r1 +76)\n"		// 1
	"   r0 =3D r2\n"				// 2
	"   if w0 > 0xffffff07 goto 1f\n"	// 3
	"   if r3 <=3D r0 goto +16\n"		// 4
	"   exit\n"				// 5
	"1: r6 =3D *(u16 *)(r1 +0)\n"		// 6
	"   r7 =3D r6\n"				// 7
	"2: w7 +=3D 447767737\n"			// 8
	"   if w7 & 0x702000 goto 2b\n"		// 9
	"   w7 &=3D 2024974\n"			// 10
	"   r5 =3D r1\n"				// 11
	"   r7 +=3D r5\n"				// 12
	"   if r7 s> 0x37d2 goto +0\n"		// 13
	"   w3 *=3D w0\n"				// 14
	"   r5 -=3D r7\n"				// 15
	"   r4 =3D r5\n"				// 16
	"   r0 +=3D -458748\n"			// 17
	"   if r3 < r4 goto 3f\n"		// 18
	"   w0 >>=3D w0\n"			// 19
	"3: goto +0\n"				// 20
	"   exit\n"				// 21
	::: __clobber_all);
}

(e.g. can be put to tools/testing/selftests/bpf/progs/verifier_and.c
 or any other verifier_*.c).

Inserting a few printks shows that the following instructions are
verified in a loop:
              =20
           ... verification starts ...
[    2.094272] do_check: env->insn_idx 0
[    2.094345] do_check: env->insn_idx 1
[    2.094417] do_check: env->insn_idx 2
[    2.094486] do_check: env->insn_idx 3
[    2.094585] do_check: env->insn_idx 4
[    2.094675] do_check: env->insn_idx 5
[    2.094748] do_check: env->insn_idx 21
[    2.094879] do_check: env->insn_idx 6
[    2.095005] do_check: env->insn_idx 7
[    2.095074] do_check: env->insn_idx 8 <------ let's call this point LBL
[    2.095156] do_check: env->insn_idx 9
[    2.095264] do_check: env->insn_idx 8
[    2.095372] do_check: env->insn_idx 9
[    2.095497] do_check: env->insn_idx 8
[    2.095579] do_check: env->insn_idx 9
[    2.095716] do_check: env->insn_idx 8
[    2.095892] do_check: env->insn_idx 9
[    2.096070] do_check: env->insn_idx 8
[    2.096151] do_check: env->insn_idx 9
[    2.096314] do_check: env->insn_idx 8
[    2.096402] do_check: env->insn_idx 9
[    2.096570] do_check: env->insn_idx 8
[    2.096646] do_check: env->insn_idx 9
[    2.096840] do_check: env->insn_idx 8
[    2.096921] do_check: env->insn_idx 9
[    2.097040] do_check: env->insn_idx 10
[    2.097113] do_check: env->insn_idx 11
[    2.097195] do_check: env->insn_idx 12
[    2.097417] do_check: env->insn_idx 13
[    2.097521] do_check: env->insn_idx 14
[    2.097597] do_check: env->insn_idx 15
[    2.097688] do_check: env->insn_idx 16
[    2.097774] do_check: env->insn_idx 17
[    2.097866] do_check: env->insn_idx 18
[    2.097990] do_check: env->insn_idx 19
[    2.098050] do_check: env->insn_idx 20
[    2.098119] do_check: env->insn_idx 21
[    2.098195] do_check: env->insn_idx 20
[    2.098347] do_check: env->insn_idx 21
[    2.098414] do_check: env->insn_idx 14
[    2.098556] do_check: env->insn_idx 15
[    2.098629] do_check: env->insn_idx 16
[    2.098700] do_check: env->insn_idx 17
[    2.098767] do_check: env->insn_idx 18
[    2.098842] do_check: env->insn_idx 8
[    2.098984] do_check: env->insn_idx 9
[    2.099108] do_check: env->insn_idx 8
[    2.099171] do_check: env->insn_idx 9
[    2.099304] do_check: env->insn_idx 8
[    2.099368] do_check: env->insn_idx 9
[    2.099505] do_check: env->insn_idx 8
[    2.099568] do_check: env->insn_idx 9
[    2.099703] do_check: env->insn_idx 8
[    2.099774] do_check: env->insn_idx 9
[    2.099921] do_check: env->insn_idx 8
[    2.099984] do_check: env->insn_idx 9
[    2.100133] do_check: env->insn_idx 8
[    2.100200] do_check: env->insn_idx 9
[    2.100349] do_check: env->insn_idx 8
[    2.100413] do_check: env->insn_idx 9
[    2.100503] do_check: env->insn_idx 10
[    2.100566] do_check: env->insn_idx 11
[    2.100636] do_check: env->insn_idx 12
[    2.100813] do_check: env->insn_idx 13
[    2.100909] do_check: env->insn_idx 14
[    2.100972] do_check: env->insn_idx 15
[    2.101047] do_check: env->insn_idx 16
[    2.101117] do_check: env->insn_idx 17
[    2.101185] do_check: env->insn_idx 18
[    2.101250] do_check: env->insn_idx 14
[    2.101389] do_check: env->insn_idx 15
[    2.101462] do_check: env->insn_idx 16
[    2.101531] do_check: env->insn_idx 17
[    2.101598] do_check: env->insn_idx 18

    ... verification repeats from LBL ...

[...]



