Return-Path: <bpf+bounces-9080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D78778F07C
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 17:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9DD28167B
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 15:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FCE16428;
	Thu, 31 Aug 2023 15:35:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548D316413;
	Thu, 31 Aug 2023 15:35:23 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20383E4C;
	Thu, 31 Aug 2023 08:35:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a603159f33so101534966b.0;
        Thu, 31 Aug 2023 08:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693496120; x=1694100920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPrh1obSVD9P3l5nWDq+dbgprPSNkWUNY1FNCUEr3RA=;
        b=bfM7eRmVizKfSOn/9tdB0H3StT+Co6iKflNAvfNUJKPquDR39hWRSZjSeFl10BRbXb
         IqKbsHypvpQndqpUz2DVdrdkqHRPJ526+klLqj2xD+ZBbt1e4+AFXKbIYnDxgBIWR/rp
         2d5dIMVLNAzE0Yeoij0kmY08pBqkrFVRaKh3SogyQXATDDES+YzEBZXT6NLos/znbpbe
         UlZcyAeRU8RwwlevCdOkG1huyyDx2Q1R92pNBDthsJPPLV8jnzdATSaWdwoh2g6A7FsQ
         qadiEYQoIprE7EdqGf4NeT/uPWad8tBrBoe9XP0kNWppkoqO0taWoLUMorkT8YqwEkz4
         4/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693496120; x=1694100920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPrh1obSVD9P3l5nWDq+dbgprPSNkWUNY1FNCUEr3RA=;
        b=I2ruNR6j6z7o39QYreurHvO0cevpjGO4aklcWJuSfdpUQT9f733tlRXJk9mcxtWzB3
         bqsokwyfRKlkehjJyKdDnpAYhVuxZBqPJLMckCckKHetdpWKdmVe1dmhYxueCczYrdUM
         haWRcLIteTklcUKPMTq0Dp7kzAorhwj80v/VYWWOSz5MBSCyYJBXGHuGv5aBKNJWLA40
         fs9/fTR4dvygW06khea3JowMPf2ViW0+65PIbTLDoV6ldhI4g36PJFNYezUJEp72zUvK
         WK5NAh4dnzFV2Dr2AGvjgsRK1dPOxyG3/hZENojfRM6KlnegJ0+CmyTbS7OSsK9XbCic
         nF2g==
X-Gm-Message-State: AOJu0Yy4zIaSVVad9MjMxSlVY1OJrQ/TJJ+bqSQKgwRtZ1bXBKQzMCxn
	qrMMXhGf9lqQG/8DfUz9093/xHB0rFILgWMUBAE=
X-Google-Smtp-Source: AGHT+IFPa/ONKkFmgEOSU7EXirwmaOQhMAI3BIOWJAh0bMvvEA7V34kK17alfvMd33lMHZDyew6g2A==
X-Received: by 2002:a17:906:3cb1:b0:9a5:c842:f2f with SMTP id b17-20020a1709063cb100b009a5c8420f2fmr4562113ejh.21.1693496120311;
        Thu, 31 Aug 2023 08:35:20 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::5:a62f])
        by smtp.googlemail.com with ESMTPSA id ds11-20020a170907724b00b0099bcf9c2ec6sm868583ejc.75.2023.08.31.08.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 08:35:19 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v3 7/9] documentation/bpf: Document cgroup unix socket address hooks
Date: Thu, 31 Aug 2023 17:34:51 +0200
Message-ID: <20230831153455.1867110-8-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831153455.1867110-1-daan.j.demeyer@gmail.com>
References: <20230831153455.1867110-1-daan.j.demeyer@gmail.com>
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


