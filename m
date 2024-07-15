Return-Path: <bpf+bounces-34800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B4E930FA6
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 10:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D15F28121E
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 08:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B763724B5B;
	Mon, 15 Jul 2024 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYvu4pSs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3B61849D7;
	Mon, 15 Jul 2024 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721031923; cv=none; b=ThWdVjDZCM2epwpEh5Y/UPd5LEwpuPbdMmv8PIjxOLvmzLdSgmNfrL/JIXGPanGYD69LBPS7NZXOAgV2GJc63RfskODImIiR0UjO0WXV5uXsn2KB8u796uHg7RdVumzAmD7F2R2EEsWK/DPgnYUJhh/shEdjFClhm5qU8nWhTxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721031923; c=relaxed/simple;
	bh=sYTa3WNcV2F8VcxAC4M8JpZN4WhbxWbON/EkXLJ5Ojc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ewN21EMMj0YyR2Hld5ylURhtoFqVtkSsl7K7SH9WAfw+RBKh0MNmkzhUMFE8ZDD2NgLt1IDEAUB6fnyq2KNg6t5JWf4FvfuJs5e85s1nBoGqCogJ0cYADPOWyESKrv66LhTxDtJhRPehQArKnd5g1lgTKxme92Gmhs0L/FWp/Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYvu4pSs; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7f6e9662880so185054239f.2;
        Mon, 15 Jul 2024 01:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721031921; x=1721636721; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rW2thNGYkRyZe8HIPJ8rpQcN6uYkUSeuH9TVqbqQqOM=;
        b=GYvu4pSsyqgoKAFf6PcsNfdojmRklpIlh+GywOkhChVFcqRWHaDGJT4hi/lTOL6GXF
         gKe99qYxtO6d+Ui4JF2Z+vrEYAB5rz2FowVZOb2Bp75YV5VuCcEHHf/zEoGky1WTOHcb
         2lZ/Xw2e5CA4FXgBAqoSmYQJAo3L3x+Q0oy1MNnUk7dCPczF8IlsFnA/PhyP5vhCbuAf
         9hqhg/MgUrnPMT2Ra/8AWX8M3Vr8hMuex7OvkhPaXHktiImv+Yh2ls45v+cjJPDdNWHw
         U1B95XlYUhmP6ouS+dYYoGxIlSZf+sDtdCEjVTLKHKH6/3uLTcYlsKArSS2jL/37KB6s
         xFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721031921; x=1721636721;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rW2thNGYkRyZe8HIPJ8rpQcN6uYkUSeuH9TVqbqQqOM=;
        b=famRvm+cqMhxTUp5LxtLu9m7fldyK+05h2eDzBm8r4fcD6MbNsoVyvJ6plzMp8ny1R
         718KSHQLzPNQO2ggA7gMg/xZOWtKQlq6aDiSISMr+X3Gq3nRsfSTOFY76T8M/waum2wB
         x2SQ0geN2C+iaAqyKVIyzJgaDyzS32imn0GpXLHY6c6fLTcmz1GeniKuVZ2T2rmMDN4v
         UbaS5cEcaX7NokAogTD7gOW3tK5SlhHc3IbpQaMSdB1TGi+PNTxBWrUZjOkE8Zafofap
         eOMSvbaJeRu5DHXTXxY3wWQwNfwzrOJdizWYbrO/zf1uF9vQjekpGY7aSaz/ZDA8P6Lw
         yzCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjxBYJf/KOwQetoqgEGyvQofQSn4Ha0Glw99HAqoeiqb+QaPWEaqkDuJw59HJg5ORfcQKXFzkwk+1MUVeRv4oqHm4V851IOTlu3q6+YTnkE8EC/gkLCapouSh11N2txJQsqRUadbTxoeWqu5+iU01aBBOZ7EdlJB8WJ4GVSySH7Ys447pGADr8PzidOnt/EXlmEFCU/sI7VHpmuoPcfq/pmk+V
X-Gm-Message-State: AOJu0YzgG5hEpn1eqm3ECohbOYynB+VzW+odwA21TXZgfrEVxfgT0Ni/
	WclQ/LTEHwCUr4TrR390iMyGinv8NYuBiwQR6UedJ2Y3vWNe/teh
X-Google-Smtp-Source: AGHT+IEJOtY6h6sgqUX2Zqpq7jO4aSc5SbNrF10Bl+Cu1roWxg+N/2mw68X1fDSEsPnU5o1cPk9G6A==
X-Received: by 2002:a6b:db0d:0:b0:805:e2bf:f303 with SMTP id ca18e2360f4ac-805e2bff70emr1391622039f.8.1721031920882;
        Mon, 15 Jul 2024 01:25:20 -0700 (PDT)
Received: from localhost ([1.146.120.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7eed2sm3770443b3a.116.2024.07.15.01.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 01:25:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jul 2024 18:25:10 +1000
Message-Id: <D2PYW90LRVAY.3PCE9P3NE2NEB@gmail.com>
Cc: "Michael Ellerman" <mpe@ellerman.id.au>, "Christophe Leroy"
 <christophe.leroy@csgroup.eu>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, "Mark Rutland"
 <mark.rutland@arm.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>, "Hari Bathini"
 <hbathini@linux.ibm.com>, "Mahesh Salgaonkar" <mahesh@linux.ibm.com>,
 "Vishal Chourasia" <vishalc@linux.ibm.com>
Subject: Re: [RFC PATCH v4 12/17] powerpc64/ftrace: Move ftrace sequence out
 of line
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Naveen N Rao" <naveen@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <cover.1720942106.git.naveen@kernel.org>
 <9cf2cdddba74ec167ae1af5ec189bba8f704fb51.1720942106.git.naveen@kernel.org>
In-Reply-To: <9cf2cdddba74ec167ae1af5ec189bba8f704fb51.1720942106.git.naveen@kernel.org>

On Sun Jul 14, 2024 at 6:27 PM AEST, Naveen N Rao wrote:
> Function profile sequence on powerpc includes two instructions at the
> beginning of each function:
> 	mflr	r0
> 	bl	ftrace_caller
>
> The call to ftrace_caller() gets nop'ed out during kernel boot and is
> patched in when ftrace is enabled.
>
> Given the sequence, we cannot return from ftrace_caller with 'blr' as we
> need to keep LR and r0 intact. This results in link stack (return
> address predictor) imbalance when ftrace is enabled. To address that, we
> would like to use a three instruction sequence:
> 	mflr	r0
> 	bl	ftrace_caller
> 	mtlr	r0
>
> Further more, to support DYNAMIC_FTRACE_WITH_CALL_OPS, we need to
> reserve two instruction slots before the function. This results in a
> total of five instruction slots to be reserved for ftrace use on each
> function that is traced.
>
> Move the function profile sequence out-of-line to minimize its impact.
> To do this, we reserve a single nop at function entry using
> -fpatchable-function-entry=3D1 and add a pass on vmlinux.o to determine
> the total number of functions that can be traced. This is then used to
> generate a .S file reserving the appropriate amount of space for use as
> ftrace stubs, which is built and linked into vmlinux.

These are all going into .tramp.ftrace.text AFAIKS? Should that be
moved after some of the other text in the linker script then if it
could get quite large? sched and lock and other things should be
closer to the rest of text and hot code.

Thanks,
Nick

