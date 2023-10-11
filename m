Return-Path: <bpf+bounces-11952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DA27C5D03
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 20:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADADD2823B7
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 18:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FCD12E4C;
	Wed, 11 Oct 2023 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+GRk4af"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D30E3F4DB;
	Wed, 11 Oct 2023 18:51:34 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3786DC;
	Wed, 11 Oct 2023 11:51:31 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3232be274a0so877725f8f.1;
        Wed, 11 Oct 2023 11:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697050290; x=1697655090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H72a4LGVoNUCY/gkI1SHITmNrYjcQdayNCB9aEVVaZ4=;
        b=O+GRk4af6JQZerPBMq7jj5dTFU9bnziIfRd2X8G5/S2oWriEZJ4z/CPudW8Haz0NVN
         KFXoFsitGvqTyHj3UfHiIYUDePtpjCbrFMwOAzXWd3LbrU6b3laT8/kLGaoiTK8mvuKl
         6wVJdnu4QC3c6XOaxLdEtdXPOAnvJ3+zN2saUHHq5iDP+/zLh9W31IgKXEET5ET9B7ex
         PYzZ1DMvLhZszu14RsQXEPnKl7RejhCBliaBitxpAtesoNsbW69y5B2CaTutJ+/nToqu
         57Vw3h5V4G3e0BMOC04ID7c2xNdA/0xtB0bBcj5o4v1NtvsFqp97iY98y1FESghLU015
         pYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050290; x=1697655090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H72a4LGVoNUCY/gkI1SHITmNrYjcQdayNCB9aEVVaZ4=;
        b=QZFliI/p/G2qOrwRbrfneiPLU36JAn8D5XXGbR7wN/Byh8BkkqRbNE0BOa78XwcalU
         ykCVmoWs3m5zZ4WiMEhjxCelJ7BCKp9XmTq/ZzLYAPMvnwE1LbCLkbOLe6AL+KaQFMoz
         nZUZ59y34bZXCsztU4+sYw/9YQjjWEsbyCZEKADVM3klZ4tMsApKii2LKw9JtnAwm5dx
         nEJpLOEwFtjPfP+4upzLBV50nZEKkWNs1h/anicpBZCwgjTUnabEIJ85uMouq5qtz+5I
         MjnTu1mqTn3tvJV61dDtVPFgj0tshhiQKkJWkhFIOUdnQ6w9OIHmH5Ke7qQB268dskIn
         PRBg==
X-Gm-Message-State: AOJu0Yx9Gt58YKP1MHuVpQjKCS6WL+Y1g/Ew64IBc7Ct2fcJWfVPV0/B
	7kro+ZMr8MfN5S5kfztvMWTCIrV84l3FxsXR
X-Google-Smtp-Source: AGHT+IFoZuL+vm5ZBF4y9VVLZ0vlrBapZjf1GHhzF8QAwlKsde+kVsgogvREqHxwP4nOe3RFesvXCg==
X-Received: by 2002:a5d:48cb:0:b0:323:3062:ef5d with SMTP id p11-20020a5d48cb000000b003233062ef5dmr14820155wrs.33.1697050290039;
        Wed, 11 Oct 2023 11:51:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id h9-20020a5d6889000000b0031c52e81490sm16424484wru.72.2023.10.11.11.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 11:51:29 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v11 5/9] libbpf: Add support for cgroup unix socket address hooks
Date: Wed, 11 Oct 2023 20:51:07 +0200
Message-ID: <20231011185113.140426-6-daan.j.demeyer@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add the necessary plumbing to hook up the new cgroup unix sockaddr
hooks into libbpf.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 tools/lib/bpf/libbpf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 31b8b252e614..a295f6acf98f 100644
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
+	SEC_DEF("cgroup/connect_unix",	CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_CONNECT, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/sendmsg4",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4_SENDMSG, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/sendmsg6",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6_SENDMSG, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/sendmsg_unix",	CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_SENDMSG, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/recvmsg4",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4_RECVMSG, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/recvmsg6",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6_RECVMSG, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/recvmsg_unix",	CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_RECVMSG, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/getpeername4",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETPEERNAME, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/getpeername6",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETPEERNAME, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/getpeername_unix", CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_GETPEERNAME, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/getsockname4",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETSOCKNAME, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/getsockname6",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETSOCKNAME, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/getsockname_unix", CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_GETSOCKNAME, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/sysctl",	CGROUP_SYSCTL, BPF_CGROUP_SYSCTL, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/getsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_GETSOCKOPT, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/setsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT, SEC_ATTACHABLE),
-- 
2.41.0


