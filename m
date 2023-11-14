Return-Path: <bpf+bounces-15053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CC77EAF62
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 12:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935E31C2074C
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 11:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A4A3C684;
	Tue, 14 Nov 2023 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F712E626;
	Tue, 14 Nov 2023 11:42:24 +0000 (UTC)
Received: from wangsu.com (unknown [180.101.34.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 793C5A7;
	Tue, 14 Nov 2023 03:42:22 -0800 (PST)
Received: from 102.wangsu.com (unknown [59.61.78.234])
	by app2 (Coremail) with SMTP id SyJltADX3QkZXVNlXr9cAA--.24900S2;
	Tue, 14 Nov 2023 19:42:18 +0800 (CST)
From: Pengcheng Yang <yangpc@wangsu.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Pengcheng Yang <yangpc@wangsu.com>
Subject: [PATCH bpf-next 0/3] skmsg: Add the data length in skmsg to SIOCINQ ioctl and rx_queue
Date: Tue, 14 Nov 2023 19:41:57 +0800
Message-Id: <1699962120-3390-1-git-send-email-yangpc@wangsu.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID:SyJltADX3QkZXVNlXr9cAA--.24900S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKw13Gw4UKw4DXry3Jw47Jwb_yoWxurX_ua
	4vgFW8uw1xXF1fWFZ7AFWjvFy5Kr4jvr1rJF12qr9FgrWYyF95GwnYy3s8Cw1DAF1SkFn5
	Wrn5ur1ktr1a9jkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07
	x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxVWUJVW8
	JwAv7VCjz48v1sIEY20_Gr4lYx0Ec7CjxVAajcxG14v26r4j6F4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK
	6r4kMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr4l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU7ZqWUUUUU
X-CM-SenderInfo: p1dqw1nf6zt0xjvxhudrp/
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

When using skmsg redirect, the msg is queued in psock->ingress_msg,
and the application calling SIOCINQ ioctl will return a readable
length of 0, and we cannot track the data length of ingress_msg from
the ss tool.

In this patch set, we added the data length in ingress_msg to the 
SIOCINQ ioctl and the rx_queue of tcp_diag.

Pengcheng Yang (3):
  skmsg: Calculate the data length in ingress_msg
  tcp: Add the data length in skmsg to SIOCINQ ioctl
  tcp_diag: Add the data length in skmsg to rx_queue

 include/linux/skmsg.h | 24 ++++++++++++++++++++++--
 net/core/skmsg.c      |  4 ++++
 net/ipv4/tcp.c        |  3 ++-
 net/ipv4/tcp_diag.c   |  2 ++
 4 files changed, 30 insertions(+), 3 deletions(-)

-- 
2.38.1


