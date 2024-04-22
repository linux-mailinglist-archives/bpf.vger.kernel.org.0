Return-Path: <bpf+bounces-27472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 512EB8AD5BD
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 22:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA581C20C29
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 20:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A9F1553AE;
	Mon, 22 Apr 2024 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="nVxzKO10";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="aivHbXJ4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SjSxmIyR"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33B415380B
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713817098; cv=none; b=L6SN7KMKDoOqUG0BFjZzV5ivfeSFXXz9UwaZxzKunQsLRSGrfeD7YQqrwmW4d3fUY5qqWquMwEbTAMxfhD8Ilg5xYJLjQJ1vHbllbEy052VU8Eii9iSqGOOME1VB4PlT4cumxKVYwxkMu14y4ASc8inYpR2iRGzJW1TVUkahMzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713817098; c=relaxed/simple;
	bh=IbnZ99b8RZ12LGJA+lySzc/cLOD3Dt8WwSbjqqAhdZE=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=YUiQ0gBno3ROSfzu+zUn3YjMvesZcfBoFIgXTwgAAztqKfR+Jt3+5thz9wRRpToUwkzQ47pXk44w/5z8ZhL9pVds18Wt6DAJHze+VlyDyitw9HdFFZNYXfx/tmvkvQm1UpOTx7x1+pyEgNyhGyT+RKZg59JglqMK7jfpWfHu8WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=nVxzKO10; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=aivHbXJ4 reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SjSxmIyR reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 23E6CC1D4CC6
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 13:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713817096; bh=IbnZ99b8RZ12LGJA+lySzc/cLOD3Dt8WwSbjqqAhdZE=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nVxzKO10F+8VFJ85CwCjWEXQauX5pY5bZ2kD5a3qD8CuYliBzlHNA2hDRa3BJQR82
	 Fh4BErzJ5M44XTeeiNGDMw1VYuFYxVzar2dKmBRPigfbcxCNVD5MkulXQYi8p19aEF
	 CFyOfX43cROTktEoByW60+RVqnkrFMWsBXqvz+tU=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id DE135C1840FD;
 Mon, 22 Apr 2024 13:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1713817095; bh=IbnZ99b8RZ12LGJA+lySzc/cLOD3Dt8WwSbjqqAhdZE=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=aivHbXJ4F11ljNxc/VMMGQ5/gKBj3kx2I2TcBXKuuA3KLJxTprjHwHna33XYQtDdX
 gQIvu7zCeKE2bZBNPBIASpmLRzz6l89IgUZTeH9wuATJ8Oxpri9BN1mON8gYcQwFgA
 vzxRgHma0asOSovKst60LSNUg5Sj3FPy8AQeKAx0=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 83CABC1840FD
 for <bpf@ietfa.amsl.com>; Mon, 22 Apr 2024 13:18:14 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.845
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ck8_6SeG-AJZ for <bpf@ietfa.amsl.com>;
 Mon, 22 Apr 2024 13:18:10 -0700 (PDT)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 7237BC14F5E9
 for <bpf@ietf.org>; Mon, 22 Apr 2024 13:18:10 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f0b9f943cbso3110656b3a.0
 for <bpf@ietf.org>; Mon, 22 Apr 2024 13:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1713817089; x=1714421889; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PUz55Nl17oll69+3WiaJPfCOIWt9awPUEg5ZbqEmiT0=;
 b=SjSxmIyRFxZe2yPyBm6ljk7uERrPO+N5KX5lqj7UHr1X/8MwtiGqcGBOrtuM6QkrKn
 XQyyrPTcqQoMVp3gkfvbQbXb0EHdn6s+0CZD96fk8sKjVGfWzkfAh6iC7V5VbcVuSwFn
 eaNdFZudbd/d7gIjwaJ7LGy1cHGABBAaRT0iF4nu40MJ5T5MN1Ak2nh74PCLFlJ98EFw
 +2doRZCG8OGtvnmwMpDT07JPe7cF/Nhl4aty7EqvL3LboLnwwgRs8E6WE6v/df5zy9Hi
 Z2Q16Pd3lDNn+eHQn2IvM94UkzvEFWQ+Kg2S1CbszdMp+V3A3qfMn0EiFp+qwdxd8Cmj
 oLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713817089; x=1714421889;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PUz55Nl17oll69+3WiaJPfCOIWt9awPUEg5ZbqEmiT0=;
 b=L1ShkTXvHxRB/UeFSI1Od0q6f+qrrZZ7FsdI7U6oJtU9baFZzayjs058tFdfq1aMEf
 e+VTUfj+kMp4obe+6kH8zyCJ0Z1Ut9JYcTpkZ0MX5TgEKyZGUqaRXZQlovyCW93lsdL6
 YedKwUjdl2KT7+Ix+I2+SblWOH7GOhyLKrEGJxRtAGFchx713QsE5XB2+97k3Ma1JW79
 6sl7kiLQ0gsCPEILTlR727WCNM/nmrs1k6H/uLzdshLO5NbxjptT+LVEv8R+dySgAB/a
 VCAkisra6tLNo0sAb2vK4dMcPBgjVrw+I6uHc0R6XB3OJ0kICU4A3Ch0xbDe+ZEGcki0
 lPLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsDEbVX8CQ9AObJdDIWgTiTJxvudZnMh9/r83jBWX2IWPNe3xtP8L8oHvacIvROncSnTuaB78gUg/MdLk=
