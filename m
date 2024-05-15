Return-Path: <bpf+bounces-29776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB048C69E5
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 17:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3F31C216D4
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 15:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463D5155A53;
	Wed, 15 May 2024 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwHJeUni"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A28D155A4F
	for <bpf@vger.kernel.org>; Wed, 15 May 2024 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715787826; cv=none; b=K9fXNgJPJQjKHuAgvkEBBIVTTPcjiq73YN9NdyfVNJ9kUbi3aRlzHB+Y3VIGow1wTImWKeCsWdqjb4Lltf5m2CDA+KeSh3f03mkjiEMj5PlsduyKyHFQpxG3hOUIYn07XyFF0mV0DjHtAbg1b2Bi/CcxMuBlsczy9/AfNyTb6bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715787826; c=relaxed/simple;
	bh=sVxFSbL3YtTiW/g14Gv6p0q8nZLKnH+spwUtKK9cJ9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSJ9GumFapW4Jv8Ijy4vmbUTs+o3+fm0CjHc1wKB3K6bo3z5frPB3sQ4afUYXnAoitRWO5oheHFNNMVcV8TZElbasX/uyEH1Z/L8qz5YxeMttNZrzvkhqyL1EF59vXm6tUEapTkDyP4vU58pYtS5zJQ9qTtIJZ/WcwBWYaK45hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NwHJeUni; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715787824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sVxFSbL3YtTiW/g14Gv6p0q8nZLKnH+spwUtKK9cJ9A=;
	b=NwHJeUniLMcY2PIjcN02rOodzkNgo6EYitlRQF3ZNCThMeNi4vkgNdjP54QzRm2nUWnL2k
	gF9pJTCLRaTIuWgkhS/D+g5eNxAinK7ZXOHcaZGOZHMg1MC0b+6vaTdoAd1fR658gStg+E
	TLdglxN10gm2tWtINu03xoPMeKTSa/Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-WrPe04tvN8qa89qxw5DYcg-1; Wed, 15 May 2024 11:43:35 -0400
X-MC-Unique: WrPe04tvN8qa89qxw5DYcg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 867498016E9;
	Wed, 15 May 2024 15:43:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.39])
	by smtp.corp.redhat.com (Postfix) with SMTP id C19983C27;
	Wed, 15 May 2024 15:43:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 15 May 2024 17:42:08 +0200 (CEST)
Date: Wed, 15 May 2024 17:42:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "olsajiri@gmail.com" <olsajiri@gmail.com>,
	"songliubraving@fb.com" <songliubraving@fb.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
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
Message-ID: <20240515154202.GE6821@redhat.com>
References: <20240507105321.71524-7-jolsa@kernel.org>
 <a08a955c74682e9dc6eb6d49b91c6968c9b62f75.camel@intel.com>
 <ZjyJsl_u_FmYHrki@krava>
 <a8b7be15e6dbb1e8f2acaee7dae21fec7775194c.camel@intel.com>
 <Zj_enIB_J6pGJ6Nu@krava>
 <20240513185040.416d62bc4a71e79367c1cd9c@kernel.org>
 <c56ae75e9cf0878ac46185a14a18f6ff7e8f891a.camel@intel.com>
 <ZkKE3qT1X_Jirb92@krava>
 <20240515113525.GB6821@redhat.com>
 <0fa9634e9ac0d30d513eefe6099f5d8d354d93c1.camel@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fa9634e9ac0d30d513eefe6099f5d8d354d93c1.camel@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 05/15, Edgecombe, Rick P wrote:
>
> On Wed, 2024-05-15 at 13:35 +0200, Oleg Nesterov wrote:
> >
> > > I'm ok with not using optimized uretprobe when shadow stack is detected
> > > as enabled and we go with current uretprobe in that case
> >
> > But how can we detect it? Again, suppose userspace does
>
> the rdssp instruction returns the value of the shadow stack pointer. On non-
> shadow stack it is a nop. So you could check if the SSP is non-zero to find if
> shadow stack is enabled.

But again, the ret-probed function can enable it before it returns? And we
need to check if it is enabled on the function entry if we want to avoid
sys_uretprobe() in this case. Although I don't understand why we want to
avoid it.

> This would catch most cases, but I guess there is the
> possibility of it getting enabled in a signal that hit between checking and the
> rest of operation.

Or from signal handler.

> Is this uretprobe stuff signal safe in general?

In what sense?

I forgot everything about this code but I can't recall any problem with signals.

Except it doesn't support sigaltstack() + siglongjmp().

Oleg.


