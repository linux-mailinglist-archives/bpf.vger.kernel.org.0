Return-Path: <bpf+bounces-76166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1A3CA896D
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 18:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED76B303DDED
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 17:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EC435B137;
	Fri,  5 Dec 2025 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YxkUMM1i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A248735A938
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764955457; cv=none; b=V2TeCrkuiOwtkCGt/BpZOBwtdOJZeInlEZdeU7OfmS3+ybxLkgZvextT57Z8EYG9p7+kyRqqgVp0RfiQT/oubKR8/ZKNEMJGOMulWMa9ifIYny+4IrYgWL1Wru4xrjFT/nVLxIAgTqWZFumpVzuS/NDd+rldhN7hkt3v3Lntbyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764955457; c=relaxed/simple;
	bh=s0iVd2RsjlWS/9TR2zy9YAOZbmjboSgGnXQyMW8/G3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rh/b5oHoksxzJmJz4bvxW4nJGjIKr2o1qIbCfk2XdgH/dsWEprEb66UhJYLG8M+9PMszC1diOWvvlelSThhszB+tNGPZ51GD+Uf3M3XgbBxuMy11zn72saiOMyuu9vlngRCImvHOoct4eKJT+7ze1P5PetOHg2Nx3ovSUoiR1sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YxkUMM1i; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7636c96b9aso312299466b.2
        for <bpf@vger.kernel.org>; Fri, 05 Dec 2025 09:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764955452; x=1765560252; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8lYM8vTuWuligOXJDgRA/sVu98AQZ0ojWGiXce05Ou0=;
        b=YxkUMM1iAnIqvBCYCXW2GR8I0tkgi0oeIswtbpN5YciOo697DW+coFTWobGpRviWci
         URbqSEhddBEz/e5fI3R8DIsdISpmrbSC0PoawLROoSIfP1n+A+xGJk9v57xOGsMS91w5
         IwlrrBSFkQuCe2aew3KohiUmbC1wcpx0aSEpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764955452; x=1765560252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lYM8vTuWuligOXJDgRA/sVu98AQZ0ojWGiXce05Ou0=;
        b=A1PwIXbQyo3f2/2qqt2vjWZWF4nutKkI1jpZnhuKGJgwrWMCUZaUnGumfVui7IhqMc
         KaVYM5+pPAjc3e2N9gJKGAmfYhlTuD4PcudnKsBZ1zlXP55V7852mRKitGk/1TCuF2rD
         1k+smPnLY6E8aokN7g8Fjg+4QP7xkdtttG93K4ukVcnwu4eqLRLCA4P71rI9rc5cHMY3
         qo8WVE9sP6Jpsz+ig+VbIm2JvMOtsQFC85Y1koBIvR7INtBv6f0oClOkoihfl3fIhzrq
         e9K1SeDC3cZn/5w1Yp8Q00/dZVqgWvatnL3uGMsm7pVbkSyGoOy06FQLseoQCGsOaSrX
         ZqkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHMw2jeA8a1u3/9pd/Y1Rl8E2UWhtLUWATcnfGiZ/CB1X6vKA2cjwl42HC8z6KdFNJWoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNjhkyP8PCNKv3NZiknJf0NexGJcbraYFTcax84IRw+qCOr6lB
	nEVDChfLKltyG4WUpa/f42BAzu7vjhx6nNnt/vxFXfMNqrAh8Y7hoRFYyMtvkqQNwh0uIGGDq/6
	VKc801bI=
X-Gm-Gg: ASbGncuqd42IPhQe/yIrFClUybpm6hCRKbyFv4tm9Q18+gKeM8BgUiLSimd7PIlVfc+
	a1isHcAQ+aAq3Tz54BwXcOU6qIna0LdJDVmIE6fo+ZryUPy8WDyPzFVELyd/wdEhl7a/r0zM7i2
	3yUv1Qz147MtpycfuNcW34nq0bwgGJG3pO6jlIUeZv+ggpXjaoOp6p4cGVjOv9n/v5rY7FIHa5t
	AZ/hDf3o7dCvbdlUpV9mxnAzjVcCdb63OlOio5KMUxjRpqbJk9EeB78WMDWVMiAt1oXfWd/cNdd
	QngqIvutu18dqAJimkP90Mm0TohkgvqS45qXAzY3d/W1UjBcyccXeehSBkjN8wtGPnyaNFw4QJz
	U6RHPyMYKus3EPMa+l0ruZN7tA3eM3nTZvyGUEwZLPiV0CemKpS9GI5ENb1og4huh/xDDM/qUsI
	HTscbtlbYO5O7SQwQss9RVrRDK7cLJZdo4WBfbce2Py+62oHWWh6Jlqb6/+5OY
X-Google-Smtp-Source: AGHT+IF/N5MXHj7U5/gFXUrQ4IyVeHDPBTe6vJcvgkoboY9D+swtZ8i7n6Jm3JNTlyKYnS6lWXSD6Q==
X-Received: by 2002:a17:907:96a9:b0:b73:a1e3:8de1 with SMTP id a640c23a62f3a-b79dbe8e28bmr1044499866b.15.1764955451540;
        Fri, 05 Dec 2025 09:24:11 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f4975c88sm403360666b.35.2025.12.05.09.24.10
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 09:24:10 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso4162363a12.1
        for <bpf@vger.kernel.org>; Fri, 05 Dec 2025 09:24:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX98KN8sBEbLVtHsjdYo7MC+gG6rMtitvz/PNO1UrkG1Uvk9rEgQrnOvoka+72UmhCb290=@vger.kernel.org
X-Received: by 2002:a05:6402:5244:b0:640:e943:fbbf with SMTP id
 4fb4d7f45d1cf-6479c496412mr9886451a12.11.1764955450397; Fri, 05 Dec 2025
 09:24:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205171446.2814872-1-jremus@linux.ibm.com> <20251205171446.2814872-4-jremus@linux.ibm.com>
In-Reply-To: <20251205171446.2814872-4-jremus@linux.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Dec 2025 09:23:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh4_BPvniQZqvEQ4cCC3WfvQqruWk0b1Yek+0d5S1LuxQ@mail.gmail.com>
X-Gm-Features: AQt7F2qyEU-sRiqYQ9Tvu5NNk8tmioQu9za2N5evR27IqNXhvz_m-7r0eTXQy38
Message-ID: <CAHk-=wh4_BPvniQZqvEQ4cCC3WfvQqruWk0b1Yek+0d5S1LuxQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 03/15] x86/unwind_user: Guard unwind_user_word_size()
 by UNWIND_USER
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Steven Rostedt <rostedt@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>, 
	"Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>, 
	Dylan Hatch <dylanbhatch@google.com>
Content-Type: text/plain; charset="UTF-8"

 Random nit...

On Fri, 5 Dec 2025 at 09:15, Jens Remus <jremus@linux.ibm.com> wrote:
>
> +static inline int unwind_user_word_size(struct pt_regs *regs)
> +{
> +       /* We can't unwind VM86 stacks */
> +       if (regs->flags & X86_VM_MASK)
> +               return 0;
> +#ifdef CONFIG_X86_64
> +       if (!user_64bit_mode(regs))
> +               return sizeof(int);
> +#endif
> +       return sizeof(long);
> +}

I realize you just moved this around, but since I see it in the patch,
the #ifdef annoys me.

That user_64bit_mode() should work equally well on 32-bit, and this
can be written as

        return user_64bit_mode(regs) ? 8 : 4;

which avoids the #ifdef, and makes a lot more sense ("sizeof(long)"
together with "user_64bit_mode()"? It's literally testing 32 vs 64
bitness, not "int vs long").

              Linus

