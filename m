Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F726A889B
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 19:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjCBSjY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 13:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCBSjX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 13:39:23 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED5C10A84;
        Thu,  2 Mar 2023 10:39:23 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id r5so284210qtp.4;
        Thu, 02 Mar 2023 10:39:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677782362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9Tp7zR6q1GyOD5xTyxBxaVoqQfeB4d9SNa5DQ/cXfo=;
        b=1rDOgWFFX9XIIYIJIF9BRP/O94wmWU1xfXMk1gj6gSl/Q8BWDaTclfnGc5r8wozaOk
         rZQPTu+fMeDs39SrljuadTEzZAaiKlQS6aH5WOET+619Y7IPmerofIbCcvb6SEdSrDUW
         frAVCi4UHT6/aHZdNNrAjyKlmisgYq4rkutYHoHxDWTH9WInEKOF2z+r1IIDsS6a/onS
         HiqZ6A7y9N/yVpDgGw+a6aR1EyQMiF7YP33eMUdwsCLT2TaFEfJr3bAN/GXY9UI4wfH+
         kB3ArPeZ4uRG3uyGyhkgWqqgVyL+YhYbDN9o9Bm9Zh4u7KKyMJp210sLkh49ha/01CbX
         rusw==
X-Gm-Message-State: AO0yUKU0o2V5EuxSv7S5d+d0fNZXBlK5ipzurFGuhLgKGMhl6pZhyxo6
        uuKgcDBG1nsryjo3Elv5NlpF/yxm5mnx3h6U
X-Google-Smtp-Source: AK7set8n4cJm54ba3dZ8nvQpYXj5CGYFDI1IP+skV4sKxo4OhqLVy4ffD/6lUlZKoHqoPPh0XQYeiQ==
X-Received: by 2002:ac8:5c88:0:b0:3b8:293c:24eb with SMTP id r8-20020ac85c88000000b003b8293c24ebmr5250856qta.30.1677782361831;
        Thu, 02 Mar 2023 10:39:21 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:5434])
        by smtp.gmail.com with ESMTPSA id l18-20020ac84592000000b003b9b48cdbe8sm172206qtn.58.2023.03.02.10.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 10:39:21 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 2/2] bpf, docs: Fix final bpf docs build failure
Date:   Thu,  2 Mar 2023 12:39:18 -0600
Message-Id: <20230302183918.54190-2-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230302183918.54190-1-void@manifault.com>
References: <20230302183918.54190-1-void@manifault.com>
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

maps.rst in the BPF documentation links to the
/userspace-api/ebpf/syscall document
(Documentation/userspace-api/ebpf/syscall.rst). For some reason, if you
try to reference the document with :doc:, the docs build emits the
following warning:

./Documentation/bpf/maps.rst:13: WARNING: \
    unknown document: '/userspace-api/ebpf/syscall'

It appears that other places in the docs tree also don't support using
:doc:. Elsewhere in the BPF documentation, we just reference the kernel
docs page directly. Let's do that here to clean up the last remaining
noise in the docs build.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/maps.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/maps.rst b/Documentation/bpf/maps.rst
index 4906ff0f8382..6f069f3d6f4b 100644
--- a/Documentation/bpf/maps.rst
+++ b/Documentation/bpf/maps.rst
@@ -11,9 +11,9 @@ maps are accessed from BPF programs via BPF helpers which are documented in the
 `man-pages`_ for `bpf-helpers(7)`_.
 
 BPF maps are accessed from user space via the ``bpf`` syscall, which provides
-commands to create maps, lookup elements, update elements and delete
-elements. More details of the BPF syscall are available in
-:doc:`/userspace-api/ebpf/syscall` and in the `man-pages`_ for `bpf(2)`_.
+commands to create maps, lookup elements, update elements and delete elements.
+More details of the BPF syscall are available in `ebpf-syscall`_ and in the
+`man-pages`_ for `bpf(2)`_.
 
 Map Types
 =========
@@ -79,3 +79,4 @@ Find and delete element by key in a given map using ``attr->map_fd``,
 .. _man-pages: https://www.kernel.org/doc/man-pages/
 .. _bpf(2): https://man7.org/linux/man-pages/man2/bpf.2.html
 .. _bpf-helpers(7): https://man7.org/linux/man-pages/man7/bpf-helpers.7.html
+.. _ebpf-syscall: https://docs.kernel.org/userspace-api/ebpf/syscall.html
-- 
2.39.0

