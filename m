Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960A55862D3
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 04:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbiHACvV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Jul 2022 22:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239324AbiHACvU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Jul 2022 22:51:20 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA81A7671;
        Sun, 31 Jul 2022 19:51:18 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id q19so44014pfg.8;
        Sun, 31 Jul 2022 19:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=E5/3EPPmTChoHJEmcg7iZTYAVeMR8tAQMUhwyuotXUs=;
        b=biEgmbwdEA6v7Wkbp8qvSR0KX5HVzyDXwGAA7hr4BP7zacsvJsElUKIJ5VraGv+f3L
         PX32CeZGzTD6wzCRr4uxTis8ijaiz+86HM70pUYAToWN9toVKYgV1xu0SVBUYqJWQCle
         aD3Bh+O21nm5RycgkhHCfD+EN5SGyGZ868y6EAQVb4mfG7ALdEWtwxC/MvY1ebRFgCsD
         roEiC+uJ2HPWfzJAKy3yLQzmQ/QOM/rlZiRURDB+6oGqSfKRPr1aLYLXtfMFX2ZBsVvY
         7jDw9cnnuUsSffV8Gr3625pc/k3FQZFadoGzD6DcSbV2vKVzXNysHkIC3zz1Tbue/slD
         rBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=E5/3EPPmTChoHJEmcg7iZTYAVeMR8tAQMUhwyuotXUs=;
        b=iznhs9VP4+w28zJuqaaseiLRHJqbVaPvgGfliKnXGJrrxN6EnFRkGUW8ZJ6sScdcfR
         rFq69aszanOeefIDwz916MqvG0DYrDN69BWipeSY6e8Q7O5R8aF4NrjRgr8wP25RGkFj
         QWtrW1vji6Zxfmo6ZakM7m+QwvZsk6IuMKccalCWcz95+7bY4QFjE3USKKkFt3lIYv/+
         VQzwnEq96oHRFhDDRFW5I3WcXN1bZb5w1MM5g6uGvlbNqgRc+JeaY4eV0T/uEkC+L3zi
         xU/5pV7fWCYnOXh0+Ws48lIH1JP1mIVb5Rq5bUg9tUr87WDTRYmj4LR5qOQ0vRIPHn15
         7A9Q==
X-Gm-Message-State: AJIora86uYrEk5xNQVN+v+y0poetPW2D2/FnIGTf4wtz0z6KSFUQfSWi
        Ju6lg74Vm15Aj7CvdqZSbSrkN0x4XAI=
X-Google-Smtp-Source: AGRyM1twLh8IBKzqyutsuxfScf0IEDrFAw3nFuNWWijoLXoDfCSoEtWBgCPNGzPNGbiUUWxi1TBm9Q==
X-Received: by 2002:a63:f207:0:b0:41b:6137:2b6d with SMTP id v7-20020a63f207000000b0041b61372b6dmr11651724pgh.397.1659322278084;
        Sun, 31 Jul 2022 19:51:18 -0700 (PDT)
Received: from localhost.localdomain (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b0016db7f49cc2sm8132666plg.115.2022.07.31.19.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 19:51:17 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] libbpf: Initialize err in probe_map_create
Date:   Sun, 31 Jul 2022 19:51:09 -0700
Message-Id: <20220801025109.1206633-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

GCC-11 warns about the possibly unitialized err variable in
probe_map_create:

libbpf_probes.c: In function 'probe_map_create':
libbpf_probes.c:361:38: error: 'err' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  361 |                 return fd < 0 && err == exp_err ? 1 : 0;
      |                                  ~~~~^~~~~~~~~~

Fixes: 878d8def0603 ("libbpf: Rework feature-probing APIs")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 tools/lib/bpf/libbpf_probes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 97b06cede56f..6cf44e61815d 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -247,7 +247,7 @@ static int probe_map_create(enum bpf_map_type map_type, __u32 ifindex)
 	LIBBPF_OPTS(bpf_map_create_opts, opts);
 	int key_size, value_size, max_entries;
 	__u32 btf_key_type_id = 0, btf_value_type_id = 0;
-	int fd = -1, btf_fd = -1, fd_inner = -1, exp_err = 0, err;
+	int fd = -1, btf_fd = -1, fd_inner = -1, exp_err = 0, err = 0;
 
 	opts.map_ifindex = ifindex;
 
-- 
2.25.1

