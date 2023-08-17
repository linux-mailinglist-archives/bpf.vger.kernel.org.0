Return-Path: <bpf+bounces-7996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7359F77FB1D
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 17:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9BF28204F
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 15:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5017F156FC;
	Thu, 17 Aug 2023 15:47:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7D514011
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 15:47:16 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D183B30C5
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 08:47:15 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5656a5c6721so4329155a12.1
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 08:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692287235; x=1692892035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yy/n52yulvpcfWLb++c8suVS1IeV5wLMc2On2ajtVn0=;
        b=DqRgdTipiN1W5MeiyyQWhKSSmmvLWQTF5ygJCsGh+oUUGl8go+IAm32IYP941AIBd+
         ukPZ95stXV19993mwBNQBV2xC+YEW0lMCnT17/h28xTbVNlgY9bRt42DdhAnWL42Slqm
         eAsfjrlGIcOFCqRk87Z+KIhXaN0rlBNlvgAX7IbGTDJxTf3zTQ/vODSYUDpPitBPKdS2
         wLtuhyWy/doXzdPMM+pfWVngYOCipb7ne76EPNQ9X8iTbNzVy9Z4UT/RXHCTDxYnNxoY
         BSXKHw4/c47JUtkwAaZsmu059qt8c/0902d99isxRcAkbi6gslbhTqolxxRbYkAJZSeD
         KnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692287235; x=1692892035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yy/n52yulvpcfWLb++c8suVS1IeV5wLMc2On2ajtVn0=;
        b=TNd9Wpm1Foa2GyMFOaNHN8YP1/d0CaZLX/KLKs8xu3/NQbYg4B3VWO/LzT81VcgI6e
         AvKlGsMLTqtPFZoU8S8V4vzKw/1OLY+d7elQjQS4b0vx8lPo66a3sKFuZKc6qAQuecKj
         590Ukj5ulMEIrPIi0P4Bxp2W1QXy9L88GNJwnO6lT6wiIL941pdBcK5+W43WoFrtY8KH
         qVXq82cJsvJweUeZblhZHF5WN7EpPXOa5zkVXmgpPTQ0Gl/u0W+Lb0/Dz+UXaJjij01L
         2cnfgC+Ssk/y7A2K5yL4cfafdj4YmEeKRvvkiV6YAfptNDVWULIyTYBrFMYL9V0AnPVB
         PjwQ==
X-Gm-Message-State: AOJu0YyCa160JY1KTHhB8iP0L197Ag3a71OLR4nuR8Y3V0WaWRqTEKiN
	fAP5w5U+jbT4NAdaLAS/Ue4=
X-Google-Smtp-Source: AGHT+IGEvVWcUtDczq5FDtbetppkb7VnPjnBC82kxf6Cv44eHo872be3BCwGzdNZww+R2KKxBmmL5Q==
X-Received: by 2002:a05:6a20:d7:b0:13a:8082:5324 with SMTP id 23-20020a056a2000d700b0013a80825324mr72037pzh.44.1692287235094;
        Thu, 17 Aug 2023 08:47:15 -0700 (PDT)
Received: from fanta-System-Product-Name.. ([222.252.65.171])
        by smtp.gmail.com with ESMTPSA id v10-20020a63ac0a000000b00563709c8647sm14019742pge.7.2023.08.17.08.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 08:47:14 -0700 (PDT)
From: Anh Tuan Phan <tuananhlfc@gmail.com>
To: sdf@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev
Cc: Anh Tuan Phan <tuananhlfc@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [bpf-next PATCH v1] samples/bpf: Cleanup repetitive swap function
Date: Thu, 17 Aug 2023 22:46:15 +0700
Message-Id: <20230817154615.87967-1-tuananhlfc@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Use the macro version of swap function and move its definition to
bpf_util.h since it is repetitive in some files. This commit also fixes
a warning from coccinelle:

- ./samples/bpf/xdp_sample_user.c:1493:8-9: WARNING opportunity for swap()
- ./samples/bpf/xdp_rxq_info_user.c:435:8-9: WARNING opportunity for swap()

Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
---
 samples/bpf/xdp_rxq_info_user.c        | 12 +-----------
 samples/bpf/xdp_sample_user.c          | 12 +-----------
 tools/testing/selftests/bpf/bpf_util.h |  3 +++
 3 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/samples/bpf/xdp_rxq_info_user.c b/samples/bpf/xdp_rxq_info_user.c
index b95e0ef61f06..862ee370f96a 100644
--- a/samples/bpf/xdp_rxq_info_user.c
+++ b/samples/bpf/xdp_rxq_info_user.c
@@ -426,16 +426,6 @@ static void stats_print(struct stats_record *stats_rec,
 }
 
 
-/* Pointer swap trick */
-static inline void swap(struct stats_record **a, struct stats_record **b)
-{
-	struct stats_record *tmp;
-
-	tmp = *a;
-	*a = *b;
-	*b = tmp;
-}
-
 static void stats_poll(int interval, int action, __u32 cfg_opt)
 {
 	struct stats_record *record, *prev;
@@ -445,7 +435,7 @@ static void stats_poll(int interval, int action, __u32 cfg_opt)
 	stats_collect(record);
 
 	while (1) {
-		swap(&prev, &record);
+		swap(prev, record);
 		stats_collect(record);
 		stats_print(record, prev, action, cfg_opt);
 		sleep(interval);
diff --git a/samples/bpf/xdp_sample_user.c b/samples/bpf/xdp_sample_user.c
index 158682852162..9508bc0c2f2f 100644
--- a/samples/bpf/xdp_sample_user.c
+++ b/samples/bpf/xdp_sample_user.c
@@ -1484,16 +1484,6 @@ static int sample_signal_cb(void)
 	return 0;
 }
 
-/* Pointer swap trick */
-static void swap(struct stats_record **a, struct stats_record **b)
-{
-	struct stats_record *tmp;
-
-	tmp = *a;
-	*a = *b;
-	*b = tmp;
-}
-
 static int sample_timer_cb(int timerfd, struct stats_record **rec,
 			   struct stats_record **prev)
 {
@@ -1505,7 +1495,7 @@ static int sample_timer_cb(int timerfd, struct stats_record **rec,
 	if (ret < 0)
 		return -errno;
 
-	swap(prev, rec);
+	swap(*prev, *rec);
 	ret = sample_stats_collect(*rec);
 	if (ret < 0)
 		return ret;
diff --git a/tools/testing/selftests/bpf/bpf_util.h b/tools/testing/selftests/bpf/bpf_util.h
index 10587a29b967..ba3c44d64d44 100644
--- a/tools/testing/selftests/bpf/bpf_util.h
+++ b/tools/testing/selftests/bpf/bpf_util.h
@@ -8,6 +8,9 @@
 #include <errno.h>
 #include <bpf/libbpf.h> /* libbpf_num_possible_cpus */
 
+#define swap(a, b) \
+	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
+
 static inline unsigned int bpf_num_possible_cpus(void)
 {
 	int possible_cpus = libbpf_num_possible_cpus();
-- 
2.34.1


