Return-Path: <bpf+bounces-56845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B1EA9F2C6
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 15:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E36017508C
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 13:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1032526A0F8;
	Mon, 28 Apr 2025 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgTx7sDu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0920E84A3E;
	Mon, 28 Apr 2025 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745848360; cv=none; b=Hp3rp4vedSafq3ZSCyU/GhdyhyYhQKxFE80o4QxcHdLCNlPH0ouiuOOS9WNzQg1d1Y0Qfi1+PnVyB956q2cxTcwG8D8iymNnr/zFIOnNyigKuN/zJ9qaNoWQd5WNEvZdr8/9JsUCETu2pbDmQmjXWsP15rZzYMpWFr6OvTiyAC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745848360; c=relaxed/simple;
	bh=YiyXYAEWOyufLlYVbFQj0/ql5q+We2qBq2b+gWBE84U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnECjMr4q7cPy3q0AMbLxzYIRuxBThc5sa661wORoRg6dIzeWGDUn0crnYM1t5koYQ85047R2Yy64nw3DUcQRJESP9iBqbkQvG5kS5SoE/UHINaW5h6YHdoehTribBoxSS/b9BwXAoMY2xVHuiMQaTS9qhX4Ww+19zoRMnBsOfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgTx7sDu; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5f4d6d6aaabso7735290a12.2;
        Mon, 28 Apr 2025 06:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745848357; x=1746453157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Qk7xr9uuwRSjYwMy4U3HtiuvB8Yd+TZDsggDR+t+kE=;
        b=ZgTx7sDukc30/Rqrw2G801PVXGN4yU0If7yVdfv52cxe45Ls1+NEm3HOFsYG6+19yX
         /lSX5ld9ycUTxIVvZGxp2aYTp/31mlTpMksiuuemLkti+lt0Y/DqVcm9ObE0PkFDKoIX
         VI0zPr6pSdzfP5ZpE0irJA3PQFMGiV8VbruBlQEX+eQ/29kqSd9IEIPUW6Dous6yALJX
         +RkNcdN7PR3AuaMqUtoptxeL2wOH7SVE2RhAVHBGej3Uw0VGue0wEI9hSY85/073onDb
         0kGTRCuTYqpALzcChYspTTT6VdGyiiZHxwnBm5EXbV6BtZOYXxg/bhbXUQGhj9tibs6u
         MgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745848357; x=1746453157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Qk7xr9uuwRSjYwMy4U3HtiuvB8Yd+TZDsggDR+t+kE=;
        b=pn+Dndy+MmAqlbw5xN9s9fbOkp8M22SmeBEcdPsdy0cLUDZ1xp4s4QOAwWg4fgm+O/
         u0EM02O2VTTqRadGaUPXQiHoNdV3y9j4Uwgg/JaTZV7OLoPV+ii9GGg4ozziLnbp2pcY
         boFTgYy5N9xWSCgNnTjZELMhctxvBrzEswUgC/PZd8/8gJbUBHdS72xpxSogkQqXKZZ0
         SD+HNqolzE+vVqY3A+pM5R1lUUz1CMdSdImjJ9aXUiSPIRa/U7cGuHOcxT7t3oTANIiL
         o2tvVxUAhFd3Zkt3TtgvnBBH2OdnMEQyTxbQYbSuFrrRSzqW/Uc1z0ll0CRKDkNTpusS
         xhHg==
X-Forwarded-Encrypted: i=1; AJvYcCV1FqVSEqQJ30KVj3hvJ7c06QSiEUxoCd10y2DN6tczSAMgXXCla6QDU3fsk0LsdvFszZDBICrf9QMDRMXkpHzUSJ+X@vger.kernel.org, AJvYcCVAQQr9u4KbllC54NzCyrHzlyBMI9nqXh/6NiT67mK3z/8UkXLNUw9CC1Qa+6HkXMUb824=@vger.kernel.org, AJvYcCXH/CCkLs7eAMNCJcXwmBS6hCxREFMBKJ38ZxzzaMGc3tmWnwzw5NIqiaOCIDIKYERx9YVbGOXGKXC8DsUD@vger.kernel.org
X-Gm-Message-State: AOJu0YzNvfxRjLLev0SSVM6Qd/Oz/sj3Z4wuiOM7Ri1LlAGxlmCeFpyG
	V531Yi2I4NHpaz5gsyteqUn8L0pE90ZfUtf5RUOWn5nGbduyGbEP
X-Gm-Gg: ASbGnctonopq1OWdxj94eosfXT3CDeSx02ekCa+BuVC8y+Sdbo0v6sEEPXkgbDri/Sl
	c2poTzG0qigbjxUdmPOBIHaY9NEkxnDPSc3c9pZUgs1sX5kbH51o91wqx93Rmv8vwHVAbqHwK1M
	nkoAOnTO8yhn6CpM9hWLp20vWqod6ewbonTS69kpQq98caczKFvrFEVztHC4rkgZh7Oi37IljwU
	Gn5pLLhrqxLdbX4oCMexK31JDYAE1Mi3zOUEeC+a2ObEahtiB/ngtMQnue3Ipx4uQfdVcCY8glO
	1Mvrx52T6wmAKv482iZS4dLi9qA=
X-Google-Smtp-Source: AGHT+IFCZpU/YmUHW/2njA9mieI/iJ8o1Jbs9JAI3+cFa+yteR0Hhm7avQ8WWUBvxAG0GEHM4GYQrA==
X-Received: by 2002:a05:6402:5021:b0:5f6:c638:c72d with SMTP id 4fb4d7f45d1cf-5f72257a2bdmr9221828a12.7.1745848357133;
        Mon, 28 Apr 2025 06:52:37 -0700 (PDT)
Received: from krava ([173.38.220.34])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f808b23ad5sm856452a12.66.2025.04.28.06.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 06:52:36 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 28 Apr 2025 15:52:34 +0200
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
Subject: Re: [PATCH perf/core 08/22] uprobes/x86: Add mapping for optimized
 uprobe trampolines
Message-ID: <aA-IImjaT33ZSHcY@krava>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-9-jolsa@kernel.org>
 <20250427180432.GC27775@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427180432.GC27775@redhat.com>

On Sun, Apr 27, 2025 at 08:04:32PM +0200, Oleg Nesterov wrote:
> On 04/21, Jiri Olsa wrote:
> >
> > +struct uprobe_trampoline {
> > +	struct hlist_node	node;
> > +	unsigned long		vaddr;
> > +	atomic64_t		ref;
> > +};
> 
> I don't really understand the point of uprobe_trampoline->ref...
> 
> set_orig_insn/swbp_unoptimize paths don't call uprobe_trampoline_put().
> It is only called in unlikely case when swbp_optimize() fails, so perhaps
> we can kill this member and uprobe_trampoline_put() ? At least in the initial
> version.

right, we can remove that

> 
> > +static void uprobe_trampoline_put(struct uprobe_trampoline *tramp)
> > +{
> > +	if (tramp && atomic64_dec_and_test(&tramp->ref))
> > +		destroy_uprobe_trampoline(tramp);
> > +}
> 
> Why does it check tramp != NULL ?

I think some earlier version of the code could have called that with NULL,
will remove that

thanks,
jirka

