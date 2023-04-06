Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3696F6D97D9
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 15:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbjDFNTe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 09:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237873AbjDFNTd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 09:19:33 -0400
Received: from mail-ej1-x664.google.com (mail-ej1-x664.google.com [IPv6:2a00:1450:4864:20::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92C6D3
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 06:19:29 -0700 (PDT)
Received: by mail-ej1-x664.google.com with SMTP id 11so1328366ejw.0
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680787168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNbic2k37/uJb//jGocyCjKfzDNnw7vJzB+19fgD/vU=;
        b=PmB8agJJoKJaEr5tBHeQOZdILV1pcXZy+QW/ctLum/8eFRHAycUl/YdJGL7ZreYdMK
         4PykMxodTpRZ4a97qllo7HHkuXHBWriuPw760bZ/Lk0itCFFXGw/Xn4qVW4z2/9K7xVn
         M6T3ebd8gzRrqh8m+mh9WhittPzXI1w/ge+Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680787168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNbic2k37/uJb//jGocyCjKfzDNnw7vJzB+19fgD/vU=;
        b=duG6mm02jsFIb/0zNuwEYUgBwLdujF/CP1uLE3ZfyxNc4HCpj2KANXWfR7Trpt4Iub
         iU0fVfG41RsxfazjXUU457hWsu4xgNnhQ3PnkyeBM8yCugCsbgUl2cRNYs7CRKrJ9xs7
         ugB0x2saKERsVRpmCYXchVMtBH/9s7y7QWESRAbx75t7im5CrWtkhjU5I+8VBNzkkYJb
         vthVUyvE5sZ967JjNCKVfp3LfmwafTS6tr2XnkuHSD5Mgz4IkDa5AuYeoX43kzkuC+YI
         lQWzndW1xUjc/dKxh6PXu25K7HSN/OEZ0Q4w3hmGp6uPH4Ru01XL5K7ZgHgDtmzI8Ugv
         WTkQ==
X-Gm-Message-State: AAQBX9d3r6Uti7DX+oMfp86h42SGV400dyS/56HfNCa40WHFExTdOSBf
        29TrMa2vInNgaOwnJkwg7N44xJzD4orHEGKvhnLd0Zy6lzPY
X-Google-Smtp-Source: AKy350ZsZ5uE7xfO97H+DmR5/MJweIMwM7CTSiGUyrZsZ91+p/RaG+LqgYUIPT4v8SRoKxHOqwsaUla6mc0o
X-Received: by 2002:a17:907:3f16:b0:8a5:8620:575 with SMTP id hq22-20020a1709073f1600b008a586200575mr8009225ejc.3.1680787168473;
        Thu, 06 Apr 2023 06:19:28 -0700 (PDT)
Received: from fedora.dectris.local (dect-ch-bad-pfw.cyberlink.ch. [62.12.151.50])
        by smtp-relay.gmail.com with ESMTPS id 7-20020a170906014700b00947de8fa946sm137999ejh.201.2023.04.06.06.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 06:19:28 -0700 (PDT)
X-Relaying-Domain: dectris.com
From:   Kal Conley <kal.conley@dectris.com>
To:     Magnus Karlsson <magnus.karlsson@intel.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
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
Subject: [PATCH bpf-next v4 2/3] selftests: xsk: Use hugepages when umem->frame_size > PAGE_SIZE
Date:   Thu,  6 Apr 2023 15:18:05 +0200
Message-Id: <20230406131806.51332-3-kal.conley@dectris.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406131806.51332-1-kal.conley@dectris.com>
References: <20230406131806.51332-1-kal.conley@dectris.com>
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

