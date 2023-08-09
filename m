Return-Path: <bpf+bounces-7357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEBE775FA0
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 14:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A2E1C2120F
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 12:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3726B1988B;
	Wed,  9 Aug 2023 12:44:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C45D18C38;
	Wed,  9 Aug 2023 12:44:37 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1621BDA;
	Wed,  9 Aug 2023 05:44:36 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe1b6192e8so18174645e9.1;
        Wed, 09 Aug 2023 05:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691585074; x=1692189874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5LGwYrDwcayojjQPJLrwM7i+6zcw7e3Fl0L8ybGHMc=;
        b=OPUavXAVE+eM91Y7eZQzbcEbLTBnfBX/uivXaqGyFuZ9H8swzUgK8i9cjRsFZ6LAO/
         QYdr+gRPt8wJfrTC043R5UxEzu1pslXrwl5qUh0KRz9MkhfqsvXcxOEf9E9gY8jEAnmC
         XevFeTe0Uac4XC/3EUM3JBBZB58RvSPekhgEXsR7t6OgPn22Pa74Ga6ETs4sAzNIpgdu
         crLKD1x58WlnEQLqxyKys6HpFv26KsJjhrhQhENpTV2k02al1Apr/pLDCIuFqEU4zIr8
         oMNzpNSSl9zWTGB/isIdcGONbe3EgGi+Mz5mH/sCaQMUg7rhqdY5Ez39Ycha0P5dx3D2
         h49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691585074; x=1692189874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5LGwYrDwcayojjQPJLrwM7i+6zcw7e3Fl0L8ybGHMc=;
        b=LmKVSJcrvZUQghS3Dw6ad6OXTeoEZPA6au+1nyIMFHH6fwU3EEbt8rTUQM4iM9UX3M
         R6WasQotmj7hqaX6IZkH/g+JtHLJ4olBNlQL46wFZCqwmEc/Ut+pWe0AuBa3YuBc53zh
         QXaO5lTlq44Ch3en5RwjQLN/nDUCoClV1FVBkTf8gxnwXn3Kb/gMkBGSEZpfvsl1r8vB
         wRT17TyxSneeDZVDaAQiq2CLrL+kM9+eLFrEnAuYgt+6D4eEXW4fWXq4+cNV5JSM6dV1
         vn+0Ig6EmO54CzHLS+CmLjHa2yNHTMzjBvjuEmce53mkgpla1wkb2tRkKl0RHl7DAn6X
         y8yg==
X-Gm-Message-State: AOJu0YwtXEElD5jkw1MLdKuhvngeNKZDD7wKXDpUciDQCVUCAmkoNeIq
	sp0dGBABy3UrhrdDlWTjtNU=
X-Google-Smtp-Source: AGHT+IG187hssArojzic8dSuLvqvGK4f7mOqOJu48BKwqpd0hkf3HI7ZDH2bJ9QsZktzyyfA73if0A==
X-Received: by 2002:a5d:534d:0:b0:317:3da0:7606 with SMTP id t13-20020a5d534d000000b003173da07606mr1597376wrv.4.1691585074380;
        Wed, 09 Aug 2023 05:44:34 -0700 (PDT)
Received: from localhost.localdomain (c-5eea7243-74736162.cust.telenor.se. [94.234.114.67])
        by smtp.gmail.com with ESMTPSA id d2-20020a5d4f82000000b0031784ac0babsm16811538wru.28.2023.08.09.05.44.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Aug 2023 05:44:34 -0700 (PDT)
From: Magnus Karlsson <magnus.karlsson@gmail.com>
To: magnus.karlsson@intel.com,
	bjorn@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	maciej.fijalkowski@intel.com,
	bpf@vger.kernel.org,
	yhs@fb.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Subject: [PATCH bpf-next 08/10] selftests/xsk: use ksft_print_msg uniformly
Date: Wed,  9 Aug 2023 14:43:41 +0200
Message-Id: <20230809124343.12957-9-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809124343.12957-1-magnus.karlsson@gmail.com>
References: <20230809124343.12957-1-magnus.karlsson@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Magnus Karlsson <magnus.karlsson@intel.com>

