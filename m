Return-Path: <bpf+bounces-55524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20834A8245F
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 14:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBBFF1B80524
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 12:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1228825EF89;
	Wed,  9 Apr 2025 12:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpsj4Jtp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA6625E471;
	Wed,  9 Apr 2025 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744200487; cv=none; b=njAjIzOTkxiTw3v6uHtCLK93EdUpOIO75NGCy7K5TELXIH/M1FrPYVhgURiW3qpZPHJjloIOP8ger9U0Q1Rxn295jgsyO8+RPEvpFjrRNv/SHCyq9ORjQeh+C2UnxyRjw1KRNT6f7kQJmXgbyOgxWvGB5efadGcpIvdcaXQccEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744200487; c=relaxed/simple;
	bh=lq1OiQsVOMHwrGtmmhdpg6FWU56qqzjfijOiXVoJzFc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8ORSggcpZ6YCu6c2qye32TP9UJn1i69XztjmlDHLuJ8s3drLhdOJuPsVrG4ZPGML9cuieEp1QfN9q/Tw3TsY5mLMRChP0DsAiI3zzNZN40vxl5wwP1Oa3b6m1kh+0tGoXetyg0LiVZJ9VO1mBu3TpAdPaSUDpurX4WVu4ZtzA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpsj4Jtp; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so10949430a12.2;
        Wed, 09 Apr 2025 05:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744200484; x=1744805284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NWhG9TBVd/wh+MuWkoZWly0RfKaqH96r0b+wVnwq3FA=;
        b=bpsj4Jtpsm1qVPBmY+5dqvJzP8E6wW4Zi+Vln2aITbBM6Yv2nXlMQQpN1m4Cg4d8/e
         VEeBvrT6HjOPnaVp2pMEO0vA8tDG+kTkCooWcD9GDnANHC2hE8ls/Lij/FusHEiw41nm
         ZHUZG9ytpQa/1c8hy8vkpP3yFYDJb8XqBJCTHepaUh2uFSXnb5taKO1nBhypgUuE3bat
         08vJXnoEldYAbbdKL1TuhbiUqDKmyeZ8lhk39pslTgLiizHDngbbe5LFtNJtiM9VnJb0
         g5jNeEy8JGPFsz8Echc70Xb5QQIwMpEviG1E+nWC6PdsQzQaaLlXP5dMUO02U3Rl3ssi
         wF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744200484; x=1744805284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWhG9TBVd/wh+MuWkoZWly0RfKaqH96r0b+wVnwq3FA=;
        b=KRtjp9aDBQnjLehB1lm1RqCz6QLxm9x/1j1mLWf+KNvuz1+NMKY0PMiMVA6UwCVnM3
         6Cs683+IO39AjUy4dph2C6gMh668eCGGHEyCir9nhx9whvqkRlvQbmT0JHD+SBm6NL3c
         0hEAegY80R9gsGj55kdPq0E0/glkK4OkKGqfRmlB0cQZSlomBMM6TwbUoWZu2OayPKk9
         0j+XQLtksS0NXADP9f9EFoY3ZDoTFkhYJiwDvU+OhLQD3z18ErvkxuEq/3/bNOD8AUN0
         0qht2esdJriTqZyaPStzN891zpdVNxsbmIFJEILWBfgg3bbSltOyp6rT4gYslkWaPv2C
         4z6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUF1iYDadpF3oM7A5puSfTMEU3I56sfUCWYGyTukH4l24P/RoSYtbIrur07MjjUq6w+pBWXfDyVYxZLqivzD3Bm+ynz@vger.kernel.org, AJvYcCWvzMj1Bb+zqLYENUD9jd2XLOohHGrbqbLE/0pj9Y0QQ9p6vy6QKzTlGaSZwSCer8ARhOKOKse3oeFgY3Cg@vger.kernel.org, AJvYcCXaua+EgJ008UmsvkHK/Hknci6Bltf2t5P0G1GpOb9vG6TOEpQ0J1F6jDsDfS7G3arMXEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv0SrcZZ83qnoFhSWops5y/7noIAfacuHlqc0O/FEltx0VXOAP
	7bj05HPJWiGDLYrR68CGnuZ8WbLSS6AILUyNOX7i6l+jUmgEu7TF
X-Gm-Gg: ASbGncuNCc3+YsGfruZvzW9QXeSM+2J57ZWF1U6xwl97BM1oJaGFL+DdfxNer0dUHVm
	hIjjtMs3VDOBRAOXThL0T6p59v1KmAJ/buoXzj+GvS0mkCvi6VYVLii3BUNinpiWym3iq1ODjWp
	zgz6vZoNAcpWTb7J13Su2b42jPI2MH5X/w6ndKAxBOlno+OeiC2Mpi0mzqcrm0dmyl/qAcb9vq+
	fwlGcqOBVEMXJxAd/6C1v0LB7/M7bRDUtgZmhXNmZmVHXcRdqdCi6IZV6EHJcvccTl/QhxcCz97
	52gRTdkxOVuZFxhfWTdPf5Pcd+xQg9HLklzw6/5X5kZevBE=
