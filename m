Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1B255E639
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 18:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345768AbiF1QCx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 12:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348078AbiF1QCd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 12:02:33 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF09F37A36
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 09:01:57 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 8A8AD240113
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 18:01:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1656432116; bh=5gEzDaNK5hPWNZabN96C5EWb4OP8e5Ipy9t8T7bvCIc=;
        h=From:To:Cc:Subject:Date:From;
        b=RyieJiKFN1RZQGr9rwKZK1x1oczPXwM5gvAdwI2L4PS2h3UDVCK6RS5QK9iT23rlC
         LhihUzuYOySluLtJVY3TsyDQnHTy97P/HMkB5ma7Ntx9v/QD/9IPr9hmW1ENsWbrhy
         itg1QCyYAYR9dqB3R9znbaziFqNEW3zfbO5SOf7YGJWfwB33npPdx4ogMrO/fXT+2x
         BHyJJG43fT9n5ViHCWErIOVjT6D+X+i48aI8oP3fp1F+0C/LXlvIRkdwJzlmAloNRj
         fpTy8DosoAGlBumh2Iq9CPBif7rH2xHt3tZfxb7hn6evcLY3zEI0DF6pCRJBC18eiD
         VKIBaFvAReBlg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LXTql5mFxz6tmS;
        Tue, 28 Jun 2022 18:01:55 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     joannelkoong@gmail.com
Subject: [PATCH bpf-next v3 05/10] bpf: Add type match support
Date:   Tue, 28 Jun 2022 16:01:22 +0000
Message-Id: <20220628160127.607834-6-deso@posteo.net>
In-Reply-To: <20220628160127.607834-1-deso@posteo.net>
References: <20220628160127.607834-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change implements the kernel side of the "type matches" support,
just calling the previously added core logic in relo_core.c.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 kernel/bpf/btf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2e2066..8923b5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7442,6 +7442,15 @@ int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
 					   MAX_TYPES_ARE_COMPAT_DEPTH);
 }
 
+#define MAX_TYPES_MATCH_DEPTH 2
+
+int bpf_core_types_match(const struct btf *local_btf, u32 local_id,
+			 const struct btf *targ_btf, u32 targ_id)
+{
+	return __bpf_core_types_match(local_btf, local_id, targ_btf, targ_id, false,
+				      MAX_TYPES_MATCH_DEPTH);
+}
+
 static bool bpf_core_is_flavor_sep(const char *s)
 {
 	/* check X___Y name pattern, where X and Y are not underscores */
-- 
2.30.2

