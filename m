Return-Path: <bpf+bounces-45079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A7A9D0BF6
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 10:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B84FB23773
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 09:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BA1193060;
	Mon, 18 Nov 2024 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQHNw3YR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91BC19067C;
	Mon, 18 Nov 2024 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731922791; cv=none; b=fhzcV3289BybGax6218OMsQoHXPjNbgzf4h9WXAKInfYpAIxdFlSL/JVpZtU+GM8Bjn8w8vmAnsyxLiqsyrQCN4kedIs8cT4DyJ08x42qMQ8xWs3D7EH4tp1N6nLNxVGPOMp9ZpKMAZRJcN6hJK31BPoLoHJUNGHsIv5+QZmr50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731922791; c=relaxed/simple;
	bh=wcjFwTi9nS9WJBtKBzT8eqmoyIq2zYhF4HyEAvJfYgE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjdmigPdnkjvTl3I7Ha44nAgV6U+3X+r4CFvvdDaR/eg7VQtvGj5JzMKLGpDNz44r2tUfMTDUJ5cM6D8Of3Q/5INZWQY3lnFGWRfzrnhuG5hg1ta06jhRbSR2JrcgAlRvfoNncqpurBoCPVI5ND6IPgkU6KOAkCAOAKT0ku9Uew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQHNw3YR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-431ac30d379so34562595e9.1;
        Mon, 18 Nov 2024 01:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731922788; x=1732527588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O2iBCRMm8OcKK+uQt7vua/k4ESoCIm8lP2KcuL0sWNM=;
        b=KQHNw3YRpPObSnyoZJgE4deA52tUHgc/rWmoAYPuKjPjOdYZ3h1ZLwoa7IZs0LtcLC
         DyaKewLzU7enA34aWmJo6VkjdAAkP4cu+VLQN1D0LScW5VJoQdEl/ygOI7lvEdsEQY0O
         vS0mfPI+BwRI/N+TpSGF2vH4ofi2x5Oejp0wN5PvdzKuA8b2sQWjKFHlCZPnxlnrI21y
         J4AxLGIBvd3mas2rlQ7CuW3TJqz6YDbCMfIMtFmdxiw5pyKdeH3frp3nHUbyFcCnOHYD
         kjGFK0Q7AgPvUV46IXVqZG/PD99j2+zg4Up17/vpnF3+FlDmbzJ35W/fDC9xKGVakkf5
         f2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731922788; x=1732527588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2iBCRMm8OcKK+uQt7vua/k4ESoCIm8lP2KcuL0sWNM=;
        b=BlK0pLfHRDolQ50vQp3MVkFwdA7+J4PHYar89eRqclmQSuUZfZPwi8//sEUi69mf/N
         CQ4285NAUqiS/Xj5C1j/JEnM4wFJ9EvQ91JFWGQWt2qQBUZNXuZt2SNek8lIzxsophfB
         oX/d+K1a+0v288bbhVstTSVmlWB4MFkPqHhJ94L6VC2ps+Ea6FyRMh8V/17k5KWXEc8C
         IYApLt6I0S8JjnHS3dwNRqyKK22sC4Dlf+PwoZEKMf4FgxTY3VyHbe6UmGKah8OBtMDu
         A/DyAMTTiz6pQbSvJ85mclno1XI/8QXkvRWMUcWKknPtTzvQPrK+b3JShn69m//GWUXd
         9o4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmBOPl67QnrXveijn7humIJHL2mtsHZlbXHumhe3I/0RwHv6yS+Iri50/PWt6nfuGQ3on1EMW/wCWSa0UR@vger.kernel.org, AJvYcCXUnEsPIbxfkWRShOQ4Tl+jCSdnu5qGlaqm1hxe0CTOHrbChx6COaSrR+su22kfxzjZZcoTRES/ufuPxSsk7iwRYwPZ@vger.kernel.org, AJvYcCXhO6Rg3i5bRaOXwelhnws3VRgCgqgZFL5ekTd58AOOD8XDKSLwW5RzdoSVN5pPfk5CAY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD4iYX8LmwmOHvLJErVgeLhr6g+H8NFIvsMArr7an3BGRn06oA
	49DkX0mSET6+h4vt5KFZvxoovoa8q+s7oQXJ/VLHTenyk1dAYv8F
