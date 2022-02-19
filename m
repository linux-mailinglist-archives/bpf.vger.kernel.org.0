Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65E94BC839
	for <lists+bpf@lfdr.de>; Sat, 19 Feb 2022 12:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239587AbiBSLiW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Feb 2022 06:38:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239523AbiBSLiW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Feb 2022 06:38:22 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63D748E44
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 03:38:03 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id m11so5574000pls.5
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 03:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XoJar16NVRcuRZ7TlhNBVxjGPdkFXWHNW7O3t39obB4=;
        b=X4kc5PUuQbxnsVtrriiix6ZKe5iu98uuMONhN5OOyEZ/Hh0wWiV9xfRutrjBb9mVN2
         +62RwUfYACHgM/4kdwwb1um33nIncH9QgU8QS9sQci5bgc4+daV+jufi3Us4fVFCfHsD
         nefK+ALIf/I/T1f56CczFI0ympZ7dbH1v2aVn5JoCuPzs+dIcUmgpJ7x7HORFOlmsf1k
         vsqA9KsE+Eo146e/8CIXN82+Q3ypTIt++3AxtT31fdTtXx6R6fIZ9Z0ExRnNk0Uth+6L
         2TS+vVjXAyiEIp32l/C7hw81RDY/k9LczbDrrjvXEVvv6r2NTrs60ccGT6/DZ1HhNKH2
         q45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XoJar16NVRcuRZ7TlhNBVxjGPdkFXWHNW7O3t39obB4=;
        b=KzAg4vENoknG4C2ezJQfbd+TULLt3NBATQK5oQ8bo2qD093tVYjyJAmmZmwrwc+pH7
         Yu/3dNFMZyHin9AATDyB4OG7k69FYnrTVPbyypWl2x79s9bnuU3SPjz4G1kR0DtIw5+n
         dqY8TbcQ2NFkGNQO4vIF4tA8TFthjTLDI7NYtqkJXq+90DQd/nimBYHs8GvaySBCZwP0
         CIcKu8c27wWP5Okhv6mqTS9bHmnfMQAW4L7rerH+QhjoB/TM6ke2DyKjtqxHFQghE03M
         4PM8olIucX6eIxPBCdudtH/764niT3Jfgkd91A5oxxh3y9Fam9utTSTW5bYLrA6XRx7d
         Nt8w==
X-Gm-Message-State: AOAM531KRbiF24IbWf295fOweblJO2oQDlzMJKQF/uBrqDJXhSfcYumd
        zH7Z+5+8+5ibu8w/hbq0O8D0VdL2lsg=
X-Google-Smtp-Source: ABdhPJxc4mraAdzmwGbtagOsX5M+iJ2LMAMoXKqU0NQuPFPxkBoFcPrRBJo5M+yw1P6wG9Bj4uKzsg==
X-Received: by 2002:a17:90b:1d0e:b0:1b9:5a43:2277 with SMTP id on14-20020a17090b1d0e00b001b95a432277mr16820209pjb.52.1645270683141;
        Sat, 19 Feb 2022 03:38:03 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id j15sm6548893pfj.102.2022.02.19.03.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 03:38:02 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf v1 5/5] selftests/bpf: Adjust verifier selftest for updated message
