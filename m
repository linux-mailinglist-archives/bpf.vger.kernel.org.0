Return-Path: <bpf+bounces-20750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E348429AD
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 17:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3137D28B375
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 16:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9550986AEF;
	Tue, 30 Jan 2024 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="nKy/wibs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="GD8U/+/9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="C2Op53Dg"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC2981AB6
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632790; cv=none; b=KZXhkuju9i2bH/1WoY1xFoJjKr0tElMgKh7yWCQ9n53EZbKWklb/wNIC/H8Q0dD8xocE5jF4ZKsc/7KdcXb+PHbD93nnbQPYnZHdr35McWs89XNa+Ax/W3ePaaq3Li4cdbRLVPBsDpX3fzdZcfYW0c3LRZ4CVUsb82vVN2cLB7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632790; c=relaxed/simple;
	bh=CzThqMSb5u3hQmK/3sds0SmdrHA6G4k1NEV9H1PH8Ws=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=hZWwZtAh5UHoOZaIL4xiny9aCyk8/CyvnluZZIHu5IL6Y7vcbz6GmwrIR+kR+NV+d8dHh2H1wg6/i8UfPUk46/wjBPHcCr7eFWPNSm7Msb+PtlAKrbpkFwkOs0oc/b2ePGm/dX9++jE58Y7eSQZRBlriWQXoe/QoIGVpTPJZG0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=nKy/wibs; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=GD8U/+/9 reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=C2Op53Dg reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id DBB74C1CAF2E
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 08:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706632787; bh=CzThqMSb5u3hQmK/3sds0SmdrHA6G4k1NEV9H1PH8Ws=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nKy/wibsAjaxAU0AIP6xaKSxeY42jMUSv5IqJy4WwQYOduujQlty7oHFsyv4mVOlD
	 GtTPdERwiMINxTen9+H4Xa4yKGLAp9O05s4v2Cl85RveMQy7ZhRFDlJ49ixhJBMMkE
	 yQj8+sCOXHm14lwgaRh4cmc4PH0VLQhb0k5DRIHY=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id BB9EBC14CE2E;
 Tue, 30 Jan 2024 08:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1706632787; bh=CzThqMSb5u3hQmK/3sds0SmdrHA6G4k1NEV9H1PH8Ws=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=GD8U/+/9JvaV1vrNoa/cE1NIhpuTrvlsJ+JGtKF15FCkEnIKw2KdxVgbyECKJpUrc
 nUsayHErG0Cfrjml+zYOiwxnJOu6Bp8vZdiFgMhh1y4rzgt5JjZB65FDjtgQ5Vvhjg
 dMPLUMr4mWIi46q4do8hd1A4dFoTgHfqolSyg2+Y=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id D2CFBC14CE2E
 for <bpf@ietfa.amsl.com>; Tue, 30 Jan 2024 08:39:46 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bcl9FX9eCCBv for <bpf@ietfa.amsl.com>;
 Tue, 30 Jan 2024 08:39:43 -0800 (PST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 055B3C14F71F
 for <bpf@ietf.org>; Tue, 30 Jan 2024 08:39:42 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5ce9555d42eso3446297a12.2
 for <bpf@ietf.org>; Tue, 30 Jan 2024 08:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1706632782; x=1707237582; darn=ietf.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7MA5MCIW7OXtKya9qDaWW4VnWdbv19urcqqsi2GglzI=;
 b=C2Op53Dgtr+SyCgycca3BoOOeqHapLU8A1IA5ojVo1xvjhn3w8vq4XgOAJaZKy8PGS
 tg4brsTEk2v4XqctVCsgMBOMKYadS9foh94PYdInQ7VtmvVvbkv1pKt7OUYisJEahqHD
 YihgkfAEIaqb9quXIbYv08kbsgZJd7DFpoFuCZOqJHRevAaee19Gys0J9NQLGJPHaYMv
 PdEl/LmFzNRmorG/QmB00y7vonTxlD3+WLlZp57mw38D8SbAyYxQaS7ttRv/dVnKthfz
 wlIMBozTiKc1G5sqtKAJRFa9EXS6NigsoBl8Sxog1UoBBAgZUv88XkTH2ShAI+0TtJDI
 qX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706632782; x=1707237582;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7MA5MCIW7OXtKya9qDaWW4VnWdbv19urcqqsi2GglzI=;
 b=wHrMHdT+rC0vX1qhqfjDLiV9sg/+eCOW2PopSzuYvaeOuzyPv5fYEs+sW1HPsNFlof
 6oNkPlxixulm8ahQy6qpQ+7J57UexUmLLBlg2PbM7k5GUqOAnm2oYYzP/cNeis3UkG7J
 0UvddsFSiUb3QJ/o6j8atxHLrnCs6BEdIHD9GTc32z/wT73thTz8nWRMQlb2pkg947tL
 MqyZoCg8NBCVKeXbhw5+tY043M6Aq4rQR9tjEBgtFiHp4ikOmM0ShVSZZwEQNUj4QXPn
 yK5tC33Jau7gfOrp87B1AsNvzjpPiNuQAseAY/Rpjqk/9PiIMCHxyQO3PE9ddRGyjErF
 1XbA==
X-Gm-Message-State: AOJu0YwnlrLIAlJDMij5kK4fcLGxoALUkMY+goZqIDJag29X1QsL43zj
 Ga7gbJGomswQy7eC8ArNBnLacSKhXPuNNBTZdD1kaxBQRrmcVTaC
X-Google-Smtp-Source: AGHT+IFElWjax7jCPPZ+XFYgwGxQuIXTnrXEYx342tMSKwBpYk6/uI/RThp9gIYG75D+C1IPuGg/0w==
X-Received: by 2002:a17:90a:5081:b0:290:108:3d8e with SMTP id
 s1-20020a17090a508100b0029001083d8emr6139344pjh.1.1706632782145; 
 Tue, 30 Jan 2024 08:39:42 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 r15-20020a17090ad40f00b00290ae3bf8d1sm8563239pju.57.2024.01.30.08.39.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jan 2024 08:39:41 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: <bpf@ietf.org>,
	"'bpf'" <bpf@vger.kernel.org>
Cc: "'Jose E. Marchesi'" <jose.marchesi@oracle.com>,
 "'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>,
 "'Yonghong Song'" <yonghong.song@linux.dev>
References: <006601da5151$a22b2bb0$e6818310$@gmail.com>
 <877cjutxe9.fsf@oracle.com> <8734uitx3m.fsf@oracle.com>
 <01e601da51b7$92c4ffa0$b84efee0$@gmail.com>
 <CAADnVQK8JegsSxgbQbO=DR71cRgkvN-y9LH_ZQYxmj1a-hCz5g@mail.gmail.com>
 <071b01da5394$260dba30$72292e90$@gmail.com>
In-Reply-To: <071b01da5394$260dba30$72292e90$@gmail.com>
Date: Tue, 30 Jan 2024 08:39:39 -0800
Message-ID: <073001da539a$ec1e2b00$c45a8100$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQI/mTVZUZpeNhzShIl9oGl01BkM9QGkD3DnAsdGbroCN+NFGgGJMAgqAYfmIS+v2lq0oA==
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/5jFsmJfOwREkveSfiYo4OCQZX6k>
Subject: Re: [Bpf] ISA: BPF_MSH and deprecated packet access instructions
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

> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> [...]
> > > Although the Linux verifier doesn't support them, the fact that gcc
> > > does support them tells me that it's probably safest to list the DW
> > > and LDX variants as deprecated as well, which is what the draft
> > > already did in the appendix so that's good (nothing to change there,
> > > I think).
> >
> > DW never existed in classic bpf, so abs/ind never had DW flavor.
> > If some assembler/compiler decided to "support" them it's on them.
> > The standard must not list such things as deprecated. They never
> > existed. So nothing is deprecated.
> 
> Ack, I will remove the ABS/IND + DW lines from the appendix.
> 
> > Same with MSH. BPF_LDX | BPF_MSH | BPF_B is the only insn ever existed.
> > It's a legacy insn. Just like abs/ind.
> 
> Should it be listed in the legacy conformance group then?
> 
> Currently it's not mentioned in instruction-set.rst at all, so the opcode is
> available to use by any new instruction.  If we do list it in instruction-set.rst
> then, like abs/ind, it will be avoided by anyone proposing new instructions.

