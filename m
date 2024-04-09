Return-Path: <bpf+bounces-26259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B24589D3FE
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 10:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D580283F41
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 08:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B40D7F47A;
	Tue,  9 Apr 2024 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Tkch436q"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE52F7E116;
	Tue,  9 Apr 2024 08:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712650566; cv=none; b=YJP+oJvKuXmFfF7lXw5baHuzN1Z+PAh2hbQ8aCk0BD6kocjtUmVmdNMCgPoQnUhaFl3TMbId9TbjfR+YjaV1T6u6OWneBdPXwLQBgpsUFAYAnl4IiievpNzlGMefIaYyvNeZAzAt603i18ZXEUvp/Hw3huuWfHo3Xq+XLEBpW6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712650566; c=relaxed/simple;
	bh=8HvCApuiy6ONW7tfYfgKhurDV6wmKYxjw6pCqGJW4qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2bIjaIxp4lOcwoi1USzcCf+uCFHhK99UlgLpOucklMvxjqqRPjSaed7F4aMbYbf/6rgRSS29Zdu+GFRq8ix11uwiNv5Uig1bZLnA06y1ciiRpADR9FAK/OJ0jI4NuHPcye4MgSIgKzfRyfYYvYr0LpKECWx2j9wWVeTAISQIfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Tkch436q; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RRSBY6/rtPwcAAaFW3HJTN9NeVlK6dzskGTvl9SWwlk=; b=Tkch436qG2RJnWFcSMxqYvcDnX
	KG41Odci/LVUbafwNby6jvXCU7pWNzdA7kTCzKMIXwBqhUsCZdJQ/m1WO7P1wwVr3UWL3FKQ84DTj
	3Y0Nm7/Hb8z/7M+x6gGufi1w4MnaBd/4/kw/q8rIge2shXxnq0XNhUGsMBqnP7+8WgGYrD+R5O7RW
	NmzLSh2XxGZb86K7eqKxsrt/5DqkIIQfcns4vAJNATXV6HCg58Pn5e8GEpmAjVI2PqCA2s2GECvwP
	LzPvDC4wbDZCF//QQEu6xOkY4cHn4GnwTHJAMtx8aYcWFfb6kVs5yKlSvvAWZkkP7UAVJfivrERak
	0CriE9Ug==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38758)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ru6dz-000640-0N;
	Tue, 09 Apr 2024 09:15:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ru6dx-0004vn-Gs; Tue, 09 Apr 2024 09:15:49 +0100
Date: Tue, 9 Apr 2024 09:15:49 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	syzbot <syzbot+186522670e6722692d86@syzkaller.appspotmail.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
	bpf <bpf@vger.kernel.org>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 copy_from_kernel_nofault (2)
Message-ID: <ZhT5NRYnceirmAGz@shell.armlinux.org.uk>
References: <000000000000e9a8d80615163f2a@google.com>
 <20240403184149.0847a9d614f11b249529fd02@linux-foundation.org>
 <CAADnVQ+meL1kvXUehDT3iO2mxiZNeSUqeRKYx1C=3c0h=NSiqA@mail.gmail.com>
 <Zg_aTFoC2Pwakyl1@FVFF77S0Q05N>
 <Zg/iGQCDKa9bllyI@shell.armlinux.org.uk>
 <CAADnVQ+LKO2Y90DVZ4qQv3dXyuWKkvFqqJ0E_p_=qwscsvnaVg@mail.gmail.com>
 <CAEf4BzYNc-cxRu9qEe2DWdCBNwXAvpSBHKtUhXtoEhB_XNc1Gg@mail.gmail.com>
 <ZhBAnvLRfj/JW5bZ@shell.armlinux.org.uk>
 <mb61pcyqzx9l9.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mb61pcyqzx9l9.fsf@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 09, 2024 at 07:45:54AM +0000, Puranjay Mohan wrote:
