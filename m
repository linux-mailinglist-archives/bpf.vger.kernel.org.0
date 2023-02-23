Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFDB6A0096
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 02:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjBWB3S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 20:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjBWB3R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 20:29:17 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654103866F;
        Wed, 22 Feb 2023 17:29:16 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id bh1so11074931plb.11;
        Wed, 22 Feb 2023 17:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Hig2Jmdl36rvUgg9VdhClX8PuuvijVWOMFe5/3goxHA=;
        b=CEfFoeeBeUHuyEvu9jEedox2IDbdYrR/T0dya6a6j6kCN3bCb+bWXJmltjvG82x2iB
         tkM6H279HdRBKQ0wxc6ji7DDzR+OL2vAWk5KGc0n3XfqJI/fDSCt99ZRXSiJPN8rRRFv
         63E5zzcrfTn+0Z9ucEkO2nZ0jsqbtUa95+T8pOkI30PfHIuFmwNY8KCF0MAHg7YXfZYm
         s5XsLNuLKlH/eXXSuQkcNTKBXVmABC5rWZCfxf/zorfLM/FSj4hm1DIIgRY7yoDhWYBN
         tbn+XtQOTrKFt+1OyEKdXLLiCUuZJEX/PtLO0tFb2ETKhMDDfpnGBqGsfjVmFqf6E+yq
         usZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hig2Jmdl36rvUgg9VdhClX8PuuvijVWOMFe5/3goxHA=;
        b=bd8MHgOjIfh1Tw3g0C/PuFZxlimCdmRNC/WXKODm2ZqfvCKWnLM4D7usy6T/9/savg
         YWScWr4VaSQcLj4sP0UNAr88RUkBRS4fVdOkQD0TSPzeFGtZuehQknPLDpSj75VQ/s3F
         NL7oT9XnCTImJGLacDsYpCTcoIOC9oA4XmRbWn0YaSTa2CMQNoRvuUNmNNvDrCjSatM7
         BcAMSXFmLeF7kFznealUOi8gibweErAQbOnno62Q83ksQdx4yPoGNpWfHt1vk1tgKfZM
         8IqQbidzXnT6N3p6vx/FEdho/HBcEMKTe1HKwUGIFfWrtqp4nh0/KDsrPgKV/Pw23kl4
         eLYQ==
X-Gm-Message-State: AO0yUKWNJNdZGP+E9wKke4YXtNHTaLh7IedwSwQ136AzH6o0nVH1+Rd5
        kuduoWgh+AVKq5Wl8aE1GTuBWvVxu5A=
X-Google-Smtp-Source: AK7set+xfzBKyJiP7uZmep0JBjcBkjIJm10pNfPvNC9ZKmeIP/37wEB7GKSgkiDZ5eVhrOPFIyPaJg==
X-Received: by 2002:a17:903:707:b0:19c:b7a9:d4a4 with SMTP id kk7-20020a170903070700b0019cb7a9d4a4mr1656452plb.37.1677115755603;
        Wed, 22 Feb 2023 17:29:15 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:1bf3])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902c10200b00189743ed3b6sm1984627pli.64.2023.02.22.17.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 17:29:14 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 22 Feb 2023 15:29:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH v2 1/2 bpf-next] bpf: Add bpf_cgroup_from_id() kfunc
Message-ID: <Y/bBaG96t0/gQl9/@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

cgroup ID is an userspace-visible 64bit value uniquely identifying a given
cgroup. As the IDs are used widely, it's useful to be able to look up the
matching cgroups. Add bpf_cgroup_from_id().

v2: Separate out selftest into its own patch as suggested by Alexei.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 Documentation/bpf/kfuncs.rst | 10 +++++++---
 kernel/bpf/helpers.c         | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index ca96ef3f6896..226313747be5 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -583,13 +583,17 @@ You may also acquire a reference to a ``struct cgroup`` kptr that's already
 
 ----
 
-Another kfunc available for interacting with ``struct cgroup *`` objects is
-bpf_cgroup_ancestor(). This allows callers to access the ancestor of a cgroup,
-and return it as a cgroup kptr.
+Other kfuncs available for interacting with ``struct cgroup *`` objects are
+bpf_cgroup_ancestor() and bpf_cgroup_from_id(), allowing callers to access
+the ancestor of a cgroup and find a cgroup by its ID, respectively. Both
+return a cgroup kptr.
 
 .. kernel-doc:: kernel/bpf/helpers.c
    :identifiers: bpf_cgroup_ancestor
 
+.. kernel-doc:: kernel/bpf/helpers.c
+   :identifiers: bpf_cgroup_from_id
+
 Eventually, BPF should be updated to allow this to happen with a normal memory
 load in the program itself. This is currently not possible without more work in
 the verifier. bpf_cgroup_ancestor() can be used as follows:
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 5b278a38ae58..a784be6f8bac 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2101,6 +2101,23 @@ __bpf_kfunc struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level)
 	cgroup_get(ancestor);
 	return ancestor;
 }
+
+/**
+ * bpf_cgroup_from_id - Find a cgroup from its ID. A cgroup returned by this
+ * kfunc which is not subsequently stored in a map, must be released by calling
+ * bpf_cgroup_release().
+ * @cgrp: The cgroup for which we're performing a lookup.
+ * @level: The level of ancestor to look up.
+ */
+__bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 cgid)
+{
+	struct cgroup *cgrp;
+
+	cgrp = cgroup_get_from_id(cgid);
+	if (IS_ERR(cgrp))
+		return NULL;
+	return cgrp;
+}
 #endif /* CONFIG_CGROUPS */
 
 /**
@@ -2167,6 +2184,7 @@ BTF_ID_FLAGS(func, bpf_cgroup_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_cgroup_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_SET8_END(generic_btf_ids)
-- 
2.39.2

