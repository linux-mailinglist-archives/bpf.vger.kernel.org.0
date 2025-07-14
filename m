Return-Path: <bpf+bounces-63261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CBAB04981
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 23:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68FA07A5296
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 21:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4DF25BEE6;
	Mon, 14 Jul 2025 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8Ae1Z4C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43CB26A08D;
	Mon, 14 Jul 2025 21:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752528565; cv=none; b=pgeZn2WSMa+Nqy/93TBhJMqYH/XQqaHSr3N13aGJetCyVCbljNsH+VewhiNvKyWllznUA6Rxshj+7rGIoJ032jpZ7jBQPajgCg8L/am5gnKe5BeioOy5wHHXMNjRNrrrgfxKUJ7VQJOvMXRbJHB+ymIwCfk2zH7c/NKEsXthoJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752528565; c=relaxed/simple;
	bh=wNlPFgcQBE+YVd9T5sWzXYJmGvbiBUkszEjf6MfB0sk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idhPCYS+NZZC0k2tTEeGEuAKAff/joczatSQtHg/EzXONM043Fx8XHb9qldBRK1qik2FBh2WK05d18ASVZ/a2noA+Y1NWUEI0srF5tsY5WX9NsY3zN7gPuEJ4Av4CIkJedVlP9gcC4z93KfcF0hRtak6HG5IeeUxVl3P1OCZZtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8Ae1Z4C; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae708b0e83eso564388766b.2;
        Mon, 14 Jul 2025 14:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752528562; x=1753133362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hc+CHUwBNo81fHNbgQNz93LxIT8EFWDlnxIV9lTjSTg=;
        b=C8Ae1Z4CwpgmFm+ULSbbs6y5eFB2xr+eJCgbecxJcRUzfHEMV1sx5l2sjoGbqSMwfJ
         trePmeRm8mtiwrFkIjkKn2BsMdrGdOvCxJ2S8X9R71sK+4dZBzmb+TkPpOHkpoIbtzrA
         qKv/amcLH/717ioWwIai39TygEVDSVc9T3lpaGK97rF0aj4OrXkzo1qkeQJ7O+g6sgpp
         nO+Pt48QtJJbqHCEB8nXzNleGieJzcqJHZSIrMvyJiODv+vCPUTXsaTYFs6n6pZ84Q5S
         rEJJxAJb3ztFQMb6mfC6UkkRR84FuhB4PC+jKAHUdZR2veyU7Kj0hAjiDR159p0xmENT
         9ldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752528562; x=1753133362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hc+CHUwBNo81fHNbgQNz93LxIT8EFWDlnxIV9lTjSTg=;
        b=fXL8PadRJPT8SvhOwiRihdy5tVGNinMusjvW2UYNfweaEyVhk5vmPmsDGreTO19ZLb
         /X/bidJa3TLSDEetrGrnuKz/5rQfe7ARmybOneHfW9CQnCIPc4+YQ82YfZnOb8wIINV+
         OwlT0hHL6+7VILm0dVc0/jcW/IFH+GcwfQ8XQ68rO0eOPoptiKhdUgDxJ+yaDsFUHKDm
         MMyqFyi8yn9Vn0aNht76yh/m78jqZpoPQUbONTQiTfrqeWJHDDr/wCuSoFF0dR4hWYgx
         t2d2/4+Lv70dLYolVDPt3oX27c5p/6N2n1gLkO5M+KTLrIMr5jQ0C3FYjStENWhy3njR
         CvJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXexCHfy0PchNkk+eTcEHEz5U/w77RDWr17IvGhetDszDMVGzsSHvgrLsv03HgHFDQ29UQ=@vger.kernel.org, AJvYcCXj6JVJkSOs+rn3DAiaE20x7nDrZ2LmKXSKAMWhMICEZ7sd22vxzqjxvVyZKc6rePVzZOMgV1pG4tqQyXKj@vger.kernel.org, AJvYcCXvlT3pqo0vcsKKMiS+cLZi5hHNRoRVm+LJewkiXNOFGxD+bBTpqUVLJxXN443nNaHEK1qG1eCKGIxUTgjxa0dObuAb@vger.kernel.org
X-Gm-Message-State: AOJu0YxTrCZj7bNMk1C/E/IyZ15rx78V6o9RO+cNcFCUkTr1s/s/EbIQ
	/PKTJRuu2apGIA9W2cIT6YkTTCPtbBWS+lFGRqOxNJUTISK28v5O2goG
