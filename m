Return-Path: <bpf+bounces-19487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C937482C64D
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 21:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71DA4287D50
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 20:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2425F168A2;
	Fri, 12 Jan 2024 20:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Fgs9+S9+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9E916417
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d54b86538aso38241855ad.0
        for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 12:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705090609; x=1705695409; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GThtuLp5dEKU7cGoP7pr5ztEC86PdrSRagZYibpGtVk=;
        b=Fgs9+S9+VbD0KY4OuCT2uMOJaW+PNkc/85oKkyrIZTd4dlb1oqsW0YDnDxCbtLv4WJ
         Naar1vdeZlLfrUxihfnjfXi5frTld1FF8U4+vokjc4oZqcPwGw5aCjhKe3pUsKjn8llT
         QvLU/8ozw1VYRI8wRt0XKwOiVQYT+Q92oOv3yOCK9JhH8uk2sNrdR4KwEUZBRIOKoI+4
         y2k+E4Se/MK1rLZaGiE8e/AXE2jczVdmonZKzyrQRPwm/b92ZyjF4Mg57L3I5FueKp4R
         GHgmpHxeVVQmg+OR095WqYotk7KTO2aKfcN08JvnaIjZWmXqrcytDQZQQyHVBzcTR/9D
         evlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705090609; x=1705695409;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GThtuLp5dEKU7cGoP7pr5ztEC86PdrSRagZYibpGtVk=;
        b=Rpo8c2EAWG3xWFFFldw6jcb1jHAInln3K4DGtqNazq3tMIphQe9lnY0A+Jkt00/OpA
         421Y89nRBYvl/Bg8d9SnFKDJK2OzELEl6flG0gZqdWp7b663C9WYpQRX/FcF39QqG12S
         A0w3t59dEn9W4c0O65OiCjQILS/SGKAW6lUggQJyXALSVrsDlaZrgDjN6CuUkNGO2vEv
         GgYZva4iSTOf+ue9Kl7K0EIJjU86yBLPsB1JWLUzhQk3Gl/HcNU3vagpyAPqKmJZd4xL
         qTWeMFPYHFYwqjJJmzo4NcfBVhs/YQMwc8gEASasiGa3XF9Z09WMBw53QOUajCf+gH4z
         D4Cw==
X-Gm-Message-State: AOJu0YznENi75IwpTnVmIXqDa+Eygtkis+NUOHXVWl2R7GmapDpmMH5y
	JK+YT0iy7MDyJrXzCl3DfWV288MXlVVwGw==
X-Google-Smtp-Source: AGHT+IERW5XSbTb++I+ILOx+rpFMCIQ/ZH3qtWc1hQaI1Up4Z6olSn9h/ap2WH7P3907RI2/tC5vzA==
X-Received: by 2002:a17:902:f54e:b0:1d4:ceaf:e7bd with SMTP id h14-20020a170902f54e00b001d4ceafe7bdmr1674077plf.99.1705090608818;
        Fri, 12 Jan 2024 12:16:48 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id ji1-20020a170903324100b001d56a8020desm3560772plb.107.2024.01.12.12.16.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jan 2024 12:16:48 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'David Vernet'" <void@manifault.com>,
	<dthaler1968@googlemail.com>
Cc: "'Aoyang Fang'" <aoyangfang@link.cuhk.edu.cn>,
	<bpf@vger.kernel.org>,
	<bpf@ietf.org>
References: <20240105031450.57681-2-aoyangfang@link.cuhk.edu.cn> <20240109173227.GB79024@maniforge> <016101da4326$8dbad1a0$a93074e0$@gmail.com> <20240109191037.GC79024@maniforge>
In-Reply-To: <20240109191037.GC79024@maniforge>
Subject: RE: [PATCH bpf-next] The original document has some inconsistency.
Date: Fri, 12 Jan 2024 12:16:47 -0800
Message-ID: <025c01da4594$4544e3f0$cfceabd0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI1wP8LxzfmoxB4tOuKvJCTZksNJgF+CbdPAgEaFl8CBSGlwq/zgVcA
Content-Language: en-us

