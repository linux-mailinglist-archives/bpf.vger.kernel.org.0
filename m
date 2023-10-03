Return-Path: <bpf+bounces-11259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB5E7B6586
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 11:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 761B5281841
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 09:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA015DF72;
	Tue,  3 Oct 2023 09:30:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47665DF65;
	Tue,  3 Oct 2023 09:30:48 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECE8B7;
	Tue,  3 Oct 2023 02:30:46 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so1122071a12.0;
        Tue, 03 Oct 2023 02:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696325445; x=1696930245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IuQAasmwLodP6MR9msfs02386+4ZzrUnvc4SbKOh5k=;
        b=Zx1YVlWeGsb3vg5r3POyYydAIQyTNGYYIKPcWHJR3irv3XHBKn6tyQq63yX0DqHeR7
         GfMJFq6HvfXQ/YDH3qXeFPG1abzXUjyrOnUxCiV4OhgUHnkIoxN7U6vDsw5zv7Pg5kE8
         yEjitWhL+6zyn0pt4WfI+5l9NBba7lgFvAe5b4PxVHRqPck4UEQlkaqONT8sZPs/WsNR
         rnhYLUwkuyBbIzxTk+MKg8dEKtkThzNvfVf7Jjs4FPPN21gJ6ROcbuidROYO/PfSLJCP
         JkOjc0Q6R82Y806Y2v2u0vzCyCX6He/QbA/LdViiwDQmxteUgRrozNO+HTjkcJ/M8oQb
         kewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696325445; x=1696930245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IuQAasmwLodP6MR9msfs02386+4ZzrUnvc4SbKOh5k=;
        b=FygVpz4CxX9dB1K7Dx7iPlsRaAHvehDAk6mbAHWF/YFYyK2qN+xsWUQtixGX4R3L4H
         sBgyzl78+4Z0TPrcA9DXXI6ABtkThj4PGiG7TV3dMDxww4Ow3orvBri9NSQVLz+IG7CF
         IxK8IfmIBwkbNekEQVeu8AahPAs8hQgjhrdeNVWIzF7IVEd2shIcxu5BjUnbEEc2DXwk
         6tKqJDmOzlxdOUdLUoFXg5UmSkLHD9BkQGd8SsW1br/hKA7aQ7gDFZuQePrscl9D06JM
         ckc1Jyxp/x+yuIG7i8YWr27lN419PrrIxNmQ9gcEp8l75xLkJtHOcZlQ5Ek8bvlfwUuF
         Y6Vw==
X-Gm-Message-State: AOJu0YwrXDF4fm0sS3RoDz8YicOfdUJjEDzgXe5PfeSDuHwuI9CqztxB
	zk1ChfQ9GP35BYRRLa1wNWRlXA52I8AzBQCf
X-Google-Smtp-Source: AGHT+IGsmnvdKqiDC3hB8QAj4uDaZzYAmQ7/wmg0DFj6uSKnMwZEAK1mFyYN4DU0fVdAN2uS8pAHpg==
X-Received: by 2002:a17:907:75c9:b0:9a6:2a0:6391 with SMTP id jl9-20020a17090775c900b009a602a06391mr12742515ejc.14.1696325444802;
        Tue, 03 Oct 2023 02:30:44 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com (2001-1c05-3310-3500-15f4-3ba0-176b-cb00.cable.dynamic.v6.ziggo.nl. [2001:1c05:3310:3500:15f4:3ba0:176b:cb00])
        by smtp.googlemail.com with ESMTPSA id g5-20020a170906594500b0098f33157e7dsm749851ejr.82.2023.10.03.02.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 02:30:44 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v7 7/9] documentation/bpf: Document cgroup unix socket address hooks
Date: Tue,  3 Oct 2023 11:30:21 +0200
Message-ID: <20231003093025.475450-8-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003093025.475450-1-daan.j.demeyer@gmail.com>
References: <20231003093025.475450-1-daan.j.demeyer@gmail.com>
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


