Return-Path: <bpf+bounces-50173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D028BA236FB
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 22:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0752716508D
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 21:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E69C1F153B;
	Thu, 30 Jan 2025 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MljO4/1x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C1A1DA5F;
	Thu, 30 Jan 2025 21:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738274035; cv=none; b=WRwX80/F1SOd6Yne8xpTPBSpJPydKCRt0iPeqrUjlZP3o9l7k9CwASIRQ1Y6egMyHNx9hG4D/px0DsiwR+xx/9W1TU8iXW5KG5I/W2aOuM5vtwx5cY7N4WsDKp2JAYmaSaMITeIhVhFE1CxxwM3j+r3T8zQs2GME1CGIGKDr2H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738274035; c=relaxed/simple;
	bh=BlisCc4UQ53UOk7mUSn+L0PAgkzzYubPamyOMdZ/dbw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iw/j186Fcgywogk75f4uI/XVREZyjWZF0a6E6cqPD9oeiCt5oQU3bHJAGPOUF0LOT7dyUIJWJfZ70Uk+HmuyOFtfgmpRA2xe67+K5HBqS+VJqUXeB1DEHNPvs9JcvBAcZyEF/1eVj6DLuqokLw68petGQl5tdKmVF+zGqA8S264=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MljO4/1x; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3863c36a731so1042024f8f.1;
        Thu, 30 Jan 2025 13:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738274030; x=1738878830; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SElByFX55HRRZEi5sy6VH1uZg/J2K83OEEcHgYpO8qo=;
        b=MljO4/1xMEpoMlflKETNVosK0MR2+hbcv7QJqvU/UG1bM+GqE5ZAuLU1ftIuwneNyt
         cVXu3TwgDbM+ot+FQN2elkLI+fd/2lobHrDpr2DbNnO59Qe17lUnTfl87hP1gQF3AnI8
         GPOg8JMEm3N5zpQIXRvH1q7X06OzY8BPmH3XtnUykmUZNiwXrht/JbBYI5WsbZndTz6T
         o1a9eETYyr7Sa0+NnGwa9Vp77KbkKbMtVFbd9DSQnAcRYl4No5pjvS4nuhPPNZcMIY5b
         zooql22dy1ALxnufx7qlDgcUbUXQUg4zmraR93mn+dbmYuhHKrPs5olgyGWay6I7EJ4f
         u4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738274030; x=1738878830;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SElByFX55HRRZEi5sy6VH1uZg/J2K83OEEcHgYpO8qo=;
        b=acNvMw0yQ1hAdKLFXj+1dt5fM1Npt08cHzTcq6Fit02s1JK9KAIW/0RkD9gZmuu6Uq
         g7+VKJQSVYj0aNKnSRwB1M6QZCAyUctSyIzFxpNNSJ8FPQLc2FAR+FkT+wNy09Xq/moD
         X9WdPZEgoIdlIjJIlTUeIQQmrw5u35NQJLGu66HWezfxnLSRS/XGdl9yNAwZPHomEvpD
         QmfEX0ykVkby53diB7cOrKS1/XqhWIVSKcCvsmd3H4pHcu0LOxfSHhY8/a+Og/4jnpoy
         6mKtpEiPEVy4NjZesOxmyffsd9ce87s244sWBdZtyY/9RVadNrFSjXE76ChhAdnUQZS8
         gRNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeHTA07fxL6J/ZTjOFXXlkPIO1KdpkZlw/ot4gvvWt3IM43Q734bRXV1Lz0NAmrM6VvAc=@vger.kernel.org, AJvYcCW5jEjnRVEQkSdREKmLyHYaIU5F+CTRpw+1ttsStFoHVKpwDWEiuo2T6776O/Ir8ZAQRIzJsFIJ@vger.kernel.org, AJvYcCWAXHJFEvk0Jinm+PkPTOKOgWZDVJYdwFRyOyMObWG+pY1asrC//p/x10DziIILmSvYZOwWc3SfAE/5iBnW@vger.kernel.org, AJvYcCWWYQzrqp+DwajXyK7nlXsWCa16nylSwQI+yfJEVezzOEMuTDdRBq6I4Dg7hyzGhC1VZ351gFh58rI+@vger.kernel.org, AJvYcCXXIvoTmse6LHuuN1C+XRbq563FziPVOeUR46oquoznclbZFKzDKY+YvaN0xDICnAld5l3MrifzYD8Z2WLlsRYyMJx8@vger.kernel.org
