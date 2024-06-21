Return-Path: <bpf+bounces-32725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F36912681
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 15:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89BC1F22B2C
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 13:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF98BEEC4;
	Fri, 21 Jun 2024 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwDmfFsg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69BA2E622;
	Fri, 21 Jun 2024 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718975884; cv=none; b=aEGSDNN2SxdiR9zbtKkrrhPY6g0eIq5E42NjYLdGLIixlVFx2lTXcIQW3YsN4/J43XKNBcAutBNGT1WUUlT1dra+SAF55vyn5BdhOO/xh7GfRgIq9BYbW8CCTZq3TRS7HS6ZFWqysa/52P6v6yycPwwbhRonNMUYYhZf/oJDTLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718975884; c=relaxed/simple;
	bh=NTlU4MzAnhhcT3IXIo/UnGQRRM53fAqVg82XwxlIG3s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8patnco3wykoXMp46UB+EImT3yPY1czHBIa63BmVL8PkM6w4pkI8cANIHL3qTREvu2gA9ZqaaG8+qiPTYvHd9FS+OMOrMnjTsLnJZ5fnRY7Tdny6DinwILNLr75h61UktmeUcmPIxDSlW80uQl9UhDnchmnfXxtZapkJA0wMiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwDmfFsg; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52cdb0d8107so454631e87.1;
        Fri, 21 Jun 2024 06:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718975881; x=1719580681; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Va7fQxN9lBsLo744XPC53nXOlbU4afLajRDQWh9HAcM=;
        b=LwDmfFsgIgqXSJLe7vkAQorPvrkxgUoi9GwHAAjqtdXUj7BldJCP+CpE9sTNQR4HkE
         NNOwil3Be5uxnON1hKy/U+tPXfZQ3rLbGLhZaD3wslW0DU7iw2/sPASpu4VfdkItySPj
         KiEbpF7b2jrEi1q7hg4NaDtzcqprDpaJihUFUkruJz84ha7x37IPNNKJXuFfcH3QW592
         EBg1AbkgkaPyUcFP64ywEhf+36U8v+GsXUhxNZRV/16Vf5TvOlrmOEU7y+pXSBIfrT1y
         4s7kM95McoWqtKtwbFcBIojIoYD7VA8edHUmmDqV5OySSjY3ByL921bkKFbeP7D/lEQg
         YUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718975881; x=1719580681;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Va7fQxN9lBsLo744XPC53nXOlbU4afLajRDQWh9HAcM=;
        b=Clh7Utq606K45dhxCpq8LNFQ16JbJsRFEkvy8KqDn6+GeJg5QFoGn3D2K669HhB78Q
         j7wcuDyXT2q5hHEpaHyoevG0CUa09mSlOqqTeZxAtnWeplphKZCW4fuxNXJxSgwifQyg
         VSsbLLP1XueHAtVBA4rI/JzFc89JV7KX/Q1CsrZ3jrl/AFh8e30m6AITd6y83V0ELCDc
         YY4cNHEUqQ/3IsfNTWo654O0dVoN582mcUzwnxlYQ8PMrIidnLxYUYDlVxHg5ZUmQwd1
         eHjiLpxD9QoRKOVSuInDLoiT7WgYKv0V3fMX6WCzLx5vPHmvIZx1BbMuo/GbuhU5D4KQ
         6Vtw==
X-Forwarded-Encrypted: i=1; AJvYcCVpl99QsDDLdMow1ZioOEzDLn4Z3aA5pxFKsPuVkxLUTNaUTUtgk3EKKWCOrLjSWTu5qZImNywTNG8TuBlhUoopjQdAhjGJjX+6YWbUid4xGLAd0IngopZP38WunfKDRNMF/d7DTNOPXLfFFK2TM/aKfAZrVEf+FJh9HrLciDBTQU5iViKO
X-Gm-Message-State: AOJu0Yy6hpo6G08SfD9Onk4HjsqjDr3l2RMwzFccuotVNUM0S7UDCRZk
	UxfaKBOT6UGfDgc0Scv7QKvFy9yJBRlmI9lzX0lbbsmRsfcFQEV9
X-Google-Smtp-Source: AGHT+IHkhqARK5Dooq1qSnFt+7oS2w45OWcGar+Ac/wnacPVJSV9FXzNu8K18xQUDgDf/Jb4mgoyTA==
X-Received: by 2002:a05:6512:138c:b0:52c:cda0:18b9 with SMTP id 2adb3069b0e04-52ccda01977mr5931095e87.59.1718975880879;
        Fri, 21 Jun 2024 06:18:00 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817a8d8esm27985845e9.12.2024.06.21.06.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 06:18:00 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 21 Jun 2024 15:17:58 +0200
To: Oleg Nesterov <oleg@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH] uprobe: Do not use UPROBE_SWBP_INSN as static initializer
Message-ID: <ZnV9hvOP5388YJtw@krava>
References: <20240618194306.1577022-1-jolsa@kernel.org>
 <CAEf4BzbN4Li2iesQm28ZYEV2nXsLre8_qknmvkSy510EV7h=SA@mail.gmail.com>
 <20240620193846.GA7165@redhat.com>
 <CAEf4BzaqgbjPfxKmzF-M7nzGroOwKikA0BM7Tnw7dKzKS+x9ZQ@mail.gmail.com>
 <20240621120149.GB12521@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240621120149.GB12521@redhat.com>

On Fri, Jun 21, 2024 at 02:01:50PM +0200, Oleg Nesterov wrote:
> On 06/20, Andrii Nakryiko wrote:
> >
> > On Thu, Jun 20, 2024 at 12:40 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > But I can't understand what does it do, it calls emit_break() and
> > > git grep -w emit_break finds nothing.
> > >
> >
> > It's DEF_EMIT_REG0I15_FORMAT(break, break_op) in
> > arch/loongarch/include/asm/inst.h
> >
> > A bunch of macro magic, but in the end it produces some constant
> > value, of course.
> 
> I see, thanks!
> 
> Then perhaps something like below?

lgtm, added loong arch list/folks

for context:
  https://lore.kernel.org/bpf/20240614174822.GA1185149@thelio-3990X/

thanks,
jirka

> 
> Oleg.
> 
> 
> --- x/arch/loongarch/include/asm/uprobes.h
> +++ x/arch/loongarch/include/asm/uprobes.h
> @@ -9,7 +9,7 @@ typedef u32 uprobe_opcode_t;
>  #define MAX_UINSN_BYTES		8
>  #define UPROBE_XOL_SLOT_BYTES	MAX_UINSN_BYTES
>  
> -#define UPROBE_SWBP_INSN	larch_insn_gen_break(BRK_UPROBE_BP)
> +#define UPROBE_SWBP_INSN	(uprobe_opcode_t)(BRK_UPROBE_BP | (break_op << 15))
>  #define UPROBE_SWBP_INSN_SIZE	LOONGARCH_INSN_SIZE
>  
>  #define UPROBE_XOLBP_INSN	larch_insn_gen_break(BRK_UPROBE_XOLBP)
> --- x/arch/loongarch/kernel/uprobes.c
> +++ x/arch/loongarch/kernel/uprobes.c
> @@ -7,6 +7,13 @@
>  
>  #define UPROBE_TRAP_NR	UINT_MAX
>  
> +static __init int __ck_insn(void)
> +{
> +	BUG_ON(UPROBE_SWBP_INSN != larch_insn_gen_break(BRK_UPROBE_BP));
> +	return 0;
> +}
> +late_initcall(__ck_insn);
> +
>  int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe,
>  			     struct mm_struct *mm, unsigned long addr)
>  {
> 

