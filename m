Return-Path: <bpf+bounces-26265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D0D89D62F
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 12:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 967BBB23749
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 10:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FC680BF0;
	Tue,  9 Apr 2024 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4yMUaEq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC7D80622;
	Tue,  9 Apr 2024 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657011; cv=none; b=XPh9EdFGkOYIsJgJ/Gs0a0wvGgFLSRLMFmvuoxRnN3TXk+N9p3d9rQRUOQ13Tqs0tcxeHMeD34FoUPpoL3+64VjaPI5uK2S4KekyzsD52H3siPxWRvYnkBxtNvhGBRhZkZbsUvytHwOemwbb0fscpbJMUIBfU64ngLP7AoykKq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657011; c=relaxed/simple;
	bh=7AjdPQ0FlCjsfvvV5eTPiyoqGmSy4+kLRz35LJWj8nU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fGlUkGp0uLPoedMaEZ3DLtl/tZ39d604rwYmfUd4/dT82EB3jYcAFRVD7QogzArvG68euk8cV9XL4WZakYznAq2dXNnAXeab9hgDTCwZnok6wHA1ZpDqqZizVPx2AjUiLNK2fIWHZYxr9rVb8Y/npKvQiq+NPyS3KodfFXfKLP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4yMUaEq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-415523d9824so55251945e9.3;
        Tue, 09 Apr 2024 03:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712657008; x=1713261808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VjADMTPZqcstz8lVC2gm5IpQDMR3KXmVjspn4JhSPv0=;
        b=a4yMUaEqnPMwhkDWKJgafpA3+xRoSUUnAhh4k+pdjpm/xM0IW1IGeevmE/iiPu+582
         L8VD6u0K0aiQYAtBRW6SeeVtF7KkOSXedmwvJMOmmQOy3E4zHt79QtbgFy/V2Gy6PUwP
         LdwGQwFLCnh6CH4F1gJ7ot1iLlDTsY3UpJnhdAEuKzX1nOL4RdbT2dBnzq2g0nr2DLim
         S8GDGdaub/bdmHxwUJVMJ7BYmGaLXqJGABCJNOz/k9rXNPrty239co6HjwfEiwNvI7A7
         EEIi5mF0teF9JHqVpjf6rsVGr92ZrQ4qWyICgyHOWPVnqLqpSfN/sFqc/W49Y87+kBht
         fI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657008; x=1713261808;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjADMTPZqcstz8lVC2gm5IpQDMR3KXmVjspn4JhSPv0=;
        b=vNM1JcMN60maLlOVoY4j1auj8ltr5yYgv/t8fW0cQIthai3hnR9A4C7zQ9jWwEwTzN
         r3f3uPVw811d68IrjXNiFiDVl8yRTZt2PmlGpIEB/ere90yHsYp+HVvaq6KUCrEjTnRk
         /+qsT2Ap1fBsJPRbdOopCByuS3s1gqsw71LI0ZBxJrq9fAoK971v52U4M9YpYk7pAGNt
         G4r4TM3Pp8NoPhy3tBuMiH2ZYrqAXzz9OJdMqW1jZvk6UAnfAQDJYDWZUnskeNT8m/Dp
         4d7tpoYBSi4Ue+GlYbmnhvAGK0m+0TzYfpB+npnswUO08/wRSs4AbBjUE9ubwIGrOsr3
         GXYw==
X-Forwarded-Encrypted: i=1; AJvYcCUZj+LPEYoX0nSBytMZrD21flO5vzidLhROqviB4GUbUlZfl9Er33PsVUMWXfB+VL0AaTBFnugNy8pFm7k+MzBT8WbdKv9Kyu1HvctXRtWJ+mj/CUEtIndVbs7saHL6kJs8
X-Gm-Message-State: AOJu0YxPCKhWXu8+S2J9zpzQNRlp3RqOm0OWQAClDP8ohXEJRco6M2/A
	OHb9TKcr4ETWYh9Av2e6DmbdDMWF1Tb45aLrAlWl1By7P/bo2h8k
X-Google-Smtp-Source: AGHT+IFRgJDyiXvcoHUn5ECDGcIlw7ghQjN+ItwK0q590NBLs0v9v5Kf2Zqi2OSo/0F9WOd+9CIqSQ==
X-Received: by 2002:a05:600c:19d1:b0:416:8efd:1645 with SMTP id u17-20020a05600c19d100b004168efd1645mr3810151wmq.7.1712657007887;
        Tue, 09 Apr 2024 03:03:27 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c19ca00b0041632fcf272sm14159656wmq.22.2024.04.09.03.03.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2024 03:03:27 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: syzbot <syzbot+186522670e6722692d86@syzkaller.appspotmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>, LKML <linux-kernel@vger.kernel.org>, linux-mm
 <linux-mm@kvack.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 bpf <bpf@vger.kernel.org>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 copy_from_kernel_nofault (2)
