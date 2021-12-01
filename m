Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409BD4654D8
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 19:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239327AbhLASQJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 13:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352228AbhLASOx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Dec 2021 13:14:53 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEBBC06175B
        for <bpf@vger.kernel.org>; Wed,  1 Dec 2021 10:11:14 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b13so18363514plg.2
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 10:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pyoh1aqHOvFXmvU6PIRcmfSQDw/GoPES6LSMSJtar9U=;
        b=S4aEsFbP6ti+z8ZEydLjvt4wzRLJ3rkm1HICnB1//Dn9hmpamnoys7DGzpXWtAmaG1
         AoYkz56Jg/E2Q4tx7zIQ91bRM8LLapKofbQIMTjZpGP902S2k7KbJQM1sTwanI6XEe88
         QdDCI2Nost3Y9UKQUcdREY7Qt3rY8B2Zv9OeBy75XHTdr1Mek6A3AWfmxZxFWQj2BBYr
         f5lxrvL4FqVlyxlgba3IOZBzOQiSfpGMgXEpkbllraS+8/i5O0peRl+UQRPq4Yc1/niB
         YATwnSC+zrUdkg3OXgXV8mSizt9WOCLXcRn7lJaI/DR87OevoMiHXn2VkHTW2fiYEB/2
         /RlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pyoh1aqHOvFXmvU6PIRcmfSQDw/GoPES6LSMSJtar9U=;
        b=O24jQON/gpYmsojWlVdeAXmuK7w1OX3aHElE0oWcev0SmwaIUfZrBrwQ004Q/K2gtA
         tRRWHvpL2JkBSlOqqyGU3JWZsJVFCSHH4X1TtQq9k/f2hbp3j2gSnYUTbKP4Fh6nrgEA
         UzapkbNTI81YbIUwAik3d1QUKX6UPlQ4gRW6KkHbhRFNZSFx2DqMND5GW7l2PWQ7v8Tf
         3gb+i6/I5IUs8aqmqAZgbsPYCjOZqRlC96pJNSqsoPT42KRR4m2yUX71ooGWfaSeRVHh
         x09OQcWutG51JzGEch226zFw8u0+S7fvSkRH7iFMB/nduRQZJwp5H2ek6/SBak382yqi
         /niA==
X-Gm-Message-State: AOAM532WfEthgfyJ7eOrFm7Z1UiS0I9zrS9GK3+fKjZ5UXpA1v2Yazkc
        yEmW3q1aGdVRuDfm6K6TvfntAQ955mA=
X-Google-Smtp-Source: ABdhPJydflVkZEo8cZL9xIIY1obplnRkjSTtf7IsfJaCJa22sucFWZTNNnG8NgNW7HXPuSKMATrDdA==
X-Received: by 2002:a17:90b:3845:: with SMTP id nl5mr9596641pjb.102.1638382273867;
        Wed, 01 Dec 2021 10:11:13 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:620c])
        by smtp.gmail.com with ESMTPSA id a6sm5823pjd.40.2021.12.01.10.11.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 10:11:13 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v5 bpf-next 11/17] libbpf: Clean gen_loader's attach kind.
Date:   Wed,  1 Dec 2021 10:10:34 -0800
Message-Id: <20211201181040.23337-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
References: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

The gen_loader has to clear attach_kind otherwise the programs
without attach_btf_id will fail load if they follow programs
with attach_btf_id.

Fixes: 67234743736a ("libbpf: Generate loader program out of BPF ELF file.")
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/gen_loader.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index ed0e949790da..21dfb930f1d2 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -1005,9 +1005,11 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 	debug_ret(gen, "prog_load %s insn_cnt %d", attr.prog_name, attr.insn_cnt);
 	/* successful or not, close btf module FDs used in extern ksyms and attach_btf_obj_fd */
 	cleanup_relos(gen, insns_off);
-	if (gen->attach_kind)
+	if (gen->attach_kind) {
 		emit_sys_close_blob(gen,
 				    attr_field(prog_load_attr, attach_btf_obj_fd));
+		gen->attach_kind = 0;
+	}
 	emit_check_err(gen);
 	/* remember prog_fd in the stack, if successful */
 	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_7,
-- 
2.30.2

