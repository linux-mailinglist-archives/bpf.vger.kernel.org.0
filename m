Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4465B2C6B50
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 19:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732673AbgK0SHF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Nov 2020 13:07:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35351 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732236AbgK0SHF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Nov 2020 13:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606500424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iFs5YuS+UQBHxuk28XB6kdJ0sgDe9yXGAPFUS7xIqxM=;
        b=ZnMPdeM3SRNO7L5uB+O1yw6MMFwzVE4jCFqD1TmCN7ElDRftrv1R2MXNekGgInojKhWNy0
        MBa6XJAKpGgcZQvk3qyql32XDHFmT1S0WFeCbJ49OKHiQ0/Pc51C01TcUXs59O+sEBfv91
        DZm696h50rq8bmTqi0jTfwYp9CPEkTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-WAl9gsxvPWyFtXc_jriLSA-1; Fri, 27 Nov 2020 13:06:59 -0500
X-MC-Unique: WAl9gsxvPWyFtXc_jriLSA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9194E80ED8A;
        Fri, 27 Nov 2020 18:06:57 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3643460BF1;
        Fri, 27 Nov 2020 18:06:54 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 220CF32138453;
        Fri, 27 Nov 2020 19:06:53 +0100 (CET)
Subject: [PATCH bpf-next V8 7/8] selftests/bpf: use bpf_check_mtu in selftest
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
Date:   Fri, 27 Nov 2020 19:06:53 +0100
Message-ID: <160650041308.2890576.12983001148622600086.stgit@firesoul>
In-Reply-To: <160650034591.2890576.1092952641487480652.stgit@firesoul>
References: <160650034591.2890576.1092952641487480652.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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


