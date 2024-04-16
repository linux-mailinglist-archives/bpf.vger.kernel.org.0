Return-Path: <bpf+bounces-26922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56738A667E
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 10:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7FEA1C212E7
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 08:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DE584A5C;
	Tue, 16 Apr 2024 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rQTCc1DG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732EEEEB7
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713257577; cv=none; b=d6r5iKzxmXyXt1/cZEt821D3VElUiNlcKP51IsStdspPl5OaPNcT7Ijn/OKO1sKYl5PbZckfYiqclZq4ueyhwWtL/N7XMk0d6QUJsbFKD5HZinsJA1W4bFxh5DnY8GpXw5e5ZEzoDC1TevRPNVwskLP2QV0BRtbIJqgH5o+D30c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713257577; c=relaxed/simple;
	bh=FdtQyAHvdiOXO6ti4ShXTouSZM7Z22hhscY+ZntVPlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMgcrrRIX+icPpdb/V2j92Z0Pn+Gty3UKwNYxKZAqnMcPMo7pKgHATRZ+E5CV124m1zFn0FnqVsfhjrGjp6tYQQe4jbWcFYShVLw6EZTgpSsqh65cGv+i2FDBTFfoHSTO5KQjMjEF7sdHBPlTgcm4DaO/p7v3zBLBdR/qRwccV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rQTCc1DG; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-69cb4a046dfso3164256d6.2
        for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 01:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713257574; x=1713862374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPVk/nT4EhdKCio3Wn9r/Arl5MCpgxnJeUxrDI8MyIE=;
        b=rQTCc1DGz3frrxpKbhy/9ejG+WfVduUruCugxkAc5sFgADXwdcpj9zCZyUgziljJFi
         ctU904t/17GeCTCltvetKp2HQ/9uH09h342nj+MfpObZ57wpPqrIuE1D/sCSXSRFue51
         zMpaLbTculKnw2XZaTKJWNGNpRly48LZHif+ZGMJIFmRA+DTNt1RDFCvRXMFnshEKqPf
         o7jxFMYdhIYE2M8gF0HtpBigUurWFU/hOinYcHbyzUcSLXYTnZO5IiNudXtFDHs2Jyla
         EQr52YF4rilEFO2AiobMhUdOiBmV8fuMgJecc3q6v0OX+UZIeaAdVlsmKOPk3+KVob6D
         i3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713257574; x=1713862374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPVk/nT4EhdKCio3Wn9r/Arl5MCpgxnJeUxrDI8MyIE=;
        b=DYrIaWoCIb71+79L/FlED0K55cjvP5IEXTBJmpJaH6R8uNtUM1ckMLg++oDGTemV1U
         9Ub4HNILXYa9IMxnVSABRgyKYZ91r0lj4CNekiN93SyehxFIrDLcxp3ZHCMT52wTm4zC
         vbt0aTUZ+PN8UFEASmyXl/fjyxDK9ABL3P6pRV1hLEY5OPV9Q8WLq4CbTf3zX4Brq/cy
         vnRH3hw1QeD9byfN1WOPJXcxIFzwCmlcKDvfnxeG+0lsjPlt6KdU7IcuUy7Qs/2gD8DM
         e61QFuuSlRrn7sJTo6CRl4ik+3SLSoOOa1OfECZ8HF5meQ0AeuheRMM5fYhAw36W3ylS
         DNew==
X-Forwarded-Encrypted: i=1; AJvYcCWpv3C7hE8D3YsUbR62bXlNw0vpRzgzN3pkpaHTAmPoBWfB1Tt4YLJ9a47yXvXznhkJw3+8AYZGgD6UqcXSefdOOGld
X-Gm-Message-State: AOJu0YzySb/zWX0yRgz3dAJA9xHJ+DD3bHS3YZ3zXMK95zoZoDHkHuSS
	4qJhhWVoiKswIeIgjIHVwfm3dWxsOPfrIJi6q1kgdhuF88XqNKRuxiiivak/mmrqYxndcEGDcoY
	4VoAg/HuDpqHHbGkTVxE6VmQuQsd0Lx/ydEq2
X-Google-Smtp-Source: AGHT+IEVH1GgftNMpoMJgPffHF/J8q7xcxKz2P8Pi0PJGcyYrQzTS/Zde01ylrcWnYqhEA7c7VJkWeiB58NSk9HcEN8=
X-Received: by 2002:ad4:4ba2:0:b0:69b:7145:b2ee with SMTP id
 i2-20020ad44ba2000000b0069b7145b2eemr6105996qvw.4.1713257574178; Tue, 16 Apr
 2024 01:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000fe696d0615f120bb@google.com> <20240415131837.411c6e05eb7b0af077d6424a@linux-foundation.org>
 <CAADnVQ+E=j1Z4MOuk2f-U33oqvUmmrRcvWvsDrmLXvD8FhUmsQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+E=j1Z4MOuk2f-U33oqvUmmrRcvWvsDrmLXvD8FhUmsQ@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 16 Apr 2024 10:52:12 +0200
Message-ID: <CAG_fn=Uxaq1juuq-3cA1qQu6gB7ZB=LpyxBEdKf7DpYfAo3zmg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] KMSAN: kernel-infoleak in bpf_probe_write_user
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	syzbot <syzbot+79102ed905e5b2dc0fc3@syzkaller.appspotmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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

Hi Alexei,

From KMSAN's perspective it is fine to pass information to the
userspace, unless it is marked as uninitialized.
It could be that we are missing some initialization in kernel/bpf/core.c th=
ough.
Do you know which part of the code is supposed to initialize the stack
in PROG_NAME?

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



--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

