Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749546EAF27
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 18:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjDUQbb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 12:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjDUQba (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 12:31:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796D415444
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:31:27 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-95316faa3a8so315751366b.2
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682094685; x=1684686685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlmCQ1bWISwjXx8nPRcd1IaBUx7R6I6VoIO3cs8+xhQ=;
        b=aKGSv/FJebfkBmnCFAP3vBWGgqCA+HJHq7I2Ps6CvybyvaMeUXyXt0323zDDzvc6ze
         6VcBn1HnHoQGh0FFkMVtiqCU5618/RF9Ym+Q/Zr6TM0dS0ObeLo3Yj9paEcvfVGDyEQz
         /ZiylFvXzMyCB8GQLTtmIoi227CcD1mhiBebKv772sD+QR3smTpatknBk3dfBxbAUUAm
         zk1c57J4piPu19QyRQ+yuQOaaWD7kMgWnoFFH712ueDPUN3EFKNIzImAILd29cUPNpRT
         x4WyD7178I9YFUlbnAn96sxPJ+C7IWHfqUwrocb5GH61l0/I8Rnau25hZU4IAeP4F4uZ
         SldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682094685; x=1684686685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlmCQ1bWISwjXx8nPRcd1IaBUx7R6I6VoIO3cs8+xhQ=;
        b=WajU4TTvIL615E5Bx8jRdv1n6EgTLeXB2M+b2EbjgaPU79igigpUnyiBAPAxJ1aiyA
         1lVwN9t489jC3VWFPMk5UXEGLuU2q1nAJUx8IMcLVvzVgCxWlCz0r/Jf3PRYNmZYqLvf
         0oFe7eT+SO7ttrmZ20bQHXimXop9fMiI/4QJjxQxdsQPu0Swfh1QiDkcNOTO+Y2AutBA
         E1gpcg3ZTNi3keWSY7r4jAz4reqdfVZ00OVd5tBGDbVXH6Fbbo+wTVaQqmXHDOKSc0RG
         7i9y7lM7VseeVMeU+9KQDicBTk/709jEisNIuSZYL+/6fg24fupMltnhijKQO5k1/+2C
         kKiw==
X-Gm-Message-State: AAQBX9eW3ns7mUth31wf97xqXCoaDliI+n1w3KXuG0zw65bXZje5HJWi
        YrzdGcv2shMjORetRUIy1e4T6COqBLM9KA==
X-Google-Smtp-Source: AKy350bCDLRTp9WIHrJKeGNUzjyOuMeBUMHv55YxlqRv9wN3pyIhp1tWYhfA9oWQaceTxlCGp/42zw==
X-Received: by 2002:a17:906:37c9:b0:930:e9ee:c474 with SMTP id o9-20020a17090637c900b00930e9eec474mr3268069ejc.54.1682094685555;
        Fri, 21 Apr 2023 09:31:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id k9-20020a170906970900b009534211cc97sm2248578ejx.159.2023.04.21.09.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 09:31:25 -0700 (PDT)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>, martin.lau@linux.dev,
        kernel-team@meta.com
Subject: [PATCH bpf-next v3 07/10] libbpf: Add support for cgroup unix socket address hooks
Date:   Fri, 21 Apr 2023 18:27:15 +0200
Message-Id: <20230421162718.440230-8-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
References: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add the necessary plumbing to hook up the new cgroup unix sockaddr
hooks into libbpf.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 tools/lib/bpf/libbpf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2600d8384252..0c4f67c3d9b9 100644
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
@@ -8693,16 +8699,22 @@ static const struct bpf_sec_def section_defs[] = {
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
2.40.0

