Return-Path: <bpf+bounces-26921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 328F08A665D
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 10:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AC29B238E5
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 08:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9962584A23;
	Tue, 16 Apr 2024 08:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4jlf6u4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D983CBE
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 08:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713257192; cv=none; b=JJM6jyIvjhNpNf945gppcFAp7tvy/ZAb8H3n76/5zsdC4DI2UQV0zm2SxuICgx/Ec7OH3aB7bRbid0Bb6RnEgQaoWf39Z+pXfvug98n32b6QKFIm1bksrTsVyIWibr2ALp2XUZobQLBg1zEVfS7kr7udL6CLx3ws2d35sN3Eork=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713257192; c=relaxed/simple;
	bh=wvlbCfxHSZpaqmi0913qTIrGU+Bv5x+PhfrqBSY9p8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGdGsuaBKbb1wveGAjcasjrokoQ6469713Yx5/Yzhaxlq79zinr+C3qNIdMFIY1UsNVT71Q2EZ5EbEM1BJH4JU+QtVajtGOqSkdOX3KKMXnJPpRO60O3pyQhvHq8Hc/mTLkj9bHKoIhvI9yWF0Oqego3suSnJ6Y0WW9J2DBK150=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C4jlf6u4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e3c89f3d32so149885ad.0
        for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 01:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713257190; x=1713861990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdFARpeJLKEG6lkXysYKLQ1MgRKXAzEEOOq2GHR99oo=;
        b=C4jlf6u4BkMKAlXkp6H0vBHquDHwX3WsR4yryseN2YfQhSDvPR56UdRl7OWUpZIdbd
         oZg2JfuFLfN0ZIZGK1gwsUvqhLQeGJG+ZLRrQP7fuxzxDRmS4lHKzemRs66CailrCL4S
         UxUIj6dIUPf6SzBJc5HnR47Bx5veES1rc8xg86lDS/XumfsnCVuvcSh0TBRX8qJQCcAF
         DEjQiWpRz5BC2YexRviZU7CzdQVFa/HvJR0xtV1TcdxydkPYLGGc8OJmbIuKSjpy/plM
         XYdIZtMJAWjqwcyeXZJtJbC4XpRxFAaF64yp95Fte/iBJgLjuyWcmvXdMlI360AK9egK
         MYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713257190; x=1713861990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdFARpeJLKEG6lkXysYKLQ1MgRKXAzEEOOq2GHR99oo=;
        b=alnGZ4ZOCxSl3+RsKwoumpZTmEBzlDHS+eQkS8y79r5xLVxjzYaNdI/xJp5bEgFKXp
         leNKzx6ZDIjvGbnldQNzDCJ/gal5ZzWb/LXo/L0iTrFowwY+UJW/oJenioQQNV/PJ7il
         5vD2EXXEFpNxPR1hH0YkobxyqURmIKTC1pOI/3+pTbJGT9e5ilTqJo3nhoV63lpDQY5a
         nhyWPYibB2T1MDLb19R7vIvJGjGavsy9RTPMlAvl7FKStxEFE3hrdmnsy/leCC/0hY8z
         MiOj5EMcbm6BpcoX6KjONTTI7qtz8Lr8hwc/d0CgTaRPqLRgo0grTcDTigZvDy+cyjOl
         KZzw==
X-Forwarded-Encrypted: i=1; AJvYcCWoMKXhoDjZRbxO3XkoEnpatucvXeqHY/PrGHQfpVgNCCVp7u837hyRGk/WVDPQWKxl2zIozUIiH4D7NWcKXCEwlJfQ
X-Gm-Message-State: AOJu0YyF6xlF9l6AAo4fPTbeabj7Td9um28L335ORfA53pUU2ngi7eTJ
	snGy364IZfroPmMX5cURmYae1IoT8aRhDq9+q0TCZ+MhDWzHdNCyzHYDcUGDQlkgP2/B+fmkEen
	rkGhZ2nQit7jlBZgoR160Wtp+v3OOTaAiUg23
X-Google-Smtp-Source: AGHT+IFO1IZLaHuBSBibnq9pM+7smIeLVIAtC5ld61VMJb0S9XUpcC1f76mOW94iGHIxSJqyUGKfqdeMQ8u15Od0bx4=
X-Received: by 2002:a17:902:f548:b0:1e5:1138:e29d with SMTP id
 h8-20020a170902f54800b001e51138e29dmr143673plf.29.1713257189512; Tue, 16 Apr
 2024 01:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000fe696d0615f120bb@google.com> <20240415131837.411c6e05eb7b0af077d6424a@linux-foundation.org>
 <CAADnVQ+E=j1Z4MOuk2f-U33oqvUmmrRcvWvsDrmLXvD8FhUmsQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+E=j1Z4MOuk2f-U33oqvUmmrRcvWvsDrmLXvD8FhUmsQ@mail.gmail.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 16 Apr 2024 10:46:16 +0200
