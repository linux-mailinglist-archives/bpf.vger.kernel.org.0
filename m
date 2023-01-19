Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90396747B6
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 00:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjASX7a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 18:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjASX7K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 18:59:10 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0519A19A5;
        Thu, 19 Jan 2023 15:58:50 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id h21so2950801qta.12;
        Thu, 19 Jan 2023 15:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szLEwMFPNAUcOlQXjDN9W13GrrQRzdrtWVVmponsE0I=;
        b=q/8Ih5SCaQiK1jOyVcsTKmN+LECWCjD5PKTd77CN/Bn7mNVkJ9LZ1LsR1GC5zxh6cw
         j7/xSXFxgGXGnoIqn3a8vZJYxmRX7XbEF2jrU4LDL2bX8H0A14skyfP4++b7ag8yYLep
         trNELfY2LGDZtMJ/WMnHlc4QvKF3ENyP8vNaFC27hExbPIG8pAfB62EenMQNk0ZRCgJ8
         FPpBYUKOolSD8thMtBUK2FJe4n6qh2eCvfVLssuNNVGR7fdXaYdsJhlMtJmvVSbHKE7q
         urrSITsG7evVYOaRgBMffLbELvFEzVTLHkSraB6zTH8O9EtY8jFKr7EIFOeo4c5pbBlb
         hxqw==
X-Gm-Message-State: AFqh2kpGkC91LvGl/Azi11lSkzhCFalViMv56MsPmS7BPxiF93xojX0T
        Ij+VsemiEdku/SWfuctJIleJs1t8eZjSAW4w
X-Google-Smtp-Source: AMrXdXvnBgc4KVjMHd9s/aniTnOzGpT2T7WHJBt+fTwuAprlvhuMDB+sDQkLh701+bdVOXCwNF1N9A==
X-Received: by 2002:ac8:6659:0:b0:3b6:2c74:b67f with SMTP id j25-20020ac86659000000b003b62c74b67fmr15249856qtp.13.1674172729271;
        Thu, 19 Jan 2023 15:58:49 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id hj4-20020a05622a620400b003995f6513b9sm19363039qtb.95.2023.01.19.15.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:58:48 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next 8/8] bpf/docs: Document how nested trusted fields may be defined
Date:   Thu, 19 Jan 2023 17:58:33 -0600
Message-Id: <20230119235833.2948341-9-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119235833.2948341-1-void@manifault.com>
References: <20230119235833.2948341-1-void@manifault.com>
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

A prior change defined a new BTF_TYPE_SAFE_NESTED macro in the verifier
which allows developers to specify when a pointee field in a struct type
should inherit its parent pointer's trusted status. This patch updates
the kfuncs documentation to specify this macro and how it can be used.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/kfuncs.rst | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index a74f9e74087b..560f4ede3a9f 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -167,7 +167,8 @@ KF_ACQUIRE and KF_RET_NULL flags.
 The KF_TRUSTED_ARGS flag is used for kfuncs taking pointer arguments. It
 indicates that the all pointer arguments are valid, and that all pointers to
 BTF objects have been passed in their unmodified form (that is, at a zero
-offset, and without having been obtained from walking another pointer).
+offset, and without having been obtained from walking another pointer, with one
+exception described below).
 
 There are two types of pointers to kernel objects which are considered "valid":
 
@@ -180,6 +181,25 @@ KF_TRUSTED_ARGS kfuncs, and may have a non-zero offset.
 The definition of "valid" pointers is subject to change at any time, and has
 absolutely no ABI stability guarantees.
 
+As mentioned above, a nested pointer obtained from walking a trusted pointer is
+no longer trusted, with one exception. If a struct type has a field that is
+guaranteed to be valid as long as its parent pointer is trusted, the
+``BTF_TYPE_SAFE_NESTED`` macro can be used to express that to the verifier as
+follows:
+
+.. code-block:: c
+
+	BTF_TYPE_SAFE_NESTED(struct task_struct) {
+		const cpumask_t *cpus_ptr;
+	};
+
+In other words, you must:
+
+1. Wrap the trusted pointer type in the ``BTF_TYPE_SAFE_NESTED`` macro.
+
+2. Specify the type and name of the trusted nested field. This field must match
+   the field in the original type definition exactly.
+
 2.4.6 KF_SLEEPABLE flag
 -----------------------
 
-- 
2.39.0