X-Gm-Gg: ASbGncvGCPFf68XvjJomXtVgvThYQLxFMzVQRhYcarUdpP/CV5K+wVHfGja7cbp0FQh
	mSKZhBfEhOSmbMUxD/dv5QVmbU9J+aPmqYzm8YuLfysRxI81xIEeaP5/PNMp/jvNXJqARhIqe2q
	gg+bRVeJSQidAeAnauYQDAx1iEUTekN/jCkJT9ibHG993hI13ZiVodmHYzsyvDUu6NP7+gT5DPn
	vtXJiLD8/xvVNhXrAhV/keWwqP3PpNzPIIaUyXs8XsFNN6LVC8U5kVc8yO3Z8D2KkAPbICwUHMg
	zNU3ZvE7rhMhTQMX4r45Ll3leSFJJNf18wnUmgkqd61lGosjAIoCbjgbEE2RQOPU07VMX5JKVS3
	crkpYrVNuiw==
X-Google-Smtp-Source: AGHT+IFkQkWQvVhJNgMdujACroPvPIsmIxRmct+3VhhXmCWLjk6DZ7dUAkDzwBcmk45SDDb+g7QFmA==
X-Received: by 2002:a17:906:d7cf:b0:ae3:53ac:2999 with SMTP id a640c23a62f3a-ae6fc21e1dbmr1505863766b.53.1752528561561;
        Mon, 14 Jul 2025 14:29:21 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82645e6sm884600566b.79.2025.07.14.14.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 14:29:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 14 Jul 2025 23:29:19 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv5 perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <aHV2r2PtLTSPVs6m@krava>
References: <20250711082931.3398027-1-jolsa@kernel.org>
 <20250711082931.3398027-11-jolsa@kernel.org>
 <20250714191304.a93c5398165bafc93827e716@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714191304.a93c5398165bafc93827e716@kernel.org>

On Mon, Jul 14, 2025 at 07:13:04PM +0900, Masami Hiramatsu wrote:

SNIP

> > diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
> > index 678fb546f0a7..1ee2e5115955 100644
> > --- a/arch/x86/include/asm/uprobes.h
> > +++ b/arch/x86/include/asm/uprobes.h
> > @@ -20,6 +20,11 @@ typedef u8 uprobe_opcode_t;
> >  #define UPROBE_SWBP_INSN		0xcc
> >  #define UPROBE_SWBP_INSN_SIZE		   1
> >  
> > +enum {
> > +	ARCH_UPROBE_FLAG_CAN_OPTIMIZE   = 0,
> > +	ARCH_UPROBE_FLAG_OPTIMIZE_FAIL  = 1,
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
> > index 5eecab712376..b80942768f77 100644
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
> > @@ -702,7 +703,6 @@ static struct uprobe_trampoline *create_uprobe_trampoline(unsigned long vaddr)
> >  	return tramp;
> >  }
> >  
> > -__maybe_unused
> >  static struct uprobe_trampoline *get_uprobe_trampoline(unsigned long vaddr, bool *new)
> >  {
> >  	struct uprobes_state *state = &current->mm->uprobes_state;
> > @@ -874,6 +874,285 @@ static int __init arch_uprobes_init(void)
> >  
> >  late_initcall(arch_uprobes_init);
> >  
> > +enum {
> > +	OPT_PART,
> > +	OPT_INSN,
> > +	UNOPT_INT3,
> > +	UNOPT_PART,
> > +};
> > +
> > +struct write_opcode_ctx {
> > +	unsigned long base;
> > +	int update;
> > +};
> > +
> > +static int is_call_insn(uprobe_opcode_t *insn)
> > +{
> > +	return *insn == CALL_INSN_OPCODE;
> > +}
> > +
> 
> nit: Maybe we need a comment how to verify it as below, or just say
>  "See swbp_optimize/unoptimize() for how it works"
> 
> /*
>  * verify the old opcode starts from swbp or call before update to new opcode.
>  * When optimizing from swbp -> call, write 4 byte oprand (OPT_PART), and write
>  * the first opcode (OPT_INSN). Also, in unoptimizing, write the first opcode
>  * (UNOPT_INT3) and write the rest bytes (OPT_PART).
>  * Thus, the *old* `opcode` byte (not @vaddr[0], but ctx->base[0]) must be
>  * INT3 (OPT_PART, OPT_INSN, and UNOPT_PART) or CALL(UNOPT_INT3).
>  */

will add the comment in here

> 
> > +static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode,
> > +		       int nbytes, void *data)
> > +{
> > +	struct write_opcode_ctx *ctx = data;
> > +	uprobe_opcode_t old_opcode[5];
> > +
> > +	uprobe_copy_from_page(page, ctx->base, (uprobe_opcode_t *) &old_opcode, 5);
> > +
> > +	switch (ctx->update) {
> > +	case OPT_PART:
> > +	case OPT_INSN:
> > +		if (is_swbp_insn(&old_opcode[0]))
> > +			return 1;
> > +		break;
> > +	case UNOPT_INT3:
> > +		if (is_call_insn(&old_opcode[0]))
> > +			return 1;
> > +		break;
> 
> > +	case UNOPT_PART:
> > +		if (is_swbp_insn(&old_opcode[0]))
> > +			return 1;
> > +		break;
> 
> nit: Can we fold this case to the OPT_PART & OPT_INSN case?
> It seems the same.

sure, thanks

jirka

