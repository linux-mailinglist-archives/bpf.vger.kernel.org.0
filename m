Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B700362703F
	for <lists+bpf@lfdr.de>; Sun, 13 Nov 2022 16:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbiKMPnJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Nov 2022 10:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbiKMPnI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 10:43:08 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44607633C;
        Sun, 13 Nov 2022 07:43:06 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id h14so8330827pjv.4;
        Sun, 13 Nov 2022 07:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bMdSQevJ359dfeT/i/9hKChaTJ8Cu8pREb/H8D2QPMw=;
        b=TyTqkxHxtB6mu44tCwkn5gl4JZyellvFeu0RovnxdJVqympj4QDQfuqg0HpifXF7ov
         gdKet53I9Lc1I1jS5lSwOFBqjvcFYdqX8I3JU+86Dvt5j1hXZeEVKwjt4HBWm4Cb1RGX
         vFN7tZ/11QPchDgeZ6DBNiLnb/gnDpl0h8c+9+Cy2I//Q1OnjZCQajKT5lPdfHufINy+
         tcYFYgVyvSw7T1ZQNHL91rv6ESNMdy3vWcxVfQkvSx3BbOCpwjQGHwLED5PsNS9UUxyB
         0oAolhcX2gAZVGRAlnmBdIRLeFFyp0hZBOQ5pxTPTPEFddzPWPmIEs+api9zknpR4bII
         s6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMdSQevJ359dfeT/i/9hKChaTJ8Cu8pREb/H8D2QPMw=;
        b=JB0J8D73KyFcMUZbtTTFZFm1nU2M1cwhvShBEM/SuFq3eh+DJCPE0qt0YgKru0FY+W
         Pb+Qg5VSV8h2o+mAEAKbxcG1KjM2qDOF5bOzjkbDI+YhvyDkpHxZnZquogSCXIq2vEXa
         Ve/PN/Z9uG7wZHiWIIKw0PoWg6AMHMhyvldQ6j4Z1Eu2LKwdZYoG+ps26U4PU5sIkzLq
         Dk5OweYyb+Xc2EmQHZkxbxFms/I464ipbZ/PBZ+eIz3pQzc2IrSDDmhBGmyvJKDFeNoE
         ZlZcP/qI0x+1OQIgfSbSuQ1CJgF7J+2qqEuOJaHhWGTotdDu/Qt7LnvC2AzNwR5Z3dj7
         f2aQ==
X-Gm-Message-State: ANoB5plebf8s1pa6xkxBQ59PIEUnaCsT7Jm0cSbeRj8n0NCfJZSnkvcL
        wsxp+YrVexDIXNC3Une28xA=
X-Google-Smtp-Source: AA0mqf7IuHOoXKfEDXXo5SJMHTRxqOykXkKwJ4ETmq5xIlajULDbqz3NKlAzG3Y0cC/daTNU62lE0A==
X-Received: by 2002:a17:902:d4d2:b0:17c:f013:8fae with SMTP id o18-20020a170902d4d200b0017cf0138faemr10277340plg.138.1668354185521;
        Sun, 13 Nov 2022 07:43:05 -0800 (PST)
Received: from localhost.localdomain ([14.5.161.132])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709026f0800b0018544ad1e8esm5304550plk.238.2022.11.13.07.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 07:43:05 -0800 (PST)
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
Subject: [PATCH 0/3] libbpf: Fixed various checkpatch issues
Date:   Mon, 14 Nov 2022 00:42:55 +0900
Message-Id: <20221113154258.36560-1-tegongkang@gmail.com>
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

This patch series fixes contains various checkpatch fixes
in btf.c, libbpf.c, ringbuf.c.

I know these are trivial but some issues are hard to ignore
and these are accumulating.

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

