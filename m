Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776654E1C6C
	for <lists+bpf@lfdr.de>; Sun, 20 Mar 2022 16:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245420AbiCTP5W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Mar 2022 11:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245415AbiCTP5V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Mar 2022 11:57:21 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ADE54188
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 08:55:58 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d18so10792109plr.6
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 08:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pZfLmYbolHwmqXMfr7nqaaE34g3CnbTOWtScfGan094=;
        b=BrDwSz1lGS0KMZSQbROcqoOPNIAd6cd07xLHzZKwkW2k4h4G+mm9Wrj7swH1CV9v6n
         zo1iti3WpipaSfNmk2jAS5Cq2D/TO+vP0WIjThSuTM8zcdHICtAw/nRseV3Lvj9SVQkx
         7W0zjXyOyv/Bhl4Gr+1Tj9nbo24tQMfQK/vtdPxwANOZlaKIgYdeCW8D6AdYOLu0n0Do
         cl7PYCv+dvzRUk17HYmy1DVIya58ugM/e/Q+T639lkXBfsLdHziOM2+ie2sE0yjdAaDs
         PpRpU5uSVH2cK4UCyWGavM9DaInc8Y+S5FPp9HBuAcaOK7/InN2anNNXn1PmlT220wF7
         JvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pZfLmYbolHwmqXMfr7nqaaE34g3CnbTOWtScfGan094=;
        b=e+dJi2x7Y7IdSiBDr4JnBhkjIXzoJgnHXXyvOFyFmyaI92T/1cA4ci/GOdhUC/A7zU
         bDbTY4G3UjlSkp9+1sMy5a5/ogEX2y6uS/SDEelnawzNg41ljgHXlcZgDWHUhAsGhFX8
         71kWfKCkTcUxgR9lyTMy49kBBI7RmJYhgAHhgg2+riENCea3MTBU33InZ5ye9YzRkqFv
         qou60yzS31Vt7b5ABHoU5QViHN3+f2jG0o3BETZGu9LdzaSnMouD3gMX39h+2XPQDgdG
         zIvSFo8TSIeFe/aggeCll14RLvz+yj+vLV3pFACjVkBbIo3BQIW6bhzDl7orcvOIRA3n
         PhgA==
X-Gm-Message-State: AOAM531TMO9PtrWScZapVGMJWf+XYDmcGe2aCAJSij/Ab8LACxub+KeL
        JiH9S4tiPH1NEaAtrMtZnsVVfkBWVyE=
X-Google-Smtp-Source: ABdhPJxEuWA9N/Ym2yNCQbI9ehYzm50+vjXhDmHvmJmcoG404U+lYYuKFJeIPUjRirBw8ecTR4859w==
X-Received: by 2002:a17:902:8b87:b0:14b:47b3:c0a2 with SMTP id ay7-20020a1709028b8700b0014b47b3c0a2mr8957654plb.51.1647791758279;
        Sun, 20 Mar 2022 08:55:58 -0700 (PDT)
Received: from localhost ([14.139.187.71])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090a7f9100b001b9e4d62ed0sm17336506pjl.13.2022.03.20.08.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 08:55:58 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v3 11/13] libbpf: Add kptr type tag macros to bpf_helpers.h
Date:   Sun, 20 Mar 2022 21:25:08 +0530
Message-Id: <20220320155510.671497-12-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220320155510.671497-1-memxor@gmail.com>
References: <20220320155510.671497-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=907; h=from:subject; bh=dtVrckouAMHnmEAd4Rr2OdBAilXX+AUoTjGvaGbi9os=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiN00ysrejQAaub14DT4bq6Zig06TX+s1CkhTq0CzC 8ntkqcuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYjdNMgAKCRBM4MiGSL8RylDqD/ 476zJfYd3lkGWpUG5RTaArkBIkbPvBL7Fh5e2VR1SlYRJwamRhArVY04KaO8I0bLOM3Uiyl4+npsma FibxdZzJSKThEmt6xea7fFJAA4HZG4AZo/RFaz9EL1yBZF57iDzliG7ngGMWlBhcxLeGgYFDCf4rMO shnJ3FnB93pFg8L+QCFi881ZCg5TqAi2UiHHL6RZ6TjGsSTNV1idK7wRCGXnv0pcBWlbd9IosuQmII L36HbtSspS98vY4FSWUfdczHWj0gd92bvFbszIBOg9rI4kPjKUvkWLOLuQYNZvMemQPEVpTKd7NH8n nuSB1R8EbzlDLmDDWwy94SrqG0DGim1dyaomdXINE8XRIeeeqDyyleRLGZwnyWcWLzmYNx6wuR94yw /pkRgUauiBKDyCM5JIquD7hJ8tEzeiBpQ3JZTQ3bb+ArDpGqBfbjBvxxpa5azn3er3Y0UE3bRoAsZe bt5KUXx9GzLt6tckUKFf3XUIFxW9wvZwSxzVu7t6TmF9n0T0VAUPopEyRfeO1Y9lXRjd1Hb+7asdFR gh+FKVITUcw5q7EWZYNb/v2EuLDVnkIjYyzWKleK1txTO6vtpnoq+Lj+kbgj8uLG2xBsnF09ZNTwC/ /VYqoV0NFFA8mrHBP/KuaHJ1jgucEsTo+zoLwfjZ3WagujrUrokZEjLi6qXA==
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

Include convenience definitions:
__kptr:		Unreferenced BTF ID pointer
__kptr_ref:	Referenced BTF ID pointer

Users can use them to tag the pointer type meant to be used with the new
support directly in the map value definition.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/bpf_helpers.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 44df982d2a5c..bbae9a057bc8 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -149,6 +149,8 @@ enum libbpf_tristate {
 
 #define __kconfig __attribute__((section(".kconfig")))
 #define __ksym __attribute__((section(".ksyms")))
+#define __kptr __attribute__((btf_type_tag("kptr")))
+#define __kptr_ref __attribute__((btf_type_tag("kptr_ref")))
 
 #ifndef ___bpf_concat
 #define ___bpf_concat(a, b) a ## b
-- 
2.35.1

