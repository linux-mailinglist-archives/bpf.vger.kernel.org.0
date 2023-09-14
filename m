Return-Path: <bpf+bounces-9991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D6D79FF56
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 11:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE020281853
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 09:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A3C224C6;
	Thu, 14 Sep 2023 08:49:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E914A20B0B;
	Thu, 14 Sep 2023 08:49:41 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F96106;
	Thu, 14 Sep 2023 01:49:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31f4629aaaaso90874f8f.0;
        Thu, 14 Sep 2023 01:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694681379; x=1695286179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwz7qoUAlPeuirGafVnoG4lXPVGNRwL7FTDIGwEv7VM=;
        b=DUVE811BPGzmiorHo1FNlr3fw/XrIY7ASEeLTFcGXaMf54AmqObK4phExZfcn+0k3b
         0zmF27FY7CiSAf9/O8dnCUhWcpCBmiePZg3O1TYi8Sw3wIL/IPlnf11T5rjEUq4DraBp
         vjTg3+L5n+urs3h9w47pG7E1/Gy1peS0aM4eA6Yel//svxOwP84EU5JmHrlC9VZ2DjXE
         gUK71MyViWYPrKQRLyGWO14BZNtYS/po0r9UDFa1my5PihN9WfTyBUbtu4XqNukLqHOS
         r5U3uwNhNIIW9FR4x/vdPVvPLm6w+4BPC0hPG09o5mN1nyEtrrlErSqC7NdnFrUhIb8t
         lRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681379; x=1695286179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwz7qoUAlPeuirGafVnoG4lXPVGNRwL7FTDIGwEv7VM=;
        b=HI4gshCOwwxnmZWrd/dB9JDFjjRHhlJjaAw5VXVa0XFEqK1PDdCv173YwLF2zsIuZ1
         sXqu5wx2rYEfQL7HFDoBFM3yE3WPsRCvGiGyCYckuNZA7FOP7zGDAhKMzPEP1nNpZ/+p
         sIx7TGLSqEyZktFcaN033QMOkd0QXu9U/oRDe8fYBLi9V3NN9VypHbj8Fu3huBd2a0JM
         Iic0p5TYhFNUyGfx3giHV0uy+tXX07NP+9pnnis4OUUbN2+31Zfz2uVKNf7U2kRa7CLY
         EynrXyqkFZRDYHQtCTE+e9HA1vGXdHk7Uxbj9bs1chxG4BykD0KAMoeSIGe9HfSRvu4d
         NXyQ==
X-Gm-Message-State: AOJu0YyRp3ofTn6gzQpsjN7lMg5DatUXsUVoqde+50dLo02gX4JQp96l
	4UrSRRMeloNaFHUuTZtoQPI=
X-Google-Smtp-Source: AGHT+IGUxjIIvetkTahKuh7yzP7BJzZv6vANuco5utlAEfoZKaLDwQLSRCC4QT5tSWTvJ5RpDDQqSw==
X-Received: by 2002:adf:fd4d:0:b0:317:3a23:4855 with SMTP id h13-20020adffd4d000000b003173a234855mr4186558wrs.2.1694681379426;
        Thu, 14 Sep 2023 01:49:39 -0700 (PDT)
Received: from localhost.localdomain (h-176-10-144-222.NA.cust.bahnhof.se. [176.10.144.222])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c294c00b003fee777fd84sm1321099wmd.41.2023.09.14.01.49.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Sep 2023 01:49:38 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 08/10] selftests/xsk: use ksft_print_msg uniformly
Date: Thu, 14 Sep 2023 10:48:55 +0200
Message-ID: <20230914084900.492-9-magnus.karlsson@gmail.com>
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

Use ksft_print_msg() instead of printf() and fprintf() in all places
as the ksefltests framework is being used. There is only one exception
and that is for the list-of-tests print out option, since no tests are
run in that case.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 25 ++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index fba42edc3961..cc39a20951ff 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -808,7 +808,7 @@ static void pkt_print_data(u32 *data, u32 cnt)
 
 		seqnum = ntohl(*data) & 0xffff;
 		pkt_nb = ntohl(*data) >> 16;
-		fprintf(stdout, "%u:%u ", pkt_nb, seqnum);
+		ksft_print_msg("%u:%u ", pkt_nb, seqnum);
 		data++;
 	}
 }
@@ -820,13 +820,13 @@ static void pkt_dump(void *pkt, u32 len, bool eth_header)
 
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
@@ -834,15 +834,15 @@ static void pkt_dump(void *pkt, u32 len, bool eth_header)
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
@@ -1553,7 +1553,8 @@ static void *worker_testapp_validate_rx(void *arg)
 		xsk_clear_xskmap(ifobject->xskmap);
 		err = xsk_update_xskmap(ifobject->xskmap, ifobject->xsk->xsk);
 		if (err) {
-			printf("Error: Failed to update xskmap, error %s\n", strerror(-err));
+			ksft_print_msg("Error: Failed to update xskmap, error %s\n",
+				       strerror(-err));
 			exit_with_error(-err);
 		}
 	}
@@ -1617,7 +1618,7 @@ static void xsk_reattach_xdp(struct ifobject *ifobj, struct bpf_program *xdp_pro
 	xsk_detach_xdp_program(ifobj->ifindex, mode_to_xdp_flags(ifobj->mode));
 	err = xsk_attach_xdp_program(xdp_prog, ifobj->ifindex, mode_to_xdp_flags(mode));
 	if (err) {
-		printf("Error attaching XDP program\n");
+		ksft_print_msg("Error attaching XDP program\n");
 		exit_with_error(-err);
 	}
 
@@ -2104,7 +2105,7 @@ static void init_iface(struct ifobject *ifobj, const char *dst_mac, const char *
 
 	err = xsk_load_xdp_programs(ifobj);
 	if (err) {
-		printf("Error loading XDP program\n");
+		ksft_print_msg("Error loading XDP program\n");
 		exit_with_error(err);
 	}
 
-- 
2.42.0


