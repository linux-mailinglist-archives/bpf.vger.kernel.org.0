Return-Path: <bpf+bounces-29758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A788C65D7
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 13:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833651F21444
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 11:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786106E617;
	Wed, 15 May 2024 11:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcGwL60O"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F61219E8
	for <bpf@vger.kernel.org>; Wed, 15 May 2024 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715773024; cv=none; b=bsUa6e+OOXjS5QN16IFhWB/+9s8HiXamKqNaltZTOOAIeTniAjO1jRqnQU26SmqbZxBHp80E3hFUP4SU2mkCKY314owL0L0EFYo8S3LPplT6nczF62JCQ2Uw7HpNq2G9Y60QVEuOqOTy5vPktEt3TBehdYNtGaF8EY467je4eWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715773024; c=relaxed/simple;
	bh=5b0coiq2Qij7YycX921gmUQ28b31nkq/g83M03VOqAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLKBuZuU0CGGxwb159BbsTHA1bCLdgXTxX/nOvnuqSV4aY1PGLzgZHYO3i5EAfYpSzQR7gwf+06LjYW/z7aQa8b7kyTZ+ISfrjPLy3r+fELmTZYVbYoQH3ljMU3dLOqI3rxlhsJiV5bU8TTKRExRxYtDbBKdDKefh2iDiIcSRIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VcGwL60O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715773021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o+uVyj8qUsbsfq+6bn2kM6u9Mh7k22x+zAgMrxxsnbY=;
	b=VcGwL60OPfPpaFhEFrbqWYQyvtiVAB77sKr0ql2bRN3JdRtUuQeCzHcD+rNmptjo8c2OJK
	oFiQ7Q2bmzGTgYsT4lj9Tq1lverLK3/yg1wvn2gh2acwsbCKrlV1d4RO+mRrTZDVg6Wj21
	ZNyZOiMW5cApX9C3Ff/LYR+JZDyXUPs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-4OmFr6i4P9O6WgqBKHOTwQ-1; Wed,
 15 May 2024 07:36:58 -0400
X-MC-Unique: 4OmFr6i4P9O6WgqBKHOTwQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FA151C0512F;
	Wed, 15 May 2024 11:36:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.39])
	by smtp.corp.redhat.com (Postfix) with SMTP id 89945200A08E;
	Wed, 15 May 2024 11:36:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 15 May 2024 13:35:31 +0200 (CEST)
Date: Wed, 15 May 2024 13:35:25 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"songliubraving@fb.com" <songliubraving@fb.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"yhs@fb.com" <yhs@fb.com>,
	"linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv5 bpf-next 6/8] x86/shstk: Add return uprobe support
Message-ID: <20240515113525.GB6821@redhat.com>
References: <20240507105321.71524-1-jolsa@kernel.org>
 <20240507105321.71524-7-jolsa@kernel.org>
 <a08a955c74682e9dc6eb6d49b91c6968c9b62f75.camel@intel.com>
 <ZjyJsl_u_FmYHrki@krava>
 <a8b7be15e6dbb1e8f2acaee7dae21fec7775194c.camel@intel.com>
 <Zj_enIB_J6pGJ6Nu@krava>
 <20240513185040.416d62bc4a71e79367c1cd9c@kernel.org>
 <c56ae75e9cf0878ac46185a14a18f6ff7e8f891a.camel@intel.com>
 <ZkKE3qT1X_Jirb92@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkKE3qT1X_Jirb92@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Let me repeat I know nothing about shadow stacks, only tried to
read Documentation/arch/x86/shstk.rst few minutes ago ;)

On 05/13, Jiri Olsa wrote:
>
> 1) current uretprobe which are not working at the moment and we change
>    the top value of shadow stack with shstk_push_frame
> 2) optimized uretprobe which needs to push new frame on shadow stack
>    with shstk_update_last_frame
>
> I think we should do 1) and have current uretprobe working with shadow
> stack, which is broken at the moment

Agreed,

> I'm ok with not using optimized uretprobe when shadow stack is detected
> as enabled and we go with current uretprobe in that case

But how can we detect it? Again, suppose userspace does

	enable_shstk()
	{
		prctl(ARCH_SHSTK_SHSTK);
	}

what if enable_shstk() is ret-probed ?

Oleg.


