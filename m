Return-Path: <bpf+bounces-11953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D3F7C5D07
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 20:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B20282849
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 18:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5282B12E69;
	Wed, 11 Oct 2023 18:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGkpi/65"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BA49CA43;
	Wed, 11 Oct 2023 18:51:35 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0464893;
	Wed, 11 Oct 2023 11:51:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3215f19a13aso138755f8f.3;
        Wed, 11 Oct 2023 11:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697050292; x=1697655092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IuQAasmwLodP6MR9msfs02386+4ZzrUnvc4SbKOh5k=;
        b=YGkpi/65MIT1+z5C+0Knq/LVJIyKHUjpn8ND8haMeI9ucrFzMUH66+t1JFjxg3EWzp
         mM4W8+/qr/0G06T6ZLLSi1Uw55tY6R45WB1mcUielVqaok19J2qi2pKCxiT3cvAvMXQU
         EY6BLxyW+iYfTlnIPUAl1+JJd/oQe5C1PJoZ/nM+rkfXv+qOcOzwlTDgyn93fcLV5z+A
         eZuWS9wZ2M9qN13AsRxlTPFX46sLF2AupFDyEuB6fs70HDMArBr8c2oZyJivX17GeNLl
         rUr8s8+hcviqN9lcsXUlq6TVE45GkbRbQyyE7g4Gfby+RXius8z9uNOuB+B49A+nn+oV
         bL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050292; x=1697655092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IuQAasmwLodP6MR9msfs02386+4ZzrUnvc4SbKOh5k=;
        b=CfZ0C1ZwafKXaRQwKI++8crNJYuvPu9y0eB1QAqpcnlQzw2AdikhKlFklkdHM3C3TQ
         TAmIskMvACqFiEg9/PuFVbwgExUwu4wqIr1XfShdNn4ptBfsYiwjKXtKTuqUnlUv/4KQ
         bzdLorAyAzvMR6rgbDiaufsa6N02Zh2WOH65x9iTYRPmm5HvnwCv5YQRucvesn4+ajm0
         +5L7wgzkZune2+j/uN2FAS9lfIWGlLUltNYseFfaxPm87EM6NqmLB5YPs+Nuyf1FJdFf
         Lw7NKzXo9sWqY2F8zV7P5wJR64kRYE0bW8MNru7CStnd9/obIBGIYnaX5ISQ7bs/TeQt
         Mgfg==
X-Gm-Message-State: AOJu0Yytqh8xwyILnHJ5SxIuGfp1V6NBelNqMn5cU9BIwjR7LSdPX/Ml
	IBfxmcder6gvSHSYLXT9DqfB+AfBH8kFDyah
X-Google-Smtp-Source: AGHT+IGxPqDTWAWTTi0NvBzuQtRTO2ttEOoMgJ+ztKWPwrOzH/QuW07r6rHY71LNpSgO4rbqo+sCEw==
X-Received: by 2002:a05:6000:1141:b0:32d:8450:1f21 with SMTP id d1-20020a056000114100b0032d84501f21mr2219704wrx.0.1697050291860;
        Wed, 11 Oct 2023 11:51:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id h9-20020a5d6889000000b0031c52e81490sm16424484wru.72.2023.10.11.11.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 11:51:31 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v11 7/9] documentation/bpf: Document cgroup unix socket address hooks
Date: Wed, 11 Oct 2023 20:51:09 +0200
Message-ID: <20231011185113.140426-8-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011185113.140426-1-daan.j.demeyer@gmail.com>
References: <20231011185113.140426-1-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Update the documentation to mention the new cgroup unix sockaddr
hooks.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 Documentation/bpf/libbpf/program_types.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/bpf/libbpf/program_types.rst
index ad4d4d5eecb0..63bb88846e50 100644
--- a/Documentation/bpf/libbpf/program_types.rst
+++ b/Documentation/bpf/libbpf/program_types.rst
@@ -56,6 +56,16 @@ described in more detail in the footnotes.
 |                                           | ``BPF_CGROUP_UDP6_RECVMSG``            | ``cgroup/recvmsg6``              |           |
 +                                           +----------------------------------------+----------------------------------+-----------+
 |                                           | ``BPF_CGROUP_UDP6_SENDMSG``            | ``cgroup/sendmsg6``              |           |
+|                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UNIX_CONNECT``            | ``cgroup/connect_unix``          |           |
+|                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UNIX_SENDMSG``            | ``cgroup/sendmsg_unix``          |           |
+|                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UNIX_RECVMSG``            | ``cgroup/recvmsg_unix``          |           |
+|                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UNIX_GETPEERNAME``        | ``cgroup/getpeername_unix``      |           |
+|                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UNIX_GETSOCKNAME``        | ``cgroup/getsockname_unix``      |           |
 +-------------------------------------------+----------------------------------------+----------------------------------+-----------+
 | ``BPF_PROG_TYPE_CGROUP_SOCK``             | ``BPF_CGROUP_INET4_POST_BIND``         | ``cgroup/post_bind4``            |           |
 +                                           +----------------------------------------+----------------------------------+-----------+
-- 
2.41.0


