Return-Path: <bpf+bounces-51389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 761FFA33AD4
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 10:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C2A61692D2
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 09:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709CC20DD72;
	Thu, 13 Feb 2025 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkB5uNRJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD6020C49E;
	Thu, 13 Feb 2025 09:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437932; cv=none; b=LjmQas9DBguPANXmIZkgXNRmLtc+2X9YAib4/2D9Y/v6OfZztUOMNWFMamzZcBn6Mx0yM3ADYVX6ppG2AjHT0Hf3lNZ8iOY1UUkRPCQbkHmjDVsw4ODX4UIRD7ro6gxYn1Q0MksbHcIOgjxmvtKPcC8KJ8EZy68HMBNa7iC6468=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437932; c=relaxed/simple;
	bh=JPlerEw+HpIcTQO1AoV9HkgsXrH9Q7r63PdqOw1EkME=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DK/7TEsbwc/HrOyZAmUcqD5ypBYRIlOKuMoVGo7XBQWkMUKBE/qGhuUqkuMnuNiBZ+vfVjaUGE+nxnOm8xRTSs1YTirkXtFokY1DkQ3PFMww1UXsg9U/JdSm8qg04ifkddV2wj5p9bpypI//TwBZ7f+07cjeRSKeVG8/8HeBImI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkB5uNRJ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab7f2b3d563so130248766b.1;
        Thu, 13 Feb 2025 01:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739437929; x=1740042729; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kk8GoiJCBLwy0VGMO3TU9B+awh6BEc3xAZZDrhJYR4Q=;
        b=VkB5uNRJjqUC7rzjY+U4v+ylv5ha2vjEWxjL3XO6KbOiw2VU7P2YulK19n6BrMfPVh
         Oh0WqiIwTNhVFQC2+UjhYPgSzALE6yQ2abcFkhXBz35POFjlICnQdgrygGiTL8fh+Asd
         j5VoqctOzf76hMehq0C7ODcsFX1BlRQp3fivn6+72x54XSu4KxvPHUJPdFu3/K9QFVFj
         HrzvtKb+axeuTObPUzgnsEGTtl2cgE6eaHiej8n0dYo67vP30Kz4XKIyf9xdICJ2DRbj
         dsaLCqXZqlqj1z3skdOD0QkPxz/1++cSiVjSoqlTcqrsTS1EVItwFGiG4fABKeI3S59c
         cy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739437929; x=1740042729;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kk8GoiJCBLwy0VGMO3TU9B+awh6BEc3xAZZDrhJYR4Q=;
        b=uO1vUv0WmYS4D71MqyvpsANk4+jQKUbyEIU863RLQyV8wzW0yWOcmK9DSt3SVeDufo
         C0psicrrhECyV4D+mmEQ5K6h8sLcH+5iE4IoN3xn0fIHEVXkzz71ybYy+JwR3EXkgz4+
         yPK/7B4VZ6Sqr5yfbr6PGCFpIIzuYZfgmCdAc68s9Q0b0o+Lh+i8gAxZ5Msav9kfQx5k
         DYYgJM6Sjcc7jB6m5XXwdS3JJw3HzfF1zuvc5mwuhi9/KAXljv/sbYXaMv3uifJevKQi
         hMX+/X2jW4s0VzHeqxqOtttxoXkmOpMZrn+dVYHxru/65OdeZQOzABfa9oye9rsMzvjl
         6Tvw==
