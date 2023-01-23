Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C3A677E6C
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 15:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjAWOwS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 09:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjAWOwQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 09:52:16 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804BC21A34
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 06:52:15 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l8so9216090wms.3
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 06:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNu9QsQPY2wu8htmYk3im2OcdGmOEVzjAIGzhmpVUyA=;
        b=PcaQ28kH4SooClUlQz95G9uZ8tcSGUme7UrShXExdvQZEu0+ZmqtlNONtrDsCSwBZ0
         w09/7zg5q1XeCkarCvdnps54Txg7CVonQJhy/1FT01SgVrKsJPNEQC2SYSboPSCKE+ul
         ptWUOy9xNliPQggk6uIPKVWQV1csyBEwfvTMcTm1hIpnyT3Y53Rev5LzFumJg4c4UbFG
         rRCA4qPMRP2ltvDfjKH1kAaJvhH4R2ZNOoJkSFh2cEomCMq6u7boSWKKVBC+ZtDFqKES
         wubBYUo8rIcPmUdWVG6CAUGh9GWWn+Akz74f9LcSaKPfGYclAf/+1L9PNhft/r2lRs4s
         onvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNu9QsQPY2wu8htmYk3im2OcdGmOEVzjAIGzhmpVUyA=;
        b=wC6DzCJsZUCjbn59t01T+G7/MXzROXi4q/j2J8Uah5uhTQozyhEx6nF5O6FLJhivs2
         1haGHtYR763Rp6OBV83+c9LcgwwTVtcQS9YPu8SPD/hhKOmJ9e0bd3VkUQluYw/c7N9w
         Dfnn0N65xAF1Sn4o2H0e9CJ33ICR2FZbyN8M47e4+MPYA9O7rY0at9zfwcWaQqYs1wZt
         6Tnfjmy3e9SgW7RPHNp+CYJRh0XiJvpVcx9ZGq7cYYFBWAhteFWo9RliLPGsVxhx/SQ+
         0Bj+4UgnSsg8YrGwqOCDTxP7MBrIYG6ZzlDCmjUTD5z74mEMUABgVdiTEfuNaSN07jbW
         xYlA==
X-Gm-Message-State: AFqh2krCoBjsLfOZfmSKjZ3YDWzd7FDwwDNXNlNc8Nsv1dqGh1luBDHG
        hw+nV5KnSdv4BV16Sj2hap4P6eb4hMg=
X-Google-Smtp-Source: AMrXdXtE/+Ze+aPJPbr15DWumFz/8NGqEg8OlFEgSb1A+VEGO4M2cOm3GWe8Ovw9igFz19tFe96neg==
X-Received: by 2002:a7b:c5c4:0:b0:3d7:889:7496 with SMTP id n4-20020a7bc5c4000000b003d708897496mr23733156wmk.17.1674485533906;
        Mon, 23 Jan 2023 06:52:13 -0800 (PST)
Received: from pluto.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b003d1e1f421bfsm11999649wmq.10.2023.01.23.06.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 06:52:13 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 4/5] selftests/bpf: __imm_insn macro to embed raw insns in inline asm
Date:   Mon, 23 Jan 2023 16:51:47 +0200
Message-Id: <20230123145148.2791939-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230123145148.2791939-1-eddyz87@gmail.com>
References: <20230123145148.2791939-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A convenience macro to allow the following usage:

  #include <linux/filter.h>

  ...
  asm volatile (
  ...
  ".8byte %[raw_insn];"
  ...
  :
  : __imm_insn(raw_insn, BPF_RAW_INSN(...))
  : __clobber_all);

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index e742a935de98..832bec4818d9 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -61,6 +61,7 @@
 #define __clobber_common "r0", "r1", "r2", "r3", "r4", "r5", "memory"
 #define __imm(name) [name]"i"(name)
 #define __imm_addr(name) [name]"i"(&name)
+#define __imm_insn(name, expr) [name]"i"(*(long *)&(expr))
 
 #if defined(__TARGET_ARCH_x86)
 #define SYSCALL_WRAPPER 1
-- 
2.39.0

