Return-Path: <bpf+bounces-748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C3770649B
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 11:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E7D281585
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 09:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A13156D2;
	Wed, 17 May 2023 09:52:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C5D11184
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 09:52:19 +0000 (UTC)
X-Greylist: delayed 86 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 May 2023 02:52:17 PDT
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1E1420A
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 02:52:17 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-yiFmWgEMNPO1yR4btlEE4A-1; Wed, 17 May 2023 05:50:31 -0400
X-MC-Unique: yiFmWgEMNPO1yR4btlEE4A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE5983C0F66B;
	Wed, 17 May 2023 09:50:30 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 808B7492B01;
	Wed, 17 May 2023 09:50:29 +0000 (UTC)
From: Alexey Gladkov <legion@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stanislav Fomichev <sdf@google.com>
Subject: [RESEND PATCH v1] selftests/bpf: Do not use sign-file as testcase
Date: Wed, 17 May 2023 11:49:46 +0200
Message-Id: <88e3ab23029d726a2703adcf6af8356f7a2d3483.1684316821.git.legion@kernel.org>
In-Reply-To: <88e3ab23029d726a2703adcf6af8356f7a2d3483.1682607419.git.legion@kernel.org>
References: <88e3ab23029d726a2703adcf6af8356f7a2d3483.1682607419.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	RDNS_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The sign-file utility (from scripts/) is used in prog_tests/verify_pkcs7_sig.c,
but the utility should not be called as a test. Executing this utility
produces the following error:

selftests: /linux/tools/testing/selftests/bpf: urandom_read
ok 16 selftests: /linux/tools/testing/selftests/bpf: urandom_read

selftests: /linux/tools/testing/selftests/bpf: sign-file
not ok 17 selftests: /linux/tools/testing/selftests/bpf: sign-file # exit=2

Fixes: fc97590668ae ("selftests/bpf: Add test for bpf_verify_pkcs7_signature() kfunc")
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 tools/testing/selftests/bpf/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b677dcd0b77a..fd214d1526d4 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -88,8 +88,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
 	xdp_features
 
-TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read $(OUTPUT)/sign-file
-TEST_GEN_FILES += liburandom_read.so
+TEST_GEN_FILES += liburandom_read.so urandom_read sign-file
 
 # Emit succinct information message describing current building step
 # $1 - generic step name (e.g., CC, LINK, etc);
-- 
2.33.8


