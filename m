Return-Path: <bpf+bounces-46309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA04C9E7819
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 19:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4286165894
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7EB198837;
	Fri,  6 Dec 2024 18:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah8Zx3Kb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D583E2206AA
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733509840; cv=none; b=t6xdyiFbdcb6QsvAWQ6yZg58g7rd7icUB2TptdECkW0UvUI/cnds2gTc+mjnHvnY507pzxvZWP8secuhsx2V4dmlMHPdhb1iTLcxvdxnbji13EX8f5Xl62nu9cQRPXBc3NNQhzSJTIrfxyzIU5g3TXoWXjm0ZgG8M6KKlJc2IdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733509840; c=relaxed/simple;
	bh=zBVKAfjlF5WngKeIB2Q3/3nGmg2s6I4nbMDp0+z94bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cdb930VQYM11ihymKT8CBsMfsbfc9Qazl218bBH7zuuvDKwUtCc6Lx6rgqVK7g4eyNJ4biSt4jmkNC71trhCJUEp5xLi+6GnUf2WRHgEEu0da0igyDrk7wTSDfT80wHSBq/d1C4OiFW6g+rrKHrOyUATxde2BjyMJGeFgyscKWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ah8Zx3Kb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a7ee3d60so20737875e9.1
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 10:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733509837; x=1734114637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBVKAfjlF5WngKeIB2Q3/3nGmg2s6I4nbMDp0+z94bQ=;
        b=ah8Zx3Kbyep5EGHXXIFTDeTl4vN58iYIAh4vAMPbduq13aeDdiHGfciGlWMMMdb+0E
         rQphZsSW7PUsm07tctFrbtptuBKQlVKOMqBUXE0ZsAvmP/ZUh552LJT7NZlSLnsF3ADA
         AP8bxd8izN+zAjv3ubzG+gtZ9KoYnZprZIizmSiWJGzTfiy4c7SRGTKd2/9k+1CF3Mdt
         iYJTEMnQNFEzHxvcmxohxUPlk5kNJY6Y1k9qwM9zPkJmmn1/o15h8EawVlVxi6UTZgy6
         j+5oWke3OStbsY5U/oUpvXoNmdGgOx/r6Kg0jyIjn/IGGPSq1OuMsMiORFNDAUHoyL9u
         ynYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733509837; x=1734114637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBVKAfjlF5WngKeIB2Q3/3nGmg2s6I4nbMDp0+z94bQ=;
        b=iGw9BUKpGwLeU3ZsMaty4SdgRD87wasXX5ICifvH9kcHRdEVTcKQuADfXRh6ehTRQe
         5MJd2XJvm2XvhWXKt6nTBa+3FbdRBoCUwRooGbXthCJgDFcsB7f0E6UAxmD3L04zcTWV
         0usWlyE+e+N2HRXQXJAAySz+UTMMYRUTNF7Bm5ofmzqJDXRnvNIlofD1ih8oo4fk5zAx
         7PbN6u07VhQGSyvGmu//e4VeRrQ+w+wgh67RGSrOjbK1QgpnH7mHw0ONqUWMQ/eFDCV1
         KeV/4kZjLdNim9FdwH1agEWA7qpr9ri79SuFmmtzLu8eQLNy+vXCAjmtK4VBRNh4RhR9
         29Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWbeG/IOoM3aYQjMLMR9EWxE7s+0+6v8K2RxeHJAwmi5t0gIeW3Dlp6k/9VhnEtFPGobpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaJNN53bzp8CZPtJkFo/6pj8Blo7A422eD1qgN9hH0wig/HWkg
	HnS/1nHG+qESBTeSFAD9EQRs9XBxhoUddQIq5+ETMwZlCX71wJFiyjdv9x7S7X8wdjtJyL4G+8R
	vDCcKopdN0aH6OqxeF4En7Umu2zE=
X-Gm-Gg: ASbGncvcZF6GVsrrFguXv8PEgekOhL9hm5lqOT3X5OWxA9kQ9XMlI8WbMfFfHHVAI/e
	mysXE2Wev19Jhhb0Vf2eB1+t4zFIB1tWy17Kc2qVCOIUoieA=
X-Google-Smtp-Source: AGHT+IE+xE/Qdc2ydcTAPXk0QhkOoz1OktjLLa+x6jOtPpfwWvUwvwhzqX+T0Id5mbWm+0IQugrg6Kt7SsPgMFvUkUA=
X-Received: by 2002:a5d:5f4b:0:b0:385:e879:45cf with SMTP id
 ffacd0b85a97d-3861bb4c763mr7213455f8f.1.1733509837007; Fri, 06 Dec 2024
 10:30:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
 <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com>
 <47f2a827d4946208e984110541e4324e653338e0.camel@gmail.com>
 <CAEf4BzZBPp40E-_itj1jFT2_+VSL9QcqjK4OQvt6sy5=iJx8Yw@mail.gmail.com>
 <4bbdf595be6afbe52f44c362be6d7e4f22b8b00f.camel@gmail.com>
 <CAADnVQKscY7UC-5nAYxaEM4FQZGiFdLUv-27O+-qvQqQX0To5A@mail.gmail.com>
 <1f77772b8c8775b922ae577a6c3877f6ada4a0a1.camel@gmail.com>
 <CAEf4BzZybLU0bmYJqH2XJYG_g8Pvm+STRdHBtE1c5zbhHvtrcg@mail.gmail.com>
 <CAADnVQJ7WuFge8YZ-g07VK6XhmMCf1RHa0B64O0_S4TLzu0yUg@mail.gmail.com>
 <CAEf4BzZPFy1XXf=2mXVpdVw70rJjgUfPnDOzWb5ZXrJF1=XqUA@mail.gmail.com>
 <CAADnVQL-0SAvibeS45arBoZcwYjQjVnsrMeny=xzptOdUOwdjQ@mail.gmail.com>
 <CAEf4BzZF3ZrVC0j=s2SpCyRWzfxS8Gcmh1vXomX4X=VS-COxJw@mail.gmail.com> <CAP01T77rBvM9sTQMbJBk2Ku5SRYHzQgvGaNf36v=BA7=nHTmeA@mail.gmail.com>
In-Reply-To: <CAP01T77rBvM9sTQMbJBk2Ku5SRYHzQgvGaNf36v=BA7=nHTmeA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Dec 2024 10:30:25 -0800
Message-ID: <CAADnVQK+-5oGLF15iuZ9_ckOZQ7QjR0ax0VL_R=tP_831Fa9yg@mail.gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, andrii <andrii@kernel.org>, Nick Zavaritsky <mejedi@gmail.com>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 10:24=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> I think Andrii has a good point here, this would be an entirely
> plausible scenario,
> and with summarization alone we would reject such freplace. Then, the use=
r,
> due to the lack of explicit tagging, will insert an extra helper call
> that does nothing
> just to indicate "invalidates all packets" side effect when it could
> have been done explicitly.
> So in effect they just explicitly declared their intent, not through a
> tag, but through code.

Exactly and that's how it should be done. Through the code.
C is the language to do that. Magic tag is an extra language hack
that people need to learn, remember, teach others, etc.

We've introduced __arg_ctx and so far the only adopters were
the programs where Andrii added it by himself.
Anyone reading it has no idea what __arg* do.
It's all magic. While C has clear meaning.

