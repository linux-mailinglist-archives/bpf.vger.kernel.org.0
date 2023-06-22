Return-Path: <bpf+bounces-3133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E57A6739DCB
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 11:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6F3281907
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 09:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF2E8BFE;
	Thu, 22 Jun 2023 09:53:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79503AABB
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 09:53:26 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510EB2694
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 02:53:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-988c495f35fso525732666b.1
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 02:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687427600; x=1690019600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=31alUebk/ciyOeOfe0Ga+rH2I3KmjnSBY8Zf5b0Gyzc=;
        b=QJeuHmARmrdOa+uEuCmXkQ6bvCQUMljTS9ijUL9P8Kcs0U6h9wEi3mKgOqjQpWeBwp
         rULeP1a1Jg53+ShOpw3RMEu/SJ9zikZiQBjAxnEUkIlRtLlEmEvoyk6KJiI6rFSLTW2G
         tX0mFn5cRHkunIpZWP6U/hJYowwetp8MTa36vlu4exEok4VcTVxY48d0uyV//GycVu3q
         GyoYVljyhmh4nKJKWL7mPdAQIQL3ZAkeagY430qE1iWZ4vkqIovoKxu1XrQG6Vc0BOL/
         V8Jz3AntsbpOLLrSUV7ZCjui0gJmjhH6J62wdjQj2bxXqYThQoM1j/QzXi6eFFXiAzUO
         HJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687427600; x=1690019600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31alUebk/ciyOeOfe0Ga+rH2I3KmjnSBY8Zf5b0Gyzc=;
        b=jTUL9K3F4V5FkeTaylgNdnPD4gwCgb/h0N7fZ8m5sgZbkMopkPnXR6sQJoPRbWibqt
         Gq0bfy0UEKeyDwNkVgfZmunxA2eeugCGxPG4yQW2e23/8J8MVkKC4jSqpKiDe4DduHgi
         wRNxZky6cxUlb9919s9/GydCQOd4uCQd8z4B4dcVp5YPI8jvbyzgTUTd9B0L/RnlHGQg
         zrvuBdWWbvU95i8NzWJ/rZecXttWR48VdrRYgNOSs0bJdGcMPjtYRIfYpHbcPWafQESu
         STeOxvvFg003Q2ir3XqQopk0t+LvjuolfdixqkY1H7DFEhRrQxt5T794Dbayl+9ECmFW
         CzDw==
X-Gm-Message-State: AC+VfDzA50m55yO7fIRvaGmfoInbPGqiv/VCSGOIvdo1dzh2Efj7DtM7
	VwlugvFF6nd5Qb03r/RXw+LIodc1blA0YrkrgZPTUR+C
X-Google-Smtp-Source: ACHHUZ58boCUF8nU9mqADahfTdIZzJGoIdxaJvO19qR7crWs+PYHRjkY1QH7AILYHBRDwc7faaTX2A==
X-Received: by 2002:a17:907:5c8:b0:94f:3980:bf91 with SMTP id wg8-20020a17090705c800b0094f3980bf91mr16725775ejb.19.1687427600660;
        Thu, 22 Jun 2023 02:53:20 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id u17-20020a1709064ad100b0098cd2814a2esm2193557ejt.70.2023.06.22.02.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 02:53:20 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Vernet <void@manifault.com>,
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
Subject: [PATCH bpf-next] bpf, docs: document existing macros instead of deprecated
Date: Thu, 22 Jun 2023 09:54:24 +0000
Message-Id: <20230622095424.1024244-1-aspsk@isovalent.com>
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

The BTF_TYPE_SAFE_NESTED macro was replaced by the BTF_TYPE_SAFE_TRUSTED,
BTF_TYPE_SAFE_RCU, and BTF_TYPE_SAFE_RCU_OR_NULL macros. Fix the docs
correspondingly.

Fixes: 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier.")
Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 Documentation/bpf/kfuncs.rst | 38 ++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 7a3d9de5f315..0d2647fb358d 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -227,23 +227,49 @@ absolutely no ABI stability guarantees.
 
 As mentioned above, a nested pointer obtained from walking a trusted pointer is
 no longer trusted, with one exception. If a struct type has a field that is
-guaranteed to be valid as long as its parent pointer is trusted, the
-``BTF_TYPE_SAFE_NESTED`` macro can be used to express that to the verifier as
-follows:
+guaranteed to be valid (trusted or rcu, as in KF_RCU description below) as long
+as its parent pointer is valid, the following macros can be used to express
+that to the verifier:
+
+* ``BTF_TYPE_SAFE_TRUSTED``
+* ``BTF_TYPE_SAFE_RCU``
+* ``BTF_TYPE_SAFE_RCU_OR_NULL``
+
+For example,
+
+.. code-block:: c
+
+	BTF_TYPE_SAFE_TRUSTED(struct socket) {
+		struct sock *sk;
+	};
+
+or
 
 .. code-block:: c
 
-	BTF_TYPE_SAFE_NESTED(struct task_struct) {
+	BTF_TYPE_SAFE_RCU(struct task_struct) {
 		const cpumask_t *cpus_ptr;
+		struct css_set __rcu *cgroups;
+		struct task_struct __rcu *real_parent;
+		struct task_struct *group_leader;
 	};
 
 In other words, you must:
 
-1. Wrap the trusted pointer type in the ``BTF_TYPE_SAFE_NESTED`` macro.
+1. Wrap the valid pointer type in a ``BTF_TYPE_SAFE_*`` macro.
 
-2. Specify the type and name of the trusted nested field. This field must match
+2. Specify the type and name of the valid nested field. This field must match
    the field in the original type definition exactly.
 
+A new type declared by a ``BTF_TYPE_SAFE_*`` macro also needs to be emitted so
+that it appears in BTF. For example, ``BTF_TYPE_SAFE_TRUSTED(struct socket)``
+is emitted in the ``type_is_trusted()`` function as follows:
+
+.. code-block:: c
+
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct socket));
+
+
 2.4.5 KF_SLEEPABLE flag
 -----------------------
 
-- 
2.34.1


