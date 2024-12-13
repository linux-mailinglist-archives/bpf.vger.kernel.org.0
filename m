Return-Path: <bpf+bounces-46837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C2D9F0CEE
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 14:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4BC16698D
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 13:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99201DFD9F;
	Fri, 13 Dec 2024 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kk0yuLv/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D8A1A8F85;
	Fri, 13 Dec 2024 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095217; cv=none; b=aJDhfXI7yGn0+z/R4/1Vh6MgWmV+1PGHQRPLDVEu0LizVYdrPFoB2a0zQxb2i9leQw6JYVhlTbLkFzbRkysS1VIiBGcHrN/Vg7JUS4IvnQ8Xlseb4uXtwNk115RHnIGlHCpQ9663gl4D0LzgbMkTYpG00fOPoAVpTRCG0fxMzqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095217; c=relaxed/simple;
	bh=cvQFBcEfOYdOICuTyki8Xr6B+aFdL8d9ijv4e5j3bts=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSJUvCjJ4w41t5VW41yxFsXcm4tBL67n7mm7BQZf43MhTERhXvwIsCJDa9McDUZFM+AH9SJ/Vcwa5NWRP8tRE3ERGGAq1dHOQVGS+3vYWv+VBx/Nqg59XMQhLS0zdUp9MXFHQU4ZyX3pUoNDvau04ZuzN3QDxhKJeef7mQA4Jgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kk0yuLv/; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38634c35129so1289639f8f.3;
        Fri, 13 Dec 2024 05:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734095214; x=1734700014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2jxt1g8XHFS3/B7asWmRRziw6Gq9LHkZ4TAqPxmYTHs=;
        b=kk0yuLv/PBur1O0rjUvIKv8ZOxd5200fvr/QdC/tu7KTqeGW+04AXe7c3HFXdDa75G
         A13TbrzksCjZw7U2hkTWwe2x+ue+Nf5Xhe8BJyNGIrt6PBhuN7m7bgydW/X0gBhXkfXz
         /jabPJvjRFJtQ8adro9v3tldbHHa0aBcUvSEEZLH4jEsDGAQPfNKVSU+9ZcHVjxxjZxn
         YhmRUNCvh2xPYVSs2XARy0Z01hZtrSP1FZwQOLLh3SnyIu7Mp6foEQt9S0lDbOfKXsTn
         h5kL9R4MVSeGmiYZnho6NQcdySQrTCglL/gBIk42KM1eaQwWH+rxu5hKMheKbCvL8pMc
         6P7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734095214; x=1734700014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jxt1g8XHFS3/B7asWmRRziw6Gq9LHkZ4TAqPxmYTHs=;
        b=Rth3xnEDGBGzuQVWb50wvRYua5yRTqSCvHWwOXKd3bJ9HLkmez2wQXvwooOvGujC6e
         QWlExALPi3+OrQWS8d1bKqyEldq8y9mYoXbXligCHCcrKsPVSlHC9OktsWv31S/JUaFp
         km7r5Ki3y5jqPfnz8DdoFbAl0Dm5wOpOo32oRYGEmFmbvYIkidjNgknCk2W6C0nQcdaD
         xzrfMoDHm/FSe3CtQoI1xyvb+Zr9BAluPOOP/9FJ2u8m+cUkUBnwunDhm8dRwxszAQ5T
         M0v8p85evkS/FsOQszgfIeMjr2aACpcGtS1nRejwXWoBJTbvuk0ws55hDulpQMaIQX8l
         Rn4A==
