Return-Path: <bpf+bounces-17247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2D580AE77
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 22:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30C01B20C06
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 21:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77DD5731B;
	Fri,  8 Dec 2023 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H0nb6f5x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NiM7ifui"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810A3BD;
	Fri,  8 Dec 2023 13:01:18 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702069276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fyZSQoqP0KRSQHqIRkZ+i+MZQFCaydm1eRetmruXsTc=;
	b=H0nb6f5x8zjNy08JE0H4JgU/rFJEaHUSvv5NQfmzxOe/rMD6OBP3CcO10v+t0zUpLhahem
	HQGtFA/zNFLQHuQHBWtTw0ljsY9glhc+T+9PjcqZHtUYGxn3uS1Jcs88qzEI1LkUWdA86I
	7sJi6kRvoVH/F/Ik7epzxJWvixDK3ppyrgM5rPgpn/jjBHGl+souvMkFSxVRvXDfZR9OL2
	H131Mf5X49ys0HNOZ3DGbmhh/Rcx079VQ5t5Onq/1xbxiLG6iCLCMVJj+jseDW7szgGh3K
	8RI+OQA0WhuXttk/1iXqcG3czStGFqOIwuqr8qX1OtJqhPR3BK1iL1iFN2Z7Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702069276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fyZSQoqP0KRSQHqIRkZ+i+MZQFCaydm1eRetmruXsTc=;
	b=NiM7ifuiSbI+Rm3HwjTlX129NUk69XhGtFXl946ccUOzRa728TtxtZp9vsSE3tqMqEHLxk
	2krhN6K0fHBigCBA==
To: Jann Horn <jannh@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>
Cc: syzbot <syzbot+72aa0161922eba61b50e@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, bp@alien8.de, bp@suse.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, luto@kernel.org, mingo@redhat.com,
 netdev@vger.kernel.org, peterz@infradead.org,
 syzkaller-bugs@googlegroups.com, x86@kernel.org
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 copy_from_kernel_nofault
In-Reply-To: <CAG48ez06TZft=ATH1qh2c5mpS5BT8UakwNkzi6nvK5_djC-4Nw@mail.gmail.com>
References: <000000000000c84343060a850bd0@google.com> <87jzqb1133.ffs@tglx>
 <CAG48ez06TZft=ATH1qh2c5mpS5BT8UakwNkzi6nvK5_djC-4Nw@mail.gmail.com>
Date: Fri, 08 Dec 2023 22:01:16 +0100
Message-ID: <87r0jwquhv.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08 2023 at 15:11, Jann Horn wrote:
> On Tue, Nov 21, 2023 at 6:13=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> > BUG: unable to handle page fault for address: ffffffffff600000
>>
>> This is VSYSCALL_ADDR.
>>
>> So the real question is why the BPF program tries to copy from the
>> VSYSCALL page, which is not mapped.
>
> The linked syz repro is:
>
> r0 =3D bpf$PROG_LOAD(0x5, &(0x7f00000000c0)=3D{0x11, 0xb,
> &(0x7f0000000180)=3D@framed=3D{{}, [@printk=3D{@integer, {}, {}, {}, {},
> {0x7, 0x0, 0xb, 0x3, 0x0, 0x0, 0xff600000}, {0x85, 0x0, 0x0, 0x71}}]},
> &(0x7f0000000200)=3D'GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0,
> 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0},
> 0x90)
> bpf$BPF_RAW_TRACEPOINT_OPEN(0x11,
> &(0x7f0000000540)=3D{&(0x7f0000000000)=3D'kfree\x00', r0}, 0x10)
>
> So syzkaller generated a BPF tracing program. 0x85 is BPF_JMP |
> BPF_CALL, which is used to invoke BPF helpers; 0x71 is 113, which is
> the number of the probe_read_kernel helper, which basically takes
> arbitrary values as input and casts them to kernel pointers, and then
> probe-reads them. And before that is some kinda ALU op with 0xff600000
> as immediate.
>
> So it looks like the answer to that question is "the BPF program tries
> to copy from the VSYSCALL page because syzkaller decided to write BPF
> code that does specifically that, and the BPF helper let it do that".

Indeed.

> copy_from_kernel_nofault() does check
> copy_from_kernel_nofault_allowed() to make sure the pointer really is
> a kernel pointer, and the X86 version of that rejects anything in the
> userspace part of the address space. But it does not know about the
> vsyscall area.

That's cureable. Untested fix below.

Thanks for the explanation!

       tglx

---
diff --git a/arch/x86/mm/maccess.c b/arch/x86/mm/maccess.c
index 6993f026adec..8e846833aa37 100644
--- a/arch/x86/mm/maccess.c
+++ b/arch/x86/mm/maccess.c
@@ -3,6 +3,8 @@
 #include <linux/uaccess.h>
 #include <linux/kernel.h>
=20
+#include <uapi/asm/vsyscall.h>
+
 #ifdef CONFIG_X86_64
 bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 {
@@ -15,6 +17,9 @@ bool copy_from_kernel_nofault_allowed(const void *unsafe_=
src, size_t size)
 	if (vaddr < TASK_SIZE_MAX + PAGE_SIZE)
 		return false;
=20
+	if ((vaddr & PAGE_MASK) =3D=3D VSYSCALL_ADDR)
+		return false;
+
 	/*
 	 * Allow everything during early boot before 'x86_virt_bits'
 	 * is initialized.  Needed for instruction decoding in early

