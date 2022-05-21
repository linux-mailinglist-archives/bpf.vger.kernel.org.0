Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB8052FCDA
	for <lists+bpf@lfdr.de>; Sat, 21 May 2022 15:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbiEUNZa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 21 May 2022 09:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355031AbiEUNZa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 21 May 2022 09:25:30 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95887606E7
        for <bpf@vger.kernel.org>; Sat, 21 May 2022 06:25:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nr2-20020a17090b240200b001df2b1bfc40so13654948pjb.5
        for <bpf@vger.kernel.org>; Sat, 21 May 2022 06:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=urg7HfnilktPs2aIRMbLMbkmP5FphJkEQhbOUOa4EG8=;
        b=g8cPnHm4wJgtKSWeZko3Fc3xmGjDNsxgVJx2YQl7RmtI8no1zVjk/exR1G++jSyFTH
         Hj09zQ/br7b062JZkQUoUWQmbyPXqy+OARTNJYBsoh8okprwx+XjjQ7dhh1e1mIY3bGB
         gKkaT5xi1e+IswCEzSZxGV6W4sA/PJ6RZ8u6Y/EXEDDlWlb0KAJKAU6qp/QVVGLhwBRg
         DV4jMi/IDpGfZKuu0PhPB6AHlLeXdi4GUkA9q1yheaLNU682czo3NbARTIrpHuMIWFVB
         AniwdqWXy8YXlDWADPwwo7wHr8QDrO5dV/q0L0BWImBvCqVAJVmPfYqHSv0nKy4YKVKR
         NDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=urg7HfnilktPs2aIRMbLMbkmP5FphJkEQhbOUOa4EG8=;
        b=JiyN/gNK0dRd/5GcZ47xiPAUzL/IwsLVP2NwXoTFOoKg2GHoF4QAl3dAnZi2zJy4k4
         9ydDYRXPY/iRVAe1O7ajq1cSlw/vru7z8eY7be1LMmin/rKsb7lde1xfjPe561q34OZC
         S7h7jS+j7bOzeDfzDK04xU9u/wC17/SddDUab4HGr/XPqaVFJW1WMhFHmYVI5H2VTd/f
         9jQz37kgtodlw5Ul4FVLcEn+ZYM7YkBpUZIdVD+JIiUc2Gr7A2beYGi37UTxDuoMwClQ
         i51thx73BveYvCj+4Y6sSMMlgXr/yxLhRWpoNYBnMqPeqcbpGPvQwydeyqqQJPjDx0DI
         c1bA==
X-Gm-Message-State: AOAM531fxn7a8UBpbYS0winBJumoOjmZYmM11s6So2wt7mv2nauoPd/P
        OKaE1Q56GN41d+wLxJe+jMxVbKYymX0=
X-Google-Smtp-Source: ABdhPJyUBqR9jvPUgtrSC42KCbNuENT7UtqX+SbXrt/LmMTQDRLHEUUeX7twzkJTGXqP6NEzP3UX7w==
X-Received: by 2002:a17:90a:4f0a:b0:1df:b37b:75b1 with SMTP id p10-20020a17090a4f0a00b001dfb37b75b1mr17132642pjh.199.1653139528940;
        Sat, 21 May 2022 06:25:28 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id cw25-20020a056a00451900b0050dc76281d3sm3665587pfb.173.2022.05.21.06.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 06:25:28 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next] bpf: Suppress 'passing zero to PTR_ERR' warning
Date:   Sat, 21 May 2022 18:56:20 +0530
Message-Id: <20220521132620.1976921-1-memxor@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kernel Test Robot complains about passing zero to PTR_ERR for the said
line, suppress it by using PTR_ERR_OR_ZERO.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 14e8c17d3d8d..45153cbc2bd6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5352,7 +5352,7 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 		return -EINVAL;
 	}
 	if (!map_value_has_kptrs(map_ptr)) {
-		ret = PTR_ERR(map_ptr->kptr_off_tab);
+		ret = PTR_ERR_OR_ZERO(map_ptr->kptr_off_tab);
 		if (ret == -E2BIG)
 			verbose(env, "map '%s' has more than %d kptr\n", map_ptr->name,
 				BPF_MAP_VALUE_OFF_MAX);
--
2.36.1

