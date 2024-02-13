Return-Path: <bpf+bounces-21844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A8885310A
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 13:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E40028A532
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 12:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9EA4EB43;
	Tue, 13 Feb 2024 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lodjaTz+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C33482CA;
	Tue, 13 Feb 2024 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829125; cv=none; b=XIuT/Xpenle8X1ZehEYutsleS/mZOhHud5WlknYijO03LpxBZC5PKK+0ATktcJVcFYQFh0DdW3/2u2xVCufGT8oEl05jJ7Ui+4CaGgXEScxsxessjqvr1JHI0eUAo7cPErYXLOUTdvs2GTIg5Bw6aLBNYwy1XpwrAbO79BstiD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829125; c=relaxed/simple;
	bh=umx89uCbZMhhKzQRBvjpXYMdKTEly2WVpnghTGFsbPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgvnZmP1oUJw4P0zCn6CIFqMAZjKJwvYMQqmMyfKbMWmGCZVx7rqfM6itpDHoaFxuSt7NbonXUFkVLuD/excmlFHXDvLb0qXP7/EOZ/WwegO0gind3sOnxXt153MJ6SA9hoyx7yv7P6/2ONC2wD1VC1YeEJFuWqXacKvqnZBnV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lodjaTz+; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3d002bc6f7so66002266b.3;
        Tue, 13 Feb 2024 04:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707829122; x=1708433922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g4agJ1A7KZIyEQouGbFZaSxgaZc9xYgjCUppDYmRrYw=;
        b=lodjaTz+ughA3q7ZV2t6Vnc/KHKQ6y/4GX2Bd0cphMtrjhg3j+ZWN8FAi+iGRlJZGS
         dJJKx17mahhSj5NjSHNi1SoOIZmUrWEA2je+27SRgpNnOoBmcyw5ayDJ68V0f5ZEuLgx
         /naDUB/vPJ7LwRqbbJ1l2TTr3eHdkpGCfkh+TEkQAYNHEjT+vhHsGrO6jlLtaN4J1SAU
         3xB5KRnQS/jApGmaH2uvh9Ry5po60R/qj8cyxLlPGiWWOxDqEE8uT2hsvfHhKM8EjV4C
         odiDovP/U2MeKHDKLBuNPCA6IapQTyk6L0x2u+h4rOlBNLJBGmSr2XJ91xuxhc7riMGr
         GcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707829122; x=1708433922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4agJ1A7KZIyEQouGbFZaSxgaZc9xYgjCUppDYmRrYw=;
        b=GNZfS/+oBA1qnPd3nYDW8yVI1ygzwJRdfkWMEEow34cM+gRh1pB2nqxh6B5g0eTUmp
         jwvEcLwTYttTdWVWbc8I54uwGp63MrTDXGhnyTYNFJaup/0dtD4ZMby62OPb28ObJZ0F
         Irsuy1S2WcePEYXTkYBdKvgvX5WmJwE5tnwqlHLRxAiHa5OQb3noQee/Uh+AJUiFKc4O
         /IsG7bOhnCGLdJN/k1ixAqL5IzcQxgnYFiRM3ALvEgSVWp5vyF36zW1w8qtDtxrpulNN
         b0SPZmcwIN6irbx534XUYhX6QPxp5aBssbclKlw8LPheZtiVZ71bTV/kTCeFtggARILv
         rmSw==
X-Gm-Message-State: AOJu0Yy+dtUw/yvF8VHA9vqri1vED/PIZOx27BtP/tXDu/Re0Ov1Zi7W
	1rcuTxiu7mBh595lTHeCYFyOYYI2VK6aDX+iyRzck3Z9ESDheeJoK6+4vlSsZQydjA==
X-Google-Smtp-Source: AGHT+IHLPgXjndJjue7JZCBb/Obkgqkz3O5ORbVsw7IyIJPKIogN2/XvGhQzDXSxhNqngAW1Otj59Q==
X-Received: by 2002:a17:906:5f86:b0:a36:f314:d8be with SMTP id a6-20020a1709065f8600b00a36f314d8bemr6544824eju.38.1707829122035;
        Tue, 13 Feb 2024 04:58:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8GmVWpVtXsv9CUGlgzj9xI5iu34FvcBpV3uY1aOPlxcvXc+l3iWpei19GntcgFFyJIg2eg7P6LnYOufUi2XZcFkCkXD3BSw3RWQv60Qn5r/uEtnk1rJEhwmPWmK7IoRsQdPF18sCyHtt0m/09EbqN0KyTZYU++MkE7E0J4Hd08q0jlw2xmMF1bPJzSXtuUt+sayp5fR/ZXOzO+ioJELvmcu20PDMAgyIsjqsho9ZbYV1fzIWfgP+dAZoFn8cu1nMGcwv2Oi82XHAJa3ZpM/tyRpUXmdmUBAIpysqGsCzhWbmiqhPnWHf1KoSyXSQxzFcmvtNGR2/RF1ivkSR7reT44XXl9/iSjUBuq0rmxYY7+75GWVKdYCb/lhjEJeV1UjS+exhDKGBihw==
Received: from andrea ([31.189.95.98])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a3c5e6515d0sm1267324ejc.24.2024.02.13.04.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 04:58:41 -0800 (PST)
Date: Tue, 13 Feb 2024 13:58:37 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jason Baron <jbaron@akamai.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: Re: [PATCH 0/7] riscv: Various text patching improvements
Message-ID: <ZctnfZWWO3HCiXe5@andrea>
References: <20240212025529.1971876-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212025529.1971876-1-samuel.holland@sifive.com>

Hi Samuel,

On Sun, Feb 11, 2024 at 06:55:11PM -0800, Samuel Holland wrote:
> Here are a few changes to minimize calls to stop_machine() and
> flush_icache_*() in the various text patching functions, as well as
> to simplify the code.
> 
> 
> Samuel Holland (7):
>   riscv: jump_label: Batch icache maintenance
>   riscv: jump_label: Simplify assembly syntax
>   riscv: kprobes: Use patch_text_nosync() for insn slots
>   riscv: Simplify text patching loops
>   riscv: Pass patch_text() the length in bytes
>   riscv: Use offset_in_page() in text patching functions
>   riscv: Remove extra variable in patch_text_nosync()

This does look like a nice clean-up.  Just curious (a "teach me"-like question),
how did you test these changes? kselftests, micro-benchmarks, other?

BTW, I recall a parallel work from Alex and Bjorn [1] that might have some minor
conflict with these changes; + both of them to Cc: for further sync.

  Andrea

[1] https://lore.kernel.org/lkml/20240206204607.527195-1-alexghiti@rivosinc.com/



