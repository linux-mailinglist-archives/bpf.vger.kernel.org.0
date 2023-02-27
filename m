Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3516A3BA6
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 08:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjB0HUX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 02:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjB0HUW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 02:20:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A58E3B9;
        Sun, 26 Feb 2023 23:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=SzNBAEO+HmUg2XhCvzB8GyNus0AL5as/+GanLa2IUdI=; b=a4RotzB3NzKQxisTWmEXktURhp
        VDuqMEFXS7GGh8QoXglF+7y2Vm4WQn3gnBxElZsVXCO4wiRx3JXJlB95crv/AxnyIlS66mj+hGGNH
        KsOacAZCu+W6DKrZ1gdNO0QRnX16tPnEPBlw1ud5Irgt8PAg/mlcNWUuQrabD5Mq3Yf75McV0zJ72
        K9t0BFZujtFNnpyU8kNPgCclm1POJKWYiykPQD3zcagssQjnf7eESBhZuOYkPFawSV3PKn3a6JLHO
        yATNlYcIuDIgMzIgOAOhvpWnJu+z7/rBpjM7CKv7n4ssMGxrG/8T9wK46WeNsK2gRSHdBxUveqxUN
        DWc6zhTQ==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWXo1-008esp-Hx; Mon, 27 Feb 2023 07:20:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Pu Lehui <pulehui@huawei.com>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        linux-riscv@lists.infradead.org
Subject: [PATCH bpf v2] riscv, bpf: fix patch_text implicit declaration
Date:   Sun, 26 Feb 2023 23:20:16 -0800
Message-Id: <20230227072016.14618-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_jit_comp64.c uses patch_text(), so add <asm/patch.h> to it
to prevent the build error:

../arch/riscv/net/bpf_jit_comp64.c: In function 'bpf_arch_text_poke':
../arch/riscv/net/bpf_jit_comp64.c:691:23: error: implicit declaration of function 'patch_text'; did you mean 'path_get'? [-Werror=implicit-function-declaration]
  691 |                 ret = patch_text(ip, new_insns, ninsns);
      |                       ^~~~~~~~~~

Fixes: 596f2e6f9cf4 ("riscv, bpf: Add bpf_arch_text_poke support for RV64")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/r/202302271000.Aj4nMXbZ-lkp@intel.com
Cc: Pu Lehui <pulehui@huawei.com>
Cc: Luke Nelson <luke.r.nels@gmail.com>
Cc: Xi Wang <xi.wang@gmail.com>
Cc: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: "Björn Töpel" <bjorn@kernel.org>
Cc: linux-riscv@lists.infradead.org
---
v2: add header file directly to bpf_jit_comp64.c (Pu Lehui)
    change patch target to bpf (for fixes)

 arch/riscv/net/bpf_jit_comp64.c |    1 +
 1 file changed, 1 insertion(+)

diff -- a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -10,6 +10,7 @@
 #include <linux/filter.h>
 #include <linux/memory.h>
 #include <linux/stop_machine.h>
+#include <asm/patch.h>
 #include "bpf_jit.h"
 
 #define RV_REG_TCC RV_REG_A6
