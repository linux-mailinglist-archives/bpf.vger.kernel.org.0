Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC406C93A4
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 11:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjCZJxy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 05:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCZJxy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 05:53:54 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855F36EAD
        for <bpf@vger.kernel.org>; Sun, 26 Mar 2023 02:53:53 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x15so5192326pjk.2
        for <bpf@vger.kernel.org>; Sun, 26 Mar 2023 02:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679824433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N/I4LeWmE6EvrVpsmoVRWWvX5meb8yBJhzJg6H+eI90=;
        b=jmj9HgFKFauhJx4dgKN6DjuLuSyY4yUVFxpAXeKiLsN/AUJNd9a9yr27LjL7lREAGh
         QCndMGUHNuIjUxMYf/XgP27HeeFVkLJqyP+YBJlTshf57+GlocYFgmgMk4Yq9mFeDCtX
         uokt+oO2XaIwB1DJF/+JpB5/+RUxM6D6s4boLwWwjSCUwMkVI3bym2SCHU5vreOXrqZw
         sQpE3kGR6GLJZ7lCsPVBZIdRQGBq1R6ghnN18ssiEHe9u4VqulI032u69ydRzDTCzXBH
         RMcFDEg/4poHqusr91Eq2h3ixTgHFEP21h2z9jvHtuEesNl0+4oguKVr3oTuM0P7KoLF
         idjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679824433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/I4LeWmE6EvrVpsmoVRWWvX5meb8yBJhzJg6H+eI90=;
        b=xhCHaVf3PdTq+5/b2oC99dH9aF4Hz8tmROcN7qnZ/apPVAeN12JC+cfBph8XrRnYFV
         FUske6GVemXR6Qr7ewTTDoDleT9bi+yDzHz9gpniWNSaM3mclQG/pZw8cwXdzB0i7izq
         Onu4kg7tLf6Y5G6tZq3PZQPU9rYzOEMA/ZKB1aKtQo4ITfz9N0wyZ6BxVR+zrjzVPiwf
         QH7qThL0BcVS78BDTzo5oQnoP29CCzP65yMnxmoxfzMTbc5XVPMXRVXodgT28S5q1ILV
         xc/Dzd3ZU2sMLkNscr2W1oirsVXdx7vAo1KW1r1ZwxkNx+GG0V9ST0UN64bL/KQ4PXAR
         Levg==
X-Gm-Message-State: AO0yUKU5C5rio/Wsj6khcTwplI8jB+evjtXIkMWO4VYHw6uXJB7LpEod
        VH6LROgjTgOf1XtGsgLthvWPBLelk0M=
X-Google-Smtp-Source: AK7set9Yev4V9jo4UMV/6/1sfbknqUVmXObz+myfL9/iH8QVwEaCO+8hSe8TgNB0l4NNwSssZxVvWQ==
X-Received: by 2002:a05:6a20:8b14:b0:da:c40:8d8 with SMTP id l20-20020a056a208b1400b000da0c4008d8mr8716184pzh.4.1679824432829;
        Sun, 26 Mar 2023 02:53:52 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id d10-20020a634f0a000000b0050f56964426sm14130789pgb.54.2023.03.26.02.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 02:53:52 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     hengqi.chen@gmail.com
Subject: [PATCH bpf-next] selftests/bpf: Don't assume page size is 4096
Date:   Sun, 26 Mar 2023 09:53:41 +0000
Message-Id: <20230326095341.816023-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The verifier test creates BPF ringbuf maps using hard-coded
4096 as max_entries. Some tests will fail if the page size
of the running kernel is not 4096. Use getpagesize() instead.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/testing/selftests/bpf/test_verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 5b90eef09ade..e4657c5bc3f1 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1079,7 +1079,7 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 	}
 	if (*fixup_map_ringbuf) {
 		map_fds[20] = create_map(BPF_MAP_TYPE_RINGBUF, 0,
-					   0, 4096);
+					 0, getpagesize());
 		do {
 			prog[*fixup_map_ringbuf].imm = map_fds[20];
 			fixup_map_ringbuf++;
--
2.31.1
