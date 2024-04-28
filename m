Return-Path: <bpf+bounces-28048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0A98B4DB4
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 22:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E692815DD
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 20:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E2A745E4;
	Sun, 28 Apr 2024 20:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NAbcl/g2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E1056B60
	for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 20:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714334502; cv=none; b=n5bExfR1kFcKFdscsvK6Wc0eU7ByM+QFldNR1H9hryuRVd0WjJ5YWthhQtJoHOfIpkTSb8iovZTvFGUCF1cIWzei9EUkBuOf+TAwkSafyFKM6VRHMunIuzyd33CR8x53PKX7hLE1/8m+x6xywb5FkcwSNtaLT5ckWGSikI++ecg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714334502; c=relaxed/simple;
	bh=/Q+bDcW8FGbBSw2YCBIscaZoTZy5JAddruxkYSnGwj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LaH/xu18fAuzPQ237xFeQZKKmV4IcT84Qr/ZsVW3ycddvgXA9GUqdrY3eIGfyx7k3Kej2abq9jyDPfjEXk3q98eCPkD05CoULm6EL0jsx0eVz5cPj+0fqe5Z8+lmesIiv+cT4Ys7DpAxkV5qNRUIIRR3hjKswdJ63SufRiJ3SQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NAbcl/g2; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51d2047220cso1286440e87.1
        for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 13:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714334498; x=1714939298; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yAlWMFpu06lOa2HCRJcPKhFggZdYhuIIy04Pcfhn4Io=;
        b=NAbcl/g2vi8Ka51B1vsuUciX7tTbQQyj5e6joMpnQ7aLvqRA33y4a/zCz38l1cox4F
         yXah57HQfnauETg56EE4ORorycdj4o8u3SZtcz6yHjUZ0WfbhP+ygMvkvsJcb7qbHIH8
         je0L3wd37n+VMZg7nIxo4NinojPlJvdSwRyU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714334498; x=1714939298;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAlWMFpu06lOa2HCRJcPKhFggZdYhuIIy04Pcfhn4Io=;
        b=bXFbYxQdBJ2cgKmUzSyXqSQ35Zrc+BOQyrouVDjSzlgwWeaVHSXv86Mq0ngPzvF8va
         bVLFngTsLaSn68/bWPZeaoLaOnYdziSfFdCDpFRwzAxOWcTQRJdy8cCE2D5SkKvQ/0vv
         ZjDzplzxAA7+q0j3g0w/lxoDi0BBwXUhMYh3mEUhNm0PTFzoMJbfQvANkreo0n+387Wq
         s33TgvmBibYY5SceOTv32yZj6km+uBZnohOnRYa2oAdmB/iw49JU1nDT1xVAIRxFXtkf
         cZTgdFqzLdH7seMoMRxkT2Xj24buFpx2q6AUB9Ep4Q2KqE8Xu/9SvuedD84kd0FtA1Lo
         eg1w==
X-Forwarded-Encrypted: i=1; AJvYcCWbv3G0s5FQMEGKVJ8vaciPFlssEacJ4o9f5lLeJtYm4RLVpsa1ZKxNWykvFuXBZ6qA7UPvPCRr7XMtzV9hnrJy0pdM
X-Gm-Message-State: AOJu0Yz3HI00Va9Dd3okRfTssIw0wIlbMK2rhmA9KRpZitu85u/8obe2
	hv9vykTDXUq7nWOdK7rSWsZwSeMxAzknLibIfmYQNxw0kK0U7lmXRCmRjNiskaY1x+UgjAYK+a9
	dft77rw==
X-Google-Smtp-Source: AGHT+IGN352vLTECkj3LKl4vhkvChUSW2XOj3SG4l0bW1h9U5s0OwY0bBSVAmPJhcMp3K1XY7WWTMA==
X-Received: by 2002:a05:6512:684:b0:518:17ad:a6e0 with SMTP id t4-20020a056512068400b0051817ada6e0mr5712202lfe.51.1714334497780;
        Sun, 28 Apr 2024 13:01:37 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id s8-20020a197708000000b00516cef1f1casm3929875lfc.181.2024.04.28.13.01.37
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 13:01:37 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5194cebd6caso4223561e87.0
        for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 13:01:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpJ6VVZAVEaxdxpq7vtH12RfWxjhV6BqApHwtie/2+xCzQsbmlceIG8QC4XUzbpNuOxxDszW3huf90NHTSztT8PNYX
X-Received: by 2002:a05:6512:3a85:b0:51b:58c7:d04d with SMTP id
 q5-20020a0565123a8500b0051b58c7d04dmr6353661lfu.0.1714334496870; Sun, 28 Apr
 2024 13:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009dfa6d0617197994@google.com> <20240427231321.3978-1-hdanton@sina.com>
