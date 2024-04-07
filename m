Return-Path: <bpf+bounces-26110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2484B89AEF8
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 08:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3201F22E3C
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 06:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5810D7489;
	Sun,  7 Apr 2024 06:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvXfnVl5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421046FC7
	for <bpf@vger.kernel.org>; Sun,  7 Apr 2024 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712473078; cv=none; b=H0qU4XU+b2yRmFERxA+ZWlf7NI2fZV1W7mg4EdMDfQMmZISCoedJhT0GFtNAjKYNPZIng4v0E/Au2E1zTo4XpW42BpDdZ4Hlhd9Y10QtUUPjXo8XWZgi1Ir2PGnUank9rhst+r6kvInrqmpjTe9nz1ears3oZBRI+zwCkXcSNCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712473078; c=relaxed/simple;
	bh=P+Y1iz9E2i7jn5JGIZ+zgrpFp5I1c5NBdDKDLhhdl1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEk5Q1aR/j1IFEkJCCnLmvA0qkKbekS+3Mn/FxjwQH5lIZaHsD+P61OoDnrIWf3ZJ/I65tFBSwSY6YphlS+eK4rMwofUnp53fS+JO1vmWBgrzx9GW7tYLRy1n/Nvyr0mn/FLMXHvYZhgWuYQ8aWYH+hn+3pz4EWwHEntU8IPszE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvXfnVl5; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d536f6f2so2088595e87.2
        for <bpf@vger.kernel.org>; Sat, 06 Apr 2024 23:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712473075; x=1713077875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbMdnxbiUtVNhOQOVtmEhywxDVYbSNqfcBpNBSCVW1Y=;
        b=VvXfnVl50Wqb+pkVLKC0GD3knqdsaSYoRwk7JO9I4Q9oN03ZbrmB7XMfHEdD7dtHDL
         rVdAmvKNBeGE4XgNrmo+QOO8ywIIBRWa60eYqpKtUqBmjYxsPxRPsV0gswaarMSQTDIx
         apaM9rQvHCSkdVIr+D9Mb5ylNpkaMWMO2MpUFnqoyO1wUvDque9mOwXmhEtqwVADn3Wt
         nLLnv2XiGZ1/qEtAsw/6NBTW6C8izMdd0ffPqbJlBashIhQfpJqmYw9qazUTdCEjPnms
         NwJxxwDIQit9RhIhPuqb3hiVm3V/LBrIhE46xHhmkvvDP35ap7umIJSOszf+o+s5lWqc
         hiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712473075; x=1713077875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbMdnxbiUtVNhOQOVtmEhywxDVYbSNqfcBpNBSCVW1Y=;
        b=KazJ93h+351y3oWA3npmr2AKsxhzfQOt4TMaQu3qXz3Az52Q5FKfq+FyuY1tGvdz6/
         fG72RyXUMBBq1JGZLDgICUVXVQF9g2xRRKs1L3jkdeiO8VDL39udggZPPVagDxMn/t6c
         45uj57EyBKMSIughjq4eO/z1ATi8tHEYIhfVMathh1cEFsz0A9kVXxFahqRofhetWfUr
         TK3/vZop3EfqUIwH96O2kbjJyv3qlRA1UAvQmRJKyajPtdvEtdL1Telij+iO34yY6XYG
         0PPOCIK12JvTITTLzSiRNsVObYjG+30ShUszLY24YinMQzJGmWxzJxRLIz4IlYrP1neh
         Be7w==
X-Forwarded-Encrypted: i=1; AJvYcCUfexpZMuv1avjXSUAeEfvtXwNJN+xOzLFIeJNbFY/WFjAWCRNusSOM517KS5HaJXv3K1yvx2LzH8QwuZCB8+GmkgcG
X-Gm-Message-State: AOJu0YweL/k9KmlZi5fa+a3okTBxObgvOpVhXnxR/iA5j82hevNsAx7v
	QtaTblrOCsC3QgxOxf+iCQZwh3TKvwFCsqOafqzIILAhY74g8AGhW8ZQS0/i4zyHa1YhaE6kaZf
	5ZqjSozlUxO9pjvHOc1V+orhNLiaWe7Lb
X-Google-Smtp-Source: AGHT+IHRKbh1gq9cx1Up4Xd4KeqXF6KfAWPuvKtbSXbTaU82E1ACigNlK2IcjqYnvUtQ3AGAgEAaaY+ygf3t213o8IY=
X-Received: by 2002:a2e:98d9:0:b0:2d6:d351:78ae with SMTP id
 s25-20020a2e98d9000000b002d6d35178aemr4526570ljj.29.1712473075170; Sat, 06
 Apr 2024 23:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0a0f01da8795$5496b250$fdc416f0$@gmail.com> <20240405215044.GC19691@maniforge>
In-Reply-To: <20240405215044.GC19691@maniforge>
From: Watson Ladd <watsonbladd@gmail.com>
Date: Sat, 6 Apr 2024 23:57:43 -0700
Message-ID: <CACsn0cmWzT4-+g0w0-ETC5ZMC1hdW0v-Rh1ZNCG2O23m9YCALQ@mail.gmail.com>
Subject: Re: [Bpf] Follow up on "call helper function by address" terminology
To: David Vernet <void@manifault.com>
Cc: dthaler1968=40googlemail.com@dmarc.ietf.org, bpf@vger.kernel.org, 
	bpf@ietf.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 2:50=E2=80=AFPM David Vernet <void@manifault.com> wr=
ote:
>
> On Fri, Apr 05, 2024 at 01:10:38PM -0700, dthaler1968=3D40googlemail.com@=
dmarc.ietf.org wrote:
> > At IETF 119, we agreed that "by address" should be changed to
> > something else in the ISA.  The term "legacy ID" was used during the
> > discussion but Christoph (if I remember right) pointed out that such
> > IDs are not deprecated per se.  Hence "legacy" may not be the right
> > word since we use that word with legacy packet access instructions
> > that are deprecated. We decided to take further discussion to the
> > list, hence this email.
> >
> > We need some term to distinguish them from BTF IDs, so another
> > alternative might be "non-BTF ID".
>
> Non-BTF ID is fine with me. Any objections?

If something later comes along supplanting BTF it will be the not-BTF
not-non-BTF thing. This is bad. How about untyped identifiers?
>
> Thanks,
> David
> --
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf



--=20
Astra mortemque praestare gradatim

