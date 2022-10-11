Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0355FAA19
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 03:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiJKB2E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 21:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiJKB2C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 21:28:02 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B8C1402F
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:28:01 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id d7-20020a17090a2a4700b0020d268b1f02so5136852pjg.1
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvVnordvZSU3xFxTAZj3NTxrUdQrGRR23kEGNEUAwwE=;
        b=LFn4811cFffMQO3y66xDtWLTlogvr06z5o5rKK+teHMfTuUIQuQtKQSDbkwF9tzBbQ
         jNV/c/FVeF6f5lWOXWt1fI/naaPDNN8mWn3wEDJzC/ufiwTgMSeh2If2eqAY038IOG/c
         wuKjxTVK6araDMKlkP13G4VyKI0ag76TSZyQjzamqTit4nWtW0CCeVcH7TFC4Gv+iabu
         IVC02MxxgY1vsjhqVmec5Fc6yG4EKtx7DV48lVuK8QJprgxXR6zAD1kewUKh2wvGiy9n
         RkrnqQqTcE1ZUTpNMjzz4UwfOh0Huq1a2nECZZ+AM/3meF+eJaQhunTuflCrOhQQ/qSw
         8d2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvVnordvZSU3xFxTAZj3NTxrUdQrGRR23kEGNEUAwwE=;
        b=8PnxRU9C0TshFY/SNLz6Io2LTUcYLs4fCdXE7D/wFh5YVzg+RqpXyLfG7yt4HWAaiO
         bF/qNR/ki04iAbvD7IbygRpl3bLUtac6MrvX/0iCmW7zofFJVnUZk4GgiwCQTKQlKy8e
         wGiV7DiZ5NkS5P0BoDsxn8jjaPFls3FyqSpcGVDT7YvB5q61DwoiJkywXx/OD2q6JBc9
         Ei2wEmsJ28gqg/dxeHjlTDy/BpeHh/ymkqSjINAnQxAHsywBzQ5WW8d4e2ct+GxmqwHw
         Gdu4lx9fF8rDrD74YekhseF2u3F7b9HIdLsEb5SEfM0AjxiOmQU/jB3w7m4t2dUjhTIX
         SGEw==
X-Gm-Message-State: ACrzQf04kCFf97mq0W0c9CB8f4obfp6GDlKy/duNw95L3Ls0HlBjj5IU
        GSoTepJT7/7Xe6rNQcRDiU5dJO3HISxgqQ==
X-Google-Smtp-Source: AMsMyM7VEmQfUzO7K+kawwEaD07EpQUnNarsLNb9lTb4FXOE3ZtOkAmZl2pHnlRTIe5Besw3UeqZnw==
X-Received: by 2002:a17:902:724b:b0:183:16f:fae4 with SMTP id c11-20020a170902724b00b00183016ffae4mr5001271pll.88.1665451680757;
        Mon, 10 Oct 2022 18:28:00 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902b49400b00176b0dec886sm7282932plr.58.2022.10.10.18.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:28:00 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v1 24/25] selftests/bpf: Add __contains macro to bpf_experimental.h
Date:   Tue, 11 Oct 2022 06:52:39 +0530
Message-Id: <20221011012240.3149-25-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011012240.3149-1-memxor@gmail.com>
References: <20221011012240.3149-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=835; i=memxor@gmail.com; h=from:subject; bh=mePnWT7ntrf/bDZBwOpfYo9bCiVvsckVmr0A0dwYENw=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjRMUcRhlvF8ospYVj4qZ7VOuqLmDjY0/aSv9H4AUh GJAxx4+JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0TFHAAKCRBM4MiGSL8RyvCfD/ 9mq5rJErJTIGF50pFTPJT5/VpfI6Qwn1R/6qpa4Wxan0QDHZTBFZruz2MeK0JwFjd7ZAClkL5xpV8I ortIzbIaUhCHDRdVQzWF7H0eVNbPx4wV3Qrf5N5og6NR0J3g+p2Kyj2kMbR+4zkyoIdN5sJa4mntx3 /PWj5txPz1qKGQ+R/4PDTMXf69svtptYjRawiTAsfiPJXCzHEuKQFIcdHIsjq2imMzuxjILrYfp5mP yUS/2l77iOTpLyKv7UOm8oUFIsd5uBoQq+cLam+YsXbWkqbEvoLkBPXzCuJJphwfOq04CJ0v5/z46d EmJjM0QCuCMofLl9ah0in9kysaQmq5ck0k19/S90p9CnfqAPCiyiLuVq29vUxAFH5qOeXI2B3EafZj 05KOMTE97pr1VEHAqDdM3ZF8PccCQteXvgO7BncaY+7CTsQJoAwYfQUzWuaJNg0jLDTMTOvucnqyiw A1CnNMtYCyGlqv3Vq0AKgRf2E0nsXISWePsYqw/3sXs6YYSgiSWlYoGWV67YQ8nSSVGd+0rE9nriXk VgrpWr0Oj1YnLRB4Smqd5Y3C5zij/Wp98EHAjY3PUXLu8d8UIgJGx+SmYnwq+c48DK1DISfmhCUTqI +AYXRdJG+e+3ZwaR7w1pLMtFc88p7Oak2qpCI5YX4VwZOCK1CpXEPssYzbww==
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
index 21b85cd721cb..dc71b58b123c 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -5,6 +5,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
 
+#define __contains(name, node) __attribute__((btf_decl_tag("contains:struct:" #name ":" #node)))
+
 #else
 
 struct bpf_list_head {
-- 
2.34.1

