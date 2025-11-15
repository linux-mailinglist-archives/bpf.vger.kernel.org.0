Return-Path: <bpf+bounces-74619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D152CC5FDE2
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 430954E2673
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD53F1E98EF;
	Sat, 15 Nov 2025 02:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOiiU36D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D911E22E9
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 02:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763172758; cv=none; b=Jud0fxSwhkenIoGo9yNO0RdFaCtK4MVs91QZWUS3Px5Qy1jfCE+qjgwiaHIgF9a8l0+2gA7N7Eo6jAq5DmbUVvKy71esfBwgYv5/ACg58nlr3/mQUSHrAsfCTwRsdLZyM2nTUDIV2WkPhuHnRJ0o5GiVxchpiA/7AeFFXZE3qbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763172758; c=relaxed/simple;
	bh=3PXnM2NF6vKZDHestwDEuZTYUPHPKyZU7tavshGG4x8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLO2po2OHq8PVqlyWrWgcpLz9hAtKy5gAl9T3xBYbgZOzyUVKqim2YFvl0laGYKwzWvaTHWQo37YPBrjhIxdjqEgIhX0YmdYjX9bRaOgXl0tmTbLYtnVqmagD2DTP9sVXII+pprtR8rM2c0lbvwok+Tjd9G4+bfOI2eE5BYjUIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOiiU36D; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-63e1e1bf882so2162899d50.1
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 18:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763172755; x=1763777555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9Qnvzwy30obfyYrc0KVi/oZN5LmGMAHEChanTy19Ac=;
        b=kOiiU36DTJsMUShh1uWPgCPzgy4lxVkLBsaQ+MfMtYbKBwQMSIQMkhplwZtxrFUl0A
         6sKYowtAhYgMGzim5xtF+4aQliRnxCZoDFsJBhckRB+lW6QJKk6jSp/+jYSchDV90avh
         D0ryhtCcvmg8Smuw+eALSXJ5k+U96U6LqN+7UsrTd7HgoyOj6+ZV6OV81G75w+Q8eBTm
         0vqwpKtNRrSincMXXz0IvEuB0kJ80qn5QYGyJE3X3msRt8/cfCjltFLdr3f1r0s/Href
         FlK2xRnE30CYetx85D4uoPEmlQz1XqZpHHl5lJ3kjNSJTaGyer4Wj/Hl8pp6XVdceoAR
         SuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763172755; x=1763777555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o9Qnvzwy30obfyYrc0KVi/oZN5LmGMAHEChanTy19Ac=;
        b=JMixkmMr3M9dxps1vjRIMjXebbAi2yWk0xnweaUMZiobfXH6+77FMYi1xDGDIf55yX
         DVZFP7jeTmz+CbMlEJ3ZSF9eS2zCoQPQX4Ycje8jpWrUywrJkgpWYXzI8Cajgut4pta4
         /hC0UoU3YYBA1cfq/lHzFXDgGAzFlXRL6z+Px0bSfoa7X3Ok/SxFfVzkqrjOej+ZA5h6
         BwoG9Oe/bEHhBNCXxX33kIXmy0UNBom7lzX/HMPr8PC0qNjHbF7gPxyeEBEZmYCmPQDM
         sfzSnDAdcEGAS1CeheI1Zj2WdvXBsLw4zYjSVoLbsRSP+pS//xwUnZxXI9uX1d0T2Ys4
         M0MQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3hbvc1abQ8vuqWhkU59zpxVBRff8KI8y1Xb536qqx5zYWUxxTxsfdJwEN08fnPhLNjWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+bLS1Ogq7dQaUopncqDr38Ra5rCxdrEt4E18Tn0DqWsJodyni
	W0CMxdqImAU3xFTPTjvNe4qrUd6tjj0qusRVPAJ4XY34EEl3FqNsP3nUjc6ahC6MzAKwajPImcx
	BnaQVQoQrmU8fVu0t5O+lYJH1z0plV6s=
X-Gm-Gg: ASbGncuuPL+vXxo/5TPRAVQGnSSmpCi5dF6DQH8KiKmnfyXzflf3gUuMaaoKYD6b6Ls
	SCLuzXyCuw8747Peugvi/RZL2S6gUApSLTfBvQVpNhAInyThmcQEpJYgEWynnHmOz6o4XGBUZB1
	AeyWBqlYi8sAZZNyUoN/lQxo5rG+AD5efL/kTGszkrfrZkLmDRTtyQS5MWDvEJmfczIGDlv6HHO
	PUxwIITTXhOBqQGi9l3f5YE2MS0yiLxKAIKILxOlwWgJfw2xpszegpmVRPaRFl0bsU5hOg=
X-Google-Smtp-Source: AGHT+IE0EjMBlj9fKLLl8YcYf2yaXpwv5o6ojXHZRKNeRCq/poWUekbkzNnqg7+1kPvc+2go9XKMhc5o2Efu9aVIVtQ=
X-Received: by 2002:a81:fb0a:0:b0:783:7b01:32fc with SMTP id
 00721157ae682-78929e2b18amr63662337b3.18.1763172755260; Fri, 14 Nov 2025
 18:12:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092450.172024-1-dongml2@chinatelecom.cn>
 <20251114092450.172024-3-dongml2@chinatelecom.cn> <20251114113924.723f6fde@gandalf.local.home>
In-Reply-To: <20251114113924.723f6fde@gandalf.local.home>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sat, 15 Nov 2025 10:12:24 +0800
X-Gm-Features: AWmQ_bl1sMdavc9XzdeKOoyyGPqNi20ltUDbJWwlSEkAyk-YWoghYmbZTUQzbIk
Message-ID: <CADxym3b8+f2Gg-2RiK++9+D8yQ7yb44VQPnuHh2uS-CDRJjzEQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/7] x86/ftrace: implement DYNAMIC_FTRACE_WITH_JMP
To: Steven Rostedt <rostedt@goodmis.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, mhiramat@kernel.org, 
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 12:39=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Fri, 14 Nov 2025 17:24:45 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
>
> > --- a/arch/x86/kernel/ftrace_64.S
> > +++ b/arch/x86/kernel/ftrace_64.S
> > @@ -285,8 +285,18 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOB=
AL)
> >       ANNOTATE_NOENDBR
> >       RET
> >
> > +1:
> > +     testb   $1, %al
> > +     jz      2f
> > +     andq $0xfffffffffffffffe, %rax
> > +     movq %rax, MCOUNT_REG_SIZE+8(%rsp)
> > +     restore_mcount_regs
> > +     /* Restore flags */
> > +     popfq
> > +     RET
> > +
> >       /* Swap the flags with orig_rax */
> > -1:   movq MCOUNT_REG_SIZE(%rsp), %rdi
> > +2:   movq MCOUNT_REG_SIZE(%rsp), %rdi
> >       movq %rdi, MCOUNT_REG_SIZE-8(%rsp)
> >       movq %rax, MCOUNT_REG_SIZE(%rsp)
> >
>
> So in this case we have:
>
>  original_caller:
>  call foo -> foo:
>              call fentry -> fentry:
>                             [do ftrace callbacks ]
>                             move tramp_addr to stack
>                             RET -> tramp_addr
>                                             tramp_addr:
>                                             [..]
>                                             call foo_body -> foo_body:
>                                                              [..]
>                                                              RET -> back =
to tramp_addr
>                                             [..]
>                                             RET -> back to original_calle=
r

Nice flow chart, which I think we can put in the commit log.

>
> I guess that looks balanced.

Yes, it is balanced.

>
> -- Steve
>
>

