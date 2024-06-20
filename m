Return-Path: <bpf+bounces-32616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A86911181
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 20:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC732849A6
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 18:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881891BB6B9;
	Thu, 20 Jun 2024 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZ5Yu+sQ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C51A1B4C5A
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909651; cv=none; b=piT0J6v33+s44BbhUchf498cmE3EZUQMh5QvQcHvT5m5uF2Tyf7+BL0C4KrDaApJCPlP8imfpPRkLY4vAC/UVd+26Nl544BT/Z5i+PATvHESBcpzdrDZeanSn/u2JPVSApQjnFbu6lCmtu6q1zF67dNr2/faXa8oXqWfKrFzjVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909651; c=relaxed/simple;
	bh=7QXAx5RXUFSzeklprgP9xCdMOxGkqkNOA9zH//++ZaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYvybxIjB+J4+2ovBSIe7JejiJTsfbKRtuyRvpk+mkVRdxojJt82XtkhLsSTZd/BrSgUhIjteMMgLFoS1IWCIRX18NUQIh7sxoHay9V+lvBizOnRPiezDZuVX33aycwzMt4Ap//DadXscfpXAS2WQU/e7kRLKI4tUJYDa36NFEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CZ5Yu+sQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718909648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6SaPDVU1xalbIsagCAY1R8fkcnXXSLdW/5aQMD2rFqY=;
	b=CZ5Yu+sQXMgJzHd25Lg/QkacYJuJ8d4g592xdQFYJI2RdGaX51oWv14aPhFxHbLeAVrMSc
	SHtHcjGLXrt4fNx8RxrywWDr2dYQAT7MEdcJlM/dft+VUTSEkHg/LnX32Dh3zsPja600hE
	qTU92YxmHZYuEd47JGIanSBw8sAaFeQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-VoSW1uqhPzGWnf7uEzF8-g-1; Thu,
 20 Jun 2024 14:54:05 -0400
X-MC-Unique: VoSW1uqhPzGWnf7uEzF8-g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B90E1955E89;
	Thu, 20 Jun 2024 18:54:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.114])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id ABF5219560AF;
	Thu, 20 Jun 2024 18:53:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 20 Jun 2024 20:52:30 +0200 (CEST)
Date: Thu, 20 Jun 2024 20:52:20 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCHv8 bpf-next 3/9] uprobe: Add uretprobe syscall to speed up
 return probe
Message-ID: <20240620185220.GB2058@redhat.com>
References: <20240611112158.40795-1-jolsa@kernel.org>
 <20240611112158.40795-4-jolsa@kernel.org>
 <054064c5-704a-4ea7-8a89-1e136e475437@roeck-us.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <054064c5-704a-4ea7-8a89-1e136e475437@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 06/20, Guenter Roeck wrote:
>
> On Tue, Jun 11, 2024 at 01:21:52PM +0200, Jiri Olsa wrote:
> > Adding uretprobe syscall instead of trap to speed up return probe.
> >
>
> This patch results in:
>
> Building loongarch:allmodconfig ... failed
> --------------
> Error log:
> In file included from include/linux/uprobes.h:49,
>                  from include/linux/mm_types.h:16,
>                  from include/linux/mmzone.h:22,
>                  from include/linux/gfp.h:7,
>                  from include/linux/xarray.h:16,
>                  from include/linux/list_lru.h:14,
>                  from include/linux/fs.h:13,
>                  from include/linux/highmem.h:5,
>                  from kernel/events/uprobes.c:13:
> kernel/events/uprobes.c: In function 'arch_uprobe_trampoline':
> arch/loongarch/include/asm/uprobes.h:12:33: error: initializer element is not constant

should be fixed by https://lore.kernel.org/all/ZmyZgzqsowkGyqmH@krava/
in this thread.

but may be arch/loongarch should override __weak arch_uprobe_trampoline() ?

Oleg.


