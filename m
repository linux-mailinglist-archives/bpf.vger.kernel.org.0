Return-Path: <bpf+bounces-20749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580148429AC
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 17:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C84ECB2B24B
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 16:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94FA1272AE;
	Tue, 30 Jan 2024 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AoNffTvU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028DA433A2
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632784; cv=none; b=uGWB1mZtiNYEvd3Hv9eo6tggfbN4G7LxYYRtwLekkBT3SHmw5EBcV8vebVXRhJmIwyZifNE3qS4uBI+jL3GvcOh7Pa/Nv2DCFOfeNsxa9k82oBysMM+wuf9K6abtoSJUo0O9J6t3EeUV348R+RvXlcj0BRXB4Qe5enEHwb+hkbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632784; c=relaxed/simple;
	bh=EwB4Bpde7MgJ6tdRciMHqtOIHFVeDLosx0QaIEBApzk=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=EyPjHB5kuabGLzNjNg8y2qaKiwwnSm/MN4I4Sgsod5j1C4SQrjaxVp0CRE2rw10b9SKU6mJvF/WrHt0ji9rLrWo62Liu2YacV7ecZV1aoIdwZcre+TX5xmOseuwejj5tfIXYi2OGNU6TrBEe9NWh3vIeJ4vwvA3wpCAP3nFLlaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=AoNffTvU; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso3518430a12.3
        for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 08:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706632782; x=1707237582; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7MA5MCIW7OXtKya9qDaWW4VnWdbv19urcqqsi2GglzI=;
        b=AoNffTvUhLKf35Qxk7mKL8JPttlNHhoWI32xj6P0dI/C4OQsWlvSDp+++S3xlvckf7
         3h2YE/1R4010CqjYrtQIzSNoZzGZieuvLEqoCgRZl0w9NeuFKCp5WkDukQHcmP2KB/3K
         9s/KVAS0z24p/IGU305+dsYK2BUbBf00CGxyCtmTVqj30+ygjzVUB0vRYYTM7EwaXGbd
         pFi9Ekf5+QypZn+9X9IP/p2MBKvidkTQXAgFSO/N5vZPyEISi6t4Pc6kJsVYoc4d7ZzY
         0nwtTPe4aB7IzJp5m3wHt+IGsLmURpdBDhJIg42b69986JD5fLMk3ZY7vdlTjz3b3c1F
         5Tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706632782; x=1707237582;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MA5MCIW7OXtKya9qDaWW4VnWdbv19urcqqsi2GglzI=;
        b=L3RDpXk5XnuCtxla7F1imaHs3T9SvLyTtemhN2LrvMHV+mJ8LavhwWQz6m9g6Lhrjv
         BC3BzmrnwHJGRb5al8TSYtiPv+KwmjUwJwqkD0yUgN1uxWnFPIbk3pJXi/Eh/M0aQpoI
         vaM0+GREOoPNEUdYacJd3JYMTiaDFgSTO3R9hls4E60bMlgspfxEFg6AxQrEJHSD2Vm4
         np3rxA1MkI8LBoSZFP9nU3rWeDkcoh5YZngxzdKolb3rI6PNZbbshlb+KIldbRKKvdyI
         DXHHkHQxBd8sCLUsYR8QHXUs6f3EK7XJ7TMw740zeou5D7fy7II9cjc/ztYqcbemhI/7
         Eu/A==
X-Gm-Message-State: AOJu0YzjmLv2UGCQ8NHgS0/MuOwdJIHQK2F+vT8Zq6Y6ZBapaa+v/ovJ
	1nm5YEtq5Ot+ksRpIEr5VkAIR/e+DW6BL8V9D7kdjri130c+WmwF5rDv2//NEjI=
X-Google-Smtp-Source: AGHT+IFElWjax7jCPPZ+XFYgwGxQuIXTnrXEYx342tMSKwBpYk6/uI/RThp9gIYG75D+C1IPuGg/0w==
X-Received: by 2002:a17:90a:5081:b0:290:108:3d8e with SMTP id s1-20020a17090a508100b0029001083d8emr6139344pjh.1.1706632782145;
        Tue, 30 Jan 2024 08:39:42 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id r15-20020a17090ad40f00b00290ae3bf8d1sm8563239pju.57.2024.01.30.08.39.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2024 08:39:41 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: <bpf@ietf.org>,
	"'bpf'" <bpf@vger.kernel.org>
