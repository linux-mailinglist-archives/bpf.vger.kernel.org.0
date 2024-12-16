Return-Path: <bpf+bounces-47031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F04F9F2CC4
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 10:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844C01884755
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 09:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646DE201011;
	Mon, 16 Dec 2024 09:20:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ACE1FFC6E
	for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734340805; cv=none; b=G7NtjRXsM/W4fc0LY/eQY0tzhLuSC6q0RJN+d5TBQT2AS9f2hRDaskVjnDNqaW0BqbVU03IrT/jwzTvUFHR/Fhgxfe4rVzc+pQVJIP5PTVabBgDeseP31zbN4bjWbDtDlDoOaPgIN1W28nyoC5WBIKMkSargYhDulKEOjz3cPFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734340805; c=relaxed/simple;
	bh=nAfkE5KL69rWWdYUtkIqB/1eTj75dNe6HapH7wdww6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=CAHquOeSS6nFwGUnT+L96c7fGAzQK6/phKCKSR0wzRp9nIjVkmCSlzgmllqR0Ku3CcmdpDxI1r8KWuXlS1UNy925dog4PXpTayaoOGqfBsCSWHSFFXi2BFk4eH+9D/CWXNwT033qReA5QG0kE+44gNP7XOUhwbcKDuh5Umkm4GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-40-TWX7wBlFMTCe8lW0s-gXdA-1; Mon, 16 Dec 2024 09:20:00 +0000
X-MC-Unique: TWX7wBlFMTCe8lW0s-gXdA-1
X-Mimecast-MFC-AGG-ID: TWX7wBlFMTCe8lW0s-gXdA
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 16 Dec
 2024 09:18:56 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 16 Dec 2024 09:18:56 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jiri Olsa' <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko
	<andrii@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Song Liu
	<songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John Fastabend
	<john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Alan Maguire
	<alan.maguire@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>
Subject: RE: [PATCH bpf-next 08/13] uprobes/x86: Add support to optimize
 uprobes
Thread-Topic: [PATCH bpf-next 08/13] uprobes/x86: Add support to optimize
 uprobes
Thread-Index: AQHbS9GTSF5rwnXysUaDsufIVqYKlLLnNYvQgAFWD+SAAA72QA==
Date: Mon, 16 Dec 2024 09:18:56 +0000
Message-ID: <c5fb22629d3f42798def5b63ce834801@AcuMS.aculab.com>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-9-jolsa@kernel.org>
 <1521ff93bc0649b0aade9cfc444929ca@AcuMS.aculab.com>
 <20241215141412.GA13580@redhat.com> <Z1_gFymfO3sAwhiY@krava>
In-Reply-To: <Z1_gFymfO3sAwhiY@krava>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6ljY0Uz5jiXbJ5rJdMO12feP5X1rNm5CBxWCGnhSV1Y_1734340799
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Jiri Olsa
> Sent: 16 December 2024 08:09
>=20
> On Sun, Dec 15, 2024 at 03:14:13PM +0100, Oleg Nesterov wrote:
> > On 12/15, David Laight wrote:
> > >
> > > From: Jiri Olsa
> > > > The optimized uprobe path
> > > >
> > > >   - checks the original instruction is 5-byte nop (plus other check=
s)
> > > >   - adds (or uses existing) user space trampoline and overwrites or=
iginal
> > > >     instruction (5-byte nop) with call to user space trampoline
> > > >   - the user space trampoline executes uprobe syscall that calls re=
lated uprobe
> > > >     consumers
> > > >   - trampoline returns back to next instruction
> > > ...
> > >
> > > How on earth can you safely overwrite a randomly aligned 5 byte instr=
uction
> > > that might be being prefetched and executed by another thread of the
> > > same process.
> >
> > uprobe_write_opcode() doesn't overwrite the instruction in place.
> >
> > It creates the new page with the same content, overwrites the probed in=
sn in
> > that page, then calls __replace_page().
>=20
> tbh I wasn't completely sure about that as well, I added selftest
> in patch #11 trying to hit the issue you described and it seems to
> work ok

Actually hitting the timing window is hard.
So 'seems to work ok' doesn't really mean much :-)
It all depends on how hard __replace_page() tries to be atomic.
The page has to change from one backed by the executable to a private
one backed by swap - otherwise you can't write to it.

But the problems arise when the instruction prefetch unit has read
part of the 5-byte instruction (it might even only read half a cache
line at a time).
I'm not sure how long the pipeline can sit in that state - but I
can do a memory read of a PCIe address that takes ~3000 clocks.
(And a misaligned AVX-512 read is probably eight 8-byte transfers.)

So I think you need to force an interrupt while the PTE is invalid.
And that need to be simultaneous on all cpu running that process.
Stopping the process using ptrace would do it.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