X-Forwarded-Encrypted: i=1; AJvYcCVHqAYbyTN3vz0nxRuKqZr9xSLizxRoo+usJA4OQDk225V4wZUd1m5ZGJ5PefwooPQgHMg4DLO7jDpvtlywwGrzytgb@vger.kernel.org, AJvYcCVum0EwGTPK4mTSzmRjiW+YMsMAKVopaK2E9/gaYNbaXSxxNtHzD45gfnZ0FXOp7JeCnfc=@vger.kernel.org, AJvYcCXyBVS2sHilsXRRzXGU0z1vp4hEtnoWuaN80D04CVhcR9J9dWVvLL/bB3EXAjjAe7vx3ekOyZdZNibr626N@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp6Xk8FPHyOMyIEN6qZ8nfxoGbNdHmV3hYQmHAnEWiSaV56Clc
	FHlv0FkwAwalZORna4VRTtTsUL1zS0tJYnon9iV9TqxspUE33uVG
X-Gm-Gg: ASbGnct1xPFZSPoJTvklndZzGAYvZlFjssvVqg/UskTMViGKYprv5nZMVWs3JPt+ekN
	0/nbaKvfHxf+h3MZfnqRXdMfk9w94Lv01NCvvDwRigxJvlqeLf43AkLi9IpGlsjc8tL7dQQYD79
	7cUQfrgBcEcL9d9cOxY6fg8fwK0oJu9C+u5Zz+Fv8HdEK/LyrlzujsmPahm6W3jakCS6QGq0bsI
	baqUwguPsCzztr4+yXfHTFnowiNpBrqwaCLvzDZjmD72stGoam4eGSYfiTJdNG8FSWtymnMfacF
	bD9+3ebN9IMIPa9DLMEjL+6QMgmkkg==
X-Google-Smtp-Source: AGHT+IGtFOtLh1i0ni3r8Ri7NtJCzumpSGuMpb61AzI5DJc3HSSKH7pGZBwy2M36EkvcC+ee86vvgA==
X-Received: by 2002:a05:6000:1842:b0:386:37bb:ddc1 with SMTP id ffacd0b85a97d-3888e0c1863mr1726305f8f.56.1734095213527;
        Fri, 13 Dec 2024 05:06:53 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824cab97sm7023922f8f.62.2024.12.13.05.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 05:06:53 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 13 Dec 2024 14:06:51 +0100
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 08/13] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <Z1wxa8yYrwt5Oz9z@krava>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-9-jolsa@kernel.org>
 <20241213104907.GA35539@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213104907.GA35539@noisy.programming.kicks-ass.net>

