Return-Path: <bpf+bounces-19282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AECF6828D27
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 20:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3F3287D2F
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 19:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4763D0C5;
	Tue,  9 Jan 2024 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="c3TFb846";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="c3TFb846"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397A33A8D9
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7F59CC0900B3
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 11:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1704827447; bh=4/J3EoQiceQV+S7rPjJk1Of6BuUBHTzV7nW/C/HG1qM=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=c3TFb846lXJkIFXzxr3BXJaLShgQY8hZ9mY1n4m+IUpkEjM4eLWOE2jI29yAWwB1I
	 /QZo/kWPhTDzoEnzXpVlrvYD4MH/f+7JW7wlhNDrYDSsYM+KkPBZTWVjpjQlyPnwvd
	 AGqyWEqNenC19pxbC6fmmCc0boNhmZUFp/T5xsME=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Jan  9 11:10:47 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 51BD5C151553;
	Tue,  9 Jan 2024 11:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1704827447; bh=4/J3EoQiceQV+S7rPjJk1Of6BuUBHTzV7nW/C/HG1qM=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=c3TFb846lXJkIFXzxr3BXJaLShgQY8hZ9mY1n4m+IUpkEjM4eLWOE2jI29yAWwB1I
	 /QZo/kWPhTDzoEnzXpVlrvYD4MH/f+7JW7wlhNDrYDSsYM+KkPBZTWVjpjQlyPnwvd
	 AGqyWEqNenC19pxbC6fmmCc0boNhmZUFp/T5xsME=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 38EC2C151553
 for <bpf@ietfa.amsl.com>; Tue,  9 Jan 2024 11:10:46 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.404
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KXDhoF32_OOE for <bpf@ietfa.amsl.com>;
 Tue,  9 Jan 2024 11:10:42 -0800 (PST)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 6BA50C151547
 for <bpf@ietf.org>; Tue,  9 Jan 2024 11:10:42 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-2064cc6cc51so694129fac.3
 for <bpf@ietf.org>; Tue, 09 Jan 2024 11:10:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704827441; x=1705432241;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N+SZmOdIJYbPI/0zOHOTQ3fKLyOIiOjGM2W5vx1idfM=;
 b=ZyFgaoAl04Cj9PfN5PtiFKrWuymmV8656qM4GnLiO48X6fxPsg7gErPQZN0MUh+ikH
 qIoMq3ROEojj/KImQHOw/6xQBfP9aLAObWizkWweRcdjaE7YplvWuFV1F4Lk5smJiBJ9
 GzOgwvtn9b1LBs2QrBHMpkTqMFg1zIs/7Xy6OhTK6DG9Z9tdslKVGmJad9xS7jjeEoBb
 yJ5ePUmBwIsC8vgO1TZ6iiy6csGnndtAUIQ5Uz8KX2fg1SLAyRJ8Ac/PEHFaviMMsN3H
 s/TeuzOzGwsxgGgiI3l0RaxFjTvvd2pLA2P18Mjt8m8qJA32vCayatdyV9krA4a1S28D
 o1wA==
X-Gm-Message-State: AOJu0YxvoVsWrSZ5CVs2QmEKlN25DYdRaPqTnFPEYv/s84+Ut6v/dp79
 1IkLKWdmicOms/oy/CnPfLk=
X-Google-Smtp-Source: AGHT+IG6GwebYw18QfSWXJq+irMryCmKbuD3RIst9g8+fq+kAuIr35xlPzVgGpOs+c7ddPs31tduTA==
X-Received: by 2002:a05:6870:670a:b0:205:ccb0:ea28 with SMTP id
 gb10-20020a056870670a00b00205ccb0ea28mr5186558oab.61.1704827441131; 
 Tue, 09 Jan 2024 11:10:41 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 y26-20020ac8525a000000b0042992b06012sm1116628qtn.2.2024.01.09.11.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 11:10:40 -0800 (PST)
Date: Tue, 9 Jan 2024 13:10:37 -0600
From: David Vernet <void@manifault.com>
To: dthaler1968@googlemail.com
Cc: 'Aoyang Fang' <aoyangfang@link.cuhk.edu.cn>, bpf@vger.kernel.org,
 bpf@ietf.org
Message-ID: <20240109191037.GC79024@maniforge>
References: <20240105031450.57681-2-aoyangfang@link.cuhk.edu.cn>
 <20240109173227.GB79024@maniforge>
 <016101da4326$8dbad1a0$a93074e0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <016101da4326$8dbad1a0$a93074e0$@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/wu9LBWwF6oAL1YFEoDoP_DEdIOg>
