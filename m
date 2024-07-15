Return-Path: <bpf+bounces-34802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD03930FB9
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 10:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D381F21CF4
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 08:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EF91849E1;
	Mon, 15 Jul 2024 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtsiajxF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEAB49659;
	Mon, 15 Jul 2024 08:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032065; cv=none; b=Sf8LyEGRPLBPYueRdmC1Wtc3B5i2tSK4YBfgIvtram+t40ytfIGxoXZW++7Ul2t+PdftMsTJhYM605InoNU0Qu7A60j/rbEfA/dK65mwXzs+b1ggwJ0620AOvIiBwRDEse7phDiyQXmLbdzf2/pUs2Twp5G/uwP66Ttl4xhKOUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032065; c=relaxed/simple;
	bh=oX3nbkgDPK6ubobNu6nSiR2qOQhSYSnYP2i+a6Mok1U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ge5iD4gB+b4Vu/uzWkZH/WOkWZomR1FAxedcwF9P2vdiEqyLp+7cIQw6LEIBIUzO88ZUmwXavdXPsg6blZU+Gi0mdQy1DaawoB8HnIG0MeI/tJtbUe3L+OenO2zT33T4c99zHga9ZaLojWUP+e8Xz3rScBvVX0tz3kC68ximyZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtsiajxF; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c98a97d1ccso3512184a91.0;
        Mon, 15 Jul 2024 01:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721032063; x=1721636863; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wkUY0TLiU0e6n58LpHN87VKdeUeX7NPc3fuLII6KMA=;
        b=UtsiajxFgP5xKdGw5P5RGsDggmYVFzMSItGxJxv1Rksd4WAnFAnf0X1jrY5KNoQEe6
         0FAMMSBXrdF7VVHHIBLPadbRdEXYXfNWh9we/e2P3oXHr/rFw0KW3h/1KSy7H72OcCMz
         sSs9ncH+ySj0pGo00WatZeb6yTY8+KL7bo0ND3JEPMEA86KmVtnPx3GAg6SPycetD6jS
         owZnLb8DxKxX4jpZiBuyzzPILAeg9RvSihIRInzBo9UNZJBPO8YpGYRm0Qq7ErJ1fhIH
         d2+OwEZj6fHAu+EHqXX36lzoERt6JKBsFo3ihfp44AUyOPCwv3Y3+sWvWgCWOI9nA8Sg
         IfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721032063; x=1721636863;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9wkUY0TLiU0e6n58LpHN87VKdeUeX7NPc3fuLII6KMA=;
        b=JK+gJ0ldf1VLkHta5Flb6Xh3YyNg6IFRzpfQFZPsKIL/1wvo1zVfb9KCTkg99+BPMG
         kiLybpksxuFd7AavUNSXbrLobWGCXHc8FYVsHDA19z8ncbDXdXOZZ4TLQvo17oXGZyJ7
         qtwhxK8NqC4t1k4kVudRLgUyFufXkE16/P/XyrBeCYNaONe8MmUL0X35YtoHs9rf7T4e
         UKnIbm9CzvprfoF/hLYJO7UKG8fxk+HDqHAy/a11L9MONWnzMDA4vjuvB3cYskEq6fBd
         sPsEoOuPuAkRjykrH2U1pCF0oxNoUa4YT0By1UBL57HdhU6ci+JmTq4qVRgVgUn/Sa5J
         ofnw==
X-Forwarded-Encrypted: i=1; AJvYcCW7MIjn7z23Bpa4a1QHsI97i5DmrZ8huay5NxwTSCB+1WSS2tbciPSqMu7box148Sb7+hiROci2KMz0iL0zhKPGBk2qJEY8XvBFDAJkPlL8mF4JXcet5Z4pXVYwlgXZdBP9czujW/QNvouA3NU4l4rmabNUDZ6GWkhLIkt9eU3xZk8NX174uPpuNIjw9FsFGONFdppyjBrWcAfnDPhjGquKZyDG
X-Gm-Message-State: AOJu0Yxy2DU4hJt4rdsZAo4Ph3DSsD8ZTOxKJWUTiB8m1Xbahaklk5bn
	ehieWQe6f6y2nPS76vNbaLCY5fMwOLLves7/mT7IzLaT/2zhsaoJ
