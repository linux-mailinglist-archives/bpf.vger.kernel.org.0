Return-Path: <bpf+bounces-6954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D2376FAEA
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 09:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D552824D0
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 07:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4224A8F52;
	Fri,  4 Aug 2023 07:16:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167518831;
	Fri,  4 Aug 2023 07:16:37 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2850D359E;
	Fri,  4 Aug 2023 00:16:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RHH801lnfz4f3n6n;
	Fri,  4 Aug 2023 15:16:32 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP2 (Coremail) with SMTP id Syh0CgAHF+jMpcxkm1vaPQ--.64994S4;
	Fri, 04 Aug 2023 15:16:33 +0800 (CST)
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
Subject: [PATCH bpf v3 2/4] bpf, sockmap: Fix bug that strp_done cannot be called
Date: Fri,  4 Aug 2023 03:37:38 -0400
Message-Id: <20230804073740.194770-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230804073740.194770-1-xukuohai@huaweicloud.com>
References: <20230804073740.194770-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAHF+jMpcxkm1vaPQ--.64994S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyxZr43KF18Jw4kAw43KFg_yoW8tFyxp3
	WkC3y3CF4UCFyxZ3Z3XFyIvw43Kw1kJFy2kryruw1ayr4qkr15JF98KF1jyFn8tr4xGFy7
	Jr4jgrsIk3W7X3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
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
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFa9-UUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Xu Kuohai <xukuohai@huawei.com>

strp_done is only called when psock->progs.stream_parser is not NULL,
but stream_parser was set to NULL by sk_psock_stop_strp(), called
by sk_psock_drop() earlier. So, strp_done can never be called.

Introduce SK_PSOCK_RX_ENABLED to mark whether there is strp on psock.
Change the condition for calling strp_done from judging whether
stream_parser is set to judging whether this flag is set. This flag is
only set once when strp_init() succeeds, and will never be cleared later.

Fixes: c0d95d3380ee ("bpf, sockmap: Re-evaluate proto ops when psock is removed from sockmap")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
---
 include/linux/skmsg.h |  1 +
 net/core/skmsg.c      | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 054d7911bfc9..c1637515a8a4 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -62,6 +62,7 @@ struct sk_psock_progs {
 
 enum sk_psock_state_bits {
 	SK_PSOCK_TX_ENABLED,
+	SK_PSOCK_RX_STRP_ENABLED,
 };
 
 struct sk_psock_link {
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index a29508e1ff35..ef1a2eb6520b 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1120,13 +1120,19 @@ static void sk_psock_strp_data_ready(struct sock *sk)
 
 int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
 {
+	int ret;
+
 	static const struct strp_callbacks cb = {
 		.rcv_msg	= sk_psock_strp_read,
 		.read_sock_done	= sk_psock_strp_read_done,
 		.parse_msg	= sk_psock_strp_parse,
 	};
 
-	return strp_init(&psock->strp, sk, &cb);
+	ret = strp_init(&psock->strp, sk, &cb);
+	if (!ret)
+		sk_psock_set_state(psock, SK_PSOCK_RX_STRP_ENABLED);
+
+	return ret;
 }
 
 void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock)
@@ -1154,7 +1160,7 @@ void sk_psock_stop_strp(struct sock *sk, struct sk_psock *psock)
 static void sk_psock_done_strp(struct sk_psock *psock)
 {
 	/* Parser has been stopped */
-	if (psock->progs.stream_parser)
+	if (sk_psock_test_state(psock, SK_PSOCK_RX_STRP_ENABLED))
 		strp_done(&psock->strp);
 }
 #else
-- 
2.30.2


