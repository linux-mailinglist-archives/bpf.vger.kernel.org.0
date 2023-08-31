Return-Path: <bpf+bounces-9019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C88178E457
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 03:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F8B281339
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 01:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B81F136C;
	Thu, 31 Aug 2023 01:31:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4A910E1;
	Thu, 31 Aug 2023 01:31:13 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB59CC2;
	Wed, 30 Aug 2023 18:31:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RbkBx37lkz4f3nqs;
	Thu, 31 Aug 2023 09:31:05 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgD3zJ9b7e9kT4X0Bw--.44897S2;
	Thu, 31 Aug 2023 09:31:08 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: [PATCH bpf-next] selftests/bpf: fix a CI failure caused by vsock write
Date: Thu, 31 Aug 2023 09:31:05 +0800
Message-Id: <20230831013105.2930824-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3zJ9b7e9kT4X0Bw--.44897S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4fXFyrAF15ZF1rAFy3XFb_yoW5AFyDpa
	yjy3sxKry0yFyagF4fCFs7WFWrCr4DXr4UArWxXr13Zw1UGrs3Gr4Ig398tFnxGrZ5ZrW5
	Zw18KrWkuw18Gw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
	Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
	daVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Xu Kuohai <xukuohai@huawei.com>

While commit 90f0074cd9f9 ("selftests/bpf: fix a CI failure caused by vsock sockmap test")
fixes a receive failure of vsock sockmap test, there is still a write failure:

Error: #211/79 sockmap_listen/sockmap VSOCK test_vsock_redir
Error: #211/79 sockmap_listen/sockmap VSOCK test_vsock_redir
  ./test_progs:vsock_unix_redir_connectible:1501: egress: write: Transport endpoint is not connected
  vsock_unix_redir_connectible:FAIL:1501
  ./test_progs:vsock_unix_redir_connectible:1501: ingress: write: Transport endpoint is not connected
  vsock_unix_redir_connectible:FAIL:1501
  ./test_progs:vsock_unix_redir_connectible:1501: egress: write: Transport endpoint is not connected
  vsock_unix_redir_connectible:FAIL:1501

The reason is that the vsock connection in the test is set to ESTABLISHED state
by function virtio_transport_recv_pkt, which is executed in a workqueue thread,
so when the user space test thread runs before the workqueue thread, this
problem occurs.

To fix it, before writing the connection, wait for it to be connected.

Fixes: d61bd8c1fd02 ("selftests/bpf: add a test case for vsock sockmap")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 .../bpf/prog_tests/sockmap_helpers.h          | 29 +++++++++++++++++++
 .../selftests/bpf/prog_tests/sockmap_listen.c |  5 ++++
 2 files changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
index d12665490a90..837dfb0361c6 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
@@ -179,6 +179,35 @@
 		__ret;                                                         \
 	})
 
+static inline int poll_connect(int fd, unsigned int timeout_sec)
+{
+	struct timeval timeout = { .tv_sec = timeout_sec };
+	fd_set wfds;
+	int r;
+	int eval;
+	socklen_t esize;
+
+	FD_ZERO(&wfds);
+	FD_SET(fd, &wfds);
+
+	r = select(fd + 1, NULL, &wfds, NULL, &timeout);
+	if (r == 0)
+		errno = ETIME;
+
+	if (r != 1)
+		return -1;
+
+	if (getsockopt(fd, SOL_SOCKET, SO_ERROR, &eval, &esize) < 0)
+		return -1;
+
+	if (eval != 0) {
+		errno = eval;
+		return -1;
+	}
+
+	return 0;
+}
+
 static inline int poll_read(int fd, unsigned int timeout_sec)
 {
 	struct timeval timeout = { .tv_sec = timeout_sec };
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 5674a9d0cacf..2d3bf38677b6 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1452,6 +1452,11 @@ static int vsock_socketpair_connectible(int sotype, int *v0, int *v1)
 	if (p < 0)
 		goto close_cli;
 
+	if (poll_connect(c, IO_TIMEOUT_SEC) < 0) {
+		FAIL_ERRNO("poll_connect");
+		goto close_cli;
+	}
+
 	*v0 = p;
 	*v1 = c;
 
-- 
2.30.2


