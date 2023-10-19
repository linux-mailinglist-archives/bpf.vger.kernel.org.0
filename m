Return-Path: <bpf+bounces-12628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15C27CEC8B
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 02:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4880CB20F1E
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 00:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EC0EB8;
	Thu, 19 Oct 2023 00:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="tjc+DhGM";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ulRlRFB1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwUEA570"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EBF17E
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 00:02:43 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663B8121
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 17:02:41 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 1E68AC1516F8
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 17:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1697673761; bh=TUT04STch1v7PD9QaEd/a8bF+XBzMxCXpo3YNHVCmng=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=tjc+DhGMbYeNOvI2KsN926f1GTBtBO/tZU4czWuFNGYHchE5ZM45r5O5jPshk5gjk
	 4uUEXpP2/+1/k71N757k7ZtY77FtL5FeEAzBHw8lPba+VDgg03sFOB33lfIlGvhlBX
	 c3htBDnT8YH8NQFiQceUuWkvF3wuMN1MwnFjyP3U=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Oct 18 17:02:41 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id E57E6C151067;
	Wed, 18 Oct 2023 17:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1697673760; bh=TUT04STch1v7PD9QaEd/a8bF+XBzMxCXpo3YNHVCmng=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=ulRlRFB14EC817e9HwgGeVBJ/ACdHt8nayiP5jTpwS/0xP8myRKJHfAhZ2sI4K8NT
	 yhIFhf8HB8ZW197saw4/mH7RhYZg9FNxkMpzGZ9HifZVGgTGySCYPPnSV1DxlU9lLw
	 AAV8Aa0Te3JiGKk+/V/esl0wpvOPtSGNqZ9FQKj4=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id CFAE6C14CE4A
 for <bpf@ietfa.amsl.com>; Wed, 18 Oct 2023 17:00:33 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sI8Ae-TCmtRC for <bpf@ietfa.amsl.com>;
 Wed, 18 Oct 2023 17:00:29 -0700 (PDT)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 46656C151067
 for <bpf@ietf.org>; Wed, 18 Oct 2023 17:00:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-53db3811d8fso482986a12.1
 for <bpf@ietf.org>; Wed, 18 Oct 2023 17:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697673627; x=1698278427; darn=ietf.org;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=c08Scj2xXGChcdKkX8dYJ98/oNBmdDjcnPAtJLMx7mU=;
 b=fwUEA570FXtim2FhFegOtcKr8wVUk5mrq8yr0Ix05oWOgLizeAdroMF9S9Z2vuQb0q
 ZWtkFRXURQY9zd6BBvUAOgOGmXrwlsReeAU6re6X/rcfLQ9ckffZ4s9cwkgflykG7v5B
 FVP0VFEEfeGNBUeVasgSXC+R0yOXvj0k+sMCyWDzN6XGprXf3SBmCW25c6pgAQPTHiSt
 8uArstRFKD7w7Rn0D+RssKyrGav+kK2HjlqRObYOv8oHGjYGnZgeInuBTAJvuksE96NB
 H2bRbmToW9gs0YlxbQ43l4Bz1+8nd9AcOzoWjq3UIQZPJUF7ByAoEBtbrA1IZ5PDNVoU
 w7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697673627; x=1698278427;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c08Scj2xXGChcdKkX8dYJ98/oNBmdDjcnPAtJLMx7mU=;
 b=bgrQ/TNj8uqf3DbAEB1i26Vn27g+/uIYmKhg+7d4m+PxuXFrRoD8TkokcNzDhYeVMC
 YrUWkjhebwCALE6E1EDdzubR2RRdw85LpFt0ZS8KTRLzjOEMhDZFq/CD4D0Ef7hOgmjf
 H2JB/zL3Qwyn13XRrdu6JTRImQJUuw14oD9FtclSq8G3cB7U0Z6SDFBgyCfwZwLfYpi2
 ORniZFmccaMoYy+qVy6u5HNcYZ6AnAtjEayzHtW8fCoiPoyHawEsfpyBgcFL/oxuRuyU
 S5jYT3LfkdvlI1VSLGEu3gKEitZbgO0oSKawmSrFR1W5CiY/r6kxXNYZeZp1Ixmw5+u8
 gElw==
X-Gm-Message-State: AOJu0YwgfXSWQ1fgL+WrRgHA6j9AiOkAyRHmz0jlAWhUg5E5aYDqBZiN
 JHi6ssEykKYMwC1rbUXii98=
