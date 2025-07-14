Return-Path: <bpf+bounces-63259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAF3B0497F
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 23:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877AE3B7F47
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 21:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EAB26A0B3;
	Mon, 14 Jul 2025 21:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muOtrp0s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C769367;
	Mon, 14 Jul 2025 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752528544; cv=none; b=RQaAkJPunNkSyONYT/bbwRevrN1OnVenhU7+9b5ic4UYkHLfz0C1r8RMMl53zcYcJj5L0XyexWfZWysJVT0MUNUTG7nYOGJMT25etQTajf/ecMmn4zaqR2VlcnMW8tx/90HRtlklJBmgmeBHGtSYUCu8nw8nb/NlU99eMR/4TcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752528544; c=relaxed/simple;
	bh=5/VVpBnB4/kJp5GDK94Ao73s2PJv/dboq1wthSvlIng=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1BN3RFAHIvd/pOVJ8ehzjHPnp9m/3nn2mYRiDQxD3ttqt6UwcT9EX222jHOQYgcJugpV8s/SEVJLZK8XUdosCubGW0uOYvBA7H4tLY8oBvdOdfW9Mlili1hVr4ibacZ47R5b8fkd3RuVfE/fMFvM2ePwrALnisnnqTbinLwWOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muOtrp0s; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae6fa02d8feso564124166b.0;
        Mon, 14 Jul 2025 14:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752528541; x=1753133341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x/nMaR86sHXJi8WQjG3Nl2Qfv6euA38lrd3J5A4nQBs=;
        b=muOtrp0stRFGs7aNs3cNx1DUP1wPC27Y0EhEfaRtP+Rjg4051GiIoGyKWeE07BEngm
         88EmRlQL9HX1mZFJzxXB90VB/30ORP38bjmLcz4HWV7lU6timeB1mqMUfs6nkscxGvN6
         UWlX5/1P8Zff/3T8z69s16OkAOzZ/Zkw5mxdiS+0Y3hEpp4I6Yz4zpg3QGp8PTLltc8z
         UbO/nqeMd9v8xzU2lv7rVj+UjSVaVgeeoGpmZBdOlaoDXHAiZR4Aq161mHD3430/30T9
         C5Gw3+REphgY2DUTKF6AWHLhAgfJxUnbGxmf2y5bHlDUS54Tu2zLhKVUfY4IBaiFeoXS
         utjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752528541; x=1753133341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/nMaR86sHXJi8WQjG3Nl2Qfv6euA38lrd3J5A4nQBs=;
        b=l7H1KeUPIpPEBAT5NpT91nop3GIrLhqhouqrndAv3spCWpLYxTAwp889UlFgL2VL5s
         yWkmh7S7w/myNRi8vaM9uZCFt+rIqAPHMO2Jv6V63Wp8GoETHGKnbPBinktnzIlFSF0T
         SYxBr2OrYjlKM2Oz5wEsSWXPaVp/gltVH+zGvI9R5rMHjK712l66ADfRATHcV0mV48AC
         d2DoNOdMC23bCYmx2ipNJOXBDdB6/7Gu5vKSfMscJGDMhTOAlsj/HnW0gEHbJLcXK+Lr
         c7B5lqrSN3qll5K96EsgPTKmSSTa1NarATHSh3Zg4/bje0WPcrhWqKkstNzNWqmngnNb
         TJLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqLL7WWG8/GA4n/caLBBT40uXiQai8mhoy2qUmCA98lUpBqKvKyHRk2b5IMuSFTrEN4p8=@vger.kernel.org, AJvYcCWhR1i6iACSa00sfWgIJbpCmMm9BdGArHXtZtXNwDcp0fgmqZGpJnQ8CUJmpCXUsBr7Ur3JdgY00uvSSBlY@vger.kernel.org, AJvYcCXumVa782azBkr6cX/nrw4BJ6FjkSOkGeeEECS2DKT3mZrZhykB6himj7uJpSM3/okjRZBPpDzd49wSVeex5JG5tvvf@vger.kernel.org
X-Gm-Message-State: AOJu0YwpMGZcIAmt5ylY+7a0h59WGv1UHEk9wCZkw6za+DWQDfiCa5F0
	tTbbuDbWstCvluhw9b66vOklDBPsSm7nYGTGtJ3Onf1OjiTjfA6d0fKP
X-Gm-Gg: ASbGncv8zg4lxX/PytWCxGeQKqhYx8bOHn3GUS3h4UwMH446dOto9ypZEDI8+pAbrcm
	EuqNj0nB2N+HAVqNBtrhF28QMwufrEkkaW/GXTulQnNLuJG2sDt4+jWk23DgTMrW2O7HnZkfE5p
	rYgUKZ2OCPFjiociccTNxe5yp/V8lerv+3WVt87E6R0p/65mGD7559p+M2/dmUSttqC7rsdkosT
	qRr84ZSvW0oznwFBG0EiEGnKMQuGVMP8BtBPQjGzttECowHhchuflqYDd8itTOzHZq5SOnJsLoT
	4qUTF7sLCOcVwbWyv2L/YHOaScbUKIA6UhpPS44o5fFwI2odRuynfuX2Rqvbu2BlgPu0xbzTsV6
	oaeTgNaBb8w==
