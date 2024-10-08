Return-Path: <bpf+bounces-41256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6873995342
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 17:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D3D281422
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 15:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EA51E0DB5;
	Tue,  8 Oct 2024 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HK7Aoff2"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE961E0B91
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400888; cv=none; b=uRob0njde3E3cIK3zWC4pguDh2x4ShAZmWCcMsJZeJpxdaRxRIX9FMKXAyf2a2+N65e2m+jqPHMR4/VkCdEGY5DIVvhltuAT4SiiUq7xOMjQFXu0YRpp29X5TtkBatzAPJCPhHh5CyNO9a2QsrbJvYspG/OPugrk2gjsPQLwFKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400888; c=relaxed/simple;
	bh=V6wv7UuW3HAgTnvx4RGFnn4y4Ee+TSsmIYQNAmcoo/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dczMuF3CESdxLRhkGVSM27dF6Is1SXaMfurHK73UD4w58z55MBMUAkz+71UZo4XD++stPYAfLsfQuHmOMmJ4M/TL01QoOXGI2PT1lXMB+Op9RVvAFeY5ccPbC8lJixPtD7SxD9Q8//kiED8RG6Ie6B90Xb17zV3TnKTHeID1TQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HK7Aoff2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728400885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ruYSLgW7gfmln5kN4ADH0+uUUeJjmQiMQYi2GHJLhGM=;
	b=HK7Aoff28qaYRPW+oEg61pRvs5yX643eJBrrHhXXrs3FckMrnWyI5GHz4mDzjsBJGneAO0
	xT1eyIpwFx5sYJ2WU7dHMClAJ4Kzlc5kv6S9nJhv54M2IIJIlW8wPy0DyVgZ1pcZyFqfXm
	CN1ksvPrNR0v9wXvevho3FrPv5BvjYo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-BuiWbL8bPueyNVxlgpUhdA-1; Tue,
 08 Oct 2024 11:21:22 -0400
X-MC-Unique: BuiWbL8bPueyNVxlgpUhdA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19AB51955F3D;
	Tue,  8 Oct 2024 15:21:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.71])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 68A7219560A7;
	Tue,  8 Oct 2024 15:21:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  8 Oct 2024 17:21:05 +0200 (CEST)
Date: Tue, 8 Oct 2024 17:20:57 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, mjguzik@gmail.com, brauner@kernel.org,
	jannh@google.com, mhocko@kernel.org, vbabka@suse.cz,
	mingo@kernel.org
Subject: Re: [PATCH v2 tip/perf/core 0/5] uprobes,mm: speculative lockless
 VMA-to-uprobe lookup
Message-ID: <20241008152056.GA9508@redhat.com>
References: <20241001225207.2215639-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001225207.2215639-1-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Well. I am in no position to ack these changes.

But let me say that I personally like this series and I see nothing wrong,
except perhaps 5/5 needs some data_race/etc annotations as we have already
discussed.

Thanks,

Oleg.

On 10/01, Andrii Nakryiko wrote:
>
> Implement speculative (lockless) resolution of VMA to inode to uprobe,
> bypassing the need to take mmap_lock for reads, if possible. Patch #1 by Suren
> adds mm_struct helpers that help detect whether mm_struct were changed, which
> is used by uprobe logic to validate that speculative results can be trusted
> after all the lookup logic results in a valid uprobe instance. Patch #2
> follows to make mm_lock_seq into 64-bit counter (on 64-bit architectures).
>
> Patch #3 adds back RCU-delayed freeing for FMODE_BACKING files, which is
> necessary to make speculation safe to access struct file's memory in any
> possible situation.
>
> Patch #4 is a simplification to uprobe VMA flag checking, suggested by Oleg.
>
> And, finally, patch #5 is the speculative VMA-to-uprobe resolution logic. See
> corresponding patch for details and benchmarking results.
>
> v1->v2:
> - adjusted vma_end_write_all() comment to point out it should never be called
>   manually now, but I wasn't sure how ACQUIRE/RELEASE comments should be
>   reworded (previously requested by Jann), so I'd appreciate some help there
>   (Jann);
> - int -> long change for mm_lock_seq, as agreed at LPC2024 (Jann, Suren, Liam);
> - kfree_rcu_mightsleep() for FMODE_BACKING (Suren, Christian);
> - vm_flags simplification in find_active_uprobe_rcu() and
>   find_active_uprobe_speculative() (Oleg);
> - guard(rcu)() simplified find_active_uprobe_speculative() implementation.
>
> Andrii Nakryiko (4):
>   mm: switch to 64-bit mm_lock_seq/vm_lock_seq on 64-bit architectures
>   fs: add back RCU-delayed freeing of FMODE_BACKING file
>   uprobes: simplify find_active_uprobe_rcu() VMA checks
>   uprobes: add speculative lockless VMA-to-inode-to-uprobe resolution
>
> Suren Baghdasaryan (1):
>   mm: introduce mmap_lock_speculation_{start|end}
>
>  fs/file_table.c           |  2 +-
>  include/linux/mm.h        |  6 ++--
>  include/linux/mm_types.h  |  7 ++--
>  include/linux/mmap_lock.h | 72 ++++++++++++++++++++++++++++++++-------
>  kernel/events/uprobes.c   | 46 ++++++++++++++++++++++++-
>  kernel/fork.c             |  3 --
>  6 files changed, 114 insertions(+), 22 deletions(-)
>
> --
> 2.43.5
>


