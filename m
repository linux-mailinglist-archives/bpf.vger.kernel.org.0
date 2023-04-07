Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED1D6DAFD0
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 17:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjDGPmG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Apr 2023 11:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDGPmG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Apr 2023 11:42:06 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AF78A72
        for <bpf@vger.kernel.org>; Fri,  7 Apr 2023 08:42:04 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y15so54933739lfa.7
        for <bpf@vger.kernel.org>; Fri, 07 Apr 2023 08:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680882122; x=1683474122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jEqzbLR3ez6naaI4HW5oxfr7gEz9Rrho475cqYDHK3k=;
        b=Ln5r/i5VsPROK6PRhP55tMf2YAdHjAg237hXG/K6eAkyJ7x8A9Oevq4dvflt2++914
         yOIYUoho/xbPkVaeQnvTgwmVnoCd8IohyAQcpQvq3riPC5fJFUhda/Jeos5myfrni6AE
         V0EjNODF/U8O3N+pviD/Ro05sfVsX2pXBZ9vkGANBYVeKklP7Dy6zM6uFGj+wdSPnZwm
         ooUfiMot8bofBMRyI1lAg+utUlLnuYsuV7BOvtzp5XW6FF5Hb8qJpNExzB9v5wlmaWlV
         XxOJPP49zPvZT9zNFicEgqBcaqyrMQDg4Z2+Vjwka41O+Pizpja0qN583P76VfX/Jl1J
         k46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680882122; x=1683474122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEqzbLR3ez6naaI4HW5oxfr7gEz9Rrho475cqYDHK3k=;
        b=nuCMpRvfer/eJpqgxC5QYTn3b8RF2wFKjDe0aKihd59u7MgJYbeeL6EbZpMNKo9Bf6
         JWY0/jPrIWobze1w4r7apYIUM7Md0Gz6HuOYoE3TyU22FROe9pFInLlMg2uQ7AjBhK4p
         vGbpJP097VPgwawTSmZOztCx2uKLY6Xva0nHZ+ZoDCjPBhaCI6/lSNQc1K2Q8BSYnqwe
         fsLJsbyE3A/YXpcNLJs4NQdE1pL8b++KAPfARIdgzqRsMwcF1sXOcH4tyZ0Oj6iIvvpm
         i+bvhRpODdtBcUG+2fQ62ijCOReZf4zec0SABQWoyVVKvnSBF7DyJbidx3a6/BavrXMD
         H7vg==
X-Gm-Message-State: AAQBX9fpFFA3r6FLOmvEEeM+FmK/QOi881yfyv6WPKGOPjmqTe0wb+PA
        uulLytt3kABhTUHyajUU0fcbO/EC8hQ=
X-Google-Smtp-Source: AKy350a22+tOBArvNnrgVSSKhcWhqIvmC2RFXyBW/MxPxBfFjTJOy/RE8Zb531Yld6dkB6V7Vpzh1w==
X-Received: by 2002:ac2:443c:0:b0:4ea:eadf:2a53 with SMTP id w28-20020ac2443c000000b004eaeadf2a53mr835580lfl.63.1680882122205;
        Fri, 07 Apr 2023 08:42:02 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id l10-20020ac24a8a000000b004cc8196a308sm759557lfp.98.2023.04.07.08.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 08:42:01 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Prevent infinite loop in veristat when base file is too short
Date:   Fri,  7 Apr 2023 18:41:25 +0300
Message-Id: <20230407154125.896927-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The following example forces veristat to loop indefinitely:

$ cat two-ok
file_name,prog_name,verdict,total_states
file-a,a,success,12
file-b,b,success,67

$ cat add-failure
file_name,prog_name,verdict,total_states
file-a,a,success,12
file-b,b,success,67
file-b,c,failure,32

$ veristat -C two-ok add-failure
  <does not return>

The loop is caused by handle_comparison_mode() not checking if `base`
variable points to `fallback_stats` prior advancing joined results
using `base`.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/veristat.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 53d7ec168268..e05954e20bba 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1824,18 +1824,22 @@ static int handle_comparison_mode(void)
 			join->stats_b = comp;
 			i++;
 			j++;
-		} else if (comp == &fallback_stats || r < 0) {
+		} else if (base != &fallback_stats && (comp == &fallback_stats || r < 0)) {
 			join->file_name = base->file_name;
 			join->prog_name = base->prog_name;
 			join->stats_a = base;
 			join->stats_b = NULL;
 			i++;
-		} else {
+		} else if (comp != &fallback_stats && (base == &fallback_stats || r > 0)) {
 			join->file_name = comp->file_name;
 			join->prog_name = comp->prog_name;
 			join->stats_a = NULL;
 			join->stats_b = comp;
 			j++;
+		} else {
+			fprintf(stderr, "%s:%d: should never reach here i=%i, j=%i",
+				__FILE__, __LINE__, i, j);
+			return -EINVAL;
 		}
 		env.join_stat_cnt += 1;
 	}
-- 
2.40.0

