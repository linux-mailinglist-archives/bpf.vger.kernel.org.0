Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC0367ED3D
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 19:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbjA0SPz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 13:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbjA0SPw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 13:15:52 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684AA86EBF
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 10:15:14 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id fi26so5465114edb.7
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 10:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChnxwB6Dc/lwyAdFAAuKNn8NDjQ5N30CsuWqf+piBg8=;
        b=cBbatx4pdyR1KZZP32BJ569oBhktR+/K8hohRS59hR2Lg/uaT93jX7EUJF/2nUBgY2
         IF2MmmHLcyHu7mZm9lhGgdm4L4JVi1EknP7O22cIufKkN8drTR/zg5FNW055yA0tsypd
         ZJKqpKMZZy2Hq3BawtAVaLiCW+TgfMebn2rrz0DPqbCcPVhZLu7KLyeLzCH1+RdYUX1q
         UTwAirKomj4MFnvBPpORFT4hCx95SmuFv9yTL2YOKP/AV8Fsha6aVsjvlX78G6wGJH7y
         tyy9IXwPwbLUofhBdGEeKLabnqvs1PwhtGjRjHe7NCIbrL5On33lRNFbp2MQbCzRSm2m
         PBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChnxwB6Dc/lwyAdFAAuKNn8NDjQ5N30CsuWqf+piBg8=;
        b=HGC+EZjxkkDWTXvac8VdEMdVvaqycqwPE50pEtLpPBEFOxQtTuLUFDU8vvplynjGV/
         IGVk71hleTi9NVBzu0v0UxPENEGSX3BPJRrmvzSt9YNgY0KFPCPaURE1vWSpAQZna5K1
         wLZEHVTUBikwU+f7ulJUzjuNQzmT8DZb8/PRdciS/td17W2xrmhCvnvnJcSSDe2D1HL4
         eVbG6DuHG8r1xCM2Mv7CjkaM6p4oINR17m4Iu0TonvfiUb3NXRpapl8s9gL51oTWT7ST
         +RuSWdYRZ/Z7oz9C002egvL7xaYjCtCUb2OAZgqtfHny2GIWu3pEwZzOgTQV0qh4Ki+m
         iC7Q==
X-Gm-Message-State: AFqh2krffQw5flzJeQ3rYJZMozEA51fz4cokEOSbVGSA7YYbmlRLQzqr
        m9S72g8RHhFicIc6Y1olAflf/VC2f6hbJcXYg9U=
X-Google-Smtp-Source: AMrXdXvnUZZSvNGjAJ/h9EKrcvdG5jHaJjWcOeFKzUzWboNevwd0xIECFP0hXgOINvpaU5VnkjY9Jw==
X-Received: by 2002:aa7:de8f:0:b0:498:e0be:318b with SMTP id j15-20020aa7de8f000000b00498e0be318bmr43929402edv.38.1674843286527;
        Fri, 27 Jan 2023 10:14:46 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a16-20020aa7d910000000b00463bc1ddc76sm2639651edr.28.2023.01.27.10.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 10:14:46 -0800 (PST)
From:   Anton Protopopov <aspsk@isovalent.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next 2/6] selftest/bpf/benchs: make a function static in bpf_hashmap_full_update
Date:   Fri, 27 Jan 2023 18:14:53 +0000
Message-Id: <20230127181457.21389-3-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127181457.21389-1-aspsk@isovalent.com>
References: <20230127181457.21389-1-aspsk@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

