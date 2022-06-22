Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC94955540A
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 21:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355550AbiFVTMw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 15:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiFVTMu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 15:12:50 -0400
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D30218B23
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 12:12:49 -0700 (PDT)
Received: from SPMA-03.tubit.win.tu-berlin.de (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 81CA86E522_2B369AFB;
        Wed, 22 Jun 2022 19:12:47 +0000 (GMT)
Received: from mail.tu-berlin.de (mail.tu-berlin.de [141.23.12.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "exchange.tu-berlin.de", Issuer "DFN-Verein Global Issuing CA" (verified OK))
        by SPMA-03.tubit.win.tu-berlin.de (Sophos Email Appliance) with ESMTPS id 3F83072BE1_2B369AFF;
        Wed, 22 Jun 2022 19:12:47 +0000 (GMT)
Received: from jt.fritz.box (77.191.241.175) by ex-04.svc.tu-berlin.de
 (10.150.18.8) with Microsoft SMTP Server id 15.2.986.22; Wed, 22 Jun 2022
 21:12:46 +0200
From:   =?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <jthinz@mailbox.tu-berlin.de>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        =?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <jthinz@mailbox.tu-berlin.de>
Subject: [PATCH bpf-next v4 1/5] bpf: Allow a TCP CC to write sk_pacing_rate and sk_pacing_status
Date:   Wed, 22 Jun 2022 21:12:23 +0200
Message-ID: <20220622191227.898118-2-jthinz@mailbox.tu-berlin.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220622191227.898118-1-jthinz@mailbox.tu-berlin.de>
References: <20220622191227.898118-1-jthinz@mailbox.tu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-SASI-RCODE: 200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=campus.tu-berlin.de; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim-tub; bh=EM0k8Ro8pAC74vcjLR9yR3JpL6km1wzvS9zKe2hd4Mk=; b=I5BPPHxf9lISnb3ZKPP8hHXLJb6Tih9r6Cx2XViP+MSrLMcGp5DwUL4FMHfJvSQ1d9JJC8UNXCix7IyU4Npzbrv/cJLamcJCUyPYEo9XQ1mWzq29fMMPwPw3gwvGMMeqRaWJxpSR2AOOoF4S8EIdDqUBc9PQjYMltoFtUtDu3XE=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A CC that implements tcp_congestion_ops.cong_control() should be able to
control sk_pacing_rate and set sk_pacing_status, since
tcp_update_pacing_rate() is never called in this case. A built-in CC or
one from a kernel module is already able to write to both struct sock
members. For a BPF program, write access has not been allowed, yet.

Signed-off-by: Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>
Reviewed-by: Martin KaFai Lau <kafai@fb.com>
---
 net/ipv4/bpf_tcp_ca.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index f79ab942f03b..1f5c53ede4e5 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -111,6 +111,12 @@ static int bpf_tcp_ca_btf_struct_access(struct bpf_verifier_log *log,
 	}
 
 	switch (off) {
+	case offsetof(struct sock, sk_pacing_rate):
+		end = offsetofend(struct sock, sk_pacing_rate);
+		break;
+	case offsetof(struct sock, sk_pacing_status):
+		end = offsetofend(struct sock, sk_pacing_status);
+		break;
 	case bpf_ctx_range(struct inet_connection_sock, icsk_ca_priv):
 		end = offsetofend(struct inet_connection_sock, icsk_ca_priv);
 		break;
-- 
2.30.2

