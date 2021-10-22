Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5361E437503
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 11:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhJVJuH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 05:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbhJVJuG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Oct 2021 05:50:06 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196F7C061764
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 02:47:49 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id z11-20020a1c7e0b000000b0030db7b70b6bso2734022wmc.1
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 02:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XuyoO0KwbnJlAvuwrNyqN2UzjOrfqN6yescFAavqV+0=;
        b=l9uS1gic+zy8IAayhWSJyK+m593hBUWrhkXaAbTdjCdOzFfqaFnDlCuVL3Oy/dDmGm
         sPc5lm9q6bbNcR7K95BFCnDLTS3tMlWm9l2aLq2tBE9C8MVpdpjiwE2U5FV20VUfGOtp
         Rr/Oy2aF71mJ1qVZGaLER3haWX7dEr6lZPRfh/G7EyNQpzSnRt7BBzSmOIRsC9fq4gAv
         0fqAAKz0AMQ9ORVSpAfSIKqg7cp6Cyla8c5TD2fMqGzOK/0fJw/8g9+uxU9FXQ9mtcLJ
         7CcU9OQHyNAoI+0xT5xvEBnqxuJDN/SZbcuUCZb65jbAYjDyyaGPHpw9WzdkQyQHamXK
         +6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XuyoO0KwbnJlAvuwrNyqN2UzjOrfqN6yescFAavqV+0=;
        b=DcEAQ5LH7SXbK+CiJYN1DWspmtlYSsKx8DVnibVZTVCXgZjlEUmcjLYtQE1sOCBSKK
         Zxg8IsWcU4t/Zb86zkPkiXpN9dhfMnF9XNwln5h7GGrFif/9adwcCRl7Y1lTWIl9owuV
         0kfyLNVWM5kxQOHbFJCFSrj6CnY+E+osiLvgs4LD6yKA3RcjkDRoqpSgTYNF26R5DbX6
         Pe9iL6P2iPTpzQEcFDXFZ5IAQcLkrzXkC3zuiSnFJoqy29lttnM1NzVqZzZrfcDBYCC+
         VkwXl4Rm4MA0Bax7AXT9r3fiXGSP41LHQmd8ReXy4Tve7Infh9/m6HkH+IIKcHsx38tj
         MlIg==
X-Gm-Message-State: AOAM531wqBmVra5Fncpxymw1o5GGzmiCMBr7g3A4STJHHVj6jkMnRBDu
        xjR1Njs6LYZ+pb29EsF2Jr+Q4Q==
X-Google-Smtp-Source: ABdhPJwMtcgjSWPbcQlGaNLO9zs6nwoMjl5M9xyy52UDXBAyjJNLhsHxSyCANAy2N9NYBOZpNBBwoA==
X-Received: by 2002:a7b:c757:: with SMTP id w23mr12821745wmk.84.1634896067692;
        Fri, 22 Oct 2021 02:47:47 -0700 (PDT)
Received: from localhost.localdomain ([149.86.70.166])
        by smtp.gmail.com with ESMTPSA id g2sm7277368wrq.62.2021.10.22.02.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 02:47:47 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next] bpftool: avoid leaking the JSON writer prepared for program metadata
Date:   Fri, 22 Oct 2021 10:47:43 +0100
Message-Id: <20211022094743.11052-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bpftool creates a new JSON object for writing program metadata in plain
text mode, regardless of metadata being present or not. Then this writer
is freed if any metadata has been found and printed, but it leaks
otherwise. We cannot destroy the object unconditionally, because the
destructor prints an undesirable line break. Instead, make sure the
writer is created only after we have found program metadata to print.

Found with valgrind.

Cc: YiFei Zhu <zhuyifei@google.com>
Fixes: aff52e685eb3 ("bpftool: Support dumping metadata")
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/prog.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 277d51c4c5d9..f633299b1261 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -307,18 +307,12 @@ static void show_prog_metadata(int fd, __u32 num_maps)
 		if (printed_header)
 			jsonw_end_object(json_wtr);
 	} else {
-		json_writer_t *btf_wtr = jsonw_new(stdout);
+		json_writer_t *btf_wtr;
 		struct btf_dumper d = {
 			.btf = btf,
-			.jw = btf_wtr,
 			.is_plain_text = true,
 		};
 
-		if (!btf_wtr) {
-			p_err("jsonw alloc failed");
-			goto out_free;
-		}
-
 		for (i = 0; i < vlen; i++, vsi++) {
 			t_var = btf__type_by_id(btf, vsi->type);
 			name = btf__name_by_offset(btf, t_var->name_off);
@@ -328,6 +322,14 @@ static void show_prog_metadata(int fd, __u32 num_maps)
 
 			if (!printed_header) {
 				printf("\tmetadata:");
+
+				btf_wtr = jsonw_new(stdout);
+				if (!btf_wtr) {
+					p_err("jsonw alloc failed");
+					goto out_free;
+				}
+				d.jw = btf_wtr,
+
 				printed_header = true;
 			}
 
-- 
2.30.2

