Return-Path: <bpf+bounces-27252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5B48AB5AE
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 21:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83EEE282A9D
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 19:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B2913C913;
	Fri, 19 Apr 2024 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQDtRDE2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA1A25740;
	Fri, 19 Apr 2024 19:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713555859; cv=none; b=S5BcytYU0y56fEy7adFpU6P7tmioD9kGzYuLDs54a4Za+xXJQv037FX8mXSLlKFUVHWBg9LjW9cljee96ESZIz+HfRp4w6REDsLOlarOz55WzZ87vmL37HW9bJFMWdzvwtH7kLTz2muRm+n3pT26H6yKulGVVLsl0cH7jIFtui4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713555859; c=relaxed/simple;
	bh=FzIGdHEK5ySJlGhteBUxTX1/M8jMaY27GHBdJyGHt2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMOi8j06EyxWH33HKe1HoA69KUKrO7ol3zmwok1mmVfQzBaod0tem/3L+8fdYEJ+gze6/504L0wN0X3jtQOMcJ6yYWE2f1a+1ymoTySWIWX0RN9udm5hCdh+IdNMJTE41QY8UberEwf2oVgBM4W+fv7EENSM22l6AO9xUguQq6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQDtRDE2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-419d320b8abso2967105e9.0;
        Fri, 19 Apr 2024 12:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713555856; x=1714160656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCrxq4t8fwrHzvVr4sA2ZSywiX2Op8XkRZfOXi+I1ZY=;
        b=RQDtRDE24Ts7Ltt/1w+pF74nZB+8Sxt8a+n5h+WROKw3lja94b6XJdTvpJpkUBcwPe
         Qvn+GniihNepfrXGKIq59J8ASNe2VSfnjhjTmtxH/8Y4LZr0uh2Yqgtdh2iOih7lC/FI
         Wsa5SN0+tmhT9mbf5qrfqKdO+a0BB7i5pLeMFgJ18Bp6n9bfccdPKhScFQrcEynO4CUK
         N9aGmMaCmndIfC2PE2UTD4mx/UI+qP41qWJtZ2Ex9Q6oJPcHV107QXLjmXFmdOvWh1Np
         Y6MVq/1wtPD0QwSSKy0EeaASaucq295PdIvI5oTfxK5bFTMwvVu+b+B9EuRIFaYpJAYh
         5J5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713555856; x=1714160656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCrxq4t8fwrHzvVr4sA2ZSywiX2Op8XkRZfOXi+I1ZY=;
        b=MqmDfEXWGVsmEtAhh4gFzrCpvqmYj13mo+EOMh01tUmGBk2A1u2sBH20jj/6DPrxwi
         1I1yMagSQHjdQBEhQYnlhVIE5PWd7g/u0iWDzJvoz7eyJKO3A7cfJ0fBwZ2fW0JYM7qz
         muSp++6WevEsufzLrIqSZxCgIYl04bLUFD+3w6MdHROIpFN0rbLo5jyDyJG/fIjK07VP
         bItufpYGxh3FP+CvzMnjqCPSNdknwuAVSySppvk3GX5ehbUZgjQDBSQ09iuSuGkS8bsI
         WyRA86Fn6nZCgHQ9W7gOMMTaCE8qdA6DAY/NfwWNuBl6c2TPpY5p6+lQETXH2/FziCkT
         fJeg==
X-Forwarded-Encrypted: i=1; AJvYcCX0mmHnjpKMg7XYi0ioxrVoQwpv0YkOuuReZlYoKZyLonqA+cEOBIQ7b9/iMzUj/SQIHq5IQnSKscTnZVHQCZWjM2F4WI2xYzVplnueJWCcKs4pJ8u3QuVBaF9qBrU96Woz
X-Gm-Message-State: AOJu0YwuGmKY0B2ZmxSx8TO/n1pv13gzlcNeSMChmOrjnHir/PiVIoH9
	BKF0Cku9J9DPZBEVCvWQ05M562fZHa/Es/d0NPW0RqB1mJeivDU3m0hzNHa21o4WKU/pcrPdY2u
	qGhspCka9WhEJWSdKVSCw9tTNmZDY+A==
