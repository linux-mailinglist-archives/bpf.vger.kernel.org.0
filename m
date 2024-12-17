Return-Path: <bpf+bounces-47080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DAF9F40E6
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 03:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F77A188C5CA
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 02:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D70B13B7A1;
	Tue, 17 Dec 2024 02:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laRhZ3mc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4025818035;
	Tue, 17 Dec 2024 02:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734403151; cv=none; b=IgMD7htLEzJwHk3Wglulsnyuw31fN6krCvwB2MJEzoned9pNl50KxYgPR+Nu48oa+YDG/pdi/a/qWvGo2L8qTKYHGvi9gV+UazDu5ZbVwEeYVgnMCKC+szOPNpPC8awQxtpd0ynBf1ANWtI6a2n6BhHCP38vYZYRj2lhQqyEIFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734403151; c=relaxed/simple;
	bh=d7tKwNggGYb7+cuJhX3++J9k4A9128hA0Qj4NxY8Xko=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i8nR5Uico3lQmC7w1iExoulKdjGWOooS9Hjs+kl3wHWBIezLBTGinsrHjGQjwdt1XXGGFDeifzxFsq6oga9SAbfY3Z4i7cZ9uud1wFbxJ7jEmCCPKdB3LnPnd54VA1v2MRBrxBIz+wrE/yfkK9Hzj7qE8wChHy0enUwiDytsI54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laRhZ3mc; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-728eccf836bso4128347b3a.1;
        Mon, 16 Dec 2024 18:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734403149; x=1735007949; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/UAOt1R2UFoEWdb+FDwAoeGbA0s67yZZ0DJm5nsl6Tw=;
        b=laRhZ3mcDBW5Isi1Mjv2OjAIsPZXmA7ejSoK2aXm9n9FRFRtlLhs1wzfiTLxI2BHcq
         AfcMgcZc8GTRTPqJhMyjwpKbkAA2n5DjOcChYpke2/vS5LeV58FClHrWvgmHivhEgqre
         J4CcQj0wqSXY2XUQcszsIXqXMs53akkdjT3kdYupBJfNtAJ97gmse4GmJ2wr4eyWclGr
         PEvDBDpQboFuGotyjupXSqsUzj9LBHXTGQHT75wZDvn/XOJF9nPI+omyPicP1eR/Ukkw
         sy8rXYfkNeaEGDvhqfwAdIWKnV7Wi/bPGaQtlPm+CBZisnA9kWAbT10+mh6D4kxZU6xT
         6hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734403149; x=1735007949;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/UAOt1R2UFoEWdb+FDwAoeGbA0s67yZZ0DJm5nsl6Tw=;
        b=JQ/A6GqOgb6Q3UVJxDhtRVfQliIVXvO2Da2WUvapy97aXUWGzPGg33HqMQOx0La3xy
         yF53GOIZ0qpizkJFXP/Y1QT760IRNaCJ/HmwqBKCBigjwqAhRwmKQdUFeHtaOQxJDs/N
         qrSkknvsbbmVWVIlqBF78Y8NxW6vN9Rcsn10xXa8Q8BEG3knKXybNKfmBnIfXsX6/tJ8
         iUJuRomuFzLtDH0pEt/t+YpwglFZx1qwIqJppjtT8u5Yrg4n/Q/uEA1PRP9p1UQ6epLY
         i+Ve+uGpRqNgn4PkvORkEHVcGGlQBpll9kXiM8QbppvLJHP+4nqf0UNiJoMCqdn9gEUN
         03mw==
X-Forwarded-Encrypted: i=1; AJvYcCWL7jMOvssvw7Dtlr+70YudboippR7SRDgEisr/LdUU4lhRWnWHPhlJxatLugAL/aZAJBA=@vger.kernel.org, AJvYcCXpeoFeyCRApQbtTw9ET558EyjJoxn1ISvJcyqePdaxenyrN9te5rmnLRe0lYdsqgE+Swt+Wr7ThQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJtNDiUkvPi1KEpo7fz+r6KZHnQCUOEATc4wYr6fO5rwazx2cE
	FoOnvgcPjkzYVOrZ36ZlU9bLJtvcyaS7yUmjY82BHjvmC91vQkLo
X-Gm-Gg: ASbGncvVURn8sW5UJJbopsB3VYPtCKBel2l3pyflYXAhhdluMjmhtHg3kAne9Z/rvi1
	Mn5iM/7G81Oyg141z32UZEWi3ksTkeGEKnFNLGSqkMAdzVfqnNBstFHYqU7Qma0p5MxukDjXyqY
	3FyvWIT0OwX2AiY4A/URQDaxe3V/tTq5gHyIWRzYsbxfV2eEuUddSWRxUqaRuJ0eQxnPmULw/cc
	V1Tq9Y916zK1DLhiZaOhRfLUtFhCdhFPRj739vbBvXUlUSldNOkLA==
X-Google-Smtp-Source: AGHT+IFmJIw3cwZcaPC0wESUPJsZaM/404E1iB/Bu6Vkx7ocIqnUcAhW7UdygscbwNbHVAUSncGY0Q==
X-Received: by 2002:a17:903:3256:b0:215:7faa:ece2 with SMTP id d9443c01a7336-21892a4177emr169914825ad.35.1734403149498;
        Mon, 16 Dec 2024 18:39:09 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dcb415sm49403025ad.71.2024.12.16.18.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 18:39:08 -0800 (PST)
Message-ID: <09f6bc335380ca73d365566de7af8f2e73ac9cfd.camel@gmail.com>
Subject: Re: [PATCH dwarves v2 07/10] btf_encoder: introduce
 btf_encoding_context
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org,
 mykolal@fb.com, 	bpf@vger.kernel.org
Date: Mon, 16 Dec 2024 18:39:03 -0800
In-Reply-To: <20241213223641.564002-8-ihor.solodrai@pm.me>
References: <20241213223641.564002-1-ihor.solodrai@pm.me>
	 <20241213223641.564002-8-ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-13 at 22:37 +0000, Ihor Solodrai wrote:
> Introduce a static struct holding global data necessary for BTF
> encoding: elf_functions tables and btf_encoder structs.
>=20
> The context has init()/exit() interface that should be used to
> indicate when BTF encoding work has started and ended.
>=20
> I considered freeing everything contained in the context exclusively
> on exit(), however it turns out this unnecessarily increases max
> RSS. Probably because the work done in btf_encoder__encode() requires
> relatively more memory, and if encoders and tables are freed earlier,
> that space is reused.
>=20
> Compare:
>     -j4: 	Maximum resident set size (kbytes): 868484
>     -j8: 	Maximum resident set size (kbytes): 1003040
>     -j16: 	Maximum resident set size (kbytes): 1039416
>     -j32: 	Maximum resident set size (kbytes): 1145312
> vs
>     -j4: 	Maximum resident set size (kbytes): 972692
>     -j8: 	Maximum resident set size (kbytes): 1043184
>     -j16: 	Maximum resident set size (kbytes): 1081156
>     -j32: 	Maximum resident set size (kbytes): 1218184
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---

After patch #10 "dwarf_loader: multithreading with a job/worker model"
from this series I do not understand why this patch is necessary.
After patch #10 there is only one BTF encoder, thus:
- there is no need to track btf_encoder_list;
- elf_functions_list can now be a part of the encoder;
- it should be possible to forgo global variable for encoder
  and pass it as a parameter for each btf_encoder__* func.

So it seems that this patch should be dropped and replaced by one that
follows patch #10 and applies the above simplifications.
Wdyt?

[...]


