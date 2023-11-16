Return-Path: <bpf+bounces-15164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C747EDDC8
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 10:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB283280FD3
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 09:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE64928E09;
	Thu, 16 Nov 2023 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUmdIqIT"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1E1187
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 01:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700127600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LLXIUTXD0M2uVOySxASo8TWbR7mxoyT6p6/agsN7zes=;
	b=aUmdIqITRtaWYvDU6k/onutdYzbOT1qH9COoe5pnpVV6shE4LkpMazIPqN4AFrWRwhQNuf
	95ZgNEdJCBI3WxDvW9Ck2JQes2DFcqlO1ajn/m2zH/HS6WBYDGbgQ6n7IgZTFuYnIkfdNf
	bFV8e6LhJJDhU0dNH75Q53kwYoNNJck=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426--r7ZKUlaPpu-Zo4m0k70mA-1; Thu,
 16 Nov 2023 04:39:55 -0500
X-MC-Unique: -r7ZKUlaPpu-Zo4m0k70mA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39F783C11C66;
	Thu, 16 Nov 2023 09:39:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.23])
	by smtp.corp.redhat.com (Postfix) with SMTP id 5C859492BFD;
	Thu, 16 Nov 2023 09:39:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 16 Nov 2023 10:38:51 +0100 (CET)
Date: Thu, 16 Nov 2023 10:38:48 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <kuifeng@fb.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 3/3] bpf: bpf_iter_task_next: use next_task(kit->task)
 rather than next_task(kit->pos)
Message-ID: <20231116093848.GB18748@redhat.com>
References: <20231114163239.GA903@redhat.com>
 <9dfbc7ce-49cc-4519-88cf-93d6b72e5ff6@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dfbc7ce-49cc-4519-88cf-93d6b72e5ff6@linux.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 11/16, Yonghong Song wrote:
>
> On 11/14/23 11:32 AM, Oleg Nesterov wrote:
> >This looks more clear and simplifies the code. While at it, remove the
> >unnecessary initialization of pos/task at the start of bpf_iter_task_new().
> >
> >Note that we can even kill kit->task, we can just use pos->group_leader,
> >but I don't understand the BUILD_BUG_ON() checks in bpf_iter_task_new().
>
> Let us keep kit->task, which is used in later function
> bpf_iter_task_next(). The patch looks good to me.

Yes, but it can use pos->group_leader instead of kit->task.
But I agree, lets keep kit->task.

> Acked-by: Yonghong Song <yonghong.song@linux.dev>

Thanks!

Oleg.


