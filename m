Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6603C84A5
	for <lists+bpf@lfdr.de>; Wed, 14 Jul 2021 14:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhGNMtw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 08:49:52 -0400
Received: from smtp-fw-80007.amazon.com ([99.78.197.218]:7293 "EHLO
        smtp-fw-80007.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhGNMtv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Jul 2021 08:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1626266821; x=1657802821;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rssHyYGDL3QISy23HxtpYdf1togEl2MiZj23eym/eMM=;
  b=ohh35q5/vYfTE6sTmHQWLT03QYmSHE2y/ZTcnLS0doYBj9aG3v8qggD7
   rSUaolaaIaITg4rpGKb0gT/DeT7WLF79sP8jpsTgOH0xjdcXMx0FNZOsu
   WhGjfi30vcSQYw+1j8kZBy/63C64AYTk4SZcZ+/JxU0BcqtEXBORHf2EW
   s=;
X-IronPort-AV: E=Sophos;i="5.84,239,1620691200"; 
   d="scan'208";a="12001625"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP; 14 Jul 2021 12:44:01 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id 78A74A0502;
        Wed, 14 Jul 2021 12:43:59 +0000 (UTC)
Received: from EX13D04ANC001.ant.amazon.com (10.43.157.89) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Wed, 14 Jul 2021 12:43:58 +0000
Received: from 88665a182662.ant.amazon.com (10.43.161.175) by
 EX13D04ANC001.ant.amazon.com (10.43.157.89) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Wed, 14 Jul 2021 12:43:55 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.co.jp>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
CC:     Martin KaFai Lau <kafai@fb.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Kuniyuki Iwashima <kuni1840@gmail.com>, <bpf@vger.kernel.org>
Subject: [PATCH] bpf: Fix a typo of reuseport map in bpf.h.
Date:   Wed, 14 Jul 2021 21:43:17 +0900
Message-ID: <20210714124317.67526-1-kuniyu@amazon.co.jp>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.161.175]
X-ClientProxiedBy: EX13D32UWB002.ant.amazon.com (10.43.161.139) To
 EX13D04ANC001.ant.amazon.com (10.43.157.89)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix s/BPF_MAP_TYPE_REUSEPORT_ARRAY/BPF_MAP_TYPE_REUSEPORT_SOCKARRAY/ typo
in bpf.h.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
---
 include/uapi/linux/bpf.h       | 2 +-
 tools/include/uapi/linux/bpf.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b46a383e8db7..bafb6282032b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3246,7 +3246,7 @@ union bpf_attr {
  * long bpf_sk_select_reuseport(struct sk_reuseport_md *reuse, struct bpf_map *map, void *key, u64 flags)
  *	Description
  *		Select a **SO_REUSEPORT** socket from a
- *		**BPF_MAP_TYPE_REUSEPORT_ARRAY** *map*.
+ *		**BPF_MAP_TYPE_REUSEPORT_SOCKARRAY** *map*.
  *		It checks the selected socket is matching the incoming
  *		request in the socket buffer.
  *	Return
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index bf9252c7381e..5cdff1631608 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3249,7 +3249,7 @@ union bpf_attr {
  * long bpf_sk_select_reuseport(struct sk_reuseport_md *reuse, struct bpf_map *map, void *key, u64 flags)
  *	Description
  *		Select a **SO_REUSEPORT** socket from a
- *		**BPF_MAP_TYPE_REUSEPORT_ARRAY** *map*.
+ *		**BPF_MAP_TYPE_REUSEPORT_SOCKARRAY** *map*.
  *		It checks the selected socket is matching the incoming
  *		request in the socket buffer.
  *	Return
-- 
2.30.2

