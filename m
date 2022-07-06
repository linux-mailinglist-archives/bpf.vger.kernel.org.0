Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8F6568E79
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 17:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiGFP7W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 11:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiGFP7V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 11:59:21 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1416B21E36
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 08:59:19 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 145so14322090pga.12
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 08:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qd0JB5cfMOZXju+WK3uakPtpMzOhhWDX4kTiYeCgPR4=;
        b=OAKYxyOapwiVgzTm0M/+5qMploaHB8Fd5AKESgyzYGNfYOJJeB4K4JP21u4y4B+vpa
         7SmhZLXxe5yo2MMxjE/ynYk0boDbQo4zz1Ylxi37Xn0BNxesNVuydH+Dp2pXV/xmp3YO
         5Mpi5ZLtKJSZjuu6L62q4rnJybhOqscs2qKpMIoe3JLsiE/KiSbWWzshVWpLlHy4XUgE
         mrXaxZFJ7Uh+lZzGOSxqIK1UQdt/crDSYob98tIgK2bdqqQ03tWrE/+swKSPLZseezfA
         hzBrRwcV3v290BchZUMphrqpIF7zdD7w5gFs5cnNBqTAU7R7c/l7n7r59Tj6khJXHtD1
         qeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qd0JB5cfMOZXju+WK3uakPtpMzOhhWDX4kTiYeCgPR4=;
        b=fzM2JaN1eDnoi+V4c069bq0CsyMzIR6neO4TRRBWLIrkwV/3ChzSNgEuonRsMBTV+K
         AQh9Xq0ZvBx9kq5UHGoCwwF3nq6MLBACnb4bBRoKPsA4Jffq6BXrkiz5Ex5y6uyMRT6D
         Kl4GrAmwdRgsn9t+2OlmK6r2uHT/WuYMGhpz9Mc3D0U7EW4sVZeBm3yRmxMzzNhWIHQk
         YbOXPR58ZhGgwVwhMH7rkXTUoILeMERV1j91O2ncr6XU3RtrGKrYTnxfqyEZefE/s6H/
         EIaY+e+2gDQ6QYCi0vQeI8HawksQzAHK26i3SAkeCEfONxVaU9emEmxtWJGxkFUDu9/F
         Wk+g==
X-Gm-Message-State: AJIora+ADHhw8pYCivVyJ4iYBM3L2OrLo3kboGt7m26DiMZNaKXSe3Jq
        AnnODLScoeGwQEEyNM0w1tY=
X-Google-Smtp-Source: AGRyM1s0QPfTexu7TomygDyRXf/v2uhg7XcmyHXydM9+PAvA7Sj9ccBGowg/XIFXrGeFsdCBeUiHBg==
X-Received: by 2002:a63:d94a:0:b0:412:6e04:dc26 with SMTP id e10-20020a63d94a000000b004126e04dc26mr9511132pgj.539.1657123158640;
        Wed, 06 Jul 2022 08:59:18 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:3e22:5400:4ff:fe0f:2b20])
        by smtp.gmail.com with ESMTPSA id n17-20020a056a0007d100b0051bada81bc7sm25000125pfu.161.2022.07.06.08.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 08:59:17 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, roman.gushchin@linux.dev, haoluo@google.com
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 2/2] bpf: Warn on non-preallocated case for missed trace types
Date:   Wed,  6 Jul 2022 15:58:48 +0000
Message-Id: <20220706155848.4939-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220706155848.4939-1-laoar.shao@gmail.com>
References: <20220706155848.4939-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE and BPF_PROG_TYPE_TRACING are
trace type as well, which may also cause unexpected memory allocation if
we set BPF_F_NO_PREALLOC.
Let's also warn on both of them.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index df3ec6b05f05..f9c0f4889a3a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12570,6 +12570,8 @@ static bool is_tracing_prog_type(enum bpf_prog_type type)
 	case BPF_PROG_TYPE_TRACEPOINT:
 	case BPF_PROG_TYPE_PERF_EVENT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
+	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
+	case BPF_PROG_TYPE_TRACING:
 		return true;
 	default:
 		return false;
-- 
2.17.1

