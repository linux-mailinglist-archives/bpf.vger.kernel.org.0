Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FF5550BF1
	for <lists+bpf@lfdr.de>; Sun, 19 Jun 2022 17:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiFSPuw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Jun 2022 11:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbiFSPuw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Jun 2022 11:50:52 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D57CBCA7
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 08:50:51 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso8160508pjk.0
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 08:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fG2YxPMk3XHSDo57as/MEaodXX0vf3EFBzxExOHzp94=;
        b=XkgPPFKVR0Jb570fcBCjFqP4oTrs6/NzA9SwpN40QvOkpRrkdVm4xtW+wtc1OeLYnQ
         7n5ljaFkzV62y5SctU2XLyM5Ncv2PvQXvXlTPFHLGngn5hRYSNnk/hAML04kw5vaftoC
         kicAFGjW8BsQmffGKtlas6ScJlQuTDHwrwdPMjdRMG4+MbIEI/+4yBkDRHeRmPwSA9pr
         ZFBtd8SEVoAv/qVyE5F76lxq6R1Jd47JM6IooznrhE3yduAUu+K8GZYPIRZc5jleBog6
         Z2XpWHdYxSbHdu+VIYBfO0TJAdtxROQ77z4rPcz4rXDjpZ0kS+mzu8bj5jSq4/PuEIPu
         a4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fG2YxPMk3XHSDo57as/MEaodXX0vf3EFBzxExOHzp94=;
        b=Vn73e/Nl2HlJ8DrII18NZBrEjFiSWpdg2N8S0Mbqkz5vWpJ1bh9h2cNnmzuJcWZmVo
         5epoFSt0gXCVdD7gdo8Sxrkjjcnlsslx9t2SvuXZ+QhFPtqaF1GSWVU8r3EAZHC1bEWt
         y7P0N1eUKLaihaqbdjR8tCC24u9klTYkDxpPp3W6jgproiwOyytVGaOruIIAuzt2NtFm
         QdSLy+iyuwCo3BW++XTWRyJ0Z8n5w2Inp9EJnhLPYSqoVEzAu9t3LMu13DBXaG4HcR3j
         fmx6nbdGsujirfHcZ4yfTdqJs+B/4r/P82gyzAlaG+fyh2HXRqyLEIb+HdLRp+DGjoor
         apsA==
X-Gm-Message-State: AJIora/Gn7AUTa3R62lL5gM6jHp63mbIlH9UcIqZIsPpdMtbK5ANfPmh
        rAtuqdwpnpEbTUgeu0jRnd0=
X-Google-Smtp-Source: AGRyM1vxAU7OTmDElw6CQ4IfMkyUasemfaxdeD46XcwgZFgN1qsd8XEuFJv7/HuK+g+5Vt/uKY9xag==
X-Received: by 2002:a17:90b:4d11:b0:1e8:436b:a9cc with SMTP id mw17-20020a17090b4d1100b001e8436ba9ccmr33074721pjb.40.1655653850770;
        Sun, 19 Jun 2022 08:50:50 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:2b24:5400:4ff:fe09:b144])
        by smtp.gmail.com with ESMTPSA id z10-20020a1709027e8a00b001690a7df347sm6381761pla.96.2022.06.19.08.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 08:50:49 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        songmuchun@bytedance.com, akpm@linux-foundation.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 04/10] mm, memcg: Make obj_cgroup_{charge, uncharge}_pages public
Date:   Sun, 19 Jun 2022 15:50:26 +0000
Message-Id: <20220619155032.32515-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220619155032.32515-1-laoar.shao@gmail.com>
References: <20220619155032.32515-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make these two helpers public for later use.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/memcontrol.h |  4 ++++
 mm/memcontrol.c            | 11 ++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 402b42670bcd..ec4637687d6a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1709,6 +1709,10 @@ struct obj_cgroup *get_obj_cgroup_from_page(struct page *page);
 
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size);
 void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
+int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
+			    unsigned int nr_pages);
+void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
+			       unsigned int nr_pages);
 
 extern struct static_key_false memcg_kmem_enabled_key;
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 350a7849dac3..0ba321afba3b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -260,9 +260,6 @@ bool mem_cgroup_kmem_disabled(void)
 	return cgroup_memory_nokmem;
 }
 
-static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
-				      unsigned int nr_pages);
-
 static void obj_cgroup_release(struct percpu_ref *ref)
 {
 	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
@@ -2991,8 +2988,8 @@ static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
  * @objcg: object cgroup to uncharge
  * @nr_pages: number of pages to uncharge
  */
-static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
-				      unsigned int nr_pages)
+void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
+				unsigned int nr_pages)
 {
 	struct mem_cgroup *memcg;
 
@@ -3012,8 +3009,8 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
  *
  * Returns 0 on success, an error code on failure.
  */
-static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
-				   unsigned int nr_pages)
+int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
+			    unsigned int nr_pages)
 {
 	struct mem_cgroup *memcg;
 	int ret;
-- 
2.17.1

