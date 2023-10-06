Return-Path: <bpf+bounces-11585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF56E7BC202
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 00:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E581C20C1F
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 22:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3035F450E3;
	Fri,  6 Oct 2023 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="bP6goTWu"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F91450D5
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 22:07:11 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F3FC5
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 15:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Tk50MVtgBtEZTz+ZbBJ6stFQdM/+OLKuBSPu4cfoP/Q=; b=bP6goTWu+ht6uogWapDElvgONm
	VyaWpiHkvLrYSmiaucSITfXepuzBwMyUO6X2UZk2F90rKlIr2wgwzzhnaaly53j39B80TDvHEhSEn
	znOcZ3uoPQtM2ehEH+mTv8VidL2dvxAPJA+NECmz6H/kAcH/3ZrWgfzJIXY2Yt2s+x0ukMYUGSy+M
	GycV6IsxlmME98Fa5wRUelv6E7+pl7qqcTzrcrPGoeSlzBTGu6VHK9pglx5NPKtnns5J3EZ0UB/OV
	A4hEBKfrkSRhnKm3yprd5vqOJuUVua+0QUY+yJO76LWyMA2sMOR7HAv2DcEQENI3vjLsh+i7WQqnO
	Xv/7HpHg==;
Received: from 17.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.17] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qosyR-0001kR-7I; Sat, 07 Oct 2023 00:07:07 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: lmb@isovalent.com,
	martin.lau@kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 5/7] selftests/bpf: Adapt assert_mprog_count to always expect 0 count
Date: Sat,  7 Oct 2023 00:06:53 +0200
Message-Id: <20231006220655.1653-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231006220655.1653-1-daniel@iogearbox.net>
References: <20231006220655.1653-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27053/Fri Oct  6 09:44:40 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Simplify __assert_mprog_count() to remove the -ENOENT corner case as the
bpf_prog_query() now returns 0 when no bpf_mprog is attached. This also
allows to convert a few test cases from using raw __assert_mprog_count()
over to plain assert_mprog_count() helper.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/bpf/prog_tests/tc_helpers.h | 11 ++++-------
 tools/testing/selftests/bpf/prog_tests/tc_links.c   |  2 +-
 tools/testing/selftests/bpf/prog_tests/tc_opts.c    |  6 +++---
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_helpers.h b/tools/testing/selftests/bpf/prog_tests/tc_helpers.h
index 6c93215be8a3..c88dce27a958 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/tc_helpers.h
@@ -45,7 +45,7 @@ static inline __u32 ifindex_from_link_fd(int fd)
 	return link_info.tcx.ifindex;
 }
 
-static inline void __assert_mprog_count(int target, int expected, bool miniq, int ifindex)
+static inline void __assert_mprog_count(int target, int expected, int ifindex)
 {
 	__u32 count = 0, attach_flags = 0;
 	int err;
@@ -53,20 +53,17 @@ static inline void __assert_mprog_count(int target, int expected, bool miniq, in
 	err = bpf_prog_query(ifindex, target, 0, &attach_flags,
 			     NULL, &count);
 	ASSERT_EQ(count, expected, "count");
-	if (!expected && !miniq)
-		ASSERT_EQ(err, -ENOENT, "prog_query");
-	else
-		ASSERT_EQ(err, 0, "prog_query");
+	ASSERT_EQ(err, 0, "prog_query");
 }
 
 static inline void assert_mprog_count(int target, int expected)
 {
-	__assert_mprog_count(target, expected, false, loopback);
+	__assert_mprog_count(target, expected, loopback);
 }
 
 static inline void assert_mprog_count_ifindex(int ifindex, int target, int expected)
 {
-	__assert_mprog_count(target, expected, false, ifindex);
+	__assert_mprog_count(target, expected, ifindex);
 }
 
 #endif /* TC_HELPERS */
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_links.c b/tools/testing/selftests/bpf/prog_tests/tc_links.c
index 74fc1fe9ee26..073fbdbea968 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_links.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_links.c
@@ -1667,7 +1667,7 @@ static void test_tc_chain_mixed(int target)
 	if (!ASSERT_OK(err, "prog_detach"))
 		goto cleanup;
 
-	__assert_mprog_count(target, 0, true, loopback);
+	assert_mprog_count(target, 0);
 
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_opts.c b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
index aeec10bb3396..2174bea3427e 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
@@ -635,7 +635,7 @@ static void test_tc_chain_classic(int target, bool chain_tc_old)
 	if (!ASSERT_OK(err, "prog_detach"))
 		goto cleanup;
 
-	__assert_mprog_count(target, 0, chain_tc_old, loopback);
+	assert_mprog_count(target, 0);
 cleanup:
 	if (tc_attached) {
 		tc_opts.flags = tc_opts.prog_fd = tc_opts.prog_id = 0;
@@ -2250,7 +2250,7 @@ static void test_tc_opts_delete_empty(int target, bool chain_tc_old)
 				       BPF_TC_INGRESS : BPF_TC_EGRESS;
 		err = bpf_tc_hook_create(&tc_hook);
 		ASSERT_OK(err, "bpf_tc_hook_create");
-		__assert_mprog_count(target, 0, true, loopback);
+		assert_mprog_count(target, 0);
 	}
 	err = bpf_prog_detach_opts(0, loopback, target, &optd);
 	ASSERT_EQ(err, -ENOENT, "prog_detach");
@@ -2352,7 +2352,7 @@ static void test_tc_chain_mixed(int target)
 cleanup_opts:
 	err = bpf_prog_detach_opts(detach_fd, loopback, target, &optd);
 	ASSERT_OK(err, "prog_detach");
-	__assert_mprog_count(target, 0, true, loopback);
+	assert_mprog_count(target, 0);
 
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
-- 
2.34.1


