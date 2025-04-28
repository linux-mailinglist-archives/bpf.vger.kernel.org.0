Return-Path: <bpf+bounces-56842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AACCA9F23E
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 15:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0923B46C5
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 13:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4257426C384;
	Mon, 28 Apr 2025 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6xbDRej"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F1A26A1C7;
	Mon, 28 Apr 2025 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745846656; cv=none; b=eUO8LqHgwOru2WjBukHiptFZLF5be+wItjQXe+O5umkTfaJXACnaiWbGsCdRZdd7GOChLHvz8gZRvGgLehKQl9yZ0lDDDoXbWLUDPW2fnJ9QHNhzP0eMeBXaQcYC7qqX7hwcBVYacCJg1ddB9ShsJaz20qO5R0aawZXraTe5eSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745846656; c=relaxed/simple;
	bh=hn6gUG/uMhg3INwamZeRuZN3rMEqPTje4krz2pd/DDA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2l9cThkiyRB7XHsgE4YEcmaChmDL9X6nffGFtAaQARbDpDYSMCocgS9tUE64pVAkFF0yxrWA2/vnBFcMPOKLCJZTIdEEhNIka9RtZm70ERvRycYButW9TFWdChIvnWN+98BiuoUX+FnWMkcJ5Oco+e8zu6CrPSkdb7GTe2mXbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6xbDRej; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-acb2faa9f55so594564166b.3;
        Mon, 28 Apr 2025 06:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745846653; x=1746451453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jZR2TvCbGlhyANdYnfatd8PyBN2C3qFNwSfpnT5DvJU=;
        b=Q6xbDRejyC7pQsAUi82VptEqTgVC8Uhl5UE73MRlZt9/bHQu3bbs2Sk1/FbF0jHKB7
         8yG0ih+A7cP4pga7G+2IoZOoSvk2QfqWqalbjdtz8rxfXBp9Q9+0EwrJa8/EINPNl5uK
         mU/RJZ79L+5MuyPi/K6ant5bi88fc9cmohHnisPIcnC62NT1Ssb5K3Jaa74vHhTfqhVI
         s/b+/VdoVl+s5dxZdECN/hMCP3CjqiG+DGYEETIpk+uc3ZAyxrdyH6CaPnhkv0b6rvoK
         tLhjS5WpSc4zsZL2+otYCmoVKoRjWgEFm5jlN4aWxURal4MxC/eMqhY9k8/PNzLYYQU4
         cJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745846653; x=1746451453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZR2TvCbGlhyANdYnfatd8PyBN2C3qFNwSfpnT5DvJU=;
        b=vj5Rs9jm0jlDvH+EZF8WMFrMiTwnV+G/VARpvvj0ZWAhUWVwqeOKiDL3azosCJbPov
         hZfX5eL9w5DTPMjF1oVRciVsMCRGpd7K6YT3dU95kDXd7WaR3rsRdPPWNeqlkoeiV5lx
         4Ex4wO+eHcKhyEG/RCgYWhnvUI+kSMGBGHMpcangth1Ds5nYwxFCcRrLiGvQDKhcC0GV
         yDqtP3GBoE9ZAUridA6chtImqomQS4HQSCAPhOoucJGl8H9ZxXAQDmU33iLsGDA8iF09
         SnWpkKHMfQ/LRt4EbqB4+Xt4Lw92ixYT73xBRe3fIEUpbjzcJ3iXlvzu8B4z8/A/XU0O
         A6Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVALCcNiE+pg539hMcQ52TSfyjKF1+wE9emLneONmfvGmtO9YObE2EV/kI/JU/oFoNbsVQ=@vger.kernel.org, AJvYcCWS1ozPLPlLkQwtPTns7MrU2bD1B3fJLfcpBv8KfXXllUP1C2TCC62SFAWlWvDIl+QmXzHMm33BDm72z0TcPDVWt0HP@vger.kernel.org, AJvYcCXv8tWDUos5DAII/jOXmRVVyQc9ySRvG/v9glUUKPrS7hDoZAdYEM4LxMZzDypzbnt8UD25HNFehPamu/bF@vger.kernel.org
