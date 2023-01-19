Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C730672EB8
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 03:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjASCPU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 21:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjASCPT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 21:15:19 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3501567957
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 18:15:17 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id q9so407993pgq.5
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 18:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyWwSNg9QzAeroGa/+/BxJKA6GqXjtdfjppelIMtWNc=;
        b=cekGRCsym0xj6j6V5fiM12CDlbG13NG8+GYHAxcT/oYo9NEQuncOezV+8i1JaE65t1
         iV0Ck9PqZSD4Axkv9e7O5mebnIdTMrzxM3oLq5uRZQkE70YZX34tmfdNOKn4r/1q7+Dt
         oc5QbqE8eiYJJhpI6Bu05QSCCqWnWeDLbc2PsCJPE6FUU5NDNiBu03/d8ObegDBGs3ir
         GwAiMNb0tY/pamqbMLt2DalU4nl2q8IduLHgV/jfhmhDQltU/X0HluhpCrkYyODXrS9j
         7uPEQI5zlwDBbh0ylq3zHJMMYftMb/Tv/UhNqHiACtrFnJdAwD72SyMD5l/eW/za5fro
         5xyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyWwSNg9QzAeroGa/+/BxJKA6GqXjtdfjppelIMtWNc=;
        b=no23dPuSGaBoXZjZlcgu3ypiulVs4mijuVcF/LsR4g8aS3KzhON9Op3ThazrfFIaH5
         F/kyPq9N+48RuC384ONGpfrYwQ/cR+Ffi9UoIXCcQZ8FluplvdO5iosa7mszYVwi+a1C
         ER6FRbG/sQx8ZI5VpqKT4H9F/jI7N17qu70fXF5x+y7Tims73r5/+yq3jyVnwT2CgRRq
         3+3ZGEh1y4UbiDxdivyK+0phzZcFxUNqvIfbskyAUIidz4Rr0tQyCvBPNALM4LdbJ+qG
         Akf9KNm9jKqzo+Zw+wv6W1K1Rlzdi8miRwL9zuneVqI/v1fxdo8C3mkZP+xxy1IKazZ3
         Nxlg==
X-Gm-Message-State: AFqh2krYbdzFMCjejW4e/iyur/wqbDvPFSiXT4lPNuqAj63m7AhqkwdH
        ijvFgqHZ5awU4jK78tSBm4Kn0I4SfEo=
X-Google-Smtp-Source: AMrXdXswtMGv9+yFBMsXw5DkxMjr9AZSN5/5xyVODLevUbmhJwj2JDRLOWvjbfRtkDHJow/rq1QHcQ==
X-Received: by 2002:a62:de44:0:b0:58d:a565:e2ea with SMTP id h65-20020a62de44000000b0058da565e2eamr10447105pfg.14.1674094516970;
        Wed, 18 Jan 2023 18:15:16 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id z13-20020aa7990d000000b0058a313f4e4esm17168181pff.149.2023.01.18.18.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 18:15:16 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 09/11] selftests/bpf: Add dynptr var_off tests
Date:   Thu, 19 Jan 2023 07:44:40 +0530
Message-Id: <20230119021442.1465269-10-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119021442.1465269-1-memxor@gmail.com>
References: <20230119021442.1465269-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1572; i=memxor@gmail.com; h=from:subject; bh=aspe8EeCNDbrDriDvXyGcWu+p91GApIw3l2e0nxkZ9k=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyKdAlEOmw0hPk8d0a6faIgyduUuCfRw5Be0GQOgn anmktwSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8inQAAKCRBM4MiGSL8RyuXqD/ 4gVsZEp2a+K/L5hpj7Kpf7ZIECeZevfTufrj2whHE4uJqm2VyHW29pT4jci2bHUSPgOwfW/wxmKC4j FlIsd5yULNn6w/KE0PpzJGHftv4gLYgZyoUPZ2s4BTiXwUZXQccq5qnTSjt2FaUmQZnMef4VWxGOxk Z7DZdcY8GWE3S1jbMnC2m4UUAso73DHa7B/NzEeooMGcD4MHHwJBMroLRrP1JHtp5Eq/qbpu2URjEb XtitCc2gB1OARPuOUuLzauDbbHUGmVZufY/bJ8wVB1SZbvnugqMlKIGvA3hXqVexej9FO6FUSl/69v It7xT8dC+BynjZmfrvvdvlx9b+W8msRW1p1pAD+fZ0DusckWcauzjWQVLEmV408vu+hWCLZZcoL7eC FBgV48j1gx3io2FZojlZEwyg+mmjxK5M2Y1qYJbo9tU8s7TnbV31GOmd/ReFFEqxSQYzHfG1lqdREQ Qhh+T/A0GzmKGX1IJ3i3Cb56obRRLfF1IWvZ/+ObWsKjOgg21JuoAW6AtsLsNQ7vJoAYosEQUEb9q3 4wC6ks38qNqU1Di610RQ9TscSBxJ/d+8qRFw2sfiJsLHJ2VT+G3mXgBAk/3SGZxeuzHEojRdHv3HFp uq34aOjPJRFUv7B5HYAM69etDefjppyqO34ujAxScftAJFSLtgoEiY9S+q2A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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

Ensure that variable offset is handled correctly, and verifier takes
both fixed and variable part into account. Also ensures that only
constant var_off is allowed.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 023b3c36bc78..063d351f327a 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -794,3 +794,43 @@ int dynptr_pruning_type_confusion(struct __sk_buff *ctx)
 	);
 	return 0;
 }
+
+SEC("?tc")
+__failure __msg("dynptr has to be at the constant offset") __log_level(2)
+int dynptr_var_off_overwrite(struct __sk_buff *ctx)
+{
+	asm volatile (
+		"r9 = 16;"
+		"*(u32 *)(r10 - 4) = r9;"
+		"r8 = *(u32 *)(r10 - 4);"
+		"if r8 >= 0 goto vjmp1;"
+		"r0 = 1;"
+		"exit;"
+	"vjmp1:"
+		"if r8 <= 16 goto vjmp2;"
+		"r0 = 1;"
+		"exit;"
+	"vjmp2:"
+		"r8 &= 16;"
+		"r1 = %[ringbuf] ll;"
+		"r2 = 8;"
+		"r3 = 0;"
+		"r4 = r10;"
+		"r4 += -32;"
+		"r4 += r8;"
+		"call %[bpf_ringbuf_reserve_dynptr];"
+		"r9 = 0xeB9F;"
+		"*(u64 *)(r10 - 16) = r9;"
+		"r1 = r10;"
+		"r1 += -32;"
+		"r1 += r8;"
+		"r2 = 0;"
+		"call %[bpf_ringbuf_discard_dynptr];"
+		:
+		: __imm(bpf_ringbuf_reserve_dynptr),
+		  __imm(bpf_ringbuf_discard_dynptr),
+		  __imm_addr(ringbuf)
+		: __clobber_all
+	);
+	return 0;
+}
-- 
2.39.1

