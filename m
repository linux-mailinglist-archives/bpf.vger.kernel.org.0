Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60081616EBB
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 21:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiKBU21 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 16:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiKBU2X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 16:28:23 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6122702
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 13:28:23 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y4so17696975plb.2
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 13:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYtF/UXw0qmYd1/zuW+uh72Hu3XMpXMJLuNN98J9FJY=;
        b=FbRqyZsBT2u1Oud8a6ytzp6pTV9jlaA7/zV8I4vTTeKYmfzezptGRCQWrWk5n/EaIF
         qe6ux5g7m1V3Wx+N4fDOygBedGY9YcqsLKnkXL6AAprqbEOk9m2zTOURq+bqGBKcBApR
         s3LXXgjFcuAiTOhHrWXKe3d2SqxGzIPqcRMVBLc4SN3Oboe5eLKUn2mEjXAr+n1l5AfW
         OF/bmNeGYR9uXs2CYorMXs7sVyUg8USHQMmAA7Gj2agS18iEstlmG29I3f38PR7Lgh3R
         csnfY9IJz1aExpUVM7BZobpQ7I/eg6e3efiRtdDiURC6qpmT9qbB/tjHFcwtXkHfv9P+
         oK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYtF/UXw0qmYd1/zuW+uh72Hu3XMpXMJLuNN98J9FJY=;
        b=2V17BMl1j+gzDlnwclHdW0akofb6N3QfYSFXMSYozjO9Are/GCLMeP/uyEgHKJLZwM
         wHZilTuiOeT14Sv/tbm4V/rJ37lA/MRfADwYSEQXwoG+YQWicRIFEJa65xFcWbdgRiq+
         Coi6E6YRMw4wS+HitJG9ALi4SP4j8/BXDEJHrtGIvJF/vNuXWYJgmni2dafEzxZM6vbq
         Ok2TChjoswKjSCAJzuWf5YuxAw2AEBPnz/PQZitYFtYz2AGOwzcibzrKsq2VCE4jL3HF
         3Jw3GxppLlUspxnzZKKO0ZcaLfF63TDNpolEnZxBGxs3PKeJ2059P6a2h7V//auqzDFE
         qeNQ==
X-Gm-Message-State: ACrzQf10twnF8wwZeTxcb9SK68Pnh7GNI6PiyMjgKFrNejf4q7Ifn2mW
        dQ+IXs6+dyzylZkx1OLaO7kX7+BKmIX9gw==
X-Google-Smtp-Source: AMsMyM4mS43joIW+QGAfOUlIdfXe0+SwZy17HpOSdElMi4teem3txvi+jPxrrHnUtTWL40yRP0R6lw==
X-Received: by 2002:a17:903:1381:b0:186:8bdb:6865 with SMTP id jx1-20020a170903138100b001868bdb6865mr26327490plb.166.1667420902545;
        Wed, 02 Nov 2022 13:28:22 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902ed0100b001806445887asm8685197pld.223.2022.11.02.13.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:28:22 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v3 23/24] selftests/bpf: Add __contains macro to bpf_experimental.h
Date:   Thu,  3 Nov 2022 01:56:57 +0530
Message-Id: <20221102202658.963008-24-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102202658.963008-1-memxor@gmail.com>
References: <20221102202658.963008-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=963; i=memxor@gmail.com; h=from:subject; bh=Io4vqKrkd1wDTzE0Rs4W9/+sNb3Zdb5AncG3KXVOofI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjYtIEXNYEiYDxNVYDibmbUKaS47MCCg9fdooXNrUf FL8HCdKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2LSBAAKCRBM4MiGSL8Ryo9DD/ 4hDH6yEiDOkE7WYSRp9eLlQvq1ovqPWny+QSDT98Cs/dJx3iE1kIUnSg1/E6WEFwWA72Kjhg8bW8R9 NiaPwIo6TAHBGv0VHOKVdzNxB2XeGnNVkNde8XkRQSshcJQBhB8Xh89FpFGBLHd1bBycZLnG6C10v2 1YyN9NeDDAeczy5bqPV10YpKYKdiUysRPWX6BjnGe0hQdl5Y9WdstZMkD/9nzBGJB5af5osCe81DQE UTkSjMcPW4px7CnxHMCs1rosaT11LCpCM532G7J2iiFK411y9xKsKlKr35COWv+7//04WchXq8C3LB HgqqdjiceDPWwHDV+OUvU5HWm9+X0C/9gJJ3VRZswEyDA6wYK+WgxiWaqL6YAzUVcZt/D7ySBPrJg3 0qPhYESlAt1fzdlhg4JakWLyokf8HRcHhhwBUs5HBS77mA9YGqAU+HGyS7DbFLIe5Atvils7btYpeB w0c/B27JQ/GwaXeRbh5bApbZfEkI2f1Us7p9xwQsxnIGWP4eDKn09FLrFtZJiF7AgS//7tmrQ6VUAv faivvtnbkLfLLUA9FY1lqvSsQuJ2dD4rLyH+EIWC3z+9HDUTfVdW6mD6j67Bko/C3Id6YLgzHI9bpM kYvxVNvfEoFgfCeG/uQXxpUph2sCkX3Ot14Ljl4j32NQedtEmiZ0Fq9lvBUg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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

Add user facing __contains macro which provides a convenient wrapper
over the verbose kernel specific BTF declaration tag required to
annotate BPF list head structs in user types.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 4a76c64e50ad..3db1578db2d9 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -3,6 +3,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
 
+#define __contains(name, node) __attribute__((btf_decl_tag("contains:" #name ":" #node)))
+
 /* Description
  *	Allocates a local kptr of type represented by 'local_type_id' in program
  *	BTF. User may use the bpf_core_type_id_local macro to pass the type ID
-- 
2.38.1

