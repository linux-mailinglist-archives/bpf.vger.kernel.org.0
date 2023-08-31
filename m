Return-Path: <bpf+bounces-9077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1061B78F074
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 17:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338041C20AFA
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 15:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25BC15AE3;
	Thu, 31 Aug 2023 15:35:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE16815ADB;
	Thu, 31 Aug 2023 15:35:21 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E58E4C;
	Thu, 31 Aug 2023 08:35:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a5e1812378so112343866b.2;
        Thu, 31 Aug 2023 08:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693496118; x=1694100918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0DGTowVg9Uc336U6PFvgmYvKqV0hgvvYv5OSHWGQ8A=;
        b=VPw8+uUR2Jgm26Xg78RouuPUsw5vsv7Ou/nFGLi66s+jgwzaCmIHiSVGKvFaWSfF4n
         WB5CtBwrHEXEkKxS3ooxw0FXiAXc52Wkoy+mFuokSfj8oQ6R0PHlmO1bSmlYezKZ8nR9
         67h7UAPskKyqGU0OvLIK8fzL30eXnmytQyQ/Ox15Pn/WJxArU0+OJN2+rs86SUBTwepe
         aW23OtcMWZ1XQO5XCFI9ywZu3919CS5bBpQA44maTwJ6u77RYo1kRqvJWJI7aOrUQv4E
         fuvyxbSzvpvzEmsvvmHZnNWg0wu+su1kqI1AWIOAf4yjtMt+nhsipsIiPm9xGRvzhG+R
         eAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693496118; x=1694100918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0DGTowVg9Uc336U6PFvgmYvKqV0hgvvYv5OSHWGQ8A=;
        b=IdfT4gqdQuqUb9/eO5MDpDuhPioRNWW4b+xZsxJlDuw5HSRzH27i3U6C5o486SJFCb
         jDJlMJUsFRd02PXm2fjR7odLb01HEppVbScDF96HGvt7mFT8HMAfB3EkgnfRtFPZi6KK
         WHJ2a7V/2eIA203BLhIHJb0uVSr61eqX7D7zliKrqbgIHlWbkU4tCHJy9FM0dOtwUJ1R
         wlvRo437jfePpfDlfnwrSU5PbT9feIZ4yvgzGfYhN3rj7xHfcpkeiNVj6ayNhfTdkoL5
         y7BH1j7OAeqEGEMc/p9ocutvZWeLQLXg8cW9Uhk/4/ua1UCOFxXmuwpARuRIIaLOI9W+
         VnLA==
X-Gm-Message-State: AOJu0YwGMGrU0FCd24L5U7UR12Cmx9ECqXFBhO8BaT1WQLq/vaC+59Xp
	zPm/OAL34tGt2tjZA3+yFCVRREMtzlD7XGvhgbM=
X-Google-Smtp-Source: AGHT+IHJ8MHR3EZyKPiByuW5fBFkwTMATr2xBSHkyLCSbM/ER6KJeskfg0PoctmAOYw4JCMnjYAvUQ==
X-Received: by 2002:a17:906:530c:b0:9a2:16e2:35c with SMTP id h12-20020a170906530c00b009a216e2035cmr4008176ejo.31.1693496118491;
        Thu, 31 Aug 2023 08:35:18 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::5:a62f])
        by smtp.googlemail.com with ESMTPSA id ds11-20020a170907724b00b0099bcf9c2ec6sm868583ejc.75.2023.08.31.08.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 08:35:18 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v3 5/9] libbpf: Add support for cgroup unix socket address hooks
Date: Thu, 31 Aug 2023 17:34:49 +0200
Message-ID: <20230831153455.1867110-6-daan.j.demeyer@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add the necessary plumbing to hook up the new cgroup unix sockaddr
hooks into libbpf.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 tools/lib/bpf/libbpf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 96ff1aa4bf6a..99075f7f4e11 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -80,19 +80,25 @@ static const char * const attach_type_name[] = {
 	[BPF_CGROUP_DEVICE]		= "cgroup_device",
 	[BPF_CGROUP_INET4_BIND]		= "cgroup_inet4_bind",
 	[BPF_CGROUP_INET6_BIND]		= "cgroup_inet6_bind",
+	[BPF_CGROUP_UNIX_BIND]		= "cgroup_unix_bind",
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
@@ -8840,16 +8846,22 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("cgroup/post_bind6",	CGROUP_SOCK, BPF_CGROUP_INET6_POST_BIND, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/bind4",		CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_BIND, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/bind6",		CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_BIND, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/bindun",	CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_BIND, SEC_ATTACHABLE),
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


