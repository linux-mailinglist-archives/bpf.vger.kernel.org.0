Return-Path: <bpf+bounces-8903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3522A78C241
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 12:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660A31C209DC
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 10:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C3E15494;
	Tue, 29 Aug 2023 10:19:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619B214F72
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 10:19:29 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534E7CC9
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 03:19:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so5389936a12.1
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 03:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693304359; x=1693909159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPrh1obSVD9P3l5nWDq+dbgprPSNkWUNY1FNCUEr3RA=;
        b=pFWM/l/Uu20i9Z3OEviTiB3cWePBp7+Ye14HOwBdCM9UdTxNx7bmXWYNZM4M3rPk+K
         aon7t5KjtrPHXfRAFwIoT+r6yok1PaXyA3Big63NIufLjmM84ozxVWn1ne/l81qPinTK
         Vm3Gg9pxBDF8FTgq8hiyds29wgWcwtyNRFvkujez8Z/OynEUG6xROwrkUwABsBp7SkTF
         PE5SiRfyPtbCfEY5QXp4qKjiS5hJeF31znnVjkaMPK7iuNWtZ163/3sTVAGVXH6nf8hp
         hEye9KT6zzUrhBK0SS0Z3vU3IQ8V2+/jsG8SGPd9NzJ4s2s0vQZxIkbZiYK2XBJc8Jxk
         zIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693304359; x=1693909159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPrh1obSVD9P3l5nWDq+dbgprPSNkWUNY1FNCUEr3RA=;
        b=E6Ok4Xu6PR8RFNeHMv62sc/AohDvM0lBOYsYJ9aOBrNCfL2+qxumy6MVKp3xh/3uyd
         ECdxSskUYsO4p6e8tJqCDTBVw9hO5jiKPawKmNWBzoy2G4KrG3GshRmyf++Lj/0VenMO
         TTxq8t9UxQvibWXdseBXFdMCp6e0thB+IYbGg2D+S6u3n1hH1a0c4fuujd5ncAAMCxqR
         xJmlVslyknOvP9RVPxA+AOKykwdA/zpnMPJAsfAGbnVxC7KkIfNqErRzuApO1DV5ip0H
         BmztSExbSyDRpEHJzlzNFNEp/k7tmhq4PVinve4Kn+GYRv3FssiqUJuFf97eKwzRJqAh
         rbwg==
X-Gm-Message-State: AOJu0YzUKAHyALkL2JuOBjJ/NNAsTAsH5jFWkTzSmNN4ZdweS9Adzs9r
	fSRkqAeiPjBWrS1wgXmUSIIn1Io1cDqFZSxDUYg=
X-Google-Smtp-Source: AGHT+IGHIsOPGWLF55ZQcJhn55RMgWd6I8tiFbBWejWM2ddxBYZEAI1djOS9qUwAzULiSwXckE4Z1A==
X-Received: by 2002:a05:6402:398:b0:525:7091:124c with SMTP id o24-20020a056402039800b005257091124cmr21766722edv.19.1693304359515;
        Tue, 29 Aug 2023 03:19:19 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com (2001-1c05-3310-3500-67a4-023c-67c4-b186.cable.dynamic.v6.ziggo.nl. [2001:1c05:3310:3500:67a4:23c:67c4:b186])
        by smtp.googlemail.com with ESMTPSA id f15-20020a50ee8f000000b0051e2670d599sm5545606edr.4.2023.08.29.03.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 03:19:18 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 7/9] documentation/bpf: Document cgroup unix socket address hooks
Date: Tue, 29 Aug 2023 12:18:31 +0200
Message-ID: <20230829101838.851350-8-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829101838.851350-1-daan.j.demeyer@gmail.com>
References: <20230829101838.851350-1-daan.j.demeyer@gmail.com>
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
2.41.0


