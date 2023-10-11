Return-Path: <bpf+bounces-11941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 803FF7C59EC
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 19:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096F9282764
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 17:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB6D3992C;
	Wed, 11 Oct 2023 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFdZ2QnY"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4AB2232C;
	Wed, 11 Oct 2023 17:03:43 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C5CC4;
	Wed, 11 Oct 2023 10:03:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-325e9cd483eso19021f8f.2;
        Wed, 11 Oct 2023 10:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697043818; x=1697648618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IuQAasmwLodP6MR9msfs02386+4ZzrUnvc4SbKOh5k=;
        b=lFdZ2QnYjJKHZ/XsmXMmqgi5e2m0dtgbzaRjmBvm29h942IJcQyEBRCpyzkX5jjH3O
         /a0RRHe0iC98usy0OUUIUIULoiCdUcngJwjrxEV8wWSZzWEPjpRNwSM1h+oD9o8FhD5D
         1tMeSzEfcOYZNvBFKO5TpLp75G23TswENGpXIUZDPwUPleivqKV6TtgENnBaIm197eE9
         FwoodJGjOl7BBNZUr3E9ZwUOVplbPtUfmDhi076aqueKqYCbrA2Lt9oJlP76w2TUuz5M
         Ktein694kMIZznkNWUBe8b21gisAL7lpBnWi3Y5x1Gm9sRIljpWVI8WpcIvFUgqbnlgm
         pBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697043818; x=1697648618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IuQAasmwLodP6MR9msfs02386+4ZzrUnvc4SbKOh5k=;
        b=ss+2c/haryVYEp7KgH72Zfwqd1bv+NRgtaN/HCSDoFd0OdNaQf9rSV0UyJYXna9tMJ
         u5+kwvHuGVcaZWkJ5tdYX45RhEP++slRn9A/X0xl8LNhnmiyWkysBnJxsOZoHu92wZ7K
         HrjzpbxwH5nvEOPUHIzTUToGBxLtkRbL0G6+gbqMzv0HBb4ENFDl/vNCbVtQF7teB2gJ
         JXZLYEo6P0CpM7XQ0D8HTZ/xHsbW771ocGLWNQTSrTfXcpg5Mkan9hRQZX++AMyqgoha
         p0LTUafStwSoWZ+BeFhB+GypjQ40DJbZGPz0UfUBdQnDtHvFf7BIDg4AcaQYccVxJ8Jc
         C9gw==
X-Gm-Message-State: AOJu0YzcHG2Z1WQac6VPjjauTYuSm+rW1FhWwBY3Jdo3lAdDG1shRM6K
	FD2OpbYkewvPRhYPIiKuRLJwPl+B/SkqBQ63
X-Google-Smtp-Source: AGHT+IFGWs4hp4P5+nSOjht9KVUlHdoH7CMPtvBYo/Oatp4UPIK5hzYV5sNtE61ZUPJ/Ydj4w9WANQ==
X-Received: by 2002:a05:6000:4e1:b0:31f:fdd8:7d56 with SMTP id cr1-20020a05600004e100b0031ffdd87d56mr18282859wrb.12.1697043817767;
        Wed, 11 Oct 2023 10:03:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id h28-20020adfa4dc000000b003296b913bbesm2335480wrb.12.2023.10.11.10.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:03:37 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v10 7/9] documentation/bpf: Document cgroup unix socket address hooks
Date: Wed, 11 Oct 2023 19:03:17 +0200
Message-ID: <20231011170321.73950-9-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011170321.73950-1-daan.j.demeyer@gmail.com>
References: <20231011170321.73950-1-daan.j.demeyer@gmail.com>
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


