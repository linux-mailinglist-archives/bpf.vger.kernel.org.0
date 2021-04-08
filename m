Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9677C358C75
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 20:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbhDHSaK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 14:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbhDHS3k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Apr 2021 14:29:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AD4C0613A6
        for <bpf@vger.kernel.org>; Thu,  8 Apr 2021 11:29:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d1so2833501ybj.15
        for <bpf@vger.kernel.org>; Thu, 08 Apr 2021 11:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A4KMkUZrl4YbLTqlF2GjjNGTYuxFr+/F8S0sGB79SBc=;
        b=rt9fOxKnB9y0igHfYBfQLlswurHVd9akIm8mQ7xCsufNWiBYdR3JhCpYM7Uax/eLvb
         Ihhz4rq6HcyX7REf0u2fqx7LVp4ukkmU+QC5NvoPcxJetx0GLnWLloqncFHy9GmoYMBn
         XjIhO8wNOL3YaZSw+9n6f8hcXwGNa5EVXVYOv+TLwmMSwMQDUKpz6OfnrIlesqFMkgkR
         XwLL5SN+XXLMayXhC5sCImEanWSuJTwkFWqMibje/hh2cGiFwv4rge6/fnMF/5m4/W6v
         2KS84+T3ETJUQYWmacNH46sk/sKcVZ9rguitgtGIPddtwdEI5YDOujUYGBTToDSb8o4O
         GYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A4KMkUZrl4YbLTqlF2GjjNGTYuxFr+/F8S0sGB79SBc=;
        b=bzjIdp6x05MMta1jiASShNg0adLanLviFQrjmBNG4f7x0fRf2wLL+/XXCH6PVwdimE
         Gmgt0nfHhtaC4BVvwLSYQ3NBWWXw3sKFW7LWQUdDolmah8NxDKmB4DpSVaNvKXwj8rDA
         Z/SE0jjMJ/SBNEYCE2Ftx8K3r0qgSTCrJIkWZExPQA6qb6d9KyuOaAwGon8d23Bb8cqB
         XyU9YEaoqbdqAa9m1SQ9PMKEuvwsWGkiecvx9CA3isRgXXx6s1P9U9uW2wNk6GmSv/1a
         QrdcQiwgl1ZX85etObIZHf5AlmH7LmgAn7Hq+2sC/UQIPnQUh9smxqhq8wlr15aA6MQ5
         klTw==
X-Gm-Message-State: AOAM530mmcG6wiojgzY0zamgKn8Rw1288PZbS1H3D7reKKX7IGOFgLPJ
        bzZ7jQpVlR23h8LuNkrz3gsPsxc9QXzMJu+Zh9M=
X-Google-Smtp-Source: ABdhPJy9XDHY4+uyYXn6KtdLMb9MXbOaRaW45MMiG7dZpwvMKLXKIxABytCBmfYEFzzpAYPpLEY0MfZ524rYOheFYP8=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:3560:8505:40a2:e021])
 (user=samitolvanen job=sendgmr) by 2002:a25:ea44:: with SMTP id
 o4mr9706249ybe.506.1617906544646; Thu, 08 Apr 2021 11:29:04 -0700 (PDT)
Date:   Thu,  8 Apr 2021 11:28:35 -0700
In-Reply-To: <20210408182843.1754385-1-samitolvanen@google.com>
Message-Id: <20210408182843.1754385-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210408182843.1754385-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v6 10/18] lkdtm: use function_nocfi
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To ensure we take the actual address of a function in kernel text,
use function_nocfi. Otherwise, with CONFIG_CFI_CLANG, the compiler
replaces the address with a pointer to the CFI jump table, which is
actually in the module when compiled with CONFIG_LKDTM=m.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/misc/lkdtm/usercopy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 109e8d4302c1..15d220ef35a5 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -314,7 +314,7 @@ void lkdtm_USERCOPY_KERNEL(void)
 
 	pr_info("attempting bad copy_to_user from kernel text: %px\n",
 		vm_mmap);
-	if (copy_to_user((void __user *)user_addr, vm_mmap,
+	if (copy_to_user((void __user *)user_addr, function_nocfi(vm_mmap),
 			 unconst + PAGE_SIZE)) {
 		pr_warn("copy_to_user failed, but lacked Oops\n");
 		goto free_user;
-- 
2.31.1.295.g9ea45b61b8-goog

