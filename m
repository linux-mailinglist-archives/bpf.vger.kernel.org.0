Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDCB46B003
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 02:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhLGBwN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 20:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhLGBwM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Dec 2021 20:52:12 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F515C061746
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 17:48:43 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id q16so12188983pgq.10
        for <bpf@vger.kernel.org>; Mon, 06 Dec 2021 17:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TbgWsx6bnviUrWC0SoIxtrCOl08OnDIAMuWBZRCm+aw=;
        b=pgzWi3nRoT/sjMJ/nLnb4ePoPc+bYE06/h6rhi8Okd8IOXaXuwwCPRB0aJdUWhSTE/
         XaW0JnDYUJxFDiIHuRvN4nuiPFVfZbKEvMMVaUVRbWsKPoMNKvLAJowiyywyD0XB1z7d
         2qDei7vyT/v4GO3VwR6FC0EYxcN7ZEpJGRmvqrZBj9EIe2vr9orEDjqVEpfr9tujYFmE
         PQievnPtVwD53nuT8Kr8t9ITfKu6V+FDgtC0BFGHQpbKsALQI5CfS7a50SmTODhSkTHp
         F46TUgHyaT+WV4FMsjhes6hP1zhB4pvKqiLjCL5esomTglbgQ4Dq9CdM41sG1/ixZwCN
         U7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TbgWsx6bnviUrWC0SoIxtrCOl08OnDIAMuWBZRCm+aw=;
        b=lhwP4yb5sEKY+BLqnfZfv5xsiAbJqb4saD1GpMTIRe1SX8mX1FUvH5vZ8uwcN+dmQ+
         7Lc1+1bBZ/QE4WQ8ocDKsnnXCCYVZE33jyg3XZYxTM0XRAbK0PYN0EQrszD2JaRy+jfd
         kDYqQopiSqfkz0pBM80mjfAj9+FeuReq9xnlldqDELGRyc4nCNanBkGu6W6wq3JpGq5X
         iuiUEQJ5hQDtJucCKkzv9fguNGwLMdf315KDB4tvkZP/e63FtTHxWLkLx2GZANRhoWlP
         8c2TMHi3IKyChB4UDUUW0NHCjEPsA7l+Hv26Wj4/GhGnx1+roWJ1T/PYVIq3okQyIHxM
         5APw==
X-Gm-Message-State: AOAM530omBjShvUyp4QaBmeEJII9siivMvaRmSgY+yvZAb6wiLVOUDQh
        OkAuwzOfztqqB/3jYXupq7I=
X-Google-Smtp-Source: ABdhPJzB6+hcTeWmWGbADcDAaMUcdRxSYC0WSxPCnfDic0VwLc2vXqZ8luNnNqFeHL1Z7fZkElhEjA==
X-Received: by 2002:a62:5a02:0:b0:4a2:a6ee:4d8e with SMTP id o2-20020a625a02000000b004a2a6ee4d8emr40136823pfb.47.1638841721554;
        Mon, 06 Dec 2021 17:48:41 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:8d36])
        by smtp.gmail.com with ESMTPSA id on5sm670089pjb.23.2021.12.06.17.48.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Dec 2021 17:48:40 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH bpf-next] bpf: Silence purge_cand_cache build warning.
Date:   Mon,  6 Dec 2021 17:48:39 -0800
Message-Id: <20211207014839.6976-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

When CONFIG_DEBUG_INFO_BTF_MODULES is not set
the following warning can be seen:
kernel/bpf/btf.c:6588:13: warning: 'purge_cand_cache' defined but not used [-Wunused-function]
Fix it.

Fixes: 1e89106da253 ("bpf: Add bpf_core_add_cands() and wire it into bpf_core_apply_relo_insn().")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/btf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 36a5cc0f53c6..01b47d4df3ab 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6560,6 +6560,7 @@ static struct bpf_cand_cache *populate_cand_cache(struct bpf_cand_cache *cands,
 	return new_cands;
 }
 
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 static void __purge_cand_cache(struct btf *btf, struct bpf_cand_cache **cache,
 			       int cache_size)
 {
@@ -6598,6 +6599,7 @@ static void purge_cand_cache(struct btf *btf)
 	__purge_cand_cache(btf, module_cand_cache, MODULE_CAND_CACHE_SIZE);
 	mutex_unlock(&cand_cache_mutex);
 }
+#endif
 
 static struct bpf_cand_cache *
 bpf_core_add_cands(struct bpf_cand_cache *cands, const struct btf *targ_btf,
-- 
2.30.2