David Vernet <void@manifault.com> wrote:
[...]
> > > > For example:
> > > > 1. 1.3.1 Arithmetic instructions use '8 bits length' encoding to
> > > >    express the 'code' value, e.g., BPF_ADD=0x00, BPF_SUB=0x10,
> > > >    BPF_MUL=0x20. However the length of the 'code' is 4 bits. On the
> > > >    other hand, 1.3.3 Jump instructions use '4 bits length' encoding,
> > > >    e.g., BPF_JEQ=0x1 and BPF_JGT=0x2.
> > > > 2. There are also many places that use '8 bits length' encoding to
> > > >    express the corresponding contents, e.g., 1.4 Load and store
> > > >    instructions, BPF_ABS=0x20, BPF_IND=0x40. However, the length of
> > > >    'mode modifier' is 3 bits.
> > > >
> > > > To summarize, the only place that has inconsistent encoding is
> > > > Jump instructions. After discussing with Dave,
> > > > dthaler1968@googlemail.com, we agree that the document should be
> more clear.
> > > >
> > > > Signed-off-by: Aoyang Fang <aoyangfang@link.cuhk.edu.cn>
> > > >
> > > > ---
> > > >  .../bpf/standardization/instruction-set.rst   | 170
+++++++++---------
> > > >  1 file changed, 85 insertions(+), 85 deletions(-)
> > > >
> > > > diff --git a/Documentation/bpf/standardization/instruction-set.rst
> > > > b/Documentation/bpf/standardization/instruction-set.rst
> > > > index 245b6defc..57dd1fa00 100644
> > > > --- a/Documentation/bpf/standardization/instruction-set.rst
> > > > +++ b/Documentation/bpf/standardization/instruction-set.rst
> > > > @@ -172,18 +172,18 @@ Instruction classes
> > > >
> > > >  The three LSB bits of the 'opcode' field store the instruction
class:
> > > >
> > > > -=========  =====  ===============================
> > > ===================================
> > > > -class      value  description                      reference
> > > > -=========  =====  ===============================
> > > ===================================
> > > > -BPF_LD     0x00   non-standard load operations     `Load and store
> > > instructions`_
> > > > -BPF_LDX    0x01   load into register operations    `Load and store
> > > instructions`_
> > > > -BPF_ST     0x02   store from immediate operations  `Load and store
> > > instructions`_
> > > > -BPF_STX    0x03   store from register operations   `Load and store
> > > instructions`_
> > > > -BPF_ALU    0x04   32-bit arithmetic operations     `Arithmetic and
jump
> > > instructions`_
> > > > -BPF_JMP    0x05   64-bit jump operations           `Arithmetic and
jump
> > > instructions`_
> > > > -BPF_JMP32  0x06   32-bit jump operations           `Arithmetic and
jump
> > > instructions`_
> > > > -BPF_ALU64  0x07   64-bit arithmetic operations     `Arithmetic and
jump
> > > instructions`_
> > > > -=========  =====  ===============================
> > > > ===================================
> > > > +=========  =============  ===============================
> > > ===================================
> > > > +class      value(3 bits)  description
reference
> > > > +=========  =============  ===============================
> > > ===================================
> > > > +BPF_LD     0x0            non-standard load operations     `Load
and
> > store
> > > instructions`_
> > > > +BPF_LDX    0x1            load into register operations    `Load
and
> > store
> > > instructions`_
> > > > +BPF_ST     0x2            store from immediate operations  `Load
and
> > store
> > > instructions`_
> > > > +BPF_STX    0x3            store from register operations   `Load
and
> > store
> > > instructions`_
> > > > +BPF_ALU    0x4            32-bit arithmetic operations
`Arithmetic
> > and jump
> > > instructions`_
> > > > +BPF_JMP    0x5            64-bit jump operations
`Arithmetic
> > and jump
> > > instructions`_
> > > > +BPF_JMP32  0x6            32-bit jump operations
`Arithmetic
> > and jump
> > > instructions`_
> > > > +BPF_ALU64  0x7            64-bit arithmetic operations
`Arithmetic
> > and jump
> > > instructions`_
> > > > +=========  =============  ===============================
> > > > +===================================
> > >
> > > Hmm, I presonally think this is more confusing. The opcode field is
> > > 8
> > bits. We
> > > already specify that the value is the three LSB of the opcode field.
> > > It's certainly subjective, but I think we should have the value
> > > reflect the
> > actual
> > > value in the field it's embedded in. In my opinion, changing the
> > > value to
> > not
> > > reflect its place in the actual opcode in my opinion imposes a
> > > burden on
> > the
> > > reader to go back and reference where the field actually belongs in
> > > the
> > full
> > > opcode. It's a tradeoff, but I think we're already on the winning
> > > end of
> > that
> > > tradeoff.
> >
> > This document is an IETF standards specification so it's worth looking
> > at what typical RFC conventions are.
> >
> > * RFC 791 section 3.1 defines the IPv4 header, where the Version field
> > is the high
> >    4 bits of a byte.  It defines the value as 4, not 0x40.
> >    It also defines the Type of Service bits which are 1 bit fields
> > with value 0 or 1
> >    (not, say 0x40).
> > * RFC 8200 section 3 defines the IPv6 header, where the Version field
> > is the high
> >    4 bits of a byte.  It defines the value as 6, not 0x60.
> 
> I definitely believe we should follow IETF conventions, but from looking
at [0]
> it looks like we're already deviating.
> 
> [0]: https://www.rfc-editor.org/rfc/rfc791.txt
> 
> Here are some excerpts from what's there:
> 
>
----------------------------------------------------------------------------
---
> 
> 3.1.  Internet Header Format
> 
>   A summary of the contents of the internet header follows:
> 
> 
>     0                   1                   2                   3
>     0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
>    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>    |Version|  IHL  |Type of Service|          Total Length         |
>    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>    |         Identification        |Flags|      Fragment Offset    |
>    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>    |  Time to Live |    Protocol   |         Header Checksum       |
>    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>    |                       Source Address                          |
>    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>    |                    Destination Address                        |
>    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>    |                    Options                    |    Padding    |
>    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> 
>                     Example Internet Datagram Header
> 
>                                Figure 4.
> 
>   Note that each tick mark represents one bit position.
> 
>   Version:  4 bits
> 
>     The Version field indicates the format of the internet header.  This
>     document describes version 4.
> 
> [...]
> 
>   Type of Service:  8 bits
> 
>     The Type of Service provides an indication of the abstract
>     parameters of the quality of service desired.  These parameters are
>     to be used to guide the selection of the actual service parameters
>     when transmitting a datagram through a particular network.  Several
>     networks offer service precedence, which somehow treats high
>     precedence traffic as more important than other traffic (generally
>     by accepting only traffic above a certain precedence at time of high
>     load).  The major choice is a three way tradeoff between low-delay,
>     high-reliability, and high-throughput.
> 
>       Bits 0-2:  Precedence.
>       Bit    3:  0 = Normal Delay,      1 = Low Delay.
>       Bits   4:  0 = Normal Throughput, 1 = High Throughput.
>       Bits   5:  0 = Normal Relibility, 1 = High Relibility.
>       Bit  6-7:  Reserved for Future Use.
> 
>          0     1     2     3     4     5     6     7
>       +-----+-----+-----+-----+-----+-----+-----+-----+
>       |                 |     |     |     |     |     |
>       |   PRECEDENCE    |  D  |  T  |  R  |  0  |  0  |
>       |                 |     |     |     |     |     |
>       +-----+-----+-----+-----+-----+-----+-----+-----+
> 
>         Precedence
> 
>           111 - Network Control
>           110 - Internetwork Control
>           101 - CRITIC/ECP
>           100 - Flash Override
>           011 - Flash
>           010 - Immediate
>           001 - Priority
>           000 - Routine
> 
> [...]
> 
> APPENDIX A:  Examples & Scenarios
> 
> Example 1:
> 
>   This is an example of the minimal data carrying internet datagram:
> 
> 
>     0                   1                   2                   3
>     0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
>    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>    |Ver= 4 |IHL= 5 |Type of Service|        Total Length = 21      |
>    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>    |      Identification = 111     |Flg=0|   Fragment Offset = 0   |
>    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>    |   Time = 123  |  Protocol = 1 |        header checksum        |
>    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>    |                         source address                        |
>    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>    |                      destination address                      |
>    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>    |     data      |
>    +-+-+-+-+-+-+-+-+
> 
>
----------------------------------------------------------------------------
---
> 
> This is already pretty different from how we're visualizing and
enumerating
> the instructions in our document.

