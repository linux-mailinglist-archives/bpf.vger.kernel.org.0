Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC62C6D978E
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 15:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbjDFNCs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 09:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbjDFNCp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 09:02:45 -0400
Received: from mail-wr1-x462.google.com (mail-wr1-x462.google.com [IPv6:2a00:1450:4864:20::462])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF5C83FD
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 06:02:38 -0700 (PDT)
Received: by mail-wr1-x462.google.com with SMTP id v1so39444537wrv.1
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 06:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680786157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNbic2k37/uJb//jGocyCjKfzDNnw7vJzB+19fgD/vU=;
        b=fYGBsedO7sFGOwkuHkxlhxHdXQ5kL1JPCs+UK404gumJcIWP5To2X9LbN8Uu0zXRtp
         cFQizxbm8foNz1Iz01EY4Hf3rHlzhX34AB1b1usIpK9Akz3bisg30VWafpA26T6437sT
         V4IIF2WXJA3F9mAwJ+A+wXmSmRPn3NY37zBGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680786157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNbic2k37/uJb//jGocyCjKfzDNnw7vJzB+19fgD/vU=;
        b=gyvrZyoxfHp4k2Tz+CufbgOb0dN0HzEL+T6OQDeFhMWK/3sb+IHEystcdYhmH2IBLA
         rSH3th5SFOuHnakFQoV+diSv0k+mqgPvUp5rC5d7JuKdHmAqoxz4jEBJkiMbnzptnoIB
         oKrcpiAVEl+lRnQqz7/X1zyGPy3GaS5k6s2uX+zvZqDXDaYq08ZLgh7uClpOI6q5R2uU
         /D09MB5av8kLZobrpTJK3Qlf8pwOMrOwwFxwk723ATZQfn3K3xvW4RM+oEzLE6QbnR55
         K3KS/shG63Kd3TYPC8Hp5oIlV6NxhSvcyR569ul+pra3DXu1my4xge8tcgk8buvKPp64
         vLDg==
X-Gm-Message-State: AAQBX9cCuYHKsev2Svmvu1MXRumHt+kjSfj+Ja8Pzc4T84ElG1bkI2xv
        QOY4NoybZEwdZnvEFm+xbkfngkbzERNLpesM8f89pQHK6XEv
X-Google-Smtp-Source: AKy350Z7nWji5jZ/JhutfeuyyKpRm9ttRpjaDA26u8AtYWHHXOQbl1G71/2HXI1EXyGCEsSgLhbgJwy3mUrX
X-Received: by 2002:a5d:4cc2:0:b0:2cf:f44e:45e1 with SMTP id c2-20020a5d4cc2000000b002cff44e45e1mr5992704wrt.19.1680786156773;
        Thu, 06 Apr 2023 06:02:36 -0700 (PDT)
Received: from fedora.dectris.local (dect-ch-bad-pfw.cyberlink.ch. [62.12.151.50])
        by smtp-relay.gmail.com with ESMTPS id s3-20020adfeb03000000b002e62dd5b3d6sm65625wrn.3.2023.04.06.06.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 06:02:36 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/3] selftests: xsk: Use hugepages when umem->frame_size > PAGE_SIZE
Date:   Thu,  6 Apr 2023 15:02:04 +0200
Message-Id: <20230406130205.49996-3-kal.conley@dectris.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406130205.49996-1-kal.conley@dectris.com>
References: <20230406130205.49996-1-kal.conley@dectris.com>
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

HugeTLB UMEMs now support chunk_size > PAGE_SIZE. Set MAP_HUGETLB when
frame_size > PAGE_SIZE for future tests.

Signed-off-by: Kal Conley <kal.conley@dectris.com>
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

