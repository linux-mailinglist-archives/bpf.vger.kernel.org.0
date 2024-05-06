Return-Path: <bpf+bounces-28684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 523858BD0D9
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 16:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1516B218E5
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 14:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389981534E5;
	Mon,  6 May 2024 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy85dAs0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD5D381AA
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007425; cv=none; b=l2tdJnbyO6yxOiN7mnpvtjyyB65uCkwOycv2vgBYGdZcYpyfpW0HBlyr9S9xlYE1uff+PIR5vFmGivvrNDVY67M8GU4eY0EnSznvwJce7SWKrAeVUXLs4YDhy9Wn/zeuPBxldGViz0RYadj0IPA8D84g3QEeQjTlH6S8Q3hkfSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007425; c=relaxed/simple;
	bh=z3L1pgC38r/dYDhwRlCAjSbuFavfYq6CD/btEK1IJL8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RinHlf+Vg+qzo/OEb4ABAs0KljU/jIi5GyOXKnhhBTRzjYeEikHPFq5QNblQqcGzC205EqFSKBuVOmQcutkhOMOxziahunGnov/4ORWq2+d8RvmY88MR1GHUw9cZWmg4LTvIb0bnXljOQDkfiQcA4M3L4FbzFnsfHq3OWejrt+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fy85dAs0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41a72f3a20dso13694495e9.0
        for <bpf@vger.kernel.org>; Mon, 06 May 2024 07:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715007422; x=1715612222; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wOiBF2i/qYkVslPSiOCngyhsTabQWfifsM82slbbqRI=;
        b=fy85dAs0TFkYG3EsheCOUbru+9F8YAChZ5evuQ+qbJb3qGvrNUO/gKyaWlVWWQNTKI
         PPes8Tx2ayq+WbcktIjzsFPeHwOy1+T/eaWiij5T8wwUKcf7A48C4z4sFngewmw7f7lk
         kmRo0lLKhaM2p1KvylYMJj0zoOPsk21Fm+tQf7QzpY+cWH0hUF+raE8N6GRQiJwei1NV
         82fMtJ35BbpArNLbWcAUogP8FW6a+GzHIlc+RLUscKLl0o/1GmWvJJQurZ3WykifSuld
         J+kYETDjBNy632mi0seiV+ISmQjtapYLee/igLAIF54ked5gq1syeeOWYsjTUjEsRwGM
         Z5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715007422; x=1715612222;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wOiBF2i/qYkVslPSiOCngyhsTabQWfifsM82slbbqRI=;
        b=LVV6U56ogLcmYnDQQwmid8U1anrlAO5h6CgHa1kHMpCARF52sxqs69+JAjf+omzivR
         Gq10q8271cM7zn/HKBtTY3UB3q3yvHICLKdxf3MfNmqZMzL3YbBbmtMJGvZ4U/C0iAvf
         aiQ56xzHfTd9kAjmXOK1I0aKgwQJuuI0W5KezNIvYWx0Kst9FDPHPvMlEvMxAJUaZV6J
         oZqZ37qEzJcKwxDet31qxCBwLQa/YIuIgZFDD+e0ZJQRgPklm91KAXyeUdiTDxnt22St
         N6Qxm8WNqzG5jmZS22YgahyaLFpzbunGa2QEweL4PnuzgMTn3Sajau55cmRZ+NH9Dv83
         lM3A==
X-Gm-Message-State: AOJu0YwlZtmTvqnRnyZPnvERxwh00eqHYUoqmNLCmYD4cR7Mnbpiq6h2
	Gy+O+D0PqF2/H3+9D/eI78HRkM8CV3KvxGq9Psadjro9+AKcsN7T
X-Google-Smtp-Source: AGHT+IGjlzeg1ZJxiNbmyj/wJ+T8MsSeLJdEHCmkTdnJvKqX0r/3odeA0QT0dez3DSsKmw9iwpFr5Q==
X-Received: by 2002:a05:600c:1d9c:b0:41b:dafe:ff78 with SMTP id p28-20020a05600c1d9c00b0041bdafeff78mr7319458wms.20.1715007422240;
        Mon, 06 May 2024 07:57:02 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id fc16-20020a05600c525000b00418d68df226sm20107903wmb.0.2024.05.06.07.57.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2024 07:57:01 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH bpf-next] s390/bpf: Fully order atomic "add", "and",
 "or" and "xor"
In-Reply-To: <20240506141649.50845-1-iii@linux.ibm.com>
References: <20240506141649.50845-1-iii@linux.ibm.com>
Date: Mon, 06 May 2024 14:56:59 +0000
Message-ID: <mb61pa5l30z0k.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> BPF_ATOMIC_OP() macro documentation states that "BPF_ADD | BPF_FETCH"
> should be the same as atomic_fetch_add(), which is currently not the
> case on s390x: the synchronization instruction "bcr 14,0" is missing.
>
> This should not be a problem in practice, because s390x is allowed to
> reorder only stores with subsequent fetches from different addresses.
> Still, just to be on the safe side, and also for consistency, emit the
> synchronization instruction.
>
> Note that it's not required to do this for BPF_XCHG and BPF_CMPXCHG,
> because COMPARE AND SWAP performs serialization itself.
>
> Fixes: ba3b86b9cef0 ("s390/bpf: Implement new atomic ops")
> Reported-by: Puranjay Mohan <puranjay12@gmail.com>
> Closes: https://lore.kernel.org/bpf/mb61p34qvq3wf.fsf@kernel.org/
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/net/bpf_jit_comp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> index fa2f824e3b06..a0dfb3f665ab 100644
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c
> @@ -1427,6 +1427,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
>  	EMIT6_DISP_LH(0xeb000000, is32 ? (op32) : (op64),		\
>  		      (insn->imm & BPF_FETCH) ? src_reg : REG_W0,	\
>  		      src_reg, dst_reg, off);				\
> +	/* bcr 14,0 - see atomic_fetch_{add,and,or,xor}() */		\
> +	_EMIT2(0x07e0);							\

Shouldn't this be:

        /* bcr 14,0 - see atomic_fetch_{add,and,or,xor}() */ 
        if (insn->imm & BPF_FETCH)
                _EMIT2(0x07e0); 

The barrier is only needed for the BPF_FETCH varient and I am assuming
that the barrier has some overhead. So we should not emit it for all
operations.


Thanks,
Puranjay

