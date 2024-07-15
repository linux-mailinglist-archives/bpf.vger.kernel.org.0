Return-Path: <bpf+bounces-34797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5145930EE1
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 09:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE321C211EB
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 07:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D80613AA32;
	Mon, 15 Jul 2024 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRmdB0Lp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF36B64E;
	Mon, 15 Jul 2024 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721028907; cv=none; b=jP4PNzi4OGSnYDxLFqcqN/3ZfTFsRtRZxDxihzBERgw7EtQJkhLmRowIceKE4pGZpR5zmR/L/ZCZu1gZOlonUKDf68Va2oVCAmwBy+vuEceJcfJ2kNNTFWmF/cKmWXxtT7PTJ1L0YEaCv57u5TkCV+OuxbSIXdtazbgc5NhZFEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721028907; c=relaxed/simple;
	bh=3WWL/jBQa0NLTVwdJTJpRNQUJfoVD8NFt+CYd5SjHNs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7wRLq3PaQMuvx/2PXUsRUTl2NyhGLw3cg/fM1Wqdn5NP/xpFFkt1isVZLG7dXpS6xGyEEcdRKX7+GdsjaRqnqnXLNwZujTvx1Gbey76I68Iq7vwEsYTseAQKN+DCoun7+aL2WWb+kcauEZVhbZwMklggYr37joYniqqea+SHT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRmdB0Lp; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a77e85cb9b4so450534466b.0;
        Mon, 15 Jul 2024 00:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721028904; x=1721633704; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BcOgtWAypcf1P+ThgUe+PPTLQr2PLitubGeopMxoiNw=;
        b=QRmdB0LpWSxpFrtD6u3x/0Pmxzf3oIYJEdVCfscgw3yZxIwLvxHZBEHJtgETD++oLb
         uKRfOdES3LjmOSBg+fSgv5iycg4A6gfCw250/xdqgxozFj284aZM3HaleAjas5ISuj/B
         VE2RRNNUqzUifLIkfYCenGgA48V1ODevIMNBzRsQeFybLF/fukEHqckfbzOqOsd/xvBq
         tJO4LU7KYEvz9h7prGQ0CX85FaUDKJFfwYjVZtClTh1o1/2r2I/yiS0g3y3ky8kF+Rs9
         dLgW7ryeA2MguEcYkB7DffBnl1d1XfYCH+rKcOonWWuoFiZigDgR09Z9aRQ6xe/wEirE
         XBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721028904; x=1721633704;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BcOgtWAypcf1P+ThgUe+PPTLQr2PLitubGeopMxoiNw=;
        b=JaMzFlECL8VV2ZgnfDMmNJ6BY8LpF88E/wiVF48mYEoUqItVGPEef2rjk0lDVmnuvX
         0ALxNNy8BJhACbuo9Ui9hQBySUPWFpAWAkl/P/o6TBpNaHQOyXN9HslHOVl7bEZIqQPQ
         4oJlgU8RlelZkK3J7dnht57Evf6EdVt8/sm+JYUyJAGaS/KIUY4tbRFDgbpyY8n4b81f
         rno874iuFQDMaHihIHDglLeQ71D+uCrg2AnLVNFy+8ePbbL2Qxn0rfszmV8ENoKIJZxf
         ZikT7UplKurqRfofhVpA89gaTEK6fBjM4X4ltJ7K2ueURk8DR0qlLJSqfmrHfPnwceLQ
         vu6A==
X-Forwarded-Encrypted: i=1; AJvYcCVEnksMe66S4JSP+ntgnAhQSJ879+QcaqElPyVeHNuumTnYJ/nzEYWCGO6yZhl74jiDdvnxG9m3TL/DNQkm7CFbQiQQ/Yj3LWwVfXZYLz5/pQ6K4lkReIbkRG00WRdbBwcISqywnH8gzBcZlntfQxPW2jPZlnpEcHzXWFXEAJsuWCu6FV1FTS1KrJAxYRVc6kX7ZLuO8WP5W3Bg32yzjX/8
X-Gm-Message-State: AOJu0Yznmiy6LlVKv5aSa+TIutT1zxpqIrGLF+hKSWx2NIf58xFEyMwZ
	U25frPjyg48/MoQBRvIgDDX1YN2CRxZOzo9gdv+op88bcBzLY+3z
X-Google-Smtp-Source: AGHT+IEKVP1zAahjz9aKLXWmRMsyrpaqAkpZLrsO+kL6HBBMg6LMXmL28y8wrOQyOfMmBNzrpCxAQQ==
X-Received: by 2002:a17:907:d93:b0:a77:b3c4:cd28 with SMTP id a640c23a62f3a-a780b68a287mr1551287666b.9.1721028904192;
        Mon, 15 Jul 2024 00:35:04 -0700 (PDT)
Received: from krava ([2a00:102a:5016:2f5f:f580:e408:137f:9c83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc822bfasm187916866b.222.2024.07.15.00.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 00:35:03 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 15 Jul 2024 09:34:57 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/2] selftests/bpf: Change uretprobe syscall number in
 uprobe_syscall test
Message-ID: <ZpTRIa2_sk4hKAQU@krava>
References: <20240712135228.1619332-1-jolsa@kernel.org>
 <20240712135228.1619332-3-jolsa@kernel.org>
 <CAEf4BzY3Xo-g02r9TY9tHq49JLrrYoUNoXN=WXhJ02q4xUbGbA@mail.gmail.com>
 <20240715144651.98ef93f04a96a7aa9109d55e@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240715144651.98ef93f04a96a7aa9109d55e@kernel.org>

On Mon, Jul 15, 2024 at 02:46:51PM +0900, Masami Hiramatsu wrote:
> On Fri, 12 Jul 2024 11:27:30 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> 
> > On Fri, Jul 12, 2024 at 6:53 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Fixing the syscall number value.
> > >
> > > Fixes: 9e7f74e64ae5 ("selftests/bpf: Add uretprobe syscall call from user space test")
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > 
> > is this selftest in probes/for-next already? If yes, I'd combine these
> > two patches to avoid any bisection problems

yes it's all there.. I don't mind squashing it, I just did not want
to combine kernel and user space parts.. up to Masami I guess

> > 
> > but either way
> > 
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> Thanks, let me pick it to for-next branch.

thanks,
jirka

> 
> Thank you,
> 
> > 
> > 
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > > index c8517c8f5313..bd8c75b620c2 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > > @@ -216,7 +216,7 @@ static void test_uretprobe_regs_change(void)
> > >  }
> > >
> > >  #ifndef __NR_uretprobe
> > > -#define __NR_uretprobe 463
> > > +#define __NR_uretprobe 467
> > >  #endif
> > >
> > >  __naked unsigned long uretprobe_syscall_call_1(void)
> > > --
> > > 2.45.2
> > >
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

