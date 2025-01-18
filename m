Return-Path: <bpf+bounces-49257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4355A15D8E
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 16:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A303A83D9
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 15:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A709619AD8C;
	Sat, 18 Jan 2025 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGPuQF8T"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C53172BB9
	for <bpf@vger.kernel.org>; Sat, 18 Jan 2025 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737212750; cv=none; b=ltZgKGhyVMpz9x2Nc3iyfQtjkoajuE6C7NBSaDyJKbKrD4g+OT1eQEh603rCS5vyJmAi1utTdJRqvmrTL2aNNptTTG6XiJSj8ZDHfaHsjNsBAm7gnJNznMzIaikJ9HI9yzhDsZcVTJDryOvFZlIqVm976brUxU6c/cqkQ6Y/nNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737212750; c=relaxed/simple;
	bh=FB5tEY/SIGgEcj+wCphizTJs+zgzCCFaTisQu4Io4D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHIn68C0Txi6awgNpxTMHfuPcHMTEoDajk+atmOEUV2Z4bOvz1NhLwdBtGyIvbdv4wh7HNIXi45NAtKp81Rpm4tNPoObl4EO0BjOcIic31SuNN9nf2d3ca0O09hkCO7WbylJ28wu/LJkukzUckZQl6EvDYAZtqxKWCnYGO3svLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TGPuQF8T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737212747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FB5tEY/SIGgEcj+wCphizTJs+zgzCCFaTisQu4Io4D8=;
	b=TGPuQF8TewVK0imZ1cb7e9dHfsU3glLtK0o3lUXZzKfyoN+uDoupJSoo23iyLveSM7yHVv
	ZcqCMHKezttEwIi+GpSeJyWfCWw1871Y0K0UXkdyHWUtz+g+syQhZKrJtYBH6w5ETclaAc
	NictkQvrsmRyCBCK+62sIrGIx44m/oc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-kWG6VUqGNcauERNYzyMBkQ-1; Sat,
 18 Jan 2025 10:05:42 -0500
X-MC-Unique: kWG6VUqGNcauERNYzyMBkQ-1
X-Mimecast-MFC-AGG-ID: kWG6VUqGNcauERNYzyMBkQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EAA119560B1;
	Sat, 18 Jan 2025 15:05:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.39])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AFEAD195608A;
	Sat, 18 Jan 2025 15:05:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 18 Jan 2025 16:05:12 +0100 (CET)
Date: Sat, 18 Jan 2025 16:05:01 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>, kees@kernel.org,
	luto@amacapital.net, wad@chromium.org, andrii@kernel.org,
	jolsa@kernel.org, alexei.starovoitov@gmail.com, olsajiri@gmail.com,
	cyphar@cyphar.com, songliubraving@fb.com, yhs@fb.com,
	john.fastabend@gmail.com, peterz@infradead.org, tglx@linutronix.de,
	bp@alien8.de, daniel@iogearbox.net, ast@kernel.org,
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org, linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"Dmitry V. Levin" <ldv@strace.io>
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <20250118150500.GB21464@redhat.com>
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <20250117013927.GB2610@redhat.com>
 <20250117170229.f1e1a9f03a8547d31cd875db@kernel.org>
 <20250117140924.GA21203@redhat.com>
 <CAEf4BzYhcG8waFMFoQS5dFWVkQGP6ed_0mwGTK4quN5+6-8XuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYhcG8waFMFoQS5dFWVkQGP6ed_0mwGTK4quN5+6-8XuA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 01/17, Andrii Nakryiko wrote:
>
> On Fri, Jan 17, 2025 at 6:10 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > We can, and this is what I tried to suggest from the very beginning.
> > But I agree with Eyal who decided to send the most trivial fix for
> > -stable, we can add the helper later.
> >
> > I don't think it should live in uprobes.h and I'd prefer something
> > like arch_seccomp_ignored(int) but I won't insist.
>
> yep, I think this is the way, keeping it as a general category. Should
> we also put rt_sigreturn there explicitly as well? Also, wouldn't it
> be better to have it as a non-arch-specific function for something
> like rt_sigreturn where defining it per each arch is cumbersome, and
> have the default implementation also call into an arch-specific
> function?

I personally don't think we should exclude rt_sigreturn. and I guess
we can't do it in a arch-agnostic way, think of __NR_ia32_sigreturn.

However. These are all good questions that need a separate discussion.
Plus the SECCOMP_RET_TRACE/strace issue raised by Dmitry. And probably
even more.

But IMO it would be better to push the trivial (and urgent) fix to
-stable first, then discuss the possible cleanups/improvements.

What do you think?

Oleg.


