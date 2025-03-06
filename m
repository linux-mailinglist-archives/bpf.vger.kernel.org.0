Return-Path: <bpf+bounces-53466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B143A54889
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 11:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6581732BA
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 10:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C64A204F6E;
	Thu,  6 Mar 2025 10:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmjxlUG6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ED8202984;
	Thu,  6 Mar 2025 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258640; cv=none; b=DJqGgOXvvbfyPydLnHE8JuyYD0PR9cq2EDIUBF0nhE4r0H5vPNSKRLtPccQLpLgEupIqiD4AdbG2uIKi4c8seqXB/8jwtIAK6Yv7Vs70V+L5S4n1Dp9ojvv1h5Vr2VadsnElM6KT17nIwEONqpb3Vhr6DN1PpqOpcH/99RoBvLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258640; c=relaxed/simple;
	bh=I9pdTKoLaw+6AaESsv4LPJeCEfXkPMTSZEKG9PY9KuY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2tpscL3q/9zV5OtjIJOKPigWmLbCNTlAh84qb2rwTIQSYwyFbF6Pw4+CKa++3dGsZFVbMXv/fWxFzDzXJ6yFTTwaoAmPUVcwEAKTziK0+ht43cfuCM69VVCbRQqSzOg2652Bsfh7eXNb3YVchJ7Es10on0dzUTqZPGpUKYik3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmjxlUG6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394a823036so4252855e9.0;
        Thu, 06 Mar 2025 02:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741258637; x=1741863437; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lgkMBhBzFh4GMW6txcVgpWsBqFCCmiQ9SftChtsfc9M=;
        b=PmjxlUG6VrJKmJPC6cd+uEun1KdKE+THkC4GWs67ZKj2jbJp/1g4JtGtXbsqEQmeZo
         xa3NRg9xSZua+CuuTFilX3ZZj70RrSuwKLd6xEf+GeWD1VfSnMb7FdW7kLrOSg/LoykZ
         2w8Rh8dbIebmg7XsXQ1nR8kMKK76/uQTMkQYjtlMC5TPrNqTzL/1418qAFJFTeUy3+Hy
         UiF/XXAKb1hMM2SDXGs+7e7QleH0G2atTD4k/aZ7h+JyDKraohBWjZk73mfAedKx5toq
         fSiOlHRm1Wx8Db4gFsxnyczi81ms358608cQYGQ1BtyZXODHeLlgGVEpK96hp7EZeida
         +0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741258637; x=1741863437;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgkMBhBzFh4GMW6txcVgpWsBqFCCmiQ9SftChtsfc9M=;
        b=DnmU+AmyGQUJvIQc43ZrWedLu8YVNK9IR4A0Vsbmi0hA5QZJbYt3LcsS7ke46ajTlc
         8IHCFRWZEimj8N5O6rr0HJ57uVd9D3mi4XZgdfiOHw9aPG5e6343PeZBJhD77hfcN3Qt
         zvU5rSSrXTthQDFHkVDHao0CJborEMP6o+MlQS3whJ3+tL47D8KXT0zKGfLzMoIzeSxF
         7GEimLqRQ8thTr/BPy6sZiEx1uXsqeZJwkRorTZ0n/oJajEpTdvTptQof0qeLDZY3bFq
         t73cgZBVUtiVRXXRQ2jCNFak8iy3eHfBd5Ha1b+gvaOvjwGAR08PYkOT3AB+UfV4Oy+M
         lUPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGGlg/GpDKulMPxPPZOmAhAi2kZFmO7RBSwXjYHCZlIJEWrG3AAQ9U5wy6S7F9f2bUtcEXWgXYqg4WF2V/@vger.kernel.org, AJvYcCUUY7hdyTI3q6ZNSmFmsyEhMdTOoys+7fXiuKTERsR8crdAz7hQLjUuSl6BcUPRsDvYkSZG1SOVIxWr@vger.kernel.org, AJvYcCVbJD9ckb7u53lcssV+yJrRPsBlwkWf9fm1/Lm9sKbxrvZPT3Y6O/kUyr8WAUJMS35IUrE=@vger.kernel.org, AJvYcCW0f4jWFDk/A+hgw9YIcmobkKkhdA4w41HRa+P7Kd/R7wVtox2hIvcrMB+AeMNd+J9+hW5nThci@vger.kernel.org, AJvYcCWdblM5mYu3Od982WBbTNg/c/KNToMio0epDMGyVi8t0WAWW81TuB/rnUOba6EE9J5+2MwRVLC71FtsmCrBfBPAGqFJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyol0cm7lv0K1Av3qib7fXvRlSgpgyRJEIcOXcTYDYYbfYyXQkU
	NSAzOBEQyk15M9907URiY8qmKTSWwu+SMlkmXSRjIKOUHbpfAcIadlX+wTaGHis=
