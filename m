Return-Path: <bpf+bounces-48840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95DAA1110F
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 20:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581B51665E1
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 19:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FAD1FCFC5;
	Tue, 14 Jan 2025 19:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ME4A4bHM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65041E495;
	Tue, 14 Jan 2025 19:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736882521; cv=none; b=rV3dHqjnSDuVQiAaSfln4evGwbJ1ML/hGn6qJIAfLhRGb4wzfgJjEYFIFPPMmbDpduYlNRrwLK9T7vdD9iihYpTQfQ/vvjIxZkIweTXGzQ4gyW4pwOPxtXE4CDoyIycNDAEQ5vQ3etmuKLrbMoJnIPz70zJ5CIwPQTyVd5g/fZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736882521; c=relaxed/simple;
	bh=EYlwav4mcTdoq3gOWi0pQ5xfwZ86otI56TWgAM1kaDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0K3lD+TYu+IZei3InTnT/H8z+ew1SMlF4KfXzNuVfCqzY914W9hin2nN9HOQT3mECote4Y48klvIffsarWQZXtiXlhD3P0CLXkPo7vqO71AtNrv+OM7VSvQcYeb1Ll1pXkAl68adJ5kPJNiXjOGEm7sPhmw4dV4q+uhSuq2Zlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ME4A4bHM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2165cb60719so106193555ad.0;
        Tue, 14 Jan 2025 11:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736882519; x=1737487319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAYWjDlNWwIFZHAb6sj8GvPPzYC00Jjai6XPpOSZVbg=;
        b=ME4A4bHMPrCWVLupAg9t/bNsLOG9Is8KYdxxstUsiLRDGd1Be/blwmTmw7NxS9W2Sf
         Kq27eceNPk9s2RlHFN1c9zwh+Nvsk98Q6BDLmOyscF+0wf1gOqljTvJznubBma8I5E6E
         l0/m1sewqyVTLITcKWdmOY71MOL0C++P4cvfXJmmy4/7v9o+UutwM8rZrYyj/U/ogRGE
         8PanPA1T7o72O/x/FSHo9NH+DUbJJHYsZU01QTAdxUc6B+dp/Ar3delSyAercqwozdFw
         agTvAtRcUUC1sK/YZW8MJtKAUPJokERPu9AHrDIZF+BPhV9rK9JnD+EnsNY06eYFU0Mx
         kVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736882519; x=1737487319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAYWjDlNWwIFZHAb6sj8GvPPzYC00Jjai6XPpOSZVbg=;
        b=dFPB9QbEFjtqmShOG8+RLDTJAGTf2b9t1G+jhWAYHdWcgJENA/WWmoaDmr94o9d4WP
         NsiFXFvG+Ksmu3ZCa5ljq38mvaAr1Kw/3wZA/sRxOAfJjTwZFRwu/CqCqxhSVsRv5pI0
         2ru1+1+YxSaRqNkKZhyiFKnzL6TZXJ0RqzCt47BtdCxrywtH5zLHOdt17bYmZdejvDGS
         wYtlP/G/gbuMCDat9LfTJR1Cj1ajrqxCq7+hbnEoORC0ZjIn3qtURkN7sSU5V8qtKpfQ
         w8Cerr7lDHenMqi6RNa9GBmgQ2LDOFsScadn8ZSPJ4ndXwqzh8Zaoyw8a6tCG9bW6D4I
         ElBA==
X-Forwarded-Encrypted: i=1; AJvYcCVqmxcqSAIEB62meC8jyPj4z6FSSD4toEs0zk8ygQ1mTRHMkCb98HXUy4oe7LT/VT7CPXLAuSYL+F6AiObO@vger.kernel.org, AJvYcCWEvmwFcbAUbbF8ss/lFxek+XjgIRszIbtOzz+gOgl/7ZsH4IaGMxGPlPkwKHk4swAZvFU=@vger.kernel.org, AJvYcCWPM/mjGDCL2Oh8/BQ3/n6enYNZlIIqEgI+2oUfiy1NpWZeKmkRyy7BG+1HIkFQ/s4C3mxsE6J0DXjA@vger.kernel.org, AJvYcCWSsgoPesPjZjwp7AGBPgqo8VoZ1fd9oPk6VtojulZy5FsXxfVHZDhjVyClFH9P5pyLWTYFxw5FCn/+NE+4tUO0G4qJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzqBdkhoIsyzjxlHxg+L7+SHwtI5lsszKrQuIcn/4Kd5WHrtkPE
	TL46/ktS8148A4a0pTrxFbXkwNhf15VMzzPQln2BcsPW1aQNp52znAseFIy51UPBDASP5Ns4TkT
	6AgogpBRMtYDtHeL3UXnXj40YkjM=
