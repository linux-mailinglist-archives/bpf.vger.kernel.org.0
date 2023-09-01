Return-Path: <bpf+bounces-9097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2693A78F761
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 05:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6157D1C20B2E
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 03:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC9C1C3E;
	Fri,  1 Sep 2023 03:11:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDD915A6;
	Fri,  1 Sep 2023 03:11:09 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ACBE7E;
	Thu, 31 Aug 2023 20:11:07 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RcNMm3yNMz4f3kFp;
	Fri,  1 Sep 2023 11:11:00 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP2 (Coremail) with SMTP id Syh0CgD3YWZGVvFkL2w6CA--.946S2;
	Fri, 01 Sep 2023 11:11:04 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: [PATCH bpf-next v2] selftests/bpf: fix a CI failure caused by vsock write
Date: Fri,  1 Sep 2023 11:10:37 +0800
Message-Id: <20230901031037.3314007-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD3YWZGVvFkL2w6CA--.946S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4fXFyrAF15ZF1rAFy3XFb_yoW5CFy7pa
	y0ywnxKrW0yFyaga1fCFs7WFWrCr4kXr45ArZ3XrnxZw1UGrs3Wr4Ig398JFnxGrZ5ZrWr
	Zw18Kr4kuw48G3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
	0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
v1->v2: initialize esize to sizeof(eval) to avoid getsockopt() reading
uninitialized value
---
 .../bpf/prog_tests/sockmap_helpers.h          | 29 +++++++++++++++++++
 .../selftests/bpf/prog_tests/sockmap_listen.c |  5 ++++
 2 files changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
index d12665490a90..abd13d96d392 100644
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
+	socklen_t esize = sizeof(eval);
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


