Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E2D240CE5
	for <lists+bpf@lfdr.de>; Mon, 10 Aug 2020 20:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgHJSV0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Aug 2020 14:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgHJSVY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Aug 2020 14:21:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E72CC06178A
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 11:21:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i62so13722315ybc.15
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 11:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2vXzz9RZaTLHmklPgeZMZ7n+eXaXAJl2SzN+35Zb3vY=;
        b=Xc3Mu/6Iaucr66ZiIbk5IiFY/YxYzRde0HoOqvoidqKKocQZcmyMNmHCUD1yGmMEHv
         0i+rKIt8gIXiN+GnbFrGOXdGmqRJ4EU/G5Um9yCIx0xBi1LMsThGy/KDS7ZoeREN4w2W
         2+NejrEwtMLxzu8CUtDmP3kK7KMXYF8aqTFJFjx4asUQSwWsoryPQVtk8lP3bMabFSVY
         s//DEUkbRWUVZjkzLtOvvfWZbz9H9FyWtL8ol114FD1gJtb4hiSUUYtLv7COxHMQc+mX
         y8RXSck/OQbIjVlobdxOml68XXLlNO423sWlcMOpcf6UrHnnrZ0LnI9St6JB5Ja/TMG4
         7a4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2vXzz9RZaTLHmklPgeZMZ7n+eXaXAJl2SzN+35Zb3vY=;
        b=O+kAng8nNEXJPtpD4htUvVw9I61Fm5KA3JdHDN+qB4v68PNhO2EhFYXbgnDLiNmDM4
         poDs3eeZrnFLccCB9G88MjV+v8FhBIbuckI16nWJiFuH6dC+7ikDhkcrfXCEYoKnp4OF
         6yR89rCSw7h84uXsTfQbCk+qWLErzx2W+0iL0k+DOtYT2OWZ0vkzaLIQYim/jLeozMep
         Oxxy/faQ7P3VV6bh7UZu2BLnPgUK1VsNiJ8R0qAEfMtbyKZMzRGbJC4sHrMb37yoK7/A
         u3oi9THdFlHVWhZ9MDMyWWcHfqtj9TFIGC1A7o+4DgzyZW5KcIw+2CcRUXIKIc0UQdG6
         5H9g==
X-Gm-Message-State: AOAM533i2reE+ShZGRsZS1fFd8H/7fS9v5TPOyC0B/HxuB8BPQzUa+pF
        CZR6FhYIcHbFrSqcTVrFDy/K22FQCVAOuoDiF94=
X-Google-Smtp-Source: ABdhPJxSruMwwAUl3EcPl4M3H+GVaFfbBao26VCJwXIrm/O/ZLItnCovpcssixNNvTuPahlTJbao0/kgLAD9nNECAS0=
X-Received: by 2002:a5b:b45:: with SMTP id b5mr41549839ybr.294.1597083682134;
 Mon, 10 Aug 2020 11:21:22 -0700 (PDT)
Date:   Mon, 10 Aug 2020 11:21:11 -0700
Message-Id: <20200810182112.2221964-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v2 net] bitfield.h: don't compile-time validate _val in FIELD_FIT
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     David Miller <davem@davemloft.net>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Jakub Kicinski <kuba@kernel.org>, stable@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
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
Fixes: 1697599ee301a ("bitfield.h: add FIELD_FIT() helper")
Link: https://lore.kernel.org/kernel-hardening/CAK7LNASvb0UDJ0U5wkYYRzTAdnEs64HjXpEUL7d=V0CXiAXcNw@mail.gmail.com/
Reported-by: Masahiro Yamada <masahiroy@kernel.org>
Debugged-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V1->V2:
* add Fixes tag.

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
2.28.0.236.gb10cc79966-goog