X-Gm-Gg: ASbGncvoCCFSdVtkswEfYeXKmFA/p1B+Q1m2pZuN/y9rxILthvVDxeKHd/CUso/OMdn
	xpCbKFKihEdXssH8Wof2QDVAoIl4nYBLxvsC81Th1eNthiPWzylxj+Q==
X-Google-Smtp-Source: AGHT+IEInQ3nliq6U7ZDfH5HitS+QkRObpsN43yA3MrtfJWj+r/2ebIua7P3dNIdI+vx9PVbNXxWP+5rD3/ilEPL+Kk=
X-Received: by 2002:a05:6a00:e89:b0:71d:f2e3:a878 with SMTP id
 d2e1a72fcca58-72d21f10759mr34449002b3a.5.1736882518949; Tue, 14 Jan 2025
 11:21:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava> <Z4YszJfOvFEAaKjF@krava> <20250114105802.GA19816@redhat.com>
 <Z4ZyYudZSD92DPiF@krava>
In-Reply-To: <Z4ZyYudZSD92DPiF@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 14 Jan 2025 11:21:46 -0800
X-Gm-Features: AbW1kvYA3HYA9G3lAeXlMz62ogiBuaOIE4dkUTraqSnTw4PFa6AB1sY8EE_fAA0
Message-ID: <CAEf4BzZoa6gBQzfPLeMTQu+s=GqVdmihFdb1BHkcPPQMFQp+MQ@mail.gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Eyal Birger <eyal.birger@gmail.com>, mhiramat@kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	BPF-dev-list <bpf@vger.kernel.org>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, peterz@infradead.org, tglx@linutronix.de, 
	bp@alien8.de, x86@kernel.org, linux-api@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io, 
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 6:19=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Jan 14, 2025 at 11:58:03AM +0100, Oleg Nesterov wrote:
> > On 01/14, Jiri Olsa wrote:
> > >
> > > --- a/arch/x86/kernel/uprobes.c
> > > +++ b/arch/x86/kernel/uprobes.c
> > > @@ -315,14 +315,25 @@ asm (
> > >     ".global uretprobe_trampoline_entry\n"
> > >     "uretprobe_trampoline_entry:\n"
> > >     "pushq %rax\n"
> > > +   "pushq %rbx\n"
> > >     "pushq %rcx\n"
> > >     "pushq %r11\n"
> > > +   "movq $1, %rbx\n"
> > >     "movq $" __stringify(__NR_uretprobe) ", %rax\n"
> > >     "syscall\n"
> > >     ".global uretprobe_syscall_check\n"
> > >     "uretprobe_syscall_check:\n"
> > > +   "or %rbx,%rbx\n"
> > > +   "jz uretprobe_syscall_return\n"
> > >     "popq %r11\n"
> > >     "popq %rcx\n"
> > > +   "popq %rbx\n"
> > > +   "popq %rax\n"
> > > +   "int3\n"
> > > +   "uretprobe_syscall_return:\n"
> > > +   "popq %r11\n"
> > > +   "popq %rcx\n"
> > > +   "popq %rbx\n"
> >
> > But why do we need to abuse %rbx? Can't uretprobe_trampoline_entry do
> >
> >       syscall
> >
> > // int3_section, in case sys_uretprobe() doesn't work
> >       popq %r11
> >       popq %rcx
> >       popq %rax
> >       int3
> >
> > uretprobe_syscall_return:
> >       popq %r11
> >       popq %rcx
> >       popq %rbx
> >       retq
> >
> > and change sys_uretprobe() to do
> >
> >       - regs->ip =3D ip;
> >       + regs->ip =3D ip + sizeof(int3_section);
>
> nice idea, I wonder we get the trampoline size under one xol slot with th=
at
>

Should we just fix whoever is blocking kernel-internal special syscall
(sys_uretprobe)? What would happen if someone blocked that other
special kernel-internal syscall for signal handling (can't remember
the name, but the one that was an inspiration/justification for
sys_uretprobe)?


> thanks,
> jirka

