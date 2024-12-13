Return-Path: <bpf+bounces-46836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D669F0CE3
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 14:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8C0164395
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 13:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1191DFDA4;
	Fri, 13 Dec 2024 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCxdUq1Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0EE1B6D14;
	Fri, 13 Dec 2024 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734094983; cv=none; b=N7YgRIrj1BmVQBl/vSWtxmhgyHNl8Lo+jCU4qIapa1qg7WMJPJKuTXHl8B81zAfasvP4QtLlmAJtEI38rXgdzKTAVNSVQaw8rf+Ge5XDcXkkeE/9qSHi1hXhziPlpuyYOeYwDvoCb6yyFhP1dbnB6/EpU/IoBrkOSEWdp4Go8bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734094983; c=relaxed/simple;
	bh=eOHv9bgSptLqDXcvvlILRpCCRGBprfHIR9LeZ6+5n9w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1OgdOBDgfI/BozlbDzC+FgkHWuy+aEoorduh12L4g2k3XVd5yNM/9wLLW1rV9GhfYz77m+owzqBcKiicutpVoBj8sJsAWH0LRFqx0sCh4kWLVfkFIqcFHTUgint0HixeWgFVlVLk4mFRcQ8hBe8lxOQuKs0NDPe63mRvzDwVlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCxdUq1Z; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361f664af5so18152265e9.1;
        Fri, 13 Dec 2024 05:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734094979; x=1734699779; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cVqA3EWWaY9TRkvPct1HGfcQOD/FwItMYVggUcSmkOw=;
        b=aCxdUq1ZTFVD4YFSXO7NediauPKUqX48h7bTdFGwHSZc7OvMgnnFDGxwYXH4Hws18n
         q9MITL5kLHIC1p/CHDxRZ6oUAaJJt2xVMBh2ROxOyBjmnECTF6hf7qjFdhbN6abp2Vnm
         nCEFRgJom3RkEG19bxsXYqaOYUFurJQ6VHcyZQ6Y2as0u+xTxu3R4TBGHLhN0C1eutBr
         kUKa9OYl1JOCzlsv6CVX2C5/QVszjj+Fa4A0D0d4Vwg4cuELGE/cVhhPOUkaP9Mz7y8/
         MErc6HbcT5cJmF/Zbsdi2dtIqqv2IPsDHmCVP+qoceRyWPMC1hq4lC8kkiMImhtCYYZd
         voVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734094979; x=1734699779;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVqA3EWWaY9TRkvPct1HGfcQOD/FwItMYVggUcSmkOw=;
        b=hfziDn8BW+andfHI+DLNYSrv+zF23D5UWPZRMDMtq7hL49Sm3tlN5Nk5MYvxgdP//6
         2Her4L0vKwORdpM5sHXDQ1HfaLBRpq+D8y0AvN5FB0FXY7MfHuU5+P2sOHxZHl0P70WU
         DsT8633FZwq8Pt4RxVDWEQVgBEJFiADWFdl2++STQCEQp6oMLBCSmuA99AuR7EoXzntz
         hMv6ksCloVgTCmCFsB+pez30H0UKt3636157UqM80J8WdZJknP/fok3ye/MQ3MxOqyPt
         7IYVOe4MPYx8oVij7PBKHN5IcDBNh59iTvW/DNBbFIfq1tovrUe+wIUNVN4niohHlxdE
         +kEw==
X-Forwarded-Encrypted: i=1; AJvYcCV671GVp/wKT8PueR8oyO1ZJWVWKnYU9FZXdvdy8GzjgGE8fYv/iQwPa6d4j3XtOFRe2ZA=@vger.kernel.org, AJvYcCWIe++o9tAMlV1THEdCDXRIJNmpXxO9tjan7ofG+TwsafyOcZbzKTpXZ7JWGc5+HUdT5UmYSYe4ROQK5fz0fuZHxD7Q@vger.kernel.org, AJvYcCXo4JE4YboL1bRrJtrINJwolTVZVmkqrZJTTR4feHajrUKPP9QexUCUVjc8F1ApH1cT1lUapvmSpdAI6+F6@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ1IAdCOJ/eWu4DZta9Hyr6ziE4WaRA+/unkppILusThFXiTTN
	xLNG0InD76OQNq+neeLZNF3ZnhHKfvjdjmfr4/w2sFT7KL9FzNoN
