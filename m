Return-Path: <bpf+bounces-48784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA31A109AD
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 15:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB20D3A1E41
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 14:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A1A126C02;
	Tue, 14 Jan 2025 14:46:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AC883CD2
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865972; cv=none; b=gZnpyxxMtYviOIJR0FYa1UVbehS1PZtiON6KpoTPXyuX1Q+LilU5K4oTjUP8KEMxYsJSScgrib/brh96xsZGLB+b5QcEQvdlV4z5dMOZ+1SStxsvXvvG5v9oJNufgAshyGdo5O/q4qfIoNoJvWfjSAYuUWjLX7IWQjY2l1uTKWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865972; c=relaxed/simple;
	bh=wsHZtnHpAWP3Z6iWC4XZy/63GYdfKEW6a1pz2UhTr+g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=UTg5rZPc6/Me+RqdckirK4zKhuP8k6YRt9MjQJQFZPEVfqJI1VpyF8HPVCDuyR6Kub2PqE+LvDGoGpIbyrJ+gj36FG6qcBqHFCnH6ubhKAbK3/xD7XtXiTvR7iJCMTJyxtNQqaO0zY5huHMokpv1h+0FyvoNMU18Hi/HECvI7Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-3-ithJAbB0MtWJLSy7a8AjyA-1; Tue, 14 Jan 2025 14:39:42 +0000
X-MC-Unique: ithJAbB0MtWJLSy7a8AjyA-1
X-Mimecast-MFC-AGG-ID: ithJAbB0MtWJLSy7a8AjyA
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 14 Jan
 2025 14:38:42 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 14 Jan 2025 14:38:42 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jiri Olsa' <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>
CC: lkml <linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [RFC] x86/alternatives: Merge first and second step in
 text_poke_bp_batch
Thread-Topic: [RFC] x86/alternatives: Merge first and second step in
 text_poke_bp_batch
Thread-Index: AQHbZozZ4ySmWOzi/E+fxf1y3jFjErMWUqfg
Date: Tue, 14 Jan 2025 14:38:42 +0000
Message-ID: <c88cf8951a0d4f73901ba97a81ba3a12@AcuMS.aculab.com>
References: <20250114140237.3506624-1-jolsa@kernel.org>
In-Reply-To: <20250114140237.3506624-1-jolsa@kernel.org>
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
X-Mimecast-MFC-PROC-ID: ZiiDWlVgrZoM_DBapIZGk65odeHn-Ef5zCaS_vZwSLE_1736865581
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Jiri Olsa
> Sent: 14 January 2025 14:03
>=20
> hi,
> while checking on similar code for uprobes I was wondering if we
> can merge first 2 steps of instruction update in text_poke_bp_batch
> function.
>=20
> Basically the first step now would be to write int3 byte together
> with the rest of the bytes of the new instruction instead of doing
> that separately. And the second step would be to overwrite int3
> byte with first byte of the new instruction.
>=20
> Would that work or do I miss some x86 detail that could lead to crash?

I suspect it will 'crash and burn'.

Consider what happens if there is a cache-line boundary in the
middle of an instruction.
(Actually an instruction fetch boundary will do.)

cpu0: reads the old instructions from the old cache line.
cpu0: pipeline busy (or similar) so doesn't read the next cache line.
cpu1: writes the new instructions.
cpu0: reads the second cache line.

cpu0 now has a mix of the old and new instruction bytes.

Writing the int3 is safe - provided they don't return until
all the patching is over.

But between writing the int3 (over the first opcode byte) and
updating anything else I suspect you need something that does
a complete synchronise between the cpu that discards any bytes
in the decode pipeline as well as flushing the I-cache (etc).
I suspect that requires an acked IPI.

Very long cpu stalls are easy to generate.
Any read from PCIe will be slow (I've at fpga target that takes ~1us).
You'd need to be unlucky to be patching an instruction while one
was pending, but a DMA access might just be enough to cause grief.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


