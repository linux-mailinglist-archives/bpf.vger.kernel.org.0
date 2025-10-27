Return-Path: <bpf+bounces-72379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E3EC11B06
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 23:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA4F402CD9
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 22:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECE832C31E;
	Mon, 27 Oct 2025 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFjWr7Is"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152F7329C64
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 22:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761603935; cv=none; b=mAJrM81+THQFU9B9uA3GlxI5m6Rhzg3Po1EIf2OqbXPNXeAZoSkryw/K3AIbu1uxSxkf+Al2fTjTbNaDxlmJTlZiE5IfXLFIq7x5BfL30tYKCwEPKN1PaDSJIAf3bWSnus2mMtXe6QhifK/n6LwkokL5JllcKKSlENOqrgDJ/hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761603935; c=relaxed/simple;
	bh=ujIAydKczuzdwKBdhbyuKoWTL5IbL7V/TEs/+/HAH2M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaA0hyk2Kbv0Yk+TRAm+4ZdPLg2W40LKzsDyQHqyy/polp/vRcy+x8DWw6AV2v6OydSmn75eJq4zvU10H8SVBuLlgoPkIkHX5QfNb/6V4/zvQctEqE0H75czDl4JPOZo64d3I1u0EgNzapV6HEV71vgYa4bi0afHU32BH30nhEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFjWr7Is; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4710022571cso54175645e9.3
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 15:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761603932; x=1762208732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MKDbU8B4IbG+AAzbZltvWI7s50AOGrKS71QrEu9vmRY=;
        b=LFjWr7IsGCicE/XBCvNiXABDOS/DJOaKIjU7vurkKgaa5l/7481xoGTrfgjNFbpwFG
         uw8XTUw0bzG1cVhxmBs3dn8sgkTSFmgaqkWIvit2DRymc/0jvFSGk/CguXxXjnQMTKtk
         uq2oInYyANV/qupdxUP4UShFBdAVmpzqALb2PVTEqrLvfz5Lwxbm64eKNCMC4BUBtaq5
         v2AG9t6tI8VFIbDQ3iFqw8BrHZPYdkVSeowvu7Y/m3yEiDA6F89py0eSPm+weFW0ww7B
         ayEwWZ6d8Yp9QXNnYkFvjb7IzWTtaPY29aWvfNf+o+M0K8W/SSz9sGfiO2rMUDvQo33L
         SU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761603932; x=1762208732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKDbU8B4IbG+AAzbZltvWI7s50AOGrKS71QrEu9vmRY=;
        b=YOct32zf50ijXydyHKwBrh4wxRLXFignYfhDMZEdPJLrehvAYa4oSs2C7LFzlGWj84
         Mp03K4bKxZ6Otpf46H+XX6g2k4ccYlFPmK7R6oX6RcYAMJ99oGsBQzQ79LEMCNa78HXh
         SEt6eiwST67ruAXQ5cYGH8k9nIWspx3PhsgwcmxqaqcRN9jzS+Rd+IZjwcprWZK7xwFQ
         j0dpTuHF7bufrXHDneIvFUrVvbc80LWx7+E333DCnPhT8RKCBrVKzEQXuxfu52RJBUde
         +CJ0B5PGsMOC6+pugwv3NjNuGwWZghPx8sBPP7UDS28Yy8cT46kXw6VmhcgQYsioQhLI
         cc+A==
X-Forwarded-Encrypted: i=1; AJvYcCW3hWIEDZZLWybFchQ1vWdJTpuQJlB1cOBU1qwG250t0mY04ACH4/4S6NGdPqFSAYpnzlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP1xVPOaM9olLJUZ3LVuImsOScp6RZa0FI+5oJefyrKHyxbP1x
	C0Tgri+j9KIc9ISg1xdwHi2eudzAxXm+nrqMQHfCf7AHbxF2OHu9GByy
X-Gm-Gg: ASbGncucR/vYdDBWcFO4gfBkIWbWwrzxMzHqwP5fmyuLyPK3sb+/+7QjlXK5eYwzwvZ
	RAxoYHNTSwTQuxi0jxA8OsiOJ4WKi3e1PnY5/pUQQHqGjQ7tpCj1LdTh3KCzkYLqDb/07butqqf
	EDXGN5LYw3u9fZ1HpReyr54souaHax51F0eqWnnornLzDQmPjyopvatr10FLAaXy/2Zzjb8cCLw
	mqJqpWc0DQH6z0b/DoIw6c3NxdkPCivapnEfqz1n2snloYgZIlSLr7ykORdWhR0XMQPi4n0RFku
	rR5B/v5TzzYBV2HPjPLFqzSomVuwa+KSBOgT3uGs1lRPhs+IzSGFN4OFkbBhLG3TkjrMdA9yj01
	Mix671NbtLyGMqqViiQ2UeCQ0WhK+T7RgyYqSb0eqTLVGipa/7Ytwqf/MgDj1XqQ8
