Return-Path: <bpf+bounces-49273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F4EA16147
	for <lists+bpf@lfdr.de>; Sun, 19 Jan 2025 11:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9A553A6918
	for <lists+bpf@lfdr.de>; Sun, 19 Jan 2025 10:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34B11C5F1D;
	Sun, 19 Jan 2025 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8+psl9g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A91213C80E;
	Sun, 19 Jan 2025 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737283484; cv=none; b=mqXTQxxDZO8lj6lVNXire5heCv16NrUM8IjvLRVFkcuc4dZg64Rl0aF9bv/0vRhZJLZ6FPyppmq9MyXPZOHyDlojmu527JtVXVGaJK0QfF9vWAaRVbSfuS/GGrG7qQs11CheKOnRnIQCdmS1ythXBuBirjLKUrqlGxhFrZKNLmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737283484; c=relaxed/simple;
	bh=lb55ckuAR8lfHsBUK+wyTlK9di7ed3BL2MRAC9jPiQw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkWIfuVQhVrGQtjbyTAc0UhYOieo8M8NzxwvHEmyTyyB6Dezgqdw0rlNiMDY9+vHjNDHrD6sVBSrRl1IyeCYe5lnrWlAEKINq2sIPA2Y0HEfIs1sDNYygIQoHSaLehG1kmoBtwchSSulu7D/psLpexm0kxyjpL+9bxOF0t929ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8+psl9g; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab2bb0822a4so710123466b.3;
        Sun, 19 Jan 2025 02:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737283481; x=1737888281; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3iIRit5OxlfyRRtJQo/bMu4Bqq6EWcAF4iWmraH3mXE=;
        b=K8+psl9gnlHnjgHpRX+2DQJYD41Jq9F1K3GtdJDNKtLkMhItM/xXw0j/ChvxQm/asU
         etGvmEPa12Rq36kzeDjeuoU1ddcCzzqxI00bwDJwPp13llr92Rot0cDe52qWK3UuKbBt
         V/Jg9J9v/Nhqjo35hP8Rotpn8sZ61T5krV02vuDleto3G/DlDSHaqaXIp5+xR6AgYxUF
         eP5ODDED/trOe9a52Xjl9BbE1+pHve02/mevgeEQqTuTvSRTdFyg+QJGAcc/K2RQP/Xh
         6H2wnp0hM790j5/evxXrkbz6IKkL16+QQl4YO9Y/ZV0hpB4jK/HCpNIaE4oAbuoOx8dZ
         RVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737283481; x=1737888281;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3iIRit5OxlfyRRtJQo/bMu4Bqq6EWcAF4iWmraH3mXE=;
        b=A3vhLGtvbMLO18HBbrsAGa3hqkWwTBTccXzySbMMnt9jb19ES4o3ok1eqqo5EoDTPV
         Kw5E6XC5I2xRV3xB5K3Tlbf7MbNdA+zdEvqCJVlsCembkZEDB/FDAmFLdhQDz5SHzGYe
         KmIaLJVDxuD36F4HN5D24S8IpABOxswgdGs2xxzXBWvz7N/y1P3gN7+SfxfXqMM52WJ2
         LGazdqexAQlU7fZgW7Nu8Evko5G4mPjHNazJbRdXCjXQVFPDIxIU7NxBWccNPZXKk3PJ
         KjILVznvSoxpX3Laon3ss2izvDfosTmZi/uSeGIHbsPwwt5pCcw/lG+EF/DqRFn0lItp
         2sfg==