Here's my understanding of this thread so far:

* (IND/ABS) | (W/H/B) | LD : these are accepted by the Linux verifier and are supported
   by clang and gcc.  They should be in the legacy conformance group of deprecated
   instructions.

* (IND/ABS) | DW | (LD/LDX) : these are not accepted by the Linux verifier and were
   never used.  Clang doesn't generate them but gcc did which is now removed
   based on this discussion.  They should NOT be in the legacy conformance group of
   deprecated instructions because they were never defined in the first place, and
   instruction-set.rst should be updated to clarify this.

* (IND/ABS) | (W/H/B) | LDX : these are not accepted by the Linux verifier and were 
   never used.  Clang doesn't generate them but gcc does. They should NOT 
   be in the legacy conformance group of deprecated instructions because they were
   never defined in the first place, and instruction-set.rst should be updated to clarify this.

* (IND/ABS) | (W/H/B/DW) | (ST/STX): these are not accepted by the Linux verifier and were 
   never used.  I don't know whether clang or gcc generates them.  They should NOT 
   be in the legacy conformance group of deprecated instructions because they were
   never defined in the first place, and instruction-set.rst should be updated to clarify this.

* MSH | B | LDX: this existed in classic BPF but does not exist in (e)BPF since it is not accepted
   by the Linux verifier.  I don't know whether clang ever generated them, but gcc never did.
   The "Legacy BPF Packet access instructions" section of instruction-set.rst says
   > BPF previously introduced special instructions for access to packet data that were carried
   > over from classic BPF. However, these instructions are deprecated and should no longer be used.
   I read Alexei's comment "It's a legacy insn. Just like abs/ind" as a possible argument that MSH|B|LDX
   should be mentioned in instruction-set.rst, pointing to the above section, like IND/ABS do.
   But Yonghong argued that it was never accepted by the verifier, so need not be mentioned.

* MSH | (W/H/DW) | (LD/ST/STX): These are not accepted by the Linux verifier and were 
   never used.  They should NOT be in the legacy conformance group of deprecated instructions
   because they were never defined in the first place.

Let me know if any of the above is incorrect and I can submit a doc patch.

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

