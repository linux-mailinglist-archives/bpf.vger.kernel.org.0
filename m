Return-Path: <bpf+bounces-19067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0C38249F6
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 22:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7388B247D1
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 21:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4292A28E0D;
	Thu,  4 Jan 2024 21:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKsk64C2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B192C682
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 21:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3374e332124so727911f8f.2
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 13:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704402184; x=1705006984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/Tdh7c2+Btks82IRS0spPYj1q4zDgMXMFn5PaejoNg=;
        b=dKsk64C2vbcECTCUKMN3bWjvAxhnsCCBL5QuZb+cnf4jQn+0+wpVXIM9bEvUrf8UTa
         WzweKdqStst0DKGZZDaOanvsHmWqr7xjKxUXDugy/b7yA/ripkXTdvbj3eMRfpvNM7PK
         vwzZuaEwDLazEJ8sldHrlOV8WfWov4Q7JeEBZeqZ6DEHBvuK2f1gWz8R87yq1jwr9HUy
         qP77LhPpFJuS7z6UjV59ihq6A5obHLp9AxpavFy72eBiM2wrywX3EkjPC5oABSnHhovs
         lJQz8RXRQfXtGrhmMl/PI4DteuU7ycoRkw4YqIHMipJ0VNz8Ks34myDQp/Ui4igq3rTk
         iOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704402184; x=1705006984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/Tdh7c2+Btks82IRS0spPYj1q4zDgMXMFn5PaejoNg=;
        b=CACzTxmdqcDDBhHz+RTtVnWY4lii5ArFEUiG8d1IW5f3kqtFltB+OMyWx/5hXeqd/z
         4Uw716sU36ihpP7luUe7y/vx8pN3szgXTVf+z6Cty4lDclR7ubJK9EsOlTII8IGGCo5t
         h4MJg3VG1IuhMqtXGOXfO8oOk1Ys9S4uYrfbFvUVt8lzzjtuDCfn/IorS+t26w/zyoFI
         ns9LND7qlVmajeoWdxTMsHUKtwTThSoQoaj9AjebfPNtJbpAQZn6Ei3qzBPTcY6mpAIW
         6quxyPXey6akax+Uo5CePqQQpkc0KjySEb2PnRnjhft+LkxrGsH/y4A2UcONQgiAR7Wh
         /9+A==
X-Gm-Message-State: AOJu0Yy5V1RTLh0cNVJn6LCbvfuskB+nYMnpFEQkKY/fvYO8rgrG3JdB
	hylTTVofwNr4xRbG70IHknMKhP98VTydl7Tp2YOjix2so/c=
X-Google-Smtp-Source: AGHT+IGb5o4YIlVali+qslDysuSecYjMCsjFq0TySYqPgObWNzR2hWJLfIIA4YnI5frjdbiCo3w6SUXOORSr9xilbGE=
X-Received: by 2002:adf:f2c4:0:b0:336:614b:5326 with SMTP id
 d4-20020adff2c4000000b00336614b5326mr641107wrp.82.1704402184280; Thu, 04 Jan
 2024 13:03:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
 <20231221033854.38397-3-alexei.starovoitov@gmail.com> <CAP01T77fbW-9N+Z-2LFS=174HN6v_OJAbR_s6EOfLLW8Oceh_g@mail.gmail.com>
 <CAADnVQKY4hB4quJX_oyq4GULEJkehXWx6uW1nAYHveyvdyG8sw@mail.gmail.com>
 <CAADnVQ+tYBpt_aRG5aU3sAYEysKxUOKQ24dBG4bP2kLy8nmmgA@mail.gmail.com> <c467ee717491884d153bb0016accb9a8a539b899.camel@gmail.com>
In-Reply-To: <c467ee717491884d153bb0016accb9a8a539b899.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Jan 2024 13:02:52 -0800
Message-ID: <CAADnVQL4L_htW4ByN2r-PuTZZUp0EV+XqfefQb=PSQqtwsdXrw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/5] bpf: Introduce "volatile compare" macro
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, 
	John Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 12:06=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2023-12-25 at 12:33 -0800, Alexei Starovoitov wrote:
> [...]
>
> Regarding disappearing asm blocks.
>
> > https://godbolt.org/z/Kqszr6q3v
> >
> > Another issue is llvm removes asm() completely when output "+r"
> > constraint is used. It has to be asm volatile to convince llvm
> > to keep that asm block. That's bad1() case.
> > asm() stays in place when input "r" constraint is used.
> > That's bad2().
> > asm() removal happens with x86 backend too. So maybe it's a feature?
>
> The difference between bad1() and bad2() is small:
>
>                              .---- output operand
>                              v
> bad1:    asm("%[reg] +=3D 1":[reg]"+r"(var));
> bad2:    asm("%[reg] +=3D 1"::[reg]"r"(var));
>                               ^
>                               '--- input operand
>
> This leads to different IR generation at the beginning of translation:
>
>   %1 =3D call i32 asm "$0 +=3D 1", "=3Dr,0"(i32 %0)
>
> vs.
>
>   call void asm sideeffect "$0 +=3D 1", "r"(i32 %0)
>
> Whether or not to add "sideeffect" property to asm call seem to be
> controlled by the following condition in CodeGenFunction::EmitAsmStmt():
>
>   bool HasSideEffect =3D S.isVolatile() || S.getNumOutputs() =3D=3D 0;
>
> See [1].
> This is documented in [2] (assuming that clang and gcc are compatible):
>
> >  asm statements that have no output operands and asm goto statements,
> >  are implicitly volatile.
>
> Asm block w/o sideeffect, output value of which is not used,
> is removed from selection DAG at early stages of instruction generation.
> If "bad1" is modified to use "var" after asm block (e.g. return it)
> the asm block is not removed.
>
> So, this looks like regular clang behavior, not specific to BPF target.

Wow. Thanks for those details.
I didn't know that getNumOutputs() =3D=3D 0 is equivalent to volatile
in that sense. Sounds like we should always add volatile to
avoid surprises.

