Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C94B3C6E9E
	for <lists+bpf@lfdr.de>; Tue, 13 Jul 2021 12:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbhGMKfX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Jul 2021 06:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbhGMKfX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Jul 2021 06:35:23 -0400
X-Greylist: delayed 309 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Jul 2021 03:32:33 PDT
Received: from sym2.noone.org (sym2.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86FDC0613DD
        for <bpf@vger.kernel.org>; Tue, 13 Jul 2021 03:32:33 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4GPGzC5F2Rzvjfp; Tue, 13 Jul 2021 12:27:19 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Willem de Bruijn <willemb@google.com>
Subject: [PATCH bpf-next] selftests/bpf: remove unused variable in tc_tunnel prog
Date:   Tue, 13 Jul 2021 12:27:19 +0200
Message-Id: <20210713102719.8890-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The variable buf is unused since commit 005edd16562b ("selftests/bpf:
convert bpf tunnel test to BPF_ADJ_ROOM_MAC"). Remove it to fix the
following warning:

    test_tc_tunnel.c:531:7: warning: unused variable 'buf' [-Wunused-variable]

Fixes: 005edd16562b ("selftests/bpf: convert bpf tunnel test to BPF_ADJ_ROOM_MAC")
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
index 84cd63259554..a0e7762b1e5a 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
@@ -528,7 +528,6 @@ int __encap_ip6vxlan_eth(struct __sk_buff *skb)
 
 static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
 {
-	char buf[sizeof(struct v6hdr)];
 	struct gre_hdr greh;
 	struct udphdr udph;
 	int olen = len;
-- 
2.31.1

