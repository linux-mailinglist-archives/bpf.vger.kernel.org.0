Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62FD6CF1DB
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 20:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjC2SIv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 14:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjC2SIV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 14:08:21 -0400
Received: from mail-ed1-x562.google.com (mail-ed1-x562.google.com [IPv6:2a00:1450:4864:20::562])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B4D65B8
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 11:08:11 -0700 (PDT)
Received: by mail-ed1-x562.google.com with SMTP id ek18so66807744edb.6
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 11:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680113291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPoyIAdL7R3dFOvlNYTf6qBsx+voZAd+nmyiSJz/hmk=;
        b=iNQKUbUQv4rmNqH8vbFGuMkYVHzB8ujbeimo9lcg0Az7EyrB4qgnb7XilOT1DDchLc
         EdokyaKindLWKbyYSvJQ7AvPuU2muF1ShsPqgqMvJad6ioy93reX3YZnxHDCtX7k6pi+
         MaIwjg3GMpKAP8DSMYACvTdfiVekzB4Of66oM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680113291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPoyIAdL7R3dFOvlNYTf6qBsx+voZAd+nmyiSJz/hmk=;
        b=7GuLigDqcgo8z3i9uUKocT+O1gtF57+OJlQb8MZ0kO7O4GY0ZxKKPDPIJcITbbmXDW
         4wJ0dnaZTsSO6KrtW6ElPtaqRX86L4uyAeToWGMbUDYTMJ55CAvH3+MzM4HfC/PRqYyE
         C33nYtT6CyQgk0mY7kDh5eQNq6afHCsQLKGTmoKb9/vH/l3gAhRh4tgiXojot6Bs2UOi
         arecRlOLopi2u0LezZ7qd+c8wWH7hETxTmyeFK4C6MO/zWopdskeMMKKSbE/LF4HD6vE
         fgnHMyFthQw4+HrRKlUMmauHnJ0WJrFbaLBjhGjoiakdO4SNAXCc3+yj6CFVqRRPXE8h
         VDXQ==
X-Gm-Message-State: AAQBX9dlkBz8NWrDPlfk1wjmnrF7th/Azt7E9cMcEHH6CwxLsvLusySH
        Bqaz3BPov3zihXjU0I5othb+uo/VyLhEM2hG1UKpXuOmyr/e
X-Google-Smtp-Source: AKy350ZQMWCGePKnVaO5B7F0bPYL4LdNVb+jsAYGhBNUPtXHcN9KN5VYh5ajl9dihSeTQKLUlVpPrE2PSGNc
X-Received: by 2002:a17:907:7fa3:b0:8f0:143d:ee34 with SMTP id qk35-20020a1709077fa300b008f0143dee34mr3429202ejc.1.1680113291130;
        Wed, 29 Mar 2023 11:08:11 -0700 (PDT)
Received: from fedora.dectris.local (dect-ch-bad-pfw.cyberlink.ch. [62.12.151.50])
        by smtp-relay.gmail.com with ESMTPS id m10-20020a1709066d0a00b00920438f59b3sm12072998ejr.154.2023.03.29.11.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:08:11 -0700 (PDT)
X-Relaying-Domain: dectris.com
From:   Kal Conley <kal.conley@dectris.com>
To:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc:     Kal Conley <kal.conley@dectris.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 10/10] selftests: xsk: Add tests for 8K and 9K frame sizes
Date:   Wed, 29 Mar 2023 20:05:02 +0200
Message-Id: <20230329180502.1884307-11-kal.conley@dectris.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329180502.1884307-1-kal.conley@dectris.com>
References: <20230329180502.1884307-1-kal.conley@dectris.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests:
- RUN_TO_COMPLETION_8K_FRAME_SIZE: frame_size=8192 (aligned)
- UNALIGNED_9K_FRAME_SIZE: frame_size=9000 (unaligned)

Signed-off-by: Kal Conley <kal.conley@dectris.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 25 ++++++++++++++++++++++++
 tools/testing/selftests/bpf/xskxceiver.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index f73bc6ff5c3d..fb5ba225b652 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -1841,6 +1841,17 @@ static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_
 		pkt_stream_replace(test, DEFAULT_PKT_CNT, PKT_SIZE);
 		testapp_validate_traffic(test);
 		break;
+	case TEST_TYPE_RUN_TO_COMPLETION_8K_FRAME:
+		if (!hugepages_present(test->ifobj_tx)) {
+			ksft_test_result_skip("No 2M huge pages present.\n");
+			return;
+		}
+		test_spec_set_name(test, "RUN_TO_COMPLETION_8K_FRAME_SIZE");
+		test->ifobj_tx->umem->frame_size = 8192;
+		test->ifobj_rx->umem->frame_size = 8192;
+		pkt_stream_replace(test, DEFAULT_PKT_CNT, PKT_SIZE);
+		testapp_validate_traffic(test);
+		break;
 	case TEST_TYPE_RX_POLL:
 		test->ifobj_rx->use_poll = true;
 		test_spec_set_name(test, "POLL_RX");
@@ -1905,6 +1916,20 @@ static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_
 		if (!testapp_unaligned(test))
 			return;
 		break;
+	case TEST_TYPE_UNALIGNED_9K_FRAME:
+		if (!hugepages_present(test->ifobj_tx)) {
+			ksft_test_result_skip("No 2M huge pages present.\n");
+			return;
+		}
+		test_spec_set_name(test, "UNALIGNED_9K_FRAME_SIZE");
+		test->ifobj_tx->umem->frame_size = 9000;
+		test->ifobj_rx->umem->frame_size = 9000;
+		test->ifobj_tx->umem->unaligned_mode = true;
+		test->ifobj_rx->umem->unaligned_mode = true;
+		pkt_stream_replace(test, DEFAULT_PKT_CNT, PKT_SIZE);
+		test->ifobj_rx->pkt_stream->use_addr_for_fill = true;
+		testapp_validate_traffic(test);
+		break;
 	case TEST_TYPE_HEADROOM:
 		testapp_headroom(test);
 		break;
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index 919327807a4e..7f52f737f5e9 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -69,12 +69,14 @@ enum test_mode {
 enum test_type {
 	TEST_TYPE_RUN_TO_COMPLETION,
 	TEST_TYPE_RUN_TO_COMPLETION_2K_FRAME,
+	TEST_TYPE_RUN_TO_COMPLETION_8K_FRAME,
 	TEST_TYPE_RUN_TO_COMPLETION_SINGLE_PKT,
 	TEST_TYPE_RX_POLL,
 	TEST_TYPE_TX_POLL,
 	TEST_TYPE_POLL_RXQ_TMOUT,
 	TEST_TYPE_POLL_TXQ_TMOUT,
 	TEST_TYPE_UNALIGNED,
+	TEST_TYPE_UNALIGNED_9K_FRAME,
 	TEST_TYPE_ALIGNED_INV_DESC,
 	TEST_TYPE_ALIGNED_INV_DESC_2K_FRAME,
 	TEST_TYPE_UNALIGNED_INV_DESC,
-- 
2.39.2