Subject: Re: [Bpf] [PATCH bpf-next] The original document has some
 inconsistency.
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============4768675751200411511=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============4768675751200411511==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KWs5EMOk1v6q47GL"
Content-Disposition: inline


--KWs5EMOk1v6q47GL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 10:06:22AM -0800, dthaler1968@googlemail.com wrote:
> David Vernet <void@manifault.com> writes:=20
> > Hi Aoyang,
> >=20
> > Thanks a lot for your contribution. I agree that we need to fix the
> document
> > to be consistent, though I'm afraid that I think this patch goes in the
> wrong
> > direction by making everything match the jump instruction class. More
> below.
>=20
> I disagree, and I agree with Aoyang's direction.
>=20
> > nit: Could you please update the patch subject to be more self-describi=
ng.
> For
> > example, something like:
> >=20
> > Use consistent numerical widths in instructions.rst encodings
>=20
> I agree with that subject.
>=20
> > > For example:
> > > 1. 1.3.1 Arithmetic instructions use '8 bits length' encoding to
> > >    express the 'code' value, e.g., BPF_ADD=3D0x00, BPF_SUB=3D0x10,
> > >    BPF_MUL=3D0x20. However the length of the 'code' is 4 bits. On the
> > >    other hand, 1.3.3 Jump instructions use '4 bits length' encoding,
> > >    e.g., BPF_JEQ=3D0x1 and BPF_JGT=3D0x2.
> > > 2. There are also many places that use '8 bits length' encoding to
> > >    express the corresponding contents, e.g., 1.4 Load and store
> > >    instructions, BPF_ABS=3D0x20, BPF_IND=3D0x40. However, the length =
of
> > >    'mode modifier' is 3 bits.
> > >
> > > To summarize, the only place that has inconsistent encoding is Jump
> > > instructions. After discussing with Dave, dthaler1968@googlemail.com,
> > > we agree that the document should be more clear.
> > >
> > > Signed-off-by: Aoyang Fang <aoyangfang@link.cuhk.edu.cn>
> > >
> > > ---
> > >  .../bpf/standardization/instruction-set.rst   | 170 +++++++++-------=
--
> > >  1 file changed, 85 insertions(+), 85 deletions(-)
> > >
> > > diff --git a/Documentation/bpf/standardization/instruction-set.rst
> > > b/Documentation/bpf/standardization/instruction-set.rst
> > > index 245b6defc..57dd1fa00 100644
> > > --- a/Documentation/bpf/standardization/instruction-set.rst
> > > +++ b/Documentation/bpf/standardization/instruction-set.rst
> > > @@ -172,18 +172,18 @@ Instruction classes
> > >
> > >  The three LSB bits of the 'opcode' field store the instruction class:
> > >
> > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > -class      value  description                      reference
> > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > -BPF_LD     0x00   non-standard load operations     `Load and store
> > instructions`_
> > > -BPF_LDX    0x01   load into register operations    `Load and store
> > instructions`_
> > > -BPF_ST     0x02   store from immediate operations  `Load and store
> > instructions`_
> > > -BPF_STX    0x03   store from register operations   `Load and store
> > instructions`_
> > > -BPF_ALU    0x04   32-bit arithmetic operations     `Arithmetic and j=
ump
> > instructions`_
> > > -BPF_JMP    0x05   64-bit jump operations           `Arithmetic and j=
ump
> > instructions`_
> > > -BPF_JMP32  0x06   32-bit jump operations           `Arithmetic and j=
ump
> > instructions`_
> > > -BPF_ALU64  0x07   64-bit arithmetic operations     `Arithmetic and j=
ump
> > instructions`_
> > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +class      value(3 bits)  description                      reference
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +BPF_LD     0x0            non-standard load operations     `Load and
> store
> > instructions`_
> > > +BPF_LDX    0x1            load into register operations    `Load and
> store
> > instructions`_
> > > +BPF_ST     0x2            store from immediate operations  `Load and
> store
> > instructions`_
> > > +BPF_STX    0x3            store from register operations   `Load and
> store
> > instructions`_
> > > +BPF_ALU    0x4            32-bit arithmetic operations     `Arithmet=
ic
> and jump
> > instructions`_
> > > +BPF_JMP    0x5            64-bit jump operations           `Arithmet=
ic
> and jump
> > instructions`_
> > > +BPF_JMP32  0x6            32-bit jump operations           `Arithmet=
ic
> and jump
> > instructions`_
> > > +BPF_ALU64  0x7            64-bit arithmetic operations     `Arithmet=
ic
> and jump
> > instructions`_
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > Hmm, I presonally think this is more confusing. The opcode field is 8
> bits. We
> > already specify that the value is the three LSB of the opcode field. It=
's
> > certainly subjective, but I think we should have the value reflect the
> actual
> > value in the field it's embedded in. In my opinion, changing the value =
to
> not
> > reflect its place in the actual opcode in my opinion imposes a burden on
> the
> > reader to go back and reference where the field actually belongs in the
> full
> > opcode. It's a tradeoff, but I think we're already on the winning end of
> that
> > tradeoff.
>=20
> This document is an IETF standards specification so it's worth looking at
> what
> typical RFC conventions are.
>=20
> * RFC 791 section 3.1 defines the IPv4 header, where the Version field is
> the high
>    4 bits of a byte.  It defines the value as 4, not 0x40.
>    It also defines the Type of Service bits which are 1 bit fields with
> value 0 or 1
>    (not, say 0x40).
> * RFC 8200 section 3 defines the IPv6 header, where the Version field is =
the
> high
>    4 bits of a byte.  It defines the value as 6, not 0x60.

