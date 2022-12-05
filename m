Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFEB6421B0
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 03:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiLECur (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Dec 2022 21:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiLECup (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Dec 2022 21:50:45 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B43910576
        for <bpf@vger.kernel.org>; Sun,  4 Dec 2022 18:50:45 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id f9so9289812pgf.7
        for <bpf@vger.kernel.org>; Sun, 04 Dec 2022 18:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oNPZAxJlRQhNTySwkKjnN/AI/Aeneyj9Y3IU2cqYsZY=;
        b=SskYsPGsnAAxNQJoRIW2YCNt+1xrkWZIp5cp1NUk6qW27Tn0sjQEF+xwju75a9syQc
         +V9731RdCuZM8Yv62VFEYm3Ykrt3CZaaS6k/AnNsW4EzXOV50YjJJYxnYvrFhXOgS7OX
         LI/diuFq1PXxMCS566gihkM/iLXKCN422qkWnJaRYTm1UwlYLLD4jELwxjtV5lowMzyN
         aj20i+bBA5OrVyDlkynL138+XtZTyC0buBTEe/Mt/klzMCcwNq8UFy/lgN02WSIsMaNO
         quue4pbAvR82aDBYc8GexQ99h88+gxCtYHOsDDMV+gzTzGr+l6tgQX/gjiI4dCV1n+CA
         eGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNPZAxJlRQhNTySwkKjnN/AI/Aeneyj9Y3IU2cqYsZY=;
        b=uXzKfVbiHmy0g0KP1RUozdAAokIH0umGiSt7dJlgMJA7nEo2JuuI1G+fT6W7UodYTH
         +w67MXFoRuob1z+frJ90NPKmw/q32mmLltHdHnDLqxtqfyNPLgqZGQU76dl/lJbo/JAC
         bjo5QU9O9KAxb7ubLbmyUsD6bJMBZGIz4kHtHZvEa6XH7sp/WwhCF3dc4Y1t23T139tT
         wqV8nom3eNxtZ6DuNFxvIj0/FYfpWI/KsUCjgRQ8cF5BWEE6j76cHZT+KgzBfl+67Ds8
         8cXVX6qhu2RG+aF0bffBP1KVcE2nIcUaorkYt40y8oi2Ju6qyhsZBMEe1C+1HjJ54jnu
         YuBw==
X-Gm-Message-State: ANoB5pn7vZ89iSWZDLQ+ptQo6d7JdpEDNMNKXfVNuJqVS94iEizM/eHb
        yitwphQJhEmbIbXZuKe6NGlMX9J4sZs=
X-Google-Smtp-Source: AA0mqf6ttATFlA4WM0qauJHJxgEc2ERMEuTt1KdYvnOQIOZvJFBchLWtj86AHCW9i9K9owyVfvcEcg==
X-Received: by 2002:a05:6a00:3204:b0:574:31bb:a576 with SMTP id bm4-20020a056a00320400b0057431bba576mr58503264pfb.46.1670208644215;
        Sun, 04 Dec 2022 18:50:44 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9181:1cf0::d00])
        by smtp.gmail.com with ESMTPSA id c9-20020a63ef49000000b0046feca0883fsm7158770pgk.64.2022.12.04.18.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 18:50:43 -0800 (PST)
From:   Khem Raj <raj.khem@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Khem Raj <raj.khem@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] libbpf: Fix build warning on ref_ctr_off
Date:   Sun,  4 Dec 2022 18:50:39 -0800
Message-Id: <20221205025039.149139-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Clang warns on 32-bit ARM on this comparision

libbpf.c:10497:18: error: result of comparison of constant 4294967296 with expression of type 'size_t' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
        if (ref_ctr_off >= (1ULL << PERF_UPROBE_REF_CTR_OFFSET_BITS))
            ~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Check for platform long int to be larger than 32-bits before enabling
this check, it false on 32bit anyways.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 91b7106a4a73..65cb70cdc22b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9837,7 +9837,7 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 	char errmsg[STRERR_BUFSIZE];
 	int type, pfd;
 
-	if (ref_ctr_off >= (1ULL << PERF_UPROBE_REF_CTR_OFFSET_BITS))
+	if (BITS_PER_LONG > 32 && ref_ctr_off >= (1ULL << PERF_UPROBE_REF_CTR_OFFSET_BITS))
 		return -EINVAL;
 
 	memset(&attr, 0, attr_sz);
-- 
2.38.1

