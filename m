Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2D757E0E1
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 13:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbiGVLgL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 07:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiGVLgL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 07:36:11 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9B4AF86B
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 04:36:09 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e15so5524209edj.2
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 04:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xVXAp1mjr259BrvsjKA1qGL2+daaYRYQfZc/rTiRhU0=;
        b=iWl4CRm3uvIKQRaVqlldCze5IFSxrpRcxMG3jaZ+0A4rj2g1MldsNaok8TVdGF2ZVq
         1KT5fnOCc2UEYMmNEm5lnN7YY/DXqwwm2L6Mxaa+dGzGBh+uWPRnciP7Uw0q1pUPOhBJ
         rFvjXLQ/ZyDYhXzmFhhJ6O0fNt99Cw1fngEtzzzzBTJmYMVbspfof68xhg/i1tBMrsbS
         0PcMbLV9Qp+xGj6HCkLL0dqT35zlEsKhFqFueFI8Xk8SYQ4hsQX07WsAcXGHV4vRcouz
         I/tgiWB6HYZvtCHNCJ/ADTRxUJ50PJk4NnDvVAprA+88wCmf1zO6BYvVk7B9bYI8XEq9
         bhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xVXAp1mjr259BrvsjKA1qGL2+daaYRYQfZc/rTiRhU0=;
        b=gRWl3T8DWx0cLDM31ZO6gp15JJOFwu4yLo6gZeURZjwiSHC++9Xj0oL+J3W3pjUHBH
         JDN/ASdLHDF8+canGEULfwYJ7HmG3QeECOtBpZDj7MX0eV5xoWbyWuzu0UxBgUya8/zi
         b0ZIjBwgq3bl7H0bawZ/Xd1eyH2cvLim6NSi5dNHcX9LLDBlMYc1kSyH/m+NAQGmfoe0
         VtnNZNdkpgaDfkoYKNrvAsMfVBc4CZgtHEHmuEsLR/9/u69AZy8U0/fwFkK7OC58SqVO
         hEnR0AfHB8AmydqiNFECD7Hbn+8wAeKBM8Tu6WIWszEwQDR5+GfINd5eenhU05vm4tAu
         rw6Q==
X-Gm-Message-State: AJIora8OAY/Tnln1W0w1sEfYgzm9gxgRDEcuaHuXWwQR1AYp1tjCMdvU
        xw5xwhHG5SbH/cs0jSjv/cwvWTHM4kfIhA==
X-Google-Smtp-Source: AGRyM1vxH0laxfF0BjSfeMuBk+u+aJG84eQ6Prxxi/CYgEGsiw/8YRb4igCnsuUx+fEOYHcwqpsTAQ==
X-Received: by 2002:a05:6402:294c:b0:43a:91a9:a691 with SMTP id ed12-20020a056402294c00b0043a91a9a691mr188930edb.182.1658489767847;
        Fri, 22 Jul 2022 04:36:07 -0700 (PDT)
Received: from localhost (icdhcp-1-189.epfl.ch. [128.178.116.189])
        by smtp.gmail.com with ESMTPSA id gx27-20020a1709068a5b00b0072ed9efc9dfsm1920636ejc.48.2022.07.22.04.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 04:36:07 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next] bpf: Fix build error in case of !CONFIG_DEBUG_INFO_BTF
Date:   Fri, 22 Jul 2022 13:36:05 +0200
Message-Id: <20220722113605.6513-1-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407; i=memxor@gmail.com; h=from:subject; bh=KVBThGw3gMjaxo95/bOtV97nrlSwFW9QIwm2+fZjAJo=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBi2osziyPbK3fffIZ50jOH++0OwmiL4eoGAqRuOIFQ IK0NBsyJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYtqLMwAKCRBM4MiGSL8RyosHEA Cf2G5T04U9LYQ65D8eiv/crGVA8x30e0w7SHkJiPXWj5HVx5EhwaTDyTVOwu7A57Pn7je8PQuzlIA9 HeSUmsKhvaVTWNQe4RQKZYRVVDxBLpm6amPVsJs/DlqMAlB059tGMmT2yk2B8MdlyHFOfPAv7oUPEP /KotKbge13GLRnSO4027fuUvrL+2y1F8Uu6ODCp+rigL87bjeKlyr3ooZt333vEdz6GeObYoLKnanT GhLZvJK4N6//2QgeSUrXq8fKmmFtnM9aYOJ86yNE1zYRuikEni713oid1oE/SeCj9nqiWFYEbv/BS9 HrQhrg3LselIpwrycvW9UY5rtg6KeCS4LNjI2sFeGnRrPrFGzDnJQJ6LOrWt9H35odmmvgf5UKZVS7 +Wi38ldCg/dxUFjyzdJYwFcp2csDEbGOSWMpbU3HCIQhu96q1OkTQdSZg2/PepWhZUYo615bawGdRs BSDDH46bqY8ffmMHZTbOkGwHbQK2lfbdeSRWux7WQ53GowtqzDgsWyDiOroX0S+n3GpTfq/mkxISxn fA7MxJ+XpCF4Oph515PA8AgSbqvhIKoIYXMa4rTqY8rszPjUS4CuPjE3Pb62u6uot5VHAQCrWD7cgU t17tCyWUAn7qvYgmoHdKJ1oQrgV74lgsNpI2AoYn7PAnfqjp/rpU55NIbN2g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BTF_ID_FLAGS macro needs to be able to take 0 or 1 args, so make it a
variable argument. BTF_SET8_END is incorrect, it should just be empty.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: ab21d6063c01 ("bpf: Introduce 8-byte BTF set")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/btf_ids.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 3cb0741e71d7..2aea877d644f 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -206,7 +206,7 @@ extern struct btf_id_set8 name;

 #define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
 #define BTF_ID(prefix, name)
-#define BTF_ID_FLAGS(prefix, name, flags)
+#define BTF_ID_FLAGS(prefix, name, ...)
 #define BTF_ID_UNUSED
 #define BTF_ID_LIST_GLOBAL(name, n) u32 __maybe_unused name[n];
 #define BTF_ID_LIST_SINGLE(name, prefix, typename) static u32 __maybe_unused name[1];
@@ -215,7 +215,7 @@ extern struct btf_id_set8 name;
 #define BTF_SET_START_GLOBAL(name) static struct btf_id_set __maybe_unused name = { 0 };
 #define BTF_SET_END(name)
 #define BTF_SET8_START(name) static struct btf_id_set8 __maybe_unused name = { 0 };
-#define BTF_SET8_END(name) static struct btf_id_set8 __maybe_unused name = { 0 };
+#define BTF_SET8_END(name)

 #endif /* CONFIG_DEBUG_INFO_BTF */

--
2.34.1

