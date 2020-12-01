Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2E52C9691
	for <lists+bpf@lfdr.de>; Tue,  1 Dec 2020 05:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgLAEmU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Nov 2020 23:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgLAEmU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Nov 2020 23:42:20 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4ABC0613D2
        for <bpf@vger.kernel.org>; Mon, 30 Nov 2020 20:41:39 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id d9so242653qke.8
        for <bpf@vger.kernel.org>; Mon, 30 Nov 2020 20:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RDs00tVo96Kqx2drcJiU3BBpp5slt3iL0SRlon2k7K8=;
        b=mmNVogu/m0EtZqUy6eZ2E2A4Hip6PkNPR9njR7iTeXXLD1FUqV7fwmxfkYLFTIxxMq
         AWe7f9KPUoluAnaGGz/Cvrb55amxYQEYfbxiSr34bX5POVtpJDQuZiH7PPlgkQvbixsu
         IbYUyNcnAfR5xT9xXeMxa36kXk+LbsE/QNqUmaXG1q6h4xrt60PZ8hI0pDYauF7EnRAO
         nqP7eX7uWD3qxto8mxrHDwP/IWCcaNe2kurnp4h1t7REci2S0OieuEE7z0PHq8W0iojE
         /raXc+0IufaFO48KRlnIBB7cvhrF50POY235gpd3p8wKn/2GPfBh984Y3EqdvBc4bEjL
         47LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RDs00tVo96Kqx2drcJiU3BBpp5slt3iL0SRlon2k7K8=;
        b=DwgcueEzTFq8RafGbOMNIEraTCpHjdFFKZ529k8akM39I2Usct2TOHoFzhacWxOXRj
         KCiPwSE/Tv+gu0NDvNMOvcXV/N/m7yBwkULZ4qDPnxpF9hxQ+uesN5NTlBkeKEGX6Zz5
         rQ1Sy21CqCxpukxTzsSfkMABGHuOdyKmPmL+TSNTHolBVdJleJvElfa01pL1k96D3ZQa
         K3vpd9PKV3G9nN/77X9eSllPPBJxbTJemvDXeh/MABBH96runtywe1Sa61LboyWkcwzO
         jflpe7JIJZhhqKIU95v+jyEfRyve9YPUFhgHcOoaJJ5dxf/ok9GJ4+9Q+O+UdTqZCXTd
         Wdag==
X-Gm-Message-State: AOAM533u7spHpYjRUJQccaLUZItOojc773I1Ml6RD9wvr55InN2Ss/XK
        CESu1GhCz4mw1RlUqVsRCQrj+L44fZvA2Q==
X-Google-Smtp-Source: ABdhPJyfZqxIevO71tNThne1OYU+GBwDONv+788MnKmU/YPpebnCu4TfHunsUSvTidZjXPhh6UcTZw==
X-Received: by 2002:a05:620a:2e8:: with SMTP id a8mr1218294qko.144.1606797698730;
        Mon, 30 Nov 2020 20:41:38 -0800 (PST)
Received: from localhost (pool-96-239-57-246.nycmny.fios.verizon.net. [96.239.57.246])
        by smtp.gmail.com with ESMTPSA id l79sm703445qke.1.2020.11.30.20.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 20:41:38 -0800 (PST)
From:   Andrei Matei <andreimatei1@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next 1/1] libbpf: fail early when loading programs with unspecified type
Date:   Mon, 30 Nov 2020 23:41:04 -0500
Message-Id: <20201201044104.24948-2-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201201044104.24948-1-andreimatei1@gmail.com>
References: <20201201044104.24948-1-andreimatei1@gmail.com>
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
 tools/lib/bpf/libbpf.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 313034117070..abca93b4f239 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6629,6 +6629,18 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	char *log_buf = NULL;
 	int btf_fd, ret;
 
+	if (prog->type == BPF_PROG_TYPE_UNSPEC) {
+		if (!prog->sec_def) {
+			// We couldn't find a proper section definition at load time; that's probably why
+			// the program type is missing.
+			pr_warn("prog '%s': missing BPF prog type'; check ELF section name '%s'\n",
+					prog->name, prog->sec_name);
+		} else {
+			pr_warn("prog '%s': missing BPF prog type\n", prog->name);
+		}
+		return -EINVAL;
+	}
+
 	if (!insns || !insns_cnt)
 		return -EINVAL;
 
@@ -6920,9 +6932,11 @@ __bpf_object__open(const char *path, const void *obj_buf, size_t obj_buf_sz,
 
 	bpf_object__for_each_program(prog, obj) {
 		prog->sec_def = find_sec_def(prog->sec_name);
-		if (!prog->sec_def)
+		if (!prog->sec_def) {
 			/* couldn't guess, but user might manually specify */
+			pr_debug("prog '%s': unrecognized ELF section name '%s'\n", prog->name, prog->sec_name);
 			continue;
+    }
 
 		if (prog->sec_def->is_sleepable)
 			prog->prog_flags |= BPF_F_SLEEPABLE;
-- 
2.27.0

