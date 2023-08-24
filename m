Return-Path: <bpf+bounces-8464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB3C786F09
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 14:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3411C20E21
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 12:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FD31119D;
	Thu, 24 Aug 2023 12:29:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A2410793;
	Thu, 24 Aug 2023 12:29:37 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2F819AE;
	Thu, 24 Aug 2023 05:29:36 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b73261babdso17088421fa.1;
        Thu, 24 Aug 2023 05:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692880174; x=1693484974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PSGRjY4gaWoRxNJIciCZYxevRMLIXBsP8ao9oiijR9w=;
        b=NRnXZIoW/fJxCdBGcYV67b/DZ3O8oawUkfclu21SarrAbdshrsEVnfRISQl/YRigow
         qD4ZzbZHG184WJlcTGtcArZfPje1BgyftoZfxeUPena/bWiTwGJVptS3IvcDjBYXW5xI
         /hXSqw49zmsBcGn2mt7HLOgnOPsUtrVCXLM3o+OpJ9aYl/NIjTjz3wA2rFlq6ZQBHJjg
         dny1N08kZ5PYtVBTFseDV9Da7MJvaHapIx2k74dPG2Ye+buJ0oTTD5DrL8BLKcEJxL9s
         PzBkWpEP9IANklKpoUCOTk3GhixELb4TVTrf1v1Z64U0LJRYPkFQN12G1DosbY3vX53i
         cwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692880174; x=1693484974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PSGRjY4gaWoRxNJIciCZYxevRMLIXBsP8ao9oiijR9w=;
        b=hn8I8ka330k+jmk7d52t0KJOQm8mnIMf6eQSLVvuHVK6E1YxvpIxcfAZnU8qq+vbqV
         ujfdAavCCdW6fPXasbBIKMENFxDuIQBz7IynjK0/aOLZ9YkULUoUs0mBjHe+OuOg+OjX
         JK3W2zIzYdBOO4m3pHD0OEXyZK7n0XsCFo7yBXVflG3i4L1nNmIeuLlCz2tte77B0Zaw
         qasLUOTuPGV9qhCreVuVTTXVQK/9ImZZtStPgCDXlKqH1G80nC9cl1rSwDgNXI2Zub8W
         EPF2mRw12kqMFlmBbiL/LEW1vB7U3pY2D3eWEcJOHOf6oC5NS2Jw+LiPsSpLXThzS5GS
         U2JQ==
X-Gm-Message-State: AOJu0YzaGzy0oaEyQktVQMnbVBOC4KU2cySgEPlT8Udig1sYpiQ8kk8A
	9GyvTcZT4xRp8BJDI/TjRCw=
X-Google-Smtp-Source: AGHT+IFy/RfMOaAF33tuMrkJoQFOGo59jOlJ9VataWBVN1eesDw6U+0wqMfzbSoH4IXI4gmQ+oN2Og==
X-Received: by 2002:a2e:aaa8:0:b0:2b6:120a:af65 with SMTP id bj40-20020a2eaaa8000000b002b6120aaf65mr8908800ljb.3.1692880174069;
        Thu, 24 Aug 2023 05:29:34 -0700 (PDT)
Received: from localhost.localdomain ([94.234.116.52])
        by smtp.gmail.com with ESMTPSA id hn1-20020a05600ca38100b003fbe4cecc3bsm2523776wmb.16.2023.08.24.05.29.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Aug 2023 05:29:33 -0700 (PDT)
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
	jolsa@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: [PATCH bpf-next v2 01/11] selftests/xsk: print per packet info in verbose mode
Date: Thu, 24 Aug 2023 14:28:43 +0200
Message-Id: <20230824122853.3494-2-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824122853.3494-1-magnus.karlsson@gmail.com>
References: <20230824122853.3494-1-magnus.karlsson@gmail.com>
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


