Return-Path: <bpf+bounces-60534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2326AD7DB7
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 23:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9B43B2FD7
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 21:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BD02D322D;
	Thu, 12 Jun 2025 21:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmH1VtxT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1B679E1;
	Thu, 12 Jun 2025 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749764672; cv=none; b=TtRsYdhGkvLu5YJoaX9v4LSLk2zV1FKZW5/Kkv2tnqBOrN2k0c4FPI5dtXzsBFC1MT8z0lhtACcFfxK9CC+hrMER3KCitdifY1+ViDuGXvZ5Mzqtur8R4gP+weNGDgq1Bo3IwRcKqUnvaP9LCNNd/X0/0VmRM9xfykhqrP6a5Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749764672; c=relaxed/simple;
	bh=IATpOY238gFRIVo+bPshN1PINtZLZa5IPupP6GUEMmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwdZZlCWRB+ecEoYrKx0iJWRFOJ81wiNh65mmaC82gf3L7/tHH4p/mTM5MaXtfR+XG8T61IDhPPfqim1vr83Cm/qKzWBFte0ZKn4P0fljWYJ34jPPyNX7mo/5/fjEX1jSPwA6d7yVtZPdMt4PMgxrxZpNXYxaNRApgJ/zA0p3kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmH1VtxT; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b1ff9b276c2so926102a12.1;
        Thu, 12 Jun 2025 14:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749764670; x=1750369470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IATpOY238gFRIVo+bPshN1PINtZLZa5IPupP6GUEMmM=;
        b=AmH1VtxTJ6oQ8w4jRl0n3RIJeChB9wEekCyNX9TLfS72xc/RDoNAqkmeq9euA6WBoZ
         KFoUDw3eYbSSHyK81IviuOsOBl6MTAThNOXWrnUnQmCG6DQrOvF2IYyAebA2ESomVUZN
         i9k9ONCKUwhQl3uBPQSGPHJSSOOzCvIrR06nUo0eYAsWVbhYrpKgOTDUscULkTT2Axsu
         +uq82JlN/1anc4meN0xWVTtPHPP7PHZJN/NeYFWUx4UwT0n7kRbJNao3+rclBldbgxS0
         pA4+oLm9Hb3ueqsnEHXf5o+kjGvbCLiaGkUhTBp4blN7j3DtxkqkDFGn20ib8ncfQDCV
         1Hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749764670; x=1750369470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IATpOY238gFRIVo+bPshN1PINtZLZa5IPupP6GUEMmM=;
        b=fZUQzcxlUFR9uN5mt0iAtrpvjfr04fvBHj7/JHUud4bBehltk/Lhyf+sTp9aSDh28J
         hqGygRoyQxwmnvKg+JP9JymjZ5EulXQh6VUATfhBOG5CCLU/31PquhO+QEH0I+auh/CB
         /WvLyUtqlOlUZMmp2+OOW8CeuQCur7SmOV4Ttd8/6RgQu3cRtfp7vNAujGwau3UoMile
         Xw9AMUFLcp455iBrSyfzASQ19ijOH39t+iYw7NQg0W4lMa0tlphagMiImxIxwVk8qmkH
         WCv70236ROC2jfExze8FCGxNBHCA95Y6JiD0MeB/B2hkH13tYkiuAfvAbqlFvHBkeaGx
         23NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxNqDQtILvA/j4uc1SSkS2g9q+qf7IQQm5FXP6UDAe6wns68UEBaxAMrHLC4cPONuHuq2dTBo8J8xVtB+jN9wRsHf5@vger.kernel.org, AJvYcCXfYAUf9VLfpUs/aaRHUpaU2JJQbdnl6Q30PEbvk6w4A0ergiRf6vJ8T8m603fITKa6Fek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKfkF4hRC8VIbncQqq+cgaC5eHzP81wPjrEugVMxHsqMzCmMi4
	P8tk3BcZOKvEOAGxc3T2b+JQPcA0e4hsOoPC2TAJHxjcUqiebcw8VZ7zFWdFfIhM0ZmNisHH0eG
	p7j9cyyewQOtTWT8h5JkKUHFlIz3Hp94=
X-Gm-Gg: ASbGncvXP1WRgiO6HDtWbbb2EGwWfb4YBVkoIiL3KpuruKqv+ilVuy7mumFS1Gj6ODA
	Fr7s+3XgSJ+SGxaHgG6tRypJHK/qSQ6G68Ssmcnw0DZLk8rwFi/slaXaQzeelT46FPvt+uJUs8T
	QBUouWelNphwpKcc3xgGx0Y/2jgJFuLDeZ2l9ebFpe6MCFy5/AJsfVSzIDofA=
X-Google-Smtp-Source: AGHT+IHhZCcPD/r3sFQ9gQrmnCeEnJ8w0ck2pNHkvamx2T5ty3OdoBVMzEXMPUIkDXYKLj4kAqcLWzf4CCp6+nV/vh8=
X-Received: by 2002:a05:6a20:6a0b:b0:1fe:5921:44f2 with SMTP id
 adf61e73a8af0-21facc8793bmr680738637.20.1749764670394; Thu, 12 Jun 2025
 14:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611005421.144238328@goodmis.org>
In-Reply-To: <20250611005421.144238328@goodmis.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Jun 2025 14:44:18 -0700
X-Gm-Features: AX0GCFsMARBAt82iHeyYKq9sfzlLjy1I8tyKt0b1U2KihKgFlzE187b6rKd18ik
Message-ID: <CAEf4BzZ9-wScwgYAc5ubEttZyZYUfkuAhr3dYiaqoVYu=yWKog@mail.gmail.com>
Subject: Re: [PATCH v10 00/14] unwind_user: x86: Deferred unwinding infrastructure
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Jens Remus <jremus@linux.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 6:03=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
>
> Hi Peter and Ingo,
>
> This is the first patch series of a set that will make it possible to be =
able
> to use SFrames[1] in the Linux kernel. A quick recap of the motivation fo=
r
> doing this.
>
> Currently the only way to get a user space stack trace from a stack
> walk (and not just copying large amount of user stack into the kernel
> ring buffer) is to use frame pointers. This has a few issues. The biggest
> one is that compiling frame pointers into every application and library
> has been shown to cause performance overhead.
>
> Another issue is that the format of the frames may not always be consiste=
nt
> between different compilers and some architectures (s390) has no defined
> format to do a reliable stack walk. The only way to perform user space
> profiling on these architectures is to copy the user stack into the kerne=
l
> buffer.
>
> SFrames is now supported in gcc binutils and soon will also be supported
> by LLVM. SFrames acts more like ORC, and lives in the ELF executable

Is there any upstream PR or discussion for SFrames support in LLVM to
keep track of?

> file as its own section. Like ORC it has two tables where the first table
> is sorted by instruction pointers (IP) and using the current IP and findi=
ng
> it's entry in the first table, it will take you to the second table which
> will tell you where the return address of the current function is located
> and then you can use that address to look it up in the first table to fin=
d
> the return address of that function, and so on. This performs a user
> space stack walk.
>

[...]

