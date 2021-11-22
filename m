Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D3C4598B7
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 00:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhKWAAz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 19:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhKWAAx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 19:00:53 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3CEC061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 15:57:46 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id q16so971091pgq.10
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 15:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wLvm8xrydUZEiupL1Ri2HILzjTylSZV2lBH0wIPc26M=;
        b=OImYy+t8e9jWyQswbeAahACRkY2ARDQNzsDbthryrzfl2dHWbCHVyWH/LTYBfP+mm1
         6kkF45kWA+S21cguAcJ4EA7RLKhfwTyP8DypHUP64wvqefDZ1y72feZ1xkLyaE7dvtPe
         +RmvqvzuNk46T2PPj6vmeAdpsbyW3zFFBTLyZo8AeCGBoy+sg7hNa3r+PmYQfRLGWL28
         pVcBINaR9UbZzlbyp9yN/PUpjmMqpmOjTdHxm3FK+o/6z8GC6UMKnNBhMIbk7deURGcH
         enRURBpWQe+f9JuJyt9NT0uD8ek5m1/HDd/f9/+k5iH9+eDjwOH06oNANUaOzOSMKeVS
         8nsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wLvm8xrydUZEiupL1Ri2HILzjTylSZV2lBH0wIPc26M=;
        b=6eb3Ix7tpeGOYgqMDKoWMnPmdEA+KpFoO8Vc7GbgJxINpA0B0+i6qeO1M2K72uvTdV
         qlIpdej95imCmDVV5tDeDMKrGEy11boyYPnnXlBjrdakcbusCFNRbnnQ8EhHk3+c/y/m
         WwvQwBQHq/hVE7JNpkgQi6mLHu7juOSnNR/5pr63ZTWDOqrmeF2kjTNw0vdaSG7FJ/NG
         1QyH7ItFyiIvrCgAd0v5jX8lde3gHB8ugrlzFmk7vCPxwYye488lDDauUZebsB0n1DLK
         /XnJEAbrclt1sDX/EDx8Y9gCjzD/dVx9rQ/zdY9HB7N3+QqQnJvXHo1p7ug16EsENZpH
         byDA==
X-Gm-Message-State: AOAM530nUHmvz4T+0YXRbWZROsssp9407CE8J7aM+QWoBF3tQXJDl6cS
        fFpvyiSVNKKarViWH8O7cr0u1qVueB0=
X-Google-Smtp-Source: ABdhPJy/BKmRDCTsDXZNL+DW3hsOyv1bVBg94vLKv9EW7cn5aUEckYmMcvXD1WuGT1TK40KtVc+GSw==
X-Received: by 2002:a65:6814:: with SMTP id l20mr693249pgt.326.1637625465652;
        Mon, 22 Nov 2021 15:57:45 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id v1sm9419369pfg.169.2021.11.22.15.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 15:57:45 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v1 3/3] libbpf: Avoid reload of imm for weak, unresolved, repeating ksym
Date:   Tue, 23 Nov 2021 05:27:33 +0530
Message-Id: <20211122235733.634914-4-memxor@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211122235733.634914-1-memxor@gmail.com>
References: <20211122235733.634914-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1443; h=from:subject; bh=9Q/8ozrv6De4qMFJTMQslfhx934/a4xi8bfMHzQcEQU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBhnC22l8DY0vyOseEA61XY+X5BiLgpSzjAqdOhIYBT J8eBqXOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYZwttgAKCRBM4MiGSL8RysaiEA CWa7JzZXJ8xLyl9YVvq/lTT7hUZn+DcfymOd+yv1pC2FfgHokV2dY0H1xHkkmU+1nW08+pulWbNVdE mc28/gCnbmKhrOdkw5yYKxPbnju0i1KcAUcdadV/WWEPoTcEE1h6yjL9WfN3zeg2CwuxI5zrirMi3v ahEv7rn5iwFz+40acd3h2yGnjZ5T+FZSHf4PUc10klHZ/6mEftPeDar7dUhPigdF5bKFjpj0dCZKwN WfaDknC7OH6SFfDaZwd9o/83ScDwHL++tX7e37iiMguYzrd5B0v2Y4tiHGerR3/KjsreZ6klM7NGok Zf7jyMgWq2SHp7ZfPa9k7KDJGlaP79UTtGt0woQ0wGE40cd9b42nwhhIO91fmm7+yKoOq8eIr1XYoT BjWjcG5Mt2j4k8T2r9N/M3feeKRMA2Bns0N1i+iqp4Z4sKjUQqZtMa1YOK7rBC3jgd6oyBynzKHaiH qOdl/iXgmHpuFw5JIrFERj2qjjvogsO1NtutNw2PmGeoS5HSIz8olcYs8lmzbJQ1wkkZmCCW08t3IL Dm3mUYis1VHkHESdckx7ls1hBSg6K+LCfyfvXU6R6Mz/0cSMvQpWDbzvk+3EKaVJiZtytJCn9Hq23s fUBTTbpqHEHQD9/OXCIhIpnJyjcUUBv9OGSOiOlXk3+hLrLDfu1RSkaGe7qg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei pointed out that we can use BPF_REG_0 which already contains imm
from move_blob2blob computation. Note that we now compare the second
insn's imm, but this should not matter, since both will be zeroed out
for the error case for the insn populated earlier.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/gen_loader.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 88da09665eef..286fb0661487 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -809,9 +809,8 @@ static void emit_relo_ksym_btf(struct bpf_gen *gen, struct ksym_relo_desc *relo,
 			       kdesc->insn + offsetof(struct bpf_insn, imm));
 		move_blob2blob(gen, insn + sizeof(struct bpf_insn) + offsetof(struct bpf_insn, imm), 4,
 			       kdesc->insn + sizeof(struct bpf_insn) + offsetof(struct bpf_insn, imm));
-		emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_9, BPF_REG_8, offsetof(struct bpf_insn, imm)));
-		/* jump over src_reg adjustment if imm is not 0 */
-		emit(gen, BPF_JMP_IMM(BPF_JNE, BPF_REG_9, 0, 3));
+		/* jump over src_reg adjustment if imm is not 0, reuse BPF_REG_0 from move_blob2blob */
+		emit(gen, BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3));
 		goto clear_src_reg;
 	}
 	/* remember insn offset, so we can copy BTF ID and FD later */
-- 
2.34.0

