Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F0B59640B
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 22:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbiHPUzo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 16:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiHPUzn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 16:55:43 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DB674B82
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 13:55:43 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id y9-20020a17090322c900b0016f8fdcc3b1so7118837plg.6
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 13:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=QrSW24/BS8u7q7dcP3o82dhH836yjfgTMb9u+0+RDPE=;
        b=hyCzE9JxjRzZ7zx6nizeJ1Ep24IqkfM3vFhvcOlBHgf0YtvYNVANdYmvd+ej3RGHNz
         ZdKP3kltutminzjQmgtk+SqYcpqP45GmC6q1c0bVj9bKW1Bmiqu3OB4EsyFRz9qmXoEB
         xxHM3mvnAI87dRzvpLrjFOnjELpDSAMMNiwqPSm0g15MB7EbBLEm3bVTlo91M4Ipf8Bc
         8aDxulHd6by/u55s4KC++IyB1/gjRiSKTqf51Agi2Jj4efHbwTtJWmytOOJO7tcYIqk3
         F7GtLIaW8qKJu1aIB1ujkk04GJ5t3fmsq/eHfX3CDhG7PpxpPmhzmT3auXFx8zF/Ze5j
         N8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=QrSW24/BS8u7q7dcP3o82dhH836yjfgTMb9u+0+RDPE=;
        b=l1lzcfFr/Z4SVYhM85RlMfW4r7Beg5MVmnwzlCI/vqGfouxb7FibdOcQysjlux/ypv
         FwXFInGZlofiWQG4D0jRTy/W10JtUmQbJC5nvVyvEj6GW4iF25m+hcXnUW74vA2ekfvs
         Li32yV10Zd8bx3Zow4UaBXMCCiw0cDRq5NRYAThssv56lYDvobyR9Y50WPXaK6VTxMQY
         LvyM8AS8knyyF2KsMz8luwbCrftzmX2HU+hpsUuXoxsXVGNPCGEfd1w61skA43N6grjd
         4wOI9IV+RrnT2Lb0sJQRhVAZNfbmXRuRnodWZweUz/FADE0K8P0dWb1hmxu8c6ZIyxhY
         V91w==
X-Gm-Message-State: ACgBeo3HajKAMzfAOcqZ6od3PvfU0BIcTtz7/CllJ8+iIjdYZOCdJXWW
        CN37oJ1UbzNZyymAqpDI3RePEOfxBgGBZIZ5iOaoKa0DYRAb27qubOZstYpM/sET17TKn+FHGzM
        laNW77TXQMlQ+gMAzYKJHVlJLJr4VSSnJcpLsxIq2TvfVguMZfNNWfffATOqtS10=
X-Google-Smtp-Source: AA6agR4Gve3PtDBwyEebIxFsHHKJknmXGXa055YJseN8EgiPxe7Ix7BUJhr+7hYaPqw3/jpwuFJAjKEj+Qyy5g==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:aa7:88cf:0:b0:52f:fdad:9e0 with SMTP id
 k15-20020aa788cf000000b0052ffdad09e0mr22733683pff.74.1660683342445; Tue, 16
 Aug 2022 13:55:42 -0700 (PDT)
Date:   Tue, 16 Aug 2022 20:55:16 +0000
Message-Id: <20220816205517.682470-1-zhuyifei@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf 1/2] bpf: Restrict bpf_sys_bpf to CAP_PERFMON
From:   YiFei Zhu <zhuyifei@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jinghao Jia <jinghao7@illinois.edu>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jason Zhang <jdz@google.com>, Jann Horn <jannh@google.com>,
        mvle@us.ibm.com, zohar@linux.ibm.com, tyxu.uiuc@gmail.com,
        security@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The verifier cannot perform sufficient validation of any pointers
passed into bpf_attr and treats them as integers rather than pointers.
The helper will then read from arbitrary pointers passed into it.
Restrict the helper to CAP_PERFMON since the security model in
BPF of arbitrary kernel read is CAP_BPF + CAP_PERFMON.

Fixes: af2ac3e13e45 ("bpf: Prepare bpf syscall to be used from kernel and user space.")
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a4d40d98428a..27760627370d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5197,7 +5197,7 @@ syscall_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
 	switch (func_id) {
 	case BPF_FUNC_sys_bpf:
-		return &bpf_sys_bpf_proto;
+		return !perfmon_capable() ? NULL : &bpf_sys_bpf_proto;
 	case BPF_FUNC_btf_find_by_name_kind:
 		return &bpf_btf_find_by_name_kind_proto;
 	case BPF_FUNC_sys_close:
-- 
2.37.1.595.g718a3a8f04-goog

