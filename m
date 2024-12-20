Return-Path: <bpf+bounces-47405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D52ED9F8D7F
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 08:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277EE16440E
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 07:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C965919FA93;
	Fri, 20 Dec 2024 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BC0A9s8n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D9141C6A;
	Fri, 20 Dec 2024 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734681377; cv=none; b=qP2i/McH244K/LVbqdB/5Dt2e8FgO2zcNsWmjwhw1cRrCO70vxrs4cz6Qu15rjdtf9dy9Zf6TS5X5urxAn4CUOy+xfqu0rvajVai9TUz2zrh42ptnFVvoBgm3xZ2ckP/mb3qssgS+vjTA7svsajmgnc2LakEYz0n9kv1QccHOrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734681377; c=relaxed/simple;
	bh=e4F2m1FFUSwO/OMiUHzHsOW54aum4mUteR+BHX5RlOM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WftDfdcDgQgnLSMyaJ/pSXpQAjBRh1H3fltqPdgCl41L5njucok6zLccEFErLN4TYtv/9QpADf2/oM5g6+DIkr+ypMv/A0bOoTjLlcswOxCVn5BdMd2MF+EMD/lcG71biT8qIykenLfdm4E3G6GvSdiPWT5w7eEKkCn3T05oqpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BC0A9s8n; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-801c081a652so2145340a12.0;
        Thu, 19 Dec 2024 23:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734681375; x=1735286175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cwv6cGXBMSPsqiQk43DsTTbOsw6YSE/MxSGSYva2uIA=;
        b=BC0A9s8nmJno7LRtdgtAGd3ezqlAnTLUIKXvhJv/Ezacw2J+PLGB0RZpTs2LLmDrYA
         WTPEItFQgJauEEBx9Muuz5OGurBi0ChZMUhsbBODNZ7xfIDJSPdnhBoXUBWk112Hq3DM
         22lhd4TR3tPIHDVzk43Yzl9MF1MrNNVsktS+7vFCmtyKgucIOFkNe/smDr0SX26+aWpw
         WTnVz/gP9PnKpajKi8L290i8+PASaW9gNpAxP+UcNGkU1XXBG3CLFJDvjkznyAt6+QZj
         rb6VELRQuHw8d4hBGOIuEeZnNSB0TUBhhoml6DJ+W6GNaNw6olhUgilXX4zWepAlY92i
         JuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734681375; x=1735286175;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cwv6cGXBMSPsqiQk43DsTTbOsw6YSE/MxSGSYva2uIA=;
        b=CENjqLJZhJt6n4AR8GKOLo0Vfz1fhdfwZ/RQ/ZXIfNYB46tET8UljLCRAfx88Lck1Q
         emk1LDCxW87ZZUZWmvhznrQx4Wa6QZ2rtvVOHu1icVuRI8CPhg2DXfTT19VIXrZu8Qon
         WIgaVGH908yB5UCN9JaTXle1SYrmwSCsX4kgTqYia5Lltm7w8EGF3P2vpH8LJRIgguRF
         ZXbtwA/W5C/gqmqZheap0Cm7Ab3rmIKzuywvMlyg8XWcPwOl+5xuGKbwLC0cWyKf4n4r
         fIQBXY0WV+eCwL6bHrs2k+uCijq+5xvmf9BaCtZMIXgP/67FUiXzcRpQYshrrGMaqLq+
         n87w==
X-Forwarded-Encrypted: i=1; AJvYcCU4zkPKIAjgLe2LKzXSh5Uw/7N8GL0hDTX1RpR7FKVULDuDGVisvaLy8buYR/qfEcrrLFgTfKzW@vger.kernel.org, AJvYcCVY+VutI1UgALsVpYiZMgNRzfajLMNYG8rXX//20ZpCrVVhymTLZ7OjFxRzegiSkizh1ZEghxELpWD/TYKw@vger.kernel.org, AJvYcCWXFmmlDbZ4xexltSVZcVPFOs/QGydL1+IhfHbHxI1otNqFfzo2Vi4QUI92g+1snxKUKEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9VTxHvseVHbMWeQTMkptbRS0pR1fO9gbASezRhQKHGuKbUmip
	Eabx4bxD7SQPLjcFzp+v2aJBx6+uFgHFycpjhyi0hE/o1YbKo0Vb