X-Google-Smtp-Source: AGHT+IHqyXgGM32CeAw38kNKNCoXAHTVN/XIPKxUb0SGnHVFWdk9q24RFL0YmWvVm87TG8dRtPxqA8WZKWfYh0H9VO0=
X-Received: by 2002:adf:fed0:0:b0:33e:76d7:a8ad with SMTP id
 q16-20020adffed0000000b0033e76d7a8admr1918657wrs.38.1713555855620; Fri, 19
 Apr 2024 12:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000004792a90615a1dde0@google.com>
In-Reply-To: <0000000000004792a90615a1dde0@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Apr 2024 12:44:04 -0700
Message-ID: <CAADnVQKoPfHC_o7jSa0W-gC=fqodmNDeoRO8eaTPN_NxBuXD6w@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] BUG: unable to handle kernel paging request in
 bpf_prog_ADDR (2)
To: syzbot <syzbot+838346b979830606c854@syzkaller.appspotmail.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eddy Z <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 8:53=E2=80=AFPM syzbot
<syzbot+838346b979830606c854@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kerne=
l..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1259622318000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4d90a36f0cab4=
95a
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D838346b97983060=
6c854
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D134ecbb5180=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D141a8b3d18000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f6c04726a2ae/dis=
k-fe46a7dd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/09c26ce901ea/vmlinu=
x-fe46a7dd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/134acf7f5322/b=
zImage-fe46a7dd.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+838346b979830606c854@syzkaller.appspotmail.com
>
> BUG: unable to handle page fault for address: 0000001000000112
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 800000002e7b1067 P4D 800000002e7b1067 PUD 0
> Oops: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 0 PID: 5060 Comm: syz-executor351 Not tainted 6.8.0-syzkaller-08951-=
gfe46a7dd189e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
> RIP: 0010:bpf_prog_a8e24a805b35c61b+0x19/0x1e
> Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc f3 0f 1e fa 0f 1=
f 44 00 00 66 90 55 48 89 e5 f3 0f 1e fa 31 c0 48 8b 7f 18 <8b> 7f 00 c9 c3=
 cc cc cc cc cc cc 40 03 00 00 cc cc cc cc cc cc cc
> RSP: 0018:ffffc90003b07b30 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffffc90000ace048 RCX: ffff88802aa89e00
> RDX: 0000000000000000 RSI: ffffc90000ace048 RDI: 0000001000000112
> RBP: ffffc90003b07b30 R08: ffffffff81bf633c R09: 1ffffffff2595ca0
> R10: dffffc0000000000 R11: ffffffffa000095c R12: ffffc90000ace030
> R13: ffff88802ac3ae28 R14: dffffc0000000000 R15: ffff88802ac3ae28
> FS:  000055558f759380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001000000112 CR3: 0000000077cfa000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>  __bpf_prog_run include/linux/filter.h:657 [inline]
>  bpf_prog_run include/linux/filter.h:664 [inline]
>  bpf_prog_run_array_cg kernel/bpf/cgroup.c:51 [inline]
>  __cgroup_bpf_run_filter_setsockopt+0x6fa/0x1040 kernel/bpf/cgroup.c:1830
>  do_sock_setsockopt+0x6b4/0x720 net/socket.c:2293
>  __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
>  __do_sys_setsockopt net/socket.c:2343 [inline]
>  __se_sys_setsockopt net/socket.c:2340 [inline]
>  __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75

This one looks interesting.
But I cannot reproduce it.

Bjorn or Stan,

Could you take a look?

Probably a race in xdp dispatcher setup or the way cgroup-lsm
logic is doing it.