X-Gm-Message-State: AOJu0YzKt6W3N5TZcJbV5amaQi1hZr4QQeEniXqiG8BoswUsWTcU8GlI
	bNPa7bFj6a/62RmW/lswQ/BHJ+z1bGfnM6w2GxHjgJCEYbQC7ckD
X-Gm-Gg: ASbGncv7aOW000pZS5BvD0KSYSWqh4L3hbIsnz5qburUJCNfjLkSZuOFhZ0HaJHKcyJ
	8y5gbEUGC4m6dhpHXN2o5I7sA9r+BYG5hgrH/S95H8b1R/JM/tU3epeBVezVC0LPfzVfUzNLEMC
	X+5lMKOovUi0rV1zsp1E/AtNihNNEw7tTmYmdILAKyIlcsJQ2HhBcWZwf9z41OZScPRNx6kHDcS
	LFGYQwkVYc0hfsVPG6O029IpJmQe6+NF9l6g/SJQGEwGS8f5FNtM29LdSnW1HHcV0vrqxI9vLCF
	Xdel/JSUx+vrpcU3Tas=
X-Google-Smtp-Source: AGHT+IEh6os44BnNcNnrkansmGStdkdiA/EweUgFYf4Q/Kzk+a8Jf2qrIaH2MEgysghthnExU6q14A==
X-Received: by 2002:a5d:588d:0:b0:38a:68f4:66a2 with SMTP id ffacd0b85a97d-38c51b600f7mr7386249f8f.31.1738274030038;
        Thu, 30 Jan 2025 13:53:50 -0800 (PST)