X-Google-Smtp-Source: AGHT+IEx1uG94pHcWnn1BeSICFxkZnxhXwr+SPBiaeXhhwGCBkbPd01NG/fkT+f43kVhWDiUn0/qkA==
X-Received: by 2002:a05:600c:468b:b0:431:5eeb:2214 with SMTP id 5b1f17b1804b1-432df7954a8mr86880085e9.33.1731922787837;
        Mon, 18 Nov 2024 01:39:47 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab78897sm148333635e9.16.2024.11.18.01.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 01:39:47 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 18 Nov 2024 10:39:45 +0100
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC perf/core 07/11] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <ZzsLYQiER7EXf5J0@krava>
References: <20241105133405.2703607-1-jolsa@kernel.org>
 <20241105133405.2703607-8-jolsa@kernel.org>
 <20241118171808.316ae124cd57886e813cb98f@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118171808.316ae124cd57886e813cb98f@kernel.org>

On Mon, Nov 18, 2024 at 05:18:08PM +0900, Masami Hiramatsu wrote:
> On Tue,  5 Nov 2024 14:34:01 +0100
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > Putting together all the previously added pieces to support optimized
> > uprobes on top of 5-byte nop instruction.
> > 
> > The current uprobe execution goes through following:
> >   - installs breakpoint instruction over original instruction
> >   - exception handler hit and calls related uprobe consumers
> >   - and either simulates original instruction or does out of line single step
> >     execution of it
> >   - returns to user space
> > 
> > The optimized uprobe path
> > 
> >   - checks the original instruction is 5-byte nop (plus other checks)
> >   - adds (or uses existing) user space trampoline and overwrites original
> >     instruction (5-byte nop) with call to user space trampoline
> >   - the user space trampoline executes uprobe syscall that calls related uprobe
> >     consumers
> >   - trampoline returns back to next instruction
> > 
> > This approach won't speed up all uprobes as it's limited to using nop5 as
> > original instruction, but we could use nop5 as USDT probe instruction (which
> > uses single byte nop ATM) and speed up the USDT probes.
> > 
> > This patch overloads related arch functions in uprobe_write_opcode and
> > set_orig_insn so they can install call instruction if needed.
> > 
> > The arch_uprobe_optimize triggers the uprobe optimization and is called after
> > first uprobe hit. I originally had it called on uprobe installation but then
> > it clashed with elf loader, because the user space trampoline was added in a
> > place where loader might need to put elf segments, so I decided to do it after
> > first uprobe hit when loading is done.
> > 
> > TODO release uprobe trampoline when it's no longer needed.. we might need to
> > stop all cpus to make sure no user space thread is in the trampoline.. or we
> > might just keep it, because there's just one 4GB memory region?
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/include/asm/uprobes.h |   7 ++
> >  arch/x86/kernel/uprobes.c      | 130 +++++++++++++++++++++++++++++++++
> >  include/linux/uprobes.h        |   1 +
> >  kernel/events/uprobes.c        |   3 +
> >  4 files changed, 141 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
> > index 678fb546f0a7..84a75ed748f0 100644
> > --- a/arch/x86/include/asm/uprobes.h
> > +++ b/arch/x86/include/asm/uprobes.h
> > @@ -20,6 +20,11 @@ typedef u8 uprobe_opcode_t;
> >  #define UPROBE_SWBP_INSN		0xcc
> >  #define UPROBE_SWBP_INSN_SIZE		   1
> >  
> > +enum {
> > +	ARCH_UPROBE_FLAG_CAN_OPTIMIZE	= 0,
> > +	ARCH_UPROBE_FLAG_OPTIMIZED	= 1,
> > +};
> > +
> >  struct uprobe_xol_ops;
> >  
> >  struct arch_uprobe {
> > @@ -45,6 +50,8 @@ struct arch_uprobe {
> >  			u8	ilen;
> >  		}			push;
> >  	};
> > +
> > +	unsigned long flags;
> >  };
> >  
> >  struct arch_uprobe_task {
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index 02aa4519b677..50ccf24ff42c 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -18,6 +18,7 @@
> >  #include <asm/processor.h>
> >  #include <asm/insn.h>
> >  #include <asm/mmu_context.h>
> > +#include <asm/nops.h>
> >  
> >  /* Post-execution fixups. */
> >  
> > @@ -877,6 +878,33 @@ static const struct uprobe_xol_ops push_xol_ops = {
> >  	.emulate  = push_emulate_op,
> >  };
> >  
> > +static int is_nop5_insns(uprobe_opcode_t *insn)
> > +{
> > +	return !memcmp(insn, x86_nops[5], 5);
> 
> Maybe better to use BYTES_NOP5 directly?

ok

> 
> > +}
> > +
> > +static int is_call_insns(uprobe_opcode_t *insn)
> > +{
> > +	return *insn == 0xe8;
> 
> 0xe8 -> CALL_INSN_OPCODE

right, thanks

jirka

