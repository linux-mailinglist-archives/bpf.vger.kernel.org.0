Return-Path: <bpf+bounces-52668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D67A4678E
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 18:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070E31890AC1
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 17:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B02223716;
	Wed, 26 Feb 2025 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="FxYEgwwL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F387A1632C8
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589496; cv=none; b=DCinzfFMnmRitZ1K2a+2NqMhzG1tEzZhqvjh1Wlp0VTAtFATZUWGNXlwzMBE3b9bGnP2oRb+Rl3TpnEVGbyCf8PpfjbQEmBxKEdRnDmXGuqfibKrUT2bQoNGkOL2uf0/L/rg/uaz32PVameZNyD6FI0OVc3L+k3fcjpwMM7EebM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589496; c=relaxed/simple;
	bh=AWsRoz2fNu3CXRN7h1fJe1Turw58iB3Gsbcsk340M4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUmGEubEB7zk5dav6yBxoiJdWkL22K1sDTeksSGz5iAhgLstU5Fy+p9pAyeJeEa37Ziis+q92/2BxGdOHKLXVNlAG2X7VFB0MRwjLytQyRLhf7NPoxrJf4nLvjRpy7xRmyZlr/q84S+qLLYdQ7YJGkn4nXED08Dtm+jM6EQruIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=FxYEgwwL; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-472098e6eaeso1711cf.1
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 09:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1740589494; x=1741194294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AWsRoz2fNu3CXRN7h1fJe1Turw58iB3Gsbcsk340M4Q=;
        b=FxYEgwwLPGfUa96vktWzGFxw7kI3Jbw6RJ1l/apuEixDCw01KjIh/rbozk5dYBJrSf
         l92Fqltx0JGXmojp7n4PNM2Uf2qqVWfppEM0PeQUPHqJSxpUKwLxPpAcpZSFR9IYvDRw
         YszwA2WOUsZ+td7BIXtT06D5ZlRMieZn8XXkb+26elwT7Z3NVJW/9jrGPTzfnyFWWpJh
         ZcvObL0lceh3hGrOsHxchtg6/zefUbCO/GavnuTmBf9hVWdFJjnK+epHvbkJpoDqVf7H
         MlNZYxtQbCxcjN1WgeZYX3MvSaPmdJK1nWGB/67ngfPvHcWwjH3xZQYV7TuLNb157sFJ
         eh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740589494; x=1741194294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWsRoz2fNu3CXRN7h1fJe1Turw58iB3Gsbcsk340M4Q=;
        b=Llto4GiI1Qp9kgzo3zCpKNUTOMf1lt4EaOQTq57xcRrvSA2TBeDtphCn/wAihOoUkn
         VyRzEkKrTJ4TZ1LLHU6S188UwB4A5Uj2u3SNy5qYwHozhEWOkdTQDPuwh6rZj+baz/00
         zarrFkjJx9MX0ufHYWLe8XNG1MVusDveeOrV0xPTeNWoOneSr7VmPdtaSG42X3NQ9lI3
         XZyUqvzmRluN0T8Jl7PJRG2r8Hz1rREP5/imgDs0kXYlR4r9p8iVwFegsp9ykwF1u7jW
         BuOmegP3X3jbdiCITAp7kiKuRMxIVbwka7V0Nn012/xXX6PTMB/1fwaI8Bh6jy59gTBe
         gjyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw6uknW6jUrBYhq9VwpM/ToCGaWOdSdMEg+womco6PaeoVt+74DoSt6Csoa6+1l3uid9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGZOWCpMcS1JiJeLmkHdITqaJPaVkOkb7JI4OfoNOD0FikG9X7
	oLrBCV0f717NuX9pSAOv26ITZGjXXNOVBx6hG7B/sbAJx7ECREF49ePbh9ywvcUp0v9XTp/+/xv
	ilg19yCXNHapYmXnl0A3CPJ5bPlGszSr3Z0l+TcGMGJqE96FLBvxMUg==
X-Gm-Gg: ASbGncsRAe/FzldIe3gNqHlV39X5V93U5SWnV/PoKfLjhJ4oB4/dhi5dfBajSbQWaHM
	mXA2FpeYeOY6ock1U/ohWiPrO+VzZoNucobL0Pf9ZtZw/5u8j7kIvz0FY5XGEZTS/ulBzH2c4Jv
	5FCFOJnh2PjMl3KX2Y0NZZs06t/8tUV4okZjFWUU3k
X-Google-Smtp-Source: AGHT+IGklVbLHssJPI1L1/VFC49krBHkA/q+FnsaacxEENuSfvREAYd1ePOxr27IHHmmJHZzJK3xP+UMKVG4EgjFmQM=
X-Received: by 2002:ac8:5786:0:b0:472:7e8:a773 with SMTP id
 d75a77b69052e-472228ab2abmr122960141cf.1.1740589493798; Wed, 26 Feb 2025
 09:04:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224164903.138865-1-jordan@jrife.io> <f1854274-653a-414a-9300-c2e805d2ce14@kernel.org>
In-Reply-To: <f1854274-653a-414a-9300-c2e805d2ce14@kernel.org>
From: Jordan Rife <jordan@jrife.io>
Date: Wed, 26 Feb 2025 09:04:43 -0800
X-Gm-Features: AQ5f1JqxOf2RYy8Ymp-gU9ORSmMKw9yE8irwk_sAaJBquTvUZ_G4CAZDwKthpcQ
Message-ID: <CABi4-oiq4nZzPzmtncVEhbbcbZECjJy6QL1TN18J8L01oy2+4g@mail.gmail.com>
Subject: Re: [PATCH iproute2-next v2] ip: link: netkit: Support scrub options
To: David Ahern <dsahern@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, stephen@networkplumber.org
Content-Type: text/plain; charset="UTF-8"

> needs an update to the man page.

Ack. Will send a v3 with an update.

-Jordan

