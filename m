Return-Path: <bpf+bounces-74090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C30D2C48064
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 17:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FD8A4F6229
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 16:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3732428003A;
	Mon, 10 Nov 2025 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFzqDuqB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F2B26E6F7
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792364; cv=none; b=ZSLfBZNLyKDpFodNRbDOk6YQ8DxPLUqo/PJQvbnuSAtRAREiF0KiYpRvQ1skgDqtEiJoP7hHEUNOSsaDXCw6EQbW4ROPcGGVLbBS6gddE3kDRPt0CEF1W8l6vkDLJV1EjCvqz71JcSvjlXmw8oBmJktYvcNydjMr/yjMXsYI5JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792364; c=relaxed/simple;
	bh=2EZi6jKwgm9I2wh6xZdb5ldE7GJF25G3X3fcAOG3YPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g69Pua/YPaVhR+Zi+ZHPYe/5t51qjtb2LHRiwi4sbySESVJdWO4dr/mDkBig4u1YAwU08UDMOJt7vdfmu4K4hdaDfg0dNiHkamrLyS6re1Haahtu7R1uU+KoiPm3IlSeGjvijmf4GVAiQuJCpQl9KKZU0TWBccdbeaXjMZJrK0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFzqDuqB; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b3c965df5so574046f8f.1
        for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 08:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792361; x=1763397161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EZi6jKwgm9I2wh6xZdb5ldE7GJF25G3X3fcAOG3YPg=;
        b=KFzqDuqBGcQym1zjkunveCl/qENOHmwxIGYbhdtWfwJXbyKuuVdQPExYff7s1x3VgS
         Ks1POVmraO5hzCN55lGSdQB4tiKb43hqLUwKXs+V9SO2BikoXqwSp14AlQZz5Y2tC1gh
         5dovYPV7L7Hsp96kUy1wB7Fl5CUL5JXJl2WR/W4aRwk8hDXgujhHOAnGmxHRXej7Q4tM
         7s9WEDnYuZyTH6RLlRFj6yFBb71wejKl7hkRNb/Gwfk9+obrYoUlFragSVe8dOelOGJA
         nv5wiJ7OwCaqfCwGvxCY1rkmsWWXIoHjLI/NAf7Bl5weA8QF+1ATILxR0OtNnY1RbVbW
         jx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792361; x=1763397161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2EZi6jKwgm9I2wh6xZdb5ldE7GJF25G3X3fcAOG3YPg=;
        b=WfPG+t3ofhafOtvPeW/yUBMW1fNQzTB7fr/cO3Q4adMaVKJbfw2ZjEiI8FPDRDLdMm
         9x8iPQrnpZt44ZpGrkQeSikF+nXxUYrm9T7fJvq213TEVhIlqEGdDC+D5iERPKRYDWpu
         Cx2bAg9wBc7QpgKGvIrDD/SKWQTRdVWv60me0Ek+5P6sWz7KUbraUubsQJLRhaIJP3Fk
         mGAsTsIs5JP7BIZzyfqcAFpST779AUr4dIOXCsOevyMtjSI+iwzG3elfeoYa/beBdEii
         WnMu50pPH7tAFDMZRO7CdHsg+TgTTosL5HdnL0BsChiJ3xlPj5UF7nvg1OY1TxKJdYw8
         Tjhw==
X-Forwarded-Encrypted: i=1; AJvYcCUF6el5nlUljcrth2eBk9wwVRuGR001ZeHRl2XPu/EMA+P9XBZ/YuEU+IDvnPbXTuBpuIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDr1XhQD0NRPeBy1l+BgfKJenf52uG2VB46ef6LmtDNUqzl8Ed
	ZqpsoIbOIIMBriTwctV0zlQdg/ueaENU80Dtq/nmO8CgRSWbAOPthvYOn0ZcDujKMkszUEAwrwm
	2OasP9cjNVnKWWT0vIAEnQ48mHIrFrXk=
X-Gm-Gg: ASbGnctQEqdXES4Ats4dkAolD3QKez+T9FmYinssKLd76tR8LoOdGAkrFSiubWZXdG5
	R+ilGKzb5cqgW/nqMH8bm2Urr1629Fss1Guwthgxepk7XLpv9FRf+KUJFBoTD911xu7sBhoApIO
	5zsdikMQArBqhd0wzuCgID8IjHfQxRkMnG4YrOJfAxAieNofF+jPjGLwNGh95FuRBrpn7RyQiCB
	rHuD8ULG/9N/btGpEsn3Lpfpu9AirW5E9LmV2jNRU2f68GQwmSsNm360kEzKvyTTEH9EWJFtP23
X-Google-Smtp-Source: AGHT+IESaTzl2YjaPic/68VsYA9tLWSz9buPfpL2rLQvUoP21k+abXTvq24TsJrQA1TS5C/2kdb5XjyMjjTGgVQvWV0=
X-Received: by 2002:a05:6000:1888:b0:42b:40b5:e64c with SMTP id
 ffacd0b85a97d-42b40b5e9dfmr1641240f8f.30.1762792361129; Mon, 10 Nov 2025
 08:32:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104104913.689439-1-dongml2@chinatelecom.cn>
 <2388519.ElGaqSPkdT@7950hx> <CAADnVQ+tUO_BJV8w1aPLiY50p7F+uk0GCWFgH0k5zLQBqAif1g@mail.gmail.com>
 <13884259.uLZWGnKmhe@7950hx>
In-Reply-To: <13884259.uLZWGnKmhe@7950hx>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Nov 2025 08:32:29 -0800
X-Gm-Features: AWmQ_blde-Om93LZ8uH2LbpRe5eXO2GqX0LA_EpxNj-rGvCG6KH_W84-SJVDMLg
Message-ID: <CAADnVQKQ2Pqhb9wNjRuEP5AoGc6-MfLhQLD++gQPf3VB_rV+fQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf,x86: do RSB balance for trampoline
To: Menglong Dong <menglong.dong@linux.dev>
Cc: sjenning@redhat.com, Peter Zijlstra <peterz@infradead.org>, 
	Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, jiang.biao@linux.dev, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 3:43=E2=80=AFAM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
>
> Do you think if it is worth to implement the livepatch with
> bpf trampoline by introduce the CONFIG_LIVEPATCH_BPF?
> It's easy to achieve it, I have a POC for it, and the performance
> of the livepatch increase from 99M/s to 200M/s according to
> my bench testing.

what do you mean exactly?
I don't want to add more complexity to bpf trampoline.
Improve current livepatching logic ? jmp vs call isn't special.

> The results above is tested with return-trunk disabled. With the
> return-trunk enabled, the performance decrease from 58M/s to
> 52M/s. The main performance improvement comes from the RSB,
> and the return-trunk will always break the RSB, which makes it has
> no improvement. The calling to per-cpu-ref get and put make
> the bpf trampoline based livepatch has a worse performance
> than ftrace based.
>
> Thanks!
> Menglong Dong
>
> >
>
>
>
>

