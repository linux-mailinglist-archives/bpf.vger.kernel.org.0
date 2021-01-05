Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE702EA86F
	for <lists+bpf@lfdr.de>; Tue,  5 Jan 2021 11:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbhAEKSu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Jan 2021 05:18:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51536 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbhAEKSh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Jan 2021 05:18:37 -0500
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1kwjPV-0002EA-UK
        for bpf@vger.kernel.org; Tue, 05 Jan 2021 10:17:54 +0000
Received: by mail-pf1-f197.google.com with SMTP id y2so10531024pfr.12
        for <bpf@vger.kernel.org>; Tue, 05 Jan 2021 02:17:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nmZhDdIWfrQhED+W2CTz4bW1p0zeWIgQoTW8Rle8EdQ=;
        b=bCjk1w1N/4vaynRxsFeSINmsF2rw0t38t9NnMTAgGqVofnlzZ4ElP/aR7XEQiHbVI0
         6G9IGcJiHuu6RCSusr5eohUnsq7jZaxrhuQRKllXRLfEUJ75EsF3+lITxo48AyeDe3pU
         lu9Wtj10awNGcTbN5S8bKURAOkGPRxIVsb5trYN5BhUrAj6o4OX+hRvOHFxv7MFhQ4pm
         4a/ZVeQNnP9Mum3ibL14/0cVRL2BrAwNlG88dvvQv23s4aC6NDKntMAf9odBJPm6ojHo
         AufbTZHfkdZ9Nq8qN6DlXIgk3e3QEMUW0pd3AeuMi7X0dvaNk0sP6BIgCcsdgw5tDkwb
         talw==
X-Gm-Message-State: AOAM533J50fQwiq6JAqpsZCa5zhrpTrPSrRHok6oC4fMaIiesn2A4/Jc
        MrzW4LS4xn7SYvLSRP5InRIgzMhnYZD7IUUgawYNU6z+dd8UUEYYnR6UHWLNt1zpcQbKfYYcFC3
        TwDfPzBNPoOImB69KPyzaN8ffWEH/
X-Received: by 2002:aa7:9af4:0:b029:19d:975a:3ef2 with SMTP id y20-20020aa79af40000b029019d975a3ef2mr69627686pfp.5.1609841872224;
        Tue, 05 Jan 2021 02:17:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMAaVfi3bUcazBSl5ZsPBoTUedxxtPUVkOKwcDIDKjf/q5zQhAKKnnjrdj/1sHtdcMEIf7lQ==
X-Received: by 2002:aa7:9af4:0:b029:19d:975a:3ef2 with SMTP id y20-20020aa79af40000b029019d975a3ef2mr69627662pfp.5.1609841871872;
        Tue, 05 Jan 2021 02:17:51 -0800 (PST)
