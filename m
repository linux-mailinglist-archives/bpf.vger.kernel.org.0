Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600BE694081
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 10:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjBMJPR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 04:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjBMJPP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 04:15:15 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C51B472
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 01:15:13 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id sb24so6182854ejb.8
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 01:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChnxwB6Dc/lwyAdFAAuKNn8NDjQ5N30CsuWqf+piBg8=;
        b=c7UM+aubM9cEObDnBsuJzwi994qI1yTpkuOygdG6kera9uS5VEBEArDhjQvcEGT86N
         Bnh9TQxJx/OAVoE3pqRxl5B54gwVNgzOjAJ0NgQuXc5/Td+DH2gEhhb3uM2zdeJZWYN/
         GWM5E6kUaYIWSMY+z0jctOycvWF5cOAB0h8LH5LF0sRQSpWJJIideT8n0XMhIIoC9N9/
         f9PS9qCngTwFt0JBsxIsgp2RODDJhli8PXD5vUGhChx3uR4+GwuIvQ1usWiIICC/3dSX
         yKhFGe75C5TTR4GQsOit5c0CkWkpVqwwPg6+IkjErQjkIn03o/eXg4QNmMsJVKcqjdn7
         lZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChnxwB6Dc/lwyAdFAAuKNn8NDjQ5N30CsuWqf+piBg8=;
        b=jcmkHFX4IJwt4BLHb8MaSmf3kn1uETlokTynqdI+1DUJFwX5yS64PkRe8zg66KXywt
         5VhnDm8Tg6DmQdoqHq85/OcdmTOc6g6VBqyOWlAf6XbFlQ5ucn32TFX/R6T+sxxatbmG
         iGod0IV0Rw5/kuRyRljY8S4aHOQ2Q1kH3aSIyrU1iQ387JMQu4Tc7N5t0kIY2qTtXW/S
         pbTBJ5FCS/tsN2kPCLzCt7HvfhqotaMgfaaNsZONmW0mktUbjINUmpcEcRC8k/t0AsQV
         5X/TlMZgZGKiGNb2ElhN5GxUawyfm28RYoh0j1qEWg35S7zzVALiSaMX1XLqD9zbg3QZ
         KLnw==
X-Gm-Message-State: AO0yUKWSgy/OOhRJ5swuV6pDlq51eOwalkiRE7/ke398Uh/GsOk8JxfA
        YwZ0AzXB9WbYPFUVlVfbGZeV/dgk1unRntXcT6g=
X-Google-Smtp-Source: AK7set/0ojEvPql9DQ6yJ4PKbAsopL94Ub+DlemO9ipw9IHvGUxwt8nYEuvXrfEQb21SFuxcx3Ol9A==
X-Received: by 2002:a17:906:228b:b0:888:a06f:104b with SMTP id p11-20020a170906228b00b00888a06f104bmr24501741eja.36.1676279711631;
        Mon, 13 Feb 2023 01:15:11 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id f8-20020a50d548000000b004ab33d52d03sm5336587edj.22.2023.02.13.01.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 01:15:11 -0800 (PST)
From:   Anton Protopopov <aspsk@isovalent.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next v2 2/7] selftest/bpf/benchs: make a function static in bpf_hashmap_full_update
Date:   Mon, 13 Feb 2023 09:15:14 +0000
Message-Id: <20230213091519.1202813-3-aspsk@isovalent.com>
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

The hashmap_report_final callback function defined in the
benchs/bench_bpf_hashmap_full_update.c file should be static.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 .../selftests/bpf/benchs/bench_bpf_hashmap_full_update.c        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_full_update.c b/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_full_update.c
index 44706acf632a..67f76415a362 100644
--- a/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_full_update.c
+++ b/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_full_update.c
@@ -68,7 +68,7 @@ static void setup(void)
 		bpf_map_update_elem(map_fd, &i, &i, BPF_ANY);
 }
 
-void hashmap_report_final(struct bench_res res[], int res_cnt)
+static void hashmap_report_final(struct bench_res res[], int res_cnt)
 {
 	unsigned int nr_cpus = bpf_num_possible_cpus();
 	int i;
-- 
2.34.1

