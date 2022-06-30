Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE675614EE
	for <lists+bpf@lfdr.de>; Thu, 30 Jun 2022 10:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiF3I0p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 04:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbiF3I0Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 04:26:24 -0400
Received: from sym2.noone.org (sym.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE708DF18
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 01:26:22 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4LYWd73pmfzvjfm; Thu, 30 Jun 2022 10:26:18 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH bpf-next] bpf: omit superfluous address family check in __bpf_skc_lookup
Date:   Thu, 30 Jun 2022 10:26:18 +0200
Message-Id: <20220630082618.15649-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

family is only set to either AF_INET or AF_INET6 based on len. In all
other cases we return early. Thus the check against AF_UNSPEC can be
omitted.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 net/core/filter.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index c6941ab0eb52..4fae91984359 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6516,8 +6516,8 @@ __bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 		 u64 flags)
 {
 	struct sock *sk = NULL;
-	u8 family = AF_UNSPEC;
 	struct net *net;
+	u8 family;
 	int sdif;
 
 	if (len == sizeof(tuple->ipv4))
@@ -6527,8 +6527,7 @@ __bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 	else
 		return NULL;
 
-	if (unlikely(family == AF_UNSPEC || flags ||
-		     !((s32)netns_id < 0 || netns_id <= S32_MAX)))
+	if (unlikely(flags || !((s32)netns_id < 0 || netns_id <= S32_MAX)))
 		goto out;
 
 	if (family == AF_INET)
-- 
2.36.1

