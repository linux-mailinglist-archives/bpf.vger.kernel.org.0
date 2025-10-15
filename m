Return-Path: <bpf+bounces-70962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB0ABDC0E6
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 03:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB8319A2BAF
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 01:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D97D3090CB;
	Wed, 15 Oct 2025 01:51:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8AA308F26;
	Wed, 15 Oct 2025 01:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493090; cv=none; b=OLjeGMcDg7wNJGl7sdh8wi7vmhs4d+hD4yonTJDyK4Ay1NATANctt2WicsCwVA1Hu+i/aguHpJio3AFsNgVFkbt6TXOmmd/Zw5vRVmsxUsk89SMNUNASCLiPXvq2zSFKLc16Zy/UqU9BHLdshhMFVCf4Q8Pr3MtDUGfMW8WVnS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493090; c=relaxed/simple;
	bh=rFwCqzQTLiU/uOXOqo0/NGD9Qs3i0/V+TxtzJ9f05OA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EgW5VKYmYWaEqSNxklEZah6dqSaGwj39hJm9UySEy7kdX3S0vbfhiD0ap9zDGHDb+x+T6Vy3s0VnDxkfm3Dqv2bWr+FaIXpau0t2zD4MzTVx9JBxhMfrfzHP4Ndyr8umZ2XIxpojKxhLBAQjpCmi2Iiu41i1xRZH8luqdUuTag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201615.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202510150951143115;
        Wed, 15 Oct 2025 09:51:14 +0800
Received: from jtjnmailAR01.home.langchao.com (10.100.2.42) by
 Jtjnmail201615.home.langchao.com (10.100.2.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 15 Oct 2025 09:51:12 +0800
Received: from inspur.com (10.100.2.108) by jtjnmailAR01.home.langchao.com
 (10.100.2.42) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 15 Oct 2025 09:51:12 +0800
Received: from localhost.localdomain.com (unknown [10.94.16.205])
	by app4 (Coremail) with SMTP id bAJkCsDwybQO_u5o8rwJAA--.1663S5;
	Wed, 15 Oct 2025 09:51:12 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@fomichev.me>, <haoluo@google.com>, <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chu Guangqing
	<chuguangqing@inspur.com>
Subject: [PATCH v3 1/1] samples/bpf: Fix spelling typo in samples/bpf
Date: Wed, 15 Oct 2025 09:50:24 +0800
Message-ID: <20251015015024.2212-2-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251015015024.2212-1-chuguangqing@inspur.com>
References: <20251015015024.2212-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: bAJkCsDwybQO_u5o8rwJAA--.1663S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4rGF17Xw4UJw1fKrW3Jrb_yoW5CFW5pF
	WkW343tr1Fvry3WF9rXay8Ww1av3s5WFy7JF4FqryfJ3ZIgF95JrW3tFyYqrs8trW3Za9I
	vF4qk345W3WrW37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE3s1l84
	ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I2
	62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
	AFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
	0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI
	1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_
	Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU8XdbUUUUU
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?dkyjQZRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KWAwL8U5dyr1fkifcC2mKowIlzJi/LbWIEZLlrl94anxLMUtIcfI5+ZXyQtcyso7qgZv
	QT+yZWdHj3JddvZ8RS0=
Content-Type: text/plain
tUid: 202510150951158fd4b44b6bb3dcd184a09b3328be24ef
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

do_hbm_test.sh:
The comment incorrectly used "upcomming" instead of "upcoming".

hbm.c
The comment incorrectly used "Managment" instead of "Management".
The comment incorrectly used "Currrently" instead of "Currently".

tcp_cong_kern.c
The comment incorrectly used "deteremined" instead of "determined".

tracex1.bpf.c
The comment incorrectly used "loobpack" instead of "loopback".

Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
---
 samples/bpf/do_hbm_test.sh  | 2 +-
 samples/bpf/hbm.c           | 4 ++--
 samples/bpf/tcp_cong_kern.c | 2 +-
 samples/bpf/tracex1.bpf.c   | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/samples/bpf/do_hbm_test.sh b/samples/bpf/do_hbm_test.sh
index 38e4599350db..7f4f722787d5 100755
--- a/samples/bpf/do_hbm_test.sh
+++ b/samples/bpf/do_hbm_test.sh
@@ -112,7 +112,7 @@ function start_hbm () {
 processArgs () {
   for i in $args ; do
     case $i in
-    # Support for upcomming ingress rate limiting
+    # Support for upcoming ingress rate limiting
     #in)         # support for upcoming ingress rate limiting
     #  dir="-i"
     #  dir_name="in"
diff --git a/samples/bpf/hbm.c b/samples/bpf/hbm.c
index bf66277115e2..fc88d4dbdf48 100644
--- a/samples/bpf/hbm.c
+++ b/samples/bpf/hbm.c
@@ -5,7 +5,7 @@
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
  *
- * Example program for Host Bandwidth Managment
+ * Example program for Host Bandwidth Management
  *
  * This program loads a cgroup skb BPF program to enforce cgroup output
  * (egress) or input (ingress) bandwidth limits.
@@ -24,7 +24,7 @@
  *		beyond the rate limit specified while there is available
  *		bandwidth. Current implementation assumes there is only
  *		NIC (eth0), but can be extended to support multiple NICs.
- *		Currrently only supported for egress.
+ *		Currently only supported for egress.
  *    -h	Print this info
  *    prog	BPF program file name. Name defaults to hbm_out_kern.o
  */
diff --git a/samples/bpf/tcp_cong_kern.c b/samples/bpf/tcp_cong_kern.c
index 2311fc9dde85..339415eac477 100644
--- a/samples/bpf/tcp_cong_kern.c
+++ b/samples/bpf/tcp_cong_kern.c
@@ -5,7 +5,7 @@
  * License as published by the Free Software Foundation.
  *
  * BPF program to set congestion control to dctcp when both hosts are
- * in the same datacenter (as deteremined by IPv6 prefix).
+ * in the same datacenter (as determined by IPv6 prefix).
  *
  * Use "bpftool cgroup attach $cg sock_ops $prog" to load this BPF program.
  */
diff --git a/samples/bpf/tracex1.bpf.c b/samples/bpf/tracex1.bpf.c
index 0ab39d76ff8f..ceedf0b1d479 100644
--- a/samples/bpf/tracex1.bpf.c
+++ b/samples/bpf/tracex1.bpf.c
@@ -20,7 +20,7 @@ SEC("kprobe.multi/__netif_receive_skb_core*")
 int bpf_prog1(struct pt_regs *ctx)
 {
 	/* attaches to kprobe __netif_receive_skb_core,
-	 * looks for packets on loobpack device and prints them
+	 * looks for packets on loopback device and prints them
 	 * (wildcard is used for avoiding symbol mismatch due to optimization)
 	 */
 	char devname[IFNAMSIZ];
-- 
2.43.7


