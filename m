Return-Path: <bpf+bounces-51730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964BCA3829E
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 13:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F268B170301
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 12:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648A221A43C;
	Mon, 17 Feb 2025 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W267dJ6j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB7C2185A8;
	Mon, 17 Feb 2025 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739794188; cv=none; b=KhEIxiJ5sIUieVUoVjX6wXkRvFL7m/E8Sn1RaOuxxKKANvjxJ5kB3AytmRzxF4us4XJG/KAZTEOVZwmvRQ8MG+9Y+gCxalLXjWwl9x9fyswvhYwmUaZOr/gsE0xt+2m8+gk88KzT3aOmRi3fmqDVRamEyoCyUxMRXP//8WQ5sTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739794188; c=relaxed/simple;
	bh=Inc0DYizA8KNQ76TznDJ4jYBwtNttsUa637XXQe72zE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSFNwQYg3Gi8QVszkcs52y9sVSKLBwE55+DJGeu/1hdbn9O6SPV5zEyEFULhguUAKE5vG2C4xs94JTS/BEaFw7xmt5SrXTYWjJolgNTV8MTZYKrMlQsyH76Fg5E525qZM2+lRLlsQHMDQrnbMwqC7R/5RC9Sn0DCRWmPltx+N3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W267dJ6j; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38dd9b3419cso2241312f8f.0;
        Mon, 17 Feb 2025 04:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739794185; x=1740398985; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eSFQgbvq+nNgV7Pls+43YmrvimRl0VvsXoAHq2jrYgw=;
        b=W267dJ6jRpk4INEYYLmNDUkAmeD4bA1PwAp8dcm+kXnJ3Q73MYS5TEepJIhqP5Ge3g
         paVhAS4SEzsqzL9ITYeaHNdgPTCgJybin8oBu9WDEaJLIfCQ3J0iWYLTbj9GlKjENI4h
         yehkXSv3TqnJQVinaubyAQ+Xr+vhujMhxn7eHOASpYln0qOLX8XnWangUv4A1Ajaln9C
         RJFrVHC4R4lOv6jQf206DPB3QtqeLwSY+uNFcTpXyZBkKhxSvdMPIO2PiKYhHbQIE2NW
         NzW9KayTHIp0c1JaOOo8HFfxgXCxR0wrCMccMz2OdWTnDoFLilYiN1eot+mvX1m0kS9G
         JmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739794185; x=1740398985;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSFQgbvq+nNgV7Pls+43YmrvimRl0VvsXoAHq2jrYgw=;
        b=gOJLm3e5uybz//qkwsFqDVB31C04SGk9TJO3v2fNEfgGuPb6JitjuoFe7X4mhVni6c
         jBv21lOG9R0YMMem/ZrHZctRJSf9Z8LpLciPzzuJjjQbnhi6V5k25YyJlubYTMwbq+RL
         gVrMbM8D1TzHP4RwDasbMI07CfnNB9tIL/yCZrJEF0RNQR4t4d+0Bkz2lYcNCoh2Yb5x
         qbb8sUbGdOzD9p2R8n45uMd+azJpC5TzZLtJI71wGbFT6P6w8BLS1aIwSzU89nO5lKeU
         OwDC536eN8pyfp6MvoIvn9rcZjzPGzB/tf4ZmYwKJXdz5/v8hXBDwKysMmE6uNwMH22g
         kQJA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ/Czgs1augz1PGsBvaILjwzGmq9VzaqqBpOcZMCat8+1aDnFZoV1Y4WYzoAqtqSQ14JHlDnk4rpGx@vger.kernel.org, AJvYcCVo65O9eStms4zeMo/bC2gJOUBMZb8DvgFgkPK6r5MEffcBX0pWTv8EIsZKF+QBFai4f562fqCy@vger.kernel.org, AJvYcCWCfqM6MnpkMOkJIuaOmtQzIH0H+s+2AHnmj2mFD6276K7CMvLkNvgfA13vIZq/XVqhaK0=@vger.kernel.org, AJvYcCWlmTaR4ZLYdKUqAC8HHiy+qBAT7pcFp2Ii7gVJyehiXewnZHKvoJBpi3Z4BNkYJ9PuIgme5u13SLg/rm2KzuGr9+Bj@vger.kernel.org, AJvYcCX2BntPeE8SlbwiSZUkFb5+6Qhjyx7ndduRRKqNFf8WYXUFUa/OXmEYh2c7Lwm3LBwsGFkkGWmb8U57oAqZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2PN3l99oyryJsSoulngZ8NuA/9ASr24/TP4lAbG7nv1TEGMGZ
	nGMIQHbdN77CfsFjFXmZ4+6yGrDf75MAlnEv68bWAWPAMq660uHJ
