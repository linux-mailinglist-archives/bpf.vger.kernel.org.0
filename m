Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AE349B985
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 18:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587194AbiAYRBM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 12:01:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30074 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350609AbiAYQ7E (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Jan 2022 11:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643129942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KDOvTBWTB68A1+zMvaZuOmuYFuzBPVTiI2ekvr/ZuSA=;
        b=RGH/oxc714vV+stjBEUgw+bLNenuj7QfWPIOXNto0BBkjUHLas0+vT+/DUtKOh0WNwnEbv
        N8OdTSRg5pUsB4ADzhRvR9xbagCQOLVIZBlad6z0pqCidgX4y4YtXGc9stCRGXbq3UFV/B
        Wgb0dvwisPN2lfbvBb+8vk7vmZW+ZDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-YLiR9wMcNWex-x97vJKXBw-1; Tue, 25 Jan 2022 11:58:59 -0500
X-MC-Unique: YLiR9wMcNWex-x97vJKXBw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09EA26409A;
        Tue, 25 Jan 2022 16:58:58 +0000 (UTC)
Received: from thinkpad.fritz.box (unknown [10.40.194.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EEA77798D8;
        Tue, 25 Jan 2022 16:58:55 +0000 (UTC)
From:   Felix Maurer <fmaurer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, kafai@fb.com,
        yauheni.kaliuta@redhat.com, sdf@google.com, zhuyifei@google.com,
        jbenc@redhat.com
Subject: [PATCH bpf-next] selftests: bpf: Less strict size check in sockopt_sk
Date:   Tue, 25 Jan 2022 17:58:23 +0100
Message-Id: <6f569cca2e45473f9a724d54d03fdfb45f29e35f.1643129402.git.fmaurer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Originally, the kernel strictly checked the size of the optval in
getsockopt(TCP_ZEROCOPY_RECEIVE) to be equal to sizeof(struct
tcp_zerocopy_receive). With c8856c0514549, this was changed to allow
optvals of different sizes.

The bpf code in the sockopt_sk test was still performing the strict size
check. This fix adapts the kernel behavior from c8856c0514549 in the
selftest, i.e., just check if the required fields are there.

Fixes: 9cacf81f81611 ("bpf: Remove extra lock_sock for TCP_ZEROCOPY_RECEIVE")
Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 tools/testing/selftests/bpf/progs/sockopt_sk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
index d0298dccedcd..c8d810010a94 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
@@ -72,7 +72,8 @@ int _getsockopt(struct bpf_sockopt *ctx)
 		 * reasons.
 		 */
 
-		if (optval + sizeof(struct tcp_zerocopy_receive) > optval_end)
+		/* Check that optval contains address (__u64) */
+		if (optval + sizeof(__u64) > optval_end)
 			return 0; /* bounds check */
 
 		if (((struct tcp_zerocopy_receive *)optval)->address != 0)
-- 
2.34.1

