Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7575755AF
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 21:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbiGNTQ5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 15:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiGNTQ4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 15:16:56 -0400
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5632DA88
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 12:16:56 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.156.149])
        by sinmsgout03.his.huawei.com (SkyGuard) with ESMTP id 4LkPN121Rgz9xGNy;
        Fri, 15 Jul 2022 03:15:45 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 21:16:48 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <john.fastabend@gmail.com>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <kpsingh@kernel.org>
CC:     <bpf@vger.kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v8 06/12] KEYS: Move KEY_LOOKUP_ to include/linux/key.h
Date:   Thu, 14 Jul 2022 21:14:49 +0200
Message-ID: <20220714191455.2101834-7-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714191455.2101834-1-roberto.sassu@huawei.com>
References: <20220714191455.2101834-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In preparation for the patch that introduces the bpf_lookup_user_key() eBPF
kfunc, move KEY_LOOKUP_ definitions to include/linux/key.h, to be able to
validate the kfunc parameters.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/key.h      | 3 +++
 security/keys/internal.h | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 7febc4881363..a297e075038c 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -88,6 +88,9 @@ enum key_need_perm {
 	KEY_DEFER_PERM_CHECK,	/* Special: permission check is deferred */
 };
 
+#define KEY_LOOKUP_CREATE	0x01
+#define KEY_LOOKUP_PARTIAL	0x02
+
 struct seq_file;
 struct user_struct;
 struct signal_struct;
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 9b9cf3b6fcbb..3c1e7122076b 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -165,8 +165,6 @@ extern struct key *request_key_and_link(struct key_type *type,
 
 extern bool lookup_user_key_possessed(const struct key *key,
 				      const struct key_match_data *match_data);
-#define KEY_LOOKUP_CREATE	0x01
-#define KEY_LOOKUP_PARTIAL	0x02
 
 extern long join_session_keyring(const char *name);
 extern void key_change_session_keyring(struct callback_head *twork);
-- 
2.25.1