I definitely believe we should follow IETF conventions, but from looking
at [0] it looks like we're already deviating.

[0]: https://www.rfc-editor.org/rfc/rfc791.txt

Here are some excerpts from what's there:

---------------------------------------------------------------------------=
----

3.1.  Internet Header Format

  A summary of the contents of the internet header follows:

                                   =20
    0                   1                   2                   3  =20
    0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1=20
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |Version|  IHL  |Type of Service|          Total Length         |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |         Identification        |Flags|      Fragment Offset    |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |  Time to Live |    Protocol   |         Header Checksum       |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                       Source Address                          |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                    Destination Address                        |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                    Options                    |    Padding    |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

                    Example Internet Datagram Header

                               Figure 4.

  Note that each tick mark represents one bit position.

  Version:  4 bits

    The Version field indicates the format of the internet header.  This
    document describes version 4.

[...]

  Type of Service:  8 bits

    The Type of Service provides an indication of the abstract
    parameters of the quality of service desired.  These parameters are
    to be used to guide the selection of the actual service parameters
    when transmitting a datagram through a particular network.  Several
    networks offer service precedence, which somehow treats high
    precedence traffic as more important than other traffic (generally
    by accepting only traffic above a certain precedence at time of high
    load).  The major choice is a three way tradeoff between low-delay,
    high-reliability, and high-throughput.

      Bits 0-2:  Precedence.
      Bit    3:  0 =3D Normal Delay,      1 =3D Low Delay.
      Bits   4:  0 =3D Normal Throughput, 1 =3D High Throughput.
      Bits   5:  0 =3D Normal Relibility, 1 =3D High Relibility.
      Bit  6-7:  Reserved for Future Use.

         0     1     2     3     4     5     6     7
      +-----+-----+-----+-----+-----+-----+-----+-----+
      |                 |     |     |     |     |     |
      |   PRECEDENCE    |  D  |  T  |  R  |  0  |  0  |
      |                 |     |     |     |     |     |
      +-----+-----+-----+-----+-----+-----+-----+-----+

        Precedence

          111 - Network Control
          110 - Internetwork Control
          101 - CRITIC/ECP
          100 - Flash Override
          011 - Flash
          010 - Immediate
          001 - Priority
          000 - Routine

[...]

APPENDIX A:  Examples & Scenarios

Example 1:

  This is an example of the minimal data carrying internet datagram:

                                   =20
    0                   1                   2                   3  =20
    0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1=20
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |Ver=3D 4 |IHL=3D 5 |Type of Service|        Total Length =3D 21      |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |      Identification =3D 111     |Flg=3D0|   Fragment Offset =3D 0   |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |   Time =3D 123  |  Protocol =3D 1 |        header checksum        |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                         source address                        |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                      destination address                      |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |     data      |                                               =20
   +-+-+-+-+-+-+-+-+                                               =20

---------------------------------------------------------------------------=
----

This is already pretty different from how we're visualizing and
enumerating the instructions in our document. Consider:

1. They're not even using numerical values to define some fields, such
   as with Type of Service. They're specifying the exact values of
   individual bits within the field (e.g. with Precedence).

2. They're using decimal instead of hexadecimal.

Unless I'm missing something, it seems like the deviation in terms of
using 0x40 vs. 0x4 is specific to how they present examples in the
appendices (though even the appendices are using base 10).

