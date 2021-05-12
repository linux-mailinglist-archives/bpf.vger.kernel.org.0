Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B624D37EF2A
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 01:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbhELW73 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 18:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345371AbhELVnY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 17:43:24 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2285C08C5C5
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:07 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id a5so12654525pfa.11
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1+Zpv9JYBhU7ewga/40LM78tbNyS/mW675CJRjEZs9E=;
        b=n1GTaPa21nLeJ+WNKMWLoFxtOaRg+sTUPYikmWTnlJ36m2vNPdAGDuEbAH6TwPfdbS
         Llj855u/akHSfwfJWlUjhNtZ20dCHb/D9V+5NjhC/51h66Az00lv2Ip6BrgG8EN1HAnr
         8dhTzfN0WjuMIpOgK5ljWJy/UiMu1ZQ4wkUNGtjSoymh/ILEZp8PLlzBjBEaqpnLfx9B
         TEYptrIniVCns2H4FO/sN63MhuQHTOPMxJ9oMlRqaXHg3mYjgMMSk8YXNDX0uKMJ5cdy
         tPI/ewiaiiVtaj4fv4e8Q2Zg9B/MF8SWJNsh65SjjujgnRamCtsWE0xPHWkTGOPocKAB
         11tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1+Zpv9JYBhU7ewga/40LM78tbNyS/mW675CJRjEZs9E=;
        b=quY2C7pFAamgIETlM3YGdvL92jItXC5ru8agbfmjugr1My4kyEctuyIVo4YpgKcBzz
         hM2Ju3tD3PvPxEe+cWwXaqSC7Fh4ftQIKxI0+PKm2UZCEbRGL9uQcUkl59UPcx1mz9t2
         eVCqqfBfgGju3GqXOyie5Hfo7+O1AXkV92lDGqeFIr7AW3AoWy+2k0vXdGdEdY31kUBM
         vd8NbrwdYvYxmAZyY2f7GzgVp3nSTWfA+/6wQX3xchdRRMMXvRrzoqDdIf1M8IMny9UB
         T5X+VnM1JwGso561DJuZjDki6ZoKCro8ahitbvQet+e0TdhKOpi1rmtctKJZ6kRDC7a1
         2xSg==
X-Gm-Message-State: AOAM533kmGi9vCX16bcAjPxJ+Az09oNOcTRrX98uy2m4eWqOVhTFV+Dq
        ItbfNezultZtjbD42HsT8kU=
X-Google-Smtp-Source: ABdhPJy1cV+UQuYqmaO4sSZdQWIBkO91SYdletHJzWOiV9aCkzxA2KyDaCQZ4e6q6h+MgsFlUDtoFA==
X-Received: by 2002:a63:da55:: with SMTP id l21mr37984563pgj.188.1620855187463;
        Wed, 12 May 2021 14:33:07 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id c128sm609222pfa.189.2021.05.12.14.33.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 14:33:06 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 04/21] libbpf: Support for syscall program type
Date:   Wed, 12 May 2021 14:32:39 -0700
Message-Id: <20210512213256.31203-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
References: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Trivial support for syscall program type.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b8cf93fa1b4d..f4cf7cb87986 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8885,6 +8885,8 @@ static const struct bpf_sec_def section_defs[] = {
 		.expected_attach_type = BPF_TRACE_ITER,
 		.is_attach_btf = true,
 		.attach_fn = attach_iter),
+	SEC_DEF("syscall", SYSCALL,
+		.is_sleepable = true),
 	BPF_EAPROG_SEC("xdp_devmap/",		BPF_PROG_TYPE_XDP,
 						BPF_XDP_DEVMAP),
 	BPF_EAPROG_SEC("xdp_cpumap/",		BPF_PROG_TYPE_XDP,
-- 
2.30.2

