Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42FD669336
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 10:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240949AbjAMJr1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 04:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237529AbjAMJqo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 04:46:44 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C56781D69;
        Fri, 13 Jan 2023 01:35:42 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id y1so22918736plb.2;
        Fri, 13 Jan 2023 01:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LuIB1D5VRsHEDevL2A4uFAIi6WCJULM9GsA/lvt8gRg=;
        b=mnDB/X5DlObF+SjP5BeF0jehFm9HeXGYxNn4oN8HTB5R4Fqbz441FRARuNYzyJuGGF
         9Wc35fGmyl8YZeGv5nrkcOOG/VEZtx+VzOdELjedCFaH4aaXLZO+12PR0Gq0EsaIo+Bb
         SlgdQ/yKtYlScsrl9EDoGckqyYL8SHYnZl5WAv+nRcjQAuMS0pSQozp8r6G3WJYHu9oU
         e92u++dtOC1/mPIVhqA5IQ72filvcgQbdcFLwElLthbc+WovdtqTkLgYjjBCa8YsPiCx
         KvkgHka8A5MdFYIGvEnTmKCMaN9lxFgyEhHuFZ9om9sa3IUH4f9/44t5Y1KEH7Hvkoqq
         QrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LuIB1D5VRsHEDevL2A4uFAIi6WCJULM9GsA/lvt8gRg=;
        b=Ht3FcFiSSm39tNFYYR22y2DtqboRjZz6V3b2z95U653nC8t8smoIafxQPu9OyrIgCe
         GseTWUYA8NA8jDNEefXE1U15QqXgip7rILDRHGr1PS4T36420OsVJX3jrqrdlQSrzWXF
         iSyUZM82E/FcqFq7bcUCwQUXOz0+//w8fei8kky4a7qneYreeU0/n8lQa25Yh6JKhBQP
         Y1qFSR2+PJkipo7qAy4efdv/GRWVLWvJX3aLNBZSCyO+p8l3wjzeBQ9TJeUGJXRV9Xrs
         GBYnMopjKE3ebksJddlVtbRoW174OLETnJq/5lTLX2nl18bMhIo32mc8sJbXgg8Zq0s8
         FZ6g==
X-Gm-Message-State: AFqh2kpTi5R2QVDzU8hcFtlLVpFaniwih/0CgRKpXrrusGWxrIqjMfpz
        1FxGqobyqqZIbrEMJm9dkVo=
X-Google-Smtp-Source: AMrXdXuLiqHGdVOkmSVng7rqdaveCxTRaofjgG8nAEHpdBXuBZyAjqHm8kAc9GP7Cgq+kjEdwJN2Tg==
X-Received: by 2002:a17:902:7c17:b0:192:6b28:2b4e with SMTP id x23-20020a1709027c1700b001926b282b4emr65625792pll.69.1673602542027;
        Fri, 13 Jan 2023 01:35:42 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.12])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090322cc00b001896af10ca7sm13674311plg.134.2023.01.13.01.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 01:35:41 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     andrii@kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: [PATCH] libbpf: replace '.' with '_' in legacy kprobe event name
Date:   Fri, 13 Jan 2023 17:34:27 +0800
Message-Id: <20230113093427.1666466-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

'.' is not allowed in the event name of kprobe. Therefore, we will get a
EINVAL if the kernel function name has a '.' in legacy kprobe attach
case, such as 'icmp_reply.constprop.0'.

In order to adapt this case, we need to replace the '.' with other char
in gen_kprobe_legacy_event_name(). And I use '_' for this propose.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 tools/lib/bpf/libbpf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fdfb1ca34ced..5d6f6675c2f2 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9994,9 +9994,16 @@ static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
 					 const char *kfunc_name, size_t offset)
 {
 	static int index = 0;
+	int i = 0;
 
 	snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx_%d", getpid(), kfunc_name, offset,
 		 __sync_fetch_and_add(&index, 1));
+
+	while (buf[i] != '\0') {
+		if (buf[i] == '.')
+			buf[i] = '_';
+		i++;
+	}
 }
 
 static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
-- 
2.39.0