So while I certainly agree that we should follow conventions, I think
I'd prefer that we either follow them completely, or not sacrifice
readability by following them in specific ways which don't necessarily
match the chosen format for our document.

> Etc.  Offhand I am not aware of any RFC that uses the convention you
> suggest,
> though perhaps others are?

I am not, no.

> > >  Arithmetic and jump instructions
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > @@ -203,12 +203,12 @@ code            source  instruction class
> > >  **source**
> > >    the source operand location, which unless otherwise specified is o=
ne
> of:
> > >
> > > -  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > -  source  value  description
> > > -  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > -  BPF_K   0x00   use 32-bit 'imm' value as source operand
> > > -  BPF_X   0x08   use 'src_reg' register value as source operand
> > > -  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > + =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +  source  value(1 bit)  description
> > > +  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +  BPF_K   0x0           use 32-bit 'imm' value as source operand
> > > +  BPF_X   0x1           use 'src_reg' register value as source opera=
nd
> > > +  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > + =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > Same here as well. The value isn't really 0x1, it's 0x8. And 0x08 is ev=
en
> more
> > clear yet, given that we're representing the value of the bit in the 8 =
bit
> opcode
> > field.
>=20
> Its 1, in the same sense as the TOS bits in RFC 791 are 1.
>=20
> > >  **instruction class**
> > >    the instruction class (see `Instruction classes`_) @@ -221,27
> > > +221,27 @@ otherwise identical operations.
> > >  The 'code' field encodes the operation as below, where 'src' and
> > > 'dst' refer  to the values of the source and destination registers,
> respectively.
> > >
> > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > -code       value  offset   description
> > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > -BPF_ADD    0x00   0        dst +=3D src
> > > -BPF_SUB    0x10   0        dst -=3D src
> > > -BPF_MUL    0x20   0        dst \*=3D src
> > > -BPF_DIV    0x30   0        dst =3D (src !=3D 0) ? (dst / src) : 0
> > > -BPF_SDIV   0x30   1        dst =3D (src !=3D 0) ? (dst s/ src) : 0
> > > -BPF_OR     0x40   0        dst \|=3D src
> > > -BPF_AND    0x50   0        dst &=3D src
> > > -BPF_LSH    0x60   0        dst <<=3D (src & mask)
> > > -BPF_RSH    0x70   0        dst >>=3D (src & mask)
> > > -BPF_NEG    0x80   0        dst =3D -dst
> > > -BPF_MOD    0x90   0        dst =3D (src !=3D 0) ? (dst % src) : dst
> > > -BPF_SMOD   0x90   1        dst =3D (src !=3D 0) ? (dst s% src) : dst
> > > -BPF_XOR    0xa0   0        dst ^=3D src
> > > -BPF_MOV    0xb0   0        dst =3D src
> > > -BPF_MOVSX  0xb0   8/16/32  dst =3D (s8,s16,s32)src
> > > -BPF_ARSH   0xc0   0        :term:`sign extending<Sign Extend>` dst >=
>=3D
> (src &
> > mask)
> > > -BPF_END    0xd0   0        byte swap operations (see `Byte swap
> instructions`_
> > below)
> > >
> > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +code       value(4 bits)  offset   description
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +BPF_ADD    0x0            0        dst +=3D src
> > > +BPF_SUB    0x1            0        dst -=3D src
> > > +BPF_MUL    0x2            0        dst \*=3D src
> > > +BPF_DIV    0x3            0        dst =3D (src !=3D 0) ? (dst / src=
) : 0
> > > +BPF_SDIV   0x3            1        dst =3D (src !=3D 0) ? (dst s/ sr=
c) : 0
> > > +BPF_OR     0x4            0        dst \|=3D src
> > > +BPF_AND    0x5            0        dst &=3D src
> > > +BPF_LSH    0x6            0        dst <<=3D (src & mask)
> > > +BPF_RSH    0x7            0        dst >>=3D (src & mask)
> > > +BPF_NEG    0x8            0        dst =3D -dst
> > > +BPF_MOD    0x9            0        dst =3D (src !=3D 0) ? (dst % src=
) : dst
> > > +BPF_SMOD   0x9            1        dst =3D (src !=3D 0) ? (dst s% sr=
c) :
> dst
> > > +BPF_XOR    0xa            0        dst ^=3D src
> > > +BPF_MOV    0xb            0        dst =3D src
> > > +BPF_MOVSX  0xb            8/16/32  dst =3D (s8,s16,s32)src
> > > +BPF_ARSH   0xc            0        :term:`sign extending<Sign Extend=
>`
> dst >>=3D
> > (src & mask)
> > > +BPF_END    0xd            0        byte swap operations (see `Byte s=
wap
> > instructions`_ below)
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > Same here.
> >=20
> > >  Underflow and overflow are allowed during arithmetic operations,
> > > meaning  the 64-bit or 32-bit value will wrap. If BPF program
> > > execution would @@ -314,13 +314,13 @@ select what byte order the
> > > operation converts from or to. For  ``BPF_ALU64``, the 1-bit source
> > > operand field in the opcode is reserved  and must be set to 0.
> > >
> > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=
=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > -class      source     value  description
> > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=
=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > -BPF_ALU    BPF_TO_LE  0x00   convert between host byte order and lit=
tle
> > endian
> > > -BPF_ALU    BPF_TO_BE  0x08   convert between host byte order and big
> > endian
> > > -BPF_ALU64  Reserved   0x00   do byte swap unconditionally
> > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=
=3D=3D
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > +class      source     value(1 bit)  description
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > +BPF_ALU    BPF_TO_LE  0x0           convert between host byte order =
and
> little
> > endian
> > > +BPF_ALU    BPF_TO_BE  0x1           convert between host byte order =
and
> big
> > endian
> > > +BPF_ALU64  Reserved   0x0           do byte swap unconditionally
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >=20
> > Same here. Which bit does the 0x1 actually correspond to? It's
> self-evident in
> > the former, not the latter.
>=20
> Would you then say that RFC 791 (and many RFCs since) is not self-evident?

