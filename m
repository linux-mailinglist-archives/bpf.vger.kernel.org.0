Return-Path: <bpf+bounces-55527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56082A8259D
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 15:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3D21B632E1
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 13:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964B5262814;
	Wed,  9 Apr 2025 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3cnPE28"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6DC26156D
	for <bpf@vger.kernel.org>; Wed,  9 Apr 2025 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744204327; cv=none; b=Kd6d+y7KLNgLEMUzqATA3Jvp3B74LiNm04jPq3kW4NnAnHOC4awVKUk0JVSMte3IJg3G614w8loY7hySmeMBf3OW0wToF789jfiAz2c0s6v/BXIkfPZefYSc3pCwspslASSbre/4smsZE+d8sRD99XCj8zsFT/hx4W7jbCr676Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744204327; c=relaxed/simple;
	bh=DznCfzIaOLdxkX+FrlW8LSVnUQrLhKiolS6TwaE2KgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2di7IpoUqxrigh3gGJWAzY6kiv9NkzPFpNcccBAffgy+WOv29DyddOVSlIaEiJkq8BkxhDMWlCHEqdgEQsWAyHbZe95C6lAUJOaK8X5mNLSwMuuvaREFtSidLUULcVtvuHXAIJdTAa9nfGTGHFrOgspPh3SsnvLtKrtubSEKTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3cnPE28; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744204324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KXiUeYyq4+iJaCplSLvKXi9bRn4ApyyG03ayLtmLjGY=;
	b=T3cnPE28dJwOXyB5kBTap804/fsK863uV9643hb7sbFlhLR493Jp3VdNV9CsOLSior1sXD
	nyM95nelF2T3EFVga/+XCsmawfmz0gAeZhgKxUj9RuyGo9E2WtClQh62yPS1u48SoPdsRO
	C8f2oOUGkFZeRWglNnEiLKaftC3EVm4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-uPbBto-fMVux_7CJk3KPCQ-1; Wed,
 09 Apr 2025 09:12:00 -0400
X-MC-Unique: uPbBto-fMVux_7CJk3KPCQ-1
X-Mimecast-MFC-AGG-ID: uPbBto-fMVux_7CJk3KPCQ_1744204318
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9EDA61801A07;
	Wed,  9 Apr 2025 13:11:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8E27C19560AD;
	Wed,  9 Apr 2025 13:11:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  9 Apr 2025 15:11:23 +0200 (CEST)
Date: Wed, 9 Apr 2025 15:11:16 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
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
Message-ID: <20250409131115.GD32748@redhat.com>
References: <20250408211310.51491-1-jolsa@kernel.org>
 <20250409112839.GA32748@redhat.com>
 <Z_ZjIerx-QvY7BSI@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_ZjIerx-QvY7BSI@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 04/09, Jiri Olsa wrote:
>
> On Wed, Apr 09, 2025 at 01:28:39PM +0200, Oleg Nesterov wrote:
> > On 04/08, Jiri Olsa wrote:
> > >
> > > --- a/arch/x86/kernel/uprobes.c
> > > +++ b/arch/x86/kernel/uprobes.c
> > > @@ -608,6 +608,16 @@ static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
> > >  		*sr = utask->autask.saved_scratch_register;
> > >  	}
> > >  }
> > > +
> > > +static int is_nop5_insn(uprobe_opcode_t *insn)
> > > +{
> > > +	return !memcmp(insn, x86_nops[5], 5);
> > > +}
> > > +
> > > +static bool emulate_nop5_insn(struct arch_uprobe *auprobe)
> > > +{
> > > +	return is_nop5_insn((uprobe_opcode_t *) &auprobe->insn);
> > > +}
> >
> > Why do we need 2 functions? Can't branch_setup_xol_ops() just use
> > is_nop5_insn(insn->kaddr) ?
>
> I need is_nop5_insn in other changes I have in queue, so did not want
> to introduce extra changes

But I didn't suggest to remove is_nop5_insn(), I meant that
branch_setup_xol_ops() can do

	if (is_nop5_insn(insn->kaddr))
		goto setup;
or
	if (is_nop5_insn(auprobe->insn))
		goto setup;

this even looks more readable to me. but I won't insist.

> > For the moment, lets forget about compat tasks on a 64-bit kernel, can't
> > we simply do something like below?
>
> I sent similar change (CONFIG_X86_64 only) in this thread:
>   https://lore.kernel.org/bpf/Z_O0Z1ON1YlRqyny@krava/T/#m59c430fb5a30cb9faeb9587fd672ea0adbf3ef4f
>
> uprobe won't attach on nop9/10/11 atm,

Ah, OK, I didn't know. But this means that nop9/10/11 will be rejected
by uprobe_init_insn() -> is_prefix_bad() before branch_setup_xol_ops() is
called, right? So I guess it is safe to use ASM_NOP_MAX. Nevermind.

> also I don't have practical justification
> for doing that.. nop5 seems to have future, because of the optimization

OK, I won't insist, up to you.

Just it looks a bit strange to me. Even if we do not have a use-case
for other nops, why we can't emulate them all just for consistency?

And given that emulate_nop5_insn() compares the whole insn with
x86_nops[5], I guess we don't even need to check OPCODE1(insn)...
Nevermind.

So, once again, I won't argue.

Oleg.


