Return-Path: <bpf+bounces-68594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421D4B7F475
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0218C52222F
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 01:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B8D35971;
	Wed, 17 Sep 2025 01:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIDaK3Lo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD676ADD
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 01:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071068; cv=none; b=BPTKuCs5n7MRePvHLOE7CQuIQCHRBqjxC9sdEBEf7MquPtT5t5a11I+LqJXD54ZF9Jz4zmiRyQlkt0J5L5vu7g/gDq0Se+Kv3d61GjoBi/7yUNgCg/7gfGoVpDMf9JjV4/f2C715gcL9QPYqh1SU9J5Gal+YqBHSFYGyrABmQro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071068; c=relaxed/simple;
	bh=bfQ/jBZdJQMA9wS760Mk/bw4FeuPnm7V1koxwQ5M7UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGKBMxvHqBppv2UePZw7v/5aMN6swNkPLZ7bsugk/Znv0+aa+mAOngtoj64DILoJOSXLIIn1KNKovFP1E2Fs4XGzOUaOGx38rQr/MyRV7jgEWQe4ISHeU4NNcPfK/q8ddk0BB1BW/zvTR9TWFafrePI9nHBRkdF6kssk/OJA5Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIDaK3Lo; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-62f7bcde405so913675a12.2
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 18:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758071065; x=1758675865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1QyiPtuLPDx63AVu47wKjbmIkBLrVtpsQcDTTG/bNl0=;
        b=FIDaK3LohjNNeuE9k5QIs1Hs8ibj28VjiKvf4RrYnhrezQFYDqL6bY3WuGxo7m5XVf
         xXPdKH+ygozzAJTsT9S/bl+BGcWZ9XTPuqh8d+X97ZVlUivPoRPCeGjynztJnxC0Kwcn
         axbp2jUnhBSUiGlmhVGeHFDoGM2/9fN3ADr0F77vVnThLLBH2ZkMP/vwBcHPaTJ7AY52
         yyKu8bKh40N2dweHUGIi1Wa7AOG2jeplz2m21ry80do0zWr+vJPY9ptX6F7nKoRjvfTu
         MlIbMhbOFoTCmIssZHZsWABAStXdw4lAkEBIJHmlGELc7SY+R2LprZZC9noadBXavlCT
         DiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071065; x=1758675865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1QyiPtuLPDx63AVu47wKjbmIkBLrVtpsQcDTTG/bNl0=;
        b=jdG4b/D1SAbTsN3DSXjEqCLpq0feNxLJFxEq20XtVbgMxum2cJQ/KKf5MsL9HxpXjx
         FXGgAuHyRt9rQcwU3/PA5dShhNonk4aaiAtzLH+4FyafSnXHE1yJNTII28hj1gh1+Nm5
         NRXyA33OC7t2o/8A7u/FlecRTrBhbqECeeQ0GAVVxltxpcbswSCBi63TD8NWe46dV24j
         roo9uCuQ/Z5M3gmveZQ4JXaFU+sAE769NyC+gWQZ3eGX+wKD4uOXGuqM0mCLa38FF052
         QoIyJeVoqc1cd+t1hcCcfxl2txETD+Zs0x6piGl91xI2B7+GXgOV+KceHsmZwP5Zxbdn
         PRYA==
X-Gm-Message-State: AOJu0YwewuBakkjlqbmkUQI+9/aWGs8S0W6jJ/snw1wPuJgGlnZvr2fb
	eSIPQVuNg/iZ4fOLWNMlSY75R4ptTA6D3+6nq0TRIfNNGw4VfGup7jlVKDjpt1usSnalonYHjx4
	/bRkWyyjE9Pi9kKKdbT6kbRQI66xX0PU=
X-Gm-Gg: ASbGnctRyGqWrMaGzmZOl/8hmKTKDMZoocrR+RiEitVs1bSmjYpyw1pBUu3ZnkSMfzR
	RT70j4UNDngWHLg/33JwpXcmu3a6XbHA41BIn0qj+rjXfhytByL3/bPIQ3a+EgDTIpPiG6ovuUO
	RrP/VHivDpgeXF/g7zsdinc9qerGQj7UPaQ2Ct6n8d/s9HaB3P9imJHpVPjFc4ogYrEnqsYNfaL
	rYPJMuepQ==
X-Google-Smtp-Source: AGHT+IFkBNcykaysO72+JHRTnZm9Tw7em8+9tQywJVp/THsKv9F+o7BWBeBWe6AvYtS4qG9fZQNJgWFBLUbTeurObpA=
X-Received: by 2002:a05:6402:d0d:b0:626:8e29:8d42 with SMTP id
 4fb4d7f45d1cf-62f84441772mr432481a12.37.1758071064458; Tue, 16 Sep 2025
 18:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915162848.54282-1-puranjay@kernel.org>
In-Reply-To: <20250915162848.54282-1-puranjay@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 17 Sep 2025 03:03:47 +0200
X-Gm-Features: AS18NWAzxLEGJEn5tdoP4g4EEMGIfaU5cTyfWPjf5pHHEGboZ5_mCAjRqLqICeM
Message-ID: <CAP01T74rStmtnHhubDx8q0AQ7J4ZYEaX0EO5DZtqUxT-ceT6uw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] Signed loads from Arena
To: Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Sept 2025 at 18:29, Puranjay Mohan <puranjay@kernel.org> wrote:
>
> Changelog:
> v1 -> v2:
> v1: https://lore.kernel.org/bpf/20250509194956.1635207-1-memxor@gmail.com
> - Use bpf_jit_supports_insn. (Alexei)
>
> v2 -> v3:
> v2: https://lore.kernel.org/bpf/20250514175415.2045783-1-memxor@gmail.com/
> - Fix encoding for the generated instructions in x86 JIT (Eduard)
>   The patch in v2 was generating instructions like:
>         42 63 44 20 f8     movslq -0x8(%rax,%r12), %eax
>   This doesn't make sense because movslq outputs a 64-bit result, but
>   the destination register here is set to eax (32-bit). The fix it to
>   set the REX.W bit in the opcode, that means changing
>   EMIT2(add_3mod(0x40, ...)) to EMIT2(add_3mod(0x48, ...))
> - Add arm64 support
> - Add selftests signed laods from arena.
>
> Currently, signed load instructions into arena memory are unsupported.
> The compiler is free to generate these, and on GCC-14 we see a
> corresponding error when it happens. The hurdle in supporting them is
> deciding which unused opcode to use to mark them for the JIT's own
> consumption. After much thinking, it appears 0xc0 / BPF_NOSPEC can be
> combined with load instructions to identify signed arena loads. Use
> this to recognize and JIT them appropriately, and remove the verifier
> side limitation on the program if the JIT supports them.
>
> Kumar Kartikeya Dwivedi (1):
>   bpf, x86: Add support for signed arena loads
>
> Puranjay Mohan (2):
>   bpf, arm64: Add support for signed arena loads

+Cc Xu, could you please ack arm64 bits before we merge this?
Thanks a lot.

>  [...]

