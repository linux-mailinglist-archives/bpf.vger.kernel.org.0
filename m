Return-Path: <bpf+bounces-66082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 148EAB2DC42
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 14:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ABD27AC4EF
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 12:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FBD2F1FDD;
	Wed, 20 Aug 2025 12:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExXUGvPT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE702F1FC6;
	Wed, 20 Aug 2025 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755692361; cv=none; b=e28t6BeoYCP/aUmnFVq23t9W+gJafQ+QraehzlD6mtlMypf3KyO/Km9z7bvoLuQaOnLgIH29lpjBdvl9cboCH5O5lQ5sqGGq2mKgSmyHNtwxn/dHuQ+X19gFiG96j9Gz86YqqjrqAEQ/4VaRMvjNgAKgt4h9Mjr2Aft2F5SlJ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755692361; c=relaxed/simple;
	bh=7EcpW2eOchKzD6ZlAZ+uh51OaABTPr6h8uLUF7gXhMI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn7lJaW7xtoqB80nBTGvo0oY+58a2iKeDF48wkP4miO+uBDRJPJy/u+btoSKKthSOnaXOpZRcZwhpnp5qaCyzmjrIF4VEuol2CN4m0IH6ZmUaEin30H68ve5q/CfRAl2Y+7U/tMy4khuZobppaY+KcnI4davoasfdSokDsbXfNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExXUGvPT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3bb30c72433so2212875f8f.3;
        Wed, 20 Aug 2025 05:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755692358; x=1756297158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AsexO6ou94rmoBrX2cQh5fbd0bE6ZgFrE900h7rjRwM=;
        b=ExXUGvPTEmT64JOkOTYk9V6G7Ii75qtqSPe3AE1/ASe+XMtduK+loWAEPkqn2STdlc
         4ifQVT3AU7huFS6wjo8uisvPYlpQdqBM0fTRLxELGZ/bWwiGfb8F97hvsCBZfoVEbAci
         G5nwBoXadqmTjgb/gRANvVTsKBe/nxgpHF/NGx58Et5Vy+ojx5wtP1CLtd7SLvtP6JSz
         cAS7FMBG+KH0uvwQmls+H/J5GdOnIAWwfQqAwrfA/ugue4A/KjVTBzmhbniNxFXNJQbe
         PkoZMYWkeLXjyqhPIZ259WCxb8W+s0KqZSyhCwQuWxJEwPggC8JpAD9NkUabIGv3DbbL
         yLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755692358; x=1756297158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsexO6ou94rmoBrX2cQh5fbd0bE6ZgFrE900h7rjRwM=;
        b=cMzqpp+nTfCnbD4acC20EYEVoe+rZy0oNGYCetQEvdgT8DXoZJt2UPAS+exHFTFHAN
         ktrBA6Yp6kQ2ka7dsZArh7HGYhzmnb7t6BfaxD1UlyrRehuLvuEZZNFioMsTGd9Fo0UH
         zWf+slX/z5+dBR61fE4+llrxXzt5hhAtBa18KXMdVIpX769PiiPbWLf9twUeWlOZNmkg
         LDFC/IJ3fY7fztuv2f48AJceWBOMW7Gfkwf813dfu3qRlzAqUPjnhc1P9M/Q+ZpKdHiN
         Kcv19s6dYhaJB2MY541HoD2HfgLr2tefixl9iIUeMOIPu9Ox/oaSzA2StteA3VLbZ88w
         1ywA==
X-Forwarded-Encrypted: i=1; AJvYcCVIoPakGuvPk1qdqkGpHAQalVek2oMfsmCHWWZUKbC8C3ykCgNPHSFB8AHExY4BCxLaDVyYTJ4dCaE6crdkZ8wDwTAq@vger.kernel.org, AJvYcCVhomU5S4HjZQw8u3dyGqzeTrq74IPcUvfwap/NYlS48HrVysbuziQ+RiugIoWz7XFlSxI=@vger.kernel.org, AJvYcCW6isLwVfIpx4abZglvA8q0DsyDISXXFBWB+YIkMPPKpHZLkYLwICvxi+g2ZIM0a7v+DChO5i1uCSOeiReq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4OVSBg595rWpOAfRcUT2onYQW2MR9O6f7pDzZw1YOQbYrqhW9
	7urNX8dIRjvkPnOrJhAxKo5MQm2kqIKZ2z85ksPTW4GfJXREleWPv2ko
X-Gm-Gg: ASbGncurnc9szKDTqsDUKhSlM3qLUANfpztWPdw6tuYkQBNNNfXAJnvFbGCgWfTW+F4
	+2W2Y0TXHCfOjSWuD7LekJvdHC7lj5vNGwvf/f9910ygKgZywSiOnagHoq4tj80hV6DKW5WnOGj
	RXdDCTr79XEU+fY3kPNSTbOeadHAmp+7TbAuF/wZPSYud2J7oQesyLAQa66DD9Vzft40HcAWzqZ
	UsveMjXQSFfEvgG/2wWZ+StDbNA56vweY7S4MGk+TnOLqjGSnIrjWVier3FK07zyvmvKz6MUfiS
	8xopkLwsUOYoJfbBPWTHmWdLEw8KYpV6VwrN3FN2Qu8ZY9ECRb1NjLgnB57Biw82uMzuPc6U
