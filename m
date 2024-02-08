Return-Path: <bpf+bounces-21508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8627784E40B
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 16:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73651F22BBD
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 15:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EAB7B3F3;
	Thu,  8 Feb 2024 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNsaN1+D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01567640A
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707406089; cv=none; b=CC1Y0KS3F5K1SHAxW5aykBZJHSRkS4qBdWTaDUUrF9lwkJcD7Vya//X46qZTlTK+lMDQV/waW1xOiYKKq7DgliZ5uWIfE0GeY4fetsxMHhsNn1xLQB3voJWStGYtzh3OUf9SIhK+d6V2DJJRTWc3om7bWZhSuTEo8RtWsRMJR2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707406089; c=relaxed/simple;
	bh=VOcn6RtaYFn826djIlijCskn6f1vXff1Kxy9reuVFmo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qfzO+dLu3itX9zwcOZGX5TxFDz/OtZShvwhukfIfIAMJWTtOKJAb06jDMteMRzRQe7O8GhuhKiVvCmWmxpJQfeMlxihAQZl+1P19q/z6eSNeDiPMQWOVbk2jVFdPthgGknz6JgUglZTQIrD7KI+dbM8TaPP8ytaZsGUbkmn8FGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNsaN1+D; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56003c97d98so2185210a12.3
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 07:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707406086; x=1708010886; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VOcn6RtaYFn826djIlijCskn6f1vXff1Kxy9reuVFmo=;
        b=VNsaN1+DVbiX0G/PMQqmm+VvHpvTImw0EnLwK1wcg5d+bKAz10xRzFXOyi1l95Q4Xp
         deKub+lqSQs7DKsS+HnSnmsi+Iw/74y6g0ukNdvtH/Rau4rcrxK0XCHOESNSNefh2qeZ
         ZKlh3v1t1bvkAx7PRkvEK5R9VcHxjPS6DeqP5hUh+VmD3Kjar063syI6ZgD+AVkOEWUZ
         SeXK4FzOoIziecOBvigHERiI4e3sqB+2Hm79VoqekXQM43ffCQENNXTcYgZOMn0GfrD5
         k66KlqY2HBp0ycOdlmvpLHYzKa+hXon0pVye3olKqhnENpqbb/qbcgjLNA1bqR+wdg8v
         5oTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707406086; x=1708010886;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOcn6RtaYFn826djIlijCskn6f1vXff1Kxy9reuVFmo=;
        b=hMZ+QdNXDnAd41SvReTn33k7dvd9nHv2Vfm0sO4VpRCmFK7g2AIkO7405eOVA6yfaQ
         K5ngOutHmk3SPEdX2F8Y1+hmdID6Uvp+9ZmWlEWyThm+DDElJ7ZnSiDK/qQV75Txba4s
         NgEmGbv8f0KaudBKceujRqic4ULqo3dEFBeowgmuYC0eJ4w6LP3wLJhEB/6XYobbuhmx
         l72N9xtHLaEoOoOVpv05t5T7XWOQmIwasuIOyO8yCsU3MevK2QzG3Ra5vdghqekuSK3z
         SMjz9+KWwEj+ToHLuauuJNg3G0Opd8L3LLDYsdPVc2pf1JESOuy3ubXENwSXG1GbQHbm
         /mig==
X-Forwarded-Encrypted: i=1; AJvYcCWh4qoqu1iY2bY+7ESSeQl/kiDIpJKZHCTfNA+og8CZRSB5wSFocwGdgnuzBkHoHl9qYmsyMwoynJrFHjvyN5AVNSfK
X-Gm-Message-State: AOJu0Ywbjs/nytu8Urk15Jw366E3+UE9WOj6vKyzjPEI5WTeJNZqr2Uv
	ODHQf17HI0cWCqb8RgOqwAldymN05MtvRdzUxsItD73+/m6XCdam
X-Google-Smtp-Source: AGHT+IHgjA0GSYXviDp30+AwFNR/K9M7hJgRW/oo8G68YjAhjxfFSJ0gaddR3InCBIFwkAbZo9i2qA==
X-Received: by 2002:a05:6402:1ad1:b0:560:c984:b06f with SMTP id ba17-20020a0564021ad100b00560c984b06fmr4612575edb.5.1707406085852;
        Thu, 08 Feb 2024 07:28:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgUn1BXEfJTXRo5TOHB1UC6UsmZ9uwAYjcNuJnZGndDGfTJhiUDCNhmTQG3GZpd2tBlyR3RnZjEFs6Tf7mj9/HSbU9xHbzuyYmkE8skQH4ksN2BKGS3TsyW3fWKWiS+HxN87Ve1VseloqqsByUBxEwwmFANxl2ysd8jKtSox3BHfZ9UkQmYfAwWczF/wMGBhmJ5KL7f0zoP+b3xXw5GG7Z3b1yKLw=
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id n9-20020a056402434900b0055f0b3ec5d8sm909287edc.36.2024.02.08.07.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 07:28:05 -0800 (PST)
Message-ID: <eea74ef852fc57e9fb69d18e1e5960523c4f7abb.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: abstract loop unrolling pragmas in BPF
 selftests
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, Yonghong
 Song <yhs@meta.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 david.faust@oracle.com, cupertino.miranda@oracle.com
Date: Thu, 08 Feb 2024 17:28:04 +0200
In-Reply-To: <87o7crdmjn.fsf@oracle.com>
References: <20240207101253.11420-1-jose.marchesi@oracle.com>
	 <c3d29d43-ffa3-47e5-9e44-9114f650bfc4@linux.dev>
	 <87h6ijfayj.fsf@oracle.com> <87wmrfdsk7.fsf@oracle.com>
	 <4ad9dad64b38ae90e4a050ce5181ced750913b23.camel@gmail.com>
	 <87o7crdmjn.fsf@oracle.com>
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

On Thu, 2024-02-08 at 16:05 +0100, Jose E. Marchesi wrote:
> > On Thu, 2024-02-08 at 13:55 +0100, Jose E. Marchesi wrote:
> > [...]
> >=20
> > > However, it would be good if some clang wizard could confirm what
> > > impact, if any, #pragma unroll (aka #pragma clang loop unroll(enabled=
))
> > > has over -O2, before ditching these pragmas from the selftests.
> >=20
> > I compiled sefltests both with and without this patch,
> > there are no differences in disassembly of generated BPF object files.
> > (using current clang main).
> >=20
> > [...]
>=20
> Hmm, wouldn't that mean that the loops in profiler.inc.h never get
> unrolled regardless of optimization level or pragma? (profiler2.c)
>=20

No, the generated code is different between profiler{1,2,3}, e.g.:

$ llvm-objdump -d before/profiler1.bpf.o | wc -l
5356
$ llvm-objdump -d before/profiler2.bpf.o | wc -l
2329
$ llvm-objdump -d before/profiler3.bpf.o | wc -l
1915

What I meant, is that generated code for before/profiler1.bpf.o
and after/profiler1.bpf.o is identical, etc.

