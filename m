Return-Path: <bpf+bounces-51340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AF1A335AD
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 03:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A8A188B20D
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 02:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F522046B2;
	Thu, 13 Feb 2025 02:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ay+0USiZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934781FECB4;
	Thu, 13 Feb 2025 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739415546; cv=none; b=Cq+XDJbKxQLHldGHzaEhfbc6bTUBtVeqXUOpWlJnQv0HITQ6hbCOZDXGLHi5eqroOF2qkBXpIB08UdyKFObyVI8Z4/OgGK2N7IungSBt4efA8XkFyQOwr3e24FHo2UbFA3ImVbB7tBbd9KErWYTR9TFYsXlaPtL/WZ6bCe/JyYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739415546; c=relaxed/simple;
	bh=sm/A5DDYfWFWU/VotvaDeerUCy+HMeubsXLRAwDtoso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fm9q6F0nOTMOhuhaCSKOktwHJVBh4kR14sILxq0uTQ8qGTokIcwr82iTLZ3wCx2uN89rr+zV23G+UmSi5RoHzWVJMvKXWhY93L18KTMBIP09RtqnCFsyxddxn55aiptGUEL28iQmWBt1yTI4foGAcAwHhZZlxe6Rd4QQus71LH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ay+0USiZ; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2b1a9cbfc8dso154912fac.2;
        Wed, 12 Feb 2025 18:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739415544; x=1740020344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4ZQSX+iTddF0FgfN0z+bWuH3PadR/0Ql3Bz3nbWzqU=;
        b=Ay+0USiZYpA/DBrmxiINHo1fbxc1NUC7Q2sieYelefXtbKBo2SoX/oAVYkh6BS7BF9
         coVznKfKEeBFFE2QDj+8lTC8UE7iNNx95TpJ+WsBLcOZNXpOJ+1zN/2QRu+lA+fi6w5f
         cu3C0X1rM/XtvMHdGDDt25n4joRbeQ68CZTJ2QvPuPOLnGsmafecwI39BLkBdYaSMR8R
         JGK9UD1sbD4XOz0N558ul4z+wtueYGy0GSsaZz43o/0ilRw1zZ33Y/BYA9Q3CT+DoXZQ
         q741ZCwI8suUs7vefJCYP92BlId/KY2a/JPsb2k0ihh9uqLAJSLbAo1fibfS7M2nB7WZ
         FJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739415544; x=1740020344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4ZQSX+iTddF0FgfN0z+bWuH3PadR/0Ql3Bz3nbWzqU=;
        b=DsLWVfQtQ5rBLU/owdJqCJda6q8ZbwX31nGwawmSujUbb0YBqmCWh5sxBujk90XBoc
         rBlnPpKLyWdnsq7wEeURgA9UfGP2WQW/FTBUP3KyzjMqzyEnnPivNnV/EBiyPJcZTdDE
         3YOcsDbIbHsDLVY3slnr2Jlyx5BBegfxBCDUktwh6RJte1BWf3CVJ33SZR4LlcaakBlk
         /U/YrK0fjLQC8ZoPJvJf/DbIIydems4po0QnwaPw9nSY3P9G3WQIJX9vHzWLtsAd/yDK
         Lkt31pzWAzFlPGLa+XaDwQ+zkNFWZlzxf7sVWKWUef4lNQPNfOrFr28SG4rP4EIXFU5Q
         knxA==
