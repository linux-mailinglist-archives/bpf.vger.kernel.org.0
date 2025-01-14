Return-Path: <bpf+bounces-48760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03880A10534
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 12:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291941887666
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 11:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0319F284A48;
	Tue, 14 Jan 2025 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWM2hZGC"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1232F1ADC9B
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736853712; cv=none; b=b7LYHmGHCeATjnbLSCBmZ4TsppQn2Ex4mUqwcMk+FQm9WTDLqkybdNsDW+QPNCNif1Pq5zrOSmGd+TRbpasO7CFdVpnQ5pmEp7+40NKuhciALK2uvIS8dml4Uyc9eJ4Xev1v0YewltEp4HTe3wS6gnXT/9Rwev6m0vAiKnVPiyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736853712; c=relaxed/simple;
	bh=5JFAfkPR+Ike3FMmbmMZs5Ka5jUJg7zx9lp5Nr+ajQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTlUt5jsZq6U5+p1Gy9Bhy0Es4ShoOfwDqP1cWXh85tdROpRaFcGPNGU6dQWtk6GhuLj4UJ/TIZIF3KJvEFSCHOX7frTYLREwnSbYSrJ/yZbcpDZHLszq22kTnXeT9krWDRl22Q1ACbhUdz2gJGZTg2RGlaXbaPnOfaNQdzV3RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CWM2hZGC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736853709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gKIV4YzdGrCw0FjbYvth1lwU1z2n2sZ8xFygOnMWM/Q=;
	b=CWM2hZGCtB7xUhqOhM9gmsjmzMZtPqTwAJepp0yC5DePH2SmGH6JnDYUetSz3xyOf6uYvQ
	9HpS+fsZCbaLF3Zj6+JTAcbgCoTzrTo403XPf/mTTpM3wzF+GWzyEmIhygW7xeIcr4dIKs
	5ZCR7QuIO7862/6SitCa2rGj7hrKozE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-MOulm-YXPBixk34LJI9Atw-1; Tue,
 14 Jan 2025 06:21:44 -0500
X-MC-Unique: MOulm-YXPBixk34LJI9Atw-1
X-Mimecast-MFC-AGG-ID: MOulm-YXPBixk34LJI9Atw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3656D195605E;
	Tue, 14 Jan 2025 11:21:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.88])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C67BB3003FD1;
	Tue, 14 Jan 2025 11:21:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 14 Jan 2025 12:21:16 +0100 (CET)
Date: Tue, 14 Jan 2025 12:21:07 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
	Eyal Birger <eyal.birger@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	BPF-dev-list <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>, peterz@infradead.org,
	tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
	linux-api@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-ID: <20250114112106.GC19816@redhat.com>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava>
 <Z4YszJfOvFEAaKjF@krava>
 <20250114190521.0b69a1af64cac41106101154@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114190521.0b69a1af64cac41106101154@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 01/14, Masami Hiramatsu wrote:
>
> On Tue, 14 Jan 2025 10:22:20 +0100
> Jiri Olsa <olsajiri@gmail.com> wrote:
>
> > @@ -418,6 +439,9 @@ SYSCALL_DEFINE0(uretprobe)
> >  	regs->r11 = regs->flags;
> >  	regs->cx  = regs->ip;
> >
> > +	/* zero rbx to signal trampoline that uretprobe syscall was executed */
> > +	regs->bx  = 0;
>
> Can we just return -ENOSYS as like as other syscall instead of
> using rbx as a side channel?
> We can carefully check the return address is not -ERRNO when set up
> and reserve the -ENOSYS for this use case.

Not sure I understand...

But please not that the uretprobed function can return any value
including -ENOSYS, and this is what sys_uretprobe() has to return.

Oleg.


