Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8A0694084
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 10:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjBMJPS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 04:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjBMJPQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 04:15:16 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E9413DE1
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 01:15:14 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id eq11so11892937edb.6
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 01:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ct2ZwWa3guJI6HJb5Y1bTPIxspl1vdEyPX1NWxrdHTo=;
        b=Gid4ghCt/nWfgJTvNWZDLwDrTDPPDUaS4jU4xde+1tI2isZEktbg7+Iso9uhaX2U9z
         xpSjGQ/VcAM9ifcuVkTmyKDrvmWzr3iUmUofF7MMV9RJkbESkKoOo03s8ymvaoHY6Ffv
         61dTeGYcyILmuGG14Fnxw9tqKPevw3KRMyjVyBo23FsmXIoFSiDE/TlzULfzdTl5spqv
         lvU1rsB7a5s8rOyUEbVL1EkBlAqFq+jxe/vRGt1ANbh96kfsqjB3I8SFPddIxr1ZfhEB
         zVwb/0pPZzFv03V2skBoog8/sgPiuM7dKZUEGHXNtyD/ll3fvsUg+gmnDpdSkA2abvhE
         JwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ct2ZwWa3guJI6HJb5Y1bTPIxspl1vdEyPX1NWxrdHTo=;
        b=5x7rzHVd5KE8owK7dY649dev5lkmLbOGOw6IjPOLHcjcweZnsbxOmRIa/28U0UMpTF
         F402zrDgwIjw5h3wASUdAAE+ORuC00GQ74iwgLg4kRuG1nAUFDoptKN659gx03iPq4fX
         Abw/w2ztDPAeN1w1IpfBTL1ggKWC744De/Zn4Nxhxo5dpL+weD1Ohvev4QtcWXjim9mz
         /BdSYOIW/ry8lAEam8a7zVeaIYXY0xyX/9VmM+hm30u+OruIRnjXmkWWl4VLohe5ck4F
         O5gYmrUjvkWJwQvX0wkesSPx3Oi+Rm/6V2C2itxN5UQbIVPoX/jcIflfmL8x7GiSePD7
         +bWg==
X-Gm-Message-State: AO0yUKXZOGYgWzf96yiuELYtLqixzXNaG+VeebNv8TWPPyrnoll/KImx
        x/eoLd6KAlOb/PfeETwYdVICHPaky5AtIZZ2/UI=
X-Google-Smtp-Source: AK7set/Y+uO9/0XPaoj93R7heCWeBn70SMVgCv9l9zAzcv7ZNkDPxgMdQudLqU5c+SMOidthruhGpw==
X-Received: by 2002:a50:aac5:0:b0:4ac:c7b3:8c27 with SMTP id r5-20020a50aac5000000b004acc7b38c27mr2330784edc.28.1676279713076;
        Mon, 13 Feb 2023 01:15:13 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id f8-20020a50d548000000b004ab33d52d03sm5336587edj.22.2023.02.13.01.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 01:15:12 -0800 (PST)
From:   Anton Protopopov <aspsk@isovalent.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next v2 4/7] selftest/bpf/benchs: remove an unused header
Date:   Mon, 13 Feb 2023 09:15:16 +0000
Message-Id: <20230213091519.1202813-5-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230213091519.1202813-1-aspsk@isovalent.com>
References: <20230213091519.1202813-1-aspsk@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The benchs/bench_bpf_hashmap_full_update.c doesn't set a custom argp,
so it shouldn't include the <argp.h> header.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 .../testing/selftests/bpf/benchs/bench_bpf_hashmap_full_update.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_full_update.c b/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_full_update.c
index 67f76415a362..75abe8137b6c 100644
--- a/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_full_update.c
+++ b/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_full_update.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022 Bytedance */
 
-#include <argp.h>
 #include "bench.h"
 #include "bpf_hashmap_full_update_bench.skel.h"
 #include "bpf_util.h"
-- 
2.34.1