X-Forwarded-Encrypted: i=1; AJvYcCUzDXUBI3Kj2lGwBcGMAn6VYgemfm0EBcKAH1GB6JOVMbJG5y0Wdwzz9BmxALbTSxAn/0E0Z0F/pgbU@vger.kernel.org, AJvYcCVMSxAztRuQKDiYMRMkEPHfNpq36RLbCzijDionSOnOgqZ7m8eNvfQWl/sRraINzfU2UDmzKdqZ@vger.kernel.org, AJvYcCW2BMMoSWLsRgHkXglk6EPUWLF/ys+ICZxTg1CNB3Z93ijA13ZgMPRdv62VFPcD+jNdDbNI+854AjjLssAj@vger.kernel.org, AJvYcCWi8w48FdgpPT0n2l/9KiNZcPhHSSi5fLXe5MH5pK28IlM6QSrvcCrgddTROBIjbiBogk+Ip9pEChxKRRd7axDgLVf1@vger.kernel.org, AJvYcCX8Woo0cN+wLcOKn7RsAV3BfoJ4pQbw8UaJo7B+ZH87ZCGb7wjw3mwyjGR+Z0XhAfvs/e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnxSpQQ0IXP/MGTWw0+xmZro9MIkWqMHb4w3LT7WRdSiRuVqk3
	9Im12MGztLdkfyB6OJZsoKInvRHPEO2ITgMWuSCcwS1LL+WdvLLB
X-Gm-Gg: ASbGnctRf+9qLiq4ZnLfBCuYPD3ISYRpKEPX2khISyoQzd3eWEhhAhgDW0JczpRYnp+
	Foji+C5RSo8uv3jJr2SvzF6GP12cOnTW2TMTXNronMKKLCr3eNBTXgrINFHkaiTmXb+DaZKpAIR
	1H5RdUQYjfMl+7pu5To0Zc0SE17JXY2rEu0vsBtXShURq2ge5Qa0tOfQRAsPAGtfpP4bwG6E740
	l3V3HmDCj8SCGE0uvg63BV3ijDzYvoFXCR7AV4u6jkVyYOrKD7r0LqCn9L6aMzjwTSJYya5D3gK
X-Google-Smtp-Source: AGHT+IFqATT8PvJpKvb/VVEjpa3TsYRrBDKVeIlHRc2lfKM3C5t9z2K7SPemjwkQsLz7s3W0rPP7Tg==
X-Received: by 2002:a17:907:1c11:b0:ab2:f74f:3f82 with SMTP id a640c23a62f3a-ab38b3da0cemr816685566b.57.1737283480433;
        Sun, 19 Jan 2025 02:44:40 -0800 (PST)