In-Reply-To: <20240427231321.3978-1-hdanton@sina.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Apr 2024 13:01:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com>
Message-ID: <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in force_sig_info_to_task
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>, 
	andrii@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Apr 2024 at 16:13, Hillf Danton <hdanton@sina.com> wrote:
>
> > -> #0 (&sighand->siglock){....}-{2:2}:
> >        check_prev_add kernel/locking/lockdep.c:3134 [inline]
> >        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
> >        validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
> >        __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
> >        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
> >        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >        _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
> >        force_sig_info_to_task+0x68/0x580 kernel/signal.c:1334
> >        force_sig_fault_to_task kernel/signal.c:1733 [inline]
> >        force_sig_fault+0x12c/0x1d0 kernel/signal.c:1738
> >        __bad_area_nosemaphore+0x127/0x780 arch/x86/mm/fault.c:814
> >        handle_page_fault arch/x86/mm/fault.c:1505 [inline]
>
> Given page fault with runqueue locked, bpf makes trouble instead of
> helping anything in this case.

That's not the odd thing here.

Look, the callchain is:

> >        exc_page_fault+0x612/0x8e0 arch/x86/mm/fault.c:1563
> >        asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
> >        rep_movs_alternative+0x22/0x70 arch/x86/lib/copy_user_64.S:48
> >        copy_user_generic arch/x86/include/asm/uaccess_64.h:110 [inline]
> >        raw_copy_from_user arch/x86/include/asm/uaccess_64.h:125 [inline]
> >        __copy_from_user_inatomic include/linux/uaccess.h:87 [inline]
> >        copy_from_user_nofault+0xbc/0x150 mm/maccess.c:125

IOW, this is all doing a copy from user with page faults disabled, and
it shouldn't have caused a signal to be sent, so the whole
__bad_area_nosemaphore -> force_sig_fault path is bad.

The *problem* here is that the page fault doesn't actually happen on a
user access, it happens on the *ret* instruction in
rep_movs_alternative itself (which doesn't have a exception fixup,
obviously, because no exception is supposed to happen there!):

  RIP: 0010:rep_movs_alternative+0x22/0x70 arch/x86/lib/copy_user_64.S:50
  Code: 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 83 f9 40 73 40 83 f9 08
73 21 85 c9 74 0f 8a 06 88 07 48 ff c7 48 ff c6 48 ff c9 75 f1 <c3> cc
cc cc cc 66 0f 1f 84 00 00 0$
  RSP: 0000:ffffc90004137468 EFLAGS: 00050002
  RAX: ffffffff8205ce4e RBX: dffffc0000000000 RCX: 0000000000000002
  RDX: 0000000000000000 RSI: 0000000000000900 RDI: ffffc900041374e8
  RBP: ffff88802d039784 R08: 0000000000000005 R09: ffffffff8205ce37
  R10: 0000000000000003 R11: ffff88802d038000 R12: 1ffff11005a072f0
  R13: 0000000000000900 R14: 0000000000000002 R15: ffffc900041374e8

where decoding that "Code:" line gives this:

   0: f3 0f 1e fa          endbr64
   4: 48 83 f9 40          cmp    $0x40,%rcx
   8: 73 40                jae    0x4a
   a: 83 f9 08              cmp    $0x8,%ecx
   d: 73 21                jae    0x30
   f: 85 c9                test   %ecx,%ecx
  11: 74 0f                je     0x22
  13: 8a 06                mov    (%rsi),%al
  15: 88 07                mov    %al,(%rdi)
  17: 48 ff c7              inc    %rdi
  1a: 48 ff c6              inc    %rsi
  1d: 48 ff c9              dec    %rcx
  20: 75 f1                jne    0x13
  22:* c3                    ret <-- trapping instruction

but I have no idea why the 'ret' instruction would take a page fault.
It really shouldn't.

Now, it's not like 'ret' instructions can't take page faults, but it
sure shouldn't happen in the *kernel*. The reasons for page faults on
'ret' instructions are:

 - the instruction itself takes a page fault

 - the stack pointer is bogus

 - possibly because the stack *contents* are bogus (at least some x86
instructions that jump will check the destination in the jump
instruction itself, although I didn't think 'ret' was one of them)

but for the kernel, none of these actually seem to be the case
normally. And even abnormally I don't see this being an issue, since
the exception backtrace is happily shown (ie the stack looks all
good).

So this dump is just *WEIRD*.

End result: the problem is not about any kind of deadlock on circular
locking. That's just the symptom of that odd page fault that shouldn't
have happened, and that I don't quite see how it happened.

               Linus

