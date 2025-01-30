Return-Path: <bpf+bounces-50092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A519A22785
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 02:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D462C3A693D
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 01:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7C91119A;
	Thu, 30 Jan 2025 01:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l4RfYCTM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3731E4A9
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 01:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738201390; cv=none; b=FiE/5ra5C54oDlGG275gh6j20sWLQN0Q8+L+nawUM0XIGOLggnu/HaF8x/Dq/owYIuoptoZnpd0gn29OvZGTl90ie1ItAXSVmm4ZMvUgkE5rHHIo2r9LdU1mwQ23FoGSRJhUDus4W8p9MD+sBlqcur9ciEX3yN6xJy6qrcKNCaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738201390; c=relaxed/simple;
	bh=SBrIDrBBtkF/79w3PecySMmiUHoOKHgSqpgs/0y6hNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkS5Wzq4TgFCVMYyw4ZNW7ufyeicyVovfzNiRutRAhqewG4sL2Xn9xvD5WXQQLaXI1mCYlVMH8MG4gKd0ICfmnLqPBTClDU9Da3VrRhAw4ke9ved31B/rL6rslZT0vxiiDI3dak4bSK4qMaTTXp+8dqZ/f9SGLQ6H0dry2U97aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l4RfYCTM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21625b4f978so61135ad.0
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 17:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738201388; x=1738806188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBrIDrBBtkF/79w3PecySMmiUHoOKHgSqpgs/0y6hNE=;
        b=l4RfYCTMU4Ay5ZjNpBwEmc72auFNJDt9x+iR4WQwpPWMZOFG3yR4gZTP4o90YQKER2
         gi35B94vJhvWO9SepDxmWn5OIaYdFSjBrxtU6zLLV8+XRCqIo1eSaEZwOgWcq4EFmyhh
         aijERGNXKUflhCs/MID00jZrqvBgoeAdUc5RfhHjZxi7YLXGvW9Op6DiRjeHyEcvmxBt
         R5rvYxFdeKKCvweBokpeun4FoDqVcbbyD8o+fWZzYGd1ISC7eM2832PzMJdEhcrQ7/D+
         OFMXXihfmWWkiwLT/iqeShHldbko/eJIAp0My9yweYuluQuF6ljijkBTD40GM5h7MpWk
         irVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738201388; x=1738806188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBrIDrBBtkF/79w3PecySMmiUHoOKHgSqpgs/0y6hNE=;
        b=Xbl2ttgSMXx3mVapBd/3QFoIVc9Mk9GWxDoCl0uD/HcHoO4ESJKSjvj338gYfKLwNr
         eTn8De4+q1l37ewMZ/kdO4QlKR5exBrl2F0MVOKcu5hsiA4Zi7uIWF3B/t6vHs9ykhhg
         Y5MYCkDh/1mowa7B+fvio6DEEYBe6zHstUkA1B9UU/ngC36u7PeeswocaeojME/0aerI
         qyXNOznRexbMqCAcCAgBtMZLUMrMKkEclQOOVModQoyJXO7AnnBFj+MePC6Oj4hdBf99
         LJC/90IR/80CRdF324u+ADFwhKYA4QI8VywfNmBNJMu2+Q1AuzHJy8H9vX+qjU9AxXM9
         Bbdg==
X-Forwarded-Encrypted: i=1; AJvYcCU51Oi7QPMEVzoFWWUKZpZbhhI428IstItcIatzU4pwTZlAbJDBGWebtYCl5DDK2aoz4pc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk2sKqLmP0ofF+ITbw8MG/gF1+ZSHmxNnb3PZ2efOSn7JSrQWF
	vVcJMBjzUsY4Paox5bCJAMtiu/gXA9E8k2oV2/gfO+X9NwsIXLXqCgU2YTtOhDck3MUiBC8zJMc
	3ghCXFBo4YxSd9U68dVnx8tvZy6PQ6hoAODah
X-Gm-Gg: ASbGncugAVMOuspJLFfmWU+9A10K/h/ihy9twHJPZQia2unQsY61/Ax+MY678C+RwsS
	4neCYSUZS7XFgsVNXzwXMCyiCm2JGWGgK2hshQVI3VZPt7OeoiGHjdpzHi6uydCqxquxahIPhuY
	oyr1UrQ8UlgiTWS5hCB9g7kK9rGg==
X-Google-Smtp-Source: AGHT+IFF+EXsap9Y27G6hz0CAJByVSDh+P99ewgvmlhQ71vPlZxj38LxmsstN3A/4vUoyv0Jc3jSEymzYndsjg49I9g=
X-Received: by 2002:a17:903:1450:b0:215:79b5:aa7e with SMTP id
 d9443c01a7336-21de3697386mr728395ad.13.1738201386787; Wed, 29 Jan 2025
 17:43:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJj2-QEtASHEfiYuoKrfx7n1UjDS1e+aF0LdYB5vhBUUS3cq8g@mail.gmail.com>
 <20250109114847.539237-1-tianmuyang@huawei.com>
In-Reply-To: <20250109114847.539237-1-tianmuyang@huawei.com>
From: Yuanchu Xie <yuanchu@google.com>
Date: Wed, 29 Jan 2025 17:42:50 -0800
X-Gm-Features: AWEUYZkCm7GZHqoTF_LkSbJKMKMuuvsnPLq00Zdm0WDkQiuhx53xxjCw08WuEgU
Message-ID: <CAJj2-QFH=8=ggYuy9Wb29VKbW+39GxvSPfQ89JXs=5eNYLxfjg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] mm: multi-gen LRU: per-process heatmaps
To: Muyang Tian <tianmuyang@huawei.com>
Cc: Michael@michaellarabel.com, akpm@linux-foundation.org, bpf@vger.kernel.org, 
	corbet@lwn.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	liuxin350@huawei.com, liwei883@huawei.com, wuchangye@huawei.com, 
	xiesongyang@huawei.com, yanan@huawei.com, yuzhao@google.com, 
	zhangmingyi5@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 3:48=E2=80=AFAM Muyang Tian <tianmuyang@huawei.com> =
wrote:
>
> Hi Yuanchu,
>
> I'm working on observability and the programmable page generation policy =
of MGLRU based on eBPF, using a similar approach to yours.
> I'd like to know if there is any related work, such as the application of=
 eBPF in MGLRU?
Not that I'm aware of. There were some patches fiddling with the
generation placement of pages but I can't seem to find them.

> Also, this RFC provides a user space interface to call run_aging(), which=
 is called periodically in the demo.
> Do you plan to optimize this, perhaps by calling run_aging() based on pag=
e access observation results?
Right now I don't have any plans to optimize this patch series. What
are your use cases? All I cared about was one off observability of
accesses and not much thought went into optimizing the tool.

Thanks,
Yuanchu

