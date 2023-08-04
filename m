Return-Path: <bpf+bounces-6955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D9076FAF4
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 09:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186051C21789
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 07:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ED09465;
	Fri,  4 Aug 2023 07:16:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3AB9448;
	Fri,  4 Aug 2023 07:16:38 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B014735AA;
	Fri,  4 Aug 2023 00:16:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RHH810JvVz4f3nJj;
	Fri,  4 Aug 2023 15:16:33 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP2 (Coremail) with SMTP id Syh0CgAHF+jMpcxkm1vaPQ--.64994S5;
	Fri, 04 Aug 2023 15:16:34 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Cong Wang <cong.wang@bytedance.com>
Subject: [PATCH bpf v3 3/4] selftests/bpf: fix a CI failure caused by vsock sockmap test
Date: Fri,  4 Aug 2023 03:37:39 -0400
Message-Id: <20230804073740.194770-4-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230804073740.194770-1-xukuohai@huaweicloud.com>
References: <20230804073740.194770-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAHF+jMpcxkm1vaPQ--.64994S5
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy3XF18Jr48tryDZFy8uFg_yoW5JF4rpF
	W5trZ3tr10yryaqFs5CF1xGFy8C3yDXr1UJr1UXr13Zw1rGrs3GrZFgwsIvF9xJrZ5Za4F
	vw4vgrW7Z3ykGw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Xu Kuohai <xukuohai@huawei.com>

BPF CI has reported the following failure:

Error: #200/79 sockmap_listen/sockmap VSOCK test_vsock_redir
  Error: #200/79 sockmap_listen/sockmap VSOCK test_vsock_redir
  ./test_progs:vsock_unix_redir_connectible:1506: egress: write: Transport endpoint is not connected
  vsock_unix_redir_connectible:FAIL:1506
  ./test_progs:vsock_unix_redir_connectible:1506: ingress: write: Transport endpoint is not connected
  vsock_unix_redir_connectible:FAIL:1506
  ./test_progs:vsock_unix_redir_connectible:1506: egress: write: Transport endpoint is not connected
  vsock_unix_redir_connectible:FAIL:1506
  ./test_progs:vsock_unix_redir_connectible:1514: ingress: recv() err, errno=11
  vsock_unix_redir_connectible:FAIL:1514
  ./test_progs:vsock_unix_redir_connectible:1518: ingress: vsock socket map failed, a != b
  vsock_unix_redir_connectible:FAIL:1518
  ./test_progs:vsock_unix_redir_connectible:1525: ingress: want pass count 1, have 0

It’s because the recv(... MSG_DONTWAIT) syscall in the test case is
called before the queued work sk_psock_backlog() in the kernel finishes
executing. So the data to be read is still queued in psock->ingress_skb
and cannot be read by the user program. Therefore, the non-blocking
recv() reads nothing and reports an EAGAIN error.

So replace recv(... MSG_DONTWAIT) with xrecv_nonblock(), which calls
select() to wait for data to be readable or timeout before calls recv().

Fixes: d61bd8c1fd02 ("selftests/bpf: add a test case for vsock sockmap")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index b4f6f3a50ae5..ba35bcc66e7e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1432,7 +1432,7 @@ static void vsock_unix_redir_connectible(int sock_mapfd, int verd_mapfd,
 	if (n < 1)
 		goto out;
 
-	n = recv(mode == REDIR_INGRESS ? u0 : u1, &b, sizeof(b), MSG_DONTWAIT);
+	n = xrecv_nonblock(mode == REDIR_INGRESS ? u0 : u1, &b, sizeof(b), 0);
 	if (n < 0)
 		FAIL("%s: recv() err, errno=%d", log_prefix, errno);
 	if (n == 0)
-- 
2.30.2


