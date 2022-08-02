Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B78587DB6
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 15:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbiHBN5Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 09:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237198AbiHBN5A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 09:57:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B7612A87
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 06:56:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82EF261453
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 13:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44696C433D6;
        Tue,  2 Aug 2022 13:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659448616;
        bh=UmD8kLeguZqaJD3rAmi39hg+OHxHJaWSP8j71gxstZw=;
        h=From:To:Cc:Subject:Date:From;
        b=JXJz9xohaElNbrGfOXVKG8TzkKhgFXqkU5CVcM/+IMgrIVA0w6S7g8eCtoiaaxri5
         Z/10gLgxdGMcVMrQH7kBa/NlC8SNxgqIhM+99xUQRSzXA7wz+kXHZ885di6aKiJbP2
         a0UD9qhp2be1cW+hpckPUylbJvKjqStZuWMyofsE62bnlo2FoG5/jPoJ/NY77lPQa6
         jc/TO4ILp7XLW4vR7uPbNoj0M836z6Bg4NCJJzmeug2Zs9lO+eD8I+uGbNcNdnMQvt
         09mWV+5jXBMEU/EoRwtYqOBWyw0pYQ/2UTj7HoTgL1sl9MS6O6KeGi9lMZMoCXnOtw
         ISwaAhWFZVrRQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH bpf] bpf: Cleanup ftrace hash in bpf_trampoline_put
Date:   Tue,  2 Aug 2022 15:56:51 +0200
Message-Id: <20220802135651.1794015-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We need to release possible hash from trampoline fops object
before removing it, otherwise we leak it.

Fixes: 00963a2e75a8 ("bpf: Support bpf_trampoline on functions with IPMODIFY (e.g. livepatch)")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/trampoline.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 0f532e6a717f..ff87e38af8a7 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -841,7 +841,10 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 	 * multiple rcu callbacks.
 	 */
 	hlist_del(&tr->hlist);
-	kfree(tr->fops);
+	if (tr->fops) {
+		ftrace_free_filter(tr->fops);
+		kfree(tr->fops);
+	}
 	kfree(tr);
 out:
 	mutex_unlock(&trampoline_mutex);
-- 
2.37.1

