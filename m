Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96DE5F1BD8
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 12:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJAKpK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Oct 2022 06:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJAKpH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Oct 2022 06:45:07 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6576C1EC7C
        for <bpf@vger.kernel.org>; Sat,  1 Oct 2022 03:45:04 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b2so13693329eja.6
        for <bpf@vger.kernel.org>; Sat, 01 Oct 2022 03:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=I0Kgwsm6MMz+s3g+ObWAwy803kmWiuaT8m3YfjMLBoQ=;
        b=SbM7OeVL/PVedugz++gsCeDZQ8Vfbo1BzM0wl9g7iYM3WBG0IFFo48s1EvEwCTv/Cz
         +9mrBz3aov1uR252JgUIQmfmyVEOSdbLlRPB+oM2dwwTrul9IBtp/K/+XNlpKSRDqcyo
         J87OvP5O4bilhivTSwD3fmlj0kJB7r3A3RUzJ0LP9dETbFiPeOSxr2gpGnkNiEaBv8fg
         O9e8/OSO6kD+Iacdu6wdknIspZLcI8CFzPt5hAM5/1oGVMrfJvBT+CwUSnAlLusF/So5
         HXgsoDwqao8mEeHdM0Du6kguOOTG6oU1JwjbV0YNInEn1vqDxeHOGEqRW/nSCbnphcFZ
         6wpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=I0Kgwsm6MMz+s3g+ObWAwy803kmWiuaT8m3YfjMLBoQ=;
        b=MX5s0oyKsTapQNiGvy3MmFVXFNDR6U5EVlPr7FjNbrMX04g074KTnaOqvNHw90XPU0
         As6z7O2PjjsxvhIsA4HeKgN739PojhPdLxXHRh3eilbncDAm2rk/SMu62UeFrLDxNCMQ
         39DqUxZMm67tM/ZBTsG0j6XvTe1jrSaDoJzkKoUiRfDcIA8tHZLJ0HacTAcgexk7qgzW
         Y4PBiFCD+cP6LRzrkH57XutzvEThncqn0BoIi7s27eJItF0/c0VfwjxOWhvjaOKzmugJ
         v+fCHnTV3Alr1gk/Pbu6GRLHQeAfqld7Lec4JTlhchGtih3tlfMK5G6LReZXbvdl7TSx
         m51w==
X-Gm-Message-State: ACrzQf27Sedw1limzPaVskXwYtMmE811baIHJUkXhbW4H212mQMZbJ4S
        ULj3AXBg6QZ3UckqOS8VuEc00Tv5M5Fm0nJm
X-Google-Smtp-Source: AMsMyM6Mle0jPKVAtcCEl5p+Fb6WD7LT95q+DgQ91tCn2HPZNyc0o3+QMQmgPCvPz5hzs0viIpwqFA==
X-Received: by 2002:a17:907:2e01:b0:77f:92be:8181 with SMTP id ig1-20020a1709072e0100b0077f92be8181mr9461766ejc.229.1664621102702;
        Sat, 01 Oct 2022 03:45:02 -0700 (PDT)
Received: from badger.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id y8-20020a056402358800b0044dbecdcd29sm3415635edc.12.2022.10.01.03.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 03:45:02 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test btf dump for struct with padding only fields
Date:   Sat,  1 Oct 2022 13:44:25 +0300
Message-Id: <20221001104425.415768-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001104425.415768-1-eddyz87@gmail.com>
References: <20221001104425.415768-1-eddyz87@gmail.com>
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

Structures with zero regular fields but some padding constitute a
special case in btf_dump.c:btf_dump_emit_struct_def with regards to
newline before closing '}'.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/btf_dump_test_case_padding.c     | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
index f2661c8d2d90..7cb522d22a66 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
@@ -102,12 +102,21 @@ struct zone {
 	struct zone_padding __pad__;
 };
 
+/* ----- START-EXPECTED-OUTPUT ----- */
+struct padding_wo_named_members {
+	long: 64;
+	long: 64;
+};
+
+/* ------ END-EXPECTED-OUTPUT ------ */
+
 int f(struct {
 	struct padded_implicitly _1;
 	struct padded_explicitly _2;
 	struct padded_a_lot _3;
 	struct padded_cache_line _4;
 	struct zone _5;
+	struct padding_wo_named_members _6;
 } *_)
 {
 	return 0;
-- 
2.37.3