X-Google-Smtp-Source: AGHT+IFewjIU04uCpHRCTJrs4Aqm896DfPXNFrP2ep6c0V5rjWWsGXrd3MTH1aryAc1zbKqXD+Is1w==
X-Received: by 2002:a05:600c:4fc4:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-47717e037f5mr9929675e9.17.1761603932286;
        Mon, 27 Oct 2025 15:25:32 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4783b8sm159667385e9.15.2025.10.27.15.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 15:25:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 27 Oct 2025 23:25:29 +0100
To: bot+bpf-ci@kernel.org
Cc: mhiramat@kernel.org, rostedt@goodmis.org, jpoimboe@kernel.org,
	song@kernel.org, peterz@infradead.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, yhs@fb.com,
	songliubraving@fb.com, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 1/3] Revert "perf/x86: Always store regs->ip in
 perf_callchain_kernel()"
Message-ID: <aP_xWRe7qNr1j9Px@krava>
References: <20251027131354.1984006-2-jolsa@kernel.org>
 <8227ad3af501bb982231ef00ac5e970a0a12c9d64e07ea3f3d37100ec7e3f1cc@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8227ad3af501bb982231ef00ac5e970a0a12c9d64e07ea3f3d37100ec7e3f1cc@mail.kernel.org>

On Mon, Oct 27, 2025 at 01:52:18PM +0000, bot+bpf-ci@kernel.org wrote:
> 
> ```
> commit 26b06def1956497a15eecf22787d5430fad2fed6
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"
> 
> This commit reverts a 2019 fix that ensured regs->ip is stored when
> using non-HW regs (regs populated by perf_arch_fetch_caller_regs). The
> revert claims the IP is captured during unwinding, but analysis suggests
> otherwise.
> 
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index 745caa6c1..fa6c47b50 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -2789,13 +2789,13 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
> >  		return;
> >  	}
> >
> > -	if (perf_callchain_store(entry, regs->ip))
> > -		return;
> > -
> > -	if (perf_hw_regs(regs))
> > +	if (perf_hw_regs(regs)) {
> > +		if (perf_callchain_store(entry, regs->ip))
> > +			return;
> >  		unwind_start(&state, current, regs, NULL);
> > -	else
> > +	} else {
> >  		unwind_start(&state, current, NULL, (void *)regs->sp);
> > +	}
> 
> When perf_hw_regs(regs) returns false (which happens when regs comes from
> perf_arch_fetch_caller_regs since it sets regs->flags=0), the else branch
> calls unwind_start with regs=NULL. Can this lose the regs->ip value?
> 
> Looking at the code flow:
> 
> perf_arch_fetch_caller_regs() sets:
>   - regs->ip = CALLER_ADDR0 (the caller's instruction pointer)
>   - regs->flags = 0 (no X86_EFLAGS_FIXED)
> 
> perf_hw_regs() checks:
>   - returns (regs->flags & X86_EFLAGS_FIXED), which is false
> 
> The else branch executes:
>   - unwind_start(&state, current, NULL, (void *)regs->sp)
> 
> In __unwind_start() at arch/x86/kernel/unwind_orc.c, when regs=NULL:
>   - Takes the "else if (task == current)" path (line 711)
>   - Initializes state->ip via inline asm from current location
>   - This is __unwind_start's IP, not the original regs->ip
>   - Then advances to first_frame at regs->sp (lines 755-758)
> 
> The original regs->ip value (captured by perf_arch_fetch_caller_regs) is
> never stored in the callchain. This was the exact issue fixed by commit

IIUC it is, unwinder will eventually unwind to it

> 83f44ae0f8af in 2019, which stated:
> 
>   "The stacktrace_map_raw_tp BPF selftest is failing because the RIP
>    saved by perf_arch_fetch_caller_regs() isn't getting saved by
>    perf_callchain_kernel()."
> 
> Does this revert re-introduce the BPF selftest failure that was fixed in
> 2019? The test tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
> still exists in the kernel tree.

stacktrace_map_raw_tp does not check what's the first ip of the
stacktrace and it passes with or without this change

I can see double entries on current code and just one with this change:

# bpftrace -e 'tracepoint:sched:sched_process_exec { print(kstack()); }'
Attaching 1 probe...

        bprm_execve+1767
        bprm_execve+1767
        do_execveat_common.isra.0+425
        __x64_sys_execve+56
        do_syscall_64+133
        entry_SYSCALL_64_after_hwframe+118

thanks,
jirka

