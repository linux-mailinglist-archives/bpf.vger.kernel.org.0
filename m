Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D660E6BC365
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 02:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCPBla (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 21:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjCPBl3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 21:41:29 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E58AAB080;
        Wed, 15 Mar 2023 18:41:28 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id m6so360888qvq.0;
        Wed, 15 Mar 2023 18:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678930887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Mw+fd0bH4Z7LLAT9myck2MFtZEkV/SC3orkjhIOzHc=;
        b=tJPoVaVle+g1LVzEL/kjV0dMc3kcdagkVf1HUpdHYyEBwAbNUAFbjWg6myvthWvDu2
         XhZegT5DCt5+iPl90BPS1WGMN6d4ojRNQwXtyOIQMna1eiwJUUnP644/1uYqOJSIZqmm
         139e65Hmttnnx5vTLBnLJ2oiLt07bxYOIFnsYueqm0ZXOWxUKIzHSIlxnEuKbj5aV1ra
         FWV5RqIw1TdjWxFMcjZ6Sj1xDX2C6flhS42MEWIvoGwbNWip7J3Ovxtdbs6OdTgyMAc9
         BoFxHC8M0jtMol9zgBLwpjb2TJVYX5VULvIfeIX6cOH/0wO0tz3+uJEu12YTTncKBLXP
         fp8A==
X-Gm-Message-State: AO0yUKWWK2IzQ9NcwBiQWZ/O8YP9j5eBMy3RCYcpyb4cuBsIHQg5qQWe
        PJ6o39h5qI9Zz07uaeIcgPkVBj1s1CjGglhi
X-Google-Smtp-Source: AK7set/XCqdLdWn8xpHO5xeWXcmHd9LKzqEhHK/z8EVv8MlHNq4f3Ub0T7lLXFU5cCMwh0vOt8/Kug==
X-Received: by 2002:a05:6214:238e:b0:572:5a16:51c0 with SMTP id fw14-20020a056214238e00b005725a1651c0mr28574433qvb.16.1678930887158;
        Wed, 15 Mar 2023 18:41:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:5c58])
        by smtp.gmail.com with ESMTPSA id u19-20020a37ab13000000b00725d8d6983asm3390746qke.61.2023.03.15.18.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 18:41:26 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 2/5] bpf: Mark struct bpf_cpumask as RCU protected
Date:   Wed, 15 Mar 2023 20:41:19 -0500
Message-Id: <20230316014122.678082-3-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230316014122.678082-1-void@manifault.com>
References: <20230316014122.678082-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

struct bpf_cpumask is a BPF-wrapper around the struct cpumask type which
can be instantiated by a BPF program, and then queried as a cpumask in
similar fashion to normal kernel code. The previous patch in this series
makes the type fully RCU safe, allowing the type can be included in the
rcu_protected_type BTF ID list.

A subsequent patch will remove bpf_cpumask_kptr_get(), as it's no longer
useful now that the verifier allows us to use bpf_rcu_read_{un}lock() to
get an RCU-safe pointer.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 60793f793ca6..15b5c5c729f9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4599,6 +4599,7 @@ static bool in_rcu_cs(struct bpf_verifier_env *env)
 BTF_SET_START(rcu_protected_types)
 BTF_ID(struct, prog_test_ref_kfunc)
 BTF_ID(struct, cgroup)
+BTF_ID(struct, bpf_cpumask)
 BTF_SET_END(rcu_protected_types)
 
 static bool rcu_protected_object(const struct btf *btf, u32 btf_id)
-- 
2.39.0

