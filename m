Return-Path: <bpf+bounces-75008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1B3C6BE43
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 23:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7B914E3988
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 22:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E982EAB64;
	Tue, 18 Nov 2025 22:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kfnf07jk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1525B2741A6
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 22:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763506036; cv=none; b=MBBV21pkCXGdsTvm7l+x/dNwTX5D/atWtJI5oo6N8YwyROiUkAOjzq3fQr39qwzTVS9zyqwrWJRTIacrEi6B4rg4Zx6va/jtWhar6/PIHhNgMhPPGYrHvSWx9pblmvamdHlMk3vFxCaWq6Y8zYgBH2fDRh/mSrlSShz801XERBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763506036; c=relaxed/simple;
	bh=C2PzE1+aS7OKShapUCv0+jM/cP1jrF+lyhA8geXw0ao=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nehq6GTEVoxrUdQhOzTNPL9ww8cs7Bb1ZxNmfADd9/3Pnjn1In9GeuYCkh1H6unQtm3IXPfv26aNoOrBTGqQHcac/eKE076dYy1pu/1idnQogq9vvIXvxjY0IgpDxajuRdS2aUJtyWJEqQkSt6yghXD7+HeDtMWbefatubQsGa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kfnf07jk; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso2430598b3a.1
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 14:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763506034; x=1764110834; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E5Vby6CwVdFhg65WMXe//pDnz6SXhP0klYXhMdzP8HY=;
        b=Kfnf07jkYf+txVDBhlz1VIxnnwdQ44skAdQu9YqKeLlKORz+/7wQgNFBfupQXadba0
         37TF1Gsb0xENOjuubPqmJ6VZ6dsE0DszNwI0PAJYk/WFvEUvWmeiqa90GBEF+hfd5fdL
         DYFvoFz6ORoL/gXdtzgJi2lfKSDi7vWZqWZhtkzqmTXcevbqujK41SYsXGIUkRtCTNWR
         CIv7qSc+o3EM+BhrV3hEfuAUiwf9X47CtDEXuIW5WYa673+W8PcNq8v/gqHIMK7VDYuS
         iQ6MMXjM/6NUmwI+PJ7bW70D9WuwIjA3IjVdXpuSL9WDm9VRCz1o61r31QYyQNtMhSS4
         MF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763506034; x=1764110834;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5Vby6CwVdFhg65WMXe//pDnz6SXhP0klYXhMdzP8HY=;
        b=j0vZp63BMDcWGKLl0M5s9IItw20ORNIOTwYTOdiWn7cDwXvNnVU8WG5RAYSzzOMeMG
         +7o0YueNtR0W+1Cs7E4rErkGt6hCLNTRDWjAOKCDQ/ipTsVTcUiCavKsGwQ2zOKxIuLZ
         TmSZOIkhoIdEYzORY0fvQfeZ9kym073iGWk/mkl5nonjAcs+PA403HhutJJNiSATp93g
         bmAuhAXp+FvTxGc4sQZOJ4h3mNStTTOP1DFuWF4zPgS7JTliVLeDzsP8r7RHcyuqQgt0
         8NgEPp8oA4jXPQ4iKCr59wkRiTnhREFdxOGGyXDIo0sQsOcqSEkVxJZhbT12IlYkokDQ
         8a4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPkfAOjDSJEepg9Zf7WUAVGo5p8Tf08gzlX8YglB9b20Z/GcrdN2+4jp21N2O7suwQD80=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMy+3/A0Zx8O7sCZOX8iLO5TTshfobq3xQl6YmLEMoWdz00AZl
	xURRZ7YR69NTxbssS3vx3ovTut1I8FiltEhAo6iEHpJdi5q+SELp/rF/
