Return-Path: <bpf+bounces-53318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA45A50088
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BE901894AFB
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 13:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FC424887F;
	Wed,  5 Mar 2025 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mU8M+p4Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0AD2E3396;
	Wed,  5 Mar 2025 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741181312; cv=none; b=Wwm450X1vvnfBLE48zk+5YII70A6CFhHbsXsmg/lMn1xxwR+6K/YC8KPIc7Ey4W9fY+LaHJ3GT0zJFn45SfKoXN2z+WEiQEXnEvhOewv3zMz22R/++7DJhZZrk3nfbQxW4Q7QhpCdnCI4be/d672OX33wB2j4VRJeLCQyGHNG0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741181312; c=relaxed/simple;
	bh=rGBj7dVt1RavRkxRS63LNUf7YDov3xjEg/AcTR1w6FI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hd0O7GFZ0DnNvCOt+gxrkbtuv2iacF8iM0VuFk74zSRmEWzY4XxMEuqj4SdnjqSlsz4cGmK1AzA/QW6FgqXBCBQcdajKl2tGHmS72LSRxU3wkDqD0Y5SkVb6A2GKmwVkplhsx7dpcGYySSKNaqe0x5RpDFemQW+V1k0molf7S68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mU8M+p4Y; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2b8e26063e4so3476285fac.3;
        Wed, 05 Mar 2025 05:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741181309; x=1741786109; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I+wI51ktHcqEkDfOx1x2HQqCQFm9fi/Gjngxq8wZXFI=;
        b=mU8M+p4YFJL/Qmd2MKp78lfvdvABpeWaGMWYNCCeB+bgz7yV0HvloHTUOWMhL9e4kA
         mQAxcjX3Pft04F9SODkGoERR7xBzd52Gc7qjr0aSae7HyFZo6e6KpkY85t3csbi7+elQ
         yUk/gMX2hDJiq95obfboifYiim9Cp9P1Nx1Be0/QalOZfBRvcQBetUwoehREFTT24u48
         XViV34ny6Pj2g+33CDlCxCVNnuqWbbosU9jX+LSTpZQ9i5u6hC+C+E7W8UTNwK1VN8SC
         mOOEVuIShD+2wtQk7TBXEf+/1wWp6Afk1Rs1FOVCLcVf47RxI0JZ06hDvdX/LJI1EHUI
         LVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741181309; x=1741786109;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+wI51ktHcqEkDfOx1x2HQqCQFm9fi/Gjngxq8wZXFI=;
        b=r4CEydemXqJorv65TcCkjwnuXgkRSU5usa3Xt14nCuV8f3JUfUm89LfI3N6ypvLUBy
         QIB0LbuHsBM49RTuwJIXwj2+0wI4YhLd/tiVPcyo2pC1CduJePya8Umrei54IRsCdzNI
         F22lQG0Rd/saW2RWNalAwqB5KZVpnX9LgkQRH/X1bEZL0JffQtxALzVmk8Ifhe8JFiZ6
         ypCXPH+BatNRe6w9IInqmME9vrdCf4r0jka8cef+4kJ9AOpWyw/abcGPhKd+fswQAvMM
         fkHZ+6knXU3VQJ2i6Ddvd87HqTmQeeJrtu/6ZPuTeB2lwik0+OHXevs5Ztb/IN/gy6bj
         m1mg==
X-Forwarded-Encrypted: i=1; AJvYcCVKZn2C0ofhHk+cKaPTeJtgDmy8ZOFrnB8u2mK9vRTp6ndAuZ/XY7Mmd43DyBkLpZzCvVWEh2DU59IYQ7Gb@vger.kernel.org, AJvYcCVrdzrw4b4DD1zOPIwBeUrAgoloUuFxhvMklLw6ahRcoJmiKdIUc1LTRU/tXaXUXw6Magw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrhxzFTisiT+WRp27PECFtB9Uo6P3oCqDeBoytPmSp/HsT6e9W
	qPlYILqycH1TXMRQfPBcVd2QQi5vaBcRhc9za+ZProF8vFkeCpaskN9U23FRinfWvXJL3EEFeaj
	ZBzYv4HalTn8kN7aPT3vg8Loyv3Y=
X-Gm-Gg: ASbGncueblSZ+HkirJ51gO2wEt4dvSpVY0Ij+HM9iGfem/EFNhTorQzUqQ51ZjkVfXq
	g59GmMcesRTVYIMdeOzEONAYZopNLcqrwoAQUiEFWFFO1EHUkmVpcUfas/USi4BXDp+1i8KKxeN
	Wcczih2yXf6FffeKkZfsHpW09NMQ==
X-Google-Smtp-Source: AGHT+IH7Nt1CQ0iMhn63GtgT65QKf4iagQkRDjyWf7VmXU3pa/zuehd9xh31N3d1H/7+79SeQ9iCKL7VfAN+rJlnos4=
X-Received: by 2002:a05:6870:d186:b0:2bc:9197:3508 with SMTP id
 586e51a60fabf-2c21ce437c4mr1776731fac.34.1741181309225; Wed, 05 Mar 2025
 05:28:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Strforexc yn <strforexc@gmail.com>
Date: Wed, 5 Mar 2025 21:28:18 +0800
X-Gm-Features: AQ5f1JoH5OoaXA590z8B2G25EL7HVufkT02Ea02mEzBuP0tewUQxl_KsV2GBpbc
Message-ID: <CA+HokZqeQsYkLeyrwaJK-T8ngXDO207_QuuZX2G8AbWFuvYG-A@mail.gmail.com>
Subject: =?UTF-8?Q?=5BBUG=5D_list_corruption_in_=5F=5Fbpf=5Flru=5Fnode=5Fmove_=28=29_=E3=80=90_?=
	=?UTF-8?Q?bug_found_and_suggestions_for_fixing_it=E3=80=91?=
