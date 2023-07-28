Return-Path: <bpf+bounces-6190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ED5766B10
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 12:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4773B2827FC
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 10:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A55125DB;
	Fri, 28 Jul 2023 10:50:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18480125B6;
	Fri, 28 Jul 2023 10:50:57 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E821FDA;
	Fri, 28 Jul 2023 03:50:55 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RC3ty5t5rz4f3nyP;
	Fri, 28 Jul 2023 18:35:38 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP2 (Coremail) with SMTP id Syh0CgDHp9X9mcNkeBG8Ow--.58627S2;
	Fri, 28 Jul 2023 18:35:41 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf] bpf, sockmap: Fix bug that strp_done cannot be called
Date: Fri, 28 Jul 2023 06:57:17 -0400
Message-Id: <20230728105717.3978849-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDHp9X9mcNkeBG8Ow--.58627S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyxZr43KF18Jw4kAw43KFg_yoW8uw4kp3
	WkC3y3CF4UCFWxZasxXF92yw1agw1DJFyjkryrZw13trnFkr15JF98KF1jyFn8tr4xGFy7
	Jr4jgrsxC3W7XwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Gr0_Zr
	1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
	vfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
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
---
 include/linux/skmsg.h |  1 +
 net/core/skmsg.c      | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 054d7911bfc9..959c5f4c4d19 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -62,6 +62,7 @@ struct sk_psock_progs {
 
 enum sk_psock_state_bits {
 	SK_PSOCK_TX_ENABLED,
+	SK_PSOCK_RX_ENABLED,
 };
 
 struct sk_psock_link {
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index a29508e1ff35..7c2764beeb04 100644
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
+		sk_psock_set_state(psock, SK_PSOCK_RX_ENABLED);
+
+	return ret;
 }
 
 void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock)
@@ -1154,7 +1160,7 @@ void sk_psock_stop_strp(struct sock *sk, struct sk_psock *psock)
 static void sk_psock_done_strp(struct sk_psock *psock)
 {
 	/* Parser has been stopped */
-	if (psock->progs.stream_parser)
+	if (sk_psock_test_state(psock, SK_PSOCK_RX_ENABLED))
 		strp_done(&psock->strp);
 }
 #else
-- 
2.30.2


