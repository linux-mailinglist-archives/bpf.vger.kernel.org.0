Return-Path: <bpf+bounces-60511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C92AD7AEB
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 21:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8503A3FA5
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 19:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4372BE7C6;
	Thu, 12 Jun 2025 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzGttMYP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE31929898B
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749755420; cv=none; b=CfgVY57Hfgir4S+E4haGOYVqE9jvDMxy/gSxi0zEybwbTtBSEJYuLSPyGPGfrBYv+M6xe3aj8uQc9G7UcD7YW2psAJ6gnt54oPa0598+6xsULqA5wHrTk7k1DbGaU2iH1zv9v04t3clBbnEKJplnqe4YJoeUO61vHjj3JKiUL48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749755420; c=relaxed/simple;
	bh=SM3NsHmB/LGFn4Inr06kM7LyG1Jis3wAXkNxkExNGlA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VmTYyenueKlj+LKhhqez5Of5I10iM99AJyak8duBtvEaCvturUmdsPgoMfBu0V/C+i3DrdvIHRuqBp0AtrCLu6OFKf4wakE/SlUHyVkIVoeAkztrBxH1mRDQiLkX+Gia34+MEzwdc0qrn0FXYaeYvyQqX9H3EZZYhAn7t6aawXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzGttMYP; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3122368d7c4so1320910a91.1
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 12:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749755418; x=1750360218; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7mk9nAYY01msstUb/N2aecnGoz2OvotS4hyvSPSwNzQ=;
        b=kzGttMYPi3UIQZMGT1Jo3NHswwSiLAkuZ0iQtENlxjRSzgvhQzAGDshLmQxJdK3kRX
         ThkpEAqlQEHVGOrwx6X9/uPsWYEqZpHtTeb4R+7fboXAWLl5roe1BLw5D3Agm/USadmO
         EY4c2OgFxUU7R+/xivzn/TBYLJEt94jMV+/rvCL15TxUceRYy5PDVvuJQIbpA1QhU6FE
         U3G+1dm7mz/aC/R0fHm/0dQUqktRwhhds2nzd3MncUadZ/dWsAwatZTE8sI2jQEMhMM9
         gAIFkYbuei1PesGmzs226hAZxXE5AjOmgW23cIvFFrP7+2J55gwIpD1gIvu5t7UK/p5F
         z/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749755418; x=1750360218;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7mk9nAYY01msstUb/N2aecnGoz2OvotS4hyvSPSwNzQ=;
        b=HD4inVWvetiHLbQCxnwhBT6sUJlyDwmg/yuJFILUoKCnkpdiN4OwUNw9d7nmETv8Si
         ucbeFp0PMqnEGdKOMn8DxBF5Nbi1DdhFfVxDSTyaZAnHI6SDLfdEHGGYCqR1IT4yOtkZ
         UIoBi4SVolYLmSPOJsyL5NJ/bMFppVBSgtKcPC594wY1ar7zk/NMCsU4zOQ4H2YkFH/8
         1K159ZawyHk7jEpQzNAza5aH7BB5SbGf8O2Il+R0rpxtn7/oyGjZblvcIDtlUZXZVg7Z
         ld39whT9+ukgK9jmk2QUJI0LM+WeJ36CKOaPd1FoyJ9zLjyml3aSmpwNQO0KC7Jtu0S9
         Ym5w==
X-Forwarded-Encrypted: i=1; AJvYcCUqqxqwrF/JyQ+ssGFpHhJ6fGIHtGyua+E1gmorJOegdMJsCDa24O2VqtqbuUE8KYyo7nY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk7hTTYX2vkyMvc79giTTLNIG2fXpLViOBNTH+Gj/lUfbyeKP3
	iGA0VCpX3wvGDCnv2VcF8ti2I9qsn8OrlgPkccv0FrITzFu+gf2TkBmf
X-Gm-Gg: ASbGncu7LAEM4/CXsWu9WX84DbbVdMMjOicaP3nXGYylVVy1MrCnRnpW1TgAIZ3R3U8
	FuGJQGwFrcmL3C7oFqTnRCruchlCCYRvggCO0d1nmuHXpcQUp85lvWmzxjij2K1ccX5UVePZP80
	1OnzA1389XRdjpEmnvAJAxuq9I06I8wecFJG25XEbZGi7GDoV7dSWOlFGNs3PNCKcSwPECSZ/rj
	zbckEOxqaEhXOCvnQTz7gwtPOpsA1fxAgG3UVlwsmjN8zdd4aBEyeegaqHj7B/6hZX9m7Q+VZg0
	+XccoTRtbebsQQ2fkNLUiAy1R3Vy968tKkYx9w2XS97H1E1UTvuKvT1vXRo=
X-Google-Smtp-Source: AGHT+IGQw7qN1H3gz7VZVo86hgKumNhQRdsYlcH01MJkFf2iQVgIzYUhuuTY9z4vJHUNX6WtfGuGpw==
X-Received: by 2002:a17:90b:3b8c:b0:30e:5c7f:5d26 with SMTP id 98e67ed59e1d1-313d9ed8064mr521735a91.24.1749755418120;
        Thu, 12 Jun 2025 12:10:18 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1b6d560sm1868342a91.49.2025.06.12.12.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 12:10:17 -0700 (PDT)
Message-ID: <5341c8c05537d6f9a4d252f5c98ec895ade09430.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix some incorrect inline asm
 codes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Thu, 12 Jun 2025 12:10:15 -0700
In-Reply-To: <20250612171938.2373564-1-yonghong.song@linux.dev>
References: <20250612171938.2373564-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-12 at 10:19 -0700, Yonghong Song wrote:
> In one of upstream thread ([1]), there is a discussion about
> the below inline asm code:
>=20
>   if r1 =3D=3D 0xdeadbeef goto +2;
>   ...
>=20
> In actual llvm backend, the above 0xdeadbeef will actually do
> sign extension to 64bit value and then compare to register r1.
>=20
> But the code itself does not imply the above semantics. It looks
> like the comparision is between r1 and 0xdeadbeef. For example,
> let us at a simple C code:
>   $ cat t1.c
>   int foo(long a) { return a =3D=3D 0xdeadbeef ? 2 : 3; }
>   $ clang --target=3Dbpf -O2 -c t1.c && llvm-objdump -d t1.o
>     ...
>     w0 =3D 0x2
>     r2 =3D 0xdeadbeef ll
>     if r1 =3D=3D r2 goto +0x1
>     w0 =3D 0x3
>     exit
> It does try to compare r1 and 0xdeadbeef.
>=20
> To address the above confusing inline asm issue, llvm backend ([2])
> added some range checking for such insns and beyond. For the above
> insn asm, the warning like below
>   warning: immediate out of range, shall fit in int range
> will be issued. If -Werror is in the compilation flags, the
> error will be issued.
>=20
> To avoid the above warning/error, the afore-mentioned inline asm
> should be rewritten to
>=20
>   if r1 =3D=3D -559038737 goto +2;
>   ...
>=20
> Fix a few selftest cases like the above based on insn range checking
> requirement in [2].
>=20
>   [1] https://lore.kernel.org/bpf/70affb12-327b-4882-bd1d-afda8b8c6f56@li=
nux.dev/
>   [2] https://github.com/llvm/llvm-project/pull/142989
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Changes like 0xffffffff -> -1 and 0xfffffffe -> -2 look fine,
but changes like 0xffff1234 -> -60876 are an unnecessary obfuscation,
maybe we need to reconsider.

[...]