X-Forwarded-Encrypted: i=1; AJvYcCU5U5Mi34o4/PRVw8ZxOUjuQjt0ttjaadYGEe0KKz79OG3sKYegidbu0dAajRCxe5ZN05E=@vger.kernel.org, AJvYcCUqyRVJjnTWYdV4jhFsxKgRV1FIza1p9liU5hFTudNlYBpxUKYASLBBKLxeHBVS6YKu35e3s3s+jnqRV//rlAmHqplS@vger.kernel.org, AJvYcCWGInCIwF1AQmHOgX0VMmwUImltoVBhix0Ee4yAPdaz34yPDna8l8J+6YHtuLE+LBZn3z5JcqzeydU7CFwe@vger.kernel.org, AJvYcCX5vzqYtT3UCloNkpQgRRkiPsmbPxkZvSoNhXknpY//eoFzx+0ogP67Xs67uSyYFXpXLf6WhHxKPT3O@vger.kernel.org, AJvYcCXOk4r1TDkVpdmKxSJPAiFK4gtoapC1yeqDB/LT9o3cn0ygjiVZowR04VdO4wkKgLnGU9d6vg9H@vger.kernel.org
X-Gm-Message-State: AOJu0YwqOofyjkX/Bu2ORkY0+vfL5i9XEefB3euDeTumEVlM7at1Odlf
	tP0+xpQJWEqU6zG/OW9/royTBiQn3b6H4D2z17b77h25oLCxjufFx2BBAHFJA4WOTf1DM2wZmHS
	MOxSAAX2q5y66WRdpckFgNKGIYHw=
X-Gm-Gg: ASbGncseUdqhvE+silbszctwWCp0OOL5SBv1LbL/Xk4TCKwZvka4pk4lwbYa/ZPmmDT
	s2fKhG7vD661dhW2EN3tyC/uVF5lNVzKsuYsAXAA7Ja65R9uHn7KBjBk52svziF2IU/4t3CIY
X-Google-Smtp-Source: AGHT+IFGA+xw9PUj3EPyBJDEfnct8a80eDqwi4eIT1nLpiELpYVP3ZL5tJreXFrsqRlNLfGgFswLTHKffTwAIuAe19c=
X-Received: by 2002:a05:6871:10b:b0:29e:2422:49f9 with SMTP id
 586e51a60fabf-2b8d684addamr3452293fac.25.1739415543729; Wed, 12 Feb 2025
 18:59:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212220433.3624297-1-jolsa@kernel.org> <CALCETrVFdAFVinbpPK+q7pSQHo3=JgGxZSPZVz-y7oaG=xP3fA@mail.gmail.com>
In-Reply-To: <CALCETrVFdAFVinbpPK+q7pSQHo3=JgGxZSPZVz-y7oaG=xP3fA@mail.gmail.com>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Wed, 12 Feb 2025 18:58:52 -0800
X-Gm-Features: AWEUYZnrOGezMYWshN0W51Wq8NuAF6Ki9dZJOYg4qrtbtnzm3Yom2efk1PBRoAQ
Message-ID: <CAHsH6GtYpH++etxpa4YDkW5PQTLRA5QiZ8fqBViwZV4+yXG5+A@mail.gmail.com>
Subject: Re: [PATCHv3 perf/core] uprobes: Harden uretprobe syscall trampoline check
To: Andy Lutomirski <luto@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>, 
	stable@vger.kernel.org, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	bpf@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Deepak Gupta <debug@rivosinc.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(sorry for the HTML spam)

On Wed, Feb 12, 2025 at 5:37=E2=80=AFPM Andy Lutomirski <luto@kernel.org> w=
rote:
>
> On Wed, Feb 12, 2025 at 2:04=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrot=
e:
> >
> > Jann reported [1] possible issue when trampoline_check_ip returns
> > address near the bottom of the address space that is allowed to
> > call into the syscall if uretprobes are not set up.
> >
> > Though the mmap minimum address restrictions will typically prevent
> > creating mappings there, let's make sure uretprobe syscall checks
> > for that.
>
> It would be a layering violation, but we could perhaps do better here:
>
> > -       if (regs->ip !=3D trampoline_check_ip())
> > +       /* Make sure the ip matches the only allowed sys_uretprobe call=
er. */
> > +       if (unlikely(regs->ip !=3D trampoline_check_ip(tramp)))
> >                 goto sigill;
>
> Instead of SIGILL, perhaps this should do the seccomp action?  So the
> logic in seccomp would be (sketchily, with some real mode1 mess):
>
> if (is_a_real_uretprobe())
>     skip seccomp;
>
> where is_a_real_uretprobe() is only true if the nr and arch match
> uretprobe *and* the address is right.



Why would it make sense to rely on CONFIG_SECCOMP for this check? seems
this check should be done regardless of seccomp.

Or maybe I missed something in the suggestion.

Eyal.

>
>
> --Andy

