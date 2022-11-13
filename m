Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC316271EB
	for <lists+bpf@lfdr.de>; Sun, 13 Nov 2022 20:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbiKMTG6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Nov 2022 14:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiKMTG5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 14:06:57 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255C3101D2;
        Sun, 13 Nov 2022 11:06:57 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id k5so8563131pjo.5;
        Sun, 13 Nov 2022 11:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dKFCQLLD24B5y6IQ/DPcV3YJ7iqEJopE8xQjjU2Dx+Q=;
        b=W7Db21D9LySww5CNcPS7PzptT3j827cHszV4BBxC7SrucEulcWnEymvWvXpa8hJdxV
         DrYjcHVW0TLzZWpBNetZx0TVSa9p+JWD6RJSTdJegUjINAMk+Wb25lnpcUl8N4Rwzx4+
         A6zHUgRXn+zhL1unZXvum3mp2lFtvHKrykm8b7G5yeQYPsxIoBgLxu5KF/r3S4IBrsnu
         q+XqlDrcX8ADzvnlNWX5qGKOgtodSplfi2L2+hf4skiL4pFmqmhBMxh1HWSRku2tVOYv
         prWVViWhs0YvXbd8QHC7zG1FiCBGfkWBqSiYNgZEcU2CGn0ARomgjYCA6lZxQQ/SKjNV
         CGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dKFCQLLD24B5y6IQ/DPcV3YJ7iqEJopE8xQjjU2Dx+Q=;
        b=0LILwbbUy3Cr3NHQpIZ+Mu0TARjoa24RGG49BNMmjFgPerrKWMCjHpmW4SMHYNew/f
         hZpQwkPKckTbJnvOtGA/WzsmNWBBbQE+WK9sFib6r+9HizY8SjpbhYgkoG2BoJJ4ce0g
         4/I0TWrwmqLk0wIuqWPKknO1oP34ap4APH5vX2Lg092Bu4o8AiGNQOzMPdj8CR8yJhta
         dXJbJc1tLEPILLb2Uj5p6tQifdYzh9zJExmYhDpcOPxABrwNWyYka+ekX+r/SdwlvPP/
         ZltcMaGXlixhX9WKvKUNbj6mwnMS6HwW2Nxlwv0FYqRw7JI70nnGE64nrQkgP0JL/ZsT
         v6wA==
X-Gm-Message-State: ANoB5pmTVtCzLCGEdtzpU+03lRFrWlWtGv5AgNU7txgLzCt/+/BIPe02
        oyKOHS2CWtVHG/lurqoHtts=
X-Google-Smtp-Source: AA0mqf43nr3OmWmU5p6xb7qKvMCKxGRun1xKLDD/CTr7qTD1YgD1/51GluXp5GywlDOMceRtysHdFw==
X-Received: by 2002:a17:90a:1788:b0:209:853d:ec6 with SMTP id q8-20020a17090a178800b00209853d0ec6mr11079225pja.29.1668366416447;
        Sun, 13 Nov 2022 11:06:56 -0800 (PST)
Received: from localhost.localdomain ([14.5.161.132])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b001869f2120a5sm5549604plh.34.2022.11.13.11.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 11:06:55 -0800 (PST)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH v2 0/3] libbpf: Fixed various checkpatch issues
Date:   Mon, 14 Nov 2022 04:06:45 +0900
Message-Id: <20221113190648.38556-1-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This patch series contains various checkpatch fixes
in btf.c, libbpf.c, ringbuf.c.

I know these are trivial but some issues are hard to ignore
and I think these checkpatch issues are accumulating.

v1 -> v2: changed cover letter message.

Kang Minchul (3):
  libbpf: checkpatch: Fixed code alignments in btf.c
  libbpf: Fixed various checkpatch issues in libbpf.c
  libbpf: checkpatch: Fixed code alignments in ringbuf.c

 tools/lib/bpf/btf.c     |  5 +++--
 tools/lib/bpf/libbpf.c  | 45 +++++++++++++++++++++++++----------------
 tools/lib/bpf/ringbuf.c |  4 ++--
 3 files changed, 33 insertions(+), 21 deletions(-)

-- 
2.34.1