X-Gm-Gg: ASbGncuxF2MvovX5yjL2JxsulhshnLMezH0Ptlp2xz9cZouL3yS03HTkZnC3h+vwMte
	UlzCR//a340jUWQ+l02Ca9ko6ifhqqm4RzjGwadAHkTDwuFHgHs12UYHkqmvhH5YEevCX8hCxrP
	7V2u9iSIe8Gj78mUB3GSOtnZtZjBR3l9ZkEcu4wZX+n9N0PeUWaQwNBSsW+cMq0CAEsBluCIn89
	kvYREculo/7V6ZicIc39RIGje8/SUTUeQAhA0jaw8TN7P2Jzz51smQYkw==
X-Google-Smtp-Source: AGHT+IE6a7wsKwBZ5rvYFGHEGlJeEvek2IxDmYvcsUFoxAsXTenhTxST4UptIvwhBmlczsoynJyy7Q==
X-Received: by 2002:a17:90b:2d4e:b0:2ea:61c4:a443 with SMTP id 98e67ed59e1d1-2f44353f053mr9578296a91.4.1734681375038;
        Thu, 19 Dec 2024 23:56:15 -0800 (PST)
Received: from localhost ([98.97.40.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed82d273sm4574772a91.30.2024.12.19.23.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 23:56:14 -0800 (PST)
Date: Thu, 19 Dec 2024 23:56:12 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Levi Zim <rsworktech@outlook.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <6765231ce87bd_4e17208be@john.notmuch>
In-Reply-To: <87msgs9gmp.fsf@all.your.base.are.belong.to.us>
References: <20241130-tcp-bpf-sendmsg-v1-0-bae583d014f3@outlook.com>
 <MEYP282MB23129373641D74DE831E07E9C6342@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
 <Z0+qA4Lym/TWOoSh@pop-os.localdomain>
 <MEYP282MB2312EE60BC5A38AEB4D77BA9C6372@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
 <87y10e1fij.fsf@all.your.base.are.belong.to.us>
 <87msgs9gmp.fsf@all.your.base.are.belong.to.us>
Subject: Re: [PATCH net 0/2] Fix NPE discovered by running bpf kselftest
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel wrote:
> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
> =

> > Levi Zim <rsworktech@outlook.com> writes:
> >
> >> On 2024-12-04 09:01, Cong Wang wrote:
> >>> On Sun, Dec 01, 2024 at 09:42:08AM +0800, Levi Zim wrote:
> >>>> On 2024-11-30 21:38, Levi Zim via B4 Relay wrote:
> >>>>> I found that bpf kselftest sockhash::test_txmsg_cork_hangs in
> >>>>> test_sockmap.c triggers a kernel NULL pointer dereference:
> >>> Interesting, I also ran this test recently and I didn't see such a
> >>> crash.
> >>
> >> I am also curious about why other people or the CI didn't hit such c=
rash.
> >
> > FWIW, I'm hitting it on RISC-V:
> >
> >   |  Unable to handle kernel access to user memory without uaccess ro=
utines at virtual address 0000000000000008
> >   |  Oops [#1]
> >   |  Modules linked in: sch_fq_codel drm fuse drm_panel_orientation_q=
uirks backlight
> >   |  CPU: 7 UID: 0 PID: 732 Comm: test_sockmap Not tainted 6.13.0-rc3=
-00017-gf44d154d6e3d #1
> >   |  Hardware name: riscv-virtio qemu/qemu, BIOS 2025.01-rc3-00042-ga=
cab6e78aca7 01/01/2025
> >   |  epc : splice_to_socket+0x376/0x49a
> >   |   ra : splice_to_socket+0x37c/0x49a
> >   |  epc : ffffffff803d9ffc ra : ffffffff803da002 sp : ff20000001c3b8=
b0
> >   |   gp : ffffffff827aefa8 tp : ff60000083450040 t0 : ff6000008a12d0=
01
> >   |   t1 : 0000100100001001 t2 : 0000000000000000 s0 : ff20000001c3ba=
e0
> >   |   s1 : ffffffffffffefff a0 : ff6000008245e200 a1 : ff60000087dd04=
50
> >   |   a2 : 0000000000000000 a3 : 0000000000000000 a4 : 00000000000000=
00
> >   |   a5 : 0000000000000000 a6 : ff20000001c3b450 a7 : ff6000008a12c0=
04
> >   |   s2 : 000000000000000f s3 : ff6000008245e2d0 s4 : ff6000008245e2=
80
> >   |   s5 : 0000000000000000 s6 : 0000000000000002 s7 : 00000000000010=
01
> >   |   s8 : 0000000000003001 s9 : 0000000000000002 s10: 00000000000000=
02
> >   |   s11: ff6000008245e200 t3 : ffffffff8001e78c t4 : 00000000000000=
00
> >   |   t5 : 0000000000000000 t6 : ff6000008869f230
> >   |  status: 0000000200000120 badaddr: 0000000000000008 cause: 000000=
000000000d
> >   |  [<ffffffff803d9ffc>] splice_to_socket+0x376/0x49a
> >   |  [<ffffffff803d8bc0>] direct_splice_actor+0x44/0x216
> >   |  [<ffffffff803d8532>] splice_direct_to_actor+0xb6/0x1e8
> >   |  [<ffffffff803d8780>] do_splice_direct+0x70/0xa2
> >   |  [<ffffffff80392e40>] do_sendfile+0x26e/0x2d4
> >   |  [<ffffffff803939d4>] __riscv_sys_sendfile64+0xf2/0x10e
> >   |  [<ffffffff80fdfb64>] do_trap_ecall_u+0x1f8/0x26c
> >   |  [<ffffffff80fedaee>] _new_vmalloc_restore_context_a0+0xc6/0xd2
> >   |  Code: c5d8 9e35 c590 8bb3 40db eb01 6998 b823 0005 856e (6718) 2=
d05 =

> >   |  ---[ end trace 0000000000000000 ]---
> >   |  Kernel panic - not syncing: Fatal exception
> >   |  SMP: stopping secondary CPUs
> >   |  ---[ end Kernel panic - not syncing: Fatal exception ]---
> >
> > This is commit f44d154d6e3d ("Merge tag 'soc-fixes-6.13' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc").
> >
> > (Yet to bisect!)
> =

> Took the series for a run, and it does solve crash, but I'm getting
> additional failures:

Hi Bjorn,

Thanks! I'm guessing those tests were failing even without the patch
though right?

Thanks,
John

> =

>   |  [TEST 298]: (512, 1, 3, sendpage, pass,pop (1,3),ktls,): socket(pe=
er2) kTLS enabled                               =

>   | socket(client1) kTLS enabled                                       =
                                                =

>   | recv failed(): Invalid argument                                    =
                                                =

>   | rx thread exited with err 1.                                       =
                                                =

>   |  FAILED                                                            =
                                                =

>   |  [TEST 299]: (100, 1, 5, sendpage, pass,pop (1,3),ktls,): socket(pe=
er2) kTLS enabled                               =

>   | socket(client1) kTLS enabled                                       =
                                                =

>   | recv failed(): Invalid argument                                    =
                                                =

>   | rx thread exited with err 1.                                       =
                                                                         =
                                                                         =
                 =

>   |  FAILED                                                            =
                                                =

>   |  [TEST 300]: (2, 32, 8192, sendpage, pass,pop (4096,8192),ktls,): s=
ocket(peer2) kTLS enabled                                                =
                                                                         =
                 =

>   | socket(client1) kTLS enabled                                       =
                                                =

>   | recv failed(): Bad message                                         =
                                                                         =
                                                                         =
                 =

>   | rx thread exited with err 1.                                       =
                                                =

>   |  FAILED                                                            =
                                                                         =
                                                                         =
                 =

>   |  ...
>   | #42/ 9 sockhash:ktls:txmsg test pop-data:FAIL                      =
                                                =

>   | ...
>   |  [TEST 308]: (2, 32, 8192, sendpage, pass,pop (5,21),ktls,): socket=
(peer2) kTLS enabled                            =

>   | socket(client1) kTLS enabled                                       =
                                                                         =
                                                                         =
                 =

>   | recv failed(): Bad message                                         =
                                                                         =
                                                                         =
                 =

>   | rx thread exited with err 1.                                       =
                                                =

>   |  FAILED                                                            =
                                                                         =
                                                                         =
                 =

>   |  [TEST 309]: (2, 32, 8192, sendpage, pass,pop (1,11),ktls,): socket=
(peer2) kTLS enabled                            =

>   | socket(client1) kTLS enabled                                       =
                                                =

>   | recv failed(): Bad message                                         =
                                                                         =
                                                                         =
                 =

>   | rx thread exited with err 1.                                       =
                                                =

>   |  FAILED
>   | ...
>   | #43/ 6 sockhash:ktls:txmsg test push/pop data:FAIL                 =
                                                                         =
                                                                         =
                 =

> =




