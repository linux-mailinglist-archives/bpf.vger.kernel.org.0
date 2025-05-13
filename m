Return-Path: <bpf+bounces-58128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E120AAB59BB
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 18:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E933C3AEC02
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 16:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5271D2BF3C2;
	Tue, 13 May 2025 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lladFSDR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B9F28DF08;
	Tue, 13 May 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747153267; cv=none; b=LJFgl6rXf546X0GpED8lxwihsJkhKvnWxZwIiTC3ilYc7xi0+NsWD25TEemVj3epjiSxlwi1Ur12IsbrYIA1ODAy5gDt2rakxHf/0Ny2fAPx48KtkXe3cZdRbzGsPYY1v7e7yUsWwm8cEnxd0JxBrUL6fvyTeyBlcTfqy/WFpeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747153267; c=relaxed/simple;
	bh=xclisS5BkvPZHchwV0BGySrX4fYAWqdhAIyu73hj/tU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmzGmpQH4hOXtJV7923j7LpRhEdKVzllMjo98mMtisdNqJ5i1YSRJ7ZSHOxZZ4z9QzTWGmEfvGhMSGQqMyck5VWDjjiWp1eAGHoo+5qCvDiwfllRpAjyrsbQoNxOWAehxS6LnwsfMO/ND00pB/tbBZJj0sCUoLHEFTKW8UGcAZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lladFSDR; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30a93117e1bso7673527a91.1;
        Tue, 13 May 2025 09:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747153265; x=1747758065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+E16I8vzEmd9DjLSjm9FsQflL/9sYtnGL2OMd5s3O6A=;
        b=lladFSDRo6lFS2e1wEs+KieWvE38B3fFMASPslCI7RvaYEXblNcuvMYswtF/aylfvp
         izEc85Tkz7pobdh5Vm413EFt2GgM72CQl3dORzSvVNLTOn7EenFu0jEOd0hycwPt9+Uz
         FtBUX0gUhaJRMzW+oCR0j212mEyRBpEv/hTQrWdaluJYel2JELDbw8kwrJn0elSrLfMq
         9nQHPxOcGD06BtSwCF9TksbPAbF3E0H0cDLvBkSnMQXoNyiG47KhmjUcRouIosXCd7ot
         o45akIadIP2bAG3KeN2Y9drsDjz6I4Qf+neHqtgJTfJwHhzj7qdv12Q0aJq3gZ6AY9aw
         OxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747153265; x=1747758065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+E16I8vzEmd9DjLSjm9FsQflL/9sYtnGL2OMd5s3O6A=;
        b=EVlJBC4cu4GpuB6J6Ps9LdDPVVoImng332JjxGSN9XG12szSsUs71I6oVpt8e30Lph
         A7G6TIT9RyEspN/FASO11vQHTPYtFUGZQ72EX6mHBhBgcz4JResGPKrhGzDB77kCsQau
         hOpcyfgh2uzCfCJyd2+bIpGoGaSKl7ECgUpFkscde3L5S8Vwqp2pc4B+e3hoa9ayIbUw
         GzBWNRRUgiVUznv9xKs38gsB2oGyzTIfS43Pe3dXIa5t8mj9BaE6VxRgHlGk2aMHioZS
         u2dIlELxSOZeUlATCcBW6wVD9Cr1zA5KbTgUtiLZfmypSNsESeMyPrk19oW/P3WPqsqL
         NDbA==
X-Forwarded-Encrypted: i=1; AJvYcCUMQ69hew6Ainw1i5XBAOfNS0cAxYKtpBIUpQaf9BpvPtp1cq8QoMRgbBrwlxJL5zaEP9A=@vger.kernel.org, AJvYcCWi7S4Z/9v7skhYEcLjKy65capth7uSZ04Y9L0N5wjRug7CIOXkb16bfnp6MePDyHK2ticeGZztBHF5Ysgv@vger.kernel.org
X-Gm-Message-State: AOJu0YzojHvP6H/0iTrV1ZxMO0aLvPpZcPlwO+KIWg6RohWB7ERubv3s
	olXCmjDaXQO2J0aSPN243MIao9kxryXJFh4JKpubdDBRJC0a1unmKjBEG5kycV8DUtBISC4bkKw
	OMwWVDrjBJBrEM88Ri7Zla0MQD5c=
