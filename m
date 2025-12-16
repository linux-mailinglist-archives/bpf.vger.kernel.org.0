Return-Path: <bpf+bounces-76656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA27CC07AE
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 02:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5CCA3021064
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 01:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670A627CB04;
	Tue, 16 Dec 2025 01:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDLQX6v8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C2F27FD5D
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 01:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765849381; cv=none; b=ZCJWXiF4KurHvD48JSIGtmmrzRgAur5eIdvuRCI6zcCfN4NBXOXSE1oMPtKEgtvS1SQA3ZqncLOfi8SI5w1dZoanlAkt5kCH6muyZw2RkkZKi3UQzCmX11x3+tRC8Rk+46HEbxtQ/w1tvSONInbch5wlipTnQ3HaMEIxpeKzkc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765849381; c=relaxed/simple;
	bh=ZyiAfBS1SHi1ogYvB6RKd2TbkiFPHcyLTNoNsrXdb6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCdColczH7ASep25P4ceqB3H/SRCzGcZGmWJT5aph3x0WEjr6XwMryTWoBuNEM0dntWuwDLk9LIBnBAL+3N3k4N4H7TwphLRddpfCla+oax2TjvUa5vE/UIFlmzI7aWNySAHy5xwmcaADCCHd+U43YrihcMj14rkfggHZU7AMkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDLQX6v8; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-431048c4068so159450f8f.1
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 17:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765849377; x=1766454177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyiAfBS1SHi1ogYvB6RKd2TbkiFPHcyLTNoNsrXdb6o=;
        b=dDLQX6v8xVx58d9y4lPH83vCx7nAbXoodPpqTmM0oWNmbVvOdGsENfXSco5Lgs9344
         zLQAE0JiACBwqMJjVVmVWY78HmZAQnVh/NLMg8Ns2X5y1ujQ6Ve2RvpKwEPBZxFzFnAU
         1c/V11w89MYQCHxfAFIL4qCthAqpqwI9KqYaAr2gQMVsWZ6gftv2+LGba7UR7umgDdhE
         v0b2eGdoDYPHd+XQJ774NDDGKSgy+W3GzPli/OiGOmuyKQBwxaIo5PoBFJxK4EWrwCEh
         /OspgPaMaDnRZSyoawBo1e7DZeyfAra6HWP/J3trzCQ3LlSxzlWkqnsQXA7ytn6oNqh2
         Xi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765849377; x=1766454177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZyiAfBS1SHi1ogYvB6RKd2TbkiFPHcyLTNoNsrXdb6o=;
        b=ao3rsZzXnGx61ildZPWdT4THUw8UH1FY2S13TJhvE0srcFEVyUVPn242ZK20uCkMnj
         rQb11pBDvWU5uKz3tatLHw8AWTMowK4yLEG36+TZl7/8UQ0kY55XOuocciIPCC4ndxZk
         gJ6bcSeAB8Z+mLNA7L58rJB3l/TP0DPO6gG9/saqDU0TiF/mEySUNjjCYog8rpFlEwTn
         FB6zO0luUQaQxPSDNtBtk3MvsDSmpFAo51qlqpNBl/tSHHXlgred2YFgoKqNJQoSqTG7
         s5zTLO47FpQNZvhLjV4CSYOKGYzYb2Kf5AfQMII3fN5qbR7f8GpXvdyN+sQseoWLjJpP
         TnvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOoDoMDjOYFhTcPz8InCCJ2QcpcBxOXc3uitqOJLrAAreVfe/seoCYWY+WHCrgzOnVduQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcz/8svrxbpZv6aAKkBPnxiJdgKFHgjHiJPI+usomu5PvP1/MV
	gP/bQJCC0I+xx1y7X2/i+fe0WXQHd2W39dc21K8MzfGbxrHWLYKjvKgJr/m9VLKsr/NtIS16Dqf
	8KTKA4rD4RA5a85fC2iy0Xg+msIQU9ZM=
X-Gm-Gg: AY/fxX5Lp7W5pSYVV/i8haX0e38WjaAs+ln+0lDDUjJHvWDxJUxhLWY76M8b40FSJn9
	ZNvV7xO79151y0Rsg16aSQrO70xUl3113aodCWcqB/siAUw8Yo1TcZoOtRLkMfrXlM7esdouHMn
	0kBveY8zYB45qWikE2HBRX5oLKLyiEXc1RAHlzlzA1fnHvwFZHnd4yTcSeuN/fRWEvb3jFeSV9F
	VtY2InF73V/LDXndk9FzWukVtK5y9srn8PSt5kvM/0KxE4uRLTL1FQ6GE3/IszZgaX+FCnwGl9B
	UagM/SBx5adw9A1b2jHyIVh1aWcU
X-Google-Smtp-Source: AGHT+IHXZEfg1p3HRgI0++xedDQyyt6TVJAX8tLf80JYu34CJbWOG8x06pVXb0fDbpBBSUhZfKL0ivJQkRM5N2F1zdU=
X-Received: by 2002:a05:6000:381:b0:430:f3bd:720a with SMTP id
 ffacd0b85a97d-430f3bd763amr10307348f8f.27.1765849377540; Mon, 15 Dec 2025
 17:42:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176584314280.2550.10885082269394184097@77bfb67944a2>
 <20251216122514.7ee70d5f@canb.auug.org.au> <3cd2c37e-458f-409c-86e9-cd3c636fb071@linux.dev>
 <CAADnVQKB1Ubr8ntTAb0Q6D1ek+2tLk1yJucLOXouaF_vMqP3GA@mail.gmail.com>
In-Reply-To: <CAADnVQKB1Ubr8ntTAb0Q6D1ek+2tLk1yJucLOXouaF_vMqP3GA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Dec 2025 17:42:45 -0800
X-Gm-Features: AQt7F2qZ64Mmn0-BWatGXdXbAgAM-TAJMN_WlLu09kQhu9Y_Np5ib-yXqYgCTp8
Message-ID: <CAADnVQLE1R=DDjj88u+xuws8+JLKo6J2HiLj=jpO8MLpbp98SA@mail.gmail.com>
Subject: Re: [REGRESSION] next/pending-fixes: (build) error: unknown warning
 option '-Wno-suggest-attribute=format'; did...
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, KernelCI bot <bot@kernelci.org>, 
	kernelci@lists.linux.dev, kernelci-results@groups.io, 
	Linux Regressions <regressions@lists.linux.dev>, gus@collabora.com, 
	Linux-Next Mailing List <linux-next@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 5:37=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
>
> I removed the offending patch from bpf tree.

All,

heads up. gmail doesn't like me :(
I see Steven's and Ihor's replies in lore, but nothing in my mailbox.

And Steven's reply was a couple hours ago.
Nothing in my spam either, and I was cc-ed directly!
So it's not mailing list delivery throttling.
Ouch.

If it looks like I'm ignoring your emails, it's not me. It's gmail fault.

