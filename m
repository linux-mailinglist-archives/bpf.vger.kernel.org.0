Return-Path: <bpf+bounces-51940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47279A3BF56
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 14:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49A3189A22F
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 13:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF021E834B;
	Wed, 19 Feb 2025 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAlauonR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736852862BB
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969855; cv=none; b=Bky7XoZUgV+WBoyRWkAmFKE0m0GXCF8X2hmlUKmjnW1HDiRBIslv/7PlorEAaT+0Nb2CKmjRTpE+28YCrEGwfwtsoTSHZAQQlfsrl3v/IX0MuxeEXpg4eVC4JvZgKvoNDufS0NYb7t8loo14FJQrZtTTUUHb/F/6sR6QKkyA3+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969855; c=relaxed/simple;
	bh=pBfWiZvx8qYm2fdvdvM6o4636PJ3aQNmfPYuy5trZFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/w3QCfui1aE5re2pnRHFyBgAGtCCVTKhHweVBXIj72fSoNc97AcGuvx77bvLTj/xe+PkrqvH8xbppx/CgrcAjKMREy4EaYX/XVeRATekwCjEue1o/yWF2lK1dNhfqk0QHLnMu061w7+QuFe2ZV9tQY/CCRhf2NVVPE7vRO+HC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAlauonR; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5e04064af07so7801727a12.0
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 04:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969851; x=1740574651; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pBfWiZvx8qYm2fdvdvM6o4636PJ3aQNmfPYuy5trZFI=;
        b=IAlauonRNA9uG5VvxZbqQwserWsPnmTEVsWLYAXenGyPFfZLRm8VlOjvHTDbtV4kdd
         HFFxAjGxM07OTWsAL/AggtoiNyaEg4cn5QQTRfIaofgJHKnDEEoSZh4pDMWlO4JNon+N
         Pshk7XXYkBRMnkMxhAXjy8WNevsxsVc1yE6CrP79nB1ZA5yV8oz5V7Mw9jbJk/3zlAKQ
         hwyTKGwfy4uHN40lEbtRqj1jV7qABeaNP78fH/rNn+wEk5G7A2SoH0xStPWWWlMBvV3Y
         7dJLlfZ0yCS76hNElmwQCidmAEROIGF/vKjpKJxf1LK+1jb/VEl2kEU8R0nHvcXgwAVV
         eGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969851; x=1740574651;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBfWiZvx8qYm2fdvdvM6o4636PJ3aQNmfPYuy5trZFI=;
        b=FdT2IZQZ15nRYLiSiaUk+mW01D2tir14AsXaJOxWl0YXNCYbh72n21GcJBuGrq3V/r
         nfxpAHrKUH1qN9Gps/SBjaBA3auQhGjTZKktM2cWgurxb56TRCBkxkv4QDPqHXC7mVVx
         PdOxwxbrGSKq0HHPJxLuJqEFjtWbezoVSPGdmoNyUJXyydVust7siiGgzfP0E1Z3auaS
         GAzIoMzGIjMswN54Lgplc1gURil+3lhV3S/iHQIQOXJz8nnqiGDwhDa4cCVYWTO9Snug
         NvQM1vrKjYOG41koVGu/2pXmEUB8Hhk3yZdbFFwTtn6Y2IW2T2c8h1FINjK2bCCmevd+
         KtIQ==
X-Gm-Message-State: AOJu0YwPTa0J9l0V/qmxfZkIDgFaSudwXv6WpcikYWaRXKQzzOkmmKOm
	spy33SRQvMW9wr2ehrbN9XEqrFwusRARnJ8o8hTf3ewZuqQiNL+T19rZWbBVNkwkVjBfVnfBKmx
	AH3GNUjFHiE43KpNB75410xyVaQMQdDtXuSs=
X-Gm-Gg: ASbGncvzRIIpeF+4TKtJ+KAkNfW7uVfGiQnOPf/RmQpfAocKXTB4gVL1DJRCs1EDT7M
	b2j1AkCdg5FjgWBQIYYlNNUvOFX/UzqfWCfGbizc8Mey1iUAErcLKFIIR1t6tok8HdSz2RQWdNO
	jxCevOu8c14deCQUG+Pw==
X-Google-Smtp-Source: AGHT+IEgzmXADBnE3b8fUo+yf+TKGlV8JnFxmooY86PSleQtE2aoxX9zb80TIHkEk21Yww/MrYA6jXyqy95AYImWhIY=
X-Received: by 2002:a05:6402:35cb:b0:5e0:8c35:a137 with SMTP id
 4fb4d7f45d1cf-5e08c35a494mr2044091a12.23.1739969851301; Wed, 19 Feb 2025
 04:57:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219125117.1956939-1-memxor@gmail.com> <20250219125117.1956939-2-memxor@gmail.com>
In-Reply-To: <20250219125117.1956939-2-memxor@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 19 Feb 2025 13:56:54 +0100
X-Gm-Features: AWEUYZnZo3KIYRieFoVJ7m_933lL51zkIY-AXcgJ1_eI2BRWCU21Nf0w0_zpQtM
Message-ID: <CAP01T76aV+2Y-U79Csf4+-scG92jc2ZwJUhDC1MQcx1ZJ4vwkw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 1/2] bpf: Explore PTR_TO_STACK as R0 for bpf_dynptr_slice_rdwr
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Feb 2025 at 13:51, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> For the bpf_dynptr_slice_rdwr kfunc, the verifier may return a pointer
> to the underlying packet (if the requested slice is linear), or copy out
> the data to the buffer passed into the kfunc. The verifier performs
> symbolic execution assuming the returned value is a PTR_TO_MEM of a
> certain size (passed into the kfunc), and ensures reads and writes are
> within bounds.
>
> A complication arises when the passed in buffer is a stack pointer. The
> returned pointer may be used to perform writes (unlike bpf_dynptr_slice),
> but the verifier will be unaware of which stack slots such writes may
> end up overwriting. As such, a program may end up overwriting stack data
> (such as spilled pointers) through such return values by accident, which
> may cause undefined behavior.
>
> Fix this by exploring an additional path whenever the passed in argument
> is a PTR_TO_STACK, and explore a path where the returned buffer is the
> same as this stack pointer. This allows us to ensure that the program
> doesn't introduce unsafe behavior when this condition is triggered at
> runtime.
>
> The push_stack() call is performed after kfunc processing is over,
> simply fixing up the return type to PTR_TO_STACK with proper frameno,
> off, and var_off.

I just sent this out to have discussion with code and context (in selftest).

The current approach has two problems:
It fails xdp_dynptr selftest with misaligned stack access (-72+30 =
42) size 4 error.
This was happening before as well, but is surfaced because we see
writes to the stack.

It also leads to veristat regression (+80-100% in states) in two selftests.

We probably want to avoid doing push_stack due to the states increase,
and instead mark the stack slot instead whenever the returned
PTR_TO_MEM is used for writing, but we'll have to keep remarking
whenever writes happen, so it requires stashing some stack slot state
in the register.
The other option is invalidating the returned PTR_TO_MEM when the
buffer on the stack is written to (i.e. the stack location gets
reused).