X-Google-Smtp-Source: AGHT+IE4gmN92nUmZyVQlBNP4+nAs0/QbGtCFNatkp92wpmQEcVPxKH1Iuhd5MEBckojcC+d5Mo1vg==
X-Received: by 2002:a17:907:3e9e:b0:ac3:c020:25e9 with SMTP id a640c23a62f3a-aca9d6449e2mr185657466b.34.1744200483911;
        Wed, 09 Apr 2025 05:08:03 -0700 (PDT)
Received: from krava (85-193-35-57.rib.o2.cz. [85.193.35.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bea593sm88154666b.62.2025.04.09.05.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 05:08:03 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 9 Apr 2025 14:08:01 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH 1/2] uprobes/x86: Add support to emulate nop5 instruction
Message-ID: <Z_ZjIerx-QvY7BSI@krava>
References: <20250408211310.51491-1-jolsa@kernel.org>
 <20250409112839.GA32748@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409112839.GA32748@redhat.com>

On Wed, Apr 09, 2025 at 01:28:39PM +0200, Oleg Nesterov wrote:
> On 04/08, Jiri Olsa wrote:
> >
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -608,6 +608,16 @@ static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
> >  		*sr = utask->autask.saved_scratch_register;
> >  	}
> >  }
> > +
> > +static int is_nop5_insn(uprobe_opcode_t *insn)
> > +{
> > +	return !memcmp(insn, x86_nops[5], 5);
> > +}
> > +
> > +static bool emulate_nop5_insn(struct arch_uprobe *auprobe)
> > +{
> > +	return is_nop5_insn((uprobe_opcode_t *) &auprobe->insn);
> > +}
> 
> Why do we need 2 functions? Can't branch_setup_xol_ops() just use
> is_nop5_insn(insn->kaddr) ?

I need is_nop5_insn in other changes I have in queue, so did not want
to introduce extra changes

> 
> >  #else /* 32-bit: */
> >  /*
> >   * No RIP-relative addressing on 32-bit
> > @@ -621,6 +631,10 @@ static void riprel_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
> >  static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
> >  {
> >  }
> > +static bool emulate_nop5_insn(struct arch_uprobe *auprobe)
> > +{
> > +	return false;
> > +}
> 
> Hmm, why? I mean, why we can't emulate x86_nops[5] if !CONFIG_X86_64 ?

ok, so the following uprobe optimization is for CONFIG_X86_64 only, so I followed
that, but I guess we might emulate nop5 for !CONFIG_X86_64

> 
> OTOH. What if the kernel is 64-bit, but the probed task is 32-bit and it
> uses the 64-bit version of BYTES_NOP5?
> 
> Perhaps this is fine, I simply don't know, so let me ask...

hum, did not think of that, let me try it

> 
> > @@ -852,6 +866,8 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
> >  		break;
> >
> >  	case 0x0f:
> > +		if (emulate_nop5_insn(auprobe))
> > +			goto setup;
> 
> I think this will work, but if we want to emulate nop5, then perhaps
> we can do the same for other nops?
> 
> For the moment, lets forget about compat tasks on a 64-bit kernel, can't
> we simply do something like below?

I sent similar change (CONFIG_X86_64 only) in this thread:
  https://lore.kernel.org/bpf/Z_O0Z1ON1YlRqyny@krava/T/#m59c430fb5a30cb9faeb9587fd672ea0adbf3ef4f

uprobe won't attach on nop9/10/11 atm, also I don't have practical justification
for doing that.. nop5 seems to have future, because of the optimization

thanks,
jirka


> 
> Oleg.
> ---
> 
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 9194695662b2..76d2cceca6c4 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -840,12 +840,16 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
>  	insn_byte_t p;
>  	int i;
>  
> +	/* prefix* + nop[i]; same as jmp with .offs = 0 */
> +	for (i = 1; i <= ASM_NOP_MAX; ++i) {
> +		if (!memcmp(insn->kaddr, x86_nops[i], i))
> +			goto setup;
> +	}
> +
>  	switch (opc1) {
>  	case 0xeb:	/* jmp 8 */
>  	case 0xe9:	/* jmp 32 */
>  		break;
> -	case 0x90:	/* prefix* + nop; same as jmp with .offs = 0 */
> -		goto setup;
>  
>  	case 0xe8:	/* call relative */
>  		branch_clear_offset(auprobe, insn);
> 