X-Gm-Gg: ASbGncvfbo93rb81GUqfbASB4e5VoIeEn9qh+wNJvH/xJb4sW1/sDy356cgrMl31uI4
	tgisXpS6ULgKZH+m6WFSH4XusBW4/YGppQRlw7azCSJVYXW2mmRiFUfQeXA5lKTgIYqNEhPVE4J
	Z9HHZL96cOqhbpTTw5hDqfyDJmJiIQBHnIBNXllLlqhzpGTV1OGISkvkI44n5j5z1uM53B4BZYT
	2ePHM+LMdvsn1BDUQITq+QRHQp1U6DjEM6b6H2KfwxLseMpqo0QZmiKP8encqNPIXho4w3rSN2D
	h3GsYhwi6ECy/YD4X3Doi142MNgJ/vo=
X-Google-Smtp-Source: AGHT+IGUXM3M95eG2ye29Yd/3FfkwlIr6guJPzqgoVosGmixd8/VUD2KiN9iIXdlnRjIK3DBW5mXIw==
X-Received: by 2002:a05:6000:2c8:b0:38f:277a:4eb3 with SMTP id ffacd0b85a97d-38f33f1199amr7927742f8f.8.1739794185289;
        Mon, 17 Feb 2025 04:09:45 -0800 (PST)
Received: from krava (ip4-95-82-160-96.cust.nbox.cz. [95.82.160.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dd5acsm12253193f8f.35.2025.02.17.04.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 04:09:44 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 17 Feb 2025 13:09:43 +0100
To: Andy Lutomirski <luto@kernel.org>, Kees Cook <kees@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>, stable@vger.kernel.org,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, bpf@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Deepak Gupta <debug@rivosinc.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCHv3 perf/core] uprobes: Harden uretprobe syscall trampoline
 check
Message-ID: <Z7MnB3yf2u9eR1yp@krava>
References: <20250212220433.3624297-1-jolsa@kernel.org>
 <CALCETrVFdAFVinbpPK+q7pSQHo3=JgGxZSPZVz-y7oaG=xP3fA@mail.gmail.com>
 <Z623ZcZj6Wsbnrhs@krava>
 <CALCETrVt=N-QG3zGyPspNCF=8tA4icC75RVVe70-DvJfsh7Sww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrVt=N-QG3zGyPspNCF=8tA4icC75RVVe70-DvJfsh7Sww@mail.gmail.com>

On Thu, Feb 13, 2025 at 09:58:29AM -0800, Andy Lutomirski wrote:
> On Thu, Feb 13, 2025 at 1:16 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Feb 12, 2025 at 05:37:11PM -0800, Andy Lutomirski wrote:
> > > On Wed, Feb 12, 2025 at 2:04 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > Jann reported [1] possible issue when trampoline_check_ip returns
> > > > address near the bottom of the address space that is allowed to
> > > > call into the syscall if uretprobes are not set up.
> > > >
> > > > Though the mmap minimum address restrictions will typically prevent
> > > > creating mappings there, let's make sure uretprobe syscall checks
> > > > for that.
> > >
> > > It would be a layering violation, but we could perhaps do better here:
> > >
> > > > -       if (regs->ip != trampoline_check_ip())
> > > > +       /* Make sure the ip matches the only allowed sys_uretprobe caller. */
> > > > +       if (unlikely(regs->ip != trampoline_check_ip(tramp)))
> > > >                 goto sigill;
> > >
> > > Instead of SIGILL, perhaps this should do the seccomp action?  So the
> > > logic in seccomp would be (sketchily, with some real mode1 mess):
> > >
> > > if (is_a_real_uretprobe())
> > >     skip seccomp;
> >
> > IIUC you want to move the address check earlier to the seccomp path..
> > with the benefit that we would kill not allowed caller sooner?
> 
> The benefit would be that seccomp users that want to do something
> other than killing a process (returning an error code, getting
> notified, etc) could retain that functionality without the new
> automatic hole being poked for uretprobe() in cases where uprobes
> aren't in use or where the calling address doesn't match the uprobe
> trampoline.  IOW it would reduce the scope to which we're making
> seccomp behave unexpectedly.

Kees, any thoughts about this approach?

thanks,
jirka


> 
> >
> > jirka
> >
> > >
> > > where is_a_real_uretprobe() is only true if the nr and arch match
> > > uretprobe *and* the address is right.
> > >
> > > --Andy
> >