X-Google-Smtp-Source: AGHT+IFsHt0u9AlNKYQirK+RNPlrfKY/v2S66xmbPpPaI2Lc0YuOZvUCNBTfFVP0qs1dMHiFd00Ccg==
X-Received: by 2002:a17:907:962a:b0:ae0:3f20:68f8 with SMTP id a640c23a62f3a-ae6fcbc2c32mr1546602866b.39.1752528540534;
        Mon, 14 Jul 2025 14:29:00 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82df54csm875925966b.155.2025.07.14.14.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 14:29:00 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 14 Jul 2025 23:28:58 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
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
Subject: Re: [PATCHv5 perf/core 09/22] uprobes/x86: Add uprobe syscall to
 speed up uprobe
Message-ID: <aHV2mrao8EMOTz8S@krava>
References: <20250711082931.3398027-1-jolsa@kernel.org>
 <20250711082931.3398027-10-jolsa@kernel.org>
 <20250714173915.b9edd474742de46bcbe9c617@kernel.org>
 <20250714093903.GP905792@noisy.programming.kicks-ass.net>
 <20250714191935.577ec7df5ae8a73282cddce7@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714191935.577ec7df5ae8a73282cddce7@kernel.org>

On Mon, Jul 14, 2025 at 07:19:35PM +0900, Masami Hiramatsu wrote:
> On Mon, 14 Jul 2025 11:39:03 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, Jul 14, 2025 at 05:39:15PM +0900, Masami Hiramatsu wrote:
> > 
> > > > +	/*
> > > > +	 * Some of the uprobe consumers has changed sp, we can do nothing,
> > > > +	 * just return via iret.
> > > > +	 */
> > > 
> > > Do we allow consumers to change the `sp`? It seems dangerous
> > > because consumer needs to know whether it is called from
> > > breakpoint or syscall. Note that it has to set up ax, r11
> > > and cx on the stack correctly only if it is called from syscall,
> > > that is not compatible with breakpoint mode.
> > > 
> > > > +	if (regs->sp != sp)
> > > > +		return regs->ax;
> > > 
> > > Shouldn't we recover regs->ip? Or in this case does consumer has
> > > to change ip (== return address from trampline) too?
> > > 
> > > IMHO, it should not allow to change the `sp` and `ip` directly
> > > in syscall mode. In case of kprobes, kprobe jump optimization
> > > must be disabled explicitly (e.g. setting dummy post_handler)
> > > if the handler changes `ip`.
> > > 
> > > Or, even if allowing to modify `sp` and `ip`, it should be helped
> > > by this function, e.g. stack up the dummy regs->ax/r11/cx on the
> > > new stack at the new `regs->sp`. This will allow modifying those
> > > registries transparently as same as breakpoint mode.
> > > In this case, I think we just need to remove above 2 lines.
> > 
> > There are two syscall return paths; the 'normal' is sysret and for that
> > you need to undo all things just right.
> > 
> > The other is IRET. At which point we can have whatever state we want,
> > including modified SP.
> > 
> > See arch/x86/entry/syscall_64.c:do_syscall_64() and
> > arch/x86/entry/entry_64.S:entry_SYSCALL_64
> > 
> > The IRET path should return pt_regs as is from an interrupt/exception
> > very much like INT3.
> 
> OK, so SYSRET case, we need to follow;
> 
> sys_uprobe -> do_syscall_64 -> entry_SYSCALL_64 -> trampoline -> retaddr
> 
> But using IRET to return, we can skip returning to trampoline,
> 
> sys_uprobe -> do_syscall_64 -> entry_SYSCALL_64 -> regs->ip

the handler gets the original breakpoint address, it's set in:

        regs->ip  = ax_r11_cx_ip[3] - 5;

and at the point we do:

        /*
         * Some of the uprobe consumers has changed sp, we can do nothing,
         * just return via iret.
         */
        if (regs->sp != sp)
                return regs->ax;


.. regs->ip value wasn't restored for the trampoline's return address,
so iret will skip the trampoline

but perhaps we could do the extra check below to land on the next instruction?

jirka


---
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 043d826295a3..4318517aa852 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -817,8 +817,12 @@ SYSCALL_DEFINE0(uprobe)
 	 * Some of the uprobe consumers has changed sp, we can do nothing,
 	 * just return via iret.
 	 */
-	if (regs->sp != sp)
+	if (regs->sp != sp) {
+		/* skip the trampoline call */
+		if (ax_r11_cx_ip[3] - 5 == regs->ip)
+			regs->ip += 5;
 		return regs->ax;
+	}
 
 	regs->sp -= sizeof(ax_r11_cx_ip);
 

