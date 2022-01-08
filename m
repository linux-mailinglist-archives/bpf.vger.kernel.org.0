Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F1B4880E1
	for <lists+bpf@lfdr.de>; Sat,  8 Jan 2022 03:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiAHCWd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 21:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbiAHCWd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Jan 2022 21:22:33 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18E0C06173F
        for <bpf@vger.kernel.org>; Fri,  7 Jan 2022 18:22:32 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id f8so7263646pgf.8
        for <bpf@vger.kernel.org>; Fri, 07 Jan 2022 18:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openresty-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=kGrdecSC3sPdHtWn9polPOvxxPNBR4DlkW3QJLsVlic=;
        b=KPgC6CipYjBN1/pAogCBoywf5xWdGJ/B9J1tE0Hjb5fDeS78+bRTKYKFp+dRTA50iR
         jO8NboZ1pDij5ZzWF1Bd/xLD8gjq3VCnc3rgCrlYet288M2HgQnc+N3crLRiaMjABrJ9
         GkBSXOqYM8tqEIG0zIOr5Mc6CBrdse+Mp8jQ10jmIqqKBrO/CDmWYjPAIfIRciBdMAMs
         j44VKzPle4WaUYSt/LQcPDR5GZF6ZVyzVFs5U/gvy1macxEh/jf0mRblD/Nr0dSMtBa2
         GkIKnNiSwbsZ/5wmDRnVM/hew30R1R9C/M7XRdzFVpFqBIS15pX4Uatv61K+MF2WHRqz
         h+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kGrdecSC3sPdHtWn9polPOvxxPNBR4DlkW3QJLsVlic=;
        b=qD5bptHreyr+2bYhWVrY9VHrQP4pNronuYmTgSLww8magglznqHId0pZRRrQrsKwBg
         c0UnGd7rOGO3VgYIw0iMPu6JBY2vDfTP1VSfLiAtHjz221N9MGcpRpewwLEE+Jlv2b5X
         JJQKwaBqqT8Akic7b6eatNT3JAQCEvq5ANBL7wN7d29pTxZEBDKFULK8AE8sOI/c1/MY
         L+mfbv63/OFQyR6l65z1eai0uzVnMOxE49y8heOM57IVxfRZ0uNPuK44erMtFcpYSJvL
         uVYL6vTrFsyXpuGI9d8lgfj7X8kjbR/QYhXswpGi6zBHkBI+vTJMY8QlnqA6RXWcWEfB
         RlUA==
X-Gm-Message-State: AOAM5324I8kmROzolBf9TJvx/5Z+YGvtXG1cy/yCVucMF0uZeG1y/PyZ
        6xGFNSULs5mav5FIfagKWviovnJiGu1mbuvH
X-Google-Smtp-Source: ABdhPJxCSy6VDT37VYN49wFdKlTjPScq9HkyQDn/tBoXW63qDWHpTqEY0bRELQJ9YMLrm9tBHwPbEw==
X-Received: by 2002:a63:af1c:: with SMTP id w28mr54159096pge.372.1641608552345;
        Fri, 07 Jan 2022 18:22:32 -0800 (PST)
Received: from localhost.localdomain (c-98-35-249-89.hsd1.ca.comcast.net. [98.35.249.89])
        by smtp.gmail.com with ESMTPSA id w2sm169050pgt.93.2022.01.07.18.22.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jan 2022 18:22:31 -0800 (PST)
From:   "Yichun Zhang (agentzh)" <yichun@openresty.com>
To:     yichun@openresty.com
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] bpf: btf: Fix a var size check in validator
Date:   Fri,  7 Jan 2022 18:22:12 -0800
Message-Id: <20220108022212.962-1-yichun@openresty.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The btf validator should croak when the variable size is larger than
its type size, not less. The LLVM optimizer may use smaller sizes for
the C type.

We ran into this issue with real-world BPF programs emitted by the
latest version of Clang/LLVM.

Fixes: 1dc92851849cc ("bpf: kernel side support for BTF Var and DataSec")
Signed-off-by: Yichun Zhang (agentzh) <yichun@openresty.com>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9bdb03767db5..2a6967b13ce1 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3696,7 +3696,7 @@ static int btf_datasec_resolve(struct btf_verifier_env *env,
 			return -EINVAL;
 		}
 
-		if (vsi->size < type_size) {
+		if (vsi->size > type_size) {
 			btf_verifier_log_vsi(env, v->t, vsi, "Invalid size");
 			return -EINVAL;
 		}
-- 
2.17.2