X-Gm-Message-State: AOJu0YxfsTVjbNgrALCIa/qQACLIl1C8OfSI5PiZ23BMKVmdgBR3J8GF
	jhEGCVJJZVAeAH0cBapTehVYVeCKbHfA319Uf3+MlnrxJxGm8Jul
X-Gm-Gg: ASbGncsPwOADGhLjg6cc0xykL1GyvlN5P5Y+8tJkh7RJFAwNF8MJSKNiAHTv36EZrPQ
	xGSeRNBdFmSTyubNE1Oaas5ZitbzSpjQI774eZjAr9EKIG/rHI/NgsaX1LeIpygcBt3Ju8mcKVg
	AJxPPargEwEAFlMvcjwVOEtCxvS+VhKtGjljpR228JCpfJuh0I/fAscTdCtSZoU/KsASkviXAaz
	JZTT+OCAfRKoeKe8lXXlJiN/A7AjX+XB4MtYdYxQ/JEjM7mJmMxaGGf2oky4OIf0RHeCa03LUc/
	B3orjIx+dAJ6JzlcsGJoDchk/u0=
X-Google-Smtp-Source: AGHT+IFAarRX4q+A23a2tgB3P77G0Qv5o7xJlHPKXt6fFTo371xaafv79d3q2RE+3c3KdFkq7yVQzA==
X-Received: by 2002:a17:907:3dac:b0:ac7:ecfc:e5fa with SMTP id a640c23a62f3a-ace84af6a61mr997355866b.54.1745846653007;
        Mon, 28 Apr 2025 06:24:13 -0700 (PDT)
Received: from krava ([173.38.220.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e4e7260sm621154166b.49.2025.04.28.06.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 06:24:12 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 28 Apr 2025 15:24:10 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <aA-Beozthx9fxgRi@krava>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-11-jolsa@kernel.org>
 <20250427171143.GA27775@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427171143.GA27775@redhat.com>

On Sun, Apr 27, 2025 at 07:11:43PM +0200, Oleg Nesterov wrote:
> I didn't actually read this patch yet, but let me ask anyway...
> 
> On 04/21, Jiri Olsa wrote:
> >
> > +static int swbp_optimize(struct vm_area_struct *vma, unsigned long vaddr, unsigned long tramp)
> > +{
> > +	struct write_opcode_ctx ctx = {
> > +		.base = vaddr,
> > +	};
> > +	char call[5];
> > +	int err;
> > +
> > +	relative_call(call, vaddr, tramp);
> > +
> > +	/*
> > +	 * We are in state where breakpoint (int3) is installed on top of first
> > +	 * byte of the nop5 instruction. We will do following steps to overwrite
> > +	 * this to call instruction:
> > +	 *
> > +	 * - sync cores
> > +	 * - write last 4 bytes of the call instruction
> > +	 * - sync cores
> > +	 * - update the call instruction opcode
> > +	 */
> > +
> > +	text_poke_sync();
> 
> Hmm. I would like to understand why exactly we need at least this first
> text_poke_sync() before "write last 4 bytes of the call instruction".

I followed David's comment in here:

  https://lore.kernel.org/bpf/e206df95d98d4cbab77824cf7a32a80f@AcuMS.aculab.com/

  > That might work provided there are IPI (to flush the decode pipeline)
  > after the write of the 'int3' and one before the write of the 'call'.
  > You'll need to ensure the I-cache gets invalidated as well.


swbp_optimize is called when there's already int3 in place

> 
> 
> And... I don't suggest to do this right now, but I am wondering if we can
> use mm_cpumask(vma->vm_mm) later, I guess we don't care if we race with
> switch_mm_irqs_off() which can add another CPU to this mask...

hum, probably..

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
> Not sure I fully understand the comment/problem, but what if
> prctl(ARCH_SHSTK_ENABLE) is called after arch_uprobe_optimize() succeeds?

I'll address this in separate email

thanks,
jirka

