Return-Path: <bpf+bounces-11526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 226F97BB299
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 09:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C904D28275E
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 07:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838C1125B3;
	Fri,  6 Oct 2023 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="er8LMOAp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765F4E57C;
	Fri,  6 Oct 2023 07:45:59 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6E3F0;
	Fri,  6 Oct 2023 00:45:57 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bff776fe0bso23117851fa.0;
        Fri, 06 Oct 2023 00:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696578355; x=1697183155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IuQAasmwLodP6MR9msfs02386+4ZzrUnvc4SbKOh5k=;
        b=er8LMOApltxKPc6B5oGhkw2CqzTxmKWn6rubbEWdRDWB+yBFrfg3F+gWqoWZ5hcs0C
         +4sDS7lKFMCKp4tLsyAE2KjgsAGhF/RYJBvf7+orQfXS14j3YiWJyiosGpvQaP89okwR
         IkLoDX9vm1CqFv3G8yh+lPDa43J9fPi+1OCvYA49UW3W0QDy0vR1REaawyzS5ohozIxx
         J1PDqxDt9wj1V24Wmkx+axR6dU3Hh08uXKOZKBVJKE8jAmFI+SZV8o7gejeJg8xOv0tb
         /muIOrJZ0995HWHLienu/dR8kuDOzNU0uvTF7ThoItT+KBpxlvR+F0PvGSMPKfKA5KGm
         px9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696578355; x=1697183155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IuQAasmwLodP6MR9msfs02386+4ZzrUnvc4SbKOh5k=;
        b=p8BU9HBgNJbYvYTpeNVgfgBui44Ah8EqyfuVIDOGpi90k7E1CjtSErvLLgE+znB6gU
         PHS1kY1hbP6EERmyAyRpBrgyVqEBRHXpqcXTLskJ4D6DiNu4IUqri+W6up460fcQZuwu
         sahg1dwR7o88+kZl3++bIq2pHy9jlHXr5nytr5qh6IX3shyu71fdM6IfwDFBs5uJXjii
         qG2TKnpct2gzpY46wVqHMaiQ9d9hZT7OsjQmnKYQHikvCn0mQp8Rp6Xk4WhEDx/UA/u1
         MlzWqLzeFltvvAmq5w4tre/7FnMZqG7bID2OF7zxi6zIl3R50MkfWhV5X+KJ/OuDTRBS
         BWiA==
X-Gm-Message-State: AOJu0YwIxUs1bbdneqYuv9KasB2Z6YY0yDyXhBnnIivzRqAlgyg88Pur
	i/ZZx2MSXJNRHzW78pQNm0726Ab4AlfGHDbM
X-Google-Smtp-Source: AGHT+IFDKDozHSkiL5NvKLKE69cnB93rHcBpzilDcYnJD/qVUOKdX5fLY+AZGTzowwTM9KIK0mI6zg==
X-Received: by 2002:a05:6512:ac5:b0:503:2eaf:1659 with SMTP id n5-20020a0565120ac500b005032eaf1659mr8678047lfu.41.1696578355016;
        Fri, 06 Oct 2023 00:45:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id k22-20020a7bc416000000b00404719b05b5sm3126888wmi.27.2023.10.06.00.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 00:45:54 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v9 7/9] documentation/bpf: Document cgroup unix socket address hooks
Date: Fri,  6 Oct 2023 09:45:01 +0200
Message-ID: <20231006074530.892825-8-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006074530.892825-1-daan.j.demeyer@gmail.com>
References: <20231006074530.892825-1-daan.j.demeyer@gmail.com>
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