Received: from Leggiero.taipei.internal (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id m3sm56599924pfa.134.2021.01.05.02.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 02:17:51 -0800 (PST)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, shuah@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org
Subject: [PATCH] selftests: fix the return value for UDP GRO test
Date:   Tue,  5 Jan 2021 18:17:40 +0800
Message-Id: <20210105101740.11816-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The udpgro.sh will always return 0 (unless the bpf selftest was not
build first) even if there are some failed sub test-cases.

Therefore the kselftest framework will report this case is OK.

Check and return the exit status of each test to make it easier to
spot real failures.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/udpgro.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selftests/net/udpgro.sh
index ac2a30b..f8a19f5 100755
--- a/tools/testing/selftests/net/udpgro.sh
+++ b/tools/testing/selftests/net/udpgro.sh
@@ -5,6 +5,14 @@
 
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
+# set global exit status, but never reset nonzero one.
+check_err()
+{
+	if [ $ret -eq 0 ]; then
+		ret=$1
+	fi
+}
+
 cleanup() {
 	local -r jobs="$(jobs -p)"
 	local -r ns="$(ip netns list|grep $PEER_NS)"
@@ -44,7 +52,9 @@ run_one() {
 	# Hack: let bg programs complete the startup
 	sleep 0.1
 	./udpgso_bench_tx ${tx_args}
+	ret=$?
 	wait $(jobs -p)
+	return $ret
 }
 
 run_test() {
@@ -87,8 +97,10 @@ run_one_nat() {
 
 	sleep 0.1
 	./udpgso_bench_tx ${tx_args}
+	ret=$?
 	kill -INT $pid
 	wait $(jobs -p)
+	return $ret
 }
 
 run_one_2sock() {
@@ -110,7 +122,9 @@ run_one_2sock() {
 	sleep 0.1
 	# first UDP GSO socket should be closed at this point
 	./udpgso_bench_tx ${tx_args}
+	ret=$?
 	wait $(jobs -p)
+	return $ret
 }
 
 run_nat_test() {
@@ -131,36 +145,54 @@ run_all() {
 	local -r core_args="-l 4"
 	local -r ipv4_args="${core_args} -4 -D 192.168.1.1"
 	local -r ipv6_args="${core_args} -6 -D 2001:db8::1"
+	ret=0
 
 	echo "ipv4"
 	run_test "no GRO" "${ipv4_args} -M 10 -s 1400" "-4 -n 10 -l 1400"
+	check_err $?
 
 	# explicitly check we are not receiving UDP_SEGMENT cmsg (-S -1)
 	# when GRO does not take place
 	run_test "no GRO chk cmsg" "${ipv4_args} -M 10 -s 1400" "-4 -n 10 -l 1400 -S -1"
+	check_err $?
 
 	# the GSO packets are aggregated because:
 	# * veth schedule napi after each xmit
 	# * segmentation happens in BH context, veth napi poll is delayed after
 	#   the transmission of the last segment
 	run_test "GRO" "${ipv4_args} -M 1 -s 14720 -S 0 " "-4 -n 1 -l 14720"
+	check_err $?
 	run_test "GRO chk cmsg" "${ipv4_args} -M 1 -s 14720 -S 0 " "-4 -n 1 -l 14720 -S 1472"
+	check_err $?
 	run_test "GRO with custom segment size" "${ipv4_args} -M 1 -s 14720 -S 500 " "-4 -n 1 -l 14720"
+	check_err $?
 	run_test "GRO with custom segment size cmsg" "${ipv4_args} -M 1 -s 14720 -S 500 " "-4 -n 1 -l 14720 -S 500"
+	check_err $?
 
 	run_nat_test "bad GRO lookup" "${ipv4_args} -M 1 -s 14720 -S 0" "-n 10 -l 1472"
+	check_err $?
 	run_2sock_test "multiple GRO socks" "${ipv4_args} -M 1 -s 14720 -S 0 " "-4 -n 1 -l 14720 -S 1472"
+	check_err $?
 
 	echo "ipv6"
 	run_test "no GRO" "${ipv6_args} -M 10 -s 1400" "-n 10 -l 1400"
+	check_err $?
 	run_test "no GRO chk cmsg" "${ipv6_args} -M 10 -s 1400" "-n 10 -l 1400 -S -1"
+	check_err $?
 	run_test "GRO" "${ipv6_args} -M 1 -s 14520 -S 0" "-n 1 -l 14520"
+	check_err $?
 	run_test "GRO chk cmsg" "${ipv6_args} -M 1 -s 14520 -S 0" "-n 1 -l 14520 -S 1452"
+	check_err $?
 	run_test "GRO with custom segment size" "${ipv6_args} -M 1 -s 14520 -S 500" "-n 1 -l 14520"
+	check_err $?
 	run_test "GRO with custom segment size cmsg" "${ipv6_args} -M 1 -s 14520 -S 500" "-n 1 -l 14520 -S 500"
+	check_err $?
 
 	run_nat_test "bad GRO lookup" "${ipv6_args} -M 1 -s 14520 -S 0" "-n 10 -l 1452"
+	check_err $?
 	run_2sock_test "multiple GRO socks" "${ipv6_args} -M 1 -s 14520 -S 0 " "-n 1 -l 14520 -S 1452"
+	check_err $?
+	return $ret
 }
 
 if [ ! -f ../bpf/xdp_dummy.o ]; then
@@ -180,3 +212,5 @@ elif [[ $1 == "__subprocess_2sock" ]]; then
 	shift
 	run_one_2sock $@
 fi
+
+exit $?
-- 
2.7.4

