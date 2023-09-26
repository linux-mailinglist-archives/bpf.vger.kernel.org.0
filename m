Return-Path: <bpf+bounces-10898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C9A7AF521
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 22:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 99F0A282BFF
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 20:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681994B234;
	Tue, 26 Sep 2023 20:28:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3CB4B229;
	Tue, 26 Sep 2023 20:28:18 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8B7194;
	Tue, 26 Sep 2023 13:28:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c3c8adb27so1222056566b.1;
        Tue, 26 Sep 2023 13:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695760095; x=1696364895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mT5GWJnaTH4P1kD5M11l1lYox9NySbmlcUDconn0p3U=;
        b=L5+E7Z3y6d5olOgIzgrsXlMiC4WJWtVp7Yq8sYlNnW+PgF7s5T2uXrQ2tOKctPAAD/
         2xbxH/ye0Xr6TtT34K7lsh4n8cCaMBBxpYnk0qoLs9o9dNspXhU+RY2t+8bQtKwO1p2u
         XmdOQ60KkJWadLOcbpkUb5Pf1YZ9azqfz9nf3MDeHBTvmS/GcGE8zE9MFGyhDDU3rAa4
         yqZJ4g+jZ0ozY+mNYn+0W5rbpXpru691Zd/VAuwwxDQmoyeUqp9Vmq91wSn6Vzm/a2zx
         Gqxsa923Nu0NrRgycHkr1jDxijFgEJweOtCDasq42PGaB9PA5uSFmLJ+4bbGd13QKQcT
         hYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695760095; x=1696364895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mT5GWJnaTH4P1kD5M11l1lYox9NySbmlcUDconn0p3U=;
        b=WLOn1cC+eq9eRRAEDhcN6wjRe89gchwDsczPwNBZLOMMvI/MYuCWzV0EEVI9Dt6CxF
         OtO4r+IYHirTXc8xPQYPL8gPAP+sMG4HcKSg5EJXKO69q/+sljRX9zg8gf4hc6F+e0w5
         C4KyH9HHo5t9AjzLlumlIqY0nPQ6/p2LFRBtsFwxG8UMNKxlVAwUd2TtTzkbsTFnbg+6
         /JoriE8n91iGZh34xZZdnjVUy7zkJUFbbtvTAtPQkw5o9VNPaixy3yeoogdvoOreWqul
         hPlTWmrCBbrO6M30qPxxhALuIcEsqlFsavwS6tY8Wgu6ub9tZlfzDnvsegWJxOUgMD8P
         vxYw==
X-Gm-Message-State: AOJu0Yz5EG4MN9slpJQbUy3GSOXEBMOd0Qlyn/ZcAjb2RH2cCrwk0FCH
	uVakAJX/qiPTkB88J0QM3Yk2jXKloQkmqBBs
X-Google-Smtp-Source: AGHT+IH2Ff8M0E7t6std3hoj/b76ZqWbq6SpxE43rrAEil7ZuJ70D0QIDM0FadI4AIgVkalUNYOS/w==
X-Received: by 2002:a17:907:7895:b0:9ad:ef31:6efc with SMTP id ku21-20020a170907789500b009adef316efcmr9886238ejc.21.1695760094680;
        Tue, 26 Sep 2023 13:28:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id c19-20020a170906529300b00992e94bcfabsm8204664ejm.167.2023.09.26.13.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 13:28:14 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v6 7/9] documentation/bpf: Document cgroup unix socket address hooks
Date: Tue, 26 Sep 2023 22:27:46 +0200
Message-ID: <20230926202753.1482200-8-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926202753.1482200-1-daan.j.demeyer@gmail.com>
References: <20230926202753.1482200-1-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
index ad4d4d5eecb0..fa95479d1f6f 100644
--- a/Documentation/bpf/libbpf/program_types.rst
+++ b/Documentation/bpf/libbpf/program_types.rst
@@ -56,6 +56,16 @@ described in more detail in the footnotes.
 |                                           | ``BPF_CGROUP_UDP6_RECVMSG``            | ``cgroup/recvmsg6``              |           |
 +                                           +----------------------------------------+----------------------------------+-----------+
 |                                           | ``BPF_CGROUP_UDP6_SENDMSG``            | ``cgroup/sendmsg6``              |           |
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
2.41.0


