Return-Path: <bpf+bounces-3440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D01FE73E068
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 15:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF2E280D37
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 13:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325059455;
	Mon, 26 Jun 2023 13:19:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E399443
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 13:19:49 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F235121
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 06:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=oukI6vkJqTZGLgcv9vNkeAu5HO/ESgMOHhx18hBobQw=; b=VKQ7Xbf7NTumiailCYEewNxMd7
	P7XUjN7pRiTGVHschW9/O5D0oySA6ePok0rGdgpqfcF7hOk8Zlg0yD6ov7x2uE01yj2Sgiu20dSKx
	uQtXXHOaXL6yxkOtWH71GUpImS1uHgWEh7WsfrJt8ia0drXCyJ5rSU9d5QmL01TeWBXEuOQvaumy1
	n1zn2OJ4VA9dCrGqmgtFtIjWQyEEVXYPUkGP3W2NesHekZ9coyi4OafG5yFwxXSBTAsAOd97njlJx
	Ld8LF+2ieZvZWaT47wjAGfLlPTg+WAy7KtRM5VEN96wZXmbdtdQx9PTTggTFIrL4weodjkoAoYGbG
	mMJCipjQ==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qDm88-000NaL-G6; Mon, 26 Jun 2023 15:19:44 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix bpf_nf failure upon test rerun
Date: Mon, 26 Jun 2023 15:19:42 +0200
Message-Id: <20230626131942.5100-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26951/Mon Jun 26 09:29:31 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Alexei reported:

  After fast forwarding bpf-next today bpf_nf test started to fail when
  run twice:

  $ ./test_progs -t bpf_nf
  #17      bpf_nf:OK
  Summary: 1/10 PASSED, 0 SKIPPED, 0 FAILED

  $ ./test_progs -t bpf_nf
  All error logs:
  test_bpf_nf_ct:PASS:test_bpf_nf__open_and_load 0 nsec
  test_bpf_nf_ct:PASS:iptables-legacy -t raw -A PREROUTING -j CONNMARK
  --set-mark 42/0 0 nsec
  (network_helpers.c:102: errno: Address already in use) Failed to bind socket
  test_bpf_nf_ct:FAIL:start_server unexpected start_server: actual -1 < expected 0
  #17/1    bpf_nf/xdp-ct:FAIL
  test_bpf_nf_ct:PASS:test_bpf_nf__open_and_load 0 nsec
  test_bpf_nf_ct:PASS:iptables-legacy -t raw -A PREROUTING -j CONNMARK
  --set-mark 42/0 0 nsec
  (network_helpers.c:102: errno: Address already in use) Failed to bind socket
  test_bpf_nf_ct:FAIL:start_server unexpected start_server: actual -1 < expected 0
  #17/2    bpf_nf/tc-bpf-ct:FAIL
  #17      bpf_nf:FAIL
  Summary: 0/8 PASSED, 0 SKIPPED, 1 FAILED

I was able to locally reproduce as well. Rearrange the connection teardown
so that the client closes its connection first so that we don't need to
linger in TCP time-wait.

Fixes: e81fbd4c1ba7 ("selftests/bpf: Add existing connection bpf_*_ct_lookup() test")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/CAADnVQ+0dnDq_v_vH1EfkacbfGnHANaon7zsw10pMb-D9FS0Pw@mail.gmail.com
---
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
index c8ba4009e4ab..b30ff6b3b81a 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
@@ -123,12 +123,13 @@ static void test_bpf_nf_ct(int mode)
 	ASSERT_EQ(skel->data->test_snat_addr, 0, "Test for source natting");
 	ASSERT_EQ(skel->data->test_dnat_addr, 0, "Test for destination natting");
 end:
-	if (srv_client_fd != -1)
-		close(srv_client_fd);
 	if (client_fd != -1)
 		close(client_fd);
+	if (srv_client_fd != -1)
+		close(srv_client_fd);
 	if (srv_fd != -1)
 		close(srv_fd);
+
 	snprintf(cmd, sizeof(cmd), iptables, "-D");
 	system(cmd);
 	test_bpf_nf__destroy(skel);
-- 
2.34.1