X-Gm-Gg: ASbGncvUOwabC6jVrFMCpKQPY5DvysjBXkQO0qAtRmSwoD1KBX/ckeFUiD9+6hnlxLU
	/Kzas8nLzIRGhL5SxXyzS+OlyzrxT8a+yHpUbvFaUGOXnSqQUKwD5qPRyqODf0ZupsoK7/C9mLB
	UP394PUymu9uZ/7WVd5vT7KLYT7uw85f3D7tWAgAJWZjt0u4Rr
X-Google-Smtp-Source: AGHT+IFka4H8eoa7OVpKTOIIXdcuhtfU+/+l3e9nrDdI3J/0gI91v7zfBkYr6HXhC8D4L2jkbsH5fq45jqOUJK9sTgY=
X-Received: by 2002:a17:90a:ec8d:b0:2ff:53ad:a0ec with SMTP id
 98e67ed59e1d1-30e2e5d1a30mr257426a91.21.1747153264931; Tue, 13 May 2025
 09:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68213ddf.050a0220.f2294.0045.GAE@google.com> <CAEf4BzbsmHonD-G45-Jo8RQHPjDYEz-Nwx0MGtsk427tgsqGkg@mail.gmail.com>
 <CACT4Y+YpBHXXjU6rPBtB7_-5BvxqZUHW8i6YjOa6twoR=2u1aA@mail.gmail.com>
In-Reply-To: <CACT4Y+YpBHXXjU6rPBtB7_-5BvxqZUHW8i6YjOa6twoR=2u1aA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 May 2025 09:20:52 -0700
X-Gm-Features: AX0GCFtpo4CEO8cKHEVoVAl0Khf5cvl0XCIEYr5QnU_XW5ohDEqZYOc_E01IGZU
Message-ID: <CAEf4BzbqrLhB6OmkuqNQMkFQFYzbW1-abUni2vdX0N5mwaQvjA@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] KASAN: vmalloc-out-of-bounds Write in
 vrealloc_noprof (2)
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+659fcc0678e5a1193143@syzkaller.appspotmail.com>, 
	Linux Memory Management List <linux-mm@kvack.org>, andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 1:13=E2=80=AFAM Dmitry Vyukov <dvyukov@google.com> =
wrote:
>
> On Tue, 13 May 2025 at 00:52, Andrii Nakryiko <andrii.nakryiko@gmail.com>=
 wrote:
> >
> > On Sun, May 11, 2025 at 5:16=E2=80=AFPM syzbot
> > <syzbot+659fcc0678e5a1193143@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    707df3375124 Merge tag 'media/v6.15-2' of git://git.k=
ernel..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D16b1b2bc5=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D91c351a0f=
6229e67
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D659fcc0678e=
5a1193143
> > > compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef=
89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image (non-bootable): https://storage.googleapis.com/syzbot-asse=
ts/d900f083ada3/non_bootable_disk-707df337.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/bc3944720ea5/vm=
linux-707df337.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/7bc2f45ae2=
3f/bzImage-707df337.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+659fcc0678e5a1193143@syzkaller.appspotmail.com
> > >
> > > syz.0.0 uses obsolete (PF_INET,SOCK_PACKET)
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > BUG: KASAN: vmalloc-out-of-bounds in vrealloc_noprof+0x396/0x430 mm/v=
malloc.c:4093
> > > Write of size 4064 at addr ffffc9000efa1020 by task syz.0.0/5317
> > >
> >
> > A while back I sent a fix for kasan handling of vrealloc ([0]), but
> > this issue came back even with my changes in [0]. Can anyone from mm
> > side take a look at vrealloc_noprof() and see if we are missing
> > anything else to convince KASAN that we are using vrealloc()
> > correctly?
> >
> > Seems like kasan_poison_vmalloc() + kasan_unpoison_vmalloc() dance
> > isn't covering all cases? Or am I missing something? It's doubtful
> > that there is any BPF-side bug in using kvrealloc().
> >
> >   [0] https://lore.kernel.org/linux-mm/20241126005206.3457974-1-andrii@=
kernel.org/
>
> Hi Andrii,
>
> The report flags the very memset that's visible in this patch chunk, righ=
t?
> https://lore.kernel.org/linux-mm/20241126005206.3457974-1-andrii@kernel.o=
rg/
> Unless I am missing something obvious, the unpoison is added _after_
> the memset, so it can't help. The unpoison should be done _before_ the
> memset.

