Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5788A59B36F
	for <lists+bpf@lfdr.de>; Sun, 21 Aug 2022 13:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiHULgG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Aug 2022 07:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiHULgF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Aug 2022 07:36:05 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3733618386
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 04:36:04 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b5so5785378wrr.5
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 04:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=TjEkirEwRULf0M9gpuyThDnBStTzoL3ecCcLN72VTeE=;
        b=fk2MgxXDadb3rj3zJ+gqZ2Ms/Xr8lwoESWmvE6jPU0z6xZpeuFIztzw5noR5bX9hbY
         e5ewGMoiV/vJ3Ik5fJ3WWS0C1KMAPdJ/YvSjnwShgaUjYpiIHoTfh/9GMuQvZ8aTk+/x
         OCV/3X3aIBNUqllJHINxtvv8bGhPK9VXL7tSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=TjEkirEwRULf0M9gpuyThDnBStTzoL3ecCcLN72VTeE=;
        b=1TSj1i5PrvWYsGwpqMX29R24Jh4VusRxFA7HPoWDr4dUMsewizPSoiOMz9Vb5IA8mh
         hLFNmrOExGaHxSCtBLtQU/b5bJuO9BJaIDDJbbpZDlEq45bGFOZ8CptbiVDdGZXyumkY
         A4fd4Odh/7KT26xCZrI8PHPorD08qPn+leICti9YYnBOLU1Wpkn9GnBDPMsPQxUgFx86
         VD2CWlEef8JCuwgtN7A1SMlgrduSzvmb4tUlkA75D5f0n85nznzc1F6opVQJztpGLIl2
         R5fWRCmfcJxCVj70IJnYqyhVCrVkuzulfN6EuciLx4jTPPH1l/YsUG7dW+xTfwuhiaGo
         pbng==
X-Gm-Message-State: ACgBeo2JBcVaw2x6085JRLgssAIDPmPjoTXPCEJiOxdcFueg1plwjce9
        L2li9LnbNrVkRf7m7BzIVRPz6p/FdhG+QW4UJVFH3trUcJi1POwkaRhlpzxNM+t7Ms8sPPQ1TMY
        OqZPvUDdJePeYGx/qmHJeEqpZysj+CmXL4b95vr2W/VCIRIqxvKoEBuA2H96FawCVsLuLlwP4
X-Google-Smtp-Source: AA6agR4USe1J/cxBmdA0BykymoP+IowmTBCOI/AJM/O8p6SXiIrgfgUpflbMTYc3qHqIlDjAjWxWZA==
X-Received: by 2002:adf:e68f:0:b0:225:337c:f710 with SMTP id r15-20020adfe68f000000b00225337cf710mr7022208wrm.555.1661081762411;
        Sun, 21 Aug 2022 04:36:02 -0700 (PDT)
Received: from blondie.home ([94.230.83.151])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c2cc800b003a6632fe925sm1067178wmc.13.2022.08.21.04.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 04:36:02 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH v2 bpf-next 4/4] selftests/bpf: test BPF_FLOW_DISSECTOR_CONTINUE
Date:   Sun, 21 Aug 2022 14:35:19 +0300
Message-Id: <20220821113519.116765-5-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220821113519.116765-1-shmulik.ladkani@gmail.com>
References: <20220821113519.116765-1-shmulik.ladkani@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The dissector program returns BPF_FLOW_DISSECTOR_CONTINUE (and avoids
setting skb->flow_keys or last_dissection map) in case it encounters
IP packets whose (outer) source address is 127.0.0.127.

Additional test is added to prog_tests/flow_dissector.c which sets
this address as test's pkk.iph.saddr, with the expected retval of
BPF_FLOW_DISSECTOR_CONTINUE.

Also, legacy test_flow_dissector.sh was similarly augmented.

Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
---
 .../selftests/bpf/prog_tests/flow_dissector.c | 21 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_flow.c  | 15 +++++++++++++
 .../selftests/bpf/test_flow_dissector.sh      |  8 +++++++
 3 files changed, 44 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 8fa3c454995e..7acca37a3d2b 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -8,6 +8,8 @@
 
 #include "bpf_flow.skel.h"
 
+#define FLOW_CONTINUE_SADDR 0x7f00007f /* 127.0.0.127 */
+
 #ifndef IP_MF
 #define IP_MF 0x2000
 #endif