X-Gm-Gg: ASbGnctRDu5c3cWhIGBzylmc7eNL69LdhMoWxaZrJkJCxK1bW4vZj1PAZ+zPJ67UxDF
	sjwY+WYMIUPEmRcFxOYo+ePN9qM+aOWoZlAEiaWX8DHWQC6eDHqJFUlYjqNy6WzcBZlgkKcXCeC
	5/gM8XVqZ6BX5nFBhLJ5501yq79j4LoL2GOsPjfHoK0iDyNxhcavDBDpFbRguyddEoSITwTUgEc
	7DyYn4f7xxy/4wJ+LVoPBicJ5nqoBVlRmwqNORr9RzW26uA5rZBl13jBkOgo16oLtd0l1JA18Ij
	aJWWAVgXvWSRkyWazvYpI3n3YVm69IUKpPe/kQv7fPmy5MLkqb2vD2k/u0ZkRSk+yn3hv457n0d
	Gi1f7rb4GOh9UV1QmEioxas0BbVfplJSN8VC9FGWdrNSuw8K5kgrwjRohaqdQmMyAyFtwFx6V1R
	DVRf4tqTUzsCEazPqzp8WJa1Hv1R0M3tV5+jDKpSc0r5LAdlo=
X-Google-Smtp-Source: AGHT+IHWzwi9k11gQKMfpVJS1KUk0hG8SjfWf8g3qo5nX8PRIf3k+W3hZrrQiJ8nEZ/eTvpUEmR9lQ==
X-Received: by 2002:a05:6a20:1611:b0:35d:b415:7124 with SMTP id adf61e73a8af0-35db4157822mr15515210637.50.1763506034267;
        Tue, 18 Nov 2025 14:47:14 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a9d4:ea4c:ca6f:e5fd? ([2620:10d:c090:500::5:ee25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc375177be4sm16205916a12.19.2025.11.18.14.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 14:47:13 -0800 (PST)
Message-ID: <c700efeec014293a879a33eb68fe99c03415b0ac.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/4] bpf: test the proper verification of
 tail calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin Teichmann <martin.teichmann@xfel.eu>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org
Date: Tue, 18 Nov 2025 14:47:12 -0800
In-Reply-To: <20251118133944.979865-3-martin.teichmann@xfel.eu>
References: <4952b7bf8a0b50352b31bee7ddf89e7809101af6.camel@gmail.com>
	 <20251118133944.979865-3-martin.teichmann@xfel.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-18 at 14:39 +0100, Martin Teichmann wrote:
> Three tests are added:
>=20
> - invalidate_pkt_pointers_by_tail_call checks that one can use the
>   packet pointer after a tail call. This was originally possible
>   and also poses not problems, but was made impossible by 1a4607ffba35.
>=20
> - invalidate_pkt_pointers_by_static_tail_call tests a corner case
>   found by Eduard Zingerman during the discussion of the original fix,
>   which was broken in that fix.
>=20
> - subprog_result_tail_call tests that precision propagation works
>   correctly across tail calls. This did not work before.
>=20
> Signed-off-by: Martin Teichmann <martin.teichmann@xfel.eu>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision=
.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> index ac3e418c2a96..de5ef3152567 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> @@ -793,4 +793,51 @@ __naked int stack_slot_aliases_precision(void)
>  	);
>  }

[...]

> +SEC("?raw_tp")
> +__failure __log_level(2)
> +__msg("6: (0f) r1 +=3D r0")
> +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 5: (bf) r1 =3D r6=
")
> +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 4: (27) r0 *=3D 4=
")
> +__msg("mark_precise: frame0: parent state regs=3Dr0 stack=3D:  R0=3DPsca=
lar() R6=3Dmap_value(map=3D.data.vals,ks=3D4,vs=3D16) R10=3Dfp0")

Nit: I'd add a couple more lines to this __msg sequence to check that
     backtrack_insn correctly moved one frame down.

> +__msg("math between map_value pointer and register with unbounded min va=
lue is not allowed")
> +__naked int subprog_result_tail_call(void)
> +{
> +	asm volatile (
> +		"r2 =3D 3;"
> +		"call identity_tail_call;"
> +		"r0 *=3D 4;"
> +		"r1 =3D %[vals];"
> +		"r1 +=3D r0;"
> +		"r0 =3D *(u32 *)(r1 + 0);"
> +		"exit;"
> +		:
> +		: __imm_ptr(vals)
> +		: __clobber_common
> +	);
> +}
> +
>  char _license[] SEC("license") =3D "GPL";

