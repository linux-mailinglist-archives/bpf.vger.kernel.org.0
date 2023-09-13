Return-Path: <bpf+bounces-9895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDF179E5C6
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 13:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10551C21271
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 11:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43721F19B;
	Wed, 13 Sep 2023 11:03:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BFF1F16E;
	Wed, 13 Sep 2023 11:03:28 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E815C19A6;
	Wed, 13 Sep 2023 04:03:27 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-401d61e9fecso20433235e9.0;
        Wed, 13 Sep 2023 04:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694603006; x=1695207806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8SdBPPKfbG5vKKh6IHopUBAR5I6kieHXaQn+FVPpWo=;
        b=O5Zugh3Yj5UHD6NFDYAH+9+am5vq0WhZIasVzGwQ8NKfDwyvaS/NGfzqYaG09YJiNW
         mr5hsgRt2NjDyuPIltc9nRH/UacubUzc+Ub/WDd7nGITT969BnOo9AdOZYQi9lkoQ9nL
         xJfIC2Yhfd9hkeQAZHdhXUAcTvgV13T/z3zN0ASPad7GTpJUfrXpEJTNb/BQWzgxSAVC
         TcYovUPbK4/h2CihhDdXFTA7ssWX/oQVTDSlrVBQEkY3TucDbi32KQyvxZl5L2um58fO
         cZoXMdot945aBuK0ooIFw7drWHVsP4l2bd4A3ssjcIPH8eb3oG1mAueD83pBKscd9oQu
         lk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694603006; x=1695207806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8SdBPPKfbG5vKKh6IHopUBAR5I6kieHXaQn+FVPpWo=;
        b=sz6fQ8gkmgGY+gOU+w/xLXCVColeC0VzA/Oxpp0fkMjsfcKx1JkV7dshRa7LUExQVe
         CmCpX5tKIduZlmhmQ0PF/XTo6LaNPptRublHDAgb7y5IkFIZSkX5TNexIt39d+jfiWI1
         RVgALJzJItSlQwlj6y/TBk7G0A6LNJIsFChOIIw0ZLLPqJ0rpXu/QjkhD2b+7MDj78x4
         flet9eilYzFQq5VddboSvFnjg1ptrJ4u+NXLK8myxFtUTkc6FYpaEtoCXBsMjH/28YuH
         wjV07T+cr8Wlko/21/rvzZHa5sKN5sXPaeQx9L9ixh14MIbKr4svUet850q9NKPLNz3x
         U/0w==
X-Gm-Message-State: AOJu0YyLD8BCIehKV9ywFMO092RVgUjGVss/AufHK96fwPZd2z+vma96
	eZmFZc4as3yXmjRZ6brgRLlPB1EwtpAu6W2m
X-Google-Smtp-Source: AGHT+IGdZ38PzOv1itSJGBJm3pyNGUq7mCbneEXzAWAs1zZqX4Nn+dC9+RDcDYTCd1O+rA3QkS8Igw==
X-Received: by 2002:a5d:5489:0:b0:31a:ed75:75e8 with SMTP id h9-20020a5d5489000000b0031aed7575e8mr1870805wrv.2.1694603006088;
        Wed, 13 Sep 2023 04:03:26 -0700 (PDT)
Received: from localhost.localdomain (h-176-10-144-222.NA.cust.bahnhof.se. [176.10.144.222])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d538a000000b0031c7682607asm15255289wrv.111.2023.09.13.04.03.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Sep 2023 04:03:25 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 08/10] selftests/xsk: use ksft_print_msg uniformly
Date: Wed, 13 Sep 2023 13:02:30 +0200
Message-ID: <20230913110248.30597-9-magnus.karlsson@gmail.com>
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

Use ksft_print_msg() instead of printf() and fprintf() in all places
as the ksefltests framework is being used. There is only one exception
and that is for the list-of-tests print out option, since no tests are
run in that case.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 25 ++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 4d5c53153465..1a0bb058877c 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -812,7 +812,7 @@ static void pkt_print_data(u32 *data, u32 cnt)
 
 		seqnum = ntohl(*data) & 0xffff;
 		pkt_nb = ntohl(*data) >> 16;
-		fprintf(stdout, "%u:%u ", pkt_nb, seqnum);
+		ksft_print_msg("%u:%u ", pkt_nb, seqnum);
 		data++;
 	}
 }
@@ -824,13 +824,13 @@ static void pkt_dump(void *pkt, u32 len, bool eth_header)
 
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
@@ -838,15 +838,15 @@ static void pkt_dump(void *pkt, u32 len, bool eth_header)
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
@@ -1557,7 +1557,8 @@ static void *worker_testapp_validate_rx(void *arg)
 		xsk_clear_xskmap(ifobject->xskmap);
 		err = xsk_update_xskmap(ifobject->xskmap, ifobject->xsk->xsk);
 		if (err) {
-			printf("Error: Failed to update xskmap, error %s\n", strerror(-err));
+			ksft_print_msg("Error: Failed to update xskmap, error %s\n",
+				       strerror(-err));
 			exit_with_error(-err);
 		}
 	}
@@ -1621,7 +1622,7 @@ static void xsk_reattach_xdp(struct ifobject *ifobj, struct bpf_program *xdp_pro
 	xsk_detach_xdp_program(ifobj->ifindex, mode_to_xdp_flags(ifobj->mode));
 	err = xsk_attach_xdp_program(xdp_prog, ifobj->ifindex, mode_to_xdp_flags(mode));
 	if (err) {
-		printf("Error attaching XDP program\n");
+		ksft_print_msg("Error attaching XDP program\n");
 		exit_with_error(-err);
 	}
 
@@ -2108,7 +2109,7 @@ static void init_iface(struct ifobject *ifobj, const char *dst_mac, const char *
 
 	err = xsk_load_xdp_programs(ifobj);
 	if (err) {
-		printf("Error loading XDP program\n");
+		ksft_print_msg("Error loading XDP program\n");
 		exit_with_error(err);
 	}
 
-- 
2.42.0


