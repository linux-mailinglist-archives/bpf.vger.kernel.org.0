Return-Path: <bpf+bounces-9888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE88879E5AE
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 13:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211631C20D4F
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 11:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039C11E529;
	Wed, 13 Sep 2023 11:03:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26571E520;
	Wed, 13 Sep 2023 11:03:15 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02DC19AD;
	Wed, 13 Sep 2023 04:03:14 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31f7c87353eso777038f8f.0;
        Wed, 13 Sep 2023 04:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694602993; x=1695207793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9AsvGX0Tf+T3xdcc7A5LAtXwJ+uE28UTAaOXgJkbss=;
        b=NRgBejMRSbkNK7As5KPPFNKAIB3/5y8RH3XHHeNxXGlChLv5LC4eWC2D13m86AmeAH
         jtZP2HjJdDkJs+fNy7CwRwxsIqjaBCrYx6b1K93Km4Ru/DU+fdNKJhF0/f5psabTanKq
         EpiIn8wyb/PuYtfjbpWxz/7WtkM2kAEs3UBFBUhdvqAq7dsyU1D4WiI5BTA1/jcMLTo+
         MznFzZtxLM8cv+EAX0Ml3unSpxzipBN5KrEH0IqTGH92sDf8gjQqjqkqCkmsovT3WE28
         PkrzG4hj8p691cQELo5I2UTE6QqdQ/9F19dUssehe2sFPjJWb5uIMSt9okID1UYp28iB
         ywTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694602993; x=1695207793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9AsvGX0Tf+T3xdcc7A5LAtXwJ+uE28UTAaOXgJkbss=;
        b=i+WeorMlwC6SgsBMFke8fisWhxy1EiBY3aSUA3PDqtwWLPrUKv6vB9jZFdrk7vAI6S
         ApRm4LCUC6b0DmejMugfBtsgTowm9RpxvNAUjulvEiYJCXj7VApGvnd2lbXt4k4Mqj5n
         QUy7m1Jj2oSMWHaEQEJGEim33AmmfyHNHhuuVELpo1iXH7Z9FiYVwqM6K5fk2NiP8Dz8
         BMvO02FCpiffkjb1PECHh/1tFuJ6QUmo3YNDKa6d5Db8U956EbaYpTE4BheqeBXYbPsv
         XUdxVRfPIVXVX7F0W0/5kyWPSgdprhnxV9iq4S8vAKCc3OQmDuMSMZU00K9VPLX+6FYa
         /0fw==
X-Gm-Message-State: AOJu0YwJ1F7bxpZk8zT/DeRL8rPZTRE6iSSd881bxZMWVaCUxE12C39n
	zgZBbwNocWX+zdtzN4+uomY=
X-Google-Smtp-Source: AGHT+IGwwF+k4gzR5fX/TKU8pDy7eA/0I/LJIKryHjdLmM1GamdbMdAQL2DbwZjVkjWtC0G+jAhq1Q==
X-Received: by 2002:adf:e60f:0:b0:31a:ed75:75d4 with SMTP id p15-20020adfe60f000000b0031aed7575d4mr1866319wrm.2.1694602993215;
        Wed, 13 Sep 2023 04:03:13 -0700 (PDT)
Received: from localhost.localdomain (h-176-10-144-222.NA.cust.bahnhof.se. [176.10.144.222])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d538a000000b0031c7682607asm15255289wrv.111.2023.09.13.04.03.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Sep 2023 04:03:12 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 01/10] selftests/xsk: print per packet info in verbose mode
Date: Wed, 13 Sep 2023 13:02:23 +0200
Message-ID: <20230913110248.30597-2-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230913110248.30597-1-magnus.karlsson@gmail.com>
References: <20230913110248.30597-1-magnus.karlsson@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.42.0


