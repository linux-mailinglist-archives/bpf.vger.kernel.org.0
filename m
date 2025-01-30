Return-Path: <bpf+bounces-50112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 006EFA22985
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 09:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B16F1887135
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 08:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C771B2198;
	Thu, 30 Jan 2025 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMswf7tG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EE71A4AAA;
	Thu, 30 Jan 2025 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738225490; cv=none; b=o0lTrc97mqNuIiNwlZt18+3YyPDya51ZWIlbJiI8NhPdcGkGymk4G79N10T32xaCppnHdRz4cbqh/WyIJ3eBAjGcr0Glrildh58XLh3LHtK3qAM3wScUyg6NJGHFOzGxoCWYxyE5r2uLKysFfUO9Hnf/FlS1Q4078EMZ8XEYlKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738225490; c=relaxed/simple;
	bh=255G9I1UK68I/3/1qmvviKxyuvr0JH1O15UzRJLiIxM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBRdmofgvWv+xJ3ePfzlrEwG8uHZmrd9olMCgvN7RXITK+TIJDxiP1B9wI+ZSiZfz8bkNZp/jEsbLLUihnNgVUM5vzr5+jg8rX5ClTrgmh9IFzQyqr/AI/Och4eJqLaTcK/s3QxlDNDPRdFErlr+FCez9fumA4ydVG3ZX16kDcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMswf7tG; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab2b29dfc65so90269466b.1;
        Thu, 30 Jan 2025 00:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738225487; x=1738830287; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6t4ETj0ybS3UvEPG30Ddm5C8imd0kaINUlUzibpoMo0=;
        b=JMswf7tGiGRXfERIXAqsnPmE80D2M+x+g/RVki5amlEAOCFz/cOVLFC1TLbjBlLLCx
         jMTlMcbDxE2157A2OXTj+I9gquuoWHsCjHNuY65NYFAEKRrbhR+TVtwdxYcrmEXqadQd
         N/3ZHt6rVdJLb9/wm2+avaPDP2+IqSPB26hJTuJg1dqro/WQ4wI7N0sq/LnSor/K+yMY
         XRWXc3yH3nq4eZAnRc65lNCmCttwVj+bg/XCQp6DZwdD2LA0YrUgDVMnozxmSwtgHIm8
         5YnT49ffHZbjoZ+udd4V0UzkVUkidNAg7SfgKQNXfLva3CtKCLF8ov95jbIFNbpTPWw1
         8lDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738225487; x=1738830287;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6t4ETj0ybS3UvEPG30Ddm5C8imd0kaINUlUzibpoMo0=;
        b=FHV94HLybQPUBKb/weXL2tzWBvV/PS9GAdzbDbTEFHxxDnDSqkWCVGmw30a7D7iM4K
         Kt6MtJrJE7vzNF05uvKGovfViHAacOQbmhz1JMVUzcz+w38NSJunHTOkUuFa7nau8Bta
         3BhysqS6s1JeNvvlnu5hMGK7wuKF8nyHgp4D80bPwg5IuhXIO/tYE4BjyatE4xHIXftp
         MFjT8SgZwkXQIf3ogSaBV4JbPil2Ct6h7RBSNzxKAm/70eM9wq+MUiwbToeoiGTqc5AX
         UQTqE2GWfq4UbhML/7CjrHMtZWSlQVfejxQqE0rFGK63Ed1Cj47Z92hBjU+TcFCg94bC
         YFzA==
X-Forwarded-Encrypted: i=1; AJvYcCUalcFFSdsuDYVLqadiWSfFFi1YGOGUwkhzRCHEe3N0UPZ2ktkEmeLIbZ3YiopFaBo3bRm+PnTl@vger.kernel.org, AJvYcCVgZmvQPrxXajs2U3WjGrA5bS1XzkrU3tPFVgD4PJmaDREmeoG85VZynnZ6rqtnTcoZtta3VyAtB3xyKYzX73Jb7ufW@vger.kernel.org, AJvYcCW+CyBxBx92K42Elz8/YjFuewY5r1cGQPNYCxrsMegxVbeAeqsde3DVSPnr8rsMRPdqNq8=@vger.kernel.org, AJvYcCWT1Ps+Cqaa2FAnqMq9P6s4TcW+FJyuhF0VY7dNYHihkZmV7hC/APeYHdCcUTGsKmtynfBnzDwpYiIP@vger.kernel.org, AJvYcCXPmEc8EWSkTXBB1+wnLd283lNyTdsLbFoEfvuG1qfm1EzqqEsndDi5WZBhlNlWthsH3igb58AFa5VV92Pf@vger.kernel.org
X-Gm-Message-State: AOJu0YxyfN3M5DMbW3b2i+SpLvB1bSIW1pvhad7GDJLwMUvfSOh73AWq
	by6Wff/2C012GmoggmMmEYi1MG0a8oY13qwyro7uKABjOh/xqy65
