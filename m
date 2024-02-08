Return-Path: <bpf+bounces-21506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F9684E2FF
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 15:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CC4FB217CE
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 14:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5614F78678;
	Thu,  8 Feb 2024 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqWG/m7D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C8876C75
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401945; cv=none; b=NGv6yLiBpFlE2mYpRHDDZmtaJzX/RJee7gmVoDb6UBvslX9WjNu78pZDNCZxBoQKX7/8wZVmzMLzhrIX31wuzmxWmYDGpVeQWb6G7pC+34cKKBHllv/YYrfxgJxH8BqqbmrYM8R8VYI8f3hgAVu8cTg0zqJrZX4TDprsSqhs2Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401945; c=relaxed/simple;
	bh=PXs2zQw130tBPS++gg8a4VVS6DWZdf97ZJtpVzWJ2QA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ClqrLmyeYkGuWi8b71lo0FlW1ygB5PnZ9eyKe8CxVkksNKHoHgyo5KUESqBaKMFjABfA4aJBbXzXptAR3jFvqYZmTHZtz1fovI7wuePzdo6Zu2hAjcSBDg6QaGLT2jIb0381LEY6inpvBz2bxOhu6+4bw34+pKKgobzFkCSPfLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqWG/m7D; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d0aabed735so24052551fa.0
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 06:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707401942; x=1708006742; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PXs2zQw130tBPS++gg8a4VVS6DWZdf97ZJtpVzWJ2QA=;
        b=mqWG/m7Df9f6isrY0Wa+2JnwZ03hyIDze2FRt/mvH2iMr701V0oI8U6t5G5+NO6yWc
         deTSOBwlr622GpNBP8EzSAzoX3fpBVyxFxdqrUy92qNOccBwv+rm7w1Qms/aPnY7mmCK
         vXKxKn5KFH7ZdNp2pgDgl7daOQBSDaRO9w82RsReVmdR3/d4kbGBoP+w9f//PhfvPMMl
         akJlO0W90i/TMyTrbBIrS6e8EKHJfR06girkRL5+DxKXSD75QMV2SJYTuIyIMRfpNgq0
         zoRoMIZB8nX2Ulm09jwyZ8g2hZqxp2V0KFXSNhiwPztkosamhtt82LrlXgkQHVLrpp5o
         lC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707401942; x=1708006742;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXs2zQw130tBPS++gg8a4VVS6DWZdf97ZJtpVzWJ2QA=;
        b=TOVBp2zmrOTNop2MIGsmdTPue4/S3nmFG23hZwimS0PF2nie/Olg/zIlRmY1TBcOW/
         8Kbsh5ER5PkAUZYW3skJ6zaseeEpgzKLV6La+4K+8nOdHYhIAcoWCIvAFq5TIHJvBpav
         qLVl1ITbLKy0F5qCyerI48AcnSpsv3zKp0TLr2z2ZNrtZpZOqUozzVR/QfASMKgQK6Kw
         BeBhf0bI+iEL1ctayWmRMTxwOcVowMEy53S/wRQWuA2A5Xbf+QZtLJasu3TzGlSR+rXw
         +HS4WENF+FORw3I/WAp2vrqPe0C3nAUkaDavyT4lWGqsynuVkYI8vMHL1TgtK+t38tfg
         nd7w==
X-Gm-Message-State: AOJu0YyLjSN7uU7MEI3LJ3eYOpvYBFb829gv0UwBk01TFUS729hok0CH
	zOFY9qR6JojsVncLnvX//DnMrJTpYCDk8gfUROsgIS6dlSc5UF/a
X-Google-Smtp-Source: AGHT+IGU+MzxVXGVivghVExrbBfDchFdbsLsKRoH6c3Uk4A5zPRBxMuc1yApMfAoubuXepFVyzUdQA==
X-Received: by 2002:a2e:9f4e:0:b0:2d0:822a:6740 with SMTP id v14-20020a2e9f4e000000b002d0822a6740mr6524355ljk.46.1707401941945;
        Thu, 08 Feb 2024 06:19:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqacWCUlbNXbaB5aV8HwqSp12yotgca9DG7de7yMbRDdjHpftc4H3tXiSBaPgecJW1qprUJL8EyBh4ZpWZS91ctmqYY8aO0ZVM4BTiUn5rpp1szM6PUEH/dxWTKzbmzdEwYitJmfQPqeONAwxbZWZSsQV3X+52GmfFPl5pUgE5FYJB4w//g+rvXrkednyVc7pnYWcVZjf9O0mJA0w1KaR5OJd0+mrujAqI
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ay17-20020a170906d29100b00a389adef8a8sm81763ejb.153.2024.02.08.06.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 06:19:01 -0800 (PST)
Message-ID: <4ad9dad64b38ae90e4a050ce5181ced750913b23.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: abstract loop unrolling pragmas in BPF
 selftests
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, Yonghong Song
	 <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Yonghong Song <yhs@meta.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>, david.faust@oracle.com, 
	cupertino.miranda@oracle.com
Date: Thu, 08 Feb 2024 16:18:55 +0200
In-Reply-To: <87wmrfdsk7.fsf@oracle.com>
References: <20240207101253.11420-1-jose.marchesi@oracle.com>
	 <c3d29d43-ffa3-47e5-9e44-9114f650bfc4@linux.dev>
	 <87h6ijfayj.fsf@oracle.com> <87wmrfdsk7.fsf@oracle.com>
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

On Thu, 2024-02-08 at 13:55 +0100, Jose E. Marchesi wrote:
[...]

> However, it would be good if some clang wizard could confirm what
> impact, if any, #pragma unroll (aka #pragma clang loop unroll(enabled))
> has over -O2, before ditching these pragmas from the selftests.

I compiled sefltests both with and without this patch,
there are no differences in disassembly of generated BPF object files.
(using current clang main).

[...]

