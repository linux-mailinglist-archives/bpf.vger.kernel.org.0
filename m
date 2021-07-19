Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A123CF097
	for <lists+bpf@lfdr.de>; Tue, 20 Jul 2021 02:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbhGSXb5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Jul 2021 19:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441833AbhGSWN7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Jul 2021 18:13:59 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72902C061767
        for <bpf@vger.kernel.org>; Mon, 19 Jul 2021 15:30:49 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 37so20805813pgq.0
        for <bpf@vger.kernel.org>; Mon, 19 Jul 2021 15:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9xYF/FgBs5Wya1s6TdSYN6WuGi2vLkqTN091aVRm6U=;
        b=eAQEcwctm4M+hi2fwnkRpLmIIJkTBtreDu0rAkaLAcAbm2rpVJdPl+4XK0kHZ36a6K
         2Y5yF5dysvcG7wqsEKVoHp8yHK9sJQtgI6CHjkRBi0iIM31FtXsQCYanO3p5TQ6OkNpJ
         HJEOiqG+fXtc1kQY/gyv7ebtrvGmhYTjlajtSdRucd6KeE3aAGNM4k1660T7N9caNrig
         Uwz7K7AF9PDTfrzTczKklrvkJOzJuOp/KiyV5fy/+UXu9rSpvioYlW0e3jgl6cjwzI6/
         XJMf4WKi+jsSNcVRy3XtUi8B9cxNGgzwddgQos8gKgnEAZ2PIkVGm7G/VokeoyOCif+G
         RFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9xYF/FgBs5Wya1s6TdSYN6WuGi2vLkqTN091aVRm6U=;
        b=Lz4bidmgUL3V48HN1g0ed6KF60JUt3DD3g4vM+XP01xh02scF2EJg9exbN1eET2oNw
         gFEI+kp2xs26GrxeaOWoAMLZrzVklDKDy+syu142B14gHzl3qDhnzmbThzi52/qP2QZl
         q3wjhmLJZhcsrRdd3k+z6xNhaXZZgfOdmzIMdiDicqT7E+QLKCeM7j6Q/WGiURwH3PdC
         BavlAY58jZt8Z6RnxUqetYWOawju0NvBAapjzY88KM875adoVrxVeRgfpaYBlShdwEQh
         CM8LZxJb8a9QHFTOIyKndEnrHCI8LaSO7DVuECS7iDvlhgNcIDX5zl6Vk7sRSwoNYyOO
         z6xg==
X-Gm-Message-State: AOAM531W7Bp0osnkcD7sOTodTtMeMqVqBsYRnvvfA6wB+IeMZchvZTYm
        +JwW36soW0O1iAT5mBR8jdmj6aTHq3E=
X-Google-Smtp-Source: ABdhPJziNDEdUCUBufNFSo3e8RpeIYFpzr+rwNAiqN6CPvH3bYaAgBKPODbmmtnzlQIKjQbrxJc/Sg==
X-Received: by 2002:a63:b60:: with SMTP id a32mr27975924pgl.29.1626733848552;
        Mon, 19 Jul 2021 15:30:48 -0700 (PDT)
Received: from SEA-ML-00029224.olympus.f5net.com (c-73-19-16-93.hsd1.wa.comcast.net. [73.19.16.93])
        by smtp.gmail.com with ESMTPSA id h17sm20846877pfh.192.2021.07.19.15.30.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jul 2021 15:30:47 -0700 (PDT)
From:   Vincent Li <vincent.mc.li@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, Vincent Li <vincent.mc.li@gmail.com>
Subject: [PATCH bpf-next] selftests, bpf: test_tc_tunnel.sh nc: cannot use -p and -l
Date:   Mon, 19 Jul 2021 15:30:22 -0700
Message-Id: <20210719223022.66681-1-vincent.mc.li@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When run test_tc_tunnel.sh, it complains following error

ipip
encap 192.168.1.1 to 192.168.1.2, type ipip, mac none len 100
test basic connectivity
nc: cannot use -p and -l

nc man page has:

     -l  Listen for an incoming connection rather than initiating
         a connection to a remote host.Cannot be used together with
         any of the options -psxz. Additionally, any timeouts specified
         with the -w option are ignored.

Correct nc in server_listen().

Signed-off-by: Vincent Li <vincent.mc.li@gmail.com>
---
 tools/testing/selftests/bpf/test_tc_tunnel.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh b/tools/testing/selftests/bpf/test_tc_tunnel.sh
index c9dde9b9d987..088fcad138c9 100755
--- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
@@ -69,7 +69,7 @@ cleanup() {
 }
 
 server_listen() {
-	ip netns exec "${ns2}" nc "${netcat_opt}" -l -p "${port}" > "${outfile}" &
+	ip netns exec "${ns2}" nc "${netcat_opt}" -l "${port}" > "${outfile}" &
 	server_pid=$!
 	sleep 0.2
 }
-- 
2.27.0

