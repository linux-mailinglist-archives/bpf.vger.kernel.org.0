Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869D8217A21
	for <lists+bpf@lfdr.de>; Tue,  7 Jul 2020 23:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgGGVQy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jul 2020 17:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgGGVQx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Jul 2020 17:16:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B122C08C5E1
        for <bpf@vger.kernel.org>; Tue,  7 Jul 2020 14:16:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r17so48674831ybj.22
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2020 14:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LK+EBRynEXsucfX04gFvi+gNnB4EOZ/bB2WzuaaMYIc=;
        b=Rug8tm+xa2icYOqvro5VOiB7Xb1MvWVSdcHzdKmC5ojZ1nEeGXG4Z7+A9IpOHkU3id
         vZ14aeY8oW8KS5Ms4Y6CcnEvMMZQEwc+KXXJzM7uvknJPWiNLF4FHQh+MLvz5eK9+1WK
         2UAS1N5Te+mjL/j3pUa9f+zrdmJxEb2wWf12T6FvlND+IIRhzsmnIW4/SZQ2hGc6GYjy
         RDRASgQOSHIrzI+59CFyx7vDoXfZ9OoDQObliOx+xsar02qBSpqWD4G4IvCWoOm0jg+U
         GR+s9JWZ9b2WkUIUCDq6tdDhQ7aR9zUNdO5VOjyfHmebj6JwnfZIBbmQFBZ7md/5ZlTg
         FdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LK+EBRynEXsucfX04gFvi+gNnB4EOZ/bB2WzuaaMYIc=;
        b=WtYiz3Espr2p80CGg8xFwiWsruY4VVU69Bv2bqquBMmrmkkCwsnuD5llY1YRrK3VbH
         QVQgqkVp+gEjmxVz+xUtiEu2ksSBNh/WWRrGlSdPF/D1l4AEUcXtqT2vb5xWv2IU1C/w
         OGKTkJTYXtgnZGxJNLiwhLbC1nj3+FQTjYV5Uzye49gl59DTCiTcAPg+6ILbqYOYVhoT
         DSQqBho7B7p3xQ86sIJzrwfJZLHZ5oHuaiieisbgP4YEPPQdXAYLM0PqS3nQRbpXbDBP
         Wr7IzryKymfOasKmR4s4DzZ0O/LA3Mb3AMPtALAjPk4vAV00rJDe8BaS9sNRfZRZteAl
         1xcg==
X-Gm-Message-State: AOAM533L2ClRWnUaRCF20QlX3ibBsXhuM9vxwZcU1GUCMyGTIGiI1zfm
        xq5dFGBmd5feMgdhGU67J3tO+hW5nyqhXm23f0A=
X-Google-Smtp-Source: ABdhPJzn9lxSCriqI2ToiXXIRoLSzrjmr41xe5HIRNGl0I0vjbYHXb13MWkUw/9ODphxfJt2wWrtcsLV1Vf1u8OuiVg=
X-Received: by 2002:a25:21c5:: with SMTP id h188mr36451509ybh.468.1594156612336;
 Tue, 07 Jul 2020 14:16:52 -0700 (PDT)
Date:   Tue,  7 Jul 2020 14:16:41 -0700
Message-Id: <20200707211642.1106946-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH] bitfield.h: don't compile-time validate _val in FIELD_FIT
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     Jakub Kicinski <kuba@kernel.org>, stable@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Alex Elder <elder@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

When ur_load_imm_any() is inlined into jeq_imm(), it's possible for the
compiler to deduce a case where _val can only have the value of -1 at
compile time. Specifically,

/* struct bpf_insn: _s32 imm */
u64 imm = insn->imm; /* sign extend */
if (imm >> 32) { /* non-zero only if insn->imm is negative */
  /* inlined from ur_load_imm_any */
  u32 __imm = imm >> 32; /* therefore, always 0xffffffff */
  if (__builtin_constant_p(__imm) && __imm > 255)
    compiletime_assert_XXX()

This can result in tripping a BUILD_BUG_ON() in __BF_FIELD_CHECK() that
checks that a given value is representable in one byte (interpreted as
unsigned).

FIELD_FIT() should return true or false at runtime for whether a value
can fit for not. Don't break the build over a value that's too large for
the mask. We'd prefer to keep the inlining and compiler optimizations
though we know this case will always return false.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/kernel-hardening/CAK7LNASvb0UDJ0U5wkYYRzTAdnEs64HjXpEUL7d=V0CXiAXcNw@mail.gmail.com/
Reported-by: Masahiro Yamada <masahiroy@kernel.org>
Debugged-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/bitfield.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 48ea093ff04c..4e035aca6f7e 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -77,7 +77,7 @@
  */
 #define FIELD_FIT(_mask, _val)						\
 	({								\
-		__BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_FIT: ");	\
+		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_FIT: ");	\
 		!((((typeof(_mask))_val) << __bf_shf(_mask)) & ~(_mask)); \
 	})
 
-- 
2.27.0.383.g050319c2ae-goog

