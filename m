Return-Path: <bpf+bounces-22110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFD9857060
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 23:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 201AFB23A51
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 22:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F7E145B36;
	Thu, 15 Feb 2024 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOTG5W6m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1831420DB
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 22:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708035072; cv=none; b=u+fkZTpkKuteVWgMKwH9dXKdCMMtgob3ZwtZZpcfT8LJy/4KLHMDfUsBuzen3QbggkISeeO83tRtkUnT/jWEcKl/cXeTgRQRtttDZhXney1xELa7nSQkSpBViSpz60q8fW2O7sztwP+wStDaxv9mxIHNEpvo+V36+llmkKgml60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708035072; c=relaxed/simple;
	bh=LUXz550Y/XDqSkgFvaqloc14v25/bSwAJL55EVADaB0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U5tZO1plFKk+4GIMp2zyEzx7t8F1X++LKz1v4So7mmRKZ6rT7RYaffHfGQfuwQUby9HvLoChEILR42WjLshS99PB7kSbMh9BXATKvKx3WUSuq7d8pqgV1+jtw8SCqgd0E0QXqvZsYfFUIqiTwKw2RXUJX/7K4w99jQCy1CFpRWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOTG5W6m; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-59505514213so813985eaf.0
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 14:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708035070; x=1708639870; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lIipPaHPd3BD1RjyQbMY7BT3z7H97AJ2nLYujjdrkiQ=;
        b=GOTG5W6mI5XxGTGLv7i5I0TAqs5DNaMrygTjYh1EedGrLqT8I0lmOKVfwlZ5yEtwIR
         lbBVY/Qd74xhUYTNsyEWqYNi900IhszdBCa1lYvdh0ktjtp6zZPu0GLQQuT701FtUnqA
         DnHIULoRbzwXIGaJAH8aqGR44vpRLLjvDVr+yIGdoh0REu7Nkpj4pJ1GKci2qw6Gn211
         TzEEMsZDm+WR17rogmZY80XG7ixnvz9yJh9buNHM0ktS6iS/Zq2/OkTTegljykTDqKga
         3qdK82+JxbbUYefKGb/w0RUX1JGkq2KQAWRpwCupwBAGorPXlbICcr+SR15Um21hfKpc
         7wMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708035070; x=1708639870;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lIipPaHPd3BD1RjyQbMY7BT3z7H97AJ2nLYujjdrkiQ=;
        b=RkagmzCwLFm1pRrkQ+KTzaGrqpB+hCUeTTauRPWfCwYvt8m+cgDZYJ5G8x6OmFg8CA
         yRVRH9GsxSVfbDWld2AZKKRA/dGu4ZsWq4GwNVWD1yZ4bKUUYVmx3m77yR5fjRudH4os
         wJaKfRubuRxuYQD1IYzSIRZPed2uHjM4wMp/loD5CR4yuXiZ4dBsnRGG3Ffc7oFVcWDa
         1WIwJUc3QD4Z5k25iJ03HaMkfvmdyUP1AqVDtj0SkwVcVOuTdNDBjERfximxRSPcUCn0
         /GdSQxgkAnGyCNj8locH9mC6MnskC/DQMqLpLZXCRfi5jHadR5QoM9jKDEUUngjEsO0G
         ygmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWccIwaMdFUrS14iuTyj8/h60SS6QKctbc12J1MLvVgSBfnZ1pNND8bmvEAGhCajQUIy9OQmy7rvXUGkYNcSwmeV8E3
X-Gm-Message-State: AOJu0YwWgu2PZ5YoEORSYPyQXGanphN99S+hF2KTIbR2R02g9Xs5RLCW
	88o70T1Z9nT7KijXE1j0ifWZVTCnys4qO85iK6zu9E2viMyQwlr8
X-Google-Smtp-Source: AGHT+IEy7G1bkFoMBUQVJ5KrxUgE0S2eOITFWZkzbAyG7ZiXtb2R+qEaT9rWNBB0Gr37zo6Z9zUtNw==
X-Received: by 2002:a05:6820:2189:b0:59d:6ef2:7460 with SMTP id ce9-20020a056820218900b0059d6ef27460mr2410852oob.3.1708035070187;
        Thu, 15 Feb 2024 14:11:10 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id k13-20020a9d7dcd000000b006e12023de5fsm341557otn.46.2024.02.15.14.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 14:11:09 -0800 (PST)
Message-ID: <956ffbdd1998236db4c576606729303034fe121a.camel@gmail.com>
Subject: Re: [RFC PATCH v1 07/14] bpf: Use hidden subprog trampoline for
 bpf_throw
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>,  Tejun Heo
 <tj@kernel.org>, Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>,
 Rishabh Iyer <rishabh.iyer@epfl.ch>, Sanidhya Kashyap
 <sanidhya.kashyap@epfl.ch>
Date: Fri, 16 Feb 2024 00:11:03 +0200
In-Reply-To: <20240201042109.1150490-8-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
	 <20240201042109.1150490-8-memxor@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-01 at 04:21 +0000, Kumar Kartikeya Dwivedi wrote:
> When we perform a bpf_throw kfunc call, callee saved registers in BPF
> calling convention (R6-R9) may end up getting saved and clobbered by
> bpf_throw. Typically, the kernel will restore the registers before
> returning back to the BPF program, but in case of bpf_throw, the
> function will never return. Therefore, any acquired resources sitting in
> these registers will end up getting destroyed if not saved on the
> stack, without any cleanup happening for them.

Could you please paraphrase this description a bit?
It took me a while to figure out the difference between regular bpf
calls and kfunc calls. Something like:

  - For regular bpf subprogram calls jit emits code that pushes R6-R9 to st=
ack
    before jumping into callee.
  - For kfunc calls jit emits instructions that do not guarantee that
    R6-R9 would be preserved on stack. E.g. for x86 kfunc call is translate=
d
    as "call" instruction, which only pushes return address to stack.

--

Also, what do you think about the following hack:
- declare a hidden kfunc "bpf_throw_r(u64 r6, u64 r7, u64 r8, u64 r9)";
- replace all calls to bpf_throw() with calls to bpf_throw_r()
  (r1-r5 do not have to be preserved anyways).
Thus avoid necessity to introduce the trampoline.

[...]