Received: from krava (85-193-35-4.rib.o2.cz. [85.193.35.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1b57b6sm3042176f8f.72.2025.01.30.13.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 13:53:49 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 30 Jan 2025 22:53:47 +0100
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
	luto@amacapital.net, wad@chromium.org, oleg@redhat.com,
	mhiramat@kernel.org, andrii@kernel.org,
	alexei.starovoitov@gmail.com, cyphar@cyphar.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
	daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org, linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <Z5v063xNVJfXCnKV@krava>
References: <20250128145806.1849977-1-eyal.birger@gmail.com>
 <202501281634.7F398CEA87@keescook>
 <CAHsH6Gsv3DB0O5oiEDsf2+Go4O1+tnKm-Ab0QPyohKSaroSxxA@mail.gmail.com>
 <Z5s3S5X8FYJDAHfR@krava>
 <CAHsH6GvsGbZ4a=-oSpD1j8jx11T=Y4SysAtkzAu+H4_Gh7v3Qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHsH6GvsGbZ4a=-oSpD1j8jx11T=Y4SysAtkzAu+H4_Gh7v3Qg@mail.gmail.com>

On Thu, Jan 30, 2025 at 07:05:42AM -0800, Eyal Birger wrote:
> On Thu, Jan 30, 2025 at 12:24 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Jan 29, 2025 at 09:27:49AM -0800, Eyal Birger wrote:
> > > Hi,
> > >
> > > Thanks for the review!
> > >
> > > On Tue, Jan 28, 2025 at 5:41 PM Kees Cook <kees@kernel.org> wrote:
> > > >
> > > > On Tue, Jan 28, 2025 at 06:58:06AM -0800, Eyal Birger wrote:
> > > > > Note: uretprobe isn't supported in i386 and __NR_ia32_rt_tgsigqueueinfo
> > > > > uses the same number as __NR_uretprobe so the syscall isn't forced in the
> > > > > compat bitmap.
> > > >
> > > > So a 64-bit tracer cannot use uretprobe on a 32-bit process? Also is
> > > > uretprobe strictly an x86_64 feature?
> > > >
> > >
> > > My understanding is that they'd be able to do so, but use the int3 trap
> > > instead of the uretprobe syscall.
> > >
> > > > > [...]
> > > > > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > > > > index 385d48293a5f..23b594a68bc0 100644
> > > > > --- a/kernel/seccomp.c
> > > > > +++ b/kernel/seccomp.c
> > > > > @@ -734,13 +734,13 @@ seccomp_prepare_user_filter(const char __user *user_filter)
> > > > >
> > > > >  #ifdef SECCOMP_ARCH_NATIVE
> > > > >  /**
> > > > > - * seccomp_is_const_allow - check if filter is constant allow with given data
> > > > > + * seccomp_is_filter_const_allow - check if filter is constant allow with given data
> > > > >   * @fprog: The BPF programs
> > > > >   * @sd: The seccomp data to check against, only syscall number and arch
> > > > >   *      number are considered constant.
> > > > >   */
> > > > > -static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
> > > > > -                                struct seccomp_data *sd)
> > > > > +static bool seccomp_is_filter_const_allow(struct sock_fprog_kern *fprog,
> > > > > +                                       struct seccomp_data *sd)
> > > > >  {
> > > > >       unsigned int reg_value = 0;
> > > > >       unsigned int pc;
> > > > > @@ -812,6 +812,21 @@ static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
> > > > >       return false;
> > > > >  }
> > > > >
> > > > > +static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
> > > > > +                                struct seccomp_data *sd)
> > > > > +{
> > > > > +#ifdef __NR_uretprobe
> > > > > +     if (sd->nr == __NR_uretprobe
> > > > > +#ifdef SECCOMP_ARCH_COMPAT
> > > > > +         && sd->arch != SECCOMP_ARCH_COMPAT
> > > > > +#endif
> > > >
> > > > I don't like this because it's not future-proof enough. __NR_uretprobe
> > > > may collide with other syscalls at some point.
> > >
> > > I'm not sure I got this point.
> > >
> > > > And if __NR_uretprobe_32
> > > > is ever implemented, the seccomp logic will be missing. I think this
> > > > will work now and in the future:
> > > >
> > > > #ifdef __NR_uretprobe
> > > > # ifdef SECCOMP_ARCH_COMPAT
> > > >         if (sd->arch == SECCOMP_ARCH_COMPAT) {
> > > > #  ifdef __NR_uretprobe_32
> > > >                 if (sd->nr == __NR_uretprobe_32)
> > > >                         return true;
> > > > #  endif
> > > >         } else
> > > > # endif
> > > >         if (sd->nr == __NR_uretprobe)
> > > >                 return true;
> > > > #endif
> > >
> > > I don't know if implementing uretprobe syscall for compat binaries is
> > > planned or makes sense - I'd appreciate Jiri's and others opinion on that.
> > > That said, I don't mind adding this code for the sake of future proofing.
> >
> > as Andrii wrote in the other email ATM it's just strictly x86_64,
> > but let's future proof it
> 
> Thank you. So I'm ok with using the suggestion above, but more on this below.
> 
> >
> > AFAIK there was an attempt to do similar on arm but it did not show
> > any speed up
> >
> > >
> > > >
> > > > Instead of doing a function rename dance, I think you can just stick
> > > > the above into seccomp_is_const_allow() after the WARN().
> > >
> > > My motivation for the renaming dance was that you mentioned we might add
> > > new syscalls to this as well, so I wanted to avoid cluttering the existing
> > > function which seems to be well defined.
> > >
> > > >
> > > > Also please add a KUnit tests to cover this in
> > > > tools/testing/selftests/seccomp/seccomp_bpf.c
> > >
> > > I think this would mean that this test suite would need to run as
> > > privileged. Is that Ok? or maybe it'd be better to have a new suite?
> > >
> > > > With at least these cases combinations below. Check each of:
> > > >
> > > >         - not using uretprobe passes
> > > >         - using uretprobe passes (and validates that uretprobe did work)
> > > >
> > > > in each of the following conditions:
> > > >
> > > >         - default-allow filter
> > > >         - default-block filter
> > > >         - filter explicitly blocking __NR_uretprobe and nothing else
> > > >         - filter explicitly allowing __NR_uretprobe (and only other
> > > >           required syscalls)
> > >
> > > Ok.
> >
> > please let me know if I can help in any way with tests
> 
> Thanks! Is there a way to partition this work? I'd appreciate the help
> if we can find some way of doing so.

sure, I'll check the seccomp selftests and let you know

> 
> >
> > >
> > > >
> > > > Hm, is uretprobe expected to work on mips? Because if so, you'll need to
> > > > do something similar to the mode1 checking in the !SECCOMP_ARCH_NATIVE
> > > > version of seccomp_cache_check_allow().
> > >
> > > I don't know if uretprobe syscall is expected to run on mips. Personally
> > > I'd avoid adding this dead code.
> 
> Jiri, what is your take on this one?

uretprobe syscall is not expected to work on mips, atm it's strictly x86_64

jirka