Not at all, I would say that they're presenting their information in a
very different way. Imagine if they presented Type of Service in this
way:

Type of Service: 8 bits

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D
3 bits (MSB)  1 bit  1 bit      1 bit        2 bits
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D
Precedence    Delay  Throughput Reliability  Reserved
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D

**Precedence**
The precedence with which traffic should be served.

**Delay**
The quality of service requirement for delay.

**Throughput**
The quality of service requirement for throughput.

**Reliability**
The quality of service requirement for reliability.

**Reserved**
Bits reserved for future use


Precedence types
----------------

=2E..

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D           =3D=3D=3D=3D=3D
Precedence           value
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D           =3D=3D=3D=3D=3D
Routine              0x0
Priority             0x1
Immediate            0x2
Flash                0x3
Flash Override       0x4
CRITIC/ECP           0x5
Internetwork Control 0x6
Network Control      0x7

Delay
-----

=3D=3D=3D=3D=3D         =3D=3D=3D=3D=3D
Delay         value
=3D=3D=3D=3D=3D         =3D=3D=3D=3D=3D
Normal Delay  0x0
Low Delay     0x1

Throughput
----------

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D         =3D=3D=3D=3D=3D
Throughput         value
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D         =3D=3D=3D=3D=3D
Normal Throughput  0x0
High Throughput    0x1

Reliability
-----

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D         =3D=3D=3D=3D=3D
Reliability         value
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D         =3D=3D=3D=3D=3D
Normal Reliability  0x0
High Reliability    0x1

Reserved
--------

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D
Resrved         value
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D
Reserved bit 0  0x0
Reserved bit 1  0x1
Reserved bit 2  0x2
Reserved bit 3  0x3

-----

This is of course in contrast to the much more concise way they defined
it above. If they did end up defining it this way, I think it would be
less clear to use the actual bit values rather than just the actual
value in the Type of Service mask. It's subjective, but I just don't
really see them as equivalent.

> If the WG chooses to diverge from the most common ways the IETF defines
> bit formats, that might be ok but may need a section explaining the
> divergent convention.   My personal preference though is to stay consiste=
nt
> with the normal IETF convention, which part of the ISA doc already did.

I agree with you that we should stay consistent, but it seems like we're
being selective about it. Could you help me understand why the
deviations we have already wouldn't have required a separate section?

Thanks,
David

--KWs5EMOk1v6q47GL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZZ2aLQAKCRBZ5LhpZcTz
ZLyqAP0a4Xcm7E66P45dWZakOdDHN/uqgUtOyDDsLKOQyoKVZgEAtu8uORuD4xer
b46cduULs3hwYCXxAvvdfVVGNQeAFAs=
=vOXh
-----END PGP SIGNATURE-----

--KWs5EMOk1v6q47GL--


--===============4768675751200411511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============4768675751200411511==--


