Return-Path: <bpf+bounces-66577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EE0B370CD
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 18:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0175C1BA1728
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 16:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237D62D7391;
	Tue, 26 Aug 2025 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7q+On61"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0BA2D4B44
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227565; cv=none; b=PCNmFvvb0zhOcPtXbBIMeqKkkk+SHsIZwgWcaq1vaP4Ev/CEjeFxz/g8mIwtwtR1Evamapn0bM039UR7d0IJfPI3/S/HZQ3hHwJksZnmwjC8U7HwIn66hPpFYFRnLEhnW7v/5p87cLc8w37VjtL/Hjq7sKQBvjdD2Ht9Y2vKYWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227565; c=relaxed/simple;
	bh=lXwDNiqs/CAP44QVr1WvQvVJ5D0DECSIhICrw0TrJwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQecRztF++oI5k7nAoq1Vhe4Bc16w6Kau4TrxrHeepKhXZxbNwEWj6kiIXti07kn4bjcuTacK8FuSy7yCAKOBYPz6ZELJWHbFwEWQfEobj0G/oBvFWdkiSGP2a4bjswbrKXuhtZARWREsuX8MoAlV8nPCmKTYam06Vvf7UoHJP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7q+On61; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-53b09bdcb73so67088e0c.1
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 09:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756227563; x=1756832363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXwDNiqs/CAP44QVr1WvQvVJ5D0DECSIhICrw0TrJwM=;
        b=j7q+On61YgWYmBTxLWRVdYJ4k60PDX7BuP8QJg/9gKFF4SmY1RfA12LRuh2ikw9RPb
         hOfp9hJcc8lfQEMSZqTZSrj/tVBGIxBFDwdFcANoedZpvBIy7NS2UMiVrvNk29eJPqgb
         rZg+0ulCKIP5uhkuYXHDj4yY1oqJxOUBZRnpG9yEMot4O/1Gqpc43+XD82iEQ6KJVi2z
         YGtitZVSVghk8/P695Wd1vpQ5cQBI7oF03VC/kIbunY+waExWNkKRdAegYqjmzRe+FZr
         Zd/JaBE9D7tt+tBRybYhuSXGopVeCRotSaLeGAnSeH+U8mQbS10g7SwkLVDtGvELv9vf
         5taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756227563; x=1756832363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXwDNiqs/CAP44QVr1WvQvVJ5D0DECSIhICrw0TrJwM=;
        b=LqIXeYjHQ2SRoz/S7bu6NhUERy8ade6HuQp+F/zQ7H3v300/Ro4y+q2Mss957fOKTS
         eEJ4bh02WoG05HoXFZY1cD1kplBuWIcF7RgG9v3HfGYSaYl9hGjXBX9K18CPc6NzkLOw
         o9HT8aVjrkhEeyznfvedAVi+SARcksz2k/KMOuKJ2hGfmz0NBi8t6I2u2CwkvD7bLvBu
         jEuLMrM+LwE9B1thAFFaTu2awnnbqzhH6+GP2XMNB1B//+nIO/hbnYfO/J47tJM1W1Ge
         4irzrCkVu2cbJIDAx/NHjYhBewheY2CYxaS9Pn7/mhM2VvBAccfsqXYS32Nk+Pacm9VW
         DqoA==
X-Forwarded-Encrypted: i=1; AJvYcCWqZ5bagh2WPJvwMXu1axhswsZdrgrdLhWS+Zx8V9a0wJJ7l2cyZ3uju03XyvbVOrDG4bE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTRaPCt+fRjoXumrp/tuB4MGiAvWE6q7+PK7mEzQ565Lwe4dS0
	ndRtXTK07UU7OnnHrWexOSdcmzArkuMSI5zTl7ChpFE+N8eiNRGXTKDeH01KasGsVb0S951FP0/
	sCDxiZCEitKXk4EHvWwfakWiurb4PGkU=
X-Gm-Gg: ASbGnctoDEvT5EHSzI18Yp2laDFMrMP0wc+k6K5O/wHPliLttYFQMBP+nXphtojvoqm
	xtwgdoIF5acNXDTjeScHwXci1XM/QE3kmQbVR67A6f/9WRs/w02dMYRp/lYLFFZbQP2/+dgHbzp
	6e9ISEfMMzomL/tZcaqktKILhHEB4v3CLY4btYfkFPZJ+CJEdRhkFL4vWNWidnkezo5F8aSyWm9
	TlsscUMMQF4ArRdfWkGmNnXvGbHOiW3zQ2jXjNN/mo5mXzFEvV6
X-Google-Smtp-Source: AGHT+IHDgc8tlLnNMMh54rgdMszS7L0GVNg9irJLhLFwACwL5dbI20ZUb6g3l8dALHlzpfh25NPs+5gibpewmN2EwJA=
X-Received: by 2002:a05:6122:6b13:b0:539:237c:f95d with SMTP id
 71dfb90a1353d-5438f49289amr877724e0c.0.1756227562833; Tue, 26 Aug 2025
 09:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826034524.2159515-1-nandakumar@nandakumar.co.in> <f868340c-eb9a-4757-9ddf-ae08899bb263@iogearbox.net>
In-Reply-To: <f868340c-eb9a-4757-9ddf-ae08899bb263@iogearbox.net>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Tue, 26 Aug 2025 12:59:11 -0400
X-Gm-Features: Ac12FXzia8vP6DQNE3ES0JTwQszfx3-bRQhHpbHXrSUoPNUOvOBdsxuk6C6PHY8
Message-ID: <CAM=Ch04Rh1K1GeWvy8i+Lh76GGMdgS3Drk=5FuOEBP2ym7yqgA@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 1/2] bpf: Improve the general precision of tnum_mul
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Nandakumar Edamana <nandakumar@nandakumar.co.in>, alexei.starovoitov@gmail.com, 
	Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 7:33=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 8/26/25 5:45 AM, Nandakumar Edamana wrote:
> > Drop the value-mask decomposition technique and adopt straightforward
> > long-multiplication with a twist: when LSB(a) is uncertain, find the
> > two partial products (for LSB(a) =3D known 0 and LSB(a) =3D known 1) an=
d
> > take a union.
> >
> > Experiment shows that applying this technique in long multiplication
> > improves the precision in a significant number of cases (at the cost
> > of losing precision in a relatively lower number of cases).
> >
> > Signed-off-by: Nandakumar Edamana <nandakumar@nandakumar.co.in>
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > Reviewed-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.c=
om>
>
> Hari, are you okay if we also add a ...
>
> Tested-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com> =
# Agni
>
> ... to indicate in the commit log that you also ran the code through Agni=
?
>
> Thanks,
> Daniel

Yes sure Daniel, I'm okay with adding the Tested-by.

Just to clarify: since tnum_mul has a loop, I didn't run this directly thro=
ugh
Agni, as Agni doesn't yet support loops. I tested this in Z3 via a
manual conversion
to logic by unrolling the loop for a limited bound.

Best,
Hari

