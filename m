Return-Path: <bpf+bounces-28683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CD98BD0C1
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 16:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B101F22006
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 14:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58129153BF9;
	Mon,  6 May 2024 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AC8QAUKc"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBE7153812
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007077; cv=none; b=bVKTK5r4yDJVvjQ1/ILqst4iwnSzAczSZJT6xDkKWAIxT2KgyZX1ndiONKYskN8urnCkOIjCpuL02hSvf/mj9sjwNd3SGjJtCi0L3V4HG1I5qOojU1DxbeUtuOIuj75Hxbfw4d5s3nS7Jakmhsk3nhQiVjualUXD0w9DzI0e8b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007077; c=relaxed/simple;
	bh=NoJOEe3WBr5N+Zi1ZOJ8scZWtJUtA/7YeluteZtdGJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lO/8nXfcn1y99Y1uUwzTV7TcnXuyFi/N8pNWXyXfThWMhcKdtCXsUj2c/+IubV2XvqkFWxdF/CkazA7L+gkGRI1Jqsa1zds8yoGs4SLDm76YfPQ3z42qAQokjhlbjqduG5h0GWdhGVtC5WkSArua/ed1MtQ5fDqVcmnOBCnjhDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AC8QAUKc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715007075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w3XIEQrPEX8PhRQQF8FgmaXCd9gS5l6iMjkAGMUJMYU=;
	b=AC8QAUKc3k0mkt6CnGgakZ6PgMFTuQ1cjzphs+bfD6PUUvsGPSnvqpKDVQN9mE8yUShmef
	3WmS2at/0QzVVtRVThhV3zCK+JwkuralS5IUsbk5X84es6WNJNkxWMOXHsyfcaRVTLvy34
	R1jHVWpnFW5Lvy/v/oN16qEprDcJ8oY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-FdghGdmPO52jYmhPmuM1Aw-1; Mon, 06 May 2024 10:51:08 -0400
X-MC-Unique: FdghGdmPO52jYmhPmuM1Aw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C3431044575;
	Mon,  6 May 2024 14:51:07 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.45.226.64])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2322D2024512;
	Mon,  6 May 2024 14:51:02 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] selftests/bpf: fix pointer arithmetic in test_xdp_do_redirect
Date: Mon,  6 May 2024 16:50:22 +0200
Message-ID: <20240506145023.214248-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Cast operation has a higher precedence than addition. The code here
wants to zero the 2nd half of the 64-bit metadata, but due to a pointer
arithmetic mistake, it writes the zero at offset 16 instead.

Just adding parentheses around "data + 4" would fix this, but I think
this will be slightly better readable with array syntax.

I was unable to test this with tools/testing/selftests/bpf/vmtest.sh,
because my glibc is newer than glibc in the provided VM image.
So I just checked the difference in the compiled code.
objdump -S tools/testing/selftests/bpf/xdp_do_redirect.test.o:
  -	*((__u32 *)data) = 0x42; /* metadata test value */
  +	((__u32 *)data)[0] = 0x42; /* metadata test value */
        be7:	48 8d 85 30 fc ff ff 	lea    -0x3d0(%rbp),%rax
        bee:	c7 00 42 00 00 00    	movl   $0x42,(%rax)
  -	*((__u32 *)data + 4) = 0;
  +	((__u32 *)data)[1] = 0;
        bf4:	48 8d 85 30 fc ff ff 	lea    -0x3d0(%rbp),%rax
  -     bfb:	48 83 c0 10          	add    $0x10,%rax
  +     bfb:	48 83 c0 04          	add    $0x4,%rax
        bff:	c7 00 00 00 00 00    	movl   $0x0,(%rax)

Fixes: 5640b6d89434 ("selftests/bpf: fix "metadata marker" getting overwritten by the netstack")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
index 498d3bdaa4b0..bad0ea167be7 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
@@ -107,8 +107,8 @@ void test_xdp_do_redirect(void)
 			    .attach_point = BPF_TC_INGRESS);
 
 	memcpy(&data[sizeof(__u64)], &pkt_udp, sizeof(pkt_udp));
-	*((__u32 *)data) = 0x42; /* metadata test value */
-	*((__u32 *)data + 4) = 0;
+	((__u32 *)data)[0] = 0x42; /* metadata test value */
+	((__u32 *)data)[1] = 0;
 
 	skel = test_xdp_do_redirect__open();
 	if (!ASSERT_OK_PTR(skel, "skel"))
-- 
2.44.0


