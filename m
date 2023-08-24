Return-Path: <bpf+bounces-8474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F81786F36
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 14:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7774F1C20EC4
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 12:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842CD15ACF;
	Thu, 24 Aug 2023 12:30:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A011156FD;
	Thu, 24 Aug 2023 12:30:00 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD0E10D7;
	Thu, 24 Aug 2023 05:29:59 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-400e8ab9325so2040085e9.1;
        Thu, 24 Aug 2023 05:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692880197; x=1693484997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gtB1qAnmEEEdOMdr+ldusNhjfEmkbuz6v9vvmxAdLWU=;
        b=HCmyscqBBHNTLTcBc5OA7BrAnbZC1zKZd4e4mbV9u4Cn/4bVdDnM8ZekC1YQWOsEzp
         GYJCMO19yDOcpWxEGZQu8VaWnIXwT+3tWa4sWAuwAOgLWXlH98nY9aKc0XvFNBUWddNR
         V2zqUEuQ2zb+v3kiGHDpI6zAb+ac2WGnazE5WJdn9K8TmC4BuqOgIsqtEh47c52//UDQ
         VoJ7a/NQvGhNyVDdaYr4xdkwS9YEyzLpuc/UZcelkasXoI7Z280Yw3GVCqJZd4p1mS5M
         WvYOEj1rJx8PIroV6/tM3jeQbIwkPOGy8I6/G5gSdA734AtL2Ghg9VLwSifugeHoS8J1
         eT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692880197; x=1693484997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtB1qAnmEEEdOMdr+ldusNhjfEmkbuz6v9vvmxAdLWU=;
        b=d9iZ02qhaF0NdNQgxatjbJ9+qMRUcS0rds229Vu8aoWNm44ce8G3yNVa/lWJS/Bhlo
         9nkHsBlJf/rdNAC5GsOtMhVTvaZXigCVwtqvdGNDB7cLThbwrbzZCZowPScl+OHE/D84
         73ibaEBHz0c1O6RZrLs/6ndONgQyNLYnGV4OS4BI9RPT4Od9oeC5YuyCO7AD0xe9METM
         lvVZ8hYxV4A64j4pj9CcThCds0TfjpbYnkvCtQqiawgcT7iWkCZe5d07B7b+sB10l+dj
         jIISFVdGLalpmDVe9sfZqIxAl+4/TC1S6Lv3J5CEa+h/mgA7BClJ6xqIF9ql3foYrfOd
         IjEg==
X-Gm-Message-State: AOJu0YztNFcVESD2ep16Lj3EBHB34yzmm83YkVl8WyIbTRRjYcnG5MSY
	uOgJNM5jlK8sf1W0xJPum0Y=
X-Google-Smtp-Source: AGHT+IF4POKdyilStYzuHxnt860VFcAFmJNoX2yD14rKb1ygTGjlMEsvt4e4B9ALu3HTiM5ZKt9ajA==
X-Received: by 2002:a05:600c:5185:b0:3fe:dd78:8fbc with SMTP id fa5-20020a05600c518500b003fedd788fbcmr12168797wmb.3.1692880197634;
        Thu, 24 Aug 2023 05:29:57 -0700 (PDT)
Received: from localhost.localdomain ([94.234.116.52])
        by smtp.gmail.com with ESMTPSA id hn1-20020a05600ca38100b003fbe4cecc3bsm2523776wmb.16.2023.08.24.05.29.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Aug 2023 05:29:57 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 11/11] selftests/xsk: introduce XSKTEST_ETH environment variable
Date: Thu, 24 Aug 2023 14:28:53 +0200
Message-Id: <20230824122853.3494-12-magnus.karlsson@gmail.com>
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

Introduce the XSKTEST_ETH environment variable to be able to set the
network interface that should be used for testing.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/test_xsk.sh | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
index 9ec718043c1a..3e0a2302a185 100755
--- a/tools/testing/selftests/bpf/test_xsk.sh
+++ b/tools/testing/selftests/bpf/test_xsk.sh
@@ -88,14 +88,12 @@
 
 . xsk_prereqs.sh
 
-ETH=""
-
 while getopts "vi:dm:lt:h" flag
 do
 	case "${flag}" in
 		v) verbose=1;;
 		d) debug=1;;
-		i) ETH=${OPTARG};;
+		i) XSKTEST_ETH=${OPTARG};;
 		m) XSKTEST_MODE=${OPTARG};;
 		l) list=1;;
 		t) XSKTEST_TEST=${OPTARG};;
@@ -157,9 +155,9 @@ if [[ $help -eq 1 ]]; then
         exit
 fi
 
-if [ ! -z $ETH ]; then
-	VETH0=${ETH}
-	VETH1=${ETH}
+if [ -n "$XSKTEST_ETH" ]; then
+	VETH0=${XSKTEST_ETH}
+	VETH1=${XSKTEST_ETH}
 else
 	validate_root_exec
 	validate_veth_support ${VETH0}
@@ -203,10 +201,10 @@ fi
 
 exec_xskxceiver
 
-if [ -z $ETH ]; then
+if [ -z $XSKTEST_ETH ]; then
 	cleanup_exit ${VETH0} ${VETH1}
 else
-	cleanup_iface ${ETH} ${MTU}
+	cleanup_iface ${XSKTEST_ETH} ${MTU}
 fi
 
 if [[ $list -eq 1 ]]; then
@@ -216,17 +214,17 @@ fi
 TEST_NAME="XSK_SELFTESTS_${VETH0}_BUSY_POLL"
 busy_poll=1
 
-if [ -z $ETH ]; then
+if [ -z $XSKTEST_ETH ]; then
 	setup_vethPairs
 fi
 exec_xskxceiver
 
 ## END TESTS
 
-if [ -z $ETH ]; then
+if [ -z $XSKTEST_ETH ]; then
 	cleanup_exit ${VETH0} ${VETH1}
 else
-	cleanup_iface ${ETH} ${MTU}
+	cleanup_iface ${XSKTEST_ETH} ${MTU}
 fi
 
 failures=0
-- 
2.34.1


