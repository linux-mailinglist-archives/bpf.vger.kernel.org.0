Return-Path: <bpf+bounces-51422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9193A34776
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 16:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9C11898B19
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 15:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA56515539A;
	Thu, 13 Feb 2025 15:28:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21921411DE
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460502; cv=none; b=ihP8ApTQJMO+MuuQobAXfX+fK5DlIl1VJqQpdGC/a+5meTSf+AHG2PcZbOT304lTlaa8YHxPydYl/lYzyoAqDymyWY6IoHWj0BHmXITm/wXqd9ALmRPclEnJPdee/3HLEu5x7OgHY9R4o0kCEu65s9ll8pI+08pFOLMfcn/qPP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460502; c=relaxed/simple;
	bh=pwTtDmA89D9oMuYf46iOLOZ25/BRvwvcs2JnCaElLcw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRs+bK983OkDCqnGiXPImGSeOr9C/JHhEnWHdnV2ttRC74mKX9KPxjgc/DIASnEisp/QqulzywPb08Mq7OROIklLO7lmN33la4SdZvX/ivTb0XNKQ4gpy4vdXNtBiBB8sHeymz9QNtTiKUWR/vORDdcrE7YeYbzhyVqT5QL0Rfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1D5C4CED1;
	Thu, 13 Feb 2025 15:28:20 +0000 (UTC)
Date: Thu, 13 Feb 2025 10:28:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, bpf <bpf@vger.kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>, Sebastian Sewior <bigeasy@linutronix.de>, Hou Tao
 <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt
 <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, Matthew Wilcox
 <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Jann Horn
 <jannh@google.com>, Tejun Heo <tj@kernel.org>, linux-mm
 <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v8 3/6] locking/local_lock: Introduce
 localtry_lock_t
Message-ID: <20250213102830.19437fca@gandalf.local.home>
In-Reply-To: <CAADnVQLHRb8fu9J6Yd63ZDBtJFzZN1oWfwSDA_QXFqzXyr9F5g@mail.gmail.com>
References: <20250213033556.9534-1-alexei.starovoitov@gmail.com>
	<20250213033556.9534-4-alexei.starovoitov@gmail.com>
	<1fda7391-228d-4e10-8449-189be36eb27c@suse.cz>
	<CAADnVQLHRb8fu9J6Yd63ZDBtJFzZN1oWfwSDA_QXFqzXyr9F5g@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 07:23:01 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> realtime is hard. bpf and realtime together are even harder.

Going for an LWN Quote-of-the-week ? ;-)

-- Steve

