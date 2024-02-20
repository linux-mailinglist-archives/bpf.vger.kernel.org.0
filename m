Return-Path: <bpf+bounces-22347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F4585CA4A
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 22:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5940D282A2E
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 21:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDCF152DED;
	Tue, 20 Feb 2024 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="farweVRn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F245567C72
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 21:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708466349; cv=none; b=HVaKiDBqE6u4r2h1kgbw1GIMX4p7WK+pJx6bP3KOFD9xt3BcY3uombENtc9amBXkE1PTlIIqkYgnaG3imsDZu/elheapBsTBWjefb3tPAHnXEIw+qar/ZPuKDBeWaIk57uyLjjOTj+c0/EZSUI5cli8Xjf82W1XwyevlIKFz7AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708466349; c=relaxed/simple;
	bh=rTH1NriMnDruBNVbTIapzXMvJQA9g8glR0dwMJjAHyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbdQfOpoZQZuiMO/7g7fHMwNaupBHXiFV3yzSdKL7ziKkXVIp5TsH5HIT6Ki5OLDzzhhCc2PGd2DHSMCjeqi/0XNBy8XWZ7XG65FO+VyRrqoPO+XzUDaILJNh/0AkJ+OtQ5UPa94vI34y1mZzuhcbVGLlf+8qTYipU1fuN4GEyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=farweVRn; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-512c4442095so1725036e87.2
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 13:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708466346; x=1709071146; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6IbM4kUGnQiBz43SwMbSLMM4taqbn0jKt1ukxQFY3fc=;
        b=farweVRn7JmKhtKbpMhapgAQR6QJ3Po5Kx3or706wQJxRaOhyUsYpBthdTDKOjontk
         PgdNwl4TbOsxewXvDEYcbrterVf14bpDRQ4rJFwYhKXc9OP624IufifK2OssTNDPo8jL
         DXyavrTHTpcfOiAMUColto6ZKhXJwyXRM+s5nizXqD+9OfNtEkKprsBsbrFZb7XQJ3vk
         0FOAZy3PYfJGob9lDt+UaMsm3/plk+tXM0PapOdBZH+6Ix8eZ4TAkJdI2KUPIUdfjQhD
         zZfQuyKVxo5eGdkeA5QSbbTWuXyMS7ZQbaGRyrLzN7LyPQAivnNc8ONrITI+XcdGp++9
         JZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708466346; x=1709071146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6IbM4kUGnQiBz43SwMbSLMM4taqbn0jKt1ukxQFY3fc=;
        b=sX87GObSPKVUApLDPqKSedD4vOsZuI2qjsex+YUSmXTBH+XWHpmscDHyEnkTwl+xtS
         nQjRvvG9NZGCRm27WbGUw8kTXh0ercGplYzg8/R9b0w67Isj59elUXDzAHN0GTmxDEyJ
         IVU5zRvX+hG5rSncVNBId5hMXfASj+3gXNZvWUr7+rWn72NXybWdFiCNbB1B9/4EUE78
         xz6MaLy1B5g/9uyjPwZhd80kXMPVEO2c+J3++ufz63gC68ownd+Y7aNm1vVRaLsXZNFw
         QJSxL8xVWxvtxsrKj+itfFIToa0BcfmMrYUdM501rNxksVaOxNhJhp7G/eXkVNbkD7qH
         02tw==
X-Gm-Message-State: AOJu0YwIw+URID5FAfbcpscwIk2Mxj8aT4gbLAhc++YTGZEyMzPuSmNq
	DC3gGif4uGmyV80IXfkYJQ1dOzRZ+fRQh03+1/ODcoYrHJItxF0x7UNiXQrXerZXLHx8x8Ry+Ro
	D1yhahuoMTpj3yo170C90zXtnhCU=
X-Google-Smtp-Source: AGHT+IGyjz1X/wwJubclRBTcfY1OaRWdc/CtyNhZ++Uhcj4z9oBNn9hoqs1av0hOlS3MgYqbKAwLnqAt3teH2PbT5y0=
X-Received: by 2002:a05:6512:ba5:b0:512:9863:3a41 with SMTP id
 b37-20020a0565120ba500b0051298633a41mr10365095lfv.45.1708466345826; Tue, 20
 Feb 2024 13:59:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201042109.1150490-1-memxor@gmail.com> <20240201042109.1150490-6-memxor@gmail.com>
 <ff88196b95f3f05e8fa2172c101cb29a55a9c3f2.camel@gmail.com>
 <4ef073e2cf3f5b3c7094e81593001ff068ee9f64.camel@gmail.com>
 <CAP01T754eL=NRWDk-Q-YsV9uWa1pkYaeXvjzy1SWG+A1HjQDsA@mail.gmail.com> <d047300b335b962d660b809e18bac0b3213ce187.camel@gmail.com>
