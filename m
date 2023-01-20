Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A809675DFD
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 20:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjATT0K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 14:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjATTZ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 14:25:59 -0500
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B975BD0DBE;
        Fri, 20 Jan 2023 11:25:43 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id 3so6741273vsq.7;
        Fri, 20 Jan 2023 11:25:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLylySo7R4JgpjOoJpqrUNeBZBhnsHbN5la5mr6nrKw=;
        b=547YWvQyIZjWDnN20070w6V8NkO9Z8SCnG5nu2I3gZJfE7gaA58BHDPeJnQDD/9YFp
         j7IPEikK5BZIdhIJvvBhYnQmIQQkPZK/5r0b3lcT2eR+7D6cpLbmcnpZQNbrRwH+FnOA
         wgfSbEq9I0wxoMK8VqAmzq9o2AauRcSUGwCbEVeNE4/T0Avvwf6lI1Ox1knMhg4JYQ50
         Z/huQBC5ygD2DWGiajgyV3ulRacdUV3hqVdYUypqPapCK9Lcw8hjK6aDmtVhJW9J3zTS
         0sniC5CZzXKj6qnUssEIxj9lRkoADpdrs6j2b/8rjNfC+EeEKh/hIbZZjJYZAxlbrCNd
         jQng==
X-Gm-Message-State: AFqh2krQhvDCid7utKHVZ8nob8CwaM3qISra1XZpuMLxRK1u7Ut1uzKs
        5MOcbZ1/8Jg2H/nOVkeI4LCWOQZRRA01dhOS
X-Google-Smtp-Source: AMrXdXuwO+ofhyPaP4QErp+cuZTfEInC148AOXlO3DcMuyS/22ilzZnKGRfmDh2AXKqD/XOoZO0W3Q==
X-Received: by 2002:a05:6102:1517:b0:3d3:c855:bf54 with SMTP id f23-20020a056102151700b003d3c855bf54mr11263598vsv.34.1674242742092;
        Fri, 20 Jan 2023 11:25:42 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id q15-20020a05620a038f00b00704a2a40cf2sm1419246qkm.38.2023.01.20.11.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:25:41 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH bpf-next v2 9/9] bpf/docs: Document the nocast aliasing behavior of ___init
Date:   Fri, 20 Jan 2023 13:25:23 -0600
Message-Id: <20230120192523.3650503-10-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120192523.3650503-1-void@manifault.com>
References: <20230120192523.3650503-1-void@manifault.com>
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

When comparing BTF IDs for pointers being passed to kfunc arguments, the
verifier will allow pointer types that are equivalent according to the C
standard. For example, for:

struct bpf_cpumask {
	cpumask_t cpumask;
	refcount_t usage;
};

The verifier will allow a struct bpf_cpumask * to be passed to a kfunc
that takes a const struct cpumask * (cpumask_t is a typedef of struct
cpumask). The exception to this rule is if a type is suffixed with
___init, such as:

struct nf_conn___init {
	struct nf_conn ct;
};

The verifier will _not_ allow a struct nf_conn___init * to be passed to
a kfunc that expects a struct nf_conn *. This patch documents this
behavior in the kfuncs documentation page.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/kfuncs.rst | 43 ++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 560f4ede3a9f..7bdce4955a1b 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -247,6 +247,49 @@ type. An example is shown below::
         }
         late_initcall(init_subsystem);
 
+2.6  Specifying no-cast aliases with ___init
+--------------------------------------------
+
+The verifier will always enforce that the BTF type of a pointer passed to a
+kfunc by a BPF program, matches the type of pointer specified in the kfunc
+definition. The verifier, does, however, allow types that are equivalent
+according to the C standard to be passed to the same kfunc arg, even if their
+BTF_IDs differ .
+
+For example, for the following type definition:
+
+.. code-block:: c
+
+	struct bpf_cpumask {
+		cpumask_t cpumask;
+		refcount_t usage;
+	};
+
+The verifier would allow a ``struct bpf_cpumask *`` to be passed to a kfunc
+taking a ``cpumask_t *`` (which is a typedef of ``struct cpumask *``). For
+instance, both ``struct cpumask *`` and ``struct bpf_cpmuask *`` can be passed
+to bpf_cpumask_test_cpu().
+
+In some cases, this type-aliasing behavior is not desired. ``struct
+nf_conn___init`` is one such example:
+
+.. code-block:: c
+
+	struct nf_conn___init {
+		struct nf_conn ct;
+	};
+
+The C standard would consider these types to be equivalent, but it would not
+always be safe to pass either type to a trusted kfunc. ``struct
+nf_conn___init`` represents an allocated ``struct nf_conn`` object that has
+*not yet been initialized*, so it would therefore be unsafe to pass a ``struct
+nf_conn___init *`` to a kfunc that's expecting a fully initialized ``struct
+nf_conn *`` (e.g. ``bpf_ct_change_timeout()``).
+
+In order to accommodate such requirements, the verifier will enforce strict
+PTR_TO_BTF_ID type matching if two types have the exact same name, with one
+being suffixed with ``___init``.
+
 3. Core kfuncs
 ==============
 
-- 
2.39.0

