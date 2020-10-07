Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C68285876
	for <lists+bpf@lfdr.de>; Wed,  7 Oct 2020 08:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgJGGGT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Oct 2020 02:06:19 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:45345 "EHLO
        smtpout1.mo804.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726138AbgJGGGT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Oct 2020 02:06:19 -0400
X-Greylist: delayed 537 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Oct 2020 02:06:18 EDT
Received: from mxplan6.mail.ovh.net (unknown [10.109.146.228])
        by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 2E8A06975581;
        Wed,  7 Oct 2020 07:57:20 +0200 (CEST)
Received: from jwilk.net (37.59.142.101) by DAG4EX2.mxp6.local (172.16.2.32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Wed, 7 Oct 2020
 07:57:18 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-101G004b1eb2ce0-8baf-4597-bf1b-ee644ad4aaa5,
                    210046763DD62EE8B7C8A4EF62C50FB0A57902B4) smtp.auth=jwilk@jwilk.net
From:   Jakub Wilk <jwilk@jwilk.net>
To:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     <linux-man@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Samanta Navarro <ferivoz@riseup.net>
Subject: [PATCH] bpf: Fix typo in uapi/linux/bpf.h
Date:   Wed, 7 Oct 2020 07:57:17 +0200
Message-ID: <20201007055717.7319-1-jwilk@jwilk.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG1EX1.mxp6.local (172.16.2.1) To DAG4EX2.mxp6.local
 (172.16.2.32)
X-Ovh-Tracer-GUID: c1d18d19-d613-4924-86e4-319cde4a1145
X-Ovh-Tracer-Id: 6394829998014715753
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrgeehgddutddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgtghisehtkeertdertddtnecuhfhrohhmpeflrghkuhgsucghihhlkhcuoehjfihilhhksehjfihilhhkrdhnvghtqeenucggtffrrghtthgvrhhnpedvheejjeffjeejvdekheehjeeilefhffdtudetfeehueekueeivdduheevheefhfenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnheirdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhifihhlkhesjhifihhlkhdrnhgvthdprhgtphhtthhopehfvghrihhvohiisehrihhsvghuphdrnhgvth
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Reported-by: Samanta Navarro <ferivoz@riseup.net>
Signed-off-by: Jakub Wilk <jwilk@jwilk.net>
---
 include/uapi/linux/bpf.h       | 2 +-
 tools/include/uapi/linux/bpf.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b6238b2209b7..4023d27b0951 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2204,7 +2204,7 @@ union bpf_attr {
  *	Description
  *		This helper is used in programs implementing policies at the
  *		skb socket level. If the sk_buff *skb* is allowed to pass (i.e.
- *		if the verdeict eBPF program returns **SK_PASS**), redirect it
+ *		if the verdict eBPF program returns **SK_PASS**), redirect it
  *		to the socket referenced by *map* (of type
  *		**BPF_MAP_TYPE_SOCKHASH**) using hash *key*. Both ingress and
  *		egress interfaces can be used for redirection. The
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b6238b2209b7..4023d27b0951 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2204,7 +2204,7 @@ union bpf_attr {
  *	Description
  *		This helper is used in programs implementing policies at the
  *		skb socket level. If the sk_buff *skb* is allowed to pass (i.e.
- *		if the verdeict eBPF program returns **SK_PASS**), redirect it
+ *		if the verdict eBPF program returns **SK_PASS**), redirect it
  *		to the socket referenced by *map* (of type
  *		**BPF_MAP_TYPE_SOCKHASH**) using hash *key*. Both ingress and
  *		egress interfaces can be used for redirection. The
-- 
2.28.0

