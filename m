Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BDA45B422
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 07:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbhKXGFu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 01:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbhKXGFt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 01:05:49 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA96BC061574
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:40 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id iq11so1602960pjb.3
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bVY6eVxviZg8xiPFaNj1olJC38mpBiTzlr43IK0kzAY=;
        b=HjXptZxqdaUc8OGSJO6sXPZXYD0xFQVerk9xp6hAfxaAcPcpYZc09aTeeP3JK48k4r
         Dv7GDODUD1Qrx0hJlzDaF6YIij9hw9gLnVFki0NOqlEEqVeX969bDtLp7DrhgJLaPGpG
         qmimyyAMSbMBDzyvA76MIaC0uR2pCAipohsAN2FNQABwoseFnnsGgDv/AaZ4bS4UkDHG
         Dzd0O3sBg+xLasG9e1TZWgu5tXK+PSGTQq3XK0uWbS67SoPG8Uz1ROWWAL0BLA8xpdTw
         pFduUBlbYGI7v4Ro7fvgNoGLHgJEP9LioDgE3WUpbo9RJIC8B3od1C+R+Z5KHusXokqa
         3uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bVY6eVxviZg8xiPFaNj1olJC38mpBiTzlr43IK0kzAY=;
        b=C5pgwOjLHOO6espsfEHySZ2VHmMGjhed4FYIbiITPrk/Sv8bgtwz94i8Qr1RcI83qn
         Lt69l9C5O8AcW873/4cGdxGxLiBZVM+BIeWy9jvih2zGGMgAHpRx+nh29Ssh+e829Qli
         8dU087dA9fhPce0UTxnSqVTaZuQa1lQmbrXGu77IJvqPlDnp2Qw2PsF2DzkZYWjLSIPc
         ONVref2MgOflGjI36hkUYIvTL5kEshj0LZUqUqiB1n6x/j/MZV7phne0WLVCoa2i4azO
         X5WCAZ7CD1gY+wBEdzzLRoo7eD7AruG/vNQjuUcazSJdnvXpeNYKAb0R6Hor/elGUXA6
         zdsw==
X-Gm-Message-State: AOAM5332hpazT1Kd7kAK5ByUckdHMKYxKZdwigC8g4iH4nOODDnP8Bdv
        XnUel38jkGCIKvEGGOfC0nVsh4Lpuuo=
X-Google-Smtp-Source: ABdhPJzwa6J7cZ3xrpZ/t4H8JhcKhAeh4nKCT7N6Zy4IIKhwRrNPKWi202oVoTWwC02JxEJ/SaQWPw==
X-Received: by 2002:a17:90b:3ec6:: with SMTP id rm6mr11663140pjb.94.1637733760169;
        Tue, 23 Nov 2021 22:02:40 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:8fd1])
        by smtp.gmail.com with ESMTPSA id nm13sm3044216pjb.56.2021.11.23.22.02.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Nov 2021 22:02:39 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 bpf-next 10/16] libbpf: Clean gen_loader's attach kind.
Date:   Tue, 23 Nov 2021 22:02:03 -0800
Message-Id: <20211124060209.493-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211124060209.493-1-alexei.starovoitov@gmail.com>
References: <20211124060209.493-1-alexei.starovoitov@gmail.com>
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
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/gen_loader.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 9066d1ae3461..3e9cc2312f0a 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -1015,9 +1015,11 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
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

