Return-Path: <bpf+bounces-77652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBD4CECA36
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 23:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A06653013391
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 22:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E128430C60B;
	Wed, 31 Dec 2025 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caeSvVUc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47C150276
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 22:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767220962; cv=none; b=SBsWswm7n6U3TRzlgaE8/cyZMpvokQjVVjryuOOakG3u0zopsjzT6x0GmkOtKUltmw8qGQ9gqVNOVYBSyhJExNTa1cBrATJJBAKQDBtYoBM3bP+blT9+5o/Y3UtEt6q6kQkR6eVUnW3C4mYfro6/BkWy2vcWSDYlKUxRSViG4ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767220962; c=relaxed/simple;
	bh=T4K8zxFsKyFqXvkWNU3hF4Ct3+tZ0Ex3que5nmjgQcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pebjnYIubemQTXHKLQpiHZ6edc4Ncwn7bKjkb0/E9o1nGzYJrdH0idw9dDfIDfIESD7Ocrn4ncN0hk/Od28b3qpIXmrm+S5xoh3sNDyWVzR0TXb9M1ha1fDqPgjzmovatdJ1hNO5N+gjWBdn1J80oLLbIdAtOxCvzYVL5M4R5fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caeSvVUc; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b713c7096f9so1751353966b.3
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 14:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767220959; x=1767825759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7xVQ7sNKtOHvlX/ACB0QZttaDOgoyezL9G8wLVJ3nY=;
        b=caeSvVUcyx3odDbmETbW6cRRNH2Rhso9NbTe50s5Z+WUOg9Gil5tiQ/isyJBhKifMT
         WEqhAy1+zxVrubfKO2DDA4eVI5XAHnU/7Vn2j1Yf4VjxiJguqE307yVQbTxMUHV9skHf
         94fd8E5On02ucFgOgTfDpDoqp2dQmd/5WuzgbP0QK53e1plokw8/TppZ8GcMgjGPV+hw
         zyiS/JRGmJZWz2THiIUXCTOURk/FJsB/Yq5pax0sfG5Dwni6JH9IKj+MzO1L4ttaOUFN
         w/27edGCCo17YwODMUSPu4cT46f9gfsrhAoz+1Jz6WDtI32XbocZ4FNkvSliMh/QjJ2g
         PudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767220959; x=1767825759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t7xVQ7sNKtOHvlX/ACB0QZttaDOgoyezL9G8wLVJ3nY=;
        b=viFQ0/7IVLqI2sIXVr6uDILzNKmkTdSVuqREw7AELbeLKzjAzpgbilLDx4rfWAZcgQ
         L3lRj/Z1xD3TjYvAVn3Mx8Bmi2yM1fiKlX9+HV3B4kHtEUiShRa8ni/bF94OU12o1Z1c
         YY+u/B5FnsOyTW5NifP4+nIBwMIeIR7+7Yr+PAOxwL/riiSvwn6pp25WdYYy1ER/9Zka
         Oxtlwyulaic0JUUaor3DnPHlIVjBDaUhlcpkEiP5gmt9fd1a6XcOXiKG0gWPz936Y0IA
         LFvBOjkpQt1iR48HUTG9ZS7y9S7Rs9LpBslgbw7z6N3XYqu9+6+lS5nJac9afeqG1q5W
         bhog==
X-Forwarded-Encrypted: i=1; AJvYcCVaNPjhX2zY1GDGEMxNNQGZM5/tZpVu829v7+cZBOhHnQp8AfMOtaYR+jUEbmAuzbl/uNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfEGaIKwm20M/l6LjjRDNDPa3y9eDmhaggbLRryfK4k/TdtBu+
	E8ndaM7Ib+wNhxWrb2A1D44ggqxmjuvpM0vJyj6XxgEGO56vXGRPHEiN4MWfNR7TfnXfmtKZHES
	C5DwdbQ1SzwgBY6wl/OtP12GufyfnDtQ=
X-Gm-Gg: AY/fxX52lj6D2jCXF5KIPJicen0maigGvA5BK2DFp9Be0gFdhX9hV/LkwwydmXiDWZP
	3Z1ElZy+fkTq3990XfUFQjnHmsA+AKlclVywNlgJCwQK8yBfsvt2TIm12tfiFfXpCFzpMgF3dyv
	s9isMXRJOkmS9/RkgKcNb7qjfzhydfOyiV+yYPsrmSGVzgYQezYKOMSKO3tZqeYZruUk7JxvJt1
	crnfnLBdSThKdr+u8g7WRv2qDx6XFGe7SrRSIcf6HYoRR0NwhO1ffRdcEVcyRUCol//ceQTH1dZ
	O/FwZ2YS6sk=
