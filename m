Return-Path: <bpf+bounces-8471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C376786F2E
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 14:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0D81C20E39
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 12:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B8214AB6;
	Thu, 24 Aug 2023 12:29:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1561429D;
	Thu, 24 Aug 2023 12:29:55 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC4C1995;
	Thu, 24 Aug 2023 05:29:52 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fef244772bso8790865e9.1;
        Thu, 24 Aug 2023 05:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692880191; x=1693484991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Njinz5B8bKMSFukzgiEU0+2HkIWqLmNPSSRaDHk9K4=;
        b=UHGFnfMFwpOh4edf5cp5Ptw8556nszuNSJtCt23N/Bljyt4v3Q2LoEXW56rVQWt/5p
         c6DRMfA4BYpuLml96xLQDMnmDSJ1SCLtzrvSGNrSGTBSFps7OcAkYKoxuS6VVppEknz8
         aWSzxP2Iq1uMvTwWzLFUIcNA3sPGH5PTSEqPxzl8hQzJdVRUisCk/yPHzmTJMbYO8CxR
         yT1f37ROX5E7edESbAKTlHC6lsMKbFN20axmihxa1dIDfsm0MhDLdbPuwwZyWliGsU0H
         7cyd19x1ang6n1/pHrWnRJ3D4ztDKsvuc1bO2My6PH1Ey5JpVW6/2DkONGtRQj97IR33
         53Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692880191; x=1693484991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Njinz5B8bKMSFukzgiEU0+2HkIWqLmNPSSRaDHk9K4=;
        b=VNfha8yIglEwvk1vUZ/Y+jyog2gn8oou0n6tShLwjdWsN1diexIMWijVZtTmg+xy6D
         MMk94FGE6rYi30yF8V6wM2W09uLv3hmtsAPMmSQYx8FVzxoqvL70ePiFTRWEd7KqR6Uh
         zD18qEmU/sGO9VlBhsvVeORSwnsCAKP/Yfb2CJORCblnMt0KnsEMBdqnKpA6ioO13MmC
         ful1vUSLIm9dymCn5u/u+mKO++EgmdkKkgcCeqxpy/a8B+IEdfoYkla0QfSmsvrCR/F5
         AVN07bY56tQPqUxwtqBItk0h+hZhFhGmLLqdbqEIO4mlu7w2wrPqkc3wE5BvsmB/r3es
         m4EQ==
X-Gm-Message-State: AOJu0YwLoB7QSwKt99eBwDn1AAkcMH0lBk2idzbv8pZOXDJ+RJR3ko02
	rm1WcnrzCzGhx4ACl+zKb0E=
X-Google-Smtp-Source: AGHT+IE/TfIzdxuYQzF8nV6s3J7fEalJMQ2LJVM3K8QhaFfEdroLBC0c6xh+fLIQD9OqEqzZVEneWw==
X-Received: by 2002:a05:600c:54ea:b0:3fe:d780:4f93 with SMTP id jb10-20020a05600c54ea00b003fed7804f93mr12728167wmb.0.1692880190553;
        Thu, 24 Aug 2023 05:29:50 -0700 (PDT)
Received: from localhost.localdomain ([94.234.116.52])
        by smtp.gmail.com with ESMTPSA id hn1-20020a05600ca38100b003fbe4cecc3bsm2523776wmb.16.2023.08.24.05.29.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Aug 2023 05:29:50 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 08/11] selftests/xsk: use ksft_print_msg uniformly
Date: Thu, 24 Aug 2023 14:28:50 +0200
Message-Id: <20230824122853.3494-9-magnus.karlsson@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
index 6eca5f95a3e0..2cb5fdf0188e 100644
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
2.34.1