X-Gm-Gg: ASbGncsIJ/X4ij6Ik3TbwbpYwMuwaWYbOfmrIhdh0tnmyI8RqttTtWpsJq8nZt/xOPr
	pE7Kkl0Dk8Po2xH1tGMqu8eRrUre8cnjel7AEc3DDK9naXkyGywcxBokH5LvRKfkxy5/NQAm7P2
	DqZT0oLwozFetWW/dXvUMUnu6TuNKqFP6u9xP+tUW6588fQCBUSSB+E4K5AlepH3aMGXiK0Pu/w
	WBYwvdqXnJn2u1bXY2oz7/HGM/Hk9xx7AhbNFoBVndNgsJkvLdFSnued9YHMyiioy5cjkYSlqMa
	C1nfyTRK0UI5UG4cy1zj/GgMzqXU6Q==
X-Google-Smtp-Source: AGHT+IG4B3IGdjHz7hPYBV8Vxy3CuZvgFizI2WTe2k4yzRL5aPRIszxm1lA/KfX+nRZknTRPM6OBvQ==
X-Received: by 2002:a05:600c:511a:b0:434:f804:a992 with SMTP id 5b1f17b1804b1-4362aa9fe0amr18821835e9.32.1734094979206;
        Fri, 13 Dec 2024 05:02:59 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559ea75sm48750535e9.19.2024.12.13.05.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 05:02:58 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 13 Dec 2024 14:02:56 +0100
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 07/13] uprobes/x86: Add support to emulate nop5
 instruction
Message-ID: <Z1wwgIPh7dieKSPV@krava>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-8-jolsa@kernel.org>
 <20241213104536.GZ35539@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241213104536.GZ35539@noisy.programming.kicks-ass.net>

On Fri, Dec 13, 2024 at 11:45:36AM +0100, Peter Zijlstra wrote:
> On Wed, Dec 11, 2024 at 02:33:56PM +0100, Jiri Olsa wrote:
> > Adding support to emulate nop5 as the original uprobe instruction.
> > 
> > This speeds up uprobes on top of nop5 instructions:
> > (results from benchs/run_bench_uprobes.sh)
> > 
> > current:
> > 
> >      uprobe-nop     :    3.252 ± 0.019M/s
> >      uprobe-push    :    3.097 ± 0.002M/s
> >      uprobe-ret     :    1.116 ± 0.001M/s
> >  --> uprobe-nop5    :    1.115 ± 0.001M/s
> >      uretprobe-nop  :    1.731 ± 0.016M/s
> >      uretprobe-push :    1.673 ± 0.023M/s
> >      uretprobe-ret  :    0.843 ± 0.009M/s
> >  --> uretprobe-nop5 :    1.124 ± 0.001M/s
> > 
> > after the change:
> > 
> >      uprobe-nop     :    3.281 ± 0.003M/s
> >      uprobe-push    :    3.085 ± 0.003M/s
> >      uprobe-ret     :    1.130 ± 0.000M/s
> >  --> uprobe-nop5    :    3.276 ± 0.007M/s
> >      uretprobe-nop  :    1.716 ± 0.016M/s
> >      uretprobe-push :    1.651 ± 0.017M/s
> >      uretprobe-ret  :    0.846 ± 0.006M/s
> >  --> uretprobe-nop5 :    3.279 ± 0.002M/s
> > 
> > Strangely I can see uretprobe-nop5 is now much faster compared to
> > uretprobe-nop, while perf profiles for both are almost identical.
> > I'm still checking on that.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/kernel/uprobes.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index 23e4f2821cff..cdea97f8cd39 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -909,6 +909,11 @@ static const struct uprobe_xol_ops push_xol_ops = {
> >  	.emulate  = push_emulate_op,
> >  };
> >  
> > +static int is_nop5_insn(uprobe_opcode_t *insn)
> > +{
> > +	return !memcmp(insn, x86_nops[5], 5);
> > +}
> > +
> >  /* Returns -ENOSYS if branch_xol_ops doesn't handle this insn */
> >  static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
> >  {
> > @@ -928,6 +933,8 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
> >  		break;
> >  
> >  	case 0x0f:
> > +		if (is_nop5_insn((uprobe_opcode_t *) &auprobe->insn))
> > +			goto setup;
> 
> This isn't right, this is not x86_64 specific code, and there's a bunch
> of 32bit 5 byte nops that do not start with 0f.
> 
> Also, since you already have the insn decoded, I would suggest you
> simply check OPCODE2(insn) == 0x1f /* NOPL */ and length == 5.

ah right.. ok will change, thanks

jirka

> 
> >  		if (insn->opcode.nbytes != 2)
> >  			return -ENOSYS;
> >  		/*
> > -- 
> > 2.47.0
> > 

