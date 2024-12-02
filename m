Return-Path: <bpf+bounces-45915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EECA9DFBF1
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 09:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E857B20FEE
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 08:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA58C1F9AA4;
	Mon,  2 Dec 2024 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFVXQf3V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ACB13635B
	for <bpf@vger.kernel.org>; Mon,  2 Dec 2024 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128378; cv=none; b=QU2YCkDBnf9NoAVdElyY0kfOdyC0hYktYghF5NkmwecmFnenQGfH1lr8A4NCPTJWdqv1Bw4xoqlzdjfLspIk6kJznMUi6LllQkmVP0GGq7YnEtrtDtUTxiT2hgoYpA410ddm7CnyL8FdhxWA7X5Qkh2ciu0vnVeSschwkHDpi8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128378; c=relaxed/simple;
	bh=PzwYJwvRD2wHQ9vAHNrm2iH1pYALq3ur/3Fq4KabDNM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QQw5Aqewhl1HzmV616/sbZmzawxu0llxBb80GDJv3Kg271NKtvaCj3LZW8gqA1+LKdvelQwOxrntOpLVtUAD0F/F128fUElzkNVDKV2d+ExDiuJG7NjZAXbu3twYaKgCWSO0pTaFGb4BEbe6WUc7tJw7ji/b/HQPnw6PjNdOlRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFVXQf3V; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so288025466b.1
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 00:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733128374; x=1733733174; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+UHwHd9NTd4s41zr+5YhFqZCI2x7G4QBHDBUhxWCYDk=;
        b=bFVXQf3ViMKphUXIl7GOLA5ukYscRTXFZnWvw6aCQ8/lPPGDS/PBDKZK3aPeatrDw6
         2MbdRwaS0HKEI0HsyOSGAtPkbAgSBk/YRD3nsKfTC4W9p2lODK9GqCqO2ZgNcYVr05kW
         hV1qfkMMsBaAr0hzmRumdF8m/n82RM3tA9F5FBj4jenBijo70AlgZ2eyKtaPvtDdwQZ/
         vrmIt63/3pBrJCYyCW+xJgW5t3kt4UiZy46fOeWJ7o+/TlZZuCMyKhPZ7Ve4Eo/Au+0L
         EVs+FqiwnlYGvTRZkcjKaAONVwcWweUO5M4APRZW3uvdHGmSAYnG8lziJtZi1Z4uIxmK
         jdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733128374; x=1733733174;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+UHwHd9NTd4s41zr+5YhFqZCI2x7G4QBHDBUhxWCYDk=;
        b=ADjynHkXhf0jSnsiTgc67sDi9bvEoVcvw3HWhUKHI7+EbFL3mrBaKds+F+mo7dB8x9
         Mv9BSZxwr+uTZ2pazPsE6bzwyZbiifJgivzVxZvT+WI3vrknD4KODirNSU87CUv06BdS
         j0+YOlNUmcgPRcaKuyZ8gfwl0yIBbVMQxjykuRYG/EqOuEKyzx1d20pSUatGK7idjmfT
         K5e/9iEruSThjpzHe68HkwHTmXao/somXcHMLne+5FmtgotRUwC4BGzfuxSYOJAhIReh
         ycCcuaY8zRVLgvlQu9N2kpxNuU4VxUyLIWg3Q3Rd9svh+XM+G+zD6FvuUijfoSKd5lTX
         E4FA==
X-Gm-Message-State: AOJu0YwTHZ3DtrcYstuj+hWuegrbSraq4fLYBNSfJYAUOfb/9ps0jJ9p
	/xxjh7f0dYDJJi1/ouipWa3Xh7mdfVqhPTBj1gcV9owi4pcCWlaKHbzSQ1p4ppF9tU0/f2/jLfN
	EcZCuL6Ak2t8zlYm45qQ+DXebqSBaZMpmcEIa8Q==
X-Gm-Gg: ASbGncu7H4DW0CqEbIBwK8kKkexzNEZ/cnFarOu824zu5GC1YKP3hR9iE0WwwL0ko2b
	H8XpXGGyVyEAOoPe2NQWiDvqhs5l7S0HG9uzdxM6VADhe0l+nYMviwHjMT0Aqv0jW
X-Google-Smtp-Source: AGHT+IGWwENYMm0QXhSaXS6RKIQFSxgwpkqKpWUiXT8U4DcBvt2+cXPEimlBBCfHYkM+NXakyL2Yzn/NnZZVg6P5CcE=
X-Received: by 2002:a05:6402:27c9:b0:5d0:f9a0:7c1b with SMTP id
 4fb4d7f45d1cf-5d0f9a07febmr1440914a12.30.1733128374114; Mon, 02 Dec 2024
 00:32:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 2 Dec 2024 09:32:16 +0100
Message-ID: <CAP01T768+4FkNC=nw6qnUP3NqQ3+0G_O+LLbMnyWQpkW100RNg@mail.gmail.com>
Subject: Improve precision loss when doing <8-bytes spill to stack slot?
To: bpf <bpf@vger.kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Mathias Payer <mathias.payer@nebelwelt.net>, 
	Meng Xu <meng.xu.cs@uwaterloo.ca>, Kashyap Sanidhya <sanidhya.kashyap@epfl.ch>, 
	Lyu Tao <tao.lyu@epfl.ch>
Content-Type: text/plain; charset="UTF-8"

Hello,
For the following program,

0: R1=ctx() R10=fp0
; asm volatile ("                                       \ @
verifier_spill_fill.c:19
0: (b7) r1 = 1024                     ; R1_w=1024
1: (63) *(u32 *)(r10 -12) = r1        ; R1_w=1024 R10=fp0 fp-16=mmmm????
2: (61) r1 = *(u32 *)(r10 -12)        ;
R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
R10=fp0 fp-16=mmmm????
3: (95) exit
R0 !read_ok
processed 4 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0

This is a reduced test case from a real world sched-ext scheduler when
a 32-byte array was maintained on the stack to store some values,
whose values were then used in bounds checking. A known constant was
stored in the array and later refilled into a reg to perform a bounds
check, similar to the example above.

Like in the example, the verifier loses precision for the value r1,
i.e. when it is loaded back from the 4-byte aligned stack slot, the
precise value is lost.
For the actual program, this meant that bounds check produced an
error, as after the fill of the u32 from the u32[N] array, the
verifier didn't see the exact value.

I understand why the verifier has to behave this way, since each
spilled bpf_reg_state maps to one stack slot, and the stack slot maps
to an 8-byte region.
My question is whether this is something that people are interested in
improving longer term, or is it better to suggest people to workaround
such cases?

The real code of course can be "fixed" by making the array u64
instead, and using 8-byte values everywhere, but this doubles the
stack usage (which then has other workarounds, like moving the array
to a map etc.).

Thanks for your response.