The packet layout diagram style above is indeed the most common
(and I'd be fine if the WG wants to switch to that style), but there are
RFCs that use other styles.  See for example RFC 9000 which uses a custom
style, but has a full explanation defining it.

> Consider:
> 
> 1. They're not even using numerical values to define some fields, such
>    as with Type of Service. They're specifying the exact values of
>    individual bits within the field (e.g. with Precedence).
> 
> 2. They're using decimal instead of hexadecimal.

Sometimes values are given in decimal, sometimes in hexadecimal
(e.g., see Table 1 of RFC 9000), sometimes in binary (e.g., Precedence as
you noted).  Decimal is most common but hex or binary are ok if it's clear
that's what's used.
 
> Unless I'm missing something, it seems like the deviation in terms of
using
> 0x40 vs. 0x4 is specific to how they present examples in the appendices
> (though even the appendices are using base 10).

For a 4-bit field, I've only seen cases where the value is 0x4, 4, or 0100,
which fit into a 4-bit field.  I've not seen a case of 0x40.

> So while I certainly agree that we should follow conventions, I think I'd
prefer
> that we either follow them completely, or not sacrifice readability by
following
> them in specific ways which don't necessarily match the chosen format for
> our document.

If you're suggesting we use packet layout format like you quoted, that'd
be fine with me.

> > Etc.  Offhand I am not aware of any RFC that uses the convention you
> > suggest, though perhaps others are?
> 
> I am not, no.
> 
> > > >  Arithmetic and jump instructions
> > > >  ================================
> > > > @@ -203,12 +203,12 @@ code            source  instruction class
> > > >  **source**
> > > >    the source operand location, which unless otherwise specified
> > > > is one
> > of:
> > > >
> > > > -  ======  =====
> ==============================================
> > > > -  source  value  description
> > > > -  ======  =====
> ==============================================
> > > > -  BPF_K   0x00   use 32-bit 'imm' value as source operand
> > > > -  BPF_X   0x08   use 'src_reg' register value as source operand
> > > > -  ======  =====
> ==============================================
> > > > +  ======  ============
> > > > + ==============================================
> > > > +  source  value(1 bit)  description  ======  ============
> > > ==============================================
> > > > +  BPF_K   0x0           use 32-bit 'imm' value as source operand
> > > > +  BPF_X   0x1           use 'src_reg' register value as source
operand
> > > > +  ======  ============
> > > > + ==============================================
> > >
> > > Same here as well. The value isn't really 0x1, it's 0x8. And 0x08 is
> > > even
> > more
> > > clear yet, given that we're representing the value of the bit in the
> > > 8 bit
> > opcode
> > > field.
> >
> > Its 1, in the same sense as the TOS bits in RFC 791 are 1.
> >
> > > >  **instruction class**
> > > >    the instruction class (see `Instruction classes`_) @@ -221,27
> > > > +221,27 @@ otherwise identical operations.
> > > >  The 'code' field encodes the operation as below, where 'src' and
> > > > 'dst' refer  to the values of the source and destination
> > > > registers,
> > respectively.
> > > >
> > > > -=========  =====  =======
> > > ==========================================================
> > > > -code       value  offset   description
> > > > -=========  =====  =======
> > > ==========================================================
> > > > -BPF_ADD    0x00   0        dst += src
> > > > -BPF_SUB    0x10   0        dst -= src
> > > > -BPF_MUL    0x20   0        dst \*= src
> > > > -BPF_DIV    0x30   0        dst = (src != 0) ? (dst / src) : 0
> > > > -BPF_SDIV   0x30   1        dst = (src != 0) ? (dst s/ src) : 0
> > > > -BPF_OR     0x40   0        dst \|= src
> > > > -BPF_AND    0x50   0        dst &= src
> > > > -BPF_LSH    0x60   0        dst <<= (src & mask)
> > > > -BPF_RSH    0x70   0        dst >>= (src & mask)
> > > > -BPF_NEG    0x80   0        dst = -dst
> > > > -BPF_MOD    0x90   0        dst = (src != 0) ? (dst % src) : dst
> > > > -BPF_SMOD   0x90   1        dst = (src != 0) ? (dst s% src) : dst
> > > > -BPF_XOR    0xa0   0        dst ^= src
> > > > -BPF_MOV    0xb0   0        dst = src
> > > > -BPF_MOVSX  0xb0   8/16/32  dst = (s8,s16,s32)src
> > > > -BPF_ARSH   0xc0   0        :term:`sign extending<Sign Extend>` dst
>>=
> > (src &
> > > mask)
> > > > -BPF_END    0xd0   0        byte swap operations (see `Byte swap
> > instructions`_
> > > below)
> > > >
> > > > -=========  =====  =======
> > > > ==========================================================
> > > > +=========  =============  =======
> > > ==========================================================
> > > > +code       value(4 bits)  offset   description
> > > > +=========  =============  =======
> > > ==========================================================
> > > > +BPF_ADD    0x0            0        dst += src
> > > > +BPF_SUB    0x1            0        dst -= src
> > > > +BPF_MUL    0x2            0        dst \*= src
> > > > +BPF_DIV    0x3            0        dst = (src != 0) ? (dst / src) :
0
> > > > +BPF_SDIV   0x3            1        dst = (src != 0) ? (dst s/ src)
: 0
> > > > +BPF_OR     0x4            0        dst \|= src
> > > > +BPF_AND    0x5            0        dst &= src
> > > > +BPF_LSH    0x6            0        dst <<= (src & mask)
> > > > +BPF_RSH    0x7            0        dst >>= (src & mask)
> > > > +BPF_NEG    0x8            0        dst = -dst
> > > > +BPF_MOD    0x9            0        dst = (src != 0) ? (dst % src) :
dst
> > > > +BPF_SMOD   0x9            1        dst = (src != 0) ? (dst s% src)
:
> > dst
> > > > +BPF_XOR    0xa            0        dst ^= src
> > > > +BPF_MOV    0xb            0        dst = src
> > > > +BPF_MOVSX  0xb            8/16/32  dst = (s8,s16,s32)src
> > > > +BPF_ARSH   0xc            0        :term:`sign extending<Sign
Extend>`
> > dst >>=
> > > (src & mask)
> > > > +BPF_END    0xd            0        byte swap operations (see `Byte
swap
> > > instructions`_ below)
> > > > +=========  =============  =======
> > > > +==========================================================
> > >
> > > Same here.
> > >
> > > >  Underflow and overflow are allowed during arithmetic operations,
> > > > meaning  the 64-bit or 32-bit value will wrap. If BPF program
> > > > execution would @@ -314,13 +314,13 @@ select what byte order the
> > > > operation converts from or to. For  ``BPF_ALU64``, the 1-bit
> > > > source operand field in the opcode is reserved  and must be set to
0.
> > > >
> > > > -=========  =========  =====
> > > =================================================
> > > > -class      source     value  description
> > > > -=========  =========  =====
> > > =================================================
> > > > -BPF_ALU    BPF_TO_LE  0x00   convert between host byte order and
little
> > > endian
> > > > -BPF_ALU    BPF_TO_BE  0x08   convert between host byte order and
big
> > > endian
> > > > -BPF_ALU64  Reserved   0x00   do byte swap unconditionally
> > > > -=========  =========  =====
> > > > =================================================
> > > > +=========  =========  ============
> > > =================================================
> > > > +class      source     value(1 bit)  description
> > > > +=========  =========  ============
> > > =================================================
> > > > +BPF_ALU    BPF_TO_LE  0x0           convert between host byte order
and
> > little
> > > endian
> > > > +BPF_ALU    BPF_TO_BE  0x1           convert between host byte order
and
> > big
> > > endian
> > > > +BPF_ALU64  Reserved   0x0           do byte swap unconditionally
> > > > +=========  =========  ============
> > > > +=================================================
> > >
> > > Same here. Which bit does the 0x1 actually correspond to? It's
> > self-evident in
> > > the former, not the latter.
> >
> > Would you then say that RFC 791 (and many RFCs since) is not
self-evident?
> 
> Not at all, I would say that they're presenting their information in a
very
> different way. Imagine if they presented Type of Service in this
> way:
> 
> Type of Service: 8 bits
> 
> ============  =====  ========== ===========  ========
> 3 bits (MSB)  1 bit  1 bit      1 bit        2 bits
> ============  =====  ========== ===========  ========
> Precedence    Delay  Throughput Reliability  Reserved
> ============  =====  ========== ===========  ========
> 
> **Precedence**
> The precedence with which traffic should be served.
> 
> **Delay**
> The quality of service requirement for delay.
> 
> **Throughput**
> The quality of service requirement for throughput.
> 
> **Reliability**
> The quality of service requirement for reliability.
> 
> **Reserved**
> Bits reserved for future use

That would be possible, just like the RFC 9000 style was
possible for QUIC.  But the values would still fit in the
defined field widths.

> Precedence types
> ----------------
> 
> ...
> 
> ==========           =====
> Precedence           value
> ==========           =====
> Routine              0x0
> Priority             0x1
> Immediate            0x2
> Flash                0x3
> Flash Override       0x4
> CRITIC/ECP           0x5
> Internetwork Control 0x6
> Network Control      0x7

Yes, the key being the values fit into 3 bits, as opposed
to Priority being shown as 0x20.

> 
> Delay
> -----
> 
> =====         =====
> Delay         value
> =====         =====
> Normal Delay  0x0
> Low Delay     0x1
> 
> Throughput
> ----------
> 
> ==========         =====
> Throughput         value
> ==========         =====
> Normal Throughput  0x0
> High Throughput    0x1
> 
> Reliability
> -----
> 
> ===========         =====
> Reliability         value
> ===========         =====
> Normal Reliability  0x0
> High Reliability    0x1
> 
> Reserved
> --------
> 
> ==============  =====
> Resrved         value
> ==============  =====
> Reserved bit 0  0x0
> Reserved bit 1  0x1
> Reserved bit 2  0x2
> Reserved bit 3  0x3
> 
> -----
> 
> This is of course in contrast to the much more concise way they defined it
> above. If they did end up defining it this way, I think it would be less
clear to
> use the actual bit values rather than just the actual value in the Type of
> Service mask. It's subjective, but I just don't really see them as
equivalent.
> 
> > If the WG chooses to diverge from the most common ways the IETF
> > defines bit formats, that might be ok but may need a section explaining
the
> > divergent convention.   My personal preference though is to stay
consistent
> > with the normal IETF convention, which part of the ISA doc already did.
> 
> I agree with you that we should stay consistent, but it seems like we're
being
> selective about it. Could you help me understand why the deviations we
have
> already wouldn't have required a separate section?

It's fair to argue that having a section defining the convention, like RFC
9000 did,
would be recommended if one deviates from standard conventions.  
But it'd be shorter (and perhaps less work) to use a more standard
convention.

Dave



