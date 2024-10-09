Return-Path: <bpf+bounces-41375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8F399653D
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 11:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7C3283DA4
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 09:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C0218EFD0;
	Wed,  9 Oct 2024 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/kp9Piq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B4518E34D
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465798; cv=none; b=TgzedmohaCQpdiu/YKaM9kaC+qvRGeuwi2rmGPEQoi8D79UrD4YMFl0bHqwVhlBKRGd9MUQFWotopEUUFgjsmi3Cq1gkXx+yugMWtIjPB4a9IHBLlEEYwFFfaNQ4HIE0bQfZ0FrButbECxvxS70b9C5Mea/bsgjvUoLrZrGKNJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465798; c=relaxed/simple;
	bh=fyxM2pNEQ+8rIfzmbUY2KhGbl+B32hXbSZQ96RQUfM8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GKUK9WM27YCxyIcBDH0zSIlklykIhvDHckh/EOYfX/UJ3m5gp4/9kQ+o9jMkPAFkWAlADfZWIpTM+OgmeyQzOOL1YThbYwJ/5WOEGr21yjnuWmdNxkxLBClEKuVhg9mRUA1hIi7ejk+AwrT5aPZTmK/jgthWs/76QwHvd08gbrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/kp9Piq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c593d6b1cso14530125ad.0
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2024 02:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728465796; x=1729070596; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/OiBmdna70iDUWpGMBnuQIr4MIh9fKhEt+BAl1uHApQ=;
        b=I/kp9Piq0F5aT5Z4m9rU4G79vXvDNjTg4ZmP2YTSwBsM6ISMdfPZuYj3pNlFlSxg42
         8O0FCF4+6Ns7fB9n/6nst2FjlZAKX3IaTACl7LthI6/acRrQY6wAlxqQp7+trDbpx0AG
         O3dMtdxYuI720ypEoNzTcwHtymqf72IsTIFCeyeN6rTCCZS/8/ThW/pRbE2wH5neVrB/
         FbgSRhni6QOJ8PvJagziRgPY3Hz38TLewSv/CC9TmVnwsHLqLvM00e8ttQRyQuVeKeOR
         9TpVjUQuKObzaylYkDGIahBZe0/tcM9w6mbZMXQydgm+neT9NzEAC6FRbykQEGftMa25
         skZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728465796; x=1729070596;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/OiBmdna70iDUWpGMBnuQIr4MIh9fKhEt+BAl1uHApQ=;
        b=rlE8dE/qWtPIe3iAvQISVsvwP4/Ceu6yL9NTydPYLqAMQdWUVJf1dZseSOhgN7SYbu
         tIJ6+gF/W3t5zHt99YqClQ8wuxBo46ERXMfSVYHuxCIMl71P917J2un/T3sxlzus3fal
         GKlmuVM491YsFEckF9KtA8Wg8fQr+1Er3bqapsIYlNm8bVY9cw709x+LAZFpdKlp6pW9
         s91lijuJ3+VWMM5rzB0j0uuTcKq0wVYlMrHOjyNMfQf3qUKu8xd4cI1tAZiIFiqZ4TJZ
         FTk9Id9+KxTFoEewymEwu3VWeei2v455pi/jAwzavRGYZpyfJCkU1oGmJYtMHe+RTv3p
         Oybg==
X-Gm-Message-State: AOJu0Yzw3TFw3aQaV4wixGLnZZMF3LXXuhgGYUqAztMjpZKnXLo4cFVT
	Ijiy25unu576bxILSbxnpNPDDAkg9XknpFOd0mI0SaezWdI+N4QS3pxRrt/j
X-Google-Smtp-Source: AGHT+IHURi/8bq6amX0XPJrPdDBRmLVCN/jCQ5kO0gIlU+3ZV6YDlEcWbXrqsxTu/CXKeAQIiHn3dA==
X-Received: by 2002:a17:903:2309:b0:206:c12d:abad with SMTP id d9443c01a7336-20c637511d2mr27451245ad.34.1728465796162;
        Wed, 09 Oct 2024 02:23:16 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138afd12sm67486705ad.53.2024.10.09.02.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 02:23:15 -0700 (PDT)
Message-ID: <e6d6ffc2496a2e5845293ee9b9e7d594a7ad7d1c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: force checkpoints at loop
 back-edges
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev
Date: Wed, 09 Oct 2024 02:23:11 -0700
In-Reply-To: <20241009021254.2805446-1-eddyz87@gmail.com>
References: <20241009021254.2805446-1-eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-08 at 19:12 -0700, Eduard Zingerman wrote:

[...]

> This patch forcibly enables checkpoints for each loop back-edge.
> This helps with the programs in question, as verification of both
> syzbot program and reduced snippet finishes in ~2.5 sec.

[...]

> File                        Program                               Insns  =
   (DIFF)  States       (DIFF)
> --------------------------  ------------------------------------  -------=
---------  -------------------
> ...
> pyperf600.bpf.o             on_event                               -53870=
 (-9.81%)      -3000 (-10.16%)
> ...

fwiw, this patch speeds up verification of pyperf600 by a small margin,
sufficient for it to pass in combination with jump history bump when LLVM20=
 is used.

# ./veristat pyperf600.bpf.o no_alu32/pyperf600.bpf.o cpuv4/pyperf600.bpf.o
...
File             Program   Verdict  Duration (us)   Insns  States  Peak sta=
tes
---------------  --------  -------  -------------  ------  ------  --------=
---
pyperf600.bpf.o  on_event  success        2400571  872914   26490        25=
480
pyperf600.bpf.o  on_event  success        2460908  947038   26090        25=
330
pyperf600.bpf.o  on_event  success        2158117  788481   26329        25=
368
---------------  --------  -------  -------------  ------  ------  --------=
---

W/o this patch jump history bump is not sufficient to get no_alu32 version =
verified,
instruction limit is reached.

The draft is here:
https://github.com/eddyz87/bpf/tree/jmp-history-pyperf600

[...]