X-Google-Smtp-Source: AGHT+IHvWtBH8BCkj5CtwGPMJvS2IY6R5NhZh5FeNQLJdo4RIEOB8iRbG+tOlJKAOsX48cbzzwfSLQ==
X-Received: by 2002:aa7:c589:0:b0:530:cc8c:9e41 with SMTP id
 g9-20020aa7c589000000b00530cc8c9e41mr279045edq.19.1697673627348; 
 Wed, 18 Oct 2023 17:00:27 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua.
 [176.36.0.241]) by smtp.gmail.com with ESMTPSA id
 a93-20020a509ee6000000b00536159c6c45sm3524198edf.15.2023.10.18.17.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 17:00:26 -0700 (PDT)
Message-ID: <e51603c98e2abe061b75fe8ac9854b1678a64aef.camel@gmail.com>
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Dave Thaler
 <dthaler1968@googlemail.com>, bpf@vger.kernel.org
Cc: bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Date: Thu, 19 Oct 2023 03:00:26 +0300
In-Reply-To: <e2943b75-e47a-01f2-6b3f-a3ce666008cd@iogearbox.net>
References: <20231017203020.1500-1-dthaler1968@googlemail.com>
 <d1a0907588e9d809aebba260377b6188897bd383.camel@gmail.com>
 <e2943b75-e47a-01f2-6b3f-a3ce666008cd@iogearbox.net>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual;
 keydata=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
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/GOYvOjrSofy8wjvqaiodpnmCjc4>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Define signed modulo as using truncated division
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>

On Thu, 2023-10-19 at 01:40 +0200, Daniel Borkmann wrote:
> On 10/19/23 12:34 AM, Eduard Zingerman wrote:
> > On Tue, 2023-10-17 at 20:30 +0000, Dave Thaler wrote:
> > > From: Dave Thaler <dthaler@microsoft.com>
> > > 
> > > There's different mathematical definitions (truncated, floored,
> > > rounded, etc.) and different languages have chosen different
> > > definitions [0][1].  E.g., languages/libraries that follow Knuth
> > > use a different mathematical definition than C uses.  This
> > > patch specifies which definition BPF uses, as verified by
> > > Eduard [2] and others.
> > > 
> > > [0]: https://en.wikipedia.org/wiki/Modulo#Variants_of_the_definition
> > > [1]: https://torstencurdt.com/tech/posts/modulo-of-negative-numbers/
> > > [2]: https://lore.kernel.org/bpf/57e6fefadaf3b2995bb259fa8e711c7220ce5290.camel@gmail.com/
> > > 
> > > Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> > > ---
> > >   Documentation/bpf/standardization/instruction-set.rst | 8 ++++++++
> > >   1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
> > > index c5d53a6e8c7..245b6defc29 100644
> > > --- a/Documentation/bpf/standardization/instruction-set.rst
> > > +++ b/Documentation/bpf/standardization/instruction-set.rst
> > > @@ -283,6 +283,14 @@ For signed operations (``BPF_SDIV`` and ``BPF_SMOD``), for ``BPF_ALU``,
> > >   is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and then
> > >   interpreted as a 64-bit signed value.
> > >   
> > > +Note that there are varying definitions of the signed modulo operation
> > > +when the dividend or divisor are negative, where implementations often
> > > +vary by language such that Python, Ruby, etc.  differ from C, Go, Java,
> > > +etc. This specification requires that signed modulo use truncated division
> > > +(where -13 % 3 == -1) as implemented in C, Go, etc.:
> > > +
> > > +   a % n = a - n * trunc(a / n)
> > > +
> > >   The ``BPF_MOVSX`` instruction does a move operation with sign extension.
> > >   ``BPF_ALU | BPF_MOVSX`` :term:`sign extends<Sign Extend>` 8-bit and 16-bit operands into 32
> > >   bit operands, and zeroes the remaining upper 32 bits.
> > 
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> Eduard, do we have some test cases in BPF CI around this specifically (e.g. via test_verifier)?
> Might be worth adding if not.

We do, e.g. see tools/testing/selftests/bpf/progs/verifier_sdiv.c:

  SEC("socket")
  __description("SMOD32, non-zero imm divisor, check 1")
  __success __success_unpriv __retval(-1)
  __naked void smod32_non_zero_imm_1(void)
  {
  	asm volatile ("					\
  	w0 = -41;					\
  	w0 s%%= 2;					\
  	exit;						\
  "	::: __clobber_all);
  }
  
And I'm still surprised that this produces different results in C and
in Python :)

  $ python3
  Python 3.11.5 (main, Aug 31 2023, 07:57:41) [GCC] on linux
  Type "help", "copyright", "credits" or "license" for more information.
  >>> -41 % 2
  1
  $ clang-repl
  clang-repl> #include <stdio.h>
  clang-repl> printf("%d\n", -41 % 2);
  -1

There are several such tests with different combination of signs,
both 32-bit and 64-bit.

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

