Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333E96C049F
	for <lists+bpf@lfdr.de>; Sun, 19 Mar 2023 20:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCST6h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Mar 2023 15:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjCST6c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Mar 2023 15:58:32 -0400
Received: from mail-wm1-x362.google.com (mail-wm1-x362.google.com [IPv6:2a00:1450:4864:20::362])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC8B193DA
        for <bpf@vger.kernel.org>; Sun, 19 Mar 2023 12:58:29 -0700 (PDT)
Received: by mail-wm1-x362.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so6298423wmq.1
        for <bpf@vger.kernel.org>; Sun, 19 Mar 2023 12:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1679255908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ugxvd8UKF7NxIIzphZkT6ey/EusNfyQo98VW+VJFOiI=;
        b=KVi2bUlaxkySvVdD7fhFj3qNpgz5FCFnpwYkhvQvB+1g/8EtZhSYaen0b7yYjGGYuF
         NL0NWeX+eOgD6zmL90OXF54N7JhNozKky3ouuw3FVLEWT+DtvaQIE+/cqM2OPjCaqy2V
         FHmk9p2o9CBGvChm+kdqqvbXoFs5/aQnY3voQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679255908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ugxvd8UKF7NxIIzphZkT6ey/EusNfyQo98VW+VJFOiI=;
        b=luar4lbodrLkrYz4UZ+s4D5p+ZSg1dI0mTRG5KPIhOhLkhAVg9UVkO5ROQ0hzYlSi0
         JqQF7MeGLfYLbqAAqUP0KwsE3fvWkwqRDib51+NMTV+lqYF1Rfd5aRAQBQabrTvPqI1W
         6q/lIc8VQwG8+CHMmwb7ai8tUSNeQQYCCJLcdS4nIHLSH5ui+k3O1tmbGRFXLzdLEBCE
         OqgrgE540KkZF16WW4OV66kkTLhAYYL0jcuLjrTlQEd2VMGzzNJF33/GLPpMF2vz9VjG
         uK3dbykTTBDmRIqxE9mylXPmHAybdarJ3+20gDKXDK1zEgvtegJUu1uBD6/V826ANGa1
         GIog==
X-Gm-Message-State: AO0yUKXkP12Sdosr6iBrkaLzufvV7caUigJzllwu0hK6URbyxJEDxtMG
        aEM9OTU8blKmXKr64n4EVoCW99uz5rzxReJOY5mmZ4SWM4hn
X-Google-Smtp-Source: AK7set+3PKHJJmz3XmMQAw6iCJpB6/q2hhXE/qAPOBhgn9qUnFXl5SWdKtZpa8Pn+dkZw+C8wHGU2K+Wzh2w
X-Received: by 2002:a1c:ed16:0:b0:3ed:a45d:aee9 with SMTP id l22-20020a1ced16000000b003eda45daee9mr4993314wmh.39.1679255908000;
        Sun, 19 Mar 2023 12:58:28 -0700 (PDT)
Received: from fedora.dectris.local (dect-ch-bad-pfw.cyberlink.ch. [62.12.151.50])
        by smtp-relay.gmail.com with ESMTPS id m26-20020a7bca5a000000b003b499f88f52sm2728807wml.7.2023.03.19.12.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 12:58:27 -0700 (PDT)
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
Subject: [PATCH bpf-next 3/3] selftests: xsk: Add tests for 8K and 9K frame sizes
Date:   Sun, 19 Mar 2023 20:56:56 +0100
Message-Id: <20230319195656.326701-4-kal.conley@dectris.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230319195656.326701-1-kal.conley@dectris.com>
References: <20230319195656.326701-1-kal.conley@dectris.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests:
- RUN_TO_COMPLETION_8K_FRAME_SIZE: frame_size=8192 (aligned)
- RUN_TO_COMPLETION_9K_FRAME_SIZE: frame_size=9000 (unaligned)

Signed-off-by: Kal Conley <kal.conley@dectris.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 24 ++++++++++++++++++++++++
 tools/testing/selftests/bpf/xskxceiver.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 7a47ef28fbce..f10ff8c5e9c5 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -1789,6 +1789,30 @@ static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_
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
+	case TEST_TYPE_RUN_TO_COMPLETION_9K_FRAME:
+		if (!hugepages_present(test->ifobj_tx)) {
+			ksft_test_result_skip("No 2M huge pages present.\n");
+			return;
+		}
+		test_spec_set_name(test, "RUN_TO_COMPLETION_9K_FRAME_SIZE");
+		test->ifobj_tx->umem->frame_size = 9000;
+		test->ifobj_rx->umem->frame_size = 9000;
+		test->ifobj_tx->umem->unaligned_mode = true;
+		test->ifobj_rx->umem->unaligned_mode = true;
+		pkt_stream_replace(test, DEFAULT_PKT_CNT, PKT_SIZE);
+		testapp_validate_traffic(test);
+		break;
 	case TEST_TYPE_RX_POLL:
 		test->ifobj_rx->use_poll = true;
 		test_spec_set_name(test, "POLL_RX");
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index 3e8ec7d8ec32..ff723b6d7852 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -70,6 +70,8 @@ enum test_mode {
 enum test_type {
 	TEST_TYPE_RUN_TO_COMPLETION,
 	TEST_TYPE_RUN_TO_COMPLETION_2K_FRAME,
+	TEST_TYPE_RUN_TO_COMPLETION_8K_FRAME,
+	TEST_TYPE_RUN_TO_COMPLETION_9K_FRAME,
 	TEST_TYPE_RUN_TO_COMPLETION_SINGLE_PKT,
 	TEST_TYPE_RX_POLL,
 	TEST_TYPE_TX_POLL,
-- 
2.39.2

