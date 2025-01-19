Return-Path: <bpf+bounces-49272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DA2A1601B
	for <lists+bpf@lfdr.de>; Sun, 19 Jan 2025 04:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46513A6B10
	for <lists+bpf@lfdr.de>; Sun, 19 Jan 2025 03:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB3074BE1;
	Sun, 19 Jan 2025 03:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0dGySw9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798C2EACE;
	Sun, 19 Jan 2025 03:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737257979; cv=none; b=KS55cJMU/f8zBnICgM85OUmK5NGTOD5+W+b1qEBDGGQoZAhlxVsjoaQF8Ay0oddN6Oqj0AUOVk4BDN/9On4q3mRNQG/cQHYiCcgxF82sVcdq8vTfLsuuVKq6evFkmuBfNyiMEwtjw79uLNAn0ve9UGo1LvjfE6Wl6wujd6zCpRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737257979; c=relaxed/simple;
	bh=nZPTlbAxlyNj0QUpe/LSO2IRljEZCJ1/ZSqHMjO6tDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSRZX0MV6Z+74SxYfJUe69j2W0mB82Kf9XWQpZWdXiVjKkPBW+wBxaewkdDoIIsUcPkufMqHcCvG6yogFAHB5N6tQExuGG/C4nspPgFkpTbgxqByK63yMMzkL+4jd7SgC9JOFm766yp8pa31/h7OEte9akmIEvQEMGPmZDmxPZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0dGySw9; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5f3397bef34so726529eaf.0;
        Sat, 18 Jan 2025 19:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737257976; x=1737862776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZPTlbAxlyNj0QUpe/LSO2IRljEZCJ1/ZSqHMjO6tDE=;
        b=O0dGySw9cuyOycrwcJlzjZr1v0uUeUdsW1ck7MmPRIgYpOJtaCV2dR1A5JcBM3u7Et
         6p87AmUTCzZx3cQ7xRuxxCNfhnJTE5dXN7gaKJQcL6Mmq6Cr71mIL2DTPPQFfTSgYmkQ
         IjULV88YK3jFOlIl46w2j5ReLcNTxcmpS0zaAgQXOM4+HjfL73jGwa1Bw7Kw1Co553r7
         P89MGEo+NRToQT69KWS2tVr7XTAge4Kug/9Z9zclDUE7O99zvjuKAICkwTfnHqlF7yJW
         CDjSrjGmUvsybR7agldBgqIedZ4BFNqqzyqYvuTdAEXl5CtMonTCKZ11RBWx3qgISg+E
         UKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737257976; x=1737862776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZPTlbAxlyNj0QUpe/LSO2IRljEZCJ1/ZSqHMjO6tDE=;
        b=VVoMpyrmn0IgYCigxfqv1rnhXlr9Qozp4NWSt0+gHy8ONVpjiwlcD8HMlpIaCjsp25
         4oBEzICT826rHtQDWsu28u1/sZHFEgEQvkQ8Xs2w1y+u7wqTalx1JLFBWbKq+r9tdacg
         V5cHOo4zkkbAUNxxNU6ckpoqNgLk8itWQSyG5pys0vZYbF1YAOLeNqivYYkjfta0NaPS
         IXHLZIFg7gY0WiO1NvzzWFfQhh5rR20CIbHNs2BMnwHRfCdGziYaiTbzGxvmO9HT6dta
         dbzwfSW2+X21QpL33W47wp05FInefSOVqSQZKEpzmGIRu2l/6dNEkGvjBAtJWUYm4UFF
         eQ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGeufV4+9M7NcZERSn9CBuk4U63qPB91EFSx4ZLzyh1S93rMWnV/EleMlJMtra7YNz8aC9IQqF82zBvmqPqve3zMwq@vger.kernel.org, AJvYcCVff2T5qFGJJ/T0gUJCh+kXlEHwnhlxLem2r/sS7t3uCnlezO8FjxCkoveZOzFSJ6kmu5Y=@vger.kernel.org, AJvYcCVzUCvujntcqLkJlviFgkuGfLaS42iSZUXBmfkcnDML0nxu8Aaq50vYCp6HVlOy4iYFyTvgGsg/JMQy@vger.kernel.org, AJvYcCWHU8v0lSwMFTrgBevJfjdY+eKMmMb6MVCThpqLxK3EmloWhDmZ1zhpCYmT7VaOhEHxKZK8qbVtnaZ0jbso@vger.kernel.org, AJvYcCXB1gayl5EjFtg0GOzRcrAgDMgWV1mn8RTRLjWwh60a+ZEIlQuyzYVV0nlrghFQVXH7oinUyX7p@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt6/0UH4EXm66tGG1pIJjRbji1dbrk5IxsPiMTXXYc8erumHpg
	SJgSlzqXEwt5loLuKoiLvkssnp2y63hurHECo9ZOXSbFqNSS8OZqF2H8jIEx5lt7Khyvm1UxVAw
	qFcTksvqMYe6IRxpdaJP76sn4Quk=
X-Gm-Gg: ASbGnctCaRJ8nwGfpZAoxxmLes8kEeVsAMh7W0667f0p4X5AEzwOUnhOAb65Yr2jrfg
	C4tKUaqPJPszqNNT9ymn7Ryo7p3CmPsbN/2UD615B6CHMtUhBcMg=
