Return-Path: <bpf+bounces-9897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 339B379E5CB
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 13:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5125A1C212CB
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 11:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A47C1F939;
	Wed, 13 Sep 2023 11:03:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CA61F923;
	Wed, 13 Sep 2023 11:03:31 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6031119AD;
	Wed, 13 Sep 2023 04:03:31 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-402ba03c754so19012705e9.0;
        Wed, 13 Sep 2023 04:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694603010; x=1695207810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmpdiDp8WZ2vNU4focnYGseUOqGguV6LAlX3fJfap74=;
        b=bNqAn0nYo6aOJqhx+3sk+lKRRWgFBAyearAtarr4e5YEM+r0Dk2rCrvvGMo3xdf4n0
         p9wtXaz2a4REZpWLrgXcIRMwQ2FxQl7obS7sEkad7QiJ+7bx7xY3kTuyZ9gX8lqm9FhR
         ckXejwMFBuJDat3VJanMEP4eY3HLbCiRHajqhOu5HMAYtKxiwdjP2DSc5VZ9+AZ9illK
         dKG8EMZyqTQODXufb+LaHp08tzL+82wlMxSUKr+wkod+W4VBGJyC9+umGuhnVsmeQHW1
         gOQCrUxqkFHz/uuDu6CMU03XHNDxfeQ4FRj9tbX/RAXZhcDDH9IULmZM9TAilyWI2IWr
         M7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694603010; x=1695207810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmpdiDp8WZ2vNU4focnYGseUOqGguV6LAlX3fJfap74=;
        b=dCjH63fdNOTV/eN4/XoBSA9J6ILQ/+up8lcy/4GlpWZh3B5HhGTf3Y4FxVdtIWnw/A
         Fzi66Hps6a39oHSRXdlE36mA8m1+NSJ+YbM4fFRL6c8k+rKLfWReQBIFdho03m085eiP
         ztKCicRNz9qFrCf11377GOEeZjNXPI8yHDlfTFLbUbajojm+035aoGgI9p+bl4ttBBYF
         xEoeDMS7qXCHK0DsbY4QNK3T7ow63ICh1+uzIfmwrq6lcT/NQyJrFNU7BnyRDGwOQbFY
         XhQoXLhL1xqg0maPTV5f/tze4BwqC+Htm+fzIXSzoNZnX9xcyrXZwhJFdAStwcbrevfO
         0GvA==
X-Gm-Message-State: AOJu0Yytk+jJmWEahkHBEJYBHHUKzMU1OCKGLCHRzKcM0GevYbbDusq6
	FENw3qfuH2kD0ifUW00Cawg=
X-Google-Smtp-Source: AGHT+IGvmRpX/iwfC9nYPUE2PiH/g2oLeWnC1Hp1YQ2zI7WEQ+GnJDfDFz9WBCOuIt3Mq9T65a4S/w==
X-Received: by 2002:a05:600c:34c7:b0:3fe:d637:7b25 with SMTP id d7-20020a05600c34c700b003fed6377b25mr1828413wmq.0.1694603009737;
        Wed, 13 Sep 2023 04:03:29 -0700 (PDT)
Received: from localhost.localdomain (h-176-10-144-222.NA.cust.bahnhof.se. [176.10.144.222])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d538a000000b0031c7682607asm15255289wrv.111.2023.09.13.04.03.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Sep 2023 04:03:29 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 10/10] selftests/xsk: display command line options with -h
Date: Wed, 13 Sep 2023 13:02:32 +0200
Message-ID: <20230913110248.30597-11-magnus.karlsson@gmail.com>
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
index 9883e610ff63..86eb70068325 100644
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
@@ -406,6 +408,7 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 			if (errno)
 				print_usage(argv);
 			break;
+		case 'h':
 		default:
 			print_usage(argv);
 		}
-- 
2.42.0


