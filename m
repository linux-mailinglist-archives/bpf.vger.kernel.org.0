Return-Path: <bpf+bounces-7359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFC1775FA8
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 14:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB581C20F25
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 12:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ACF19BB2;
	Wed,  9 Aug 2023 12:44:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31C8182A4;
	Wed,  9 Aug 2023 12:44:44 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD61719A1;
	Wed,  9 Aug 2023 05:44:42 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe4f3b5f25so9777795e9.0;
        Wed, 09 Aug 2023 05:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691585081; x=1692189881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pITbBVl4wFrjChu6aVPobrTISqQgG9xNiPA9IK7UYp8=;
        b=X0+rC4egdcirIn4D99DUk+dn+wiDe/u0kXcZ/4yzldIiD7ewf6Zwk+Ok7RED1ZOBgp
         sHEqFP+ikrp1YWb159rwmp9mTq+IgBlEM9Cg0SNpN4ro4VFvk2FI1L6F3WU6lkxiDP8D
         yjMs2+172y2HpidAaDHBq+AQVh/iNtzKlo+yiRKpIjdUGbzXFz29VwdmuRSLpuKQg9KR
         DFO+T85cDj9NWCfwjhbV2A40dXd/WwLurd7cBKQt5brJBzxXb32hpd9FLW0NXGvho82M
         6OqIhFuANbi294QVU3XJ5S9h0vrKM2VxfC24qFR9CJtJQ1u7H++KT5+lZP2M9Nx0Rna6
         orTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691585081; x=1692189881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pITbBVl4wFrjChu6aVPobrTISqQgG9xNiPA9IK7UYp8=;
        b=X5BpfR9IcduP9/gpwEVY8W0ht9FJt6eNjWRnKvSQvlY/zyeDRFsJj/IyRypmFJnLmZ
         r0GVmRbtsnhMUbhywfoDiFpEvln1Uls0gy7JLuxeZcbIXz2/rJrq0oIQZZRFrKA72xp3
         B/FQ/+GNcigaPDtfmMJigF1sFfejCM9bYKOLw4XlFZq0B5HhaDdznJY3kGP1bHP9N6Wa
         5dune6ciir9eU67NuLzITGAzs+JIN/tqBrCHyce4NIMlJ9acKlafj7xpFhPtS0N+w4/B
         TFRwok5yB6QahNGFoRHVnpNoYGxND/KpvCKf/t4J0QohZDooAHDC21kiemUJmcfG8VSh
         E+SQ==
X-Gm-Message-State: AOJu0YyXppPhBbjKyxKKFfDFuKk2xOUIsVMcp7Z63h+/ztGGhgSBqFJH
	80z0L03Jbi0LZ5tqWiu6nkQ=
X-Google-Smtp-Source: AGHT+IGu6BqxHYp6LvmOUq78kJ6C5HSxK854t+PupbaNcbGsrlhoRDCK6DkDTJkFgyF+hRjEisHZLQ==
X-Received: by 2002:a05:600c:3b8f:b0:3f9:88d:9518 with SMTP id n15-20020a05600c3b8f00b003f9088d9518mr2260369wms.0.1691585081102;
        Wed, 09 Aug 2023 05:44:41 -0700 (PDT)
Received: from localhost.localdomain (c-5eea7243-74736162.cust.telenor.se. [94.234.114.67])
        by smtp.gmail.com with ESMTPSA id d2-20020a5d4f82000000b0031784ac0babsm16811538wru.28.2023.08.09.05.44.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Aug 2023 05:44:40 -0700 (PDT)
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
	jolsa@kernel.org
Subject: [PATCH bpf-next 10/10] selftests/xsk: display command line options with -h
Date: Wed,  9 Aug 2023 14:43:43 +0200
Message-Id: <20230809124343.12957-11-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809124343.12957-1-magnus.karlsson@gmail.com>
References: <20230809124343.12957-1-magnus.karlsson@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Magnus Karlsson <magnus.karlsson@intel.com>

Add the -h option to display all available command line options
available for test_xsk.sh and xskxceiver.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/test_xsk.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
index 94b4b86d5239..baaeb016d699 100755
--- a/tools/testing/selftests/bpf/test_xsk.sh
+++ b/tools/testing/selftests/bpf/test_xsk.sh
@@ -79,12 +79,15 @@
 #
 # Run a specific test from the test suite
 #   sudo ./test_xsk.sh -t TEST_NAME
+#
+# Display the available command line options
+#   sudo ./test_xsk.sh -h
 
 . xsk_prereqs.sh
 
 ETH=""
 
-while getopts "vi:dm:lt:" flag
+while getopts "vi:dm:lt:h" flag
 do
 	case "${flag}" in
 		v) verbose=1;;
@@ -93,6 +96,7 @@ do
 		m) MODE=${OPTARG};;
 		l) list=1;;
 		t) TEST=${OPTARG};;
+		h) help=1;;
 	esac
 done
 
@@ -140,6 +144,11 @@ setup_vethPairs() {
 	ip link set ${VETH0} up
 }
 
+if [[ $help -eq 1 ]]; then
+	./${XSKOBJ}
+        exit
+fi
+
 if [ ! -z $ETH ]; then
 	VETH0=${ETH}
 	VETH1=${ETH}
-- 
2.34.1


