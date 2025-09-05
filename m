Return-Path: <bpf+bounces-67545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FE2B45225
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 10:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC6858802C
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 08:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6C630AD16;
	Fri,  5 Sep 2025 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nl12NNYs"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4708A2D0636
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062415; cv=none; b=Jk8niO1XhbzHFVz2XF6u5hCpKV1z4/PvbOFOl9Oyj18xo6BFacOkiwdQ8HfcBgWlSblkCpMhDEqNtPEbJnkb42Pw2KcY32uM0nbcKtW9H07ltPuxa5Ow7xISJwRWyyFexzbwHkAysMf1hTKvPEIkgMdpQubET2dLFWTiIZgos5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062415; c=relaxed/simple;
	bh=dcdyIOSIHdWK4hUmpfn/IRSAzQGUbzHF2AD9bcA3XYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trzBw7YMDcRFz99izMy1Yur29q0RHkaevG4xR+BYaAWAld76QpyicSbSxxTRzK/Pi5GkJLP/aqLJbwhPOLRXWpx9vMEZ8n+Dy28T8v9J1dRUHl6QdlWYQanDHgVV4K5r3MMvTvcplt+5LwjTcZF5koK0avUSNcSDlNc/5CpcdLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nl12NNYs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757062413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dcdyIOSIHdWK4hUmpfn/IRSAzQGUbzHF2AD9bcA3XYA=;
	b=Nl12NNYsEAc6pe1dxfkTIbqDo2+V5Tg+Xa5htJh9HG6s1kbSuEfhn6cgGjcGRRm/xJcZbS
	MPvlxk8xzzXglXvA8ruBRkyG5ptPIErE/jn/dxTgRdUOcc66+TH0q/cawwGgP0Xw3fgCo3
	46CYayEMLsFTTIetnYmGSxp7i9gFG74=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-yoJ3J4YrM3ORNbUgzmsrFw-1; Fri,
 05 Sep 2025 04:53:27 -0400
X-MC-Unique: yoJ3J4YrM3ORNbUgzmsrFw-1
X-Mimecast-MFC-AGG-ID: yoJ3J4YrM3ORNbUgzmsrFw_1757062405
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DA981956056;
	Fri,  5 Sep 2025 08:53:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B372418003FC;
	Fri,  5 Sep 2025 08:53:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  5 Sep 2025 10:52:03 +0200 (CEST)
Date: Fri, 5 Sep 2025 10:51:56 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	X86 ML <x86@kernel.org>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 02/11] uprobes: Skip emulate/sstep on unique
 uprobe when ip is changed
Message-ID: <20250905085155.GA12770@redhat.com>
References: <20250902143504.1224726-3-jolsa@kernel.org>
 <20250903112648.GC18799@redhat.com>
 <aLicCjuqchpm1h5I@krava>
 <20250904084949.GB27255@redhat.com>
 <aLluB1Qe6Y9B8G_e@krava>
 <20250904112317.GD27255@redhat.com>
 <CAADnVQ+DHGc8R0Tdxf7eUj1R0TDGHXLwk5D4i_0==2_rfXGbfw@mail.gmail.com>
 <CAEf4BzbxjRwxhJTLUgJNwR-vEbDybBpawNsRb+y+PiDsxzT=eA@mail.gmail.com>
 <20250904185553.GB23718@redhat.com>
 <CAEf4BzYb=mqN84a8+xc-Du1QkUBYMgwAuStYqastJJHQE4Os5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYb=mqN84a8+xc-Du1QkUBYMgwAuStYqastJJHQE4Os5g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 09/04, Andrii Nakryiko wrote:
>
> On Thu, Sep 4, 2025 at 11:57 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > That said. If you guys don't see a problem - I won't even try to argue.
>
> I don't, yep.

OK. Then I am fine with that too.

Oleg.