@@ -400,6 +402,25 @@ struct test tests[] = {
 		.flags = BPF_FLOW_DISSECTOR_F_STOP_AT_ENCAP,
 		.retval = BPF_OK,
 	},
+	{
+		.name = "ipip-encap-dissector-continue",
+		.pkt.ipip = {
+			.eth.h_proto = __bpf_constant_htons(ETH_P_IP),
+			.iph.ihl = 5,
+			.iph.protocol = IPPROTO_IPIP,
+			.iph.tot_len = __bpf_constant_htons(MAGIC_BYTES),
+			.iph.saddr = __bpf_constant_htonl(FLOW_CONTINUE_SADDR),
+			.iph_inner.ihl = 5,
+			.iph_inner.protocol = IPPROTO_TCP,
+			.iph_inner.tot_len =
+				__bpf_constant_htons(MAGIC_BYTES) -
+				sizeof(struct iphdr),
+			.tcp.doff = 5,
+			.tcp.source = 99,
+			.tcp.dest = 9090,
+		},
+		.retval = BPF_FLOW_DISSECTOR_CONTINUE,
+	},
 };
 
 static int create_tap(const char *ifname)
diff --git a/tools/testing/selftests/bpf/progs/bpf_flow.c b/tools/testing/selftests/bpf/progs/bpf_flow.c
index f266c757b3df..a20c5ed5e454 100644
--- a/tools/testing/selftests/bpf/progs/bpf_flow.c
+++ b/tools/testing/selftests/bpf/progs/bpf_flow.c
@@ -22,6 +22,8 @@
 #define PROG(F) PROG_(F, _##F)
 #define PROG_(NUM, NAME) SEC("flow_dissector") int flow_dissector_##NUM
 
+#define FLOW_CONTINUE_SADDR 0x7f00007f /* 127.0.0.127 */
+
 /* These are the identifiers of the BPF programs that will be used in tail
  * calls. Name is limited to 16 characters, with the terminating character and
  * bpf_func_ above, we have only 6 to work with, anything after will be cropped.
@@ -143,6 +145,19 @@ int _dissect(struct __sk_buff *skb)
 {
 	struct bpf_flow_keys *keys = skb->flow_keys;
 
+	if (keys->n_proto == bpf_htons(ETH_P_IP)) {
+		/* IP traffic from FLOW_CONTINUE_SADDR falls-back to
+		 * standard dissector
+		 */
+		struct iphdr *iph, _iph;
+
+		iph = bpf_flow_dissect_get_header(skb, sizeof(*iph), &_iph);
+		if (iph && iph->ihl == 5 &&
+		    iph->saddr == bpf_htonl(FLOW_CONTINUE_SADDR)) {
+			return BPF_FLOW_DISSECTOR_CONTINUE;
+		}
+	}
+
 	return parse_eth_proto(skb, keys->n_proto);
 }
 
diff --git a/tools/testing/selftests/bpf/test_flow_dissector.sh b/tools/testing/selftests/bpf/test_flow_dissector.sh
index dbd91221727d..5303ce0c977b 100755
--- a/tools/testing/selftests/bpf/test_flow_dissector.sh
+++ b/tools/testing/selftests/bpf/test_flow_dissector.sh
@@ -115,6 +115,14 @@ tc filter add dev lo parent ffff: protocol ip pref 1337 flower ip_proto \
 # Send 10 IPv4/UDP packets from port 10. Filter should not drop any.
 ./test_flow_dissector -i 4 -f 10
 
+echo "Testing IPv4 from 127.0.0.127 (fallback to generic dissector)..."
+# Send 10 IPv4/UDP packets from port 8. Filter should not drop any.
+./test_flow_dissector -i 4 -S 127.0.0.127 -f 8
+# Send 10 IPv4/UDP packets from port 9. Filter should drop all.
+./test_flow_dissector -i 4 -S 127.0.0.127 -f 9 -F
+# Send 10 IPv4/UDP packets from port 10. Filter should not drop any.
+./test_flow_dissector -i 4 -S 127.0.0.127 -f 10
+
 echo "Testing IPIP..."
 # Send 10 IPv4/IPv4/UDP packets from port 8. Filter should not drop any.
 ./with_addr.sh ./with_tunnels.sh ./test_flow_dissector -o 4 -e bare -i 4 \
-- 
2.37.2

