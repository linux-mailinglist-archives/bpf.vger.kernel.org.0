Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9624160D71E
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 00:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiJYW27 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 18:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbiJYW24 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 18:28:56 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204EF7D79F
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 15:28:52 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x2so11349463edd.2
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 15:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guCllocMNmw80ZyG53CeyhOkNL1cE+oBzRCN8SKnxmQ=;
        b=Vpy7pm91Pv7q+ly8gpSnv6R4YYFk+HzGU9GMH2n300sYNkjxunYodJzaw9dnxs5Bmt
         8v6AXGhq2KGsYkXDczNkFWmoT/3kvNqYnLzK30sE7hSGSx7To0ytQ7Y8wQAxwwOlVdKS
         BwS8Tz73i+59NIKb0gEAgrViQNkbwZalx9OAvAWwlgACIhebkR01C/tSfW5EnoX+4CTp
         CH8cgY5z8HxtMC8k52bh79angCdRWo/+UdOSDLXVSE3sJaVeC/7IPpVoOgrtXT+KKJd6
         GBQUX8M48U/wtOiQA8zetOtjs835DfBfOXD+8QuuvxmwCB9eW0pSl9Vj+qdGv86tah3I
         UiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guCllocMNmw80ZyG53CeyhOkNL1cE+oBzRCN8SKnxmQ=;
        b=7Y1e1c/VfyZOQOY2fRX0Qh6q44Xcxo9Z6RUo73J0k1A+f6HcORxHSWiNAHD/2jpglU
         qb5J25zwf6w483ZDgPo/EvQ2rq81PtjDu0KfGVyGBRmoVxZmGhZ4XuEqE31YC+7fyCP5
         yRf194iMq7OVurIIr6LlLNnb63JktG5QE1XO6WkLrceFx/Qj5sc8yHnEIlbnaht8oL42
         pMd5lUu9oIL1zeNt7zgfkT97ZDLJi3fQK19GEd4oUA/aYC2xygGsjAFtdNIehCku5ZjY
         S8PeW9gRrSy3M4JVkQRquMCA4Ozhu4LL7yEU2qXyetIg2jDeRAM7HMwY9xolv2HV+WfN
         qklA==
X-Gm-Message-State: ACrzQf25ZZAp2WhV5ObeLKMxQmW8owgF5QHkKFhJ+IN5gWTr/WjHWTaS
        tQYtt07KkzStPISGu/qB2Ps93mG3iGqI/jgi
X-Google-Smtp-Source: AMsMyM5EKeSmZdER5rKxCyebm8bVn64TXd/nuStRKMIAAiT5Wpdl1V1HWwjddWVxddNhIeVB1zsEwQ==
X-Received: by 2002:aa7:c61a:0:b0:461:c48d:effe with SMTP id h26-20020aa7c61a000000b00461c48deffemr11772170edq.7.1666736931110;
        Tue, 25 Oct 2022 15:28:51 -0700 (PDT)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id ks23-20020a170906f85700b0078d175d6dc5sm1993119ejb.201.2022.10.25.15.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:28:50 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, arnaldo.melo@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 12/12] selftests/bpf: script for infer_header_guards.pl testing
Date:   Wed, 26 Oct 2022 01:28:01 +0300
Message-Id: <20221025222802.2295103-13-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025222802.2295103-1-eddyz87@gmail.com>
References: <20221025222802.2295103-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This script verifies that patterns for header guard inference
specified in scripts/infer_header_guards.pl cover all uapi headers.
To achieve this the infer_header_guards.pl is invoked the same way it
is invoked from link-vmlinux.sh but with --report-failures flag.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/test_uapi_header_guards_infer.sh      | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100755 tools/testing/selftests/bpf/test_uapi_header_guards_infer.sh

diff --git a/tools/testing/selftests/bpf/test_uapi_header_guards_infer.sh b/tools/testing/selftests/bpf/test_uapi_header_guards_infer.sh
new file mode 100755
index 000000000000..bd332db100f3
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_uapi_header_guards_infer.sh
@@ -0,0 +1,33 @@
+#!/bin/bash
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+# This script verifies that patterns for header guard inference
+# specified in scripts/infer_header_guards.pl cover all uapi headers.
+# To achieve this the infer_header_guards.pl is invoked the same way
+# it is invoked from link-vmlinux.sh but with --report-failures flag.
+
+kernel_dir=$(dirname $0)/../../../../
+
+# The SRCARCH is defined in tools/scripts/Makefile.arch, thus use a
+# temporary makefile to get access to this variable.
+fake_makefile=$(cat <<EOF
+include tools/scripts/Makefile.arch
+default:
+	scripts/infer_header_guards.pl --report-failures \
+		include/uapi \
+		include/generated/uapi \
+		arch/\$(SRCARCH)/include/uapi \
+		arch/\$(SRCARCH)/include/generated/uapi 1>/dev/null
+EOF
+)
+
+# The infer_header_guards.pl script prints inferred guards to stdout,
+# redirecting stdout to /dev/null to see only error messages.
+echo "$fake_makefile" | make -C $kernel_dir -f - 1>/dev/null
+if [ "$?" == "0" ]; then
+	echo "all good"
+	exit 0
+fi
+
+# Failures are already reported by infer_header_guards.pl
+exit 1
-- 
2.34.1

