Return-Path: <bpf+bounces-29773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF57A8C69A7
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 17:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3D11C21143
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 15:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4616B15625D;
	Wed, 15 May 2024 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKzKGh93"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3098F156236
	for <bpf@vger.kernel.org>; Wed, 15 May 2024 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786883; cv=none; b=Dp2Ym2CD9xreQL2mDgALkfHu3IGxqkO5d296FYNRfTosfko3piAZiqGVrQ11wZoaCAjgTN05OqK86rOWv1Wz1dba8aXSMJqq+ZOgCARTog2Tniylpy+Rr7uG5iBCZWX0x9RxRLKmejOtDi9SBUY+dmCwyp4qAWdlBgyezvzn4gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786883; c=relaxed/simple;
	bh=C8kKQKOtylTtvVHkjEFur6xMaFsKzbM5ZDTUlRRicm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtOo/OmHiQZ0p/I9zoUqELDFTLgWP31DBflrTeIlciNWn4OkpE4MqsNq17sAZ78aMKyYojldyan71L9rBeNixtQze6tsyJ7Qdh1O/Olcbe28LReOsVib2lgXZjCcYURzCmOIvzOyPMQ1w/zG/4wG64jBhnugcjkbs9axjvqz0Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LKzKGh93; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715786880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uInC5hWDwqGcx7P6rLG2USi6e9+2nLZVOslbhOtiZQ8=;
	b=LKzKGh93tvBFeZ+m9DLl6inrNboW+4rP3q2fDHZP9Ymxc1YmqyO0qDncW7Ki7ZYhjrzBGR
	m4sqDUgoqYHbXoI9rSDRQdItoHYFLgu2VP83havmMx40bTp+HLUL7lSmjCY+NM6kZrrUiu
	JsII/6VjL6dIhBIg2oXq5E6BQK6PB2k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-OKrgi6wzN1OJxJUn5UMrTA-1; Wed,
 15 May 2024 11:27:42 -0400
X-MC-Unique: OKrgi6wzN1OJxJUn5UMrTA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4ABD71C0513F;
	Wed, 15 May 2024 15:27:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.39])
	by smtp.corp.redhat.com (Postfix) with SMTP id 7395F3C27;
	Wed, 15 May 2024 15:27:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 15 May 2024 17:26:15 +0200 (CEST)
Date: Wed, 15 May 2024 17:26:09 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Deepak Gupta <debug@rivosinc.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"songliubraving@fb.com" <songliubraving@fb.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
	"yhs@fb.com" <yhs@fb.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv5 bpf-next 6/8] x86/shstk: Add return uprobe support
Message-ID: <20240515152609.GD6821@redhat.com>
References: <ZjyJsl_u_FmYHrki@krava>
 <a8b7be15e6dbb1e8f2acaee7dae21fec7775194c.camel@intel.com>
 <Zj_enIB_J6pGJ6Nu@krava>
 <20240513185040.416d62bc4a71e79367c1cd9c@kernel.org>
 <c56ae75e9cf0878ac46185a14a18f6ff7e8f891a.camel@intel.com>
 <ZkKE3qT1X_Jirb92@krava>
 <3e15152888d543d2ee4e5a1d75298c80aa946659.camel@intel.com>
 <ZkQTgQ3aKU4MAjPu@debug.ba.rivosinc.com>
 <20240515111919.GA6821@redhat.com>
 <ZkTIU1QUAJF0f0KK@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkTIU1QUAJF0f0KK@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 05/15, Jiri Olsa wrote:
>
> On Wed, May 15, 2024 at 01:19:20PM +0200, Oleg Nesterov wrote:
> > Let me ask a couple of really stupid questions. What if the shadow stack
> > is "shorter" than the normal stack? I mean,
> >
> > 	enable_shstk()
> > 	{
> > 		prctl(ARCH_SHSTK_SHSTK);

I meant ARCH_SHSTK_ENABLE, of course

> > 	}
> >
> > what happens when enable_shstk() returns?
>
> I think it will crash, there's explanation in the comment in
> tools/testing/selftests/x86/test_shadow_stack.c test

OK, thanks...

But test_shadow_stack.c doesn't do ARCH_PRCTL(ARCH_SHSTK_DISABLE) if
all the tests succeed ? Confused but nevermind.

> > And what is the purpose of fpregs_lock_and_load() ? Why do we need to
> > fpregs_restore_userregs() in shstk_setup() and other places?
> >
> > Oleg.
> >
>