X-Forwarded-Encrypted: i=1; AJvYcCUMV5ncOl6vHXUH9nmUQzxDNGAzKiOZE/taVptbAQBEO4NcUNW7qxFmaj7tPqFStq5Jg0aSvry5BX9W4SkZ@vger.kernel.org, AJvYcCUmM8Ubyx0qWwZK/3eUVMeqrKynVW3ELFGMP40jKvOSpwoE3e21fyN9oekzeA7Qvg/+NGM=@vger.kernel.org, AJvYcCVhWHHRugOZY9cbIIuwRb+R1RwZLHqzBz2AYXLwf5NGcqSUymfx3QGHM6JcsawY2JlROPf+caxq@vger.kernel.org, AJvYcCWHvRWEB5v8NhGw9DZcWtMopzdsXCh8xiTD3gwVcGcZTdw0TX4232L/MfJLcPJq5ShAMIHuRSoV5Dm0LEl6ksP2/PbU@vger.kernel.org, AJvYcCXWbDy4bg796h9DEIsD5HdaYApq+3oaLARU10LGKOL8gUQFD7rlV8IO17C8n7JEY9TBL3h/GmAlU4tg@vger.kernel.org
X-Gm-Message-State: AOJu0YznvV8fO79wQoYLOzOUGjiBzVQATUTkpN+pu7a1caq9//paI/Yd
	1+zbfyVVBUJdzSuyyGeCKJ+ggfFyA1s4ysJ4C/g1qprViax12M6G
X-Gm-Gg: ASbGnctCxqSsloMuiPw/5skEJ51WYAiqq/a5Q5TZVRr2rz+3y9UUlB6MMZDkpmIT2AR
	zlDbpnSBTcmHWkju7VVAxIMDcW3ODWZrsDrhMJyqO2CBHfjMcrm1qN23mx89TUcIEowyjhQBMto
	OWm8BWPTR98QRNNP6SpCyjeDrMHSiFMd31KObaBkfrUDS1ZQYs0bnFGVL7RKNJTgig7NA3OkHRm
	EA/9DZklJ7oUcMC+zDf7NnIHcdv7i1nlf8RvYjisjv0+P/SranZnqlKuu3ed8jfbj8dwnHWwEWZ
	zw==
X-Google-Smtp-Source: AGHT+IGs3oJZf7x6yD/Cx3fNNknBE6YPrj9ItenyEdO+HvKskjnm0uGLWq5sjCosjH1kmhwkZqU1rQ==
X-Received: by 2002:a17:907:6d24:b0:ab7:be81:8940 with SMTP id a640c23a62f3a-aba4eb9b519mr235654066b.10.1739437928410;
        Thu, 13 Feb 2025 01:12:08 -0800 (PST)
Received: from krava ([173.38.220.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5337698asm88429866b.120.2025.02.13.01.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 01:12:07 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 13 Feb 2025 10:12:05 +0100
To: Andy Lutomirski <luto@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>, stable@vger.kernel.org,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, bpf@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Deepak Gupta <debug@rivosinc.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCHv3 perf/core] uprobes: Harden uretprobe syscall trampoline
 check
Message-ID: <Z623ZcZj6Wsbnrhs@krava>
References: <20250212220433.3624297-1-jolsa@kernel.org>
 <CALCETrVFdAFVinbpPK+q7pSQHo3=JgGxZSPZVz-y7oaG=xP3fA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrVFdAFVinbpPK+q7pSQHo3=JgGxZSPZVz-y7oaG=xP3fA@mail.gmail.com>

On Wed, Feb 12, 2025 at 05:37:11PM -0800, Andy Lutomirski wrote:
> On Wed, Feb 12, 2025 at 2:04 PM Jiri Olsa <jolsa@kernel.org> wrote:
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
> > -       if (regs->ip != trampoline_check_ip())
> > +       /* Make sure the ip matches the only allowed sys_uretprobe caller. */
> > +       if (unlikely(regs->ip != trampoline_check_ip(tramp)))
> >                 goto sigill;
> 
> Instead of SIGILL, perhaps this should do the seccomp action?  So the
> logic in seccomp would be (sketchily, with some real mode1 mess):
> 
> if (is_a_real_uretprobe())
>     skip seccomp;

IIUC you want to move the address check earlier to the seccomp path..
with the benefit that we would kill not allowed caller sooner?

jirka

> 
> where is_a_real_uretprobe() is only true if the nr and arch match
> uretprobe *and* the address is right.
> 
> --Andy