So that's the case when we realloc to a size that's smaller than
previously alloc'ed vma. So presumably the previous allocation should
have unpoisoned that. But I think you are right, there is a disconnect
between requested size of allocation (which doesn't have to be a
multiple of PAGE_SIZE), and actual page size-aligned VMA size. We
don't seem to keep track of the original requested memory size.

So yes, a simple "fix" would be to temporarily unpoison and memset.
I'll send a patch, don't know if mm/kasan folks would have any better
suggestions. Thanks for suggestion, Dmitry!

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3ed720a787ec..93b4c1758498 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4089,8 +4089,11 @@ void *vrealloc_noprof(const void *p, size_t
size, gfp_t flags)
         */
        if (size <=3D old_size) {
                /* Zero out spare memory. */
-               if (want_init_on_alloc(flags))
+               if (want_init_on_alloc(flags)) {
+                       kasan_unpoison_vmalloc(p + size, old_size - size,
+                                              KASAN_VMALLOC_PROT_NORMAL);
                        memset((void *)p + size, 0, old_size - size);
+               }
                kasan_poison_vmalloc(p + size, old_size - size);
                kasan_unpoison_vmalloc(p, size, KASAN_VMALLOC_PROT_NORMAL);
                return (void *)p;

(note, the diff formatting will be butchered courtesy of gmail, so
don't try to actually apply that)

>
>
> > > CPU: 0 UID: 0 PID: 5317 Comm: syz.0.0 Not tainted 6.15.0-rc5-syzkalle=
r-00038-g707df3375124 #0 PREEMPT(full)
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debia=
n-1.16.3-2~bpo12+1 04/01/2014
> > > Call Trace:
> > >  <TASK>
> > >  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
> > >  print_address_description mm/kasan/report.c:408 [inline]
> > >  print_report+0xb4/0x290 mm/kasan/report.c:521
> > >  kasan_report+0x118/0x150 mm/kasan/report.c:634
> > >  check_region_inline mm/kasan/generic.c:-1 [inline]
> > >  kasan_check_range+0x29a/0x2b0 mm/kasan/generic.c:189
> > >  __asan_memset+0x22/0x50 mm/kasan/shadow.c:84
> > >  vrealloc_noprof+0x396/0x430 mm/vmalloc.c:4093
> > >  push_insn_history+0x184/0x650 kernel/bpf/verifier.c:3874
> > >  do_check+0x597/0xd630 kernel/bpf/verifier.c:19450
> > >  do_check_common+0x168d/0x20b0 kernel/bpf/verifier.c:22776
> > >  do_check_main kernel/bpf/verifier.c:22867 [inline]
> > >  bpf_check+0x13679/0x19a70 kernel/bpf/verifier.c:24033
> > >  bpf_prog_load+0x1318/0x1930 kernel/bpf/syscall.c:2971
> > >  __sys_bpf+0x5f1/0x860 kernel/bpf/syscall.c:5834
> > >  __do_sys_bpf kernel/bpf/syscall.c:5941 [inline]
> > >  __se_sys_bpf kernel/bpf/syscall.c:5939 [inline]
> > >  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5939
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > RIP: 0033:0x7f649c58e969
> > > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 =
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f=
0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007f649d4dd038 EFLAGS: 00000246 ORIG_RAX: 000000000000014=
1
> > > RAX: ffffffffffffffda RBX: 00007f649c7b5fa0 RCX: 00007f649c58e969
> > > RDX: 0000000000000048 RSI: 00002000000017c0 RDI: 0000000000000005
> > > RBP: 00007f649c610ab1 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > > R13: 0000000000000000 R14: 00007f649c7b5fa0 R15: 00007fff542287e8
> > >  </TASK>
> > >
> > > The buggy address belongs to the virtual mapping at
> > >  [ffffc9000ef81000, ffffc9000efa3000) created by:
> > >  kvrealloc_noprof+0x82/0xe0 mm/slub.c:5109
> > >
> > > The buggy address belongs to the physical page:
> > > page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x3ffd0 pf=
n:0x3efe5
> > > flags: 0x4fff00000000000(node=3D1|zone=3D1|lastcpupid=3D0x7ff)
> > > raw: 04fff00000000000 0000000000000000 dead000000000122 0000000000000=
000
> > > raw: 000000000003ffd0 0000000000000000 00000001ffffffff 0000000000000=
000
> > > page dumped because: kasan: bad access detected
> > > page_owner tracks the page as allocated
> > > page last allocated via order 0, migratetype Unmovable, gfp_mask 0x10=
2cc2(GFP_HIGHUSER|__GFP_NOWARN), pid 5317, tgid 5316 (syz.0.0), ts 82587533=
383, free_ts 81110216781
> > >  set_page_owner include/linux/page_owner.h:32 [inline]
> > >  post_alloc_hook+0x1d8/0x230 mm/page_alloc.c:1718
> > >  prep_new_page mm/page_alloc.c:1726 [inline]
> > >  get_page_from_freelist+0x21ce/0x22b0 mm/page_alloc.c:3688
> > >  __alloc_pages_slowpath+0x2fe/0xcc0 mm/page_alloc.c:4509
> > >  __alloc_frozen_pages_noprof+0x319/0x370 mm/page_alloc.c:4983
> > >  alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2301
> > >  alloc_frozen_pages_noprof mm/mempolicy.c:2372 [inline]
> > >  alloc_pages_noprof+0xa9/0x190 mm/mempolicy.c:2392
> > >  vm_area_alloc_pages mm/vmalloc.c:3591 [inline]
> > >  __vmalloc_area_node mm/vmalloc.c:3669 [inline]
> > >  __vmalloc_node_range_noprof+0x8fe/0x12c0 mm/vmalloc.c:3844
> > >  __kvmalloc_node_noprof+0x3a0/0x5e0 mm/slub.c:5034
> > >  kvrealloc_noprof+0x82/0xe0 mm/slub.c:5109
> > >  push_insn_history+0x184/0x650 kernel/bpf/verifier.c:3874
> > >  do_check+0x597/0xd630 kernel/bpf/verifier.c:19450
> > >  do_check_common+0x168d/0x20b0 kernel/bpf/verifier.c:22776
> > >  do_check_main kernel/bpf/verifier.c:22867 [inline]
> > >  bpf_check+0x13679/0x19a70 kernel/bpf/verifier.c:24033
> > >  bpf_prog_load+0x1318/0x1930 kernel/bpf/syscall.c:2971
> > >  __sys_bpf+0x5f1/0x860 kernel/bpf/syscall.c:5834
> > >  __do_sys_bpf kernel/bpf/syscall.c:5941 [inline]
> > >  __se_sys_bpf kernel/bpf/syscall.c:5939 [inline]
> > >  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5939
> > > page last free pid 82 tgid 82 stack trace:
> > >  reset_page_owner include/linux/page_owner.h:25 [inline]
> > >  free_pages_prepare mm/page_alloc.c:1262 [inline]
> > >  free_unref_folios+0xb81/0x14a0 mm/page_alloc.c:2782
> > >  shrink_folio_list+0x3053/0x4e90 mm/vmscan.c:1552
> > >  evict_folios+0x417b/0x5110 mm/vmscan.c:4698
> > >  try_to_shrink_lruvec+0x705/0x990 mm/vmscan.c:4859
> > >  shrink_one+0x21b/0x7c0 mm/vmscan.c:4904
> > >  shrink_many mm/vmscan.c:4967 [inline]
> > >  lru_gen_shrink_node mm/vmscan.c:5045 [inline]
> > >  shrink_node+0x3139/0x3750 mm/vmscan.c:6016
> > >  kswapd_shrink_node mm/vmscan.c:6867 [inline]
> > >  balance_pgdat mm/vmscan.c:7050 [inline]
> > >  kswapd+0x1675/0x2970 mm/vmscan.c:7315
> > >  kthread+0x70e/0x8a0 kernel/kthread.c:464
> > >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
> > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > >
> > > Memory state around the buggy address:
> > >  ffffc9000efa0f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >  ffffc9000efa0f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > >ffffc9000efa1000: 00 00 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> > >                                ^
> > >  ffffc9000efa1080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> > >  ffffc9000efa1100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion visit https://groups.google.com/d/msgid/syzkall=
er-bugs/CAEf4BzbsmHonD-G45-Jo8RQHPjDYEz-Nwx0MGtsk427tgsqGkg%40mail.gmail.co=
m.

