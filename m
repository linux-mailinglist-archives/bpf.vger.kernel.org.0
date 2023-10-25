Return-Path: <bpf+bounces-13210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E25FE7D6189
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 08:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8F91C209B3
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 06:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8893156E5;
	Wed, 25 Oct 2023 06:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6Vq/JPQ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7D415497
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 06:19:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B1212D
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 23:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698214767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fdwDKRXZxM6igH9lqBL/vlo6C1ip2tpQphW5JxO9vD8=;
	b=T6Vq/JPQfVQLpAv3AT9X6wy4j1g5sTWCWNjcVg+RGGS7yzGgWsESmHgYg5W7R3jBA6BYR0
	eacVl1q3uhyylMwK/d0xJvWw3+rjjhnSxGZli4kNUJKdRTMACEIqYYKoFGdLno6kh15Otd
	f6upX+sY6j4pBhZKBmkZMdTxMZldLU0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-s7-jfWwAPamJmlHFxOEg4Q-1; Wed, 25 Oct 2023 02:19:21 -0400
X-MC-Unique: s7-jfWwAPamJmlHFxOEg4Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39A9B101A594;
	Wed, 25 Oct 2023 06:19:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.62])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 39BCD1121319;
	Wed, 25 Oct 2023 06:19:18 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Donald Zickus <dzickus@redhat.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next 0/3] samples/bpf: Allow building as PIE
Date: Wed, 25 Oct 2023 08:19:11 +0200
Message-ID: <cover.1698213811.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Hi,

when trying to build samples/bpf as PIE in Fedora, we came across
several issues, mainly related to the way compiler/linker flags are
handled in samples/bpf/Makefile. The first 2 commits in this patchset
address these issues (see commit messages for details).

At the same time, this proposes to allow passing an already built
bpftool to samples/bpf/Makefile. The reason is to remove a redundant
build step but also because I was not able to find a correct combination
of build flags to build libbpf.a for samples/bpf/bpftool/ with -fPIE.

Viktor Malik (3):
  samples/bpf: Allow building with custom CFLAGS/LDFLAGS
  samples/bpf: Fix passing LDFLAGS to libbpf
  samples/bpf: Allow building with custom bpftool

 samples/bpf/Makefile | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.41.0


