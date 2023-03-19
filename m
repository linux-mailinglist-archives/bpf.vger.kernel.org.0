Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5D96C049C
	for <lists+bpf@lfdr.de>; Sun, 19 Mar 2023 20:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjCST6b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Mar 2023 15:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjCST63 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Mar 2023 15:58:29 -0400
Received: from mail-wm1-x364.google.com (mail-wm1-x364.google.com [IPv6:2a00:1450:4864:20::364])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7825119688
        for <bpf@vger.kernel.org>; Sun, 19 Mar 2023 12:58:27 -0700 (PDT)
Received: by mail-wm1-x364.google.com with SMTP id p34so1206433wms.3
        for <bpf@vger.kernel.org>; Sun, 19 Mar 2023 12:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1679255905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nzhJU6njL7XEZj6il8iXiFFoFqCcRBJtzWCK3ymWFE=;
        b=cJAdwoiDxME6HDr6jd1AxR2oZQEsNJV4S0psy5LKclGbV1dvk5+kYjYQzmZy2yTUhA
         RnyUZTMVi5F8rBsdR7iFOOOL2h7vVSwpTb2jSslnN4PNXiR7Uc1by5jdqIj6NnNVw4Ek
         ypNh9e/6qUOu7emSPdH1fT7s91auCywmFYEEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679255905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nzhJU6njL7XEZj6il8iXiFFoFqCcRBJtzWCK3ymWFE=;
        b=ekQKEJacJhc2i8gPHO/uxtcs/c2GR+AhHvyI/O+FsaRbcn0ANlT7m8dAFi2A20p872
         e/jsiOrBfwkfOHtD8f1J0spqAtEd+P2v2UL99qdvoIW/t6tMz1mEkwMex1eIf1Ho0IC8
         cQeUcA+UXCrjJnMUSUOiN4laApkiJ5UyoQz9X0A/piW8imQZtqtPOsJKxEBeiFVYNXZ8
         6uAtNGqBND9vQi4Ndzi6YSdVNJbFqbROLq/Cf6+N5aGwUQMblvoUmwzoSho1bqksagGO
         +p/nOhG5hh+gp++4fop4+T6Z3zzVRQI7gv0H/yMtAneRlBM6GqAvOmSM2NAwPrEXsfxU
         SaLw==
X-Gm-Message-State: AO0yUKV1XkB2msdB8K/kTEiAtCq+OVkziyo/616tfg2OHcXJLkbcU+9n
        HJbptD0BtFAqc7jLTM52IYQYumRNHworeO8R6T5VF/+5GAAh
X-Google-Smtp-Source: AK7set93xBMvfuoZl5+kZfN9Qov/ysd+IKiWOR4q5Wxkq9SBMcH4oabsNRORdj7xcE5vrQk7sX8Y/z8FPuv6
X-Received: by 2002:a05:600c:3d95:b0:3eb:5990:aea4 with SMTP id bi21-20020a05600c3d9500b003eb5990aea4mr7646047wmb.12.1679255905592;
        Sun, 19 Mar 2023 12:58:25 -0700 (PDT)
Received: from fedora.dectris.local (dect-ch-bad-pfw.cyberlink.ch. [62.12.151.50])
        by smtp-relay.gmail.com with ESMTPS id m26-20020a7bca5a000000b003b499f88f52sm2728807wml.7.2023.03.19.12.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 12:58:25 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/3] selftests: xsk: Use hugepages when umem->frame_size > PAGE_SIZE
Date:   Sun, 19 Mar 2023 20:56:55 +0100
Message-Id: <20230319195656.326701-3-kal.conley@dectris.com>
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

HugeTLB UMEMs now support chunk_size > PAGE_SIZE. Set MAP_HUGETLB when
frame_size > PAGE_SIZE for future tests.

Signed-off-by: Kal Conley <kal.conley@dectris.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index a17655107a94..7a47ef28fbce 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -1265,7 +1265,7 @@ static void thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	void *bufs;
 	int ret;
 
-	if (ifobject->umem->unaligned_mode)
+	if (ifobject->umem->frame_size > sysconf(_SC_PAGESIZE) || ifobject->umem->unaligned_mode)
 		mmap_flags |= MAP_HUGETLB;
 
 	if (ifobject->shared_umem)
-- 
2.39.2

