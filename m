Return-Path: <bpf+bounces-6189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69390766B0A
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 12:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7F61C202DC
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 10:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E73A125BD;
	Fri, 28 Jul 2023 10:50:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42D5D304;
	Fri, 28 Jul 2023 10:50:57 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B9619B6;
	Fri, 28 Jul 2023 03:50:55 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RC3tV51msz4f3s5y;
	Fri, 28 Jul 2023 18:35:14 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP3 (Coremail) with SMTP id _Ch0CgB3ZhTkmcNkGK7LNw--.62551S2;
	Fri, 28 Jul 2023 18:35:17 +0800 (CST)
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
Subject: [PATCH bpf] bpf, sockmap: Fix map type error in sock_map_del_link
Date: Fri, 28 Jul 2023 06:56:49 -0400
Message-Id: <20230728105649.3978774-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3ZhTkmcNkGK7LNw--.62551S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy3JryrCr4xWr13JF1UWrg_yoW8XrWDp3
	WF9FySg3y7Arn7Z39YqF129r1rWF1Fq3Wj9F1rKa4fKrnrKr1rKFW8Ga4Syr1FvFZ3Wrsx
	XrWjgr13u39rX3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
	Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
	daVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Xu Kuohai <xukuohai@huawei.com>

sock_map_del_link() operates on both SOCKMAP and SOCKHASH, although
both types have member named "progs", the offset of "progs" member in
these two types is different, so "progs" should be accessed with the
real map type.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 net/core/sock_map.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 19538d628714..936c5cabe9f3 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -148,13 +148,13 @@ static void sock_map_del_link(struct sock *sk,
 	list_for_each_entry_safe(link, tmp, &psock->link, list) {
 		if (link->link_raw == link_raw) {
 			struct bpf_map *map = link->map;
-			struct bpf_stab *stab = container_of(map, struct bpf_stab,
-							     map);
-			if (psock->saved_data_ready && stab->progs.stream_parser)
+			struct sk_psock_progs *progs = sock_map_progs(map);
+
+			if (psock->saved_data_ready && progs->stream_parser)
 				strp_stop = true;
-			if (psock->saved_data_ready && stab->progs.stream_verdict)
+			if (psock->saved_data_ready && progs->stream_verdict)
 				verdict_stop = true;
-			if (psock->saved_data_ready && stab->progs.skb_verdict)
+			if (psock->saved_data_ready && progs->skb_verdict)
 				verdict_stop = true;
 			list_del(&link->list);
 			sk_psock_free_link(link);
-- 
2.30.2