X-Gm-Message-State: AOJu0YyT1GlcZxQkEqUFG6347yzJMJmAkKlgl1TsriXXghLMlNDMRw6a
 NPoGKN7rRu3/EM/sIPk+zl+xQre568B+J77V8X1ZiqvFYUWXO+I2IUdXPHrJ
X-Google-Smtp-Source: AGHT+IFNaB/pP2VBDqo9sZ3DuOnugU0crvxKt0zQBpTCpa6JnGQyFKzekv5q1BK5IOYUr9lRKR0Kpg==
X-Received: by 2002:a05:6a00:a1a:b0:6e8:f708:4b09 with SMTP id
 p26-20020a056a000a1a00b006e8f7084b09mr12704243pfh.15.1713817089260; 
 Mon, 22 Apr 2024 13:18:09 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 s23-20020a62e717000000b006ed045e3a70sm8235196pfh.25.2024.04.22.13.18.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Apr 2024 13:18:08 -0700 (PDT)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'David Vernet'" <void@manifault.com>
Cc: <bpf@vger.kernel.org>,
	<bpf@ietf.org>
References: <20240422190942.24658-1-dthaler1968@gmail.com>
 <20240422193847.GB18561@maniforge>
In-Reply-To: <20240422193847.GB18561@maniforge>
Date: Mon, 22 Apr 2024 13:18:05 -0700
Message-ID: <15c701da94f2$30a7c9f0$91f75dd0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJca10vmlzuYWeV1F8aiImCH38lawJ77JCTsF0twfA=
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/ngrJOCqbgy59odW-NKKL1rP3U40>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Add introduction for use in the ISA Internet Draft
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
> On Mon, Apr 22, 2024 at 12:09:42PM -0700, Dave Thaler wrote:
> > The proposed intro paragraph text is derived from the first paragraph
> > of the IETF BPF WG charter at
> > https://datatracker.ietf.org/wg/bpf/about/
> >
> > Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
> > ---
> >  Documentation/bpf/standardization/instruction-set.rst | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/bpf/standardization/instruction-set.rst
> > b/Documentation/bpf/standardization/instruction-set.rst
> > index d03d90afb..b44bdacd0 100644
> > --- a/Documentation/bpf/standardization/instruction-set.rst
> > +++ b/Documentation/bpf/standardization/instruction-set.rst
> > @@ -5,7 +5,11 @@
> >  BPF Instruction Set Architecture (ISA)
> > ======================================
> >
> > -This document specifies the BPF instruction set architecture (ISA).
> > +eBPF (which is no longer an acronym for anything), also commonly
> > +referred to as BPF, is a technology with origins in the Linux kernel
> > +that can run untrusted programs in a privileged context such as an
> 
> Perhaps this should be phrased as:
> 
> ...that can run untrusted programs in privileged contexts such as the
operating
> system kernel.
> 
> Not sure if that's actually a grammar correction but it sounds more
correct in my
> head. Wdyt?

That sounds less grammatically correct to my reading, since "contexts" would
be plural but "kernel" is singular.   The intent of the original sentence
was that
multiple programs (plural) can run in the same privileged context (singular)
such
as a kernel (singular).

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

