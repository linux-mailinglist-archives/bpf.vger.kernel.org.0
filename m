Return-Path: <bpf+bounces-61942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F69AEED55
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 06:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CBB33AD69B
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 04:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDACA1E9B1C;
	Tue,  1 Jul 2025 04:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lxd6hMLX"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E598A2905
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 04:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751345195; cv=none; b=tOljS2Ejl4l3F+9xYYmiJ4kEH7gIOqCYTT09mMjAteUXlEkbbRaT/GfJRaqFkQ0FfF85hjrNuNcrHtxJqdlfn/6RFOslxNfUpMRnb9gyEHrt3eE8ebvKejlCCet1fpVkWXB85HggtsYkIg/6j57CLoJM8x3KdxDuE1DGI9KHnjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751345195; c=relaxed/simple;
	bh=JREm9NxC1v8Qpc9cZYgj/EvCfx2wmXgZpAqtjSclzVo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=agNHOnTVoFEmRbU1co/NAOGgmYTOS5QKKk2Qw04eTIaSxKOsA8H8oDTo6B7OfuMB2TfBxrxm6eeqI9njXb960IH+h+sk9FulwkEkx4b4Xn3BuxtG8gkbWyruvWaSwhYA4f4BXwok6b94gfj10eplegip/EPxg3IMZ+bmXpJ3OZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lxd6hMLX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751345192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KbkMncBjf3mIjrNd7CIAKLPBk8wyiP27JXNdHQeZn8g=;
	b=Lxd6hMLXV1VvoHIMt4+yYV6ocRt/WSHPMzHpvAzCdlIM3zoB56X893U0/YeFswDlEVsH6o
	SZ463yTXuCG5TBr0lhgKdPDyHC5Vkp29TWInLEZQiPAHFh6Uk3AOo3uEJDAgoiZ6v472aZ
	0PPoY3lRM7ZxCnGMq1O3E+ZOh0f6CQM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-I0lI9O0dOC-yR5ggx5YI5A-1; Tue,
 01 Jul 2025 00:46:29 -0400
X-MC-Unique: I0lI9O0dOC-yR5ggx5YI5A-1
X-Mimecast-MFC-AGG-ID: I0lI9O0dOC-yR5ggx5YI5A_1751345187
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 729AB190FBC4;
	Tue,  1 Jul 2025 04:46:25 +0000 (UTC)
Received: from oldenburg3.str.redhat.com (unknown [10.44.32.53])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39239195608F;
	Tue,  1 Jul 2025 04:46:17 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,  linux-kernel@vger.kernel.org,
  linux-trace-kernel@vger.kernel.org,  bpf@vger.kernel.org,
  x86@kernel.org,  Masami Hiramatsu <mhiramat@kernel.org>,  Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,  Josh Poimboeuf
 <jpoimboe@kernel.org>,  Peter Zijlstra <peterz@infradead.org>,  Ingo
 Molnar <mingo@kernel.org>,  Jiri Olsa <jolsa@kernel.org>,  Namhyung Kim
 <namhyung@kernel.org>,  Thomas Gleixner <tglx@linutronix.de>,  Andrii
 Nakryiko <andrii@kernel.org>,  Indu Bhagat <indu.bhagat@oracle.com>,
  "Jose E. Marchesi" <jemarch@gnu.org>,  Beau Belgrave
 <beaub@linux.microsoft.com>,  Jens Remus <jremus@linux.ibm.com>,  Andrew
 Morton <akpm@linux-foundation.org>,  Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v12 02/14] unwind_user: Add frame pointer support
In-Reply-To: <CAHk-=wiWOYB4c3E-Cc=D89j0txbN4AGqm0j1dojqHq3uzJ+LqQ@mail.gmail.com>
	(Linus Torvalds's message of "Mon, 30 Jun 2025 19:10:09 -0700")
References: <20250701005321.942306427@goodmis.org>
	<20250701005450.888492528@goodmis.org>
	<CAHk-=wiWOYB4c3E-Cc=D89j0txbN4AGqm0j1dojqHq3uzJ+LqQ@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 01 Jul 2025 06:46:14 +0200
Message-ID: <87tt3wikmh.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

* Linus Torvalds:

> On Mon, 30 Jun 2025 at 17:54, Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> +       /* stack going in wrong direction? */
>> +       if (cfa <= state->sp)
>> +               goto done;
>
> I suspect this should do a lot more testing.
>
>> +       /* Find the Return Address (RA) */
>> +       if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
>> +               goto done;
>> +
>> +       if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
>> +               goto done;
>
> .. and this should check the frame for validity too.  At a minimum it
> should be properly aligned, but things like "it had better be above
> the current frame" to avoid having some loop would seem to be a good
> idea.

I don't think SFrame as-is requires stacks to be contiguous.  Maybe
there could be a per-frame flag that indicates whether a stack switch is
expected?

Thanks,
Florian


