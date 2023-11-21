Return-Path: <bpf+bounces-15513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092E17F2B9C
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 12:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DCEFB21B00
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 11:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5935948794;
	Tue, 21 Nov 2023 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from wangsu.com (unknown [180.101.34.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 502179C;
	Tue, 21 Nov 2023 03:22:31 -0800 (PST)
Received: from 102.wangsu.com (unknown [59.61.78.234])
	by app2 (Coremail) with SMTP id SyJltAAXHQnxklxl4VxoAA--.27190S2;
	Tue, 21 Nov 2023 19:22:25 +0800 (CST)
From: Pengcheng Yang <yangpc@wangsu.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Pengcheng Yang <yangpc@wangsu.com>
Subject: [PATCH bpf-next v2 0/3] skmsg: Add the data length in skmsg to SIOCINQ ioctl and rx_queue
Date: Tue, 21 Nov 2023 19:22:02 +0800
Message-Id: <1700565725-2706-1-git-send-email-yangpc@wangsu.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID:SyJltAAXHQnxklxl4VxoAA--.27190S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKw13Gw4UKw4DXry3Jw47Jwb_yoW3tFg_u3
	4vqryFkw1xXFyfWFZ7JFWYvFW5Kr4qyw1rKF12qr9rKrWFyFy5Jwn5Jwn8Cw1DAF12kFs5
	Wrn5ur1ktr129jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r1j6r4UMcIj6x8ErcxFaVAv
	8VW8GwAv7VCY1x0262k0Y48FwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4kMxAIw28IcxkI
	7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
	6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0J
	UNtxhUUUUU=
X-CM-SenderInfo: p1dqw1nf6zt0xjvxhudrp/
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

When using skmsg redirect, the msg is queued in psock->ingress_msg,
and the application calling SIOCINQ ioctl will return a readable
length of 0, and we cannot track the data length of ingress_msg with
the ss tool.

In this patch set, we added the data length in ingress_msg to the 
SIOCINQ ioctl and the rx_queue of tcp_diag.

v2:
- Add READ_ONCE()/WRITE_ONCE() on accesses to psock->msg_len
- Mask out the increment msg_len where its not needed

Pengcheng Yang (3):
  skmsg: Support to get the data length in ingress_msg
  tcp: Add the data length in skmsg to SIOCINQ ioctl
  tcp_diag: Add the data length in skmsg to rx_queue

 include/linux/skmsg.h | 26 ++++++++++++++++++++++++--
 net/core/skmsg.c      | 10 +++++++++-
 net/ipv4/tcp.c        |  3 ++-
 net/ipv4/tcp_diag.c   |  2 ++
 4 files changed, 37 insertions(+), 4 deletions(-)

-- 
2.38.1


