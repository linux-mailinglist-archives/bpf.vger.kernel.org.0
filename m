Return-Path: <bpf+bounces-26872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8DE8A5C99
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 23:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12701C21020
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 21:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB55156988;
	Mon, 15 Apr 2024 21:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vb7BU7U2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C7542072;
	Mon, 15 Apr 2024 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215214; cv=none; b=SftOoscaBeDC4rSnTo3WWJKqaJn8ZT5eiVCWis6hbPHvKFOh1fXL+ZozqiliWx0m1CWZAdMmqluFVv7Xd24+1w0FvyV3JtKaSFyAbY8isVlhLqX8uWpb7DWdnVM3NxRLAfPxiL4M3NKogC54swgquo/TTR9SqLINubbijZ48+qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215214; c=relaxed/simple;
	bh=GYBEw+cePmUxgK+VB8F6HIiR5cBsRNyIT1M/5ZSPIs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKiBEs9pZVkOwoSJQsgNvWHCM+PpwWHxM1lEVotRjjWMqkP3d/fc4R/olNuqMs1sGYu9oGImOaGQtajFU/pA0NXTKNPXi3tJ4cz/4MlueWf7H6DkB/B1pmwKsfL8PNNrCjF8wd9b20zXPOsMNYQe3dSC3BS/X8/wK2HMsDXpX7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vb7BU7U2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41884e96f9eso3377525e9.3;
        Mon, 15 Apr 2024 14:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713215211; x=1713820011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9IZ4DBe3s3FrC7gIAF957ztxkp3Q6VPnQHGXouJLYE=;
        b=Vb7BU7U2b0h48YTFP77mRq12/3goz0j1q1pVPbPQSSy2unTHSqquOd4gznpE4AvHwM
         V7kq12aa45PWbYO6+WkSt4a4O8dKDXoKMxMeS0Z4YEVruJcmns8jS8KNp9Hd8DRvY453
         sDgnBn5W3eAr2WLiKFEVzXLh7nEujUv3xuTQf/FOh2T2vO61pmXk563BJ16N9DZkgzxA
         zdnR7IYYffREQAbgzhY1D+k9Krsek5jDGbNkjTVBxUr0DOavdZgdLX52Ko2QSUF28NCd
         F4r+HY1Hp9/8SQPXOBUseFIKIk4F+YaK4QvY+EI7wr3X3RzXkF6CZPnvU/iqdba6a85j
         Jgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713215211; x=1713820011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9IZ4DBe3s3FrC7gIAF957ztxkp3Q6VPnQHGXouJLYE=;
        b=dr7ki+5TLba9/RgpTERNj3ak+dtwbazxUdUjNrnE0c6ITeiQDXkghEI5Dg/lkXoZ/F
         wGZafFQNUAoD3n2nN8ACstf3ZKbQLE14EiICtihxy+VqJF0qYUPtFM+YXCJB5eO6D1IB
         XDmdzp92V7m2lQ7zF3uIlZiqyb9usIeVjAGMn79Vw8P7w4OGHYVBlfEAL8m8He719VH7
         KKN66ZKkXM9wCQtuXjfBnvP0vjpa4puPsmRiFnOSoiXXb8xdsiDJPa8RxEkAr6A2GoTt
         BOTsX7SyE9fWTbQzHHLRxgcFHaeDD++DLUkQkWw5fsV6qLHmUcxR5cBmsemRf+uXuz3i
         9ZEw==
X-Forwarded-Encrypted: i=1; AJvYcCURNfgXPpQwNfbt3DDfjXgAP2rZy4l6xhRpilNOEPWK1VeiVsxiyKxPhDUUu2tVMjegfK58lq0X8kaNX3uyma0dWApFdukrhCPyPovCerai9rq0TMzOOQptrdyGEzu8BT1d
X-Gm-Message-State: AOJu0Yyh3b6AqxkzNmfgfIBfTTuaktrjVzpA6EnKl3O99adeQdn8VKbD
	WNm3K3C9h8I9m1BH0qb6kP0xZLzI7nKXd0FrEs5gZHIId1SEpTTMHFrL9fU8LRtrSXdk24PpFq1
	suGTN/E8IU1l217v2GKF6KkWeNjZLUg==
