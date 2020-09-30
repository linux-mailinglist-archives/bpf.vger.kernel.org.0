Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3C727E551
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 11:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgI3Jiq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 05:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgI3Jiq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Sep 2020 05:38:46 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5583BC061755
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 02:38:44 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p9so1815330ejf.6
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 02:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NyByuTEuvOirJzLXgLvvl14sRz/Wi0a0G4VWyIvlShU=;
        b=NBiHou7juyvnwuoaW1e12H+PmNKSAArGa6VOP5DiiawOFsgmko5Y87tn5AtropJDsp
         OuyoOCx5X0JhwZEGdHE5I7dI2iDrDpXfeFXZQcQH3KEqxLvshAR5i6WB1AI5C/3t/Gaa
         0N4rbyJzLhodUIOEZZNIz44ea7AF5qwpIaAbiKbB14IJeeorg6Xy5KU4DcRkferVbOYA
         IL2eqhZBrLe71tcfCRjniRh8YzUyscTbDNhy7rlqdCZ5hhL2+i3IP3U8CQPb4yG1Uvhk
         9ACa9A04aMIdEuljvGeyGjX927g/nSDqHTFoJYjK/QY+SY4mMBvk6p7RuD41HHi9J8ax
         l8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NyByuTEuvOirJzLXgLvvl14sRz/Wi0a0G4VWyIvlShU=;
        b=LwzA96kPMWVivRscq3s6Btg/kFl+s6erfxLsLpe88308pPTDcFQbaqSiMP4qE2u6LW
         01pgUjFimJ7GyZGhTrIu5a2nLTjiVNK6HanE3pHSpI+ditPI1IOBaHFnY6JxY44qjqQv
         GCeR2Wm6Fz8xVQtQcIkkt0+she6jLErndoRvyCQ7i4qXOtpkmyZzVgFuKx7kkkToLgqu
         JhAzaRZAE1tkAfbiBkPT5KIjVNzxvkoeyiXI+dotyYbGibMlpPfKAshX07fFMsbZnd27
         6WwCjFRkv2FRG3IFLiPeXG7uwcV3+AdPGbx0WrLhb1CXbBJ84tWj+AEwYSKp/p1qS1wM
         0i/w==
X-Gm-Message-State: AOAM533e5XIyYhiMrqHuVccft72hRmh4v0+usLgMIno11gwewhKuO2+M
        h51aufXOMi+eMj9SXRnfhu0U08myDoNlZ/Jx
X-Google-Smtp-Source: ABdhPJyBLqYdSL6tOrpKHMfoin1ZzKOd8Figm3Xj87tj3EferWP1TgsXAkqD2bIF96G5PLL0ycWt7w==
X-Received: by 2002:a17:906:3553:: with SMTP id s19mr1860336eja.178.1601458723027;
        Wed, 30 Sep 2020 02:38:43 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id ck2sm899422edb.95.2020.09.30.02.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 02:38:42 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     shuah@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        andriin@fb.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        jolsa@kernel.org, bpf@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix alignment of .BTF_ids
Date:   Wed, 30 Sep 2020 11:36:01 +0200
Message-Id: <20200930093559.2120126-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix a build failure on arm64, due to missing alignment information for
the .BTF_ids section:

resolve_btfids.test.o: in function `test_resolve_btfids':
tools/testing/selftests/bpf/prog_tests/resolve_btfids.c:140:(.text+0x29c): relocation truncated to fit: R_AARCH64_LDST32_ABS_LO12_NC against `.BTF_ids'
ld: tools/testing/selftests/bpf/prog_tests/resolve_btfids.c:140: warning: one possible cause of this error is that the symbol is being referenced in the indicated code as if it had a larger alignment than was declared where it was defined

In vmlinux, the .BTF_ids section is aligned to 4 bytes by vmlinux.lds.h.
In test_progs however, .BTF_ids doesn't have alignment constraints. The
arm64 linker expects the btf_id_set.cnt symbol, a u32, to be naturally
aligned but finds it misaligned and cannot apply the relocation. Enforce
alignment of .BTF_ids to 4 bytes.

Fixes: cd04b04de119 ("selftests/bpf: Add set test to resolve_btfids")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/testing/selftests/bpf/prog_tests/resolve_btfids.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
index 8826c652adad..6ace5e9efec1 100644
--- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
+++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
@@ -28,6 +28,12 @@ struct symbol test_symbols[] = {
 	{ "func",    BTF_KIND_FUNC,    -1 },
 };
 
+/* Align the .BTF_ids section to 4 bytes */
+asm (
+".pushsection " BTF_IDS_SECTION " ,\"a\"; \n"
+".balign 4, 0;                            \n"
+".popsection;                             \n");
+
 BTF_ID_LIST(test_list_local)
 BTF_ID_UNUSED
 BTF_ID(typedef, S)
-- 
2.28.0

