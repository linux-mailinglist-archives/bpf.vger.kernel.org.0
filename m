Return-Path: <bpf+bounces-10556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B871A7A9C73
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A2BFB2213F
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80774A554;
	Thu, 21 Sep 2023 17:52:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77A91A5A8;
	Thu, 21 Sep 2023 17:52:09 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E9983CB;
	Thu, 21 Sep 2023 10:51:42 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9adcb89b48bso152534166b.2;
        Thu, 21 Sep 2023 10:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695318701; x=1695923501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mq/loJ3f6wtqZ+hmIk0WpfL7yP6DzrTTWuWZOJLjWIU=;
        b=Yo7IDN6XPIEo4HgwOMU+eg15ZY7ii8eE0NNcUw3MbtmARl7UlF2BDTOHfZdG3uOP+d
         LQ7x/LIOsBny4/jOMwvER+KMvEObPt2upf97pDmVSiMVT93TLIRsytZ59tLQ+uDYu/UH
         U1fCehVqom21WL0Xs5K8Dxg2mAP1QPRbbzyYswYsvFPDaiOWTIGIRm7PMWAoqEWGjs/q
         thUwY7Cs13V7HjC+fWblvTvxHex4VDAtyGFBTfjDNBHLJLarMPc4XwOks9yvExJYM7zF
         Lrcyi1SCm7O08YvtqgQ8x1kVL3x6mXv8x7vbIkPsnWFMESQKzD1RAJNIYufK5h40NPcF
         PmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318701; x=1695923501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mq/loJ3f6wtqZ+hmIk0WpfL7yP6DzrTTWuWZOJLjWIU=;
        b=tNd3/C+LVhanrtSux6/rboKdM2MbUsTaKbagubcn25guoy4Fw9Bf5BGjcndV1Uqykn
         EV8zB5FHaMGycYEJoKhWgYEfbAebo9NtHAk3woh96kP59pTMO5fBS27J/9XTZtIIqVh6
         X75Ms85dbtG6IjepVlaYwKxqwAxx0rZmvZBLJWi3Pd8wLY7U5Htox3E0GitkMr03TaXj
         91ot9Xn8ORDRcA925G2QqwqsdPCs5E05AYei952/iGv9cNkuANPIVrnXDOVHYVloChi3
         JyiJ0zfVSW6pWCv5Nz9xwhe4IU5clEzUuDe9tDLu+5tergDha8gaiCjJttSn533Az1aR
         /SMg==
X-Gm-Message-State: AOJu0Ywze9XOkS1k7x9OuxdbQKfsaGAakDoCilCLKLU+VVDcBM3yJPcj
	UzcYyu6EYZJVNkC8t6rVHQLus9/i6FHU/Q+zSqQ=
X-Google-Smtp-Source: AGHT+IEFJhITBWBqjtaYAixXBZqOAAIzen+B4s581uvnjceqIXO+7rnHnzvDICY3TNx/rCYfF9n+yQ==
X-Received: by 2002:a2e:910e:0:b0:2bc:efa4:2c36 with SMTP id m14-20020a2e910e000000b002bcefa42c36mr5019470ljg.11.1695298174088;
        Thu, 21 Sep 2023 05:09:34 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::4:2a59])
        by smtp.googlemail.com with ESMTPSA id gx10-20020a170906f1ca00b0099cb349d570sm952258ejb.185.2023.09.21.05.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 05:09:33 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v5 5/9] libbpf: Add support for cgroup unix socket address hooks
Date: Thu, 21 Sep 2023 14:09:07 +0200
Message-ID: <20230921120913.566702-6-daan.j.demeyer@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add the necessary plumbing to hook up the new cgroup unix sockaddr
hooks into libbpf.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 tools/lib/bpf/libbpf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3a6108e3238b..2c5c8c8f2aa2 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -82,17 +82,22 @@ static const char * const attach_type_name[] = {
 	[BPF_CGROUP_INET6_BIND]		= "cgroup_inet6_bind",
 	[BPF_CGROUP_INET4_CONNECT]	= "cgroup_inet4_connect",
 	[BPF_CGROUP_INET6_CONNECT]	= "cgroup_inet6_connect",
+	[BPF_CGROUP_UNIX_CONNECT]       = "cgroup_unix_connect",
 	[BPF_CGROUP_INET4_POST_BIND]	= "cgroup_inet4_post_bind",
 	[BPF_CGROUP_INET6_POST_BIND]	= "cgroup_inet6_post_bind",
 	[BPF_CGROUP_INET4_GETPEERNAME]	= "cgroup_inet4_getpeername",
 	[BPF_CGROUP_INET6_GETPEERNAME]	= "cgroup_inet6_getpeername",
+	[BPF_CGROUP_UNIX_GETPEERNAME]	= "cgroup_unix_getpeername",
 	[BPF_CGROUP_INET4_GETSOCKNAME]	= "cgroup_inet4_getsockname",
 	[BPF_CGROUP_INET6_GETSOCKNAME]	= "cgroup_inet6_getsockname",
+	[BPF_CGROUP_UNIX_GETSOCKNAME]	= "cgroup_unix_getsockname",
 	[BPF_CGROUP_UDP4_SENDMSG]	= "cgroup_udp4_sendmsg",
 	[BPF_CGROUP_UDP6_SENDMSG]	= "cgroup_udp6_sendmsg",
+	[BPF_CGROUP_UNIX_SENDMSG]	= "cgroup_unix_sendmsg",
 	[BPF_CGROUP_SYSCTL]		= "cgroup_sysctl",
 	[BPF_CGROUP_UDP4_RECVMSG]	= "cgroup_udp4_recvmsg",
 	[BPF_CGROUP_UDP6_RECVMSG]	= "cgroup_udp6_recvmsg",
+	[BPF_CGROUP_UNIX_RECVMSG]	= "cgroup_unix_recvmsg",
 	[BPF_CGROUP_GETSOCKOPT]		= "cgroup_getsockopt",
 	[BPF_CGROUP_SETSOCKOPT]		= "cgroup_setsockopt",
 	[BPF_SK_SKB_STREAM_PARSER]	= "sk_skb_stream_parser",
@@ -8960,14 +8965,19 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("cgroup/bind6",		CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_BIND, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/connect4",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_CONNECT, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/connect6",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_CONNECT, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/connectun",	CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_CONNECT, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/sendmsg4",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4_SENDMSG, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/sendmsg6",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6_SENDMSG, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/sendmsgun",	CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_SENDMSG, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/recvmsg4",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4_RECVMSG, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/recvmsg6",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6_RECVMSG, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/recvmsgun",	CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_RECVMSG, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/getpeername4",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETPEERNAME, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/getpeername6",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETPEERNAME, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/getpeernameun", CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_GETPEERNAME, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/getsockname4",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETSOCKNAME, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/getsockname6",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETSOCKNAME, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/getsocknameun", CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_GETSOCKNAME, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/sysctl",	CGROUP_SYSCTL, BPF_CGROUP_SYSCTL, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/getsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_GETSOCKOPT, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/setsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT, SEC_ATTACHABLE),
-- 
2.41.0