X-Gm-Gg: ASbGncuW98deAL3dIAi8JUqsGU5QDz33q4OVHHfQEwKOrVLi/ZhR9+b7HSEgljku/+Q
	d7245+BcpGV8weg7x/JofMWqtKW9k0qx/J2dThoKpl7y35kCov1hnX7ZqqbB/QT71WiK8kLoWmo
	cFaBnzuhs4Wydbw1vg9MZ/eSpa9tUEDpK7ULF+4dnRpna8VAfjEWPY08K3BxMu39lIKVMl3eAAu
	ba8ef0S4nwOHDye6Q+xBXJF1z49gkcSJletrcyn9sjZ+fDaOlzP6d0k4m3+TDC4oxZvdHyK9OpO
	oTK/t+5iu4Ik0OYTWdVL21YYQ8EbhG1F7Id1BQ==
X-Google-Smtp-Source: AGHT+IGdyF4fkwQC57hMV2Uu0ctFzkif63J1nHpxdwUQxh1W2K4idx8e+roWw7h+Ljk0aoKtR3emaQ==
X-Received: by 2002:a17:906:d54c:b0:ab6:edd6:a812 with SMTP id a640c23a62f3a-ab6edd6a8camr27402866b.24.1738225486657;
        Thu, 30 Jan 2025 00:24:46 -0800 (PST)
