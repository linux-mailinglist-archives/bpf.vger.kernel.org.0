Return-Path: <bpf+bounces-9993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BAA79FF66
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 11:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227031F227F2
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 09:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C79C224EA;
	Thu, 14 Sep 2023 08:49:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434EB224CF;
	Thu, 14 Sep 2023 08:49:46 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5952091;
	Thu, 14 Sep 2023 01:49:45 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4046f7d49a9so1223355e9.1;
        Thu, 14 Sep 2023 01:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694681384; x=1695286184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwhhFtwprQ70ZXZEGv4EzxwCCstXMvaMKlXP1+ghg4Y=;
        b=jQWLeJroegXDfetLNeNvk3biD9F4XZTyGyRL9zVuegtQE7VfL7TSxZaKzr0JGWtFMn
         fcasW+GSs0ylsPe0LQvvL8uWA7kPkRfe19Fprlx5kNu5lkYmiH6tFvCHNsgYr8iemvA9
         BMUulkL1YC4A6JD0UsXXws+pTvTfs0H+G8On1RuLEc+C7EF5fug8qs870wmPrd2GFftC
         DnRTsF/7SGawZaw+ZgSwXIn9ff+e8nNJysoQ+zxbxSQbq0BIHyMMzUzEpFVl30sZQO5N
         8/YXtMLw42cTVb0UItHb8ouDrtdd0gelwNJ4dtSVzY987mM/H6AP55Y8Db4tWlWLCg/K
         5tcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681384; x=1695286184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwhhFtwprQ70ZXZEGv4EzxwCCstXMvaMKlXP1+ghg4Y=;
        b=Pbd2Lr5NwTN4aV62YY0IbvvirXehpbPNfdGgXp+NEPHXWpHBq+j5gJi5WIexdjDDRV
         KOglgWuFywpuX81kUKa16VHkr2PkeH11aEgkglmEtZa35K/FWzcvRmcibk2sh0GqrEQ5
         jPp7zRzh9x6aY08k6aC35TAcMnpmoG1iP3bFN24oXEo4I1QdRCSgn3VT9NpEkY1Uuwoa
         CCtWFffY5ZXrexcltg2RT+EYImT2AmZcII3nkfn6zOwLKuV5McbSRzBylOeoMAZyIW2Q
         6PC91xncXe2U5aFIqb4fiOiX5yrRRwNLpc9MuUDXEPFnN8vafm/NjGsJzxWpJGRO8LO1
         DYIw==
X-Gm-Message-State: AOJu0Yy5i54aeAAjF0+F/W9Ts5CSRIi5TwUH7QYsBGQz8vMQVDyZAMlg
	ej1th/+hL/T3WR8FecEoHao=
X-Google-Smtp-Source: AGHT+IGY6SYnInfdfXX67QvFqF/DJZmB7FLbB9FZCofEv0+goBgMadsd+UXoeanpoZm/v/EVtfPtIQ==
X-Received: by 2002:a05:600c:474c:b0:3ff:8617:672b with SMTP id w12-20020a05600c474c00b003ff8617672bmr4146377wmo.2.1694681383428;
        Thu, 14 Sep 2023 01:49:43 -0700 (PDT)
Received: from localhost.localdomain (h-176-10-144-222.NA.cust.bahnhof.se. [176.10.144.222])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c294c00b003fee777fd84sm1321099wmd.41.2023.09.14.01.49.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Sep 2023 01:49:43 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 10/10] selftests/xsk: display command line options with -h
Date: Thu, 14 Sep 2023 10:48:57 +0200
Message-ID: <20230914084900.492-11-magnus.karlsson@gmail.com>
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

Add the -h option to display all available command line options
available for test_xsk.sh and xskxceiver.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/test_xsk.sh  | 11 ++++++++++-
 tools/testing/selftests/bpf/xskxceiver.c |  5 ++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
index 296006ea6e9c..65aafe0003db 100755
--- a/tools/testing/selftests/bpf/test_xsk.sh
+++ b/tools/testing/selftests/bpf/test_xsk.sh
@@ -82,12 +82,15 @@
 #
 # Run a specific test from the test suite
 #   sudo ./test_xsk.sh -t TEST_NAME
+#
+# Display the available command line options
+#   ./test_xsk.sh -h
 
 . xsk_prereqs.sh
 
 ETH=""
 
-while getopts "vi:dm:lt:" flag
+while getopts "vi:dm:lt:h" flag
 do
 	case "${flag}" in
 		v) verbose=1;;
@@ -96,6 +99,7 @@ do
 		m) MODE=${OPTARG};;
 		l) list=1;;
 		t) TEST=${OPTARG};;
+		h) help=1;;
 	esac
 done
 
@@ -148,6 +152,11 @@ if [[ $list -eq 1 ]]; then
         exit
 fi
 
+if [[ $help -eq 1 ]]; then
+	./${XSKOBJ}
+        exit
+fi
+
 if [ ! -z $ETH ]; then
 	VETH0=${ETH}
 	VETH1=${ETH}
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index d64061d647ae..43e0a5796929 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -318,6 +318,7 @@ static struct option long_options[] = {
 	{"mode", required_argument, 0, 'm'},
 	{"list", no_argument, 0, 'l'},
 	{"test", required_argument, 0, 't'},
+	{"help", no_argument, 0, 'h'},
 	{0, 0, 0, 0}
 };
 
@@ -331,7 +332,8 @@ static void print_usage(char **argv)
 		"  -b, --busy-poll      Enable busy poll\n"
 		"  -m, --mode           Run only mode skb, drv, or zc\n"
 		"  -l, --list           List all available tests\n"
-		"  -t, --test           Run a specific test. Enter number from -l option.\n";
+		"  -t, --test           Run a specific test. Enter number from -l option.\n"
+		"  -h, --help           Display this help and exit\n";
 
 	ksft_print_msg(str, basename(argv[0]));
 	ksft_exit_xfail();
@@ -402,6 +404,7 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 			if (errno)
 				print_usage(argv);
 			break;
+		case 'h':
 		default:
 			print_usage(argv);
 		}
-- 
2.42.0