Date:   Sat, 19 Feb 2022 17:07:44 +0530
Message-Id: <20220219113744.1852259-6-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220219113744.1852259-1-memxor@gmail.com>
References: <20220219113744.1852259-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2170; h=from:subject; bh=dyJLoyeuvQy5qyKcjPqlG1OpxVRR3iVoPjvlGvhcEFE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiENZ6kR1i8t63UefK6AESmIXPvMCWWfYcxf3t/6e3 MPf75M2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYhDWegAKCRBM4MiGSL8RyuY+D/ 48A2mLFUPxtWpNaZHP7KxhoiWz3lTWbJwV/NT4boqIKDMKJrlcKkfstcTBgaX1wGJJxt05C6wuRtP2 HmH03WvfuID5fGkThCzBPWdjYswByMvbiBAXk3ex/X3OQDIkCHvdeKh6HyXt+8ziXxfe/zYhWNCpgt Sayg12wiY0vnFWctY2aOS1YTEGQnlQ/C8N6UuUALxo3qFr92Ql5nhgOsJ6EVjXIWwDqK0pJZTLdR0e 7yahwWft4fkVPOaWf9jHdQ7nw6G+t6GQV08o74c+BW6zNSFl6357PYBX+hTdhHovUCd34k5YKuO7vo idCWwRWFSqXOxGmT5GyCXUdPcQ3wQRnUb6Am9oG1NV0Q/OLY0ail7PdRuXriGbgwPeQt6V741Di4u2 dgVcPH4eCgLNRi1sXzgaLzC7eBY+6xiQ9lU2RUDd9hnmASJrOcRzFf8dGs9Gn6rTeHw38u4JQmLpAx n3DnnNH2W5JFUbP0hYRMz6nsDGCcfKwOXyYJyptJyaRxJih3pFpGNV9jIjcOhoJNhi0eH5ClCQ7fSn PRX0f15z4aOKM9OEVKb5ExgGc9DIwtxeZS631ArnCQbTy4uFn+oayu0IS1Y3popEjvMfyJQfi2cW9h so6jlKXj448jnaIzFiluRLbebrW/3euxNrt1yJJdeGifxldgUjhRqxsAV/+A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Verifier now prints a different message on seeing negative offset for
ctx reg (and others as well), change the errstr expected by test.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/verifier/bounds_deduction.c | 2 +-
 tools/testing/selftests/bpf/verifier/ctx.c              | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/bounds_deduction.c b/tools/testing/selftests/bpf/verifier/bounds_deduction.c
index 91869aea6d64..3931c481e30c 100644
--- a/tools/testing/selftests/bpf/verifier/bounds_deduction.c
+++ b/tools/testing/selftests/bpf/verifier/bounds_deduction.c
@@ -105,7 +105,7 @@
 		BPF_EXIT_INSN(),
 	},
 	.errstr_unpriv = "R1 has pointer with unsupported alu operation",
-	.errstr = "dereference of modified ctx ptr",
+	.errstr = "negative offset ctx ptr R1 off=-1 disallowed",
 	.result = REJECT,
 	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
diff --git a/tools/testing/selftests/bpf/verifier/ctx.c b/tools/testing/selftests/bpf/verifier/ctx.c
index 23080862aafd..e47a001c2bcd 100644
--- a/tools/testing/selftests/bpf/verifier/ctx.c
+++ b/tools/testing/selftests/bpf/verifier/ctx.c
@@ -58,7 +58,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = REJECT,
-	.errstr = "dereference of modified ctx ptr",
+	.errstr = "negative offset ctx ptr R1 off=-612 disallowed",
 },
 {
 	"pass modified ctx pointer to helper, 2",
@@ -71,8 +71,8 @@
 	},
 	.result_unpriv = REJECT,
 	.result = REJECT,
-	.errstr_unpriv = "dereference of modified ctx ptr",
-	.errstr = "dereference of modified ctx ptr",
+	.errstr_unpriv = "negative offset ctx ptr R1 off=-612 disallowed",
+	.errstr = "negative offset ctx ptr R1 off=-612 disallowed",
 },
 {
 	"pass modified ctx pointer to helper, 3",
@@ -141,7 +141,7 @@
 	.prog_type = BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 	.expected_attach_type = BPF_CGROUP_UDP6_SENDMSG,
 	.result = REJECT,
-	.errstr = "dereference of modified ctx ptr",
+	.errstr = "negative offset ctx ptr R1 off=-612 disallowed",
 },
 {
 	"pass ctx or null check, 5: null (connect)",
-- 
2.35.1

