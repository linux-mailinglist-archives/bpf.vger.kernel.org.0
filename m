Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8529767B4F1
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 15:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbjAYOkS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 09:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbjAYOkP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 09:40:15 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40163EFC7;
        Wed, 25 Jan 2023 06:39:49 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id jr19so14821868qtb.7;
        Wed, 25 Jan 2023 06:39:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szLEwMFPNAUcOlQXjDN9W13GrrQRzdrtWVVmponsE0I=;
        b=PB6zy6orVVPREfnzUn1bv3m3NYBC7VCIuDDo7CqTISrVOnfcpRbNZTGoaeqZRUIfoh
         aWCC7oCTeYj6LYLNUitlcBX+ADgPJdWG4FIR+3gGMBTQwnqqeHkyAzrgwA62NsIeakzO
         ZOFCulGW7VuTr3+TpE7T/L2iDblx/fp21dyb8u5i6NLTHlMloxUQ0gfS5teO54Pz5yWI
         lXnixeMSf1FKTKhsWzJvVhJsbCwscAGcPq5vxXJiclzk8Yu8XSl/JBLmYPmqmOBSFg6n
         qbpWEapF8o6XsAIMGFbHZ/CsiliyXDWf1onKytMooKy9RRWiyCgbTtScWOD6WwMSY/ep
         aWjA==
X-Gm-Message-State: AFqh2krVfQBoifLScdd98KpNySOiDRaokcnkaQ6u8xz0C1VOIU9ZAxL/
        gtiFmRWIuvgR22YllMc3lqiRY3MX9xTVkPcN
X-Google-Smtp-Source: AMrXdXuiWHJm8P9vMDHMQY3cN05eJWw7PaAeuGrH2nTjNOvX9g2ZxAwsJHxeTvzrivgFNdlF23Sr9g==
X-Received: by 2002:ac8:4896:0:b0:3a5:24ac:a175 with SMTP id i22-20020ac84896000000b003a524aca175mr49324483qtq.56.1674657507682;
        Wed, 25 Jan 2023 06:38:27 -0800 (PST)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id k8-20020ac80208000000b003b1546ee6absm3370089qtg.11.2023.01.25.06.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 06:38:27 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH bpf-next v3 6/7] bpf/docs: Document how nested trusted fields may be defined
Date:   Wed, 25 Jan 2023 08:38:15 -0600
Message-Id: <20230125143816.721952-7-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125143816.721952-1-void@manifault.com>
References: <20230125143816.721952-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
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

