Return-Path: <bpf+bounces-70184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F87BB2B83
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 09:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BDAA19C3314
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 07:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B96D2C17B4;
	Thu,  2 Oct 2025 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSzitvdF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E49D2C08A8
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 07:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759390996; cv=none; b=sP8Pq1QovAXC+vISAHWew8GpIM82Q9Lz1syfDnGcWPUy4uoNXwTI84Kf+5azPlvXhChepk0SaoAMpXMUmE+bVhSLzeyp30+thVg5d8vGjac/RChYSi95DSkO5D2+hBmPNxGnZrbKktcfGtDKPsf80qbmNrgIaF5YGBiNXlnQYTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759390996; c=relaxed/simple;
	bh=Nrkf8BY6z/Uw8X3bZjTWFJfk/9S65PuR1ftbiUPrqWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4ShYD597IshA7qmE2ps+Q+8pAPLkAPmMCiQUwuItJw8sjzupFj8owhZIVwFiPKuqeq4OkhgfCaBIpet52Co6DNtTjCQjESy+f/VQTWDvlWbVxtLj6dA0RUgosPw8yGIPbFiOHvMYQ2MN4K7nwsZgaU62C0y1OJ4UGKeRtPYvl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSzitvdF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e47cca387so7106405e9.3
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 00:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759390994; x=1759995794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8qBLJLdnLNMJht8kVfnivZV+oAoQMo4McD6KyrWTSis=;
        b=eSzitvdFm9IioBDInvVsU9MTio4PpGdzMVOYFxw0bEH4TBshkBKoh6iSQB5Y4lLi2V
         RgQANqoA7x7Rmnc6l+xrMITYi+6NAwBnKTbeUllKinzYl0j7xraJ6wHkPbfCCt34AUi4
         tm5iVq/P30UP0UAp7ozC++dtyCPzmKaVS0zzWDa/O6FxJ0kwdwcFcA4Z9iFNdLhjBAsa
         Yr10WZ31ICB7kwF+wJz9JhLLXX22tj89D9KdIXSurxw0CUyXQi6q814rsNRxHD/0iFCe
         ShFm5UgppwGE3MVsM4F5YAlDrYDUgnAdnSPtu11YN0/uyfi4eixJQDc5z/dPqe00ZwsX
         9Syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759390994; x=1759995794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qBLJLdnLNMJht8kVfnivZV+oAoQMo4McD6KyrWTSis=;
        b=jWBVEQ33uNwiiV/FqeZ3VK8fvoZ0AC7AjDKvcKxeLw9RjGULdXu3zTl0CrgTRJ//QW
         QJ/05kyu9PKyA+8/TxaDC6XoF2NrFmc/OAFtg+4b/o4vPmKxdoL9KJ+xTt+3T2Xnk40l
         B7intwPMR0XLBTnhch6kGpPwtt9r0vwmjwbYqst98OgU2zJHqyl3bY4EVN5Pe4jYPDb6
         wLRP44Pf+RQLLL+E2rL857xV6lPqkrz/CQ9MdnSOfH2j4jYndmS+9pZgPAVQW+2Q/k7M
         +pPjzlBO+TgWhZlZsxefbg9GS7rqZeL7NYKTP+hqMgxI5pZ0oGpEipgnm8StU3Kd/Iya
         mixA==
X-Gm-Message-State: AOJu0YzzZcveXmZR+77YGJ98qClDojaMsA4gP13SMNyQD/ioBgyZa6Cx
	uWmQWWzKEfLCiyDGqEOjOCZN78mw+8CAIjvhEE2SjcUqLs7hLgf0LctFxTb+TQ==
X-Gm-Gg: ASbGncvrgR067zgpOxdxkWuSQj12XPAi4nTYu1sMdEJXNjIp/2Flj1aMO5gYUHv472Z
	WhcyjSE3/Ad5R3+lnnTMmW0kCd8wpr72q6/hD7a7ix+EDQcFFJqHV/TIAfw3IKEehMrJMFwjwKo
	0+jgP35V7alF6w/F9cfosvheu3sp/l5xDvpyqAKfap/lT4C4T9GBR6q/A7zUnd648KBOqrqEzIj
	FjONwFuo/rzeGNtLQ8jiKuosEtRBALkHkW3FK2D2ZZ8mx/NOCFAvCgpXaDzpSV+t1CTGC6NsDTy
	+91+xK837l9wFzu8K/iCaGZvYKRc1/mJVxE/w+/OY2pj0cSkI5meeWDyfZs5E3O/2kipI8JdA7Z
	0seNnX+CGNMtGJRbtyUhPRVYORQx4+4+C5pJYB+kSx6w9hbxXTghCn+pj
X-Google-Smtp-Source: AGHT+IH3g26tLORUA3feAIdp7wX/3QM8M9CmOrRB88MNukHHhl+08Z53RlOFxDp9Sqev/E1ZCvbafA==
X-Received: by 2002:a05:600c:8b06:b0:46e:2e93:589f with SMTP id 5b1f17b1804b1-46e61286199mr53045555e9.14.1759390993393;
        Thu, 02 Oct 2025 00:43:13 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b8343sm70096255e9.2.2025.10.02.00.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 00:43:12 -0700 (PDT)
Date: Thu, 2 Oct 2025 07:49:34 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v5 bpf-next 11/15] bpf: disasm: add support for
 BPF_JMP|BPF_JA|BPF_X
Message-ID: <aN4ujq176kOcXbD9@mail.gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
 <20250930125111.1269861-12-a.s.protopopov@gmail.com>
 <c0626a7e12038a7afa4a4fda7c0f8e99b99596c2.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0626a7e12038a7afa4a4fda7c0f8e99b99596c2.camel@gmail.com>

On 25/10/01 05:18PM, Eduard Zingerman wrote:
> On Tue, 2025-09-30 at 12:51 +0000, Anton Protopopov wrote:
> 
> [...]
> 
> > diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
> > index 20883c6b1546..4a1ecc6f7582 100644
> > --- a/kernel/bpf/disasm.c
> > +++ b/kernel/bpf/disasm.c
> > @@ -183,6 +183,13 @@ static inline bool is_mov_percpu_addr(const struct bpf_insn *insn)
> >  	return insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) && insn->off == BPF_ADDR_PERCPU;
> >  }
> >  
> > +static void print_bpf_ja_indirect(bpf_insn_print_t verbose,
> > +				  void *private_data,
> > +				  const struct bpf_insn *insn)
> > +{
> > +	verbose(private_data, "(%02x) gotox r%d\n", insn->code, insn->dst_reg);
> > +}
> > +
> 
> Nit: there is no need for this to be a separate function,
>      can be a direct verbose call, like for any other instruction.

Thanks, removed. (The function was part of the statick keys patch
to print all ja-related insns.)

> >  void print_bpf_insn(const struct bpf_insn_cbs *cbs,
> >  		    const struct bpf_insn *insn,
> >  		    bool allow_ptr_leaks)
> > @@ -358,6 +365,8 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
> >  		} else if (insn->code == (BPF_JMP | BPF_JA)) {
> >  			verbose(cbs->private_data, "(%02x) goto pc%+d\n",
> >  				insn->code, insn->off);
> > +		} else if (insn->code == (BPF_JMP | BPF_JA | BPF_X)) {
> > +			print_bpf_ja_indirect(verbose, cbs->private_data, insn);
> >  		} else if (insn->code == (BPF_JMP | BPF_JCOND) &&
> >  			   insn->src_reg == BPF_MAY_GOTO) {
> >  			verbose(cbs->private_data, "(%02x) may_goto pc%+d\n",

