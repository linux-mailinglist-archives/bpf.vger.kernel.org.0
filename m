Return-Path: <bpf+bounces-7350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508A8775F7C
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 14:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AEAA1C211AC
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 12:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD03A182D0;
	Wed,  9 Aug 2023 12:44:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F3D182C1;
	Wed,  9 Aug 2023 12:44:13 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD3319A1;
	Wed,  9 Aug 2023 05:44:12 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe1f70a139so12274575e9.0;
        Wed, 09 Aug 2023 05:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691585051; x=1692189851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PSGRjY4gaWoRxNJIciCZYxevRMLIXBsP8ao9oiijR9w=;
        b=BKDfUhYO6i5K9weG49YsqDAFxhyXbO4CZfkTARNgllLHprqJsNhEFfa+jrFbCQJqVs
         lI9Egnd7QZGeCLbYAvmCgOnwo/PkmCWCc9AFT3NXYv5hGDKW74ywIKuBx1jt4z8pcO74
         ZPlWJD4nx60pk2/E3gEestxcP943Nd7Yh/kw+K4fKl1Mr3ZUuMKUX6pcyoTLA0sn2cqa
         K/ehTr74FRuoAkQComSeWV0wZPzaXamVwklCnOXBBGH6SDCGfzRP5oAYM8hLg/IX/sfb
         STRQvF25lhqyYorBEEYg689kNydZdLzqtBIGqa0UpYwTONIqPspmEz4ztQl99kFsd5CT
         pLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691585051; x=1692189851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PSGRjY4gaWoRxNJIciCZYxevRMLIXBsP8ao9oiijR9w=;
        b=dCsGm7v4osIj5IvebZy4WzXoRpsYQbC0Xism0UR0DkAXVeQ8EMhII5RE67UZzQhUBK
         V7QCJUerd5+j5gOZbKPVBfm7NB11ll/DgVIj++UtS4suaZ4hSNg1Jc5inLwYX/cPRWtY
         WwVvxw35Hhmv8+KoIwl6wn/R0JyaXcxcyXdbGdNhuVdT7BkH353viGC6gDVeCflf/bxy
         lwZgNly9aSK5AfNSLUfJa8k1CeBDmxr16cWy5/ihs/qZdp9NEIPdcniBqsbUusvJQXCj
         wlTc6lh1BGTl5/PrPiZ+tLn0YUoGo3+kmaRHmxQu3WfTkykA0iqGXIo/2PVzsWkWi1I0
         UR5A==
X-Gm-Message-State: AOJu0YxOltGQeoUeJXaMiY5fCI47/g0L5KbqGy9uty4mafWiVBYMr0Hf
	slTia3Ufn2jG+1VA1nr3o6E=
X-Google-Smtp-Source: AGHT+IEndFNCWGrDHA0hrypmrnwPT8Lf1F86ScjEnOYJ7gBMz2QsCAvDFoCd/fHiZwJI1gsPDqiX/g==
X-Received: by 2002:a05:600c:1c16:b0:3fb:dde9:1de8 with SMTP id j22-20020a05600c1c1600b003fbdde91de8mr2264005wms.2.1691585050519;
        Wed, 09 Aug 2023 05:44:10 -0700 (PDT)
Received: from localhost.localdomain (c-5eea7243-74736162.cust.telenor.se. [94.234.114.67])
        by smtp.gmail.com with ESMTPSA id d2-20020a5d4f82000000b0031784ac0babsm16811538wru.28.2023.08.09.05.44.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Aug 2023 05:44:10 -0700 (PDT)
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
Subject: [PATCH bpf-next 01/10] selftests/xsk: print per packet info in verbose mode
Date: Wed,  9 Aug 2023 14:43:34 +0200
Message-Id: <20230809124343.12957-2-magnus.karlsson@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Magnus Karlsson <magnus.karlsson@intel.com>

Print info about every packet in verbose mode, both for Tx and
Rx. This is useful to have when a test fails or to validate that a
test is really doing what it was designed to do. Info on what is
supposed to be received and sent is also printed for the custom packet
streams since they differ from the base line. Here is an example:

Tx addr: 37e0 len: 64 options: 0 pkt_nb: 8
Tx addr: 4000 len: 64 options: 0 pkt_nb: 9
Rx: addr: 100 len: 64 options: 0 pkt_nb: 0 valid: 1
Rx: addr: 1100 len: 64 options: 0 pkt_nb: 1 valid: 1
Rx: addr: 2100 len: 64 options: 0 pkt_nb: 4 valid: 1
Rx: addr: 3100 len: 64 options: 0 pkt_nb: 8 valid: 1
Rx: addr: 4100 len: 64 options: 0 pkt_nb: 9 valid: 1

One pointless verbose print statement is also deleted and another one
is made clearer.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 2827f2d7cf30..c595c0b65417 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -747,6 +747,9 @@ static struct pkt_stream *__pkt_stream_generate_custom(struct ifobject *ifobj, s
 			len = 0;
 		}
 
+		print_verbose("offset: %d len: %u valid: %u options: %u pkt_nb: %u\n",
+			      pkt->offset, pkt->len, pkt->valid, pkt->options, pkt->pkt_nb);
+
 		if (pkt->valid && pkt->len > pkt_stream->max_pkt_len)
 			pkt_stream->max_pkt_len = pkt->len;
 		pkt_nb++;
@@ -1042,6 +1045,9 @@ static int receive_pkts(struct test_spec *test, struct pollfd *fds)
 				return TEST_FAILURE;
 			}
 
+			print_verbose("Rx: addr: %lx len: %u options: %u pkt_nb: %u valid: %u\n",
+				      addr, desc->len, desc->options, pkt->pkt_nb, pkt->valid);
+
 			if (!is_frag_valid(umem, addr, desc->len, pkt->pkt_nb, pkt_len) ||
 			    !is_offset_correct(umem, pkt, addr) ||
 			    (ifobj->use_metadata && !is_metadata_correct(pkt, umem->buffer, addr)))
@@ -1165,6 +1171,9 @@ static int __send_pkts(struct ifobject *ifobject, struct pollfd *fds, bool timeo
 					     bytes_written);
 			bytes_written += tx_desc->len;
 
+			print_verbose("Tx addr: %llx len: %u options: %u pkt_nb: %u\n",
+				      tx_desc->addr, tx_desc->len, tx_desc->options, pkt->pkt_nb);
+
 			if (nb_frags_left) {
 				i++;
 				if (pkt_stream->verbatim)
@@ -1475,8 +1484,6 @@ static void *worker_testapp_validate_tx(void *arg)
 			thread_common_ops_tx(test, ifobject);
 	}
 
-	print_verbose("Sending %d packets on interface %s\n", ifobject->pkt_stream->nb_pkts,
-		      ifobject->ifname);
 	err = send_pkts(test, ifobject);
 
 	if (!err && ifobject->validation_func)
@@ -1715,7 +1722,7 @@ static int testapp_bidi(struct test_spec *test)
 	if (testapp_validate_traffic(test))
 		return TEST_FAILURE;
 
-	print_verbose("Switching Tx/Rx vectors\n");
+	print_verbose("Switching Tx/Rx direction\n");
 	swap_directions(&test->ifobj_rx, &test->ifobj_tx);
 	res = __testapp_validate_traffic(test, test->ifobj_rx, test->ifobj_tx);
 
-- 
2.34.1


