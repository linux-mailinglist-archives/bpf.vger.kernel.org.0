Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9E44273BC
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 00:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243651AbhJHW3b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 18:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243627AbhJHW3a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 18:29:30 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34085C061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 15:27:35 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k23so8659800pji.0
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 15:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gOCDWv+OpTK30qPaMp1sNZIWQM80bg8X8ZPM9I5Xe9w=;
        b=jT490KAhKXbUVzq/4orppLnonnQVcc+s9BC15ZuKfIU2TZcwJAJ3EJi6136pwrkD6U
         ITZi19UY/gva9Mi0etaJG95v+auWVeE0YOzs4sQbcAOap5BlIGNa0YJTSvE6vQkVTQbU
         f8pADzheCeQ82A9Y9skkxDGPeonHuJyrU6AFRuewR0wO3Kn2lDtdF7kAWeayQ+rpfZpQ
         q9uFSkQ8Uvaxd2o10LFr01jl1dNL8LX8x9zj4SMoNBVsVO7/Qo9tDxx1jrZNYb2I+RlQ
         SmdacPrk1wMPTYztSfQ+TReO1PS/daf1MHMSLFX/Q/j2WHp/gVOB7MTMo8Wi9jhs8ofW
         QwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gOCDWv+OpTK30qPaMp1sNZIWQM80bg8X8ZPM9I5Xe9w=;
        b=r4AaEzceoKpbk9q38Vo4x1nHbVDa6Epn00CFRWzy1p5nK3wAvLin2qUGeaL+u/tcv7
         DwBiiWulQm/ftgMCJ8mJJL116wXfZdSe6fXGUBJ3oAy9uwXqavkp5tgYUpgoWvdF9TFV
         5B+9MhGskIMA69HvyJqo/VlpVrpy8YGiB+Y1NmXF2fnS8Jbko1Zv/wyc3Itl+WAQNY5t
         4WT2UeiGQHFkQOFcyiv+jt0kpC83NLf3tw4kpkg2oHPaMZRIm1NCLECEJ2SiS6Pbi2X0
         ForLna/PP9GRh5ZpjukW++3lYNSML5e+XdgmymbmqHbV+KVbfBW8qDt4CCY//055QuWM
         n6JQ==
X-Gm-Message-State: AOAM530dRRnYMLZnX7DAI6Nzh1NliX0YHIRk82JT5u+ViwHXidsZNwNt
        HMWZCGwrM5+dWL/bxT24tlwr9kIZuVo=
X-Google-Smtp-Source: ABdhPJy6kNNZmMizM6ZKfyFHPhxGwgKnbshVJEjammKYZwH2UX9VvZOVKVrOORdePaAnElgAO9kRgQ==
X-Received: by 2002:a17:90a:1942:: with SMTP id 2mr15048170pjh.195.1633732054451;
        Fri, 08 Oct 2021 15:27:34 -0700 (PDT)
Received: from localhost ([2405:201:6014:d058:a28d:3909:6ed5:29e7])
        by smtp.gmail.com with ESMTPSA id r2sm329230pgn.8.2021.10.08.15.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 15:27:34 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v2] bpf: Silence Coverity warning for find_kfunc_desc_btf
Date:   Sat,  9 Oct 2021 03:57:31 +0530
Message-Id: <20211008222731.789446-1-memxor@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CAEf4BzYpp+VqqL4n1N7-Uw8sySVgvaCagEcVicgumtpK-y68aw@mail.gmail.com>
References: <CAEf4BzYpp+VqqL4n1N7-Uw8sySVgvaCagEcVicgumtpK-y68aw@mail.gmail.com>
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
the helper. Andrii noted that since __find_kfunc_desc_btf already logs
errors for all cases except btf_get_by_fd, it is much easier to add
logging for that and remove the IS_ERR check altogether, returning
directly from it.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
v1->v2
 * Remove error check, log btf_get_by_fd failure (Andrii)
---
 kernel/bpf/verifier.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 20900a1bac12..7180f0bc347e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1727,8 +1727,10 @@ static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
 			return ERR_PTR(-EFAULT);

 		btf = btf_get_by_fd(btf_fd);
-		if (IS_ERR(btf))
+		if (IS_ERR(btf)) {
+			verbose(env, "invalid module BTF fd specified\n");
 			return btf;
+		}

 		if (!btf_is_module(btf)) {
 			verbose(env, "BTF fd for kfunc is not a module BTF\n");
@@ -1782,12 +1784,7 @@ static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env,
 			return ERR_PTR(-EINVAL);
 		}

-		kfunc_btf = __find_kfunc_desc_btf(env, offset, btf_modp);
-		if (IS_ERR_OR_NULL(kfunc_btf)) {
-			verbose(env, "cannot find module BTF for func_id %u\n", func_id);
-			return kfunc_btf ?: ERR_PTR(-ENOENT);
-		}
-		return kfunc_btf;
+		return __find_kfunc_desc_btf(env, offset, btf_modp);
 	}
 	return btf_vmlinux ?: ERR_PTR(-ENOENT);
 }
--
2.33.0

