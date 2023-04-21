Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EA76EAF2A
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 18:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjDUQbh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 12:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjDUQbe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 12:31:34 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E38413F89
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:31:30 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-94a34a14a54so315269066b.1
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682094688; x=1684686688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nCvZ81MQ8C4KsN+w+vU2lanYJxjKn5TCB3KHbYXOxs=;
        b=hGLjT8S+vZ5GPA6gYuxCtOtR7BNDlqTHhcYCPlEOy/us7PpKAfL+SaoR7vrE+OwCd+
         lyOAu8kQ8Fxb+u47hvJRi3k5mstrjIb7RIRAcB1VbaW6jXyTB8umC10rSiscoYEF6yJb
         PVcuS+BN7iyMVFMiDQ83Z1ghRiAx05/t7Y3UkZQvVJUmWNCGheA7AjjdmTOlNb18qgk4
         8Gz/nBBszbBs2q4ZMX0f1B0azCmt4nSWtgW28LglMYXW0ggA5e6ZWCzeHWdigsos6bgv
         fKAE7SpE/188xijsJw9rrPcKOscIqlHmMi4iwUzp7OvA5jwFJn/mC9wjdcVBLMBfr4qs
         HdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682094688; x=1684686688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nCvZ81MQ8C4KsN+w+vU2lanYJxjKn5TCB3KHbYXOxs=;
        b=LKL1dkB7BqYuwHrNZuEnAZXrHivX4MZgAuzykWoOPa0CP23hWgWd/5lSEb999tpR6G
         EfaU3L44Og86hNPjBt6i4j67ccDc7htvfaY1lmjRBCrNN496LePJFVSrIgU+7zAz2VXU
         rdpzQ7iTyBjwcVNpND5p7RQ/eJyEqbCR+/kke2xjmlRw6yG/RxVjsILsXoOwRjZo2u86
         fBOGV3Thtud3JYmPbVHCpOLMXW9h+gtwfe+HNR/5oCNg6vo7OZK2MKkEC0TRRAamckRH
         KNUSvzXbT2qYIUxWKMeqmdoREEb2y5a3FmYf3RUrgonsWMiZqgHqBrSUSvKV9c1An6ox
         q3yw==
X-Gm-Message-State: AAQBX9eWw/HQQdtERqazZLh9V0rvJc9qmqjAlyqEboNyEStyWeW/fJ7Z
        vDUIlReIrIqmy8OxqBvkJ/PzgVIWQZS69w==
X-Google-Smtp-Source: AKy350b5akmogJd5oeOIQG3nEfYO7+jOgPblNBW7QbeJW8g13ktrLZIGQbajw8w+qd8Ge0BpDDvifg==
X-Received: by 2002:a17:907:1c86:b0:94f:81c:725e with SMTP id nb6-20020a1709071c8600b0094f081c725emr3830871ejc.59.1682094688425;
        Fri, 21 Apr 2023 09:31:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id k9-20020a170906970900b009534211cc97sm2248578ejx.159.2023.04.21.09.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 09:31:28 -0700 (PDT)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>, martin.lau@linux.dev,
        kernel-team@meta.com
Subject: [PATCH bpf-next v3 10/10] documentation/bpf: Document cgroup unix socket address hooks
Date:   Fri, 21 Apr 2023 18:27:18 +0200
Message-Id: <20230421162718.440230-11-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
References: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
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

Update the documentation to mention the new cgroup unix sockaddr
hooks.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 Documentation/bpf/libbpf/program_types.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/bpf/libbpf/program_types.rst
index ad4d4d5eecb0..06168ad73d5e 100644
--- a/Documentation/bpf/libbpf/program_types.rst
+++ b/Documentation/bpf/libbpf/program_types.rst
@@ -56,6 +56,18 @@ described in more detail in the footnotes.
 |                                           | ``BPF_CGROUP_UDP6_RECVMSG``            | ``cgroup/recvmsg6``              |           |
 +                                           +----------------------------------------+----------------------------------+-----------+
 |                                           | ``BPF_CGROUP_UDP6_SENDMSG``            | ``cgroup/sendmsg6``              |           |
+|                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UNIX_BIND``               | ``cgroup/bindun``                |           |
+|                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UNIX_CONNECT``            | ``cgroup/connectun``             |           |
+|                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UNIX_SENDMSG``            | ``cgroup/sendmsgun``             |           |
+|                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UNIX_RECVMSG``            | ``cgroup/recvmsgun``             |           |
+|                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UNIX_GETPEERNAME``        | ``cgroup/getpeernameun``         |           |
+|                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UNIX_GETSOCKNAME``        | ``cgroup/getsocknameun``         |           |
 +-------------------------------------------+----------------------------------------+----------------------------------+-----------+
 | ``BPF_PROG_TYPE_CGROUP_SOCK``             | ``BPF_CGROUP_INET4_POST_BIND``         | ``cgroup/post_bind4``            |           |
 +                                           +----------------------------------------+----------------------------------+-----------+
-- 
2.40.0

