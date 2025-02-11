Return-Path: <bpf+bounces-51164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACA5A31249
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 18:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA5FD7A3001
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 16:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F20262143;
	Tue, 11 Feb 2025 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqEdqt3Q"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C5225A359
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739293235; cv=none; b=kiCEwhANSpIWDz2V2RdO9CyzUHY1SZgps3hDOpbxLo4vLfyxWv+xQ6dTKVzVYM7aDmyz76zq7SuZuihxq/t6eLrih3nFNX7B6q5hBJ57sNLr0HSrq5FOMurLvLT5YKZ1IsYrqo+ENNXbNq4UxihAk3/EQmUWXw92F/PVgkGgGRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739293235; c=relaxed/simple;
	bh=Ijl1870gwz6IX+/MESbsYzIdZlpRJGmSg/J77w9i4U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZCK3M3h4nRxgWegzAAsLzs7iSFXiB80A6fMv+0EcIlNKWyVSj1yogKMa4Mdx5Z77loH9ETFjsbxSCOXcJW9mMrhoNF0Wnc6b4uFx9gSqqTyz8KT3BxnAwqjHAr8A7wxHl+OK/fTO/Yq0fU4wk2Hi2mvyzXOG8Py/AFDII1Ulqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WqEdqt3Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739293232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ijl1870gwz6IX+/MESbsYzIdZlpRJGmSg/J77w9i4U4=;
	b=WqEdqt3Qr71lOz2KasNmYN0rqvdsXBrGxko3gmFnMiVqtM+ncPOx2hdQ9AJeC7F4PXh0Iv
	BlebVa8sLOkDznAWt3UNR4wCYuPgLSM5sGengbYdkVLdSdfmmiFiCbm6WnV5r62CjV6h52
	U2avipoitQ0dqettTTHlWxE5VyHRmJA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-DUCuPesZNGyoR9XuI7pEIQ-1; Tue,
 11 Feb 2025 12:00:29 -0500
X-MC-Unique: DUCuPesZNGyoR9XuI7pEIQ-1
X-Mimecast-MFC-AGG-ID: DUCuPesZNGyoR9XuI7pEIQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D32C91800872;
	Tue, 11 Feb 2025 17:00:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.197])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5438019560A3;
	Tue, 11 Feb 2025 17:00:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 11 Feb 2025 17:59:51 +0100 (CET)
Date: Tue, 11 Feb 2025 17:59:41 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	stable <stable@vger.kernel.org>, Jann Horn <jannh@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Linux API <linux-api@vger.kernel.org>, X86 ML <x86@kernel.org>,
	bpf <bpf@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCHv2 perf/core] uprobes: Harden uretprobe syscall trampoline
 check
Message-ID: <20250211165940.GB9174@redhat.com>
References: <20250211111559.2984778-1-jolsa@kernel.org>
 <CAEf4BzYPmtUirnO3Bp+3F3d4++4ttL_MZAG+yGcTTKTRK2X2vw@mail.gmail.com>
 <CAADnVQJ05xkXw+c_T1qB+ECUqO5sJxDVJ3bypjS3KSQCTJb-1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJ05xkXw+c_T1qB+ECUqO5sJxDVJ3bypjS3KSQCTJb-1g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 02/11, Alexei Starovoitov wrote:
>
> > > +#define UPROBE_NO_TRAMPOLINE_VADDR ((unsigned long)-1)
>
> If you respin anyway maybe use ~0UL instead?
> In the above and in
> uprobe_get_trampoline_vaddr(),
> since
>
> unsigned long trampoline_vaddr = -1;

... or -1ul in both cases.

I agree, UPROBE_NO_TRAMPOLINE_VADDR has a single user, looks
a bit strange...

Oleg.


