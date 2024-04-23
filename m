Return-Path: <bpf+bounces-27493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 547C58ADB0D
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 02:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09CE1F22855
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 00:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4B0208BC;
	Tue, 23 Apr 2024 00:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvBrHPxZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD1B23B1
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 00:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713831578; cv=none; b=KK9hYseDU2wC4gi81DM3B4MSt22jQq9Ye6FUfXEy3vT0tl7j7STNB03+i1XR7jULmR3zgyNUb+OwJQNBaHOCYoAns4N2JkkJdJkQxvBvdxDRieQPydHrVRuyuWUcuk1II9UhH64b2UAHfFUT0Nu0pkI7QbmVO3QE58/u5s1vrbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713831578; c=relaxed/simple;
	bh=zJaI4J9nUXOLv86dpkjWP7vZXN7gQcC8ka584ZQmtkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ah97VkISY3unJ3hOP9AW+n9jjDuvdEN3XZNirOYpnZFYkAdIZEyCrVfcvZIXLcYdljC43pAs7eM1OfKfa7Yu033nJ1bWgfYmAM2O4F4aA5bHfuMGOPCP6+48/yFq0CIPz0jWfNJPEzgSmgZK9Iio0ZWmOrgO2iqVE5nzs58kqNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvBrHPxZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41a4f291f9dso12465615e9.2
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 17:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713831575; x=1714436375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLlzRTFAcFtl98xJoEUnAY+WWTCHtrEIDgh4Q1C0lFs=;
        b=AvBrHPxZd9tRrEgLOKOlSgtXZY0Sqlcfa5OYFemDoU8Aa/7w5NKTrhwcwlO0AM7i+p
         LSrw0Pc/C1XNGAg58aHnykESw1IC7V9GnKradsfmFF+MpTNNuLnlfpsc35//KKq4MTrY
         C6sr89ed2W+auoPy4RLG9vUTkdv/Z3msDxK8StuLpCgxFznp0Td0vhTMIW8oPP79oiuv
         grY7M65lhGO1Xuy4Uzrvi2sGUkxkWDtesLQvHz7VMBPE5+lVQ8km978A9lmAIqx3s0jo
         RxjL78e8bLX5oRdQpLD/ljWMNgtMRmU3PGZ9RT3Qhflvu9lcCtctNoUTP1k9CkrD4rGr
         1ViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713831575; x=1714436375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLlzRTFAcFtl98xJoEUnAY+WWTCHtrEIDgh4Q1C0lFs=;
        b=wAnzT6xWmA8d2Q00G5Xz86RMIS7VXpIFLh2U0YB9bjYpmZC3NHwjI68Lu3a4MgYmsS
         y3P7mL3I4nfLmTj4kX99HsN6daOeozH2KGVWUjZP477GaH+7K8NGRqW+hk2OTEDfU0vh
         JUr3DVmaRBHUBu4DHSXEkiWDyD04MTH6o5J29Zzsh1ZZZgWnmk9UZ7WEHQ5xXlGt874p
         kDMTv8PoBwNUs5BRccraqFEcAh6ux+WrZw6ZbmVzZizfchX0hKf9dXcc+efxHoqdO5/A
         gRaqj+80tTNtHDPUZUV3m/55Qbm9RaTO68ArVb4Zs8birh1RgNbTTo+eXTiJI3U6DIiR
         4+1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4fEwlhPfwrM5g5BlJX4n2QReYFnQEXWIW9MYjZHEn101J00fBF4e6Py6v3bBw20b8uFu57KC3muLj9nlegNse3sfO
X-Gm-Message-State: AOJu0YyU8m+l6UBDR8LEH++tsBk7dRXnSLc/6blGytOl1wS9oWnNuwon
	JNxttNcYqxmFEDZhD8ALJJ0bzr+k9/ULtFH6bRil8GouI6V13d+/TAShPwFbQP3rTE6MeuYqQzT
	ydTiqk+K2EMWE29CHW+AIwajnYHw=