> "Russell King (Oracle)" <linux@armlinux.org.uk> writes:
> 
> > On Fri, Apr 05, 2024 at 10:50:30AM -0700, Andrii Nakryiko wrote:
> >> On Fri, Apr 5, 2024 at 9:30 AM Alexei Starovoitov
> >> <alexei.starovoitov@gmail.com> wrote:
> >> >
> >> > On Fri, Apr 5, 2024 at 4:36 AM Russell King (Oracle)
> >> > <linux@armlinux.org.uk> wrote:
> >> > >
> >> > > On Fri, Apr 05, 2024 at 12:02:36PM +0100, Mark Rutland wrote:
> >> > > > On Thu, Apr 04, 2024 at 03:57:04PM -0700, Alexei Starovoitov wrote:
> >> > > > > On Wed, Apr 3, 2024 at 6:56 PM Andrew Morton <akpm@linux-foundationorg> wrote:
> >> > > > > >
> >> > > > > > On Mon, 01 Apr 2024 22:19:25 -0700 syzbot <syzbot+186522670e6722692d86@syzkaller.appspotmail.com> wrote:
> >> > > > > >
> >> > > > > > > Hello,
> >> > > > > >
> >> > > > > > Thanks.  Cc: bpf@vger.kernel.org
> >> > > > >
> >> > > > > I suspect the issue is not on bpf side.
> >> > > > > Looks like the bug is somewhere in arm32 bits.
> >> > > > > copy_from_kernel_nofault() is called from lots of places.
> >> > > > > bpf is just one user that is easy for syzbot to fuzz.
> >> > > > > Interestingly arm defines copy_from_kernel_nofault_allowed()
> >> > > > > that should have filtered out user addresses.
> >> > > > > In this case ffffffe9 is probably a kernel address?
> >> > > >
> >> > > > It's at the end of the kernel range, and it's ERR_PTR(-EINVAL).
> >> > > >
> >> > > > 0xffffffe9 is -0x16, which is -22, which is -EINVAL.
> >> > > >
> >> > > > > But the kernel is doing a write?
> >> > > > > Which makes no sense, since copy_from_kernel_nofault is probe reading.
> >> > > >
> >> > > > It makes perfect sense; the read from 'src' happened, then the kernel tries to
> >> > > > write the result to 'dst', and that aligns with the disassembly in the report
> >> > > > below, which I beleive is:
> >> > > >
> >> > > >      8: e4942000        ldr     r2, [r4], #0  <-- Read of 'src', fault fixup is elsewhere
> >> > > >      c: e3530000        cmp     r3, #0
> >> > > >   * 10: e5852000        str     r2, [r5]      <-- Write to 'dst'
> >> > > >
> >> > > > As above, it looks like 'dst' is ERR_PTR(-EINVAL).
> >> > > >
> >> > > > Are you certain that BPF is passing a sane value for 'dst'? Where does that
> >> > > > come from in the first place?
> >> > >
> >> > > It looks to me like it gets passed in from the BPF program, and the
> >> > > "type" for the argument is set to ARG_PTR_TO_UNINIT_MEM. What that
> >> > > means for validation purposes, I've no idea, I'm not a BPF hacker.
> >> > >
> >> > > Obviously, if BPF is allowing copy_from_kernel_nofault() to be passed
> >> > > an arbitary destination address, that would be a huge security hole.
> >> >
> >> > If that's the case that's indeed a giant security hole,
> >> > but I doubt it. We would be crashing other archs as well.
> >> > I cannot really tell whether arm32 JIT is on.
> >> > If it is, it's likely a bug there.
> >> > Puranjay,
> >> > could you please take a look.
> >> >
> >> 
> >> I dumped the BPF program that repro.c is loading, it works on x86-64
> >> and there is nothing special there. We are probe-reading 5 bytes from
> >> somewhere into the stack. Everything is unaligned here, but stays
> >> within a well-defined memory slot.
> >> 
> >> Note the r3 = (s8)r1, that's a new-ish thing, maybe bug is somewhere
> >> there (but then it would be JIT, not verifier itself)
> >> 
> >>    0: (7a) *(u64 *)(r10 -8) = 896542069
> >>    1: (bf) r1 = r10
> >>    2: (07) r1 += -7
> >>    3: (b7) r2 = 5
> >>    4: (bf) r3 = (s8)r1
> >>    5: (85) call bpf_probe_read_kernel#-72390
> >
> 
> I have started looking into this, the issue only reproduces when the JIT
> is enabled. With the interpreter, it works fine.
> 
> I used GDB to dump the JITed BPF program:
> 
>    0xbf00012c:  push    {r4, r5, r6, r7, r8, r9, r11, lr}
>    0xbf000130:  mov     r11, sp
>    0xbf000134:  mov     r3, #0
>    0xbf000138:  sub     r2, sp, #80     @ 0x50
>    0xbf00013c:  sub     sp, sp, #88     @ 0x58
>    0xbf000140:  strd    r2, [r11, #-64] @ 0xffffffc0
>    0xbf000144:  mov     r2, #0
>    0xbf000148:  strd    r2, [r11, #-72] @ 0xffffffb8
>    0xbf00014c:  mov     r2, r0
>    0xbf000150:  movw    r8, #9589       @ 0x2575
>    0xbf000154:  movt    r8, #13680      @ 0x3570
>    0xbf000158:  mov     r9, #0
>    0xbf00015c:  ldr     r6, [r11, #-64] @ 0xffffffc0
>    0xbf000160:  str     r8, [r6, #-8]
>    0xbf000164:  str     r9, [r6, #-4]
>    0xbf000168:  ldrd    r2, [r11, #-64] @ 0xffffffc0
>    0xbf00016c:  movw    r8, #65529      @ 0xfff9
>    0xbf000170:  movt    r8, #65535      @ 0xffff
>    0xbf000174:  movw    r9, #65535      @ 0xffff
>    0xbf000178:  movt    r9, #65535      @ 0xffff
>    0xbf00017c:  adds    r2, r2, r8
>    0xbf000180:  adc     r3, r3, r9
>    0xbf000184:  mov     r6, #5
>    0xbf000188:  mov     r7, #0
>    0xbf00018c:  strd    r6, [r11, #-8]
>    0xbf000190:  ldrd    r6, [r11, #-16]

Up to this point, it looks correct. r2/r3 contain the stack pointer
which corresponds to the instruction at "2:"

>    0xbf000194:  lsl     r2, r2, #24
>    0xbf000198:  asr     r2, r2, #24
>    0xbf00019c:  str     r2, [r11, #-16]

This then narrows the 64-bit pointer down to just 8!!! bits, but this
is what the instruction at "4:" is asking for. However, it looks like
it's happening to BPF's "r1" rather than "r3" and this is probably
where the problem lies.

I haven't got time to analyse this further this morning - I'm only
around sporadically today. I'll try to look deeper at this later on.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

