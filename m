Return-Path: <bpf+bounces-76804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BB0CC5D1E
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 03:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 359EF304FFD4
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 02:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3417C278161;
	Wed, 17 Dec 2025 02:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9bSVAN6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3914185955
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 02:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765939733; cv=none; b=dgeCOkkSReBcvkhZq5YBi+ez9D5gwCdLsBXglwraowjsCPMIHZ9xVsdQHdzBSh6wjg3GSmIUSILHKucO/AutSoKw2G3LVv7hhU81AagNaiu/JO9x6hPtfI06uqWZthHlbd4rYX0JxdJs2hmlKWdnanBQfU+JcVqgbnJJFQJ6+Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765939733; c=relaxed/simple;
	bh=obxRK1Y+7INS6FPNbsDkzAtG/dLy/RRFFHp3+NZlpnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pqU3QxzJqon3WHeIh6YRv8l1aVlnpfU1pLqGTvnDAAtyst3/gY+6BFufEfw+Z/nCCpH6fvhF+ePbr8vRSIzH3quOuTLhXHc0rI8vLNiPmyDEWkrTtfyo0dxnoMOk2aVv0fKjUAuTePNW/xWZdofZ5ukSHzCcdZwGZ2lMQNaLc6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9bSVAN6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-430f9ffd4e8so48940f8f.0
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 18:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765939730; x=1766544530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obxRK1Y+7INS6FPNbsDkzAtG/dLy/RRFFHp3+NZlpnE=;
        b=U9bSVAN6LJYymXnkvOkKdaN42xOCTKcN/WFGnz8utSfMyI8IDSW8T0BWVtQ2R2oBfU
         NEc1Fa62cVi8qOaltsZcLLxNXWdHsSkKcpPryH6Bsd1IY4yuGtjVU5bkjGMGRa4Rx5Zl
         OZMYFiW8fZUBWUS9nhhPqVRCpDFgggSQ3vPCCofBIIlqPgd4OjwWgDLd2Vp2/V6sL90E
         AH2HJk6Fu1FeL3PimmmYpJeGbQzQcru9IgRp4CtIooy09mlJm0rF+frmMF5OS+MD7Ms4
         8k/sqZAFr6UdqKl+BIB/FJoZirwatNuuSAZXhL0ptvGspSLzW01qGgTzwJc+xMQFfoAo
         nXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765939730; x=1766544530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=obxRK1Y+7INS6FPNbsDkzAtG/dLy/RRFFHp3+NZlpnE=;
        b=M78a0k/XpawEFFbsjPR0LNj2xj068nbcpx8VC77WtTErcVcb2zDkp2LKJ2za8x6XLY
         zoxB4ecqfYJhNokPai2yXaVCwq21Qt6BuYy1N49+6wGBPDhclItEzGnpZVAT4K+l+L5Q
         1zTUMr75hXmNLWTjYPo1wgjM0pKrPPwALq9s32WMyS+sknEIQx248CqvRpSeX0FHzg2g
         dE5YHBQCHLnsuHwYdi07MLEJQlRxTy2lib3NJ6l4GsstmPZsDp5zvWDurVH8uirt4k+u
         W/Lj7QxoRCOTRTFXmAoAaf+VGPXlt1UyJchFKlVnJ8atyu2TRxxxQLGntwXKJ8AuQsIh
         fG/w==
X-Forwarded-Encrypted: i=1; AJvYcCWl8HE3wA9FxwtCQDQrjJfq+1miAM2jB/a+oSmBQwUneeqzL5WMCYYrNz8wSmwcLFFOkmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlGw9iYoPjbOxmvzoK7U+r6y++4B43mvy5196HkRYJhbuuKL3k
	0pTqytw5xnOO9zXzv5TW1nEz0yxfYSl4WhQrlplHNMxqV3pDCiyxMd7kGzPZ8atYe7L8sdk9qF7
	HpsljV5ivnMBMY6TQc+EWUYYbjKa5LjziWw==
X-Gm-Gg: AY/fxX73j/4y9hmHw/MzQKl8V12ptIUy0v7cLvdtMV8mH0O9J+2vPkrcqOji8dUEOGZ
	CoADuu6ZZKOxaCZAJbthcnB81n/AnmPMCg+7pY8wHdQNMjatD6ripnR6bLZyOSrn4lZasCL6LUj
	L7Nkd1nK4wOsrP67B7NaZ6woXN3eDvENfMQJHhLbLA4qIhYgoJWmR7EhLCna1OgMlZwUbuOPdE3
	smQql6150fzzkQ+vn3Ok4Idt9Ml8vSreSGQ1heZjuCAPvtrr0i+wVogBUzA4ce6OCG0V1kmmhkT
	a5+j153Lk8RbyuOUxwJKO8WmcG1z
X-Google-Smtp-Source: AGHT+IGFEM20aK50iOTLl2MJq3XjJKOmKE+tzKPwnlj0ja1ORC3N17E+PB+g9+oAiKMphgX0KzjNlU4AmpWV9JkCRhc=
X-Received: by 2002:a5d:5704:0:b0:42f:f627:3a88 with SMTP id
 ffacd0b85a97d-42ff6273cd7mr12243819f8f.4.1765939730011; Tue, 16 Dec 2025
 18:48:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO3QcbiQqPpnCQFPcJYFf1O+-vJR9rUTHKdYwJJ+BMhviXKgFQ@mail.gmail.com>
In-Reply-To: <CAO3QcbiQqPpnCQFPcJYFf1O+-vJR9rUTHKdYwJJ+BMhviXKgFQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 Dec 2025 18:48:38 -0800
X-Gm-Features: AQt7F2r5pXqb9k8FvIaYQqAHWtU0ig_1gnEiPyWymvQ5qwWp8A4TptR4RlDHZKE
Message-ID: <CAADnVQL=NAHK5oXfy5-3xG+s_ZUTdzVcJy+KUYDJKx9yNmLpXQ@mail.gmail.com>
Subject: Re: [RFC] Rust implementation of BPF verifier
To: cb m <mcb2720838051@gmail.com>
Cc: rust-for-linux <rust-for-linux@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 9:37=E2=80=AFAM cb m <mcb2720838051@gmail.com> wrot=
e:
>
> If it would not be too much trouble, I would be very grateful if
> you could share any specific concerns or reasons behind your
> decision.

Just because rust is no longer experimental it doesn't mean
that it's a good idea to rewrite pieces of the kernel in rust.
Whether it's a small piece or big. The verifier or anything else.
binder was written, because its C implementation was effectively
unmaintained, but the component itself was mandatory.
Meaning rewriting some obsolete and unmaintained component
in rust is not a good idea.
Rewriting a well maintained component in rust is equivally bad idea.
Rewrite fits only for unmaintained, but necessary.
Or plain new code where it makes sense.