In-Reply-To: <ZhT5NRYnceirmAGz@shell.armlinux.org.uk>
References: <000000000000e9a8d80615163f2a@google.com>
 <20240403184149.0847a9d614f11b249529fd02@linux-foundation.org>
 <CAADnVQ+meL1kvXUehDT3iO2mxiZNeSUqeRKYx1C=3c0h=NSiqA@mail.gmail.com>
 <Zg_aTFoC2Pwakyl1@FVFF77S0Q05N> <Zg/iGQCDKa9bllyI@shell.armlinux.org.uk>
 <CAADnVQ+LKO2Y90DVZ4qQv3dXyuWKkvFqqJ0E_p_=qwscsvnaVg@mail.gmail.com>
 <CAEf4BzYNc-cxRu9qEe2DWdCBNwXAvpSBHKtUhXtoEhB_XNc1Gg@mail.gmail.com>
 <ZhBAnvLRfj/JW5bZ@shell.armlinux.org.uk> <mb61pcyqzx9l9.fsf@gmail.com>
 <ZhT5NRYnceirmAGz@shell.armlinux.org.uk>
Date: Tue, 09 Apr 2024 10:03:01 +0000
Message-ID: <mb61pa5m2yht6.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Russell King (Oracle)" <linux@armlinux.org.uk> writes:

> On Tue, Apr 09, 2024 at 07:45:54AM +0000, Puranjay Mohan wrote:
>> "Russell King (Oracle)" <linux@armlinux.org.uk> writes:
>>=20
>> > On Fri, Apr 05, 2024 at 10:50:30AM -0700, Andrii Nakryiko wrote:
>> >> On Fri, Apr 5, 2024 at 9:30=E2=80=AFAM Alexei Starovoitov
>> >> <alexei.starovoitov@gmail.com> wrote:
>> >> >
>> >> > On Fri, Apr 5, 2024 at 4:36=E2=80=AFAM Russell King (Oracle)
>> >> > <linux@armlinux.org.uk> wrote:
>> >> > >
>> >> > > On Fri, Apr 05, 2024 at 12:02:36PM +0100, Mark Rutland wrote:
>> >> > > > On Thu, Apr 04, 2024 at 03:57:04PM -0700, Alexei Starovoitov wr=
ote:
>> >> > > > > On Wed, Apr 3, 2024 at 6:56=E2=80=AFPM Andrew Morton <akpm@li=
nux-foundationorg> wrote:
>> >> > > > > >
>> >> > > > > > On Mon, 01 Apr 2024 22:19:25 -0700 syzbot <syzbot+186522670=
e6722692d86@syzkaller.appspotmail.com> wrote:
>> >> > > > > >
>> >> > > > > > > Hello,
>> >> > > > > >
>> >> > > > > > Thanks.  Cc: bpf@vger.kernel.org
>> >> > > > >
>> >> > > > > I suspect the issue is not on bpf side.
>> >> > > > > Looks like the bug is somewhere in arm32 bits.
>> >> > > > > copy_from_kernel_nofault() is called from lots of places.
>> >> > > > > bpf is just one user that is easy for syzbot to fuzz.
>> >> > > > > Interestingly arm defines copy_from_kernel_nofault_allowed()
>> >> > > > > that should have filtered out user addresses.
>> >> > > > > In this case ffffffe9 is probably a kernel address?
>> >> > > >
>> >> > > > It's at the end of the kernel range, and it's ERR_PTR(-EINVAL).
>> >> > > >
>> >> > > > 0xffffffe9 is -0x16, which is -22, which is -EINVAL.
>> >> > > >
>> >> > > > > But the kernel is doing a write?
>> >> > > > > Which makes no sense, since copy_from_kernel_nofault is probe=
 reading.
>> >> > > >
>> >> > > > It makes perfect sense; the read from 'src' happened, then the =
kernel tries to
>> >> > > > write the result to 'dst', and that aligns with the disassembly=
 in the report
