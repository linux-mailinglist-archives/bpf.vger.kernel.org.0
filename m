Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC0045B428
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 07:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhKXGGG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 01:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbhKXGGF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 01:06:05 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0722BC061574
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:57 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id h63so1157865pgc.12
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ML9wWSB0Ft27w87gN8NvrgcplB6DVV/ROQjg086ar6g=;
        b=aZ/8Rf/No0AAnKfAOEVYNskXwllbciqsf8INHAll3D4ub4BUMbiZpbf0T7KS93Qo9y
         GYeXe0COJlqLqNNW93z2v/XDVLK+LU0HyIo6EDENF8LWXG8s4S31aFrLYZKiBxkDxenC
         /4fUkciJrNcjLRf0OcLTBMkvJW9aIf0na/nUTxh7p05TGgpAD7YfVwqHuvKVk1OhMfV9
         3dvNdLe0rfdAz2RUO8XaVRRfObchiC79e4beUqE39bs+EopFOjWF5LLtUeHCeimIARao
         JlaMV2W7aPgvdNhaNNrooEhEVvTCCY55dgs4peWVMF4+5EaofnckprSgexGEQz4eY59f
         m9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ML9wWSB0Ft27w87gN8NvrgcplB6DVV/ROQjg086ar6g=;
        b=TNw2ZXojiSHyAR1Zk6C5Ev+CBCpHUdC+0KKQuXZlwmphGUCBFp8uxPxfEsoWHVrCoO
         29Lv3AS+7qRdTvaxPgzLs7tUE1CzT//16VrgnTqktVvwVPICMPubwh136TQ5W0SuKmBE
         hN2Uac9zLFEaEtD9hV8CxdKvRNHsvJaD+GLqMce+Lz/lE9oUPhxyR+6gkdTUpiyvexot
         fp/rnKGlJrdfSr+cWkzR8j+6SrKdLkXd5cVg1PdWyPRk3gG6S9taxA4N+2WkuOGxdnKz
         fa6I3XyNOzhyPXckFJy99fDfA/IwRsj+Wp4SJWssMWW7wrTW0luFx4xXDK3S9V3chHVh
         E+3g==
X-Gm-Message-State: AOAM532I74jN+vFXEHgV60vPoN4opIhEMlrHnokfwcUDk/DLba319psy
        quMgUr7OHQBznVoC6fbq22c=
X-Google-Smtp-Source: ABdhPJyUjMQB+18aH8xUrfX7QO4pPFw9vd3lI/CmtwiSKBt3u7WGh0RCotl4lJm84jQiTbhtIhG5jw==
X-Received: by 2002:a05:6a00:14d4:b0:49f:f2ca:e2fc with SMTP id w20-20020a056a0014d400b0049ff2cae2fcmr3367130pfu.54.1637733776569;
        Tue, 23 Nov 2021 22:02:56 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:8fd1])
        by smtp.gmail.com with ESMTPSA id k14sm15087768pff.6.2021.11.23.22.02.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Nov 2021 22:02:56 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 bpf-next 16/16] selftests/bpf: Add CO-RE relocations to verifier scale test.
Date:   Tue, 23 Nov 2021 22:02:09 -0800
Message-Id: <20211124060209.493-17-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211124060209.493-1-alexei.starovoitov@gmail.com>
References: <20211124060209.493-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add 182 CO-RE relocations to verifier scale test.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/test_verif_scale2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_verif_scale2.c b/tools/testing/selftests/bpf/progs/test_verif_scale2.c
index f024154c7be7..f90ffcafd1e8 100644
--- a/tools/testing/selftests/bpf/progs/test_verif_scale2.c
+++ b/tools/testing/selftests/bpf/progs/test_verif_scale2.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #define ATTR __always_inline
 #include "test_jhash.h"
 
-SEC("scale90_inline")
+SEC("tc")
 int balancer_ingress(struct __sk_buff *ctx)
 {
 	void *data_end = (void *)(long)ctx->data_end;
-- 
2.30.2