Cc: "'Jose E. Marchesi'" <jose.marchesi@oracle.com>,
	"'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>,
	"'Yonghong Song'" <yonghong.song@linux.dev>
References: <006601da5151$a22b2bb0$e6818310$@gmail.com> <877cjutxe9.fsf@oracle.com> <8734uitx3m.fsf@oracle.com> <01e601da51b7$92c4ffa0$b84efee0$@gmail.com> <CAADnVQK8JegsSxgbQbO=DR71cRgkvN-y9LH_ZQYxmj1a-hCz5g@mail.gmail.com> <071b01da5394$260dba30$72292e90$@gmail.com>
In-Reply-To: <071b01da5394$260dba30$72292e90$@gmail.com>
Subject: RE: [Bpf] ISA: BPF_MSH and deprecated packet access instructions
Date: Tue, 30 Jan 2024 08:39:39 -0800
Message-ID: <073001da539a$ec1e2b00$c45a8100$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQI/mTVZUZpeNhzShIl9oGl01BkM9QGkD3DnAsdGbroCN+NFGgGJMAgqAYfmIS+v2lq0oA==

> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> [...]
> > > Although the Linux verifier doesn't support them, the fact that =
gcc
> > > does support them tells me that it's probably safest to list the =
DW
> > > and LDX variants as deprecated as well, which is what the draft
> > > already did in the appendix so that's good (nothing to change =
there,
> > > I think).
> >
> > DW never existed in classic bpf, so abs/ind never had DW flavor.
> > If some assembler/compiler decided to "support" them it's on them.
> > The standard must not list such things as deprecated. They never
> > existed. So nothing is deprecated.
>=20
> Ack, I will remove the ABS/IND + DW lines from the appendix.
>=20
> > Same with MSH. BPF_LDX | BPF_MSH | BPF_B is the only insn ever =
existed.
> > It's a legacy insn. Just like abs/ind.
>=20
> Should it be listed in the legacy conformance group then?
>=20
> Currently it's not mentioned in instruction-set.rst at all, so the =
opcode is
> available to use by any new instruction.  If we do list it in =
instruction-set.rst
> then, like abs/ind, it will be avoided by anyone proposing new =
instructions.

Here's my understanding of this thread so far:

* (IND/ABS) | (W/H/B) | LD : these are accepted by the Linux verifier =
and are supported
   by clang and gcc.  They should be in the legacy conformance group of =
deprecated
   instructions.

* (IND/ABS) | DW | (LD/LDX) : these are not accepted by the Linux =
verifier and were
   never used.  Clang doesn't generate them but gcc did which is now =
removed
   based on this discussion.  They should NOT be in the legacy =
conformance group of
   deprecated instructions because they were never defined in the first =
place, and
   instruction-set.rst should be updated to clarify this.

* (IND/ABS) | (W/H/B) | LDX : these are not accepted by the Linux =
verifier and were=20
   never used.  Clang doesn't generate them but gcc does. They should =
NOT=20
   be in the legacy conformance group of deprecated instructions because =
they were
   never defined in the first place, and instruction-set.rst should be =
updated to clarify this.

* (IND/ABS) | (W/H/B/DW) | (ST/STX): these are not accepted by the Linux =
verifier and were=20
   never used.  I don't know whether clang or gcc generates them.  They =
should NOT=20
   be in the legacy conformance group of deprecated instructions because =
they were
   never defined in the first place, and instruction-set.rst should be =
updated to clarify this.

* MSH | B | LDX: this existed in classic BPF but does not exist in =
(e)BPF since it is not accepted
   by the Linux verifier.  I don't know whether clang ever generated =
them, but gcc never did.
   The "Legacy BPF Packet access instructions" section of =
instruction-set.rst says
   > BPF previously introduced special instructions for access to packet =
data that were carried
   > over from classic BPF. However, these instructions are deprecated =
and should no longer be used.
   I read Alexei's comment "It's a legacy insn. Just like abs/ind" as a =
possible argument that MSH|B|LDX
   should be mentioned in instruction-set.rst, pointing to the above =
section, like IND/ABS do.
   But Yonghong argued that it was never accepted by the verifier, so =
need not be mentioned.

* MSH | (W/H/DW) | (LD/ST/STX): These are not accepted by the Linux =
verifier and were=20
   never used.  They should NOT be in the legacy conformance group of =
deprecated instructions
   because they were never defined in the first place.

Let me know if any of the above is incorrect and I can submit a doc =
patch.

Dave


