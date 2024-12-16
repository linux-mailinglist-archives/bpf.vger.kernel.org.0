Return-Path: <bpf+bounces-47034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 713CD9F2EE6
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 12:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6901884F0E
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 11:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25692040B7;
	Mon, 16 Dec 2024 11:11:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE75204099
	for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734347491; cv=none; b=FYfgIWDyKBjgiq+gE/bV03TMKzPI9DDV6XUZBUSdpYETR/TV/qKjhLYrcKylaRyXkKNPEdGSvYPQz+xvofcoVoiqUSavAJH4oqXt7AgL0fk5Cq0SpY3X6qsJn7RafpOIRe8RNTweChHbDPie/TAMzJyH/mOjG8bHENKNxKRU8Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734347491; c=relaxed/simple;
	bh=N2vdhFMCwt7nl3aR3OnWzK7YbPyMRZ+JlQNLQWrzIEU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=FCx6rRgHk0bdT9L/c39D3lOdigrGqtr+shPxWm7Gkb4Nq0E7cBOgC+XG6gz9sDBaiCrXkHWPFJhEAsEWbrhq2+cb5e+KOvqTV+bIyxMhIyNmAlIkAWKppx8YYOHmXQ6EhzAfzXmsJZGHi/6f4x+YBaHrc7O2EHwnEDAB9k4D1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-78-kvkqQzWQOWCezDNdN5gTxA-1; Mon, 16 Dec 2024 11:11:27 +0000
X-MC-Unique: kvkqQzWQOWCezDNdN5gTxA-1
X-Mimecast-MFC-AGG-ID: kvkqQzWQOWCezDNdN5gTxA
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 16 Dec
 2024 11:10:23 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 16 Dec 2024 11:10:23 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Oleg Nesterov' <oleg@redhat.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>
CC: 'Jiri Olsa' <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, Song Liu <songliubraving@fb.com>, Yonghong Song
	<yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo
	<haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Alan Maguire <alan.maguire@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: RE: [PATCH bpf-next 08/13] uprobes/x86: Add support to optimize
 uprobes
Thread-Topic: [PATCH bpf-next 08/13] uprobes/x86: Add support to optimize
 uprobes
Thread-Index: AQHbS9GTSF5rwnXysUaDsufIVqYKlLLnNYvQgAFWD+SAAA72QIAAE/UAgAAKdkA=
Date: Mon, 16 Dec 2024 11:10:23 +0000
Message-ID: <0916e24539ba4bae9fb729198b033bd7@AcuMS.aculab.com>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-9-jolsa@kernel.org>
 <1521ff93bc0649b0aade9cfc444929ca@AcuMS.aculab.com>
 <20241215141412.GA13580@redhat.com> <Z1_gFymfO3sAwhiY@krava>
 <c5fb22629d3f42798def5b63ce834801@AcuMS.aculab.com>
 <20241216101258.GA374@redhat.com>
In-Reply-To: <20241216101258.GA374@redhat.com>
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
X-Mimecast-MFC-PROC-ID: T4qMNt266hTL06Q24Ndac85J0RvJ1h91bEYFovc8ycM_1734347486
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Oleg Nesterov
> Sent: 16 December 2024 10:13
>=20
> David,
>=20
> let me say first that my understanding of this magic is very limited,
> please correct me.

I only (half) understand what the 'magic' has to accomplish and
some of the pitfalls.

I've copied linux-mm - someone there might know more.

> On 12/16, David Laight wrote:
> >
> > It all depends on how hard __replace_page() tries to be atomic.
> > The page has to change from one backed by the executable to a private
> > one backed by swap - otherwise you can't write to it.
>=20
> This is what uprobe_write_opcode() does,

And will be enough for single byte changes - they'll be picked up
at some point after the change.

> > But the problems arise when the instruction prefetch unit has read
> > part of the 5-byte instruction (it might even only read half a cache
> > line at a time).
> > I'm not sure how long the pipeline can sit in that state - but I
> > can do a memory read of a PCIe address that takes ~3000 clocks.
> > (And a misaligned AVX-512 read is probably eight 8-byte transfers.)
> >
> > So I think you need to force an interrupt while the PTE is invalid.
> > And that need to be simultaneous on all cpu running that process.
>=20
> __replace_page() does ptep_get_and_clear(old_pte) + flush_tlb_page().
>=20
> That's not enough?

I doubt it. As I understand it.
The hardware page tables will be shared by all the threads of a process.
So unless you hard synchronise all the cpu (and flush the TLB) while the
PTE is being changed there is always the possibility of a cpu picking up
the new PTE before the IPI that (I presume) flush_tlb_page() generates
is processed.
If that happens when the instruction you are patching is part-read into
the instruction decode buffer then you'll execute a mismatch of the two
instructions.

I can't remember the outcome of discussions about live-patching kernel
code - and I'm sure that was aligned 32bit writes.

>=20
> > Stopping the process using ptrace would do it.
>=20
> Not an option :/

Thought you'd say that.

=09David

>=20
> Oleg.

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


