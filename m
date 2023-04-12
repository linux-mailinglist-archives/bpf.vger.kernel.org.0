Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D038A6DFB36
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 18:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjDLQWA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 12:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjDLQVr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 12:21:47 -0400
Received: from mail-lj1-x264.google.com (mail-lj1-x264.google.com [IPv6:2a00:1450:4864:20::264])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D798A4C
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 09:21:33 -0700 (PDT)
Received: by mail-lj1-x264.google.com with SMTP id e3so3729871ljn.1
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 09:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1681316491; x=1683908491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyAv2dean73hIsFLt2c4UWD/sKWcl5Pwsn2aihE0NA4=;
        b=OEBbkab5p2o9hwNukLgtXQ10pDTQGN6E/NQ6CLxGSLRcOZIcse9gSl42k864+87Lbc
         Lw3C/jm5yWY69rPJ6ugZycACRrpIjaPN4iJksV7AsV3ke4CZD0FEvmYqivLrV+SdnOI2
         GOSelxvcS6d+oBM14LB4gLmsYsg8oxUUqyiho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681316491; x=1683908491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyAv2dean73hIsFLt2c4UWD/sKWcl5Pwsn2aihE0NA4=;
        b=Z5YWWmxFhEjeYcp8/eWQGdGwJNP2oS2j75tDI3JbiiXtrUn+jfh6+rclRB6oya/xec
         nIbfgKGKua1rAb7iIGaIXAjA7tIqx80WdKp4a5uy6n3ij727v8ZaDYWgo3YNZidEqhK8
         OTRumsh63WDqeWI+aOMId+RPKfLe2bkhLkeylCvaliV26OsbrGEoeAJIynEw4fvJf4Ny
         OmvE1YrAJHuaWuX9JT+nwz0ZxxDFdwfArV6fHBREEeucx4KXyZjrn8I5QUr4c6IHEqrw
         4LiCDLwc3p2fFbvNWCWGVuQD6di/f9dVx3VZaSOtlICNmYcRfUcfpvsQfrEVteTSwxU5
         +rqg==
X-Gm-Message-State: AAQBX9dqKdaY9213gAgFwyOceWD1jwxfeOQBjS2ucNaz+YpwLQgZARFP
        ZRPPLDhfibJpwnwZibCI6pc0XcauT33J9e9pAll2PY6Nbua5
X-Google-Smtp-Source: AKy350Y62+xWGMlvwfPyJzRmQBZ3FmHXJICDKDqOKLASxBsPsbir+GWE2/0SgcsAlObTzzCN5cfuJfG4MSDT
X-Received: by 2002:a2e:9ed6:0:b0:2a7:9c57:dcab with SMTP id h22-20020a2e9ed6000000b002a79c57dcabmr827151ljk.6.1681316491516;
        Wed, 12 Apr 2023 09:21:31 -0700 (PDT)
Received: from fedora.dectris.local (dect-ch-bad-pfw.cyberlink.ch. [62.12.151.50])
        by smtp-relay.gmail.com with ESMTPS id t19-20020a2e8e73000000b002a77614d960sm2108109ljk.62.2023.04.12.09.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:21:31 -0700 (PDT)
X-Relaying-Domain: dectris.com
From:   Kal Conley <kal.conley@dectris.com>
To:     Magnus Karlsson <magnus.karlsson@intel.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
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
Subject: [PATCH bpf-next v6 3/4] selftests: xsk: Use hugepages when umem->frame_size > PAGE_SIZE
Date:   Wed, 12 Apr 2023 18:21:13 +0200
Message-Id: <20230412162114.19389-4-kal.conley@dectris.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412162114.19389-1-kal.conley@dectris.com>
References: <20230412162114.19389-1-kal.conley@dectris.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

HugeTLB UMEMs now support chunk_size > PAGE_SIZE. Set MAP_HUGETLB when
frame_size > PAGE_SIZE for future tests.

Signed-off-by: Kal Conley <kal.conley@dectris.com>
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 5a9691e942de..7eccf57a0ccc 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -1289,7 +1289,7 @@ static void thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	void *bufs;
 	int ret;
 
-	if (ifobject->umem->unaligned_mode)
+	if (ifobject->umem->frame_size > sysconf(_SC_PAGESIZE) || ifobject->umem->unaligned_mode)
 		mmap_flags |= MAP_HUGETLB;
 
 	if (ifobject->shared_umem)
-- 
2.39.2

