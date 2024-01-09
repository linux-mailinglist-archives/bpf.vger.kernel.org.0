Return-Path: <bpf+bounces-19275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DB9828BE9
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 19:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A9C288570
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 18:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505863BB46;
	Tue,  9 Jan 2024 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="JqW1Jqhr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="OYcr4kUv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RA71pFE3"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB17C142
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 18:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 36C39C1519BB
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 10:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1704823590; bh=70gZjbxNOTraBDwCOsGFpV1ftCZ4+/PQ92tEOU3uLJI=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JqW1JqhrIWghKzZtNTB2A+mGPCId25eN0Opq2UCoCwOG39M1XzMER1Toqj4asHFtO
	 HSXFoOGwRUcpFfDYUJXLXE+BwQ91+lmEwkmUrtHjX7JXUeeYVMYMZa0eW8cDIU3cRf
	 X/LVbZaT8PUJhf0y0U11P9fZ6vnuE6wWjz/j2vOY=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 126B2C15199B;
 Tue,  9 Jan 2024 10:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1704823590; bh=70gZjbxNOTraBDwCOsGFpV1ftCZ4+/PQ92tEOU3uLJI=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=OYcr4kUvBTZovQ3GEDVMmSOAh7wNDWeADtJjA7GW9Lwfuv5BHXHWrTAWHtg9BOAqf
 tJVb/lvuZY33G1fEqmdzlJQ98JkGHfTPka8K6+vjJi6gcuyX5jzvMxPuuHcPW5lHX9
 xRkhHAICa8FBp6WK19AnW3Z3fYhQDfH+/CyANScw=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 1F4BEC151998
 for <bpf@ietfa.amsl.com>; Tue,  9 Jan 2024 10:06:29 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yzGoZ7JFEqPX for <bpf@ietfa.amsl.com>;
 Tue,  9 Jan 2024 10:06:25 -0800 (PST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 479EDC14F74E
 for <bpf@ietf.org>; Tue,  9 Jan 2024 10:06:25 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d4a2526a7eso16414245ad.3
 for <bpf@ietf.org>; Tue, 09 Jan 2024 10:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1704823584; x=1705428384; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=U25Q7Bky2SQDCwPSDu/qLPO3Ikh5MXLLwfZ2ubor4bc=;
 b=RA71pFE3I/JxaeV7cfUevbgtGyvsC4mItayIipHJBFxF0T5caKDV2sddzM5umNvHjl
 oCweqTbVGSa2lUR/L2Ai4DOhbloG4J0YzRM4bGrRiQWjj6KySZci5nWMkeZlPwdn6soq
 kMzOsvxbFKtUjxVfgeyzQYEA1FeBCnn4jTHE+uLTVHO+woRvv7RWV5zeAW6XkXN9cx0I
 PsvIzGieWWGtEj6FR8e525VIjA9XMmWfWgIhepikv+III2TfWDy0ezRtirtykke3fuSU
 FDMJrUVneHUxshUxjsBpsM4BoEaPNsPooRB4Mfy5MfCS3bbMpRG14lMSogQE4SyQayfZ
 +gpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704823584; x=1705428384;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U25Q7Bky2SQDCwPSDu/qLPO3Ikh5MXLLwfZ2ubor4bc=;
 b=p1+mO7Y0CZ31bbzt4oZ+xmYcd+cbfj6YMTTfTg/81jNUusaNiFtlMWlVnvYv0/Ur3V
 OdzOfy69wpiSQtFeZKP+BjGkM6iHBd/H/g59ti5Rsz0KL/vZbZgR3Ac/YNRvLEJvJVh+
 zy74lgs687zT0isUN502TuOz75MWyTgRceXlAJZMrVXkaJM6HxtHWJ3UGfukK+D+hoBI
 PQoSdLrTR1OyT2qY/Q4g4o2q8/wS2iNG8wJAJuAXiYJDQ+BBMDcn3viyM+ZGSnA1VyPl
 Mdbxj9fIAwEks2KAZbZAbVgOy7HkGLYFnF0imy49mDlGF1ssKCKgPAWVSIAvYB7cGmZN
 G5IA==
X-Gm-Message-State: AOJu0YzaR9EdS4TwVbj90ml22KwD10Jv+1DJK6+b1qLQAD85Ys04dfwS
 OekeEY6dYoX33wDL1M1CgqQ=
X-Google-Smtp-Source: AGHT+IE6W5Mk+Evlcwr5Kru3as/e/t5osxM09raTZxhHRhJBvII8yFFG5NPzm2g8Gj0tN34PJUBtyg==
X-Received: by 2002:a17:903:124a:b0:1d4:60b8:aefa with SMTP id
 u10-20020a170903124a00b001d460b8aefamr3685811plh.9.1704823584188; 
 Tue, 09 Jan 2024 10:06:24 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 q1-20020a170902bd8100b001d06b63bb98sm2081032pls.71.2024.01.09.10.06.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jan 2024 10:06:23 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'David Vernet'" <void@manifault.com>,
 "'Aoyang Fang'" <aoyangfang@link.cuhk.edu.cn>
Cc: <bpf@vger.kernel.org>,
	<bpf@ietf.org>,
	<dthaler1968@googlemail.com>
References: <20240105031450.57681-2-aoyangfang@link.cuhk.edu.cn>
 <20240109173227.GB79024@maniforge>
In-Reply-To: <20240109173227.GB79024@maniforge>
Date: Tue, 9 Jan 2024 10:06:22 -0800
Message-ID: <016101da4326$8dbad1a0$a93074e0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI1wP8LxzfmoxB4tOuKvJCTZksNJgF+CbdPsA7WTWA=
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/RfV-zJbxZ-EwxYp60tRB-KO7NhA>
Subject: Re: [Bpf] [PATCH bpf-next] The original document has some
 inconsistency.
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

David Vernet <void@manifault.com> writes: 
> Hi Aoyang,
> 
> Thanks a lot for your contribution. I agree that we need to fix the
document
> to be consistent, though I'm afraid that I think this patch goes in the
wrong
> direction by making everything match the jump instruction class. More
below.

I disagree, and I agree with Aoyang's direction.

> nit: Could you please update the patch subject to be more self-describing.
For
> example, something like:
> 
> Use consistent numerical widths in instructions.rst encodings

I agree with that subject.

> > For example:
> > 1. 1.3.1 Arithmetic instructions use '8 bits length' encoding to
> >    express the 'code' value, e.g., BPF_ADD=0x00, BPF_SUB=0x10,
> >    BPF_MUL=0x20. However the length of the 'code' is 4 bits. On the
> >    other hand, 1.3.3 Jump instructions use '4 bits length' encoding,
> >    e.g., BPF_JEQ=0x1 and BPF_JGT=0x2.
> > 2. There are also many places that use '8 bits length' encoding to
> >    express the corresponding contents, e.g., 1.4 Load and store
> >    instructions, BPF_ABS=0x20, BPF_IND=0x40. However, the length of
> >    'mode modifier' is 3 bits.
> >
> > To summarize, the only place that has inconsistent encoding is Jump
> > instructions. After discussing with Dave, dthaler1968@googlemail.com,
> > we agree that the document should be more clear.
> >
> > Signed-off-by: Aoyang Fang <aoyangfang@link.cuhk.edu.cn>
> >
> > ---
> >  .../bpf/standardization/instruction-set.rst   | 170 +++++++++---------
> >  1 file changed, 85 insertions(+), 85 deletions(-)
> >
> > diff --git a/Documentation/bpf/standardization/instruction-set.rst
> > b/Documentation/bpf/standardization/instruction-set.rst
> > index 245b6defc..57dd1fa00 100644
> > --- a/Documentation/bpf/standardization/instruction-set.rst
> > +++ b/Documentation/bpf/standardization/instruction-set.rst
> > @@ -172,18 +172,18 @@ Instruction classes
> >
> >  The three LSB bits of the 'opcode' field store the instruction class:
> >
> > -=========  =====  ===============================
> ===================================
> > -class      value  description                      reference
> > -=========  =====  ===============================
> ===================================
> > -BPF_LD     0x00   non-standard load operations     `Load and store
> instructions`_
> > -BPF_LDX    0x01   load into register operations    `Load and store
> instructions`_
> > -BPF_ST     0x02   store from immediate operations  `Load and store
> instructions`_
> > -BPF_STX    0x03   store from register operations   `Load and store
> instructions`_
> > -BPF_ALU    0x04   32-bit arithmetic operations     `Arithmetic and jump
> instructions`_
> > -BPF_JMP    0x05   64-bit jump operations           `Arithmetic and jump
> instructions`_
> > -BPF_JMP32  0x06   32-bit jump operations           `Arithmetic and jump
> instructions`_
> > -BPF_ALU64  0x07   64-bit arithmetic operations     `Arithmetic and jump
> instructions`_
> > -=========  =====  ===============================
> > ===================================
> > +=========  =============  ===============================
> ===================================
> > +class      value(3 bits)  description                      reference
> > +=========  =============  ===============================
> ===================================
> > +BPF_LD     0x0            non-standard load operations     `Load and
store
> instructions`_
> > +BPF_LDX    0x1            load into register operations    `Load and
store
> instructions`_
> > +BPF_ST     0x2            store from immediate operations  `Load and
store
> instructions`_
> > +BPF_STX    0x3            store from register operations   `Load and
store
> instructions`_
> > +BPF_ALU    0x4            32-bit arithmetic operations     `Arithmetic
and jump
> instructions`_
> > +BPF_JMP    0x5            64-bit jump operations           `Arithmetic
and jump
> instructions`_
> > +BPF_JMP32  0x6            32-bit jump operations           `Arithmetic
and jump
> instructions`_
> > +BPF_ALU64  0x7            64-bit arithmetic operations     `Arithmetic
and jump
> instructions`_
> > +=========  =============  ===============================
> > +===================================
> 
> Hmm, I presonally think this is more confusing. The opcode field is 8
bits. We
> already specify that the value is the three LSB of the opcode field. It's
> certainly subjective, but I think we should have the value reflect the
actual
> value in the field it's embedded in. In my opinion, changing the value to
not
> reflect its place in the actual opcode in my opinion imposes a burden on
the
> reader to go back and reference where the field actually belongs in the
full
> opcode. It's a tradeoff, but I think we're already on the winning end of
that
> tradeoff.

This document is an IETF standards specification so it's worth looking at
what
typical RFC conventions are.

* RFC 791 section 3.1 defines the IPv4 header, where the Version field is
the high
   4 bits of a byte.  It defines the value as 4, not 0x40.
   It also defines the Type of Service bits which are 1 bit fields with
value 0 or 1
   (not, say 0x40).
* RFC 8200 section 3 defines the IPv6 header, where the Version field is the
high
   4 bits of a byte.  It defines the value as 6, not 0x60.

Etc.  Offhand I am not aware of any RFC that uses the convention you
suggest,
though perhaps others are?

> >  Arithmetic and jump instructions
> >  ================================
> > @@ -203,12 +203,12 @@ code            source  instruction class
> >  **source**
> >    the source operand location, which unless otherwise specified is one
of:
> >
> > -  ======  =====  ==============================================
> > -  source  value  description
> > -  ======  =====  ==============================================
> > -  BPF_K   0x00   use 32-bit 'imm' value as source operand
> > -  BPF_X   0x08   use 'src_reg' register value as source operand
> > -  ======  =====  ==============================================
> > +  ======  ============
> > + ==============================================
> > +  source  value(1 bit)  description
> > +  ======  ============
> ==============================================
> > +  BPF_K   0x0           use 32-bit 'imm' value as source operand
> > +  BPF_X   0x1           use 'src_reg' register value as source operand
> > +  ======  ============
> > + ==============================================
> 
> Same here as well. The value isn't really 0x1, it's 0x8. And 0x08 is even
more
> clear yet, given that we're representing the value of the bit in the 8 bit
opcode
> field.

Its 1, in the same sense as the TOS bits in RFC 791 are 1.

> >  **instruction class**
> >    the instruction class (see `Instruction classes`_) @@ -221,27
> > +221,27 @@ otherwise identical operations.
> >  The 'code' field encodes the operation as below, where 'src' and
> > 'dst' refer  to the values of the source and destination registers,
respectively.
> >
> > -=========  =====  =======
> ==========================================================
> > -code       value  offset   description
> > -=========  =====  =======
> ==========================================================
> > -BPF_ADD    0x00   0        dst += src
> > -BPF_SUB    0x10   0        dst -= src
> > -BPF_MUL    0x20   0        dst \*= src
> > -BPF_DIV    0x30   0        dst = (src != 0) ? (dst / src) : 0
> > -BPF_SDIV   0x30   1        dst = (src != 0) ? (dst s/ src) : 0
> > -BPF_OR     0x40   0        dst \|= src
> > -BPF_AND    0x50   0        dst &= src
> > -BPF_LSH    0x60   0        dst <<= (src & mask)
> > -BPF_RSH    0x70   0        dst >>= (src & mask)
> > -BPF_NEG    0x80   0        dst = -dst
> > -BPF_MOD    0x90   0        dst = (src != 0) ? (dst % src) : dst
> > -BPF_SMOD   0x90   1        dst = (src != 0) ? (dst s% src) : dst
> > -BPF_XOR    0xa0   0        dst ^= src
> > -BPF_MOV    0xb0   0        dst = src
> > -BPF_MOVSX  0xb0   8/16/32  dst = (s8,s16,s32)src
> > -BPF_ARSH   0xc0   0        :term:`sign extending<Sign Extend>` dst >>=
(src &
> mask)
> > -BPF_END    0xd0   0        byte swap operations (see `Byte swap
instructions`_
> below)
> >
> > -=========  =====  =======
> > ==========================================================
> > +=========  =============  =======
> ==========================================================
> > +code       value(4 bits)  offset   description
> > +=========  =============  =======
> ==========================================================
> > +BPF_ADD    0x0            0        dst += src
> > +BPF_SUB    0x1            0        dst -= src
> > +BPF_MUL    0x2            0        dst \*= src
> > +BPF_DIV    0x3            0        dst = (src != 0) ? (dst / src) : 0
> > +BPF_SDIV   0x3            1        dst = (src != 0) ? (dst s/ src) : 0
> > +BPF_OR     0x4            0        dst \|= src
> > +BPF_AND    0x5            0        dst &= src
> > +BPF_LSH    0x6            0        dst <<= (src & mask)
> > +BPF_RSH    0x7            0        dst >>= (src & mask)
> > +BPF_NEG    0x8            0        dst = -dst
> > +BPF_MOD    0x9            0        dst = (src != 0) ? (dst % src) : dst
> > +BPF_SMOD   0x9            1        dst = (src != 0) ? (dst s% src) :
dst
> > +BPF_XOR    0xa            0        dst ^= src
> > +BPF_MOV    0xb            0        dst = src
> > +BPF_MOVSX  0xb            8/16/32  dst = (s8,s16,s32)src
> > +BPF_ARSH   0xc            0        :term:`sign extending<Sign Extend>`
dst >>=
> (src & mask)
> > +BPF_END    0xd            0        byte swap operations (see `Byte swap
> instructions`_ below)
> > +=========  =============  =======
> > +==========================================================
> 
> Same here.
> 
> >  Underflow and overflow are allowed during arithmetic operations,
> > meaning  the 64-bit or 32-bit value will wrap. If BPF program
> > execution would @@ -314,13 +314,13 @@ select what byte order the
> > operation converts from or to. For  ``BPF_ALU64``, the 1-bit source
> > operand field in the opcode is reserved  and must be set to 0.
> >
> > -=========  =========  =====
> =================================================
> > -class      source     value  description
> > -=========  =========  =====
> =================================================
> > -BPF_ALU    BPF_TO_LE  0x00   convert between host byte order and little
> endian
> > -BPF_ALU    BPF_TO_BE  0x08   convert between host byte order and big
> endian
> > -BPF_ALU64  Reserved   0x00   do byte swap unconditionally
> > -=========  =========  =====
> > =================================================
> > +=========  =========  ============
> =================================================
> > +class      source     value(1 bit)  description
> > +=========  =========  ============
> =================================================
> > +BPF_ALU    BPF_TO_LE  0x0           convert between host byte order and
little
> endian
> > +BPF_ALU    BPF_TO_BE  0x1           convert between host byte order and
big
> endian
> > +BPF_ALU64  Reserved   0x0           do byte swap unconditionally
> > +=========  =========  ============
> > +=================================================
> 
> Same here. Which bit does the 0x1 actually correspond to? It's
self-evident in
> the former, not the latter.

Would you then say that RFC 791 (and many RFCs since) is not self-evident?

If the WG chooses to diverge from the most common ways the IETF defines
bit formats, that might be ok but may need a section explaining the
divergent convention.   My personal preference though is to stay consistent
with the normal IETF convention, which part of the ISA doc already did.

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

