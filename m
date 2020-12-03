Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3A02CCDF2
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 05:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgLCEfL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 23:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgLCEfL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 23:35:11 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEE1C061A4D
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 20:34:25 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id u4so1026711qkk.10
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 20:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MlrmMb5BKWz180CJ0D9rZ2es88HpqoLdrKLE6eyfBfM=;
        b=ZGP08ZRbLmdUwqaTZBSzYBeuJu+jcVrtVDc4xajzfIWbSKeWK8+HN3BMpVWs6JFcsS
         tLruB3TVmVLsE1mtFF4lLM+KhMGTvytcT0wd6i88elEte1eOjm9H1MzqIOuFlf3ZM1vL
         wOXKnvKquSHzhlw03XBUAg10oVo5kUGkiRLc481a8bsSfF8WEspFz9emsVIdLoC5kKVe
         r63yQmNZTW6rm8rSb1MOZpx9/cPYbDj5OGrKlmvtA1wxjEaEWMp8KB59gMP4IWoJ1ATZ
         pwqsGUhoKtVs7401QPGQY0F/SV1fj+t3qeLqY4eraDILRQKgqInfy8uK8NpMyYl6Uq/l
         3P6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MlrmMb5BKWz180CJ0D9rZ2es88HpqoLdrKLE6eyfBfM=;
        b=tUjLXCYLyaKxs5GI90n01m57Q/ueb/3Ry6YnS6GGGpon6iQBwAMtKtCVwUwUp71qqx
         77Fk77A020Vhtb7JB5LOt/cJXlWo1pcoWty5nY2UU672BZWCbqaWNoT4To5QCWNXWfzu
         6ELGvFFEsU0JLAn0XxUCH8TnbZp/fH4STO/F5gqXxZ5EvL7k0OWP1bmBo9Cx0uNl2/RY
         PS+80/1oKmuo77HlnbHE3cIjbrkgmIcIFC0Qic46kdJNBYdMfjwEvQ+Rg+S2BtGaSjCP
         ONVYQfR6lz+n/YvwPj5QZguPamW1IGNyOXr6m977km4s+c7EPYrIgjd3Ygu5p/2wpdnT
         h/tw==
X-Gm-Message-State: AOAM5338fNkWHW9+ggqjkHDGDtWMEx1siSBclEobFMO+cc6iaJQuB7we
        krU+BQBLPDSwFeRbH4ovM8f6ohrVXHZVmQ==
X-Google-Smtp-Source: ABdhPJyM+8gxVVZUmOUhomhviVaHeHLuRecg3XCMED96FUmwY4tNwaRC7fMRFrF4S2ShfrVtKRsYqg==
X-Received: by 2002:a05:620a:2019:: with SMTP id c25mr1263273qka.282.1606970064022;
        Wed, 02 Dec 2020 20:34:24 -0800 (PST)
Received: from localhost (pool-96-239-57-246.nycmny.fios.verizon.net. [96.239.57.246])
        by smtp.gmail.com with ESMTPSA id q62sm305725qkf.86.2020.12.02.20.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 20:34:23 -0800 (PST)
From:   Andrei Matei <andreimatei1@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v3] libbpf: fail early when loading programs with unspecified type
Date:   Wed,  2 Dec 2020 23:34:10 -0500
Message-Id: <20201203043410.59699-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Before this patch, a program with unspecified type
(BPF_PROG_TYPE_UNSPEC) would be passed to the BPF syscall, only to have
the kernel reject it with an opaque invalid argument error. This patch
makes libbpf reject such programs with a nicer error message - in
particular libbpf now tries to diagnose bad ELF section names at both
open time and load time.

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
v3: fixup tabs/spaces screwup in v2

 tools/lib/bpf/libbpf.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 313034117070..d6f45538444d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6629,6 +6629,16 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	char *log_buf = NULL;
 	int btf_fd, ret;
 
+	if (prog->type == BPF_PROG_TYPE_UNSPEC) {
+		/*
+		 * The program type must be set.  Most likely we couldn't find a proper
+		 * section definition at load time, and thus we didn't infer the type.
+		 */
+		pr_warn("prog '%s': missing BPF prog type, check ELF section name '%s'\n",
+			prog->name, prog->sec_name);
+		return -EINVAL;
+	}
+
 	if (!insns || !insns_cnt)
 		return -EINVAL;
 
@@ -6920,9 +6930,12 @@ __bpf_object__open(const char *path, const void *obj_buf, size_t obj_buf_sz,
 
 	bpf_object__for_each_program(prog, obj) {
 		prog->sec_def = find_sec_def(prog->sec_name);
-		if (!prog->sec_def)
+		if (!prog->sec_def) {
 			/* couldn't guess, but user might manually specify */
+			pr_debug("prog '%s': unrecognized ELF section name '%s'\n",
+				prog->name, prog->sec_name);
 			continue;
+		}
 
 		if (prog->sec_def->is_sleepable)
 			prog->prog_flags |= BPF_F_SLEEPABLE;
-- 
2.27.0