X-Google-Smtp-Source: AGHT+IHuZWw1I6Y7MUYZB9B5TcDlZ8glxCSPzNNQuG8GCBWeIP/AZca4FZ3kB2BHYgu45htQ0+RYiYlM/JBHCoopLlE=
X-Received: by 2002:a05:6870:6e14:b0:29e:1b72:7586 with SMTP id
 586e51a60fabf-2b1c0a299f0mr4654667fac.18.1737257976360; Sat, 18 Jan 2025
 19:39:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <202501181212.4C515DA02@keescook> <CAHsH6GuifA9nUzNR-eW5ZaXyhzebJOCjBSpfZCksoiyCuG=yYw@mail.gmail.com>
 <8B2624AC-E739-4BBE-8725-010C2344F61C@kernel.org>
In-Reply-To: <8B2624AC-E739-4BBE-8725-010C2344F61C@kernel.org>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Sat, 18 Jan 2025 19:39:25 -0800
X-Gm-Features: AbW1kvY4VpOklf4a2qiu78DNpmGPDhjHcLeVz5GvZrF3AHaV9TMUXeEozo3s6pg
Message-ID: <CAHsH6GtpXMswVKytv7_JMGca=3wxKRUK4rZmBBxJPRh1WYdObg@mail.gmail.com>
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without filtering
To: Kees Cook <kees@kernel.org>
Cc: luto@amacapital.net, wad@chromium.org, oleg@redhat.com, ldv@strace.io, 
	mhiramat@kernel.org, andrii@kernel.org, jolsa@kernel.org, 
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de, daniel@iogearbox.net, 
	ast@kernel.org, andrii.nakryiko@gmail.com, rostedt@goodmis.org, rafi@rbk.io, 
	shmulik.ladkani@gmail.com, bpf@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for the detailed response.

On Sat, Jan 18, 2025 at 6:25=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:

>
> On January 18, 2025 12:45:47 PM PST, Eyal Birger <eyal.birger@gmail.com> =
wrote:
> >I think the difference is that this syscall is not part of the process's
> >code - it is inserted there by another process tracing it.
>
> Well that's nothing like syscall_restart, and now I'm convinced seccomp m=
ust never ignore uretprobe -- a process might want to block uretprobe!
>

I think I understand your point. But do you think this is intentional?
i.e. seccomp couldn't have been used to block uretprobes before this
syscall implementation afaict.

> So, no, sorry, this needs to be handled by the seccomp policy that is app=
lied to the process.
>

The problem we're facing is that existing workloads are breaking, and
as mentioned I'm not sure how practical it is to demand replacing a
working docker environment because of a new syscall that was added for
performance reasons.

> >So this is different than desiring to deploy a new version of a binary
> >that uses a new libc or a new syscall.
>
> Uh, no, the case I used as an example was no changes to anything except t=
he kernel. Libc noticed the available syscall, uses it, and is instantly ki=
lled by the Docker seccomp policy which didn't know about that syscall.
>

That's an interesting situation and quite unexpected :) I'm glad I didn't
have to face that one in production.

> > Here the case is that there are
> >three players - the tracer running out of docker, the tracee running in =
docker,
> >and docker itself. All three were running fine in a specific kernel vers=
ion,
> >but upgrading the kernel now crashes the traced process.
>
> If uretprobe used to work without a syscall, then that seems to be the pr=
oblem.

I agree.

> But I think easiest is just fixing the Docker policy. (Which is a text fi=
le configuration change; no new binaries, no rebuilds!).

As far as I can tell libseccomp needs to provide support for this new
syscall and a new docker version would need to be deployed, so It's not
just a configuration change. Also the default policy which comes packed in
docker would probably need to be changed to avoid having to explicitly
provide a seccomp configuration for each deployment.

>
> >I think this syscall is different in that respect for the reasons descri=
bed.
>
> I don't agree, sorry. Seccomp has a really singular and specific purpose,=
 which is explicitly *externalizing* policy. I do not want to have policy w=
ithin seccomp itself.
>

Understood.

> >I don't know if seccomp is behaving correctly when it blocks a kernel
> >implementation detail that isn't user created.
>
> But it is user created? Something added a uretprobe to a process who's se=
ccomp policy is not expecting it. This seems precisely by design.

I think I wasn't accurate in my wording.
The uretprobe syscall is added to the tracee by the kernel.
The tracer itself is merely requesting to attach a uretprobe bpf
function. In previous versions, this was implemented by the kernel
installing an int3 instruction, and in the new implementation the kernel
is installing a uretprobe syscall.
The "user" in this case - the tracer program - didn't deliberately install
the syscall, but anyway this is semantics.

I think I understand your point that it is regarded as "policy", only that
it creates a problem in actual deployments, where in order to be able to
run the tracer software which has been working on newer kernels a new docke=
r
has to be deployed.

I'm trying to find a pragmatic solution to this problem, and I understand
the motivation to avoid policy in seccomp.

Alternatively, maybe this syscall implementation should be reverted?

Thanks again,
Eyal.

