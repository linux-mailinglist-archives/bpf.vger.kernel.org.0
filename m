Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3F823E108
	for <lists+bpf@lfdr.de>; Thu,  6 Aug 2020 20:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbgHFSkA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Aug 2020 14:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgHFS3z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Aug 2020 14:29:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2316EC0617A5
        for <bpf@vger.kernel.org>; Thu,  6 Aug 2020 11:29:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g127so18527439ybf.11
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2020 11:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+IG/dxdpIhFOg5NsrzFXy6SAE8mZFW/9Sk3pQFlLR/4=;
        b=aqhdeEeYxs4pIJ7U2ovDFyNnuGPXWzRfKQ10Xub61whpV9tbm2cil6TFTO/f1I0asV
         Jkm5iEj3REOVhxGYnDQDW9Vyad2O2p91LMVYkD1fdaXSuu2OvPO9WG1VrOWStwcbxXzZ
         AaMCgi88DzldY8DzC5b/E6Xr0eTQvkemByeALsUT2qQW/ovsBZbfkzt0qb0t6wGDSK8q
         zeV8thFiYRKXT51DfC+CnEFhs9Z1fgeEX3Ea+a0ZEJIREVYuNOhIIE4s+d4oHfAL0TLI
         7ppVzqf6bPuxq8Et9E+O1VG9H8UtDwzlOIysJD97bqAaoJhaTLuPtKTLJaTeFyY4k/2J
         2+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+IG/dxdpIhFOg5NsrzFXy6SAE8mZFW/9Sk3pQFlLR/4=;
        b=BFwXPNtFDQwGrz5iOVtAHWPv27bhnWSOQ+yjAQlXfCB5j4usECTxhJGk8N78urkDdd
         88e2I+3W138Y8ha6w5ihpkhvlMHc+vWMRJPYe6owgzTQzJwwsx/P/b7654QPtIDVVBLm
         IuiQCCxOUwrDq2AXKORAnNQKeGPAkLtAZ2SWdkAcj1ZMy6IhasGSK/gy7EdMRXk8lXuc
         kFY14beU4oop3Vdhuq8bR0rx6A6NN4eyAaljROuVllvJzmauqRhFAztLLB7brU1fW3Af
         eTqya234lDwTO8N/VRidbtHVDzHaxM/o3m/xhGclytD8t7cWdXuNFSwwXWEtczQR5swe
         SLpg==
X-Gm-Message-State: AOAM533Ijx7kDjbbaOWnLdHbaINoyx2RP9M2K+DNfTJYuHRURV96p6ro
        +WpDhl6SKjBvkovlzwWFwhre01Bl2C1CgrLrAm8=
X-Google-Smtp-Source: ABdhPJwZABlBX0pahoVpPDOus1FAsJYKYjfJy30hapIE6fqPyT+k2q2xJ16rKioJ7N6yL6pFeQR2DssnVu/ZwHHkgC0=
X-Received: by 2002:a25:f30c:: with SMTP id c12mr15528680ybs.471.1596738591183;
 Thu, 06 Aug 2020 11:29:51 -0700 (PDT)
Date:   Thu,  6 Aug 2020 11:29:39 -0700
Message-Id: <20200806182940.720057-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH net resend] bitfield.h: don't compile-time validate _val in FIELD_FIT
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     David Miller <davem@davemloft.net>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Jakub Kicinski <kuba@kernel.org>, stable@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alex Elder <elder@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
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
Acked-by: Alex Elder <elder@linaro.org>
---
Note: resent patch 1/2 as per Jakub on
https://lore.kernel.org/netdev/20200708230402.1644819-1-ndesaulniers@google.com/

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