Message-ID: <CANp29Y6UqJmBjmhO_7-DeBqou1AG7=AmSu9PvuK3cPXmCDziXA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] KMSAN: kernel-infoleak in bpf_probe_write_user
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexander Potapenko <glider@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	syzbot <syzbot+79102ed905e5b2dc0fc3@syzkaller.appspotmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, bpf <bpf@vger.kernel.org>, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(+Alexander Potapenko)

Hi Alexei,

Thanks for bringing this up!
I guess some annotations in the kernel code need to be adjusted.
Syzbot stress-tests the kernel, but in the end it's the kernel itself
that detects problems and prints error reports.

--=20
Aleksandr


On Mon, Apr 15, 2024 at 11:06=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Hi,
>
> syzbot folks, please disable such "bug" reporting.
> The whole point of bpf is to pass such info to userspace.
> probe_write_user, various ring buffers, bpf_*_printk-s, bpf maps
> all serve this purpose of "infoleak".
>
> On Mon, Apr 15, 2024 at 1:18=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > (cc bpf@)
> >
> > On Fri, 12 Apr 2024 19:27:25 -0700 syzbot <syzbot+79102ed905e5b2dc0fc3@=
syzkaller.appspotmail.com> wrote:
> >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    fec50db7033e Linux 6.9-rc3
> > > git tree:       upstream
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D16509ba11=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D13e7da432=
565d94c
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D79102ed905e=
5b2dc0fc3
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for=
 Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10a4af9=
d180000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12980f9d1=
80000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/901017b36ccc=
/disk-fec50db7.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/16bfcf5618d3/vm=
linux-fec50db7.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/dc9c5a1e7d=
02/bzImage-fec50db7.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+79102ed905e5b2dc0fc3@syzkaller.appspotmail.com
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/=
instrumented.h:114 [inline]
> > > BUG: KMSAN: kernel-infoleak in __copy_to_user_inatomic include/linux/=
uaccess.h:125 [inline]
> > > BUG: KMSAN: kernel-infoleak in copy_to_user_nofault+0x129/0x1f0 mm/ma=
ccess.c:149
> > >  instrument_copy_to_user include/linux/instrumented.h:114 [inline]
> > >  __copy_to_user_inatomic include/linux/uaccess.h:125 [inline]
> > >  copy_to_user_nofault+0x129/0x1f0 mm/maccess.c:149
> > >  ____bpf_probe_write_user kernel/trace/bpf_trace.c:349 [inline]
> > >  bpf_probe_write_user+0x104/0x180 kernel/trace/bpf_trace.c:327
> > >  ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
> > >  __bpf_prog_run64+0xb5/0xe0 kernel/bpf/core.c:2236
> > >  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
> > >  __bpf_prog_run include/linux/filter.h:657 [inline]
> > >  bpf_prog_run include/linux/filter.h:664 [inline]
> > >  __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
> > >  bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420
> > >  __bpf_trace_kfree+0x29/0x40 include/trace/events/kmem.h:94
> > >  trace_kfree include/trace/events/kmem.h:94 [inline]
> > >  kfree+0x6a5/0xa30 mm/slub.c:4377
> > >  vfs_writev+0x12bf/0x1450 fs/read_write.c:978
> > >  do_writev+0x251/0x5c0 fs/read_write.c:1018
> > >  __do_sys_writev fs/read_write.c:1091 [inline]
> > >  __se_sys_writev fs/read_write.c:1088 [inline]
> > >  __x64_sys_writev+0x98/0xe0 fs/read_write.c:1088
> > >  do_syscall_64+0xd5/0x1f0
> > >  entry_SYSCALL_64_after_hwframe+0x72/0x7a
> > >
> > > Local variable stack created at:
> > >  __bpf_prog_run64+0x45/0xe0 kernel/bpf/core.c:2236
> > >  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
> > >  __bpf_prog_run include/linux/filter.h:657 [inline]
> > >  bpf_prog_run include/linux/filter.h:664 [inline]
> > >  __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
> > >  bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420
> > >
> > > Bytes 0-7 of 8 are uninitialized
> > > Memory access of size 8 starts at ffff888121ec7ae8
> > > Data copied to user address 00000000ffffffff
> > >
> > > CPU: 1 PID: 4779 Comm: dhcpcd Not tainted 6.9.0-rc3-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 03/27/2024
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > >
> > >
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > >
> > > If the report is already addressed, let syzbot know by replying with:
> > > #syz fix: exact-commit-title
> > >
> > > If you want syzbot to run the reproducer, reply with:
> > > #syz test: git://repo/address.git branch-or-commit-hash
> > > If you attach or paste a git patch, syzbot will apply it before testi=
ng.
> > >
> > > If you want to overwrite report's subsystems, reply with:
> > > #syz set subsystems: new-subsystem
> > > (See the list of subsystem names on the web dashboard)
> > >
> > > If the report is a duplicate of another one, reply with:
> > > #syz dup: exact-subject-of-another-report
> > >
> > > If you want to undo deduplication, reply with:
> > > #syz undup
> >
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/CAADnVQ%2BE%3Dj1Z4MOuk2f-U33oqvUmmrRcvWvsDrmLXvD8FhUmsQ%40=
mail.gmail.com.