X-Google-Smtp-Source: AGHT+IHwqr+RXaxTe3zvOZmmoOk7k5D4/ZZfHGZDbpE+MX+vxW1lQni5wQo11I/QfXXSlIqhThZ8MA==
X-Received: by 2002:a17:90a:fe05:b0:2c9:648f:f0ef with SMTP id 98e67ed59e1d1-2cac4ce5611mr14582715a91.9.1721032063467;
        Mon, 15 Jul 2024 01:27:43 -0700 (PDT)
Received: from localhost ([1.146.120.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2caedc1709esm3724475a91.34.2024.07.15.01.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 01:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jul 2024 18:27:33 +1000
Message-Id: <D2PYY2N7SOGR.1KKNYAQTUWL89@gmail.com>
Cc: "Michael Ellerman" <mpe@ellerman.id.au>, "Christophe Leroy"
 <christophe.leroy@csgroup.eu>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, "Mark Rutland"
 <mark.rutland@arm.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>, "Hari Bathini"
 <hbathini@linux.ibm.com>, "Mahesh Salgaonkar" <mahesh@linux.ibm.com>,
 "Vishal Chourasia" <vishalc@linux.ibm.com>
Subject: Re: [RFC PATCH v4 13/17] powerpc64/ftrace: Support .text larger
 than 32MB with out-of-line stubs
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Naveen N Rao" <naveen@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <cover.1720942106.git.naveen@kernel.org>
 <f4faee243f85eec691f2d72133fcb8e4aa9912d0.1720942106.git.naveen@kernel.org>
In-Reply-To: <f4faee243f85eec691f2d72133fcb8e4aa9912d0.1720942106.git.naveen@kernel.org>

On Sun Jul 14, 2024 at 6:27 PM AEST, Naveen N Rao wrote:
> We are restricted to a .text size of ~32MB when using out-of-line
> function profile sequence. Allow this to be extended up to the previous
> limit of ~64MB by reserving space in the middle of .text.
>
> A new config option CONFIG_PPC_FTRACE_OUT_OF_LINE_NUM_RESERVE is
> introduced to specify the number of function stubs that are reserved in
> .text. On boot, ftrace utilizes stubs from this area first before using
> the stub area at the end of .text.

[snip]

> diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kern=
el/trace/ftrace_entry.S
> index 71f6a63cd861..86dbaa87532a 100644
> --- a/arch/powerpc/kernel/trace/ftrace_entry.S
> +++ b/arch/powerpc/kernel/trace/ftrace_entry.S
> @@ -374,6 +374,14 @@ _GLOBAL(return_to_handler)
>  	blr
>  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> =20
> +#ifdef CONFIG_PPC_FTRACE_OUT_OF_LINE
> +SYM_DATA(ftrace_ool_stub_text_count, .long CONFIG_PPC_FTRACE_OUT_OF_LINE=
_NUM_RESERVE)
> +
> +SYM_CODE_START(ftrace_ool_stub_text)
> +	.space CONFIG_PPC_FTRACE_OUT_OF_LINE_NUM_RESERVE * FTRACE_OOL_STUB_SIZE
> +SYM_CODE_END(ftrace_ool_stub_text)
> +#endif
> +
>  .pushsection ".tramp.ftrace.text","aw",@progbits;
>  .globl ftrace_tramp_text
>  ftrace_tramp_text:

How are you ensuring these new stubs get to the middle of kernel text? I
guess you just put it in regular .text and hope the linker puts it
in a good place?

Thanks,
Nick

