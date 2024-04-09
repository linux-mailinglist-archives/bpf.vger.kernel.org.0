Return-Path: <bpf+bounces-26254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7298689D388
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 09:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2177428299E
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 07:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBAA7D09F;
	Tue,  9 Apr 2024 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz8JzFeE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0B17CF17;
	Tue,  9 Apr 2024 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712648761; cv=none; b=qkGSRWY1YZgZIWllxSESdmi0pD9VzrAUfaMZWbKHoSszEOAbQTMvmWGK4fgOqTqoUVZUkrsztU38jzkA83C8H6AXmhlCbHlWZWf3y0dbD/H1tUqabxqyT/X3mkQOrWcpUdom+UoGYHxLZwXfLvd1wdM2iCUDKJzKZCdaYR4xEGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712648761; c=relaxed/simple;
	bh=gEFrq6qnBYWiBwzxenQxEtcGLyXgvwTm1q5KCoyftSE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pVCa9PwQG/BoOX8/Lap/3F1rtPiOkT6xgVY1QoyaqX6gEc9/bk9suN9NghJdS9omuPYYNTCqb9axw5bWyyzQBeSOKuUvJT6f+W9NvME+5ONtqfhz0ZSwuk7awIUfEcQcdM7izPlLqIR2FddBF6lMv+rRJFlc8Dc2GMKJF7Xv+B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gz8JzFeE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-345e1c64695so718409f8f.1;
        Tue, 09 Apr 2024 00:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712648758; x=1713253558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYjf00jBH0Rb8lew+KMaX2TbsCfyE+4RpDstXxT0XI0=;
        b=gz8JzFeEzBO/t4gAEGwWO1gvgSvsD5zutVXMNGjCJdhaVxPhh/nBEdFv5PR4AG5Q6m
         9ieHMTVsUdUhZ0VqW24746kfy15NaeEn8OnzMWIamTN6eSdf/AtjZbInT9PDB7qEEIim
         7fr/e76UIEGvqtmIuvQaE+2ps/g+m1oJXMXx+m8jhp/Z4voO6DXqF4Ejr96J7AZhwB/c
         rGWpccNC4hjSIHpiOUqyw42ZRHc3VOUt/t7MMMVLsug1jNH0ycg6tsbNM3ztEej0HJZd
         3E2jZZVq4VVa13F5ejEMTok3LEK1aL/RwGHKZFO0i4yTGB4rOZ+BEdmP5i3Ptah+tuxv
         ilnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712648758; x=1713253558;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYjf00jBH0Rb8lew+KMaX2TbsCfyE+4RpDstXxT0XI0=;
        b=qSQ2EoqhIV9nFcbyPhNV027QjmDLVv96HI21WkbDAd5tHHYUyEUzBq8RUHoadGBfiU
         5n+R1Na0vEXHEGV61mHJiumb88q3Y6E2Avaa3pk5Qpu0qoH9blawAbebDQOouuL88405
         yRqNQYqEK7uD3ZOKyd2h9R8sQlo0RJfZjCbvggaHkjG/LWp09zjWDMfYl7I5Ab+R7xww
         JZj3eKbhtWi21L0qcKN5M2ZQAbPg1xsasi5Wb5mExkF93PIyaNf0Jfwqn2UXI3UiIUY/
         wX/+JFb6QTBM/LwLT/ZsNgdvhSvcDma+QiJb9DZohkUHCndyDvc1wDzl7+XNJJ4NTsFd
         G0Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWQhmmiycmBuMcnBp3DjqY4zbXdTG5p25zFlQjARMlHGgpO9y7ZCxABYS6npiR0TJyZXtc6Jgsdj1nQ8OCHJMx52HfK5cqdunzHSXeALEk6mTg6sW6qFGs381BKmEdUxPFE
X-Gm-Message-State: AOJu0YyxySikgHAgn+C6KgrXxc0rOBNra3HJks83DFdz9agH1rdxFLxc
	qkvMOVQ6+q7yPgSC23FGT3orDISBoWZTp8Q3xy5EK2RCTxmWXNxZ
