Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8A354FA4F
	for <lists+bpf@lfdr.de>; Fri, 17 Jun 2022 17:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382628AbiFQPbH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jun 2022 11:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbiFQPbF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jun 2022 11:31:05 -0400
X-Greylist: delayed 581 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Jun 2022 08:31:04 PDT
Received: from sym2.noone.org (sym.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CF43BA44
        for <bpf@vger.kernel.org>; Fri, 17 Jun 2022 08:31:04 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4LPjS174jhzvjfp; Fri, 17 Jun 2022 17:21:21 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH] bpf: fix bpf_skc_lookup comment wrt. return type
Date:   Fri, 17 Jun 2022 17:21:21 +0200
Message-Id: <20220617152121.29617-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The function no longer returns 'unsigned long' as of commit edbf8c01de5a
("bpf: add skc_lookup_tcp helper").

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 net/core/filter.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 5af58eb48587..89cb007b6a09 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6463,8 +6463,6 @@ static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
 
 /* bpf_skc_lookup performs the core lookup for different types of sockets,
  * taking a reference on the socket if it doesn't have the flag SOCK_RCU_FREE.
- * Returns the socket as an 'unsigned long' to simplify the casting in the
- * callers to satisfy BPF_CALL declarations.
  */
 static struct sock *
 __bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
-- 
2.36.1

