Return-Path: <bpf+bounces-49229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3AFA15819
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 20:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB711168E0A
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 19:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539981A9B2A;
	Fri, 17 Jan 2025 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLo1JinN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6877525A62F;
	Fri, 17 Jan 2025 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737141893; cv=none; b=mDnX7gh9Am9xfgX1rMgiXMXccyv3gXo1qGuC9Fpg73OeQ2+TLyZ2Q5HFA6uES/Q4hw8q7Dm8kTt+uSfps0F2QU/l7Z42pswB3xf6/9VPQC/eKMQZ/UQJtVMfod4+qTCHKpPE3qEftlHol5gXSMWq3OKhcOlgGveVZJUZ3nIFOfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737141893; c=relaxed/simple;
	bh=Gsn5nz20V2fIN2FayyDmPhjKVGCG561deT7CzmcmdFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADFzyR2YgyW/f294ZwaJh71636K99IUMgGk9wj8dDwECv8VqSmfNkuhMduI+lF6rw48zhXAiwMnrZCb/Zfx+VrzMIOshy2TT9MDnjIRa9fPb2910CzMdsNlGAhR9Y3JIGKpz4T0e2fNceqFfvl/Fj/aQDF2n4Vy6V0MjKGUklk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLo1JinN; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5fa2685c5c0so1088501eaf.3;
        Fri, 17 Jan 2025 11:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737141891; x=1737746691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gsn5nz20V2fIN2FayyDmPhjKVGCG561deT7CzmcmdFo=;
        b=XLo1JinNLo2WBtzHdRfXH7KEJzuBuADMU78TUCUo+RWS/OAqcGdViTTdpE3hdLZjiB
         YUus7uxJ/v4fYINHDJl+fQhJ8ZKXx1MD7eRTQZqHs7aaE0BUO41R2x1SU5nVjdsW777G
         BKSbKXjnseJLDvjaxEFxl9SxImFt9B8Jxpt1Msf+5EbcZYboqEJC+EmPgLqbn7QnsZfm
         a+8ECf3Nr8GZ2LgkE+CMHkN8KfvHouW8sI5aZwStJPUYf8akL9RVTj/KhnNys9rrCkdV
         w4hkOmnGeiBnIWIOUqe18IquLcFLchP9pl3FJ1fF9oGmcXPHXZ5biG6zUAMhypz64C/t
         36Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737141891; x=1737746691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gsn5nz20V2fIN2FayyDmPhjKVGCG561deT7CzmcmdFo=;
        b=iN//jcVqQuSL9x31E30S/i49mHgfiCAehWqHXmEypM1w5UOU09cTaIGeV/lDwhGFnh
         OPOqmsVlqQGeN6Wh8z7NX+o+v8RCzyMvSUyx/t25Jp3PL2sPhpJREqpwaLVixvmVBkGq
         GZPxpSb/TTrlSLokYZDxtkCR6jfXVKT8N+l0DUpQqA7hh9DWTQ5VN8m8hJs1HP4SfOGV
         nZpUsqkKmx6kZrZD2Cy9WFrBnY6auDe6JwiZSBgE+HanrJuMDfOd953VjEYPjGQzQ3ct
         xpCz6lO3DpT1IKx6+cNxHecHZFFH8Q9Tb6Z/bvetyoCLe16cElC+jqzatC54lVxAgh2u
         4Zzg==
X-Forwarded-Encrypted: i=1; AJvYcCU51twM7wKHXCrwi9wxRlppmIQ1JkZwdGN1BvN3o8MDplnjFmftjBkQMgzyHcnjYIdModG0jzOBaV4QMs1mdhChOiWr@vger.kernel.org, AJvYcCWIebZ520dLfceiUD4+P8D/nJij8S9End6UrglOtcetUyMH1/xm8lVDYxJjCRpDTZpFaUUtne+sLn/bIgPa@vger.kernel.org, AJvYcCXEMPjTFc7ISHXNXxlwe/ghkjjn2b3F7I5aJDPbLUFk2hYRAn2znZ5Uy3+X0PYwxmfLCsq7SJTk@vger.kernel.org, AJvYcCXXxVVZIlg/UfFrfbDwifw5nubKS0g8wB/fesGr0WeGaBkdUq6XglbkePiLYbNxvX9ktMqCUhl7zVfH@vger.kernel.org, AJvYcCXw4g44WMNetxBW/JxF0K1e3ghvHqTOZtdaX8Xiktn0rXJOPnLA7WFdspL0Eirbxikx+9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6PiM+7mo6L9rNF7fsfBi1bve5Ob9Np2O8X50mTg1QNtfbZNf4
	0+02uVu2B3/S+mI8ib4DULIEpR3bB9/gzFT9xLNzjDBiyWeal1KV05Bb10HAf5w+iTZEjs8IlIp
	EKCtOe5DqCjDt5PRxgBR2P8STJqE=