Received: from krava (85-193-35-24.rib.o2.cz. [85.193.35.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f1e404sm474837666b.98.2025.01.19.02.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 02:44:39 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 19 Jan 2025 11:44:37 +0100
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Kees Cook <kees@kernel.org>, luto@amacapital.net, wad@chromium.org,
	oleg@redhat.com, ldv@strace.io, mhiramat@kernel.org,
	andrii@kernel.org, alexei.starovoitov@gmail.com, olsajiri@gmail.com,
	cyphar@cyphar.com, songliubraving@fb.com, yhs@fb.com,
	john.fastabend@gmail.com, peterz@infradead.org, tglx@linutronix.de,
	bp@alien8.de, daniel@iogearbox.net, ast@kernel.org,
	andrii.nakryiko@gmail.com, rostedt@goodmis.org, rafi@rbk.io,
	shmulik.ladkani@gmail.com, bpf@vger.kernel.org,
	linux-api@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <Z4zXlaEMPbiYYlQ8@krava>
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <202501181212.4C515DA02@keescook>
 <CAHsH6GuifA9nUzNR-eW5ZaXyhzebJOCjBSpfZCksoiyCuG=yYw@mail.gmail.com>
 <8B2624AC-E739-4BBE-8725-010C2344F61C@kernel.org>
 <CAHsH6GtpXMswVKytv7_JMGca=3wxKRUK4rZmBBxJPRh1WYdObg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHsH6GtpXMswVKytv7_JMGca=3wxKRUK4rZmBBxJPRh1WYdObg@mail.gmail.com>

On Sat, Jan 18, 2025 at 07:39:25PM -0800, Eyal Birger wrote:
> Hi,
> 
> Thank you for the detailed response.
> 
> On Sat, Jan 18, 2025 at 6:25 PM Kees Cook <kees@kernel.org> wrote:
> 
> >
> > On January 18, 2025 12:45:47 PM PST, Eyal Birger <eyal.birger@gmail.com> wrote:
> > >I think the difference is that this syscall is not part of the process's
> > >code - it is inserted there by another process tracing it.
> >
> > Well that's nothing like syscall_restart, and now I'm convinced seccomp must never ignore uretprobe -- a process might want to block uretprobe!
> >
> 
> I think I understand your point. But do you think this is intentional?
> i.e. seccomp couldn't have been used to block uretprobes before this
> syscall implementation afaict.
> 
> > So, no, sorry, this needs to be handled by the seccomp policy that is applied to the process.
> >
> 
> The problem we're facing is that existing workloads are breaking, and
> as mentioned I'm not sure how practical it is to demand replacing a
> working docker environment because of a new syscall that was added for
> performance reasons.
> 
> > >So this is different than desiring to deploy a new version of a binary
> > >that uses a new libc or a new syscall.
> >
> > Uh, no, the case I used as an example was no changes to anything except the kernel. Libc noticed the available syscall, uses it, and is instantly killed by the Docker seccomp policy which didn't know about that syscall.
> >
> 
> That's an interesting situation and quite unexpected :) I'm glad I didn't
> have to face that one in production.
> 
> > > Here the case is that there are
> > >three players - the tracer running out of docker, the tracee running in docker,
> > >and docker itself. All three were running fine in a specific kernel version,
> > >but upgrading the kernel now crashes the traced process.
> >
> > If uretprobe used to work without a syscall, then that seems to be the problem.
> 
> I agree.
> 
> > But I think easiest is just fixing the Docker policy. (Which is a text file configuration change; no new binaries, no rebuilds!).
> 
> As far as I can tell libseccomp needs to provide support for this new
> syscall and a new docker version would need to be deployed, so It's not
> just a configuration change. Also the default policy which comes packed in
> docker would probably need to be changed to avoid having to explicitly
> provide a seccomp configuration for each deployment.
> 
> >
> > >I think this syscall is different in that respect for the reasons described.
> >
> > I don't agree, sorry. Seccomp has a really singular and specific purpose, which is explicitly *externalizing* policy. I do not want to have policy within seccomp itself.
> >
> 
> Understood.
> 
> > >I don't know if seccomp is behaving correctly when it blocks a kernel
> > >implementation detail that isn't user created.
> >
> > But it is user created? Something added a uretprobe to a process who's seccomp policy is not expecting it. This seems precisely by design.
> 
> I think I wasn't accurate in my wording.
> The uretprobe syscall is added to the tracee by the kernel.
> The tracer itself is merely requesting to attach a uretprobe bpf
> function. In previous versions, this was implemented by the kernel
> installing an int3 instruction, and in the new implementation the kernel
> is installing a uretprobe syscall.
> The "user" in this case - the tracer program - didn't deliberately install
> the syscall, but anyway this is semantics.

that's correct, uretprobe syscall is installed by kernel to special user
memory map and it can be executed only from there and if process calls it
from another place it receives sigill

so at the end the process executes the uretprobe syscall, but it's up to
kernel to decide that and set it up..  but I don't know if that's strong
enough reason for seccomp to ignore the syscall

> 
> I think I understand your point that it is regarded as "policy", only that
> it creates a problem in actual deployments, where in order to be able to
> run the tracer software which has been working on newer kernels a new docker
> has to be deployed.
> 
> I'm trying to find a pragmatic solution to this problem, and I understand
> the motivation to avoid policy in seccomp.

I could think of sysctl for that.. you complained earlier about weird
semantics for that [1], but I think it's better than to remove it

jirka

> 
> Alternatively, maybe this syscall implementation should be reverted?
> 
> Thanks again,
> Eyal.

[1] https://lore.kernel.org/bpf/CAHsH6Gs03iJt-ziWt5Bye_DuqCbk3TpMmgPbkYh64XBvpGaDtw@mail.gmail.com/