X-Google-Smtp-Source: AGHT+IGa2PZeToYId1gdUUSd9DtmWBHX4GKe4xxDWC8xPGS7olJXLSXKKR6QKrnPUZaDKceg1VBH3Q==
X-Received: by 2002:adf:f5cd:0:b0:33e:72f4:d6b5 with SMTP id k13-20020adff5cd000000b0033e72f4d6b5mr7049667wrp.66.1712648757690;
        Tue, 09 Apr 2024 00:45:57 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id m5-20020a5d56c5000000b00341ce80ea66sm10740263wrw.82.2024.04.09.00.45.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2024 00:45:57 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Mark Rutland
 <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, syzbot
 <syzbot+186522670e6722692d86@syzkaller.appspotmail.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>, bpf
 <bpf@vger.kernel.org>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 copy_from_kernel_nofault (2)
In-Reply-To: <ZhBAnvLRfj/JW5bZ@shell.armlinux.org.uk>
References: <000000000000e9a8d80615163f2a@google.com>
 <20240403184149.0847a9d614f11b249529fd02@linux-foundation.org>
 <CAADnVQ+meL1kvXUehDT3iO2mxiZNeSUqeRKYx1C=3c0h=NSiqA@mail.gmail.com>
 <Zg_aTFoC2Pwakyl1@FVFF77S0Q05N> <Zg/iGQCDKa9bllyI@shell.armlinux.org.uk>
 <CAADnVQ+LKO2Y90DVZ4qQv3dXyuWKkvFqqJ0E_p_=qwscsvnaVg@mail.gmail.com>
 <CAEf4BzYNc-cxRu9qEe2DWdCBNwXAvpSBHKtUhXtoEhB_XNc1Gg@mail.gmail.com>
 <ZhBAnvLRfj/JW5bZ@shell.armlinux.org.uk>
Date: Tue, 09 Apr 2024 07:45:54 +0000
Message-ID: <mb61pcyqzx9l9.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Russell King (Oracle)" <linux@armlinux.org.uk> writes:

> On Fri, Apr 05, 2024 at 10:50:30AM -0700, Andrii Nakryiko wrote:
>> On Fri, Apr 5, 2024 at 9:30=E2=80=AFAM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>> >
>> > On Fri, Apr 5, 2024 at 4:36=E2=80=AFAM Russell King (Oracle)
>> > <linux@armlinux.org.uk> wrote:
>> > >
>> > > On Fri, Apr 05, 2024 at 12:02:36PM +0100, Mark Rutland wrote:
>> > > > On Thu, Apr 04, 2024 at 03:57:04PM -0700, Alexei Starovoitov wrote:
>> > > > > On Wed, Apr 3, 2024 at 6:56=E2=80=AFPM Andrew Morton <akpm@linux=
-foundationorg> wrote:
>> > > > > >
>> > > > > > On Mon, 01 Apr 2024 22:19:25 -0700 syzbot <syzbot+186522670e67=
22692d86@syzkaller.appspotmail.com> wrote:
>> > > > > >
>> > > > > > > Hello,
>> > > > > >
>> > > > > > Thanks.  Cc: bpf@vger.kernel.org
>> > > > >
>> > > > > I suspect the issue is not on bpf side.
>> > > > > Looks like the bug is somewhere in arm32 bits.
>> > > > > copy_from_kernel_nofault() is called from lots of places.
>> > > > > bpf is just one user that is easy for syzbot to fuzz.
>> > > > > Interestingly arm defines copy_from_kernel_nofault_allowed()
>> > > > > that should have filtered out user addresses.
>> > > > > In this case ffffffe9 is probably a kernel address?
>> > > >
>> > > > It's at the end of the kernel range, and it's ERR_PTR(-EINVAL).
>> > > >
>> > > > 0xffffffe9 is -0x16, which is -22, which is -EINVAL.
>> > > >
>> > > > > But the kernel is doing a write?
>> > > > > Which makes no sense, since copy_from_kernel_nofault is probe re=
ading.
>> > > >
>> > > > It makes perfect sense; the read from 'src' happened, then the ker=
nel tries to
>> > > > write the result to 'dst', and that aligns with the disassembly in=
 the report
