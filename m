Return-Path: <bpf+bounces-9184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C71B7917BD
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 15:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B3A1C2088E
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 13:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E025AD5F;
	Mon,  4 Sep 2023 13:05:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37872442D
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 13:05:09 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60D35F9;
	Mon,  4 Sep 2023 06:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6LzN0
	UAzG8+m6OJmo1SPcFqvwr26rP6o6hRn4fJfRcE=; b=NpELvzQhnCb13V2aXZBMv
	vu5J4x4IMD6m0XZuY5pK3qOMpxcoT/xhVu5tAODQ7wjtcd1jCnrWdXrawV1TZ3jN
	1GZ7NRQTf1ioZRgni8MNMfBpAIcvNYhhe+E5ocDl8neRk0uROpZh2qK4vCJyYILR
	WAkTdnZqkDsPYENwT2cc/w=
Received: from localhost.localdomain (unknown [111.35.184.199])
	by zwqz-smtp-mta-g1-1 (Coremail) with SMTP id _____wAna3zK1fVk4xioBA--.12532S4;
	Mon, 04 Sep 2023 21:04:29 +0800 (CST)
From: David Wang <00107082@163.com>
To: 
Cc: David Wang <00107082@163.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] uapi/netfilter: Change netfilter hook verdict code definition from macro to enum
Date: Mon,  4 Sep 2023 21:02:02 +0800
Message-Id: <20230904130201.14632-1-00107082@163.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAna3zK1fVk4xioBA--.12532S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF1rXw4ktFW5Zry3KFW5GFg_yoW8WrWUpF
	9xCasIyr18WFW3C34vyw1S9F13Jws3AF17ury29ryUWF1rJw4vg3yY9r45t3Z3WrZ2yayj
	qF1jqw1UC34DZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi1xRfUUUUU=
X-Originating-IP: [111.35.184.199]
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiOwHgqmC5nH6kMwAAsc
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
	RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As BPF_PROG_TYPE_NETFILTER was added in 6.4, a netfilter
bpf program can attach to netfilter hooks, process package
and return verdict back to netfilter. But those verdict
codes are defined as macro, which could not be compiled
into BTF with btf.c. libbpf, and maybe other bpf tools,
would extract information from BTF and generate a
common header "vmlinux.h". With macro definition, netfilter
bpf program would have to redefine those macro again,
besides including "vmlinux.h".

This code change netfilter hook verdict code definition to
enum, this way,  make it into BTF.

Signed-off-by: David Wang <00107082@163.com>
---
 include/uapi/linux/netfilter.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/netfilter.h b/include/uapi/linux/netfilter.h
index 5a79ccb76701..d2f5dfab20dc 100644
--- a/include/uapi/linux/netfilter.h
+++ b/include/uapi/linux/netfilter.h
@@ -8,13 +8,15 @@
 #include <linux/in6.h>
 
 /* Responses from hook functions. */
-#define NF_DROP 0
-#define NF_ACCEPT 1
-#define NF_STOLEN 2
-#define NF_QUEUE 3
-#define NF_REPEAT 4
-#define NF_STOP 5	/* Deprecated, for userspace nf_queue compatibility. */
-#define NF_MAX_VERDICT NF_STOP
+enum {
+	NF_DROP        = 0,
+	NF_ACCEPT      = 1,
+	NF_STOLEN      = 2,
+	NF_QUEUE       = 3,
+	NF_REPEAT      = 4,
+	NF_STOP        = 5,	/* Deprecated, for userspace nf_queue compatibility. */
+	NF_MAX_VERDICT = NF_STOP,
+};
 
 /* we overload the higher bits for encoding auxiliary data such as the queue
  * number or errno values. Not nice, but better than additional function
-- 
2.20.1


