Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E866DAA60
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 10:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbjDGIqm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Apr 2023 04:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjDGIql (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Apr 2023 04:46:41 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933FC976D
        for <bpf@vger.kernel.org>; Fri,  7 Apr 2023 01:46:39 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d22-20020a17090a111600b0023d1b009f52so864135pja.2
        for <bpf@vger.kernel.org>; Fri, 07 Apr 2023 01:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680857199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5K1Y4OsJcJ4KwCwbQGTYT7oxVpnc4vIiM6hHQQ2APk8=;
        b=L5z2G4SA6MyX2VTrvsYX7fiKhPZ2/afzXT4TdtYxOGCvS+0G5qtWQTdExLTDMrfWrD
         DWgh14164S8R/xx+9veSlgxZn2Yk28Jm1lSUc9LGLnY0ZipjBaMRIVst29rQGP1CoGVP
         VwF1lEebto5ctzHYyH5qzvT+jorn35mhxaFuBGtwR27EByDBB80hTDVKRhoSVvxnHzUw
         0+dct90nfc2yu0mF9qpuNL7ibW50oIIqc8NkU+PKdFQn5qQpS1k3cFpZenfR5TIEFbpz
         hJDctKGJS9ne515dXjQ2AxEAzE5QxmiPhp2Koh+FZ+t6UFfIM1YVOaVXLhlTMgLM6xZz
         t9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680857199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5K1Y4OsJcJ4KwCwbQGTYT7oxVpnc4vIiM6hHQQ2APk8=;
        b=34x7TEm3+plKuv3sRU5xL/BbVPAL8NWi5EuIzdqMkznr5GMPdQoHqXBLEq6nNvP+IR
         Q8Q5evg8w5/VWYA4jupnK15KrrU67R/Up+nlvM2LnKGTBZy2+UMl/ZRr5S6QXMyEHVBQ
         uXhaO13kU4WWkEtO5sNZgSScAWtBqwYoyvPfK0ENzdAgmxyYtt7ZKst1TSnpdzSr6DUW
         o4qRNDbiKfRiktL7AW8VJrMO+EV49qMr5z2MfyM8vPFL8j2+6nrsqEH037p1Dp9cxFaF
         OvajvAyo6Ln9BnNYpab4wCY3apD4Q8GbRCKIA2kjGuWrkTr27cZ3zL3OgBUgJUMIG1ry
         /YkA==
X-Gm-Message-State: AAQBX9caiaI8iSSoqcEo4vvzrIXOl3NF7ZKq0nCl1ZmpIPLoPcbxaK64
        th9IhnwIr7AgiAhpjBAZo4x85LCsYwwz0tDTgFI=
X-Google-Smtp-Source: AKy350Ye27QhQgOVdpS1rYrPSe1BiXyfbu4Zr6sUqaZRBP+AOWEFdGMdCVVGvgwJY46k2qIhuhp9Vg==
X-Received: by 2002:a17:90a:f293:b0:234:2485:6743 with SMTP id fs19-20020a17090af29300b0023424856743mr1752040pjb.3.1680857199018;
        Fri, 07 Apr 2023 01:46:39 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id s13-20020a17090a5d0d00b0023b3d80c76csm2333676pji.4.2023.04.07.01.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 01:46:38 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mykolal@fb.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
        zhouchengming@bytedance.com, zhoufeng.zf@bytedance.com
Subject: [PATCH v2 0/2] Fix failure to access u32* argument of tracked function
Date:   Fri,  7 Apr 2023 16:46:06 +0800
Message-Id: <20230407084608.62296-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
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

From: Feng Zhou <zhoufeng.zf@bytedance.com>

When access traced function arguments with type is u32*, bpf verifier failed.
Because u32 have typedef, needs to skip modifier. Add btf_type_is_modifier in
is_int_ptr. Add a selftest to check it.

Feng Zhou (2):
  bpf/btf: Fix is_int_ptr()
  selftests/bpf: Add test to access u32 ptr argument in tracing program

Changelog:
v1->v2: Addressed comments from Martin KaFai Lau
- Add a selftest.
- use btf_type_skip_modifiers.
Some details in here:
https://lore.kernel.org/all/20221012125815.76120-1-zhouchengming@bytedance.com/

 kernel/bpf/btf.c                                    |  5 ++---
 net/bpf/test_run.c                                  |  8 +++++++-
 .../testing/selftests/bpf/verifier/btf_ctx_access.c | 13 +++++++++++++
 3 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.20.1

