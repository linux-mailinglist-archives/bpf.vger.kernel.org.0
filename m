Return-Path: <bpf+bounces-3132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18B4739DC6
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 11:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A2D1C210AF
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 09:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E685689;
	Thu, 22 Jun 2023 09:53:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74DF3AA8C
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 09:53:14 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E262100
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 02:53:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-988689a5f44so557276066b.1
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 02:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687427586; x=1690019586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EhQ9CqocU+8B1FTKuVrFOom9z3TwFt0c6zonqMwkBp8=;
        b=KlZ+K4WlalqLiF1Kl21CaecrmdwMWgZpWH4b5O8pu5Yyn6Amfd92gkjAjLf2TFrk8E
         6KRShC75HVzEXmAdVwkAO2u+6lhw2DLBGrbGPMWi2MVrkO7g7dvYwvqnziPqc8kJryOi
         /qdV35bHyIxvfU2EIJXlEB+UXLM4QCr2xfQX0qjPqg+f0C+gtM/3Pv++glC/bgPQn5Ud
         Iv8nDA5Bf9UE88W+jtAso7bUPpu5yb7C6zHwFTAHs3Kx90AFZ949OjQXaD8vG9IlkDWN
         lkuMM8uLd1opAPzGQ5S1kxpO2AI7gWDUOChylUK//r9E3b10TXEhVhxwpibY6bXtc+Sd
         SQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687427586; x=1690019586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EhQ9CqocU+8B1FTKuVrFOom9z3TwFt0c6zonqMwkBp8=;
        b=IumW62M/R7fp2X9zDm3NUzG1lbOAELdwaLygX2XN62V5DoZ9sICnkma5qVSx17/Djk
         lBJXuJPzpKTof357fYor5f4Fd2gbT0Ith6FV77EbaAdUuLGBf3ESYj+lCnTZG6kp1cvP
         0aRkHxxGWeSon6rhxhV6k9BtN0B+xx8QI9Etf93mCpZI2e4jict2JKcEbbPzn6I4Y6F0
         UdbOz/JS6KGYr/6efj63pMqOx/oRDV0dVBM/VwaqWOph4RBtBDENECHIiyKrnFTUFxfN
         53JZQSZpGm7a1ho3AWfHHXWOzfg5sQ0CRy1ylDoVjXjfEa0ecYgl6pjzrAb/pmrJdFyy
         MuHg==
X-Gm-Message-State: AC+VfDwiDsfcxe5v7wL+9hQZQhCZ+7HbG6d5x2oGLaGwoNA/+cQEu4Ui
	LH5eLe12vE5SNCgVBgdENqL1XhDh05rleVkLUe+vXja3
X-Google-Smtp-Source: ACHHUZ7KTpwGSMB9y8NSNZp1VjzesnVul+cQSbXtEA0bRQ5afQrLa1IZTCgFfUQ0UPJswLbiccnXTg==
X-Received: by 2002:a17:906:9b88:b0:988:91cb:afd1 with SMTP id dd8-20020a1709069b8800b0098891cbafd1mr11983840ejc.29.1687427586575;
        Thu, 22 Jun 2023 02:53:06 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id x12-20020a1709060a4c00b009737b8d47b6sm4360805ejf.203.2023.06.22.02.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 02:53:06 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Vernet <void@manifault.com>,
	Sreevani Sreejith <psreep@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next] bpf, docs: BPF Iterator Document
Date: Thu, 22 Jun 2023 09:54:07 +0000
Message-Id: <20230622095407.1024053-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix the description of the seq_info field of the bpf_iter_reg structure which
was wrong due to an accidental copy/paste of the previous field's description.

Fixes: 8972e18a439d ("bpf, docs: BPF Iterator Document")
Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 Documentation/bpf/bpf_iterators.rst | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/bpf/bpf_iterators.rst b/Documentation/bpf/bpf_iterators.rst
index 6d7770793fab..07433915aa41 100644
--- a/Documentation/bpf/bpf_iterators.rst
+++ b/Documentation/bpf/bpf_iterators.rst
@@ -238,11 +238,8 @@ The following is the breakdown for each field in struct ``bpf_iter_reg``.
        that the kernel function cond_resched() is called to avoid other kernel
        subsystem (e.g., rcu) misbehaving.
    * - seq_info
-     - Specifies certain action requests in the kernel BPF iterator
-       infrastructure. Currently, only BPF_ITER_RESCHED is supported. This means
-       that the kernel function cond_resched() is called to avoid other kernel
-       subsystem (e.g., rcu) misbehaving.
-
+     - Specifies the set of seq operations for the BPF iterator and helpers to
+       initialize/free the private data for the corresponding ``seq_file``.
 
 `Click here
 <https://lore.kernel.org/bpf/20210212183107.50963-2-songliubraving@fb.com/>`_
-- 
2.34.1


