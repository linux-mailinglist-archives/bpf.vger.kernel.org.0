Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6F52FA87C
	for <lists+bpf@lfdr.de>; Mon, 18 Jan 2021 19:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407049AbhARSP0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jan 2021 13:15:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42527 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406792AbhARQ4T (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 18 Jan 2021 11:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610988888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iFs5YuS+UQBHxuk28XB6kdJ0sgDe9yXGAPFUS7xIqxM=;
        b=LcWQ+9lbbLR3kasanGN1elRGbvg11bx9I64MbNnRGKHiYqUJRTun3cit8y9wSDkstOL7O4
        E+ZZzIdieIcpTVQwXqOzIScoZDSk+9TJkO2fJj29dUkw7h4y9MrSNmgS1b3hwKrFlWY6a7
        bs57u7gZCiJxulwKV/Ibg8365eiE0NI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-nHr7iIsSNrG8xWFYhYaiYw-1; Mon, 18 Jan 2021 11:54:46 -0500
X-MC-Unique: nHr7iIsSNrG8xWFYhYaiYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CFF9190A7A2;
        Mon, 18 Jan 2021 16:54:44 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 749925D72E;
        Mon, 18 Jan 2021 16:54:41 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 655203223348F;
        Mon, 18 Jan 2021 17:54:40 +0100 (CET)
Subject: [PATCH bpf-next V12 6/7] selftests/bpf: use bpf_check_mtu in selftest
 test_cls_redirect
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        maze@google.com, lmb@cloudflare.com, shaun@tigera.io,
        Lorenzo Bianconi <lorenzo@kernel.org>, marek@cloudflare.com,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, eyal.birger@gmail.com,
        colrack@gmail.com
Date:   Mon, 18 Jan 2021 17:54:40 +0100
Message-ID: <161098888035.108067.6294974567375662017.stgit@firesoul>
In-Reply-To: <161098881526.108067.7603213364270807261.stgit@firesoul>
References: <161098881526.108067.7603213364270807261.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This demonstrate how bpf_check_mtu() helper can easily be used together
with bpf_skb_adjust_room() helper, prior to doing size adjustment, as
delta argument is already setup.

Hint: This specific test can be selected like this:
 ./test_progs -t cls_redirect

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 .../selftests/bpf/progs/test_cls_redirect.c        |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.c b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
index c9f8464996ea..3c1e042962e6 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect.c
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
@@ -70,6 +70,7 @@ typedef struct {
 	uint64_t errors_total_encap_adjust_failed;
 	uint64_t errors_total_encap_buffer_too_small;
 	uint64_t errors_total_redirect_loop;
+	uint64_t errors_total_encap_mtu_violate;
 } metrics_t;
 
 typedef enum {
@@ -407,6 +408,7 @@ static INLINING ret_t forward_with_gre(struct __sk_buff *skb, encap_headers_t *e
 		payload_off - sizeof(struct ethhdr) - sizeof(struct iphdr);
 	int32_t delta = sizeof(struct gre_base_hdr) - encap_overhead;
 	uint16_t proto = ETH_P_IP;
+	uint32_t mtu_len = 0;
 
 	/* Loop protection: the inner packet's TTL is decremented as a safeguard
 	 * against any forwarding loop. As the only interesting field is the TTL
@@ -479,6 +481,11 @@ static INLINING ret_t forward_with_gre(struct __sk_buff *skb, encap_headers_t *e
 		}
 	}
 
+	if (bpf_check_mtu(skb, skb->ifindex, &mtu_len, delta, 0)) {
+		metrics->errors_total_encap_mtu_violate++;
+		return TC_ACT_SHOT;
+	}
+
 	if (bpf_skb_adjust_room(skb, delta, BPF_ADJ_ROOM_NET,
 				BPF_F_ADJ_ROOM_FIXED_GSO |
 				BPF_F_ADJ_ROOM_NO_CSUM_RESET) ||


