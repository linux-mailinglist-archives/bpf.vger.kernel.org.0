Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C3F427711
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 06:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbhJIELA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Oct 2021 00:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhJIELA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Oct 2021 00:11:00 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65068C061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 21:09:04 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so10699174pjb.5
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 21:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NVj00YbQM9EvLzErOOsNQThY6cyK2Nrn4HsRW530SyA=;
        b=GSwtkz3nQTG41zXsM+A3Ivhe2aFYPvXA8WbhMKIkA5G09F6/BFifH9174J/pJ5OTad
         1v9ru5uwtG9wPQ4AEXLbrzCAMI3nyENUq9NKJQ5CLcMMoLLXLFVDP3FKr/WtAejFIkPY
         KSDI2U8iWwnq+J5xRxeygFRoH7Ei4Xe/qZMl4wAxHLZuzPEd9Eez0AcxQERfYC7jk+O5
         0csYFTwS9wsiu16sTLTqkxtEFbSkdJKkr9oIdpeQyosUE1/Q0glrycSEHjE2Onn3mBG0
         e9rAGmET5IELEhuma4rHd8czJM+kZF+r3o20PO97vNbZZekycaw4l2Ak8Re/9yPjDegS
         QG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NVj00YbQM9EvLzErOOsNQThY6cyK2Nrn4HsRW530SyA=;
        b=42whXtf+t+VVil150aw/Uyw6UGbyN715lOJn81se7AdfqQLwYkRy2GNvmJkcnkmY64
         zOIeeDOjvHodEoQB3NjbBcwFHrtYwfuYFjTQPmBgb9x5Oyeosp7BEE6r5h4DttexGR7b
         VmgGP+qOu7VYfyOxVBX5LsVio58esK+4K8oXa1s4WIuDaq2+uNGLDZLAYZ7S9svCPa+o
         nJC70uDtjsx3/3P801Il7NWvSrQgNsIfoOMsJzRf0RMqQZrRAcACaQt67fTtR3ARvwE6
         qRNlsmx/6Uc1WmKvNSS8ICkAV2c5xOcsVEXuql8lXWrSNEQDjrJLz8srskzGDUEjM2bU
         adLw==
X-Gm-Message-State: AOAM533EtqL4obcpqfI+Ohz6OsCxqv6nsg3xl11Kl49XfTLEVDnxopYA
        Q5FrH7NvkGdSgitxd14M4IoJtqzqVZU=
X-Google-Smtp-Source: ABdhPJzVEmMW4A5shTeTCLa41iI/PJ4v1/xDvHU0cbLNJNRLg99CV8VeK3RiMPkWPXNLfYYAMXW1Pg==
X-Received: by 2002:a17:902:a3c2:b0:13d:be85:43ca with SMTP id q2-20020a170902a3c200b0013dbe8543camr13359137plb.0.1633752543428;
        Fri, 08 Oct 2021 21:09:03 -0700 (PDT)
Received: from localhost ([2405:201:6014:d058:a28d:3909:6ed5:29e7])
        by smtp.gmail.com with ESMTPSA id e20sm730399pfc.11.2021.10.08.21.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 21:09:03 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v3] bpf: Silence Coverity warning for find_kfunc_desc_btf
Date:   Sat,  9 Oct 2021 09:39:00 +0530
Message-Id: <20211009040900.803436-1-memxor@gmail.com>
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
v2->v3
 * Remove unused variable (Kernel Test Robot)
v1->v2
 * Remove error check, log btf_get_by_fd failure (Andrii)
---
 kernel/bpf/verifier.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 20900a1bac12..21cdff35a2f9 100644
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
@@ -1771,8 +1773,6 @@ static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env,
 				       u32 func_id, s16 offset,
 				       struct module **btf_modp)
 {
-	struct btf *kfunc_btf;
-
 	if (offset) {
 		if (offset < 0) {
 			/* In the future, this can be allowed to increase limit
@@ -1782,12 +1782,7 @@ static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env,
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