Received: from krava (static-84-42-143-70.bb.vodafone.cz. [84.42.143.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47a7b0fsm80550366b.12.2025.01.30.00.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 00:24:46 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 30 Jan 2025 09:24:43 +0100
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Kees Cook <kees@kernel.org>, luto@amacapital.net, wad@chromium.org,
	oleg@redhat.com, mhiramat@kernel.org, andrii@kernel.org,
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
	daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org, linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <Z5s3S5X8FYJDAHfR@krava>
References: <20250128145806.1849977-1-eyal.birger@gmail.com>
 <202501281634.7F398CEA87@keescook>
 <CAHsH6Gsv3DB0O5oiEDsf2+Go4O1+tnKm-Ab0QPyohKSaroSxxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHsH6Gsv3DB0O5oiEDsf2+Go4O1+tnKm-Ab0QPyohKSaroSxxA@mail.gmail.com>

On Wed, Jan 29, 2025 at 09:27:49AM -0800, Eyal Birger wrote:
> Hi,
> 
> Thanks for the review!
> 
> On Tue, Jan 28, 2025 at 5:41 PM Kees Cook <kees@kernel.org> wrote:
> >
> > On Tue, Jan 28, 2025 at 06:58:06AM -0800, Eyal Birger wrote:
> > > Note: uretprobe isn't supported in i386 and __NR_ia32_rt_tgsigqueueinfo
> > > uses the same number as __NR_uretprobe so the syscall isn't forced in the
> > > compat bitmap.
> >
> > So a 64-bit tracer cannot use uretprobe on a 32-bit process? Also is
> > uretprobe strictly an x86_64 feature?
> >
> 
> My understanding is that they'd be able to do so, but use the int3 trap
> instead of the uretprobe syscall.
> 
> > > [...]
> > > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > > index 385d48293a5f..23b594a68bc0 100644
> > > --- a/kernel/seccomp.c
> > > +++ b/kernel/seccomp.c
> > > @@ -734,13 +734,13 @@ seccomp_prepare_user_filter(const char __user *user_filter)
> > >
> > >  #ifdef SECCOMP_ARCH_NATIVE
> > >  /**
> > > - * seccomp_is_const_allow - check if filter is constant allow with given data
> > > + * seccomp_is_filter_const_allow - check if filter is constant allow with given data
> > >   * @fprog: The BPF programs
> > >   * @sd: The seccomp data to check against, only syscall number and arch
> > >   *      number are considered constant.
> > >   */
> > > -static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
> > > -                                struct seccomp_data *sd)
> > > +static bool seccomp_is_filter_const_allow(struct sock_fprog_kern *fprog,
> > > +                                       struct seccomp_data *sd)
> > >  {
> > >       unsigned int reg_value = 0;
> > >       unsigned int pc;
> > > @@ -812,6 +812,21 @@ static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
> > >       return false;
> > >  }
> > >
> > > +static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
> > > +                                struct seccomp_data *sd)
> > > +{
> > > +#ifdef __NR_uretprobe
> > > +     if (sd->nr == __NR_uretprobe
> > > +#ifdef SECCOMP_ARCH_COMPAT
> > > +         && sd->arch != SECCOMP_ARCH_COMPAT
> > > +#endif
> >
> > I don't like this because it's not future-proof enough. __NR_uretprobe
> > may collide with other syscalls at some point.
> 
> I'm not sure I got this point.
> 
> > And if __NR_uretprobe_32
> > is ever implemented, the seccomp logic will be missing. I think this
> > will work now and in the future:
> >
> > #ifdef __NR_uretprobe
> > # ifdef SECCOMP_ARCH_COMPAT
> >         if (sd->arch == SECCOMP_ARCH_COMPAT) {
> > #  ifdef __NR_uretprobe_32
> >                 if (sd->nr == __NR_uretprobe_32)
> >                         return true;
> > #  endif
> >         } else
> > # endif
> >         if (sd->nr == __NR_uretprobe)
> >                 return true;
> > #endif
> 
> I don't know if implementing uretprobe syscall for compat binaries is
> planned or makes sense - I'd appreciate Jiri's and others opinion on that.
> That said, I don't mind adding this code for the sake of future proofing.

as Andrii wrote in the other email ATM it's just strictly x86_64,
but let's future proof it

AFAIK there was an attempt to do similar on arm but it did not show
any speed up

> 
> >
> > Instead of doing a function rename dance, I think you can just stick
> > the above into seccomp_is_const_allow() after the WARN().
> 
> My motivation for the renaming dance was that you mentioned we might add
> new syscalls to this as well, so I wanted to avoid cluttering the existing
> function which seems to be well defined.
> 
> >
> > Also please add a KUnit tests to cover this in
> > tools/testing/selftests/seccomp/seccomp_bpf.c
> 
> I think this would mean that this test suite would need to run as
> privileged. Is that Ok? or maybe it'd be better to have a new suite?
> 
> > With at least these cases combinations below. Check each of:
> >
> >         - not using uretprobe passes
> >         - using uretprobe passes (and validates that uretprobe did work)
> >
> > in each of the following conditions:
> >
> >         - default-allow filter
> >         - default-block filter
> >         - filter explicitly blocking __NR_uretprobe and nothing else
> >         - filter explicitly allowing __NR_uretprobe (and only other
> >           required syscalls)
> 
> Ok.

please let me know if I can help in any way with tests

> 
> >
> > Hm, is uretprobe expected to work on mips? Because if so, you'll need to
> > do something similar to the mode1 checking in the !SECCOMP_ARCH_NATIVE
> > version of seccomp_cache_check_allow().
> 
> I don't know if uretprobe syscall is expected to run on mips. Personally
> I'd avoid adding this dead code.
> 
> >
> > (You can see why I really dislike having policy baked into seccomp!)
> 
> I definitely understand :)
> 
> >
> > > +        )
> > > +             return true;
> > > +#endif
> > > +
> > > +     return seccomp_is_filter_const_allow(fprog, sd);
> > > +}
> > > +
> > >  static void seccomp_cache_prepare_bitmap(struct seccomp_filter *sfilter,
> > >                                        void *bitmap, const void *bitmap_prev,
> > >                                        size_t bitmap_size, int arch)
> > > @@ -1023,6 +1038,9 @@ static inline void seccomp_log(unsigned long syscall, long signr, u32 action,
> > >   */
> > >  static const int mode1_syscalls[] = {
> > >       __NR_seccomp_read, __NR_seccomp_write, __NR_seccomp_exit, __NR_seccomp_sigreturn,
> > > +#ifdef __NR_uretprobe
> > > +     __NR_uretprobe,
> > > +#endif
> >
> > It'd be nice to update mode1_syscalls_32 with __NR_uretprobe_32 even
> > though it doesn't exist. (Is it _never_ planned to be implemented?) But
> > then, maybe the chances of a compat mode1 seccomp process running under
> > uretprobe is vanishingly small.

no plans for __NR_uretprobe_32 at this point

> 
> It seems to me very unlikely. BTW, when I tested the "strict" mode change
> my program was killed by seccomp. The reason wasn't the uretprobe syscall
> (which I added to the list), it was actually the exit_group syscall which
> libc uses instead of the exit syscall.
> 
> Thanks again,
> Eyal.

thanks,
jirka

