Return-Path: <bpf+bounces-56803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78959A9E3D2
	for <lists+bpf@lfdr.de>; Sun, 27 Apr 2025 17:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A70189B4E9
	for <lists+bpf@lfdr.de>; Sun, 27 Apr 2025 15:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ABA1DE3A7;
	Sun, 27 Apr 2025 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bym87Twl"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE6A1D5ACE
	for <bpf@vger.kernel.org>; Sun, 27 Apr 2025 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745769117; cv=none; b=C8vS+C6mBkPh2oqATvcJn58xn77ZqNMHzTRO8icV58VbCuwmdz9qWNuiRwMjT0XQB1PHkWxb3ZKL561XRHsyk4GxEJViROGPz6QRPm1vhofTUcIR0WERL6KihRvmQly7DxVyHbGKxAaD5AlqJyVq1iiSKzkQ1EE1Xcwjl/72k60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745769117; c=relaxed/simple;
	bh=fB1w5EdlophF9FygpQ1v2gxIq4Vfe+fEHjSkE38dAW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PczC0qG9MPEpQAk/QY5wIz/eBuDrY0peQSBXSQcy8XPUl4Mf9m3wUhwiFrcnNiknXIhStAu20AdHrp50PICWz5Go4Z1J1TgQR6rhC66OgSRq0CYkGNLahTBlXu4cQXrOaUIRZ0ETpEfGvanxBPVw0VgfsfND+b5YNgDQjj8kCqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bym87Twl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745769114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEsO7LxrjwCVQiphxbxj8Q1M9BC5vnt9cQxUJ75ymR0=;
	b=Bym87TwlLG/UcM1NXuO5gHweQFVKbPGeRyj1R4UOeXekUxF7VmCPtCCbE+erRkDJdAkDtc
	PSrL4dv3rTm4yyZvHmwD5RUNsIufC+nY6U03mtMtRyLd3mgkuYv6W0QP5YW2XmzdeL6nBf
	kYBVzosZW2G2WQTmkBi3BCE32sFTCuY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-JrxdJ07tOBin5wljtoGs2Q-1; Sun,
 27 Apr 2025 11:51:50 -0400
X-MC-Unique: JrxdJ07tOBin5wljtoGs2Q-1
X-Mimecast-MFC-AGG-ID: JrxdJ07tOBin5wljtoGs2Q_1745769108
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 625D21956088;
	Sun, 27 Apr 2025 15:51:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.18])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DA0BC19560A3;
	Sun, 27 Apr 2025 15:51:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 27 Apr 2025 17:51:09 +0200 (CEST)
Date: Sun, 27 Apr 2025 17:51:00 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 09/22] uprobes/x86: Add uprobe syscall to speed
 up uprobe
Message-ID: <20250427155059.GD9350@redhat.com>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-10-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421214423.393661-10-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 04/21, Jiri Olsa wrote:
>
> We do not allow to execute uprobe syscall if the caller is not
> from uprobe trampoline mapping.

...

> +SYSCALL_DEFINE0(uprobe)
> +{
> +	struct pt_regs *regs = task_pt_regs(current);
> +	unsigned long ip, sp, ax_r11_cx_ip[4];
> +	int err;
> +
> +	/* Allow execution only from uprobe trampolines. */
> +	if (!in_uprobe_trampoline(regs->ip))
> +		goto sigill;

I honestly don't understand why do we need this check. Same for the similar
trampoline_check_ip() check in sys_uretprobe(). Nevermind, I won't argue.

Oleg.


