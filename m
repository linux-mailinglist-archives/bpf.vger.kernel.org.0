Return-Path: <bpf+bounces-47039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB169F3415
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 16:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8791882540
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 15:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1471465BB;
	Mon, 16 Dec 2024 15:09:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46E4143723
	for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361765; cv=none; b=keEELn8oVyKCDt/3Z9NINEGH+UmAZk4j/d8Te2mAsCYZ1NZCcxretuFNwG+MZAcZdYgb1vWIkvhWNCuPeqHB9M4fJvh4EhLMeiEQSBbbTk/b9ccU1iCo+E79e9c7Oxs1RtfSzFUJ1mY82Vg0YBiLewfUlVJ8iDMAbJ87uTgkkT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361765; c=relaxed/simple;
	bh=+EZvaRtod53RfYhLjTwH55bjpToAZ++4brtIjAyL2/k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Mm0JIxMUNPxKjhMqwEq+T0+N93NpD7lrhXDqRW1U66IfYsu5KKzkQ4XEv3Vo5AZcFpLfZWu7C4KsP1pJ+Xq/PtjYLWwsI7EAgrNn1iLFCrTzN0fvuXpe0ibdLlyZXSOwLv1bB6vsOh0eSaNIvnVseKgbGXABIsiTqXT2MfMS0r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-186-zBF_QFIGN8iskqJS4NvIGg-1; Mon, 16 Dec 2024 15:09:19 +0000
X-MC-Unique: zBF_QFIGN8iskqJS4NvIGg-1
X-Mimecast-MFC-AGG-ID: zBF_QFIGN8iskqJS4NvIGg
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 16 Dec
 2024 15:08:14 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 16 Dec 2024 15:08:14 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jiri Olsa' <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, Peter Zijlstra
	<peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Song Liu
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
Thread-Index: AQHbS9GTSF5rwnXysUaDsufIVqYKlLLnNYvQgAFWD+SAAA72QIAAE/UAgAAKdkCAACFInYAAIoEw
Date: Mon, 16 Dec 2024 15:08:14 +0000
Message-ID: <e206df95d98d4cbab77824cf7a32a80f@AcuMS.aculab.com>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-9-jolsa@kernel.org>
 <1521ff93bc0649b0aade9cfc444929ca@AcuMS.aculab.com>
 <20241215141412.GA13580@redhat.com> <Z1_gFymfO3sAwhiY@krava>
 <c5fb22629d3f42798def5b63ce834801@AcuMS.aculab.com>
 <20241216101258.GA374@redhat.com>
 <0916e24539ba4bae9fb729198b033bd7@AcuMS.aculab.com>
 <20241216122204.GB374@redhat.com> <Z2AiFdDsrSjZ_-3-@krava>
In-Reply-To: <Z2AiFdDsrSjZ_-3-@krava>
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
X-Mimecast-MFC-PROC-ID: c2EUuv5kicmvusNZzrE4wu3dWCz2lH9Togp5AFIhIy0_1734361758
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Jiri Olsa
> Sent: 16 December 2024 12:50
>=20
> On Mon, Dec 16, 2024 at 01:22:05PM +0100, Oleg Nesterov wrote:
> > OK, thanks, I am starting to share your concerns...
> >
> > Oleg.
> >
> > On 12/16, David Laight wrote:
> > >
> > > From: Oleg Nesterov
> > > > Sent: 16 December 2024 10:13
> > > >
> > > > David,
> > > >
> > > > let me say first that my understanding of this magic is very limite=
d,
> > > > please correct me.
> > >
> > > I only (half) understand what the 'magic' has to accomplish and
> > > some of the pitfalls.
> > >
> > > I've copied linux-mm - someone there might know more.
> > >
> > > > On 12/16, David Laight wrote:
> > > > >
> > > > > It all depends on how hard __replace_page() tries to be atomic.
> > > > > The page has to change from one backed by the executable to a pri=
vate
> > > > > one backed by swap - otherwise you can't write to it.
> > > >
> > > > This is what uprobe_write_opcode() does,
> > >
> > > And will be enough for single byte changes - they'll be picked up
> > > at some point after the change.
> > >
> > > > > But the problems arise when the instruction prefetch unit has rea=
d
> > > > > part of the 5-byte instruction (it might even only read half a ca=
che
> > > > > line at a time).
> > > > > I'm not sure how long the pipeline can sit in that state - but I
> > > > > can do a memory read of a PCIe address that takes ~3000 clocks.
> > > > > (And a misaligned AVX-512 read is probably eight 8-byte transfers=
.)
> > > > >
> > > > > So I think you need to force an interrupt while the PTE is invali=
d.
> > > > > And that need to be simultaneous on all cpu running that process.
> > > >
> > > > __replace_page() does ptep_get_and_clear(old_pte) + flush_tlb_page(=
).
> > > >
> > > > That's not enough?
> > >
> > > I doubt it. As I understand it.
> > > The hardware page tables will be shared by all the threads of a proce=
ss.
> > > So unless you hard synchronise all the cpu (and flush the TLB) while =
the
> > > PTE is being changed there is always the possibility of a cpu picking=
 up
> > > the new PTE before the IPI that (I presume) flush_tlb_page() generate=
s
> > > is processed.
> > > If that happens when the instruction you are patching is part-read in=
to
> > > the instruction decode buffer then you'll execute a mismatch of the t=
wo
> > > instructions.
>=20
> if 5 byte update would be a problem, I guess we could workaround that thr=
ough
> partial updates using int3 like we do in text_poke_bp_batch?
>=20
>   - changing nop5 instruction to 'call xxx'
>   - write int3 to first byte of nop5 instruction
>   - have poke_int3_handler to emulate nop5 if int3 is triggered
>   - write rest of the call instruction to nop5 last 4 bytes
>   - overwrite first byte of nop5 with call opcode

That might work provided there are IPI (to flush the decode pipeline)
after the write of the 'int3' and one before the write of the 'call'.
You'll need to ensure the I-cache gets invalidated as well.

And if the sequence crosses a page boundary....

=09David

>=20
> similar update from 'call xxx' -> 'nop5'
>=20
> thanks,
> jirka
>=20
> > >
> > > I can't remember the outcome of discussions about live-patching kerne=
l
> > > code - and I'm sure that was aligned 32bit writes.
> > >
> > > >
> > > > > Stopping the process using ptrace would do it.
> > > >
> > > > Not an option :/
> > >
> > > Thought you'd say that.
> > >
> > > =09David
> > >
> > > >
> > > > Oleg.
> > >
> > > -
> > > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes,=
 MK1 1PT, UK
> > > Registration No: 1397386 (Wales)
> > >
> >

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


