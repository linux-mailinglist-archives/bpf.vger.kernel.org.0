Return-Path: <bpf+bounces-8473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EF1786F33
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 14:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE0A28162A
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 12:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C8F156DE;
	Thu, 24 Aug 2023 12:29:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574AC15488;
	Thu, 24 Aug 2023 12:29:58 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DF9198B;
	Thu, 24 Aug 2023 05:29:57 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f13c41c957so2304341e87.1;
        Thu, 24 Aug 2023 05:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692880195; x=1693484995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jp79f45U+s49dvCS6AwutTJNhrpmhgL5dN2yIt+vQI0=;
        b=WjqcUBVt7fjAv9RNb8W5bHimwSzLEuwS9pjROvFYmLEFlOzrlxEDRbIs/tYrrElbcx
         JJipRhv1jjaLMQ07haKAYN/wkNv02kdT8RZufDBpKE0PODCBQYFlgz440npeWwobr2hZ
         OnGAcvd3UAQbPsdYG481+La8MfI5auCF3S9zHFJdWOb01rVdm11uEBI+nW/4GsrNPDTL
         6Y2xo5+GjadvtxbMc7t49rljkasik2531ADsvQpvwMcFHZ/LbMEpZ17jLocDzzsn7XD+
         s13mdCt6kdIAwCfg590B9Qa9p6Rm1n0JamY6E7oXB+vlcrV+wYmrSfxJjMhIZsPEri9j
         A/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692880195; x=1693484995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jp79f45U+s49dvCS6AwutTJNhrpmhgL5dN2yIt+vQI0=;
        b=M+bbiirvAgP5WVqs/snTbzBIWbnsp0yx/Rmt/hLskkr+lkiib4aMYXbYysVZGjmmfS
         X1iYBgOQURhtWes5fdXOf/nOuFPSCP0NKkdVgPhvV3TCb+MrZMr17HuQ3YQQJK5l4O/t
         h8p2oWbwqKXAIh6X/5SSn5dYB9Gt06goS1mFeQ/8dsz+rPxA0ha+hOvztUh9iySLxRP3
         HFRAJpe6PFQULtFUK4OHGQiI0jBrQ0NfvEcBkEZSTzbTiRSfK/eYoZ4SWARg5JRU87Jo
         oyEmoO73ZVztW0OuAMN8+vATlt8H15upMjMhTTpr9eD8+hWuhFj1cb3cYPfnAwjm6h8W
         0L+g==
X-Gm-Message-State: AOJu0YzfIlOpsny8+HbqOI4BHoMZu4ceILn0AwudhLumL8Iay+0V+rT6
	aPtqw0RCFAr2ZD+ClJ0LrLE=
X-Google-Smtp-Source: AGHT+IEt2PuXqnfTcXVZ8z2j4XZzbairCFQ4Yz0Pe7YG0g8ykZDWIc9ZaPRVkL4m3q/kEzM5hc/CJQ==
X-Received: by 2002:a2e:aaa8:0:b0:2b6:120a:af65 with SMTP id bj40-20020a2eaaa8000000b002b6120aaf65mr8909318ljb.3.1692880195277;
        Thu, 24 Aug 2023 05:29:55 -0700 (PDT)
Received: from localhost.localdomain ([94.234.116.52])
        by smtp.gmail.com with ESMTPSA id hn1-20020a05600ca38100b003fbe4cecc3bsm2523776wmb.16.2023.08.24.05.29.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Aug 2023 05:29:54 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 10/11] selftests/xsk: display command line options with -h
Date: Thu, 24 Aug 2023 14:28:52 +0200
Message-Id: <20230824122853.3494-11-magnus.karlsson@gmail.com>
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

Add the -h option to display all available command line options
available for test_xsk.sh and xskxceiver.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/test_xsk.sh  | 11 ++++++++++-
 tools/testing/selftests/bpf/xskxceiver.c |  5 ++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
index b7186ae48497..9ec718043c1a 100755
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
 		m) XSKTEST_MODE=${OPTARG};;
 		l) list=1;;
 		t) XSKTEST_TEST=${OPTARG};;
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
index 19db9a827c30..9feb476d647f 100644
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
2.34.1


