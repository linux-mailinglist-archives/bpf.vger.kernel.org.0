Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569FF67E7C6
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 15:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbjA0OJz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 09:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjA0OJx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 09:09:53 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A409236445
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 06:09:51 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 20DC93F2FB
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 14:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1674828590;
        bh=MB6tARXi880QTsQwMRQ5MIMlnD9ffmA7vMVVeWbOrz8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=FncMqpJ9SouTzmWNvKJp1FGwu0wTRqc/waTUnz6jSpPcbx0a2HVfBDANAcCzsrmwo
         ImIgNG4g4HSzK46InCP3Zc3QkIYzVkbAmguk7s2n7W2+1jeQaLcU7734NKJxwACqZR
         ozh6eMwtvIYd9i6ynJCfL3h5ZAOIXNA3hgBvp3mIl3TYq1T6rA/4z811B4CDviG4fm
         Py+JBjYgy1GCUJrwZ2JDKW2oNkOV8RHnMKxCQemMpZLO9Ve897CMkiFJnBzw3WCkWB
         Sv4alrcukhvHvmiV89MtruhjFXVhIbJnbZG/lO2QUSR48PewR/ReNJ0ouXobpBPpxa
         XUboq9KPoitcQ==
Received: by mail-wm1-f70.google.com with SMTP id l23-20020a7bc457000000b003db0cb8e543so1478666wmi.3
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 06:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MB6tARXi880QTsQwMRQ5MIMlnD9ffmA7vMVVeWbOrz8=;
        b=KodQG6Bilemd5x/4pJucFY2HDQkKilDX6ZmrclvfbN80BriZ6dUQ9eLfzM7sVaoRBm
         Vn1L9/Q3Ix5j5777KFjf7iGyR6y4nfHXXu1QrrkP2oJZFwkzjGdWGTe+YV/cfVfEoVP7
         xBZmC6KwkDdx6hcgjREvIs7vDvxUNaPbsEL+v8lQdzpGo6n7kzoToXaYq7iwJriaYeqX
         qVQNR945AuAvcziISwZ0a2lhsqdc0y8lYoUgXsNRKFtJClwbI5AJpde+0QI/zDHCBCn6
         r/kRNLARQX3Axmy6tYB7EJgo6YkB83VwsqLGeMTZukO7bGYSNPg7O4zFOzgglVQXWHYU
         QjSQ==
X-Gm-Message-State: AFqh2kq+0O579XPtvplN/P7um/oYw1kaobHX6FRbNrNmpaB5dVcRi9H4
        oA1OzqUy+aziZ65D5gsOYWXYFLlwKjhUS25pntPCMmCAP482YEeX4hv5EYunxivkDO7CDVpdg50
        2MDPPPPpnnbN08J7n53UfVp3YqEIETQ==
X-Received: by 2002:a5d:620a:0:b0:2bb:6b92:d4cc with SMTP id y10-20020a5d620a000000b002bb6b92d4ccmr32293111wru.53.1674828589669;
        Fri, 27 Jan 2023 06:09:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtjtC5+weCOvH9xY9DjnN1e6FzPPGLY0FEoGkcu1j4DBQe6IhUm9IRhuwIfUoi0c6giIHmbZA==
X-Received: by 2002:a5d:620a:0:b0:2bb:6b92:d4cc with SMTP id y10-20020a5d620a000000b002bb6b92d4ccmr32293067wru.53.1674828588933;
        Fri, 27 Jan 2023 06:09:48 -0800 (PST)
Received: from qwirkle.internal ([81.2.157.149])
        by smtp.gmail.com with ESMTPSA id f21-20020a5d58f5000000b00236883f2f5csm4105833wrd.94.2023.01.27.06.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 06:09:48 -0800 (PST)
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     Andrei Gherzan <andrei.gherzan@canonical.com>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v3 2/3] selftests: net: Unify references to nat6to4.o when running udpgro_frglist.sh
Date:   Fri, 27 Jan 2023 14:09:43 +0000
Message-Id: <20230127140944.265135-2-andrei.gherzan@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127140944.265135-1-andrei.gherzan@canonical.com>
References: <20230127140944.265135-1-andrei.gherzan@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change refactors the nat6to4.o references to use a variable for
consistency and also reformats two long lines.

Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
---
 tools/testing/selftests/net/udpgro_frglist.sh | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/udpgro_frglist.sh b/tools/testing/selftests/net/udpgro_frglist.sh
index 0a6359bed0b9..e1ca49de2491 100755
--- a/tools/testing/selftests/net/udpgro_frglist.sh
+++ b/tools/testing/selftests/net/udpgro_frglist.sh
@@ -6,6 +6,7 @@
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
 BPF_FILE="../bpf/xdp_dummy.bpf.o"
+BPF_NAT6TO4_FILE="nat6to4.o"
 
 cleanup() {
 	local -r jobs="$(jobs -p)"
@@ -40,9 +41,13 @@ run_one() {
 
 	ip -n "${PEER_NS}" link set veth1 xdp object ${BPF_FILE} section xdp
 	tc -n "${PEER_NS}" qdisc add dev veth1 clsact
-	tc -n "${PEER_NS}" filter add dev veth1 ingress prio 4 protocol ipv6 bpf object-file nat6to4.o section schedcls/ingress6/nat_6  direct-action
-	tc -n "${PEER_NS}" filter add dev veth1 egress prio 4 protocol ip bpf object-file nat6to4.o section schedcls/egress4/snat4 direct-action
-        echo ${rx_args}
+	tc -n "${PEER_NS}" filter add dev veth1 ingress prio 4 protocol \
+		ipv6 bpf object-file "$BPF_NAT6TO4_FILE" section \
+		schedcls/ingress6/nat_6 direct-action
+	tc -n "${PEER_NS}" filter add dev veth1 egress prio 4 protocol \
+		ip bpf object-file "$BPF_NAT6TO4_FILE" section \
+		schedcls/egress4/snat4 direct-action
+	echo ${rx_args}
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx ${rx_args} -r &
 
 	# Hack: let bg programs complete the startup
@@ -88,7 +93,7 @@ if [ ! -f ${BPF_FILE} ]; then
 	exit -1
 fi
 
-if [ ! -f nat6to4.o ]; then
+if [ ! -f "$BPF_NAT6TO4_FILE" ]; then
 	echo "Missing nat6to4 helper. Build bpf nat6to4.o selftest first"
 	exit -1
 fi
-- 
2.34.1