X-Google-Smtp-Source: AGHT+IExKbX98blDwKPhRoTaq6xKYXuuZ2J00I0SGao762cZ8gqwMwp7qeHTTu0w+qZQC+0BZGfaU+rPoIfwg0IFTzc=
X-Received: by 2002:a17:907:6ea7:b0:b80:f2e:6eb with SMTP id
 a640c23a62f3a-b8036f2ab4emr3898324266b.21.1767220958962; Wed, 31 Dec 2025
 14:42:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251227081033.240336-1-xukuohai@huaweicloud.com> <ce484a55ffa709dcfcacd631213b3b1ff1938c7a.camel@gmail.com>
In-Reply-To: <ce484a55ffa709dcfcacd631213b3b1ff1938c7a.camel@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 31 Dec 2025 22:42:27 +0000
X-Gm-Features: AQt7F2rvlMWseabyaxfs4v4wv8iqXWtzlDxehCqfM33d2M-QCN-QHXtbpaO_m48
Message-ID: <CANk7y0jR9Ttt6QKhg=iZshs4j=7GZbDXYBgf0iUqkvhWqpQxEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: arm64: Fix panic due to missing BTI at
 indirect jump targets
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 10:35=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Sat, 2025-12-27 at 16:10 +0800, Xu Kuohai wrote:
> > From: Xu Kuohai <xukuohai@huawei.com>
> >
> > When BTI is enabled, the indirect jump selftest triggers BTI exception:
> >
> > Internal error: Oops - BTI: 0000000036000003 [#1]  SMP
> > ...
> > Call trace:
> >  bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x54/0xf8 (P)
> >  bpf_prog_run_pin_on_cpu+0x140/0x464
> >  bpf_prog_test_run_syscall+0x274/0x3ac
> >  bpf_prog_test_run+0x224/0x2b0
> >  __sys_bpf+0x4cc/0x5c8
> >  __arm64_sys_bpf+0x7c/0x94
> >  invoke_syscall+0x78/0x20c
> >  el0_svc_common+0x11c/0x1c0
> >  do_el0_svc+0x48/0x58
> >  el0_svc+0x54/0x19c
> >  el0t_64_sync_handler+0x84/0x12c
> >  el0t_64_sync+0x198/0x19c
> >
> > This happens because no BTI instruction is generated by the JIT for
> > indirect jump targets.
> >
> > Fix it by emitting BTI instruction for every possible indirect jump
> > targets when BTI is enabled. The targets are identified by traversing
> > all instruction arrays of jump table type used by the BPF program,
> > since indirect jump targets can only be read from instruction arrays
> > of jump table type.
> >
> > Fixes: f4a66cf1cb14 ("bpf: arm64: Add support for indirect jumps")
> > Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> > ---
> > v3:
> > - Get rid of unnecessary enum definition (Yonghong Song, Anton Protopop=
ov)
> >
> > v2: https://lore.kernel.org/bpf/20251223085447.139301-1-xukuohai@huawei=
cloud.com/
> > - Exclude instruction arrays not used for indirect jumps (Anton Protopo=
pov)
> >
> > v1: https://lore.kernel.org/bpf/20251127140318.3944249-1-xukuohai@huawe=
icloud.com/
> > ---
>
> Hi Xu, Anton, Alexei,
>
> Sorry, I'm a bit late to the discussion, ignored this patch-set
> because of the "arm64" tag.
>
> What you are fixing here for arm64 will be an issue for x86 with CFI
> as well, right?

Yes, I just realized this would be a problem for x86 as well where
endbr64 would be needed in place of BTI

>
> If that is the case, I think that we should fix this in a "generic"
> way from the start. What do you think about the following:
> - add a field 'bool indirect_jmp_target' to 'struct bpf_insn_aux_data'
> - set this field to true for each jump target inspected by the
>   verifier.c:check_indirect_jump()
> - use this field in the jit to decide if to emit BTI instruction.
>
> Seems a bit simpler than what is discussed in this patch-set.
> Wdyt?
>
> [...]

