Return-Path: <bpf+bounces-15060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A45CC7EB4EA
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 17:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A8C1C20B1B
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 16:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59F13D3B4;
	Tue, 14 Nov 2023 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nj11PBAf"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F1C41748
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 16:33:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5B5F9
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 08:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699979601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=tzfSnDUwga1tSh876/MWCFEyzy4dmGr84sjeijPXpA0=;
	b=Nj11PBAfeD3a1EONmL69cAR3miSrhfP5kXioUoWkyRi57LR9I/tCdsjP0ZMwkr4xmi9CH0
	Lda4N/Tp6WWO+MBgtkY7JCmR9w02XNYcgg8hbmNBEwn+6jxu6usymRkHsgjC9qodaHedQw
	0naFiOZO5LLyl4CWf9jqKdW2CTRMwVk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-X_-LwZLeNp2U6b5NRUTECQ-1; Tue, 14 Nov 2023 11:33:19 -0500
X-MC-Unique: X_-LwZLeNp2U6b5NRUTECQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E97A8185A7A8;
	Tue, 14 Nov 2023 16:33:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.253])
	by smtp.corp.redhat.com (Postfix) with SMTP id 17A771121306;
	Tue, 14 Nov 2023 16:33:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 14 Nov 2023 17:32:14 +0100 (CET)
Date: Tue, 14 Nov 2023 17:32:11 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <kuifeng@fb.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 0/3] bpf: kernel/bpf/task_iter.c: don't abuse next_thread()
Message-ID: <20231114163211.GA874@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Compile tested.

Every lockless usage of next_thread() was wrong, bpf/task_iter.c is
the last user and is no exception.

Oleg.
---

 kernel/bpf/task_iter.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)