>> > > > below, which I beleive is:
>> > > >
>> > > >      8: e4942000        ldr     r2, [r4], #0  <-- Read of 'src', f=
ault fixup is elsewhere
>> > > >      c: e3530000        cmp     r3, #0
>> > > >   * 10: e5852000        str     r2, [r5]      <-- Write to 'dst'
>> > > >
>> > > > As above, it looks like 'dst' is ERR_PTR(-EINVAL).
>> > > >
>> > > > Are you certain that BPF is passing a sane value for 'dst'? Where =
does that
>> > > > come from in the first place?
>> > >
>> > > It looks to me like it gets passed in from the BPF program, and the
>> > > "type" for the argument is set to ARG_PTR_TO_UNINIT_MEM. What that
>> > > means for validation purposes, I've no idea, I'm not a BPF hacker.
>> > >
>> > > Obviously, if BPF is allowing copy_from_kernel_nofault() to be passed
>> > > an arbitary destination address, that would be a huge security hole.
>> >
>> > If that's the case that's indeed a giant security hole,
>> > but I doubt it. We would be crashing other archs as well.
>> > I cannot really tell whether arm32 JIT is on.
>> > If it is, it's likely a bug there.
>> > Puranjay,
>> > could you please take a look.
>> >
>>=20
>> I dumped the BPF program that repro.c is loading, it works on x86-64
>> and there is nothing special there. We are probe-reading 5 bytes from
>> somewhere into the stack. Everything is unaligned here, but stays
>> within a well-defined memory slot.
>>=20
>> Note the r3 =3D (s8)r1, that's a new-ish thing, maybe bug is somewhere
>> there (but then it would be JIT, not verifier itself)
>>=20
>>    0: (7a) *(u64 *)(r10 -8) =3D 896542069
>>    1: (bf) r1 =3D r10
>>    2: (07) r1 +=3D -7
>>    3: (b7) r2 =3D 5
>>    4: (bf) r3 =3D (s8)r1
>>    5: (85) call bpf_probe_read_kernel#-72390
>

I have started looking into this, the issue only reproduces when the JIT
is enabled. With the interpreter, it works fine.

I used GDB to dump the JITed BPF program:

   0xbf00012c:  push    {r4, r5, r6, r7, r8, r9, r11, lr}
   0xbf000130:  mov     r11, sp
   0xbf000134:  mov     r3, #0
   0xbf000138:  sub     r2, sp, #80     @ 0x50
   0xbf00013c:  sub     sp, sp, #88     @ 0x58
   0xbf000140:  strd    r2, [r11, #-64] @ 0xffffffc0
   0xbf000144:  mov     r2, #0
   0xbf000148:  strd    r2, [r11, #-72] @ 0xffffffb8
   0xbf00014c:  mov     r2, r0
   0xbf000150:  movw    r8, #9589       @ 0x2575
   0xbf000154:  movt    r8, #13680      @ 0x3570
   0xbf000158:  mov     r9, #0
   0xbf00015c:  ldr     r6, [r11, #-64] @ 0xffffffc0
   0xbf000160:  str     r8, [r6, #-8]
   0xbf000164:  str     r9, [r6, #-4]
   0xbf000168:  ldrd    r2, [r11, #-64] @ 0xffffffc0
   0xbf00016c:  movw    r8, #65529      @ 0xfff9
   0xbf000170:  movt    r8, #65535      @ 0xffff
   0xbf000174:  movw    r9, #65535      @ 0xffff
   0xbf000178:  movt    r9, #65535      @ 0xffff
   0xbf00017c:  adds    r2, r2, r8
   0xbf000180:  adc     r3, r3, r9
   0xbf000184:  mov     r6, #5
   0xbf000188:  mov     r7, #0
   0xbf00018c:  strd    r6, [r11, #-8]
   0xbf000190:  ldrd    r6, [r11, #-16]
   0xbf000194:  lsl     r2, r2, #24
   0xbf000198:  asr     r2, r2, #24
   0xbf00019c:  str     r2, [r11, #-16]
   0xbf0001a0:  asr     r7, r6, #31
   0xbf0001a4:  mov     r1, r3
   0xbf0001a8:  mov     r0, r2
   0xbf0001ac:  ldrd    r2, [r11, #-8]
   0xbf0001b0:  ldrd    r8, [r11, #-32] @ 0xffffffe0
   0xbf0001b4:  push    {r8, r9}
   0xbf0001b8:  ldrd    r8, [r11, #-24] @ 0xffffffe8
   0xbf0001bc:  push    {r8, r9}
   0xbf0001c0:  ldrd    r8, [r11, #-16]
   0xbf0001c4:  push    {r8, r9}
   0xbf0001c8:  movw    r6, #40536      @ 0x9e58
   0xbf0001cc:  movt    r6, #49223      @ 0xc047
   0xbf0001d0:  blx     r6
   0xbf0001d4:  add     sp, sp, #24
   0xbf0001d8:  mov     r0, #0
   0xbf0001dc:  mov     r1, #0
   0xbf0001e0:  mov     sp, r11
   0xbf0001e4:  pop     {r4, r5, r6, r7, r8, r9, r11, pc}

Thanks,
Puranjay

