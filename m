Return-Path: <bpf+bounces-30163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95C88CB501
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 22:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84EF228135A
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 20:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E458A149DE1;
	Tue, 21 May 2024 20:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1luYuIv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EE7148820;
	Tue, 21 May 2024 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716325068; cv=none; b=N9NfLSqrH4WVjBOI6Gpv1jyOrlQ7X1C4fTOzlqEOtYFMfEvPjBozFENYya7SpcxKOmB7Irj/dENncNnkERFRsImzsxtjq/WlQVP6EyLXUimPfh4Z3DqnWW1eqwE/BWHb7AbqaMyqzaCPirqmo2CcEGPwu2O1ZBtppsHpTpQPwvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716325068; c=relaxed/simple;
	bh=XvVQOYneXy31VQpI3gd6Ge47sV41dqcKNHKiTVXFSHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+k3U/I0xqQTF05S2IUa0sN6WFMfbnOS7SVpuXqyPHPMYMPYALX8rH9khL3VG5adjtPPR0PVpsGE0W+N/p1S1FkKf2s7Kr4zaf/i+pjcoScnaqQ8pwufyQYuHznNwwXpvRZhvPhDOKNWi4i2I7VdShP09HSZYho2m6W++kNH+Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1luYuIv; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-351ae94323aso107839f8f.0;
        Tue, 21 May 2024 13:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716325065; x=1716929865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvVQOYneXy31VQpI3gd6Ge47sV41dqcKNHKiTVXFSHM=;
        b=a1luYuIvlmbLWwWyv5RDPccdKQzJp2cPCcVDKn57bsIYvXwaZYGquvnFNCkP2TC/CA
         YSdpHK254F0Dgp33Hf9UriNsmIFuHA+QCPZsx4MxpC6OtyWXhbGQYnW/OyQXIK06LOXQ
         WGcHA/o89D6e8qKrVGhu+iHfEpwIUZQ/vUbi/5YcUOChjOGuWDf2bWTcriujHLaa9Rfo
         D8QOlifsfKilG02btKLe/4HUvF0yGB4KUrCxMr/74JeiK2LuvuxHQukhXc7WJ91qjHpA
         wrm+AQCIZXyVnW8UC2rUOggfO8bJmCGCjgxtkqWX8aLKBj74rdTVIKPYctkkt1CA/cNs
         u6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716325065; x=1716929865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvVQOYneXy31VQpI3gd6Ge47sV41dqcKNHKiTVXFSHM=;
        b=l64dw9+ekuh45XV93eT7YbIF7tnB6NbCK9hVLO788JmA03K810ahsN3QLRe3IYvgHP
         sF3AS1GtE9vD1dBvVTI96/Aj3DCcKq/FiiJu3y/IE6nCS21N73yf0Pz2gT3oPaEfJ3U7
         QR8qoDNVQVUEFWzNTr2AHuG1gS8o0XJwBd5jVxX40HYrUctBodYcvuVxl1gNFWdQV3N2
         fZsw+pdS2kDXyIeAb9pUeLCtb8gk6ciKU7wZFYwX0Z9j5YJZunRJ/+uW2LuhzA2e2AXl
         O6RgMLlXB3AU4YalRkG788SZkbY+UyQEb8Xk0/mWTIMopwSK7t1ChTAA1iPtZYBDoerV
         b90g==
X-Forwarded-Encrypted: i=1; AJvYcCViMqwE+ff/ErO04LV2HRR0isIKCyMBXYSdZPPgx5SbVCjSoSKLISFbCR3VJkcSYPC47JyX/88hBNB2fcte6yoIGO2aB0J6p8XNjB4r5GnF3+11q9dpzn7CcGb1Pbi+amVcgTmyP7X7HLQ4ivfiVmY6u154Lks9r9WrQSoBEySv+lDUhLxCCxg+dFaltD/AIyZ9QOFmp7rEUvwvWGpoW4pdEOw0maszEVG8kKp0WA3aR03vTGePWjshxyxp
X-Gm-Message-State: AOJu0YxpvnlLCE+r/vbk52NQiCyMwUG+l7F+xEWNZdvWbJsdeDROWtg/
	lwFSvC6h8/DtSLrVgwZUL9tIAZXtkv4B+AeGSUCdXCLZfA0LzxlBhnsjKpzAPE/EKjM/SGJP5r2
	bpW6/AzFfwUfoY8hBNvJqyzGMVwI=
X-Google-Smtp-Source: AGHT+IFAgV+GWbFNqcaKR32yK6SKB8385j+pIi2sH0h+JACJbcr6SPrKTSjXHv3VoaWXb55zX1+6+g5xDwPZqg+gYxE=
X-Received: by 2002:a7b:cb07:0:b0:418:f991:713f with SMTP id
 5b1f17b1804b1-420fd319981mr86955e9.23.1716325065000; Tue, 21 May 2024
 13:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521104825.1060966-1-jolsa@kernel.org> <Zk0IvZU834RQ7YKp@debug.ba.rivosinc.com>
In-Reply-To: <Zk0IvZU834RQ7YKp@debug.ba.rivosinc.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 May 2024 13:57:33 -0700
Message-ID: <CAADnVQ+2Q1992e9mRtWOavHfqKsFUxPp4f6MAAJg90TK_KTpew@mail.gmail.com>
Subject: Re: [PATCHv6 bpf-next 0/9] uprobe: uretprobe speed up
To: Deepak Gupta <debug@rivosinc.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, 
	linux-man <linux-man@vger.kernel.org>, X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 1:49=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> On Tue, May 21, 2024 at 12:48:16PM +0200, Jiri Olsa wrote:
> >hi,
> >as part of the effort on speeding up the uprobes [0] coming with
> >return uprobe optimization by using syscall instead of the trap
> >on the uretprobe trampoline.
>
> I understand this provides an optimization on x86. I believe primary reas=
on
> is syscall is straight-line microcode and short sequence while trap deliv=
ery
> still does all the GDT / IDT and segmentation checks and it makes deliver=
y
> of the trap slow.
>
> So doing syscall improves that. Although it seems x86 is going to get rid=
 of
> that as part of FRED [1, 2]. And linux kernel support for FRED is already=
 upstream [2].
> So I am imagining x86 hardware already exists with FRED support.
>
> On other architectures, I believe trap delivery for breakpoint instructio=
n
> is same as syscall instruction.
>
> Given that x86 trap delivery is pretty much going following the suit here=
 and
> intend to make trap delivery cost similar to syscall delivery.
>
> Sorry for being buzzkill here but ...
> Is it worth introducing this syscall which otherwise has no use on other =
arches
> and x86 (and x86 kernel) has already taken steps to match trap delivery l=
atency with
> syscall latency would have similar cost?
>
> Did you do any study of this on FRED enabled x86 CPUs?

afaik CPUs with FRED do not exist on the market and it's
not clear when they will be available.
And when they finally will be on the shelves
the overhead of FRED vs int3 would still have to be measured.
int3 with FRED might still be higher than syscall with FRED.

>
> [1] - https://www.intel.com/content/www/us/en/content-details/780121/flex=
ible-return-and-event-delivery-fred-specification.html
> [2] - https://docs.kernel.org/arch/x86/x86_64/fred.html
>
> >
> >The speed up depends on instruction type that uprobe is installed
> >and depends on specific HW type, please check patch 1 for details.
> >