X-Gm-Gg: ASbGnctErop6Lcri2Leua4OkAor+I/vMrdmOn+Afky7YaADGvIiDekz+36KQeiDPm95
	0dEWuVxvXPiKNr8tCZJs9LYYpa6YD1kMCcsECOAmqiIqq7THFj7ETWXhpDQgvYjMNsOI7Jk0UPd
	nly83edHLcjBLhpr7BHQr5RCpgnX7Sn95rdPuVEpkw5/k4IfMzO3WfYDbjz8pFMsO2H8m3677ni
	GDq8bEw8FiS2WqoluuLT0nYJVwJKATFesF7/FQQEg76rSo1cZ1DwSXu6fLAU9jcbwnhgPymvSyo
	A0UHij5u+GvXXH440irrcZTvl+CxWORITxtuxQ==
X-Google-Smtp-Source: AGHT+IGLhJA7BskK5ld+jvgOXMpsvckCM2ZvvuLBgJH2nBAC7Z74GOkDTinBbaMSWaLdw5nhhGwZtQ==
X-Received: by 2002:a05:600c:3205:b0:439:969e:d80f with SMTP id 5b1f17b1804b1-43be1d8de13mr4102405e9.31.1741258636883;
        Thu, 06 Mar 2025 02:57:16 -0800 (PST)
Received: from krava ([2a00:102a:401e:9b3a:b228:9e66:580a:3bc8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb79adsm1674487f8f.7.2025.03.06.02.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 02:57:16 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 6 Mar 2025 11:57:14 +0100
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>, Kees Cook <kees@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <Z8l_ipCn8tBE1d9Q@krava>
References: <20250212220433.3624297-1-jolsa@kernel.org>
 <CALCETrVFdAFVinbpPK+q7pSQHo3=JgGxZSPZVz-y7oaG=xP3fA@mail.gmail.com>
 <Z623ZcZj6Wsbnrhs@krava>
 <CALCETrVt=N-QG3zGyPspNCF=8tA4icC75RVVe70-DvJfsh7Sww@mail.gmail.com>
 <Z7MnB3yf2u9eR1yp@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7MnB3yf2u9eR1yp@krava>

On Mon, Feb 17, 2025 at 01:09:43PM +0100, Jiri Olsa wrote:
> On Thu, Feb 13, 2025 at 09:58:29AM -0800, Andy Lutomirski wrote:
> > On Thu, Feb 13, 2025 at 1:16 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Wed, Feb 12, 2025 at 05:37:11PM -0800, Andy Lutomirski wrote:
> > > > On Wed, Feb 12, 2025 at 2:04 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > > > >
> > > > > Jann reported [1] possible issue when trampoline_check_ip returns
> > > > > address near the bottom of the address space that is allowed to
> > > > > call into the syscall if uretprobes are not set up.
> > > > >
> > > > > Though the mmap minimum address restrictions will typically prevent
> > > > > creating mappings there, let's make sure uretprobe syscall checks
> > > > > for that.
> > > >
> > > > It would be a layering violation, but we could perhaps do better here:
> > > >
> > > > > -       if (regs->ip != trampoline_check_ip())
> > > > > +       /* Make sure the ip matches the only allowed sys_uretprobe caller. */
> > > > > +       if (unlikely(regs->ip != trampoline_check_ip(tramp)))
> > > > >                 goto sigill;
> > > >
> > > > Instead of SIGILL, perhaps this should do the seccomp action?  So the
> > > > logic in seccomp would be (sketchily, with some real mode1 mess):
> > > >
> > > > if (is_a_real_uretprobe())
> > > >     skip seccomp;
> > >
> > > IIUC you want to move the address check earlier to the seccomp path..
> > > with the benefit that we would kill not allowed caller sooner?
> > 
> > The benefit would be that seccomp users that want to do something
> > other than killing a process (returning an error code, getting
> > notified, etc) could retain that functionality without the new
> > automatic hole being poked for uretprobe() in cases where uprobes
> > aren't in use or where the calling address doesn't match the uprobe
> > trampoline.  IOW it would reduce the scope to which we're making
> > seccomp behave unexpectedly.
> 
> Kees, any thoughts about this approach?

ping, any idea?

thanks,
jirka

> 
> thanks,
> jirka
> 
> 
> > 
> > >
> > > jirka
> > >
> > > >
> > > > where is_a_real_uretprobe() is only true if the nr and arch match
> > > > uretprobe *and* the address is right.
> > > >
> > > > --Andy
> > >

