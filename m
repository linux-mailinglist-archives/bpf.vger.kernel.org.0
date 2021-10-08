Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D08D426F5B
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 19:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhJHRJu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 13:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhJHRJt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 13:09:49 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF3BC061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 10:07:54 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 75so3706114pga.3
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 10:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0KKMd4mfqEABEjdlkv7c/2AhPWgUvaW2Bxx/ArezSmA=;
        b=jMSlWj0bbdKsQQeO20UXCmVln0Ikd3CD0LE/k0VUB7iP0V4FntaLLxldgWdfoOUuSU
         RMRmzXKnwiKDzntaLNoipnaz2H1DnuQLiOBFPwEAZzFmxLUnEFL781SYsgwHKMO0/zWH
         O1smN8hk2OQTUUTZW8F94uNno+EMdZq0dkwhdXCzvHIrz2Qlf6FswxwX5XQEdS+jpGZ9
         WhVhcL8MQK9/QU83AFGebMUMJhVMhmYizRCi+Hqjyrop7a7hoHG9BbNHtRHencwdJMO1
         gXJ5k/GixtwjsLachHTub1f8UiXGLKohyy6rn+zvyHb7XWDmr6ZbU9YWneAlevtUNg17
         WuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0KKMd4mfqEABEjdlkv7c/2AhPWgUvaW2Bxx/ArezSmA=;
        b=K4MiZ4NSEinCcgySYkLOlCPC6AYChKSBrMnq9dXN7L7oibViyUSCb2yogfX/eUCJlT
         gPsd885iTk803koeWyFLAYYIQbTaEcyVCo6ebE6w0DtVTJ0j9gbxwz2jwafuWYNpJ0e9
         w2g3HG77WvDXMRVEAhEQ7ZemHxoHmphdfED7GNxUDNUw+kLZPo3j3mDDrlf9QqEVQHUC
         KlUW6GvfX+JOPOwhHaeI3SMG6SwY7Uk6adhY0mbHsrqsC6y7otFyJ73QOIxDyzkeYLgm
         kKNjUr9CD5NIbn4HiTFRQde6BxKoCBCROEU4vpRh34jlSchwMc+9QBseWyTbRUhdznJW
         AoHg==
X-Gm-Message-State: AOAM532B840oHaqtmbO/+KE0hNFlxZfY40z3xJOJslSqshrIA+XjAnY9
        SS8l5aBGdRjGWFwuLHm7NqtesyESrkQ=
X-Google-Smtp-Source: ABdhPJwLTmfYVJpCjwXTIUm9xnsNc+XLI4zqe7TTOFbntReAwKy9WzBgfRpdBDlM4OMbEa1/L+xtoA==
X-Received: by 2002:a63:7e48:: with SMTP id o8mr5674121pgn.157.1633712873740;
        Fri, 08 Oct 2021 10:07:53 -0700 (PDT)
Received: from localhost ([2405:201:6014:d058:a28d:3909:6ed5:29e7])
        by smtp.gmail.com with ESMTPSA id j20sm3368272pgb.2.2021.10.08.10.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 10:07:53 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next] bpf: Silence Coverity warning for find_kfunc_desc_btf
Date:   Fri,  8 Oct 2021 22:37:51 +0530
Message-Id: <20211008170751.690570-1-memxor@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The helper function returns a pointer that in the failure case encodes
an error in the struct btf pointer. The current code lead to Coverity
warning about the use of the invalid pointer:

 *** CID 1507963:  Memory - illegal accesses  (USE_AFTER_FREE)
 /kernel/bpf/verifier.c: 1788 in find_kfunc_desc_btf()
 1782                          return ERR_PTR(-EINVAL);
 1783                  }
 1784
 1785                  kfunc_btf = __find_kfunc_desc_btf(env, offset, btf_modp);
 1786                  if (IS_ERR_OR_NULL(kfunc_btf)) {
 1787                          verbose(env, "cannot find module BTF for func_id %u\n", func_id);
 >>>      CID 1507963:  Memory - illegal accesses  (USE_AFTER_FREE)
 >>>      Using freed pointer "kfunc_btf".
 1788                          return kfunc_btf ?: ERR_PTR(-ENOENT);
 1789                  }
 1790                  return kfunc_btf;
 1791          }
 1792          return btf_vmlinux ?: ERR_PTR(-ENOENT);
 1793     }

Daniel suggested the use of ERR_CAST so that the intended use is clear
to Coverity, but on closer look it seems that we never return NULL from
the helper, hence it can just be switched to checking for IS_ERR and
returning the pointer, similar to the cases elsewhere in the kernel.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 20900a1bac12..2551b6be8d42 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1783,10 +1783,8 @@ static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env,
 		}

 		kfunc_btf = __find_kfunc_desc_btf(env, offset, btf_modp);
-		if (IS_ERR_OR_NULL(kfunc_btf)) {
+		if (IS_ERR(kfunc_btf))
 			verbose(env, "cannot find module BTF for func_id %u\n", func_id);
-			return kfunc_btf ?: ERR_PTR(-ENOENT);
-		}
 		return kfunc_btf;
 	}
 	return btf_vmlinux ?: ERR_PTR(-ENOENT);
--
2.33.0

