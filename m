Return-Path: <bpf+bounces-9984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1E479FEFF
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 10:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9655D1F2277C
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 08:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB0615E93;
	Thu, 14 Sep 2023 08:49:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4CD15E86;
	Thu, 14 Sep 2023 08:49:29 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D5598;
	Thu, 14 Sep 2023 01:49:28 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40471c054f9so1123315e9.0;
        Thu, 14 Sep 2023 01:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694681367; x=1695286167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9AsvGX0Tf+T3xdcc7A5LAtXwJ+uE28UTAaOXgJkbss=;
        b=XviLE7qnOYKAJ6DgCAcR+v+Tuh4FkxmMM1ruU9kC7/AqyeUcNObUe6xdoi6TeKjv87
         MrkcHCDsTs/5mYn59mfMpTa22My9EjTsz56wIfA4cBxgVfF2hcXToI1qRKQ94cQTY6A+
         x0oVwQAklw8thTu8ZtAXb1hVLfjtPwkYGXf7ua6w4NzDJiEidupmbgQuOnuStiNsqMcL
         xVTzs0z9amuHDDu2JY0B9E816s6cPaOC+Pm1FZJHTjKL38pHuSLSea7c4e+6LlCn1ZIL
         PZYfRq8KHU8qFBSMwCkqeDXc78VE9A5Nrlx9YYUH6kkg4STfTuA0oXyIIIETwjzEwFCm
         HbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681367; x=1695286167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9AsvGX0Tf+T3xdcc7A5LAtXwJ+uE28UTAaOXgJkbss=;
        b=lSAIcJ79yurKVWA/8VLSiKddcy/mzhPwpgk8NeeohXQTSZcWF2GrCPuZB2xHMu1dpd
         I5FLL1C4qHm+3Xn38NTad4aaNLIolTrZsX7lDpoW1W1Ig/ounjffg+ckplAIT/es8e5J
         0VF8lXmnIXSBhWqAsgaI7qDS+nuQZ/hhjyQb0UZXpoiehXFPCRAuaRF0TxvTa6aLnUQy
         +/R2/KnhXQAcvv9vhDYfq1S9qENu9H6bndVDSHfdr9L50Yto+2Bx/9hnvdx/MM4ixYm9
         tGzEcoTHPv0zhzY3ckwY/qb2nahrIGDrd/vZG44vBZA4MMwsi+XsPdy/Lkanm8D3grqr
         2yIg==
X-Gm-Message-State: AOJu0Yxq2Q1U2aTZDZfCn4LehzHB+YKwZDamInK7XZNfN98P9eApOOCA
	hejabiCAVBkhoqiYhCYh3PM=
X-Google-Smtp-Source: AGHT+IFiNSyvQXT9HcyY8hAaZf6D14lk7kPDh+c7pwUP8vhOkRZ1/vxt3E/H/SKKiJvTQO0Fu2NE3g==
X-Received: by 2002:a05:600c:5404:b0:401:b9fb:5acd with SMTP id he4-20020a05600c540400b00401b9fb5acdmr4145802wmb.3.1694681366877;
        Thu, 14 Sep 2023 01:49:26 -0700 (PDT)
Received: from localhost.localdomain (h-176-10-144-222.NA.cust.bahnhof.se. [176.10.144.222])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c294c00b003fee777fd84sm1321099wmd.41.2023.09.14.01.49.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Sep 2023 01:49:26 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 01/10] selftests/xsk: print per packet info in verbose mode
Date: Thu, 14 Sep 2023 10:48:48 +0200
Message-ID: <20230914084900.492-2-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914084900.492-1-magnus.karlsson@gmail.com>
References: <20230914084900.492-1-magnus.karlsson@gmail.com>
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


