Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E2F572298
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 20:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiGLS2T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 14:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiGLS2S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 14:28:18 -0400
X-Greylist: delayed 1695 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Jul 2022 11:28:16 PDT
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.6.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A5DBDB88
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 11:28:16 -0700 (PDT)
Received: from localhost.localdomain ([160.80.103.126])
        by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 26CHxCBu005871
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 Jul 2022 19:59:14 +0200
From:   Andrea Mayer <andrea.mayer@uniroma2.it>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        David Lebrun <david.lebrun@uclouvain.be>,
        Mathieu Xhonneux <m.xhonneux@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
        Anton Makarov <anton.makarov11235@gmail.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [net 3/3] seg6: bpf: fix skb checksum in bpf_push_seg6_encap()
Date:   Tue, 12 Jul 2022 19:58:37 +0200
Message-Id: <20220712175837.16267-4-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220712175837.16267-1-andrea.mayer@uniroma2.it>
References: <20220712175837.16267-1-andrea.mayer@uniroma2.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Both helper functions bpf_lwt_seg6_action() and bpf_lwt_push_encap() use
the bpf_push_seg6_encap() to encapsulate the packet in an IPv6 with Segment
Routing Header (SRH) or insert an SRH between the IPv6 header and the
payload.
To achieve this result, such helper functions rely on bpf_push_seg6_encap()
which, in turn, leverages seg6_do_srh_{encap,inline}() to perform the
required operation (i.e. encap/inline).

This patch removes the initialization of the IPv6 header payload length
from bpf_push_seg6_encap(), as it is now handled properly by
seg6_do_srh_{encap,inline}() to prevent corruption of the skb checksum.

Fixes: fe94cc290f53 ("bpf: Add IPv6 Segment Routing helpers")
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 net/core/filter.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 4ef77ec5255e..59aada9c4e19 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6204,7 +6204,6 @@ static int bpf_push_seg6_encap(struct sk_buff *skb, u32 type, void *hdr, u32 len
 	if (err)
 		return err;
 
-	ipv6_hdr(skb)->payload_len = htons(skb->len - sizeof(struct ipv6hdr));
 	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
 
 	return seg6_lookup_nexthop(skb, NULL, 0);
-- 
2.20.1

