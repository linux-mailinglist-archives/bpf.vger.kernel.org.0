Return-Path: <bpf+bounces-33283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0B691AE53
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 19:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4730DB2815A
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 17:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1B819B3CC;
	Thu, 27 Jun 2024 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+Ao9hbl"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2020D19AD8D
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509996; cv=none; b=qm18xuEt33g/+oDG20XIwqos/xga297aAz71FxxnD2MjA1X+FjAAGNOoy2EqHwKiBT9rFPm7LQyWLceZ2GPoAsKuymP3mF6hjw0NnHUwq78e+PZ4/L0BB6C7d5TpCmgmRXcGfRq9OZXy4tOoUhVZG4VfDfB3HT41SP/YFCBL53I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509996; c=relaxed/simple;
	bh=M1Pr/ccqxR64Qy5pX519WkVfLnUUaSq7Qjbum1LSRes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3y3vqKfUlO/3NTVJlvYxPuu3PsHQHQ+PYxHvIbqmre6gCnzJw+PkjSRBoBXFl740i1ZgOo+RekTNEqhaSO5d7dnp4viFTbc7z/HTQcRAbPGakbuTFbNAeuvks47r64hwiVNP/NcgUEmjqwB8XP4L2IOEid1og/IY1dLE5Rnhdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+Ao9hbl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719509994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=34BYMyGoC6lX3CxmLrEw2DjPDGR7811PFr+ZC7aQ/ZU=;
	b=Y+Ao9hblb7/Lp/WbUjWOV2unEMUy1ULLKNVXLsLcZrJfDIfRn/fbC6/xphYU2KUrlElPW/
	z3noxblx4oUH6XCMpkg+U4JHZkJSRtymwUkREG8F8Y/zCDkoj7oTNwXQiQ2E7XG1ONGGlE
	w9NJU0JdXZl9CGqwiSyMcRfCP/X/FnM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-sTRvXhL3ML203UbvsHfRAA-1; Thu,
 27 Jun 2024 13:39:49 -0400
X-MC-Unique: sTRvXhL3ML203UbvsHfRAA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D9E2195608A;
	Thu, 27 Jun 2024 17:39:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.18])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5297819560AA;
	Thu, 27 Jun 2024 17:39:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 27 Jun 2024 19:38:12 +0200 (CEST)
Date: Thu, 27 Jun 2024 19:38:06 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Jiri Olsa <jolsa@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: Re: [PATCH] LoongArch: uprobes: make
 UPROBE_SWBP_INSN/UPROBE_XOLBP_INSN constant
Message-ID: <20240627173806.GC21813@redhat.com>
References: <20240618194306.1577022-1-jolsa@kernel.org>
 <20240627160255.GA25374@redhat.com>
 <CAEf4BzZVmKjfQD1zKMDOD-Zc4pVp+EGgb8h2veg=bXe1Pjn_Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZVmKjfQD1zKMDOD-Zc4pVp+EGgb8h2veg=bXe1Pjn_Uw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 06/27, Andrii Nakryiko wrote:
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks!

> > --- a/arch/loongarch/kernel/uprobes.c
> > +++ b/arch/loongarch/kernel/uprobes.c
> > @@ -7,6 +7,14 @@
> >
> >  #define UPROBE_TRAP_NR UINT_MAX
> >
> > +static __init int check_emit_break(void)
> > +{
> > +       BUG_ON(UPROBE_SWBP_INSN  != larch_insn_gen_break(BRK_UPROBE_BP));
> > +       BUG_ON(UPROBE_XOLBP_INSN != larch_insn_gen_break(BRK_UPROBE_XOLBP));
> > +       return 0;
> > +}
> > +arch_initcall(check_emit_break);
> > +
>
> I wouldn't even bother with this, but whatever.

Agreed, this looks a bit ugly. I did this only because I can not test
this (hopefully trivial) patch and the maintainers didn't reply.

If LoongArch boots at least once with this change, this run-time check
can be removed.

And just in case... I didn't dare to make a more "generic" change, but
perhaps KPROBE_BP_INSN and KPROBE_SSTEPBP_INSN should be redefined the
same way for micro-optimization. In this case __emit_break() should be
probably moved into arch/loongarch/include/asm/inst.h.

Oleg.