In-Reply-To: <d047300b335b962d660b809e18bac0b3213ce187.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 20 Feb 2024 22:58:29 +0100
Message-ID: <CAP01T74Nj1ka-QCTiOe23K6LHtGt8oLzF=8U9_3iNYruqbUgog@mail.gmail.com>
Subject: Re: [RFC PATCH v1 05/14] bpf: Implement BPF exception frame
 descriptor generation
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>, 
	Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>, Rishabh Iyer <rishabh.iyer@epfl.ch>, 
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 18:14, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Fri, 2024-02-16 at 23:06 +0100, Kumar Kartikeya Dwivedi wrote:
> [...]
>
> > I will add tests to exercise these cases, but the idea for STACK_ZERO
> > was to treat it as if we had a NULL value in that stack slot, thus
> > allowing merging with other resource pointers. Sometimes when NULL
> > initializing something, it can be marked as STACK_ZERO in the verifier
> > state. Therefore, we would prefer to treat it same as the case where a
> > scalar reg known to be zero is spilled to the stack (that is what we
> > do by using a fake struct bpf_reg_state).
>
> Agree that it is useful to merge 0/NULL/STACK_ZERO with PTR_TO_SOMETHING.
> What I meant is that merging with 0 is a noop and there is no need to
> add a new fd entry. However, I missed the following check:
>
> + static int gen_exception_frame_desc_reg_entry(struct bpf_verifier_env *env, struct bpf_reg_state *reg, int off, int frameno)
> + {
> +       struct bpf_frame_desc_reg_entry fd = {};
> +
> +       if ((!reg->ref_obj_id && reg->type != NOT_INIT) || reg->type == SCALAR_VALUE)
> +               return 0;
>
> So, the intent is to skip adding fd entry if register has scalar type, right?
> I tried the following test case:
>
> SEC("?tc")
> __success
> int test(struct __sk_buff *ctx)
> {
>     asm volatile (
>        "r7 = *(u32 *)(r1 + 0);          \
>         r1 = %[ringbuf] ll;             \
>         r2 = 8;                         \
>         r3 = 0;                         \
>         r0 = 0;                         \
>         if r7 > 42 goto +1;             \
>         call %[bpf_ringbuf_reserve];    \
>         *(u64 *)(r10 - 8) = r0;         \
>         r0 = 0;                         \
>         r1 = 0;                         \
>         call bpf_throw;                 \
>     "   :
>         : __imm(bpf_ringbuf_reserve),
>           __imm_addr(ringbuf)
>         : "memory");
>     return 0;
> }
>
> And it adds fp[-8] entry for one branch and skips fp[-8] for the other.
> However, the following test passes as well (note 'r0 = 7'):
>
> SEC("?tc")
> __success
> int same_resource_many_regs(struct __sk_buff *ctx)
> {
>     asm volatile (
>        "r7 = *(u32 *)(r1 + 0);          \
>         r1 = %[ringbuf] ll;             \
>         r2 = 8;                         \
>         r3 = 0;                         \
>         r0 = 7; /* !!! */               \
>         if r7 > 42 goto +1;             \
>         call %[bpf_ringbuf_reserve];    \
>         *(u64 *)(r10 - 8) = r0;         \
>         r0 = 0;                         \
>         r1 = 0;                         \
>         call bpf_throw;                 \
>     "   :
>         : __imm(bpf_ringbuf_reserve),
>           __imm_addr(ringbuf)
>         : "memory");
>     return 0;
> }
>
> Which is probably not correct, as scalar 7 would be used as a
> parameter for ringbuf destructor, right?

I think you are right, we probably need to create an unmergeable slot
in case we find a non-zero scalar value in the stack as well.
I will fix this and add tests as well.

Thanks a lot for your thorough reviews! Really appreciate it.