X-Google-Smtp-Source: AGHT+IFpw/AmZClbJHnALGmqym9VavRccgjWEVVVlOYo5V7O1P09NK+Dz+F8SLtTPPB4RPnxBbZB+jc6QWY/JasBYNA=
X-Received: by 2002:adf:a4c7:0:b0:347:1c20:f262 with SMTP id
 h7-20020adfa4c7000000b003471c20f262mr7250276wrb.16.1713831574461; Mon, 22 Apr
 2024 17:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <093301da933d$0d478510$27d68f30$@gmail.com> <20240421165134.GA9215@maniforge>
 <109c01da9410$331ae880$9950b980$@gmail.com> <149401da94e4$2da0acd0$88e20670$@gmail.com>
 <20240422193451.GA18561@maniforge> <160501da94f3$4f8aef40$eea0cdc0$@gmail.com>
 <160f01da94f4$31201c50$936054f0$@gmail.com>
In-Reply-To: <160f01da94f4$31201c50$936054f0$@gmail.com>
From: Watson Ladd <watsonbladd@gmail.com>
Date: Mon, 22 Apr 2024 17:19:23 -0700
Message-ID: <CACsn0ck4FW+S6ewkFwAouQ1ObHx-2sYZsEv3qGi7LcsFywfzAg@mail.gmail.com>
Subject: Re: [Bpf] BPF ISA Security Considerations section
To: dthaler1968=40googlemail.com@dmarc.ietf.org
Cc: dthaler1968@googlemail.com, David Vernet <void@manifault.com>, bpf@ietf.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 1:32=E2=80=AFPM
<dthaler1968=3D40googlemail.com@dmarc.ietf.org> wrote:
>
> > -----Original Message-----
> > From: dthaler1968@googlemail.com <dthaler1968@googlemail.com>
> > Sent: Monday, April 22, 2024 1:26 PM
> > To: 'David Vernet' <void@manifault.com>; dthaler1968@googlemail.com
> > Cc: bpf@ietf.org; bpf@vger.kernel.org
> > Subject: RE: BPF ISA Security Considerations section
> >
> > > -----Original Message-----
> > > From: David Vernet <void@manifault.com>
> > > Sent: Monday, April 22, 2024 12:35 PM
> > > To: dthaler1968@googlemail.com
> > > Cc: bpf@ietf.org; bpf@vger.kernel.org
> > > Subject: Re: BPF ISA Security Considerations section
> > >
> > > On Mon, Apr 22, 2024 at 11:37:48AM -0700, dthaler1968@googlemail.com
> > wrote:
> > > > David Vernet <void@manifault.com> wrote:
> > > > > > Thanks for writing this up. Overall it looks great, just had on=
e
> > > > > > comment
> > > > > below.
> > > > > >
> > > > > > > > Security Considerations
> > > > > > > >
> > > > > > > > BPF programs could use BPF instructions to do malicious
> > > > > > > > things with memory, CPU, networking, or other system
> > > > > > > > resources. This is not fundamentally different  from any
> > > > > > > > other type of software that may run on a device. Execution
> > > > > > > > environments should be carefully designed to only run BPF
> > > > > > > > programs that are trusted or verified, and sandboxing and
> > > > > > > > privilege level separation are key strategies for limiting
> > > > > > > > security and abuse impact. For example, BPF verifiers are
> > > > > > > > well-known and widely deployed and are responsible for
> > > > > > > > ensuring that BPF programs will terminate within a
> > > > > > > > reasonable time, only interact with memory in safe ways, an=
d
> > > > > > > > adhere to platform-specified API contracts. The details are
> > > > > > > > out of scope of this document (but see [LINUX] and
> > > > > > > > [PREVAIL]), but this level of verification can often provid=
e
> > > > > > > > a stronger level of security assurance than for
> > other software
> > > and operating system code.
> > > > > > > >
> > > > > > > > Executing programs using the BPF instruction set also
> > > > > > > > requires either an interpreter or a JIT compiler to
> > > > > > > > translate them to hardware processor native instructions. I=
n
> > > > > > > > general, interpreters are considered a source of insecurity
> > > > > > > > (e.g., gadgets susceptible to side-channel attacks due to
> > > > > > > > speculative
> > > > > > > > execution) and are not recommended.
> > > > > >
> > > > > > Do we need to say that it's not recommended to use JIT engines?
> > > > > > Given that this is explaining how BPF programs are executed, to
> > > > > > me it reads a bit as saying, "It's not recommended to use BPF."
> > > > > > Is it not sufficient to just explain the risks?
> > > > >
> > > > > It says it's not recommended to use interpreters.  I couldn't tel=
l
> > > > > if your comment was a typo, did you mean interpreters or JIT
> > > > > engines?  It should read as saying it's recommended to use a JIT
> > > > > engine rather than an interpreter.
> > >
> > > Sorry, yes, I meant to say interpreters. What I really meant though i=
s
> > that discussing
> > > the safety of JIT engines vs. interpreters seems a bit out of scope
> > > for
> > this Security
> > > Considerations section. It's not as though JIT is a foolproof method
> > > in
> > and of itself.
> > >
> > > > > Do you have a suggested alternate wording?
> > >
> > > How about this:
> > >
> > > Executing programs using the BPF instruction set also requires either
> > > an
> > interpreter
> > > or a JIT compiler to translate them to hardware processor native
> > instructions. In
> > > general, interpreters and JIT engines can be a source of insecurity
> > > (e.g.,
> > gadgets
> > > susceptible to side-channel attacks due to speculative execution, or
> > > W^X
> > mappings),
> > > and should be audited carefully for vulnerabilities.
> >
> > I've had security researchers tell me that using an interpreter in the
> same address
> > space as other confidential data is inherently a vulnerability, i.e., n=
o
> one can prove
> > that it's not a side channel attack waiting to happen and all evidence =
is
> that it cannot
> > be protected.  Only an interpreter in a separate address space from any
> secrets can
> > be safe in that respect.  So I believe just saying that interpreters
> "should be audited
> > carefully for vulnerabilities" would not pass security muster by such
> folks.
> >
> > > > How about:
> > > >
> > > > OLD: In general, interpreters are considered a
> > > > OLD: source of insecurity (e.g., gadgets susceptible to side-channe=
l
> > > > attacks due to speculative execution)
> > > > OLD: and are not recommended.
> > > >
> > > > NEW: In general, interpreters are considered a
> > > > NEW: source of insecurity (e.g., gadgets susceptible to side-channe=
l
> > > > attacks due to speculative execution)
> > > > NEW: so use of a JIT compiler is recommended instead.
> > >
> > > This is fine too. My only worry is that there have also been plenty o=
f
> > vulnerabilities
> > > exploited against JIT engines as well, so it might be more prudent to
> > > just
> > warn the
> > > reader of the risks of interpreters/JITs in general as opposed to
> > prescribing one over
> > > the other.
> > >
> > > What do you think?
> >
> > I think the "should be audited carefully for vulnerabilities" phrase wo=
uld
> apply to JITs
> > for sure.  However it would also apply to any non-BPF code in a privile=
ged
> context
> > such as a kernel, so it would seem odd to call it out here and not in a=
ll
> other RFCs
> > that would apply to kernel code (e.g., TCP/IP).  But if others really w=
ant
> that, we
> > could certainly say that.
>
> Updated proposed text, based on David's and Watson's feedback:
>
> Executing programs using the BPF instruction set also requires either an
> interpreter or a JIT compiler
> to translate them to hardware processor native instructions.  In general,
> interpreters are considered a
> source of insecurity (e.g., gadgets susceptible to side-channel attacks d=
ue
> to speculative execution,
> or W^X mappings) whenever one is used in the same memory address space as
> data with confidentiality
> concerns.  As such, use of a JIT compiler is recommended instead.  JIT
> compilers should be audited
> carefully for vulnerabilities to ensure that JIT compilation of a trusted
> and verified BPF program
> does not introduce vulnerabilities.

But W^X mappings are for JIT (and avoidable by writing, then remapping
and executing), not interpreters. How about we just say "Executing the
program requires an interpreter or JIT compiler in the same memory
space as the system being probed or extended. This creates risks of
transient execution attacks that can reveal data with confidentiality
concerns. Methods for avoiding these attacks are under active research
and frequently depend on microarchitectural details."

Sincerely,
Watson
>
> Dave
>
> --
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf



--=20
Astra mortemque praestare gradatim