To: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maintainers,

When using our customized Syzkaller to fuzz the latest Linux kernel,
the following crash was triggered.
Kernel Config : https://github.com/Strforexc/LinuxKernelbug/blob/main/.conf=
ig

A kernel BUG was reported due to list corruption during BPF LRU node moveme=
nt.
The issue occurs when the node being moved is the sole element in its list =
and
also the next_inactive_rotation candidate. After moving, the list became em=
pty,
but next_inactive_rotation incorrectly pointed to the moved node, causing l=
ater
operations to corrupt the list.

Here is my fix suggestion:
The fix checks if the node was the only element before adjusting
next_inactive_rotation. If so, it sets the pointer to NULL, preventing inva=
lid
access.

diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index XXXXXXX..XXXXXXX 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -119,8 +119,13 @@ static void __bpf_lru_node_move(struct bpf_lru_list *l=
,
  * move the next_inactive_rotation pointer also.
  */
  if (&node->list =3D=3D l->next_inactive_rotation)
- l->next_inactive_rotation =3D l->next_inactive_rotation->prev;
-
+ {
+ if (l->next_inactive_rotation->prev =3D=3D &node->list) {
+ l->next_inactive_rotation =3D NULL;
+ } else {
+ l->next_inactive_rotation =3D l->next_inactive_rotation->prev;
+ }
+ }
  list_move(&node->list, &l->lists[tgt_type]);
 }

--=20
2.34.1

Our knowledge of the kernel is somewhat limited, and we'd appreciate
it if you could determine if there is such an issue. If this issue
doesn't have an impact, please ignore it =E2=98=BA.

If you fix this issue, please add the following tag to the commit:
Reported-by: Zhizhuo Tang strforexctzzchange@foxmail.com, Jianzhou
Zhao xnxc22xnxc22@qq.com, Haoran Liu <cherest_san@163.com>

Last is my report=EF=BC=9A

 vmalloc memory
list_add corruption. next->prev should be prev (ffffe8ffac433e40), but
was 50ffffe8ffac433e. (next=3Dffffe8ffac433e41).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:29!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 14524 Comm: syz.0.285 Not tainted
6.14.0-rc5-00013-g99fa936e8e4f #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
RIP: 0010:__list_add_valid_or_report+0xfc/0x1a0 lib/list_debug.c:29
Code: 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 a6 00 00 00
49 8b 54 24 08 4c 89 e1 48 c7 c7 c0 1f f2 8b e8 55 54 d3 fc 90 <0f> 0b
48 89 f7 48 89 34 24 e8 16 54 33 fd 48 8b 34 24 48 b8 00 00
RSP: 0018:ffffc900033779b0 EFLAGS: 00010046
RAX: 0000000000000075 RBX: ffffc900035777c8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffe8ffac433e40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffe8ffac433e41
R13: ffffc900035777c8 R14: ffffe8ffac433e49 R15: ffffe8ffac433e50
FS:  00007fef15ddd640(0000) GS:ffff88802b600000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd53abb238 CR3: 00000000296f4000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_add_valid include/linux/list.h:88 [inline]
 __list_add include/linux/list.h:150 [inline]
 list_add include/linux/list.h:169 [inline]
 list_move include/linux/list.h:299 [inline]
 __bpf_lru_node_move+0x21a/0x480 kernel/bpf/bpf_lru_list.c:126
 __bpf_lru_list_rotate_inactive+0x20f/0x310 kernel/bpf/bpf_lru_list.c:196
 __bpf_lru_list_rotate kernel/bpf/bpf_lru_list.c:247 [inline]
 bpf_percpu_lru_pop_free kernel/bpf/bpf_lru_list.c:417 [inline]
 bpf_lru_pop_free+0x157/0x370 kernel/bpf/bpf_lru_list.c:502
 prealloc_lru_pop+0x23/0xf0 kernel/bpf/hashtab.c:308
 htab_lru_map_update_elem+0x14c/0xbe0 kernel/bpf/hashtab.c:1251
 bpf_map_update_value+0x675/0xf50 kernel/bpf/syscall.c:289
 generic_map_update_batch+0x44a/0x5f0 kernel/bpf/syscall.c:1963
 bpf_map_do_batch+0x4be/0x610 kernel/bpf/syscall.c:5303
 __sys_bpf+0x1002/0x1630 kernel/bpf/syscall.c:5859
 __do_sys_bpf kernel/bpf/syscall.c:5902 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5900 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5900
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcb/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fef14fb85ad
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fef15ddcf98 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fef15245fa0 RCX: 00007fef14fb85ad
RDX: 0000000000000038 RSI: 0000400000000000 RDI: 000000000000001a
RBP: 00007fef1506a8d6 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fef15245fa0 R15: 00007fef15dbd000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid_or_report+0xfc/0x1a0 lib/list_debug.c:29
Code: 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 a6 00 00 00
49 8b 54 24 08 4c 89 e1 48 c7 c7 c0 1f f2 8b e8 55 54 d3 fc 90 <0f> 0b
48 89 f7 48 89 34 24 e8 16 54 33 fd 48 8b 34 24 48 b8 00 00
RSP: 0018:ffffc900033779b0 EFLAGS: 00010046
RAX: 0000000000000075 RBX: ffffc900035777c8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffe8ffac433e40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffe8ffac433e41
R13: ffffc900035777c8 R14: ffffe8ffac433e49 R15: ffffe8ffac433e50
FS:  00007fef15ddd640(0000) GS:ffff88802b600000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd53abb238 CR3: 00000000296f4000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Regards,
Strforexc