>> >> > > > below, which I beleive is:
>> >> > > >
>> >> > > >      8: e4942000        ldr     r2, [r4], #0  <-- Read of 'src'=
, fault fixup is elsewhere
>> >> > > >      c: e3530000        cmp     r3, #0
>> >> > > >   * 10: e5852000        str     r2, [r5]      <-- Write to 'dst'
>> >> > > >
>> >> > > > As above, it looks like 'dst' is ERR_PTR(-EINVAL).
>> >> > > >
>> >> > > > Are you certain that BPF is passing a sane value for 'dst'? Whe=
re does that
>> >> > > > come from in the first place?
>> >> > >
>> >> > > It looks to me like it gets passed in from the BPF program, and t=
he
>> >> > > "type" for the argument is set to ARG_PTR_TO_UNINIT_MEM. What that
>> >> > > means for validation purposes, I've no idea, I'm not a BPF hacker.
>> >> > >
>> >> > > Obviously, if BPF is allowing copy_from_kernel_nofault() to be pa=
ssed
>> >> > > an arbitary destination address, that would be a huge security ho=
le.
>> >> >
>> >> > If that's the case that's indeed a giant security hole,
>> >> > but I doubt it. We would be crashing other archs as well.
>> >> > I cannot really tell whether arm32 JIT is on.
>> >> > If it is, it's likely a bug there.
>> >> > Puranjay,
>> >> > could you please take a look.
>> >> >
>> >>=20
>> >> I dumped the BPF program that repro.c is loading, it works on x86-64
>> >> and there is nothing special there. We are probe-reading 5 bytes from
>> >> somewhere into the stack. Everything is unaligned here, but stays
>> >> within a well-defined memory slot.
>> >>=20
>> >> Note the r3 =3D (s8)r1, that's a new-ish thing, maybe bug is somewhere
>> >> there (but then it would be JIT, not verifier itself)
>> >>=20
>> >>    0: (7a) *(u64 *)(r10 -8) =3D 896542069
>> >>    1: (bf) r1 =3D r10
>> >>    2: (07) r1 +=3D -7
>> >>    3: (b7) r2 =3D 5
>> >>    4: (bf) r3 =3D (s8)r1
>> >>    5: (85) call bpf_probe_read_kernel#-72390
>> >
>>=20
>> I have started looking into this, the issue only reproduces when the JIT
>> is enabled. With the interpreter, it works fine.
>>=20
>> I used GDB to dump the JITed BPF program:
>>=20
>>    0xbf00012c:  push    {r4, r5, r6, r7, r8, r9, r11, lr}
>>    0xbf000130:  mov     r11, sp
>>    0xbf000134:  mov     r3, #0
>>    0xbf000138:  sub     r2, sp, #80     @ 0x50
>>    0xbf00013c:  sub     sp, sp, #88     @ 0x58
>>    0xbf000140:  strd    r2, [r11, #-64] @ 0xffffffc0
>>    0xbf000144:  mov     r2, #0
>>    0xbf000148:  strd    r2, [r11, #-72] @ 0xffffffb8
>>    0xbf00014c:  mov     r2, r0
>>    0xbf000150:  movw    r8, #9589       @ 0x2575
>>    0xbf000154:  movt    r8, #13680      @ 0x3570
>>    0xbf000158:  mov     r9, #0
>>    0xbf00015c:  ldr     r6, [r11, #-64] @ 0xffffffc0
>>    0xbf000160:  str     r8, [r6, #-8]
>>    0xbf000164:  str     r9, [r6, #-4]
>>    0xbf000168:  ldrd    r2, [r11, #-64] @ 0xffffffc0
>>    0xbf00016c:  movw    r8, #65529      @ 0xfff9
>>    0xbf000170:  movt    r8, #65535      @ 0xffff
>>    0xbf000174:  movw    r9, #65535      @ 0xffff
>>    0xbf000178:  movt    r9, #65535      @ 0xffff
>>    0xbf00017c:  adds    r2, r2, r8
>>    0xbf000180:  adc     r3, r3, r9
>>    0xbf000184:  mov     r6, #5
>>    0xbf000188:  mov     r7, #0
>>    0xbf00018c:  strd    r6, [r11, #-8]
>>    0xbf000190:  ldrd    r6, [r11, #-16]
>
> Up to this point, it looks correct. r2/r3 contain the stack pointer
> which corresponds to the instruction at "2:"
>
>>    0xbf000194:  lsl     r2, r2, #24
>>    0xbf000198:  asr     r2, r2, #24
>>    0xbf00019c:  str     r2, [r11, #-16]
>
> This then narrows the 64-bit pointer down to just 8!!! bits, but this
> is what the instruction at "4:" is asking for. However, it looks like
> it's happening to BPF's "r1" rather than "r3" and this is probably
> where the problem lies.
>
> I haven't got time to analyse this further this morning - I'm only
> around sporadically today. I'll try to look deeper at this later on.
>
> --=20
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

I found the problem. The implementation of Sign extended move is broken,
it clobbers the source register. I have sent a patch to fix it and also
fixed another issue that I saw:
https://lore.kernel.org/bpf/20240409095038.26356-1-puranjay@kernel.org/

I have manually tested with the reproducer but let's try to rerun the
reproducer through syzbot:

#syz test: https://github.com/puranjaymohan/linux.git arm32_movsx_fix

