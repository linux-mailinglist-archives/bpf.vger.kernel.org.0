Return-Path: <bpf+bounces-56802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B01B2A9E3AA
	for <lists+bpf@lfdr.de>; Sun, 27 Apr 2025 16:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED43818928E8
	for <lists+bpf@lfdr.de>; Sun, 27 Apr 2025 14:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27BB199385;
	Sun, 27 Apr 2025 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHSqLjih"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E8610942
	for <bpf@vger.kernel.org>; Sun, 27 Apr 2025 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745765822; cv=none; b=giUon6Lrpxd7XDdqi0QQINsvH8IpAkmSi25U/mmr0BstsRX4UfVEXfhb41CnfDqgwrSfSQ27xRkizmjKysGhVT2cTcjWWs12RBoh8gV9aS+dqizAXi1DvCgUWRbTmcbPUgkcIXjHLABmwlOyrBKNx8zGHbk0O635bTTpCU2PJac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745765822; c=relaxed/simple;
	bh=d2uDCVX6vy5fgINTJAoPSXWz99AZILOOAgGVtDIVWIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbFt87dm2eja5sFYggv7LQvjcOsUvyOvsBDOEU1xaqw2kZlEUzE3P0nWLflE4KRPs7QdGzYf48sKlFWoEvqDCngSbFj7I5rajIeR2wZ69JUJ9vkmKzlmbbQ99MPPStzMNb822UXp2gzGjfGCWE7uNsrsWkkvF/rrVcTxzzlFpmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AHSqLjih; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745765819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=icw4AxzsZTsOJJ+P8ibwCbXmBIE2aO1l9yKvVx2uDRo=;
	b=AHSqLjihwtON1pFzFz3roh5GavbtSFmZTnMQJjW6L+PBndJPJgEUFLh7jBeAFC+cEwucT3
	Vo/23ocBww1giczQdWzyXuisD+5ANZwPtE03c4ws/ZKSFF+zmZICT78Ndr9yGE7vUDF97O
	ENFOw7iDoc0gJ5Ogb2vjgpFYgzr+qwQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-O4ZXsu8TO7GR1XelWUl6qg-1; Sun,
 27 Apr 2025 10:56:55 -0400
X-MC-Unique: O4ZXsu8TO7GR1XelWUl6qg-1
X-Mimecast-MFC-AGG-ID: O4ZXsu8TO7GR1XelWUl6qg_1745765813
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B5311955DDE;
	Sun, 27 Apr 2025 14:56:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.18])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D563E1800368;
	Sun, 27 Apr 2025 14:56:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 27 Apr 2025 16:56:14 +0200 (CEST)
Date: Sun, 27 Apr 2025 16:56:06 +0200
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
Subject: Re: [PATCH perf/core 08/22] uprobes/x86: Add mapping for optimized
 uprobe trampolines
Message-ID: <20250427145606.GC9350@redhat.com>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-9-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421214423.393661-9-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 04/21, Jiri Olsa wrote:
>
> +static unsigned long find_nearest_page(unsigned long vaddr)
> +{
> +	struct vm_area_struct *vma, *prev = NULL;
> +	unsigned long prev_vm_end = PAGE_SIZE;
> +	VMA_ITERATOR(vmi, current->mm, 0);
> +
> +	vma = vma_next(&vmi);
> +	while (vma) {
> +		if (prev)
> +			prev_vm_end = prev->vm_end;
> +		if (vma->vm_start - prev_vm_end  >= PAGE_SIZE) {
> +			if (is_reachable_by_call(prev_vm_end, vaddr))
> +				return prev_vm_end;
> +			if (is_reachable_by_call(vma->vm_start - PAGE_SIZE, vaddr))
> +				return vma->vm_start - PAGE_SIZE;
> +		}
> +		prev = vma;
> +		vma = vma_next(&vmi);
> +	}
> +
> +	return 0;
> +}

This can be simplified afaics... We don't really need prev, and we can
use for_each_vma(),

	static unsigned long find_nearest_page(unsigned long vaddr)
	{
		struct vm_area_struct *vma;
		unsigned long prev_vm_end = PAGE_SIZE;
		VMA_ITERATOR(vmi, current->mm, 0);

		for_each_vma(vmi, vma) {
			if (vma->vm_start - prev_vm_end  >= PAGE_SIZE) {
				if (is_reachable_by_call(prev_vm_end, vaddr))
					return prev_vm_end;
				if (is_reachable_by_call(vma->vm_start - PAGE_SIZE, vaddr))
					return vma->vm_start - PAGE_SIZE;
			}
			prev_vm_end = vma->vm_end;
		}

		return 0;
	}

> +static struct uprobe_trampoline *create_uprobe_trampoline(unsigned long vaddr)
> +{
> +	struct pt_regs *regs = task_pt_regs(current);
> +	struct mm_struct *mm = current->mm;
> +	struct uprobe_trampoline *tramp;
> +	struct vm_area_struct *vma;
> +
> +	if (!user_64bit_mode(regs))
> +		return NULL;

Cosmetic, but I think it would be better to move this check into the
caller, uprobe_trampoline_get().

> +	vma = _install_special_mapping(mm, tramp->vaddr, PAGE_SIZE,
> +				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
> +				&tramp_mapping);

Note that xol_add_vma() -> _install_special_mapping() uses VM_SEALED_SYSMAP.
Perhaps create_uprobe_trampoline() should use this flag too for consistency?

Oleg.