Use ksft_print_msg() instead of printf() and fprintf() in all places
as the ksefltests framework is being used. There is only one exception
and that is for the list-of-tests print out option, since no tests are
run in that case.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 25 ++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 38ec66292e03..7c19aef1dcc9 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -810,7 +810,7 @@ static void pkt_print_data(u32 *data, u32 cnt)
 
 		seqnum = ntohl(*data) & 0xffff;
 		pkt_nb = ntohl(*data) >> 16;
-		fprintf(stdout, "%u:%u ", pkt_nb, seqnum);
+		ksft_print_msg("%u:%u ", pkt_nb, seqnum);
 		data++;
 	}
 }
@@ -822,13 +822,13 @@ static void pkt_dump(void *pkt, u32 len, bool eth_header)
 
 	if (eth_header) {
 		/*extract L2 frame */
-		fprintf(stdout, "DEBUG>> L2: dst mac: ");
+		ksft_print_msg("DEBUG>> L2: dst mac: ");
 		for (i = 0; i < ETH_ALEN; i++)
-			fprintf(stdout, "%02X", ethhdr->h_dest[i]);
+			ksft_print_msg("%02X", ethhdr->h_dest[i]);
 
-		fprintf(stdout, "\nDEBUG>> L2: src mac: ");
+		ksft_print_msg("\nDEBUG>> L2: src mac: ");
 		for (i = 0; i < ETH_ALEN; i++)
-			fprintf(stdout, "%02X", ethhdr->h_source[i]);
+			ksft_print_msg("%02X", ethhdr->h_source[i]);
 
 		data = pkt + PKT_HDR_SIZE;
 	} else {
@@ -836,15 +836,15 @@ static void pkt_dump(void *pkt, u32 len, bool eth_header)
 	}
 
 	/*extract L5 frame */
-	fprintf(stdout, "\nDEBUG>> L5: seqnum: ");
+	ksft_print_msg("\nDEBUG>> L5: seqnum: ");
 	pkt_print_data(data, PKT_DUMP_NB_TO_PRINT);
-	fprintf(stdout, "....");
+	ksft_print_msg("....");
 	if (len > PKT_DUMP_NB_TO_PRINT * sizeof(u32)) {
-		fprintf(stdout, "\n.... ");
+		ksft_print_msg("\n.... ");
 		pkt_print_data(data + len / sizeof(u32) - PKT_DUMP_NB_TO_PRINT,
 			       PKT_DUMP_NB_TO_PRINT);
 	}
-	fprintf(stdout, "\n---------------------------------------\n");
+	ksft_print_msg("\n---------------------------------------\n");
 }
 
 static bool is_offset_correct(struct xsk_umem_info *umem, struct pkt *pkt, u64 addr)
@@ -1555,7 +1555,8 @@ static void *worker_testapp_validate_rx(void *arg)
 		xsk_clear_xskmap(ifobject->xskmap);
 		err = xsk_update_xskmap(ifobject->xskmap, ifobject->xsk->xsk);
 		if (err) {
-			printf("Error: Failed to update xskmap, error %s\n", strerror(-err));
+			ksft_print_msg("Error: Failed to update xskmap, error %s\n",
+				       strerror(-err));
 			exit_with_error(-err);
 		}
 	}
@@ -1619,7 +1620,7 @@ static void xsk_reattach_xdp(struct ifobject *ifobj, struct bpf_program *xdp_pro
 	xsk_detach_xdp_program(ifobj->ifindex, mode_to_xdp_flags(ifobj->mode));
 	err = xsk_attach_xdp_program(xdp_prog, ifobj->ifindex, mode_to_xdp_flags(mode));
 	if (err) {
-		printf("Error attaching XDP program\n");
+		ksft_print_msg("Error attaching XDP program\n");
 		exit_with_error(-err);
 	}
 
@@ -2106,7 +2107,7 @@ static void init_iface(struct ifobject *ifobj, const char *dst_mac, const char *
 
 	err = xsk_load_xdp_programs(ifobj);
 	if (err) {
-		printf("Error loading XDP program\n");
+		ksft_print_msg("Error loading XDP program\n");
 		exit_with_error(err);
 	}
 
-- 
2.34.1