X-Google-Smtp-Source: AGHT+IHUFlV/MuZmtkAlf5WIGJLAv2yyqjRS46ZRi2z6Zgl482QnOD4zbX0h5Xj9t0kNTCqjHgk0jiV4w4l/9whWo10=
X-Received: by 2002:adf:f2c4:0:b0:347:f7fe:135d with SMTP id
 d4-20020adff2c4000000b00347f7fe135dmr1960783wrp.18.1713215210479; Mon, 15 Apr
 2024 14:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000fe696d0615f120bb@google.com> <20240415131837.411c6e05eb7b0af077d6424a@linux-foundation.org>
In-Reply-To: <20240415131837.411c6e05eb7b0af077d6424a@linux-foundation.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Apr 2024 14:06:39 -0700
Message-ID: <CAADnVQ+E=j1Z4MOuk2f-U33oqvUmmrRcvWvsDrmLXvD8FhUmsQ@mail.gmail.com>
Subject: Re: [syzbot] [mm?] KMSAN: kernel-infoleak in bpf_probe_write_user
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+79102ed905e5b2dc0fc3@syzkaller.appspotmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

syzbot folks, please disable such "bug" reporting.
The whole point of bpf is to pass such info to userspace.
probe_write_user, various ring buffers, bpf_*_printk-s, bpf maps
all serve this purpose of "infoleak".

On Mon, Apr 15, 2024 at 1:18=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> (cc bpf@)
>
> On Fri, 12 Apr 2024 19:27:25 -0700 syzbot <syzbot+79102ed905e5b2dc0fc3@sy=
zkaller.appspotmail.com> wrote:
>
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    fec50db7033e Linux 6.9-rc3
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D16509ba1180=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D13e7da43256=
5d94c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D79102ed905e5b=
2dc0fc3
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10a4af9d1=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12980f9d180=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/901017b36ccc/d=
isk-fec50db7.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/16bfcf5618d3/vmli=
nux-fec50db7.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/dc9c5a1e7d02=
/bzImage-fec50db7.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+79102ed905e5b2dc0fc3@syzkaller.appspotmail.com
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/in=
strumented.h:114 [inline]
> > BUG: KMSAN: kernel-infoleak in __copy_to_user_inatomic include/linux/ua=
ccess.h:125 [inline]
> > BUG: KMSAN: kernel-infoleak in copy_to_user_nofault+0x129/0x1f0 mm/macc=
ess.c:149
> >  instrument_copy_to_user include/linux/instrumented.h:114 [inline]
> >  __copy_to_user_inatomic include/linux/uaccess.h:125 [inline]
> >  copy_to_user_nofault+0x129/0x1f0 mm/maccess.c:149
> >  ____bpf_probe_write_user kernel/trace/bpf_trace.c:349 [inline]
> >  bpf_probe_write_user+0x104/0x180 kernel/trace/bpf_trace.c:327
> >  ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
> >  __bpf_prog_run64+0xb5/0xe0 kernel/bpf/core.c:2236
> >  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
> >  __bpf_prog_run include/linux/filter.h:657 [inline]
> >  bpf_prog_run include/linux/filter.h:664 [inline]
> >  __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
> >  bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420
> >  __bpf_trace_kfree+0x29/0x40 include/trace/events/kmem.h:94
> >  trace_kfree include/trace/events/kmem.h:94 [inline]
> >  kfree+0x6a5/0xa30 mm/slub.c:4377
> >  vfs_writev+0x12bf/0x1450 fs/read_write.c:978
> >  do_writev+0x251/0x5c0 fs/read_write.c:1018
> >  __do_sys_writev fs/read_write.c:1091 [inline]
> >  __se_sys_writev fs/read_write.c:1088 [inline]
> >  __x64_sys_writev+0x98/0xe0 fs/read_write.c:1088
> >  do_syscall_64+0xd5/0x1f0
> >  entry_SYSCALL_64_after_hwframe+0x72/0x7a
> >
> > Local variable stack created at:
> >  __bpf_prog_run64+0x45/0xe0 kernel/bpf/core.c:2236
> >  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
> >  __bpf_prog_run include/linux/filter.h:657 [inline]
> >  bpf_prog_run include/linux/filter.h:664 [inline]
> >  __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
> >  bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420
> >
> > Bytes 0-7 of 8 are uninitialized
> > Memory access of size 8 starts at ffff888121ec7ae8
> > Data copied to user address 00000000ffffffff
> >
> > CPU: 1 PID: 4779 Comm: dhcpcd Not tainted 6.9.0-rc3-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 03/27/2024
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing=
.
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
>

