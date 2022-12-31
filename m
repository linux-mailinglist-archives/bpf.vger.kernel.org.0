Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E516665A5B8
	for <lists+bpf@lfdr.de>; Sat, 31 Dec 2022 17:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiLaQcI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 31 Dec 2022 11:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiLaQcB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 31 Dec 2022 11:32:01 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8707160DC
        for <bpf@vger.kernel.org>; Sat, 31 Dec 2022 08:31:59 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b3so35866381lfv.2
        for <bpf@vger.kernel.org>; Sat, 31 Dec 2022 08:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04IgbloqIx4UcCl5hVavkTaueACq57r7VhYRvQ+uq4E=;
        b=A6OM5X68HoXDXMFdrwM96/S2A2YuSlWbeck8hyMxW7mYujH4JL5MuNL3ffffZyJqZo
         vnv/FEnzSaQvOfDUrNNSfiCMP1zbB8syBjTw1QXdkkB0fP/6sCcJXfaHnezFy2lKRH1g
         rxoW9DhbB+j4slKkm4RX+V/WIImFiJmKJNennvKTASWrTeC6hvX3I5pmCCzjLMxVZJ6J
         CODUkc/ZX0B/InVlLEYzDFrAKH1G6MfRa6+KI8pjbvrSDYfV0vdvDdHoK+Nfsr3t7hDy
         7XrYGgfgHs6w/GyQUmXxHGUeboAVgrFZBHg4lsJYqL4+mpJHEnv2cvfvLzcDdgKg+qA9
         PUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04IgbloqIx4UcCl5hVavkTaueACq57r7VhYRvQ+uq4E=;
        b=Dl0RVSotsrFiYHv8AF7uNu5JzOJOKvjNCOQOv/ln9fSIaqsrSMlknsBVYhoFkWOdFv
         AJZwHP9DUWqHBklcpspPBLaUWS7Gg0QUVx7gJ00d5/S3h3M+8vHmyxm67aIlWLbGhFBd
         UZ/HIqsk0OyrtvAZ3jQ0+u71NTWBPEqQOKFsjTwnUsfV+bU4lHtli0Z5/pWIcGkS5VNK
         /b1z4mflSAXlBO/YbJEcZwYOmM/DyeeZ4rU+SlIo+vU1DV7g2xfZK9E76ovmRwMftDte
         3y/97NERF2+fncWhz9psf86yScOAbRwkXa8kEv6YxVI18fg9f3UtuwdMnm996SHH/VF4
         9Csg==
X-Gm-Message-State: AFqh2kr8wcUePY1Cm8QcRIYVBhpOhBfzpMV1GfBRWEhRKjp84rhGTUxm
        ey0Y5ydZhFJrg863G6o4J1RLnXf6rQk=
X-Google-Smtp-Source: AMrXdXttdifXCM4bi/c0Zy17o7ynxEILdXjPnVm3oqIxQCQCQA+OnzATsRL4fI9uLleAic9JqMWdbw==
X-Received: by 2002:a05:6512:308f:b0:4cb:1645:7259 with SMTP id z15-20020a056512308f00b004cb16457259mr4640079lfd.61.1672504318896;
        Sat, 31 Dec 2022 08:31:58 -0800 (PST)
Received: from pluto.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c10-20020a19e34a000000b004b4930d53b5sm3876784lfk.134.2022.12.31.08.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 08:31:58 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 5/5] selftests/bpf: don't match exact insn index in expected error message
Date:   Sat, 31 Dec 2022 18:31:22 +0200
Message-Id: <20221231163122.1360813-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221231163122.1360813-1-eddyz87@gmail.com>
References: <20221231163122.1360813-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Depending on the behavior of the C compiler statements like below
could be translated as 1 or 2 instructions:

  C:  int credit = 0;

BPF:  *(u32 *)(r10 -4) = 0

      - or -

      r1 = 0
      *(u32 *)(r10 -4) = r1

This commit relaxes expected error messages for a few tests to avoid
matching exact instruction number.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/log_fixup.c | 2 +-
 tools/testing/selftests/bpf/prog_tests/spin_lock.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/log_fixup.c b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
index f4ffdcabf4e4..760bd3155ea2 100644
--- a/tools/testing/selftests/bpf/prog_tests/log_fixup.c
+++ b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
@@ -123,7 +123,7 @@ static void missing_map(void)
 	ASSERT_FALSE(bpf_map__autocreate(skel->maps.missing_map), "missing_map_autocreate");
 
 	ASSERT_HAS_SUBSTR(log_buf,
-			  "8: <invalid BPF map reference>\n"
+			  ": <invalid BPF map reference>\n"
 			  "BPF map 'missing_map' is referenced but wasn't created\n",
 			  "log_buf");
 
diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
index d9270bd3d920..1bdb99b588f0 100644
--- a/tools/testing/selftests/bpf/prog_tests/spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
@@ -19,12 +19,12 @@ static struct {
 	  "; R1_w=map_value(off=0,ks=4,vs=4,imm=0)\n2: (85) call bpf_this_cpu_ptr#154\n"
 	  "R1 type=map_value expected=percpu_ptr_" },
 	{ "lock_id_mapval_preserve",
-	  "8: (bf) r1 = r0                       ; R0_w=map_value(id=1,off=0,ks=4,vs=8,imm=0) "
-	  "R1_w=map_value(id=1,off=0,ks=4,vs=8,imm=0)\n9: (85) call bpf_this_cpu_ptr#154\n"
+	  ": (bf) r1 = r0                       ; R0_w=map_value(id=1,off=0,ks=4,vs=8,imm=0) "
+	  "R1_w=map_value(id=1,off=0,ks=4,vs=8,imm=0)\n8: (85) call bpf_this_cpu_ptr#154\n"
 	  "R1 type=map_value expected=percpu_ptr_" },
 	{ "lock_id_innermapval_preserve",
-	  "13: (bf) r1 = r0                      ; R0=map_value(id=2,off=0,ks=4,vs=8,imm=0) "
-	  "R1_w=map_value(id=2,off=0,ks=4,vs=8,imm=0)\n14: (85) call bpf_this_cpu_ptr#154\n"
+	  ": (bf) r1 = r0                      ; R0=map_value(id=2,off=0,ks=4,vs=8,imm=0) "
+	  "R1_w=map_value(id=2,off=0,ks=4,vs=8,imm=0)\n13: (85) call bpf_this_cpu_ptr#154\n"
 	  "R1 type=map_value expected=percpu_ptr_" },
 	{ "lock_id_mismatch_kptr_kptr", "bpf_spin_unlock of different lock" },
 	{ "lock_id_mismatch_kptr_global", "bpf_spin_unlock of different lock" },
-- 
2.39.0

