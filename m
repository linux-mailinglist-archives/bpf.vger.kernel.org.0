Return-Path: <bpf+bounces-10578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FF47A9C92
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0FC1F2166E
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2696807C;
	Thu, 21 Sep 2023 18:34:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D42466DD3;
	Thu, 21 Sep 2023 18:34:53 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B33D256E;
	Thu, 21 Sep 2023 11:22:41 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50308217223so2170772e87.3;
        Thu, 21 Sep 2023 11:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695320559; x=1695925359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mT5GWJnaTH4P1kD5M11l1lYox9NySbmlcUDconn0p3U=;
        b=P0QwHs/ngOblStf+tAMUhwF27flmNVL/5h67Bfv4p/71N3dh4Hsai14cx7n27mW/l1
         a1/r+V3aBrhrcczyLkkmjKUEyn7Iq0p+r6jw+TG2ENP/uerfJdTxf1Il2+jeWe78/qAT
         LvUdbXZqcxiU2guWssTuVVB55dVoFjlRlBtTI8Yv7rbjAwkyePql24HRfK/l5qktG2kw
         zkDQFDlD5puWA2myXnfjvBie71exVoIbFN+s44GNZfh/7SlDv6BaLl31AYDFojuUb9+O
         pG9sZhrm9XiCHdD1/d93+IlV24/BsrcY3PA4WYSrQnxm3+r04aqBEMvavWnuLs4cWsts
         KSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320559; x=1695925359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mT5GWJnaTH4P1kD5M11l1lYox9NySbmlcUDconn0p3U=;
        b=ftdeuwjyN2irJJNvRHBlS0zFRHfjFOE+CL3yNJNSwTLxaHfaQNvqtcgwJ1Sir76fqD
         ragsqeLYZVBSWkBC5o/FBQbHWIEJ2nxao/wsjOSGdwCOJo354cP+irtrq4qqvTG5pvaL
         PJDDcxYEGZOgPlTYSOcgkin2QwzUOwKBKMD0tEzgPLKuGFBT7KeknAwZFUTiGTaidLLY
         ShELhzeKzOGm8rTlXdV+K4O0VEGhklBcpdiHv0CBrdFl/eIz2CBCW1ArseMH4FqqW+oX
         VFUMRkq7Rykj+JVq5KjxTGiu7DQnD+VGp1ZM7q572KYB3HRrDFt9IUqYVbcrxfrw5Tya
         OAzA==
X-Gm-Message-State: AOJu0YxIGWYCtzWjiVI9yYk7rfAfGeiAIWNqZDImoHMIAvNHWZADD6Nj
	tBPp9wYJihkFaMmtEEaEkIv/gXJKxRy50pFZVFY=
X-Google-Smtp-Source: AGHT+IH41Yn1gIW92VrmX4x2WissmJsr1Kxit8NI3c5GaszH5t4wWCLeLaiVSMYjZTkhetcVj6jPfA==
X-Received: by 2002:a17:906:217:b0:9ae:65a5:b6f4 with SMTP id 23-20020a170906021700b009ae65a5b6f4mr1303850ejd.20.1695298176280;
        Thu, 21 Sep 2023 05:09:36 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::4:2a59])
        by smtp.googlemail.com with ESMTPSA id gx10-20020a170906f1ca00b0099cb349d570sm952258ejb.185.2023.09.21.05.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 05:09:35 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v5 7/9] documentation/bpf: Document cgroup unix socket address hooks
Date: Thu, 21 Sep 2023 14:09:09 +0200
Message-ID: <20230921120913.566702-8-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921120913.566702-1-daan.j.demeyer@gmail.com>
References: <20230921120913.566702-1-daan.j.demeyer@gmail.com>
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


