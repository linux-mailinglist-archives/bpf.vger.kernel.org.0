Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371A667B4EB
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 15:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbjAYOkI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 09:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbjAYOkD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 09:40:03 -0500
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AA9BB80;
        Wed, 25 Jan 2023 06:39:34 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id i185so19960175vsc.6;
        Wed, 25 Jan 2023 06:39:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovlVrIKnsLO1876JlAbege0XF/0rg73ghXA+lp23XMs=;
        b=z1mNs0HB2mIHtxs0MMHIKaQz5CXxDthfCzijQEpiiXjdrBTuCmka0jV/HpMgWbPWDo
         a6pEveyG/croMndhXo9AGYGrgzJ63mdDG1K5a3fiaiYBw3UdNZm/jTDVVj+bjMDcFlLm
         G8rcnFa+l/Ac2BCu/L0C+++suC2WvkjuyiUrEmTkU+RK3+2GSBBpqRvRj0o2g8LjCamB
         vZtFMZbLIVkxBA9B4pWNWTzYstLhun0CMmpsnt0A/A3/kzviaM8k+4h9YVmLksjubElc
         K2R9lDuS1cxKVpaay/9Gw8UCZCgsWadTXT8I52evlcmI2PzU1XDACy0DEcUgvZCic0s3
         5itw==
X-Gm-Message-State: AO0yUKXQPdt67Y8XHBLuJDwE1RBwgnPcYl0Lt5oHPAAHdK2cY1Giww04
        pznNzx6OruPrtn3aybQO4OG3LmexOsXx/SyZ
X-Google-Smtp-Source: AK7set8fBdVAwZYkcqKQD1riYykYr0Hmqghc8Kq87/pWyM5jgvuiC2pSk2y7pH8vy6WG3VwmSPPnmA==
X-Received: by 2002:a05:6102:161f:b0:3e8:9a3c:f2fa with SMTP id cu31-20020a056102161f00b003e89a3cf2famr2082416vsb.4.1674657509185;
        Wed, 25 Jan 2023 06:38:29 -0800 (PST)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id os37-20020a05620a812500b0070650f5ee2fsm3572473qkn.65.2023.01.25.06.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 06:38:28 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH bpf-next v3 7/7] bpf/docs: Document the nocast aliasing behavior of ___init
Date:   Wed, 25 Jan 2023 08:38:16 -0600
Message-Id: <20230125143816.721952-8-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125143816.721952-1-void@manifault.com>
References: <20230125143816.721952-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
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
index 560f4ede3a9f..1a683225d080 100644
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
+BTF_IDs differ.
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

