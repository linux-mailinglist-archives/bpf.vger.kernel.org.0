Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13AA6CF1C0
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 20:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjC2SII (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 14:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjC2SIH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 14:08:07 -0400
Received: from mail-ed1-x563.google.com (mail-ed1-x563.google.com [IPv6:2a00:1450:4864:20::563])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A277649D5
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 11:08:05 -0700 (PDT)
Received: by mail-ed1-x563.google.com with SMTP id er13so25793056edb.9
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 11:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680113284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FndVMXQ48NmaMTKqtO1ulaQVEXkhQgQUYelFrcn8/tk=;
        b=goalJZEkY8oIQ4XWh8u26N0oAhUsnx/OGzWFHwY+BEKeZXv+4ItDLI08lnxtvpjGNl
         N2DH4gUPUAW5IKHrvUlf1ArArAj1i99oUvGgt6CN6gtqcwmZEsa9eGeZTs59pGAtkWur
         1ihwsZ28FvzyFXPihAj000bu0Rr93mh4ozkE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680113284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FndVMXQ48NmaMTKqtO1ulaQVEXkhQgQUYelFrcn8/tk=;
        b=jfZ+RpHudkeaDe5VtjbF8N3/BENuP+ijdrMKnDaTTeS/rEYH2UZsYw4wgH2OMDJk4M
         zQQIYaS9S2gv1erJbbiaC3FsTedLGgWoeLc5/wEIOCjfNb3kib38aT0V653aAgVKkVXa
         seiFXkb4tSErmZK0gv6NMfB9ZZzSsM4yLIVS6gJrxADy/zwfR9vmH0DGk1JY1kxV5oJV
         K9h5VFX0bXB8O5lLitbXFsnXACtDlQYHAZAe2XtDjwS6dEymmyNKPTj4TapoaD6u3k2M
         S5+Er/upmAQZ9FDhsc/ynuMCwxhNi/RhKbVXt6Hhwio6pWb8kNy+B2P4cTqcwNl+0fLh
         GayQ==
X-Gm-Message-State: AAQBX9dQB61lflOLHRvIAhGEjfxYiOqGISTBEnvtjfhldXa11cQgFgPF
        Sxclu+lsKV72ICrU6WD+mgbk/OfvZj/2GeaRB71/4TcxkRNJ
X-Google-Smtp-Source: AKy350Y01hX7iRmc2xxzvWLh+7WjQqMOHm0QkSS4Z8BMosMMKVb1bBzQkoWPUxennOdKe9OP6Lqkmeo4eHfC
X-Received: by 2002:a17:906:3592:b0:934:8043:ebf8 with SMTP id o18-20020a170906359200b009348043ebf8mr20517198ejb.26.1680113284096;
        Wed, 29 Mar 2023 11:08:04 -0700 (PDT)
Received: from fedora.dectris.local (dect-ch-bad-pfw.cyberlink.ch. [62.12.151.50])
        by smtp-relay.gmail.com with ESMTPS id m10-20020a1709066d0a00b00920438f59b3sm12072998ejr.154.2023.03.29.11.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:08:04 -0700 (PDT)
X-Relaying-Domain: dectris.com
From:   Kal Conley <kal.conley@dectris.com>
To:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Kal Conley <kal.conley@dectris.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 02/10] selftests: xsk: Use correct UMEM size in testapp_invalid_desc
Date:   Wed, 29 Mar 2023 20:04:54 +0200
Message-Id: <20230329180502.1884307-3-kal.conley@dectris.com>
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

Avoid UMEM_SIZE macro in testapp_invalid_desc which is incorrect when
the frame size is not XSK_UMEM__DEFAULT_FRAME_SIZE. Also remove the
macro since it's no longer being used.

Fixes: 909f0e28207c ("selftests: xsk: Add tests for 2K frame size")
Signed-off-by: Kal Conley <kal.conley@dectris.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 9 +++++----
 tools/testing/selftests/bpf/xskxceiver.h | 1 -
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index b65e0645b0cd..3956f5db84f3 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -1652,6 +1652,7 @@ static void testapp_single_pkt(struct test_spec *test)
 
 static void testapp_invalid_desc(struct test_spec *test)
 {
+	u64 umem_size = test->ifobj_tx->umem->num_frames * test->ifobj_tx->umem->frame_size;
 	struct pkt pkts[] = {
 		/* Zero packet address allowed */
 		{0, PKT_SIZE, 0, true},
@@ -1662,9 +1663,9 @@ static void testapp_invalid_desc(struct test_spec *test)
 		/* Packet too large */
 		{0x2000, XSK_UMEM__INVALID_FRAME_SIZE, 0, false},
 		/* After umem ends */
-		{UMEM_SIZE, PKT_SIZE, 0, false},
+		{umem_size, PKT_SIZE, 0, false},
 		/* Straddle the end of umem */
-		{UMEM_SIZE - PKT_SIZE / 2, PKT_SIZE, 0, false},
+		{umem_size - PKT_SIZE / 2, PKT_SIZE, 0, false},
 		/* Straddle a page boundrary */
 		{0x3000 - PKT_SIZE / 2, PKT_SIZE, 0, false},
 		/* Straddle a 2K boundrary */
@@ -1682,8 +1683,8 @@ static void testapp_invalid_desc(struct test_spec *test)
 	}
 
 	if (test->ifobj_tx->shared_umem) {
-		pkts[4].addr += UMEM_SIZE;
-		pkts[5].addr += UMEM_SIZE;
+		pkts[4].addr += umem_size;
+		pkts[5].addr += umem_size;
 	}
 
 	pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts));
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index bdb4efedf3a9..cc24ab72f3ff 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -53,7 +53,6 @@
 #define THREAD_TMOUT 3
 #define DEFAULT_PKT_CNT (4 * 1024)
 #define DEFAULT_UMEM_BUFFERS (DEFAULT_PKT_CNT / 4)
-#define UMEM_SIZE (DEFAULT_UMEM_BUFFERS * XSK_UMEM__DEFAULT_FRAME_SIZE)
 #define RX_FULL_RXQSIZE 32
 #define UMEM_HEADROOM_TEST_SIZE 128
 #define XSK_UMEM__INVALID_FRAME_SIZE (XSK_UMEM__DEFAULT_FRAME_SIZE + 1)
-- 
2.39.2

