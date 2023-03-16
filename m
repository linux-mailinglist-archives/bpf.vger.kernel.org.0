Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A226BC5C3
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 06:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjCPFkl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 01:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCPFkk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 01:40:40 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530965CC1A;
        Wed, 15 Mar 2023 22:40:39 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id c19so610265qtn.13;
        Wed, 15 Mar 2023 22:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678945238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+xUrg9q1AAptwCu8YnIT5AXN2cGpwLJEELj3y+obxs=;
        b=Ec5zskyA+CcxxKTcQLOE4iemb6Ht/F4YGEjYmARn3IJU9zMTopdvLtEQOFRc+dkxCM
         iVUw3qJimroFMgDMUJeswElwKP0HIcXQ3DXHKlGpD6IlpYAyv8VrMuDJKbHHQ+Hc9XFV
         Tcs69aCIaDSPQ7vuM6e2c0ewBJDZWp/f0CMk3ZvtPU85LeiVnPa4rD8ZCRGl8stTdkQa
         Pi6o3s0ZPOvOdoX396/WCIDa0QFnE9pneGmXcQH/ZpV/30i6O05VueCVDMNbga09pjuH
         jo5/n1c6d1/ZjsnhUqdE6gYmRT9tXBD3MRehJoStgyvz0oaSutOYafK4nl8XoTLAgUqt
         P8MA==
X-Gm-Message-State: AO0yUKU5qcyhjm06mOYTHYHxVFpYXsiJRjS6wXmP9K+GC+8oO7lYdL/v
        i1Nqs7QlL0nd+ZV2zeiI0mV/dYLN9+U97wYd
X-Google-Smtp-Source: AK7set96ow2rNLkxVUlOBvSS6JIA2gPxQ4/d5kIAjCx/ebg6wH9zyfZtvFK7EwugjOQzJWYW8JPdOw==
X-Received: by 2002:a05:622a:1049:b0:3d4:f850:2e9 with SMTP id f9-20020a05622a104900b003d4f85002e9mr4349342qte.31.1678945237984;
        Wed, 15 Mar 2023 22:40:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:7f57])
        by smtp.gmail.com with ESMTPSA id d63-20020a37b442000000b0073b575f3603sm5153630qkf.101.2023.03.15.22.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 22:40:37 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/5] bpf: Mark struct bpf_cpumask as rcu protected
Date:   Thu, 16 Mar 2023 00:40:25 -0500
Message-Id: <20230316054028.88924-3-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230316054028.88924-1-void@manifault.com>
References: <20230316054028.88924-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

struct bpf_cpumask is a BPF-wrapper around the struct cpumask type which
can be instantiated by a BPF program, and then queried as a cpumask in
similar fashion to normal kernel code. The previous patch in this series
makes the type fully RCU safe, so the type can be included in the
rcu_protected_type BTF ID list.

A subsequent patch will remove bpf_cpumask_kptr_get(), as it's no longer
useful now that we can just treat the type as RCU safe by default and do
our own if check.

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