On Fri, Dec 13, 2024 at 11:49:07AM +0100, Peter Zijlstra wrote:
> On Wed, Dec 11, 2024 at 02:33:57PM +0100, Jiri Olsa wrote:
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index cdea97f8cd39..b2420eeee23a 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> 
> > @@ -1306,3 +1339,132 @@ bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
> >  	else
> >  		return regs->sp <= ret->stack;
> >  }
> > +
> > +int arch_uprobe_verify_opcode(struct arch_uprobe *auprobe, struct page *page,
> > +			      unsigned long vaddr, uprobe_opcode_t *new_opcode,
> > +			      int nbytes)
> > +{
> > +	uprobe_opcode_t old_opcode[5];
> > +	bool is_call, is_swbp, is_nop5;
> > +
> > +	if (!test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags))
> > +		return uprobe_verify_opcode(page, vaddr, new_opcode);
> > +
> > +	/*
> > +	 * The ARCH_UPROBE_FLAG_CAN_OPTIMIZE flag guarantees the following
> > +	 * 5 bytes read won't cross the page boundary.
> > +	 */
> > +	uprobe_copy_from_page(page, vaddr, (uprobe_opcode_t *) &old_opcode, 5);
> > +	is_call = is_call_insn((uprobe_opcode_t *) &old_opcode);
> > +	is_swbp = is_swbp_insn((uprobe_opcode_t *) &old_opcode);
> > +	is_nop5 = is_nop5_insn((uprobe_opcode_t *) &old_opcode);
> > +
> > +	/*
> > +	 * We allow following trasitions for optimized uprobes:
> > +	 *
> > +	 *   nop5 -> swbp -> call
> > +	 *   ||      |       |
> > +	 *   |'--<---'       |
> > +	 *   '---<-----------'
> > +	 *
> > +	 * We return 1 to ack the write, 0 to do nothing, -1 to fail write.
> > +	 *
> > +	 * If the current opcode (old_opcode) has already desired value,
> > +	 * we do nothing, because we are racing with another thread doing
> > +	 * the update.
> > +	 */
> > +	switch (nbytes) {
> > +	case 5:
> > +		if (is_call_insn(new_opcode)) {
> > +			if (is_swbp)
> > +				return 1;
> > +			if (is_call && !memcmp(new_opcode, &old_opcode, 5))
> > +				return 0;
> > +		} else {
> > +			if (is_call || is_swbp)
> > +				return 1;
> > +			if (is_nop5)
> > +				return 0;
> > +		}
> > +		break;
> > +	case 1:
> > +		if (is_swbp_insn(new_opcode)) {
> > +			if (is_nop5)
> > +				return 1;
> > +			if (is_swbp || is_call)
> > +				return 0;
> > +		} else {
> > +			if (is_swbp || is_call)
> > +				return 1;
> > +			if (is_nop5)
> > +				return 0;
> > +		}
> > +	}
> > +	return -1;
> > +}
> > +
> > +bool arch_uprobe_is_register(uprobe_opcode_t *insn, int nbytes)
> > +{
> > +	return nbytes == 5 ? is_call_insn(insn) : is_swbp_insn(insn);
> > +}
> > +
> > +static void __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct *mm,
> > +				   unsigned long vaddr)
> > +{
> > +	struct uprobe_trampoline *tramp;
> > +	char call[5];
> > +
> > +	tramp = uprobe_trampoline_get(vaddr);
> > +	if (!tramp)
> > +		goto fail;
> > +
> > +	relative_call(call, (void *) vaddr, (void *) tramp->vaddr);
> > +	if (uprobe_write_opcode(auprobe, mm, vaddr, call, 5))
> > +		goto fail;
> > +
> > +	set_bit(ARCH_UPROBE_FLAG_OPTIMIZED, &auprobe->flags);
> > +	return;
> > +
> > +fail:
> > +	/* Once we fail we never try again. */
> > +	clear_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags);
> > +	uprobe_trampoline_put(tramp);
> > +}
> > +
> > +static bool should_optimize(struct arch_uprobe *auprobe)
> > +{
> > +	if (!test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags))
> > +		return false;
> > +	if (test_bit(ARCH_UPROBE_FLAG_OPTIMIZED, &auprobe->flags))
> > +		return false;
> > +	return true;
> > +}
> > +
> > +void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
> > +{
> > +	struct mm_struct *mm = current->mm;
> > +
> > +	if (!should_optimize(auprobe))
> > +		return;
> > +
> > +	mmap_write_lock(mm);
> > +	if (should_optimize(auprobe))
> > +		__arch_uprobe_optimize(auprobe, mm, vaddr);
> > +	mmap_write_unlock(mm);
> > +}
> > +
> > +int set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
> > +{
> > +	uprobe_opcode_t *insn = (uprobe_opcode_t *) auprobe->insn;
> > +
> > +	if (test_bit(ARCH_UPROBE_FLAG_OPTIMIZED, &auprobe->flags))
> > +		return uprobe_write_opcode(auprobe, mm, vaddr, insn, 5);
> > +
> > +	return uprobe_write_opcode(auprobe, mm, vaddr, insn, UPROBE_SWBP_INSN_SIZE);
> > +}
> > +
> > +bool arch_uprobe_is_callable(unsigned long vtramp, unsigned long vaddr)
> > +{
> > +	long delta = (long)(vaddr + 5 - vtramp);
> > +	return delta >= INT_MIN && delta <= INT_MAX;
> > +}
> 
> All this code is useless on 32bit, right?

yes, there's user_64bit_mode check in arch_uprobe_trampoline_mapping
when getting the trampoline, so above won't get executed in practise..

but I think we should make it more obvious and put the check directly
to arch_uprobe_optimize

jirka