X-Google-Smtp-Source: AGHT+IHS2M+nTCIXr90jKtKPddXgfj59TYem3ZUIEUoo6jEAj6wcOGIbQ82x+QVkSEBHCmodVotK5g==
X-Received: by 2002:a05:6000:188f:b0:3b8:f358:e80d with SMTP id ffacd0b85a97d-3c32c4345d2mr1901461f8f.5.1755692358115;
        Wed, 20 Aug 2025 05:19:18 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c3e673ab01sm1054481f8f.18.2025.08.20.05.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 05:19:17 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 20 Aug 2025 14:19:15 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv6 perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <aKW9Q0cOhNL0XV0R@krava>
References: <20250720112133.244369-1-jolsa@kernel.org>
 <20250720112133.244369-11-jolsa@kernel.org>
 <20250819191515.GM3289052@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819191515.GM3289052@noisy.programming.kicks-ass.net>

On Tue, Aug 19, 2025 at 09:15:15PM +0200, Peter Zijlstra wrote:
> On Sun, Jul 20, 2025 at 01:21:20PM +0200, Jiri Olsa wrote:
> 
> > +static bool __is_optimized(uprobe_opcode_t *insn, unsigned long vaddr)
> > +{
> > +	struct __packed __arch_relative_insn {
> > +		u8 op;
> > +		s32 raddr;
> > +	} *call = (struct __arch_relative_insn *) insn;
> 
> Not something you need to clean up now I suppose, but we could do with
> unifying this thing. we have a bunch of instances around.

ok, I noticed, will send patch for that

> 
> > +
> > +	if (!is_call_insn(insn))
> > +		return false;
> > +	return __in_uprobe_trampoline(vaddr + 5 + call->raddr);
> > +}
> 
> > +void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
> > +{
> > +	struct mm_struct *mm = current->mm;
> > +	uprobe_opcode_t insn[5];
> > +
> > +	/*
> > +	 * Do not optimize if shadow stack is enabled, the return address hijack
> > +	 * code in arch_uretprobe_hijack_return_addr updates wrong frame when
> > +	 * the entry uprobe is optimized and the shadow stack crashes the app.
> > +	 */
> > +	if (shstk_is_enabled())
> > +		return;
> 
> Kernel should be able to fix up userspace shadow stack just fine.

ok, will send follow up fix

> 
> > +	if (!should_optimize(auprobe))
> > +		return;
> > +
> > +	mmap_write_lock(mm);
> > +
> > +	/*
> > +	 * Check if some other thread already optimized the uprobe for us,
> > +	 * if it's the case just go away silently.
> > +	 */
> > +	if (copy_from_vaddr(mm, vaddr, &insn, 5))
> > +		goto unlock;
> > +	if (!is_swbp_insn((uprobe_opcode_t*) &insn))
> > +		goto unlock;
> > +
> > +	/*
> > +	 * If we fail to optimize the uprobe we set the fail bit so the
> > +	 * above should_optimize will fail from now on.
> > +	 */
> > +	if (__arch_uprobe_optimize(auprobe, mm, vaddr))
> > +		set_bit(ARCH_UPROBE_FLAG_OPTIMIZE_FAIL, &auprobe->flags);
> > +
> > +unlock:
> > +	mmap_write_unlock(mm);
> > +}
> > +
> > +static bool can_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
> > +{
> > +	if (memcmp(&auprobe->insn, x86_nops[5], 5))
> > +		return false;
> > +	/* We can't do cross page atomic writes yet. */
> > +	return PAGE_SIZE - (vaddr & ~PAGE_MASK) >= 5;
> > +}
> 
> This seems needlessly restrictive. Something like:
> 
> is_nop5(const char *buf)
> {
> 	struct insn insn;
> 
> 	ret = insn_decode_kernel(&insn, buf)
> 	if (ret < 0)
> 		return false;
> 
> 	if (insn.length != 5)
> 		return false;
> 
> 	if (insn.opcode[0] != 0x0f ||
> 	    insn.opcode[1] != 0x1f)
> 	    	return false;
> 
> 	return true;
> }
> 
> Should do I suppose.

ok, looks good, should I respin with this, or is follow up ok?

> Anyway, I think something like:
> 
>   f0 0f 1f 44 00 00	lock nopl 0(%eax, %eax, 1)
> 
> is a valid NOP5 at +1 and will 'optimize' and result in:
> 
>   f0 e8 disp32		lock call disp32
> 
> which will #UD.
> 
> But this is nearly unfixable. Just doing my best to find weirdo cases
> ;-)

nice, but I think if user puts not-optimized uprobe in the middle of the
instruction like to lock-nop5 + 1 the app would crash as well

thanks,
jirka

