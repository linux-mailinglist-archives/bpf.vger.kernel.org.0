Return-Path: <bpf+bounces-48962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 633D0A12A4C
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 18:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1820188B446
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 17:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01D21D54F4;
	Wed, 15 Jan 2025 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFCjIDXk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8777B1C4A1C;
	Wed, 15 Jan 2025 17:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736963785; cv=none; b=W7eVry9xrnAG+n4IhYPaNSve8YNbGJFYSX7EPNUrUM3OKF8wQHhOAihVas2Db+W7OB7CgmF6uhev4LCGAFaOMuydipQgYWSLvmx2bLSohCo6Icu239b4oEMw7/9rAu3eDKbsGb/O2Me3FoFe9aLfEZJQJUPDZ+NUmKxpoew/dmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736963785; c=relaxed/simple;
	bh=cwcn4UeuPicsTqyFJgpJuEYCuSBPzuvI7csqw1sRu6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkowsyKYRUkrGNztobiykL+qIwdgRgZhJ6GP/9WUtDWSqwucX7aNXbuJacU2U43x2crYlh7mGgtcZUa4ixF8ObQ26NtBTrDW59VELL+Lj7ag5ffJS3UtpSFqNDvgI/Ohwj1KLwRlceA11bASF/xOq60FHkMHpwXj7vmVV5czjMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFCjIDXk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436249df846so49060905e9.3;
        Wed, 15 Jan 2025 09:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736963782; x=1737568582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwcn4UeuPicsTqyFJgpJuEYCuSBPzuvI7csqw1sRu6Q=;
        b=AFCjIDXkOaYw6iBC2P9brjb4X3iqcZs5NxOASNc96i9sEu0atyV4Cg67qahBwupjfc
         1GYKTCF8Mp49AokQxm7Gv6q41gO0mnfzx0d7g68nAivH+MQ4DMx/dOm+Qj8gwGgflmUy
         0LXcTIKQwhWxU2iX0PBIY7dPsVQ7aSo7hk0w5zvWxwfmH8obAosHS0k178U+sDBYVg2S
         yvdyiCnMzkLtqbMD250r/RYlk4tRGUKjPHJO8Da6+BiKe+vKfi2Yr3DFFy7SWnkScE/3
         v44SVIVsj9tG0EXXV1SwzDlZFFFzc4zUYyZDcwCYo/Mdt+LHQYrNpU8m+SMaA+ZcwOnh
         V2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736963782; x=1737568582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwcn4UeuPicsTqyFJgpJuEYCuSBPzuvI7csqw1sRu6Q=;
        b=FWjJaZGYTm6dUKsL6ZWdichTjMBVrnJP+P0x6D3gZ7xbswchNo5znzCHH/IsbICCgi
         AQjxEb/AojHMWHKgdckc/2PRzRBA+BYIMqDyRfcz0TSoLS6BD1f7+RX2ad9Odqlh4jza
         OpiTb4vthQnPE3RBUXZMP70EHhTdM4kGPidy2VAzgsvEqfRyegRyYtB5uWktp2wLH9k4
         HNcjsTvk5peEHB+7M2fvB535uxlSOL4OeLirojnKJC0Vp+VgnVPbffM7BomtxVVZA6Fo
         ILWBiFc1h969KiFXn4AMRjKeoVVQtT+jWIMxHcUiVOv0YIH3CP948u5a7yNLgfn0/tee
         xzOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhbvY5N8Iq1EuvOLCcJUSv0AuNcRpdjDTDjPXPwYhEMzse7JbpDwDAUrILERX6lUS6fZg=@vger.kernel.org, AJvYcCWNrTelQsnwXnp1zbeGj1zc/Ox6APagv5BdyJqlI3uIsTQ4LzoZzgVUmiMGjMVaRY6H0eFtUVkKFOWw@vger.kernel.org, AJvYcCWeqKXes9K3EqSywG3fe9OVZaMAFg2TcvsSrhbfSd5YpMuGxF/3EfLVqtB8B4qCRoxHJkN5OsveMstEAfPP@vger.kernel.org, AJvYcCWnLAi+KwrjigHcH3AkNc3lB1q91+UnMBsoKZIyXoIHH8DmyGGDsy74W5w6/Y8RWYXcWbnxS25bfpw3oy9HkM9z8fR9@vger.kernel.org
X-Gm-Message-State: AOJu0YxpZyNPrHPqkgywyKtvWYZR32e2iHsfuxkhoLJMQTpem+jtNjqD
	mZRPQMRjO7y53nCbI1O5aBdUaw8mz4b/g+OhxE41+ypwQeGOJpiJ64nUUo5Qi736G97K0WQO3DS
	srZTqdxJn8wbVvvOstBy26L3oV/g=
X-Gm-Gg: ASbGncsaGxrI1PgmMNNXGy1953AT/h92vvkeOPF5bX22z37p2u9JfjUbkBzOMeeGlCL
	7wCIq8tHYFHeZuoPD5cUE4adgaltcCuLDb7kdHuK0ppZ9Qjs4YTYTpg==
X-Google-Smtp-Source: AGHT+IGmbXbJAWaj9ckZQRiu0VSAM5NgWnUcn4zLUuOeI5Gxn6iBndX9efW1pMop9wboot2JNLQerzhAT70UdU8r5jY=
X-Received: by 2002:a05:600c:4f4e:b0:434:a902:97cd with SMTP id
 5b1f17b1804b1-436e26935cbmr266858625e9.12.1736963781534; Wed, 15 Jan 2025
 09:56:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava> <Z4YszJfOvFEAaKjF@krava> <CAHsH6Gst+UGCtiCaNq2ikaknZGghpTq2SFZX7S0A8=uDsXt=Zw@mail.gmail.com>
 <20250114143313.GA29305@redhat.com> <Z4Z7OkrtXBauaLcm@krava>
 <20250114172519.GB29305@redhat.com> <Z4eBs0-kJ3iVZjXL@krava> <20250115150607.GA11980@redhat.com>
In-Reply-To: <20250115150607.GA11980@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 15 Jan 2025 09:56:08 -0800
X-Gm-Features: AbW1kvZBi3k5jC5kQVBYY5GvXhVSF-g6yM1q8ScaKGYFaSaB9mHQ0kNn-EI6xL0
Message-ID: <CAADnVQJjroiR0SRp69f1NbomEH-riw53e_-TioqT4aEt3GSKGg@mail.gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Eyal Birger <eyal.birger@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, BPF-dev-list <bpf@vger.kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io, 
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 7:06=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> Or we can change __secure_computing() to do nothing if
> this_syscall =3D=3D __NR_uretprobe.

I think that's the best way forward.
seccomp already allowlists sigreturn syscall.
uretprobe syscall is in the same category.
See __secure_computing_strict.

