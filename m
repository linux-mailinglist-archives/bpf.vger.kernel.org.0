Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BB065F481
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 20:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbjAETcQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 14:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjAETbt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 14:31:49 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C992DF08
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 11:26:51 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id d10so25154207pgm.13
        for <bpf@vger.kernel.org>; Thu, 05 Jan 2023 11:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2M/SEDI3ZFLLpa6t8CMCD85tOj1o/kREvGLd7NUi0i0=;
        b=bYiDK6coyyNfhwS9yGGXA4g3BMzQ6EtUBqat3QdKBC+jcD4l7q4QlmZhqOwOHhADeq
         dgCWJrtIF1YSaHqo0PjnD+lhyqppr73VpPDLIYY+ucZnsBicoMpc2hDuVHmBHJWa1H0E
         IBv3xU8jja7IXJ1CZaK2VrzBiCxVdmzHkJlQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2M/SEDI3ZFLLpa6t8CMCD85tOj1o/kREvGLd7NUi0i0=;
        b=RdW3IB48jTPdByxc74NOJJGDE82Eab+BWRw4mMyKlb1oH2Ams14IzoCaUwq+8nvyad
         QX1nxK0YwT2iDUlm1G6oS3RFbRZexwYEvZQTA/ZKII+h/5UuoYJmaVmt2NsclI5EHGQh
         MjIYaqt9SVvEbIXybHPzy4e4NzXAz7+pbqO5OT6lAbsuPz8BTuV79K9MSe23GJza8u6L
         j84oKjM+rUJfM/T8eTmiwkgO5cHBvvGxhaGYoVeL1F3waovnv9CTh0OlPgQDtSOrY8ea
         CtQoJlMvRhkrwyIJMphOuHGEn8he01rU5wd1DxBZEvVyJiQpVCfURzlICJc8IM/u80wb
         B+6g==
X-Gm-Message-State: AFqh2kqEqXFBBrFMOZWKC3db1IsEPR0tWtN2z57le12mZyyv900zlMEZ
        Tif1HSnGAazXJmj/ims7omqP/A==
X-Google-Smtp-Source: AMrXdXvzT1/nMWdJ84tldXI9Vmxm1E1kI6mLQa2i8Nq+0jr9Opq3PWNUANqe3ITb9AJZ9gTGQY4GYA==
X-Received: by 2002:a05:6a00:24cd:b0:581:4260:a650 with SMTP id d13-20020a056a0024cd00b005814260a650mr58589947pfv.33.1672946810834;
        Thu, 05 Jan 2023 11:26:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x3-20020aa79563000000b005818d4284aasm16046250pfq.160.2023.01.05.11.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 11:26:50 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] bpf: Replace 0-length arrays with flexible arrays
Date:   Thu,  5 Jan 2023 11:26:47 -0800
Message-Id: <20230105192646.never.154-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2101; h=from:subject:message-id; bh=V+hDTvfLNktsOza7//a0ww3JjY/DO434Oi3YuneAQho=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjtyR3frN3HKMkFYai/Tm7ow/5jyykqQkgn4p54zvI 3udqhk6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7ckdwAKCRCJcvTf3G3AJiVXD/ oDGiZsOyCTBvLW5TFiKe3edkbxbWHr734/G3YbQEr15ayjIYmPo4HRfPl5f4ILDNVy24KjBoUFo9pB coVD7DTnVaFqeQ+kIbE59nyjzZZuUstSyyrFAFaps2VjYlcxhQclBM8ri1GFaIyeeAeR5Qs/IPdlMn dfxzky3v1L3HQQLLG0h26sTRl+pgOhaN4hiihyxZZV8rYS1nM++DZyMjbUQh+7lO525XIOd1p5Mk0j YHEwojOP1BDNZ+/5RgCCPCyPzKhQyOB4glMRpff7BPpi/gX1moSO9xjQOxp0U/nrB/zR267fq8DCVm zeRSUBCdQdpM05UACFsqZJHwiiZerLz5/rgFgiehgoulnCiidE19JcAYOMqBI9mJqx/yTPCWjxpHGr 89uZ9V8XbgjBTViH2Xvt/GHKdKXjfMYgolk3dblHqteV/PQ287MVj0V3uO+WumVw1TY+Fx4TsJfdyS DoNCgswbqTMlBlxy3IySs5RDgp/viDh0jA9TDeolIk/9rYQACGi6HbaoVnmuEF1UWMAaKgZFbLv4gw z4Y0hX5Dp7dw34matjSvTPGwhiVP0io9YetucAqYbuVziv6heiXkyobM4g2alSdqn6rlsKkV0h4SBx H8qunve472K7XsC1zmNiU1mTDwRwXYbu2D3KNs2eAAicfhq9o18tJj/R5Hxg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Zero-length arrays are deprecated[1]. Replace struct bpf_array's
union of 0-length arrays with flexible arrays. (How are the
sizes of these arrays verified?) Detected with GCC 13, using
-fstrict-flex-arrays=3:

arch/x86/net/bpf_jit_comp.c: In function 'bpf_tail_call_direct_fixup':
arch/x86/net/bpf_jit_comp.c:606:37: warning: array subscript <unknown> is outside array bounds of 'void *[0]' [-Warray-bounds=]
  606 |                 target = array->ptrs[poke->tail_call.key];
      |                          ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/filter.h:9,
                 from arch/x86/net/bpf_jit_comp.c:9:
include/linux/bpf.h:1527:23: note: while referencing 'ptrs'
 1527 |                 void *ptrs[0] __aligned(8);
      |                       ^~~~

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: bpf@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/bpf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3de24cfb7a3d..2131000f711e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1523,9 +1523,9 @@ struct bpf_array {
 	u32 index_mask;
 	struct bpf_array_aux *aux;
 	union {
-		char value[0] __aligned(8);
-		void *ptrs[0] __aligned(8);
-		void __percpu *pptrs[0] __aligned(8);
+		DECLARE_FLEX_ARRAY(char, value) __aligned(8);
+		DECLARE_FLEX_ARRAY(void *, ptrs) __aligned(8);
+		DECLARE_FLEX_ARRAY(void __percpu *, pptrs) __aligned(8);
 	};
 };
 
-- 
2.34.1