X-Gm-Gg: ASbGncuU8MNeB9BBqf0rXWcMYd+zYCdM8RHN+EuLlIaM4XnXVrSsbRrpBiUHziyuAF+
	ByTY0qXcMaqpgG/eGDkwNA9JWQD93+zajd3ONuQ==
X-Google-Smtp-Source: AGHT+IGHQ/grVoTLQnEmUWIYJs8UfQSiHq9tDjdF267G1+pIhrwjMq0XabaARMf0WLjgOqKpCyD9WFNRUAxWyYBCYaI=
X-Received: by 2002:a05:6870:7e87:b0:28c:8476:dd76 with SMTP id
 586e51a60fabf-2b1c0c54085mr2788856fac.29.1737141891437; Fri, 17 Jan 2025
 11:24:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <20250117013927.GB2610@redhat.com> <20250117170229.f1e1a9f03a8547d31cd875db@kernel.org>
 <20250117140924.GA21203@redhat.com> <CAEf4BzYhcG8waFMFoQS5dFWVkQGP6ed_0mwGTK4quN5+6-8XuA@mail.gmail.com>
In-Reply-To: <CAEf4BzYhcG8waFMFoQS5dFWVkQGP6ed_0mwGTK4quN5+6-8XuA@mail.gmail.com>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Fri, 17 Jan 2025 11:24:40 -0800
X-Gm-Features: AbW1kvaFtcIMDe8uGBVXTe6f37MfmRRP3kByqLIaU1d2db6mBf5fy6h5vCUCnVE
Message-ID: <CAHsH6GvgqXgd3F_Nqf-f-tOigtmOACXFukSm+Wpi561xf2vCAA@mail.gmail.com>
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without filtering
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, kees@kernel.org, 
	luto@amacapital.net, wad@chromium.org, andrii@kernel.org, jolsa@kernel.org, 
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de, daniel@iogearbox.net, 
	ast@kernel.org, rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com, 
	bpf@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 9:51=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jan 17, 2025 at 6:10=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> w=
rote:
> >
> > On 01/17, Masami Hiramatsu wrote:
> > >
> > > On Fri, 17 Jan 2025 02:39:28 +0100
> > > Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > > A note for the seccomp maintainers...
> > > >
> > > > I don't know what do you think, but I agree in advance that the ver=
y fact this
> > > > patch adds "#ifdef CONFIG_X86_64" into __secure_computing() doesn't=
 look nice.
> > > >
> > >
> > > Indeed. in_ia32_syscall() depends arch/x86 too.
> > > We can add an inline function like;
> > >
> > > ``` uprobes.h
> > > static inline bool is_uprobe_syscall(int syscall)
> > > {
> >
> > We can, and this is what I tried to suggest from the very beginning.
> > But I agree with Eyal who decided to send the most trivial fix for
> > -stable, we can add the helper later.
> >
> > I don't think it should live in uprobes.h and I'd prefer something
> > like arch_seccomp_ignored(int) but I won't insist.
>
> yep, I think this is the way, keeping it as a general category. Should
> we also put rt_sigreturn there explicitly as well? Also, wouldn't it
> be better to have it as a non-arch-specific function for something
> like rt_sigreturn where defining it per each arch is cumbersome, and
> have the default implementation also call into an arch-specific
> function?

I like the more generic approach and keeping CONFIG_X86 out of seccomp,
and more generic than uprobes, however, I'm not sure where a common part
to place it which includes arch/x86/include/asm/syscall.h would be. And
as mentioned before, this would make this bugfix more complex to backport.

For that reason I wouldn't refactor handling rt_sigreturn as part of
this fix.

Thanks!
Eyal.

