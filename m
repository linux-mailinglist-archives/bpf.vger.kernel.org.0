Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430185861F5
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 01:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238558AbiGaX1k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Jul 2022 19:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiGaX1j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Jul 2022 19:27:39 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A82DF40;
        Sun, 31 Jul 2022 16:27:38 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id h16so4802915ilc.10;
        Sun, 31 Jul 2022 16:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=cB5WuvMsmL6F+p20kPSMg4z0wjNtUJa9fTAIeiqeNtg=;
        b=UwjeSffKQbdKGY38++8RLRXtWE5vnHPXf5aKbUsULqFgamZa7wJBKH/tgNsD/3P/Mb
         TOrhHiAvNZht6t+P5kI00oooFPMX7Ti4RHffhfxaJjmh8jq0j5ObeP/wgg6AsKe098Rm
         Vn27F0jGjclnXhHBz3KqVqiovzMzbaqvyrQoOzpN6vAEW84mkm0w5olUtD5LSJhUvwA1
         5Kpg1MROyplYVMbLlXcB8xq/SXOqIzqWkJyz/gDsBTSxYTECHz75m99rMqlfXYupKHnU
         HDlSpv3ovD6ag/rWdafkKN3LSEFxj6SohCvuK0IQ0f4deggi2e4qJzqzTap7aBOgXf47
         xXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=cB5WuvMsmL6F+p20kPSMg4z0wjNtUJa9fTAIeiqeNtg=;
        b=HzaaVu28ZHQPYCIlsvjHKFGpfSOwFNllRbI2tab0lyGZi6XWlzA+46fcLdTZFVm55I
         coBlDkhbI9EiRuczRj6bC58T0ifzB2WtAd2cNPqzMf2uzu1q0cYeIxQdbhlnhlG0qRdh
         tyXBdrGXxMmpAHBb+D6wuFo8yD12TCD68ILG0sprXw+kLDuOXxyMpvNTvdX62W5wLMtn
         9QZiHVsSO8+kepO9a2O9AnZHh0bl98x1o5fqP3j0fGj8Kw8+myB84q/3CCa1l15Eh/TV
         b3C/JyA3gw8Z19jcuNj/tSAcxcWWCnMfM+EsWfxs9DZtubhmwpRTgtA4Gvxdm2vvUi0d
         6SGw==
X-Gm-Message-State: AJIora82lkgEx7jA4E9aNsKYp53baR/ItvBK5wjj7eFT4ASBOu5OcQqh
        C8FQhw2Gkzo5j0rWDt66aQGWP+5EqcGFDB7J
X-Google-Smtp-Source: AGRyM1t0LOpDqDHWBniiscxsxsIm+A+EEkohFxAgrEOAmTVPyLMMCm+20QPpp0AZwJYHGODQZSIUgQ==
X-Received: by 2002:a92:d606:0:b0:2dc:e2d1:b75b with SMTP id w6-20020a92d606000000b002dce2d1b75bmr5107679ilm.91.1659310057599;
        Sun, 31 Jul 2022 16:27:37 -0700 (PDT)
Received: from james-x399.localdomain (71-33-133-32.hlrn.qwest.net. [71.33.133.32])
        by smtp.gmail.com with ESMTPSA id c189-20020a6bb3c6000000b0067b75781af9sm4995861iof.37.2022.07.31.16.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 16:27:36 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     bpf@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] libbpf: skip empty sections in bpf_object__init_global_data_maps
Date:   Sun, 31 Jul 2022 17:26:49 -0600
Message-Id: <20220731232649.4668-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The GNU assembler generates an empty .bss section. This is a well
established behavior in GAS that happens in all supported targets.

The LLVM assembler doesn't generate an empty .bss section.

bpftool chokes on the empty .bss section.

Additionally in bpf_object__elf_collect the sec_desc->data is not
initialized when a section is not recognized. In this case, this
happens with .comment.

So we must check that sec_desc->data is initialized before checking
if the size is 0.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Cc: Jose E. Marchesi <jose.marchesi@oracle.com>
---
 tools/lib/bpf/libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 50d41815f431..77e3797cf75a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1642,6 +1642,10 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
 	for (sec_idx = 1; sec_idx < obj->efile.sec_cnt; sec_idx++) {
 		sec_desc = &obj->efile.secs[sec_idx];
 
+		/* Skip recognized sections with size 0. */
+		if (sec_desc->data && sec_desc->data->d_size == 0)
+			continue;
+
 		switch (sec_desc->sec_type) {
 		case SEC_DATA:
 			sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
-- 
2.34.1

