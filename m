Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97C36EAF28
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 18:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjDUQbf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 12:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjDUQbb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 12:31:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8990E14F70
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:31:28 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-95678d891d6so264177166b.1
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682094686; x=1684686686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAdiYdJTmT1ElcYjcusvELkJU8uR9pERBCFvUOOPlpI=;
        b=m8pwg968C734fvxTj2aUvmwLdjk1H8J9WYpYTfaGKZfP+kGJBcqECt1apZ1NIhZqxm
         6IFMO7KHQTTEtFzcMOK1vMe1POl1VvPsDs5T8z1k8u89sMk5QSv+El45/kqPJ/wAEsoK
         NAnJd8ZdZbQ/GAThSreteSWAXiL1iLeH5fw6lqyiIdz8ESD7MgtvCvFSTraKkO+J+3ZY
         4C5ncBt+qsIXig6bGHcOexkna9P5EmJ2WOtSNidRhNCFUGsVaew5TkXeLleJGFk8W2eg
         BgkJ3UmZtj45S0gPXsm3cwigYvtb1k6FqGCLKd709z6cNjT83Kqo4nLekhqo02bSj7YY
         75wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682094686; x=1684686686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tAdiYdJTmT1ElcYjcusvELkJU8uR9pERBCFvUOOPlpI=;
        b=CU5xPZR+CQ+WSdWvAUOSjx1GJpUge7V5ebb/ADKZgNM7Q99qTaA+CqoWUDZb+iyoAL
         HLKebZUk8o4m+oSalFz/SmTDvfOiA+nxgXzJm3YzGB7ngJavagqaQU23AUDHyrILmdah
         cNbj9AGDtFNs8dhrSCWtRlvkGGGDxwskHrIj4MMRHHO8BFtAmZTxUFzK1+XmpZX1PvhY
         99BfQn6W9RxR6nfD0FZ4C70Y60mCXSyzr75cmSztoYJMI2YECWdRzn2LSOudL7ZoY42X
         gb8yBn6VrsPl9hIsYeKqS8aOgBomZigyTdp6NZ169IRofjeVgpNXPsVeOv4Cb3SprtzK
         ZVXw==
X-Gm-Message-State: AAQBX9ffO4ElB4GUjyhcmqIKhvJHazowrn6vLVJXW8B3PlYPIkidjB2I
        ZOb9FeXsSvvzI5apA4Aq9fNdJeiGQ0EChw==
X-Google-Smtp-Source: AKy350bvSGU48V+LQif6D75/gYaqlrYjaSSXz7QPhQx2cvjU7zXTSHt8DBb15np4JKvLiWj7RHGv2Q==
X-Received: by 2002:a17:906:5a68:b0:94e:ea07:4b87 with SMTP id my40-20020a1709065a6800b0094eea074b87mr2899729ejc.27.1682094686482;
        Fri, 21 Apr 2023 09:31:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id k9-20020a170906970900b009534211cc97sm2248578ejx.159.2023.04.21.09.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 09:31:26 -0700 (PDT)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>, martin.lau@linux.dev,
        kernel-team@meta.com
Subject: [PATCH bpf-next v3 08/10] bpftool: Add support for cgroup unix socket address hooks
Date:   Fri, 21 Apr 2023 18:27:16 +0200
Message-Id: <20230421162718.440230-9-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
References: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add the necessary plumbing to hook up the new cgroup unix sockaddr
hooks into bpftool.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 .../bpftool/Documentation/bpftool-cgroup.rst  | 21 ++++++++++++++-----
 tools/bpf/bpftool/cgroup.c                    | 17 ++++++++-------
 tools/bpf/bpftool/common.c                    |  6 ++++++
 3 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
index bd015ec9847b..a2d990fa623b 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
@@ -34,13 +34,16 @@ CGROUP COMMANDS
 |	*ATTACH_TYPE* := { **cgroup_inet_ingress** | **cgroup_inet_egress** |
 |		**cgroup_inet_sock_create** | **cgroup_sock_ops** |
 |		**cgroup_device** | **cgroup_inet4_bind** | **cgroup_inet6_bind** |
-|		**cgroup_inet4_post_bind** | **cgroup_inet6_post_bind** |
-|		**cgroup_inet4_connect** | **cgroup_inet6_connect** |
+|		**cgroup_unix_bind** | **cgroup_inet4_post_bind** |
+|		**cgroup_inet6_post_bind** | **cgroup_inet4_connect** |
+|		**cgroup_inet6_connect** | **cgroup_unix_connect** |
 |		**cgroup_inet4_getpeername** | **cgroup_inet6_getpeername** |
-|		**cgroup_inet4_getsockname** | **cgroup_inet6_getsockname** |
-|		**cgroup_udp4_sendmsg** | **cgroup_udp6_sendmsg** |
+|		**cgroup_unix_getpeername** | **cgroup_inet4_getsockname** |
+|		**cgroup_inet6_getsockname** | **cgroup_udp4_sendmsg** |
+|		**cgroup_udp6_sendmsg** | **cgroup_unix_sendmsg** |
 |		**cgroup_udp4_recvmsg** | **cgroup_udp6_recvmsg** |
-|		**cgroup_sysctl** | **cgroup_getsockopt** | **cgroup_setsockopt** |
+|		**cgroup_unix_recvmsg** | **cgroup_sysctl** |
+|		**cgroup_getsockopt** | **cgroup_setsockopt** |
 |		**cgroup_inet_sock_release** }
 |	*ATTACH_FLAGS* := { **multi** | **override** }
 
@@ -98,25 +101,33 @@ DESCRIPTION
 		  **device** device access (since 4.15);
 		  **bind4** call to bind(2) for an inet4 socket (since 4.17);
 		  **bind6** call to bind(2) for an inet6 socket (since 4.17);
+		  **bindun** call to bind(2) for a unix socket (since 6.3);
 		  **post_bind4** return from bind(2) for an inet4 socket (since 4.17);
 		  **post_bind6** return from bind(2) for an inet6 socket (since 4.17);
 		  **connect4** call to connect(2) for an inet4 socket (since 4.17);
 		  **connect6** call to connect(2) for an inet6 socket (since 4.17);
+		  **connectun** call to connect(2) for a unix socket (since 6.3);
 		  **sendmsg4** call to sendto(2), sendmsg(2), sendmmsg(2) for an
 		  unconnected udp4 socket (since 4.18);
 		  **sendmsg6** call to sendto(2), sendmsg(2), sendmmsg(2) for an
 		  unconnected udp6 socket (since 4.18);
+		  **sendmsgun** call to sendto(2), sendmsg(2), sendmmsg(2) for
+		  an unconnected unix socket (since 6.3);
 		  **recvmsg4** call to recvfrom(2), recvmsg(2), recvmmsg(2) for
 		  an unconnected udp4 socket (since 5.2);
 		  **recvmsg6** call to recvfrom(2), recvmsg(2), recvmmsg(2) for
 		  an unconnected udp6 socket (since 5.2);
+		  **recvmsgun** call to recvfrom(2), recvmsg(2), recvmmsg(2) for
+		  an unconnected unix socket (since 6.3);
 		  **sysctl** sysctl access (since 5.2);
 		  **getsockopt** call to getsockopt (since 5.3);
 		  **setsockopt** call to setsockopt (since 5.3);
 		  **getpeername4** call to getpeername(2) for an inet4 socket (since 5.8);
 		  **getpeername6** call to getpeername(2) for an inet6 socket (since 5.8);
+		  **getpeernameun** call to getpeername(2) for a unix socket (since 6.3);
 		  **getsockname4** call to getsockname(2) for an inet4 socket (since 5.8);
 		  **getsockname6** call to getsockname(2) for an inet6 socket (since 5.8).
+		  **getsocknameun** call to getsockname(2) for a unix socket (since 6.3);
 		  **sock_release** closing an userspace inet socket (since 5.9).
 
 	**bpftool cgroup detach** *CGROUP* *ATTACH_TYPE* *PROG*
diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index ac846b0805b4..a9700e00064c 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -26,13 +26,16 @@
 	"       ATTACH_TYPE := { cgroup_inet_ingress | cgroup_inet_egress |\n" \
 	"                        cgroup_inet_sock_create | cgroup_sock_ops |\n" \
 	"                        cgroup_device | cgroup_inet4_bind |\n" \
-	"                        cgroup_inet6_bind | cgroup_inet4_post_bind |\n" \
-	"                        cgroup_inet6_post_bind | cgroup_inet4_connect |\n" \
-	"                        cgroup_inet6_connect | cgroup_inet4_getpeername |\n" \
-	"                        cgroup_inet6_getpeername | cgroup_inet4_getsockname |\n" \
-	"                        cgroup_inet6_getsockname | cgroup_udp4_sendmsg |\n" \
-	"                        cgroup_udp6_sendmsg | cgroup_udp4_recvmsg |\n" \
-	"                        cgroup_udp6_recvmsg | cgroup_sysctl |\n" \
+	"                        cgroup_inet6_bind | cgroup_unix_bind |\n" \
+	"                        cgroup_inet4_post_bind | cgroup_inet6_post_bind |\n" \
+	"                        cgroup_inet4_connect | cgroup_inet6_connect |\n" \
+	"                        cgroup_unix_connect | cgroup_inet4_getpeername |\n" \
+	"                        cgroup_inet6_getpeername | cgroup_unix_getpeername |\n" \
+	"                        cgroup_inet4_getsockname | cgroup_inet6_getsockname |\n" \
+	"                        cgroup_unix_getsockname | cgroup_udp4_sendmsg |\n" \
+	"                        cgroup_udp6_sendmsg | cgroup_unix_sendmsg |\n" \
+	"                        cgroup_udp4_recvmsg | cgroup_udp6_recvmsg |\n" \
+	"                        cgroup_unix_recvmsg | cgroup_sysctl |\n" \
 	"                        cgroup_getsockopt | cgroup_setsockopt |\n" \
 	"                        cgroup_inet_sock_release }"
 
diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 5a73ccf14332..71c219b186aa 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -1067,19 +1067,25 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
 	case BPF_CGROUP_DEVICE:			return "device";
 	case BPF_CGROUP_INET4_BIND:		return "bind4";
 	case BPF_CGROUP_INET6_BIND:		return "bind6";
+	case BPF_CGROUP_UNIX_BIND:		return "bindun";
 	case BPF_CGROUP_INET4_CONNECT:		return "connect4";
 	case BPF_CGROUP_INET6_CONNECT:		return "connect6";
+	case BPF_CGROUP_UNIX_CONNECT:		return "connectun";
 	case BPF_CGROUP_INET4_POST_BIND:	return "post_bind4";
 	case BPF_CGROUP_INET6_POST_BIND:	return "post_bind6";
 	case BPF_CGROUP_INET4_GETPEERNAME:	return "getpeername4";
 	case BPF_CGROUP_INET6_GETPEERNAME:	return "getpeername6";
+	case BPF_CGROUP_UNIX_GETPEERNAME:	return "getpeernameun";
 	case BPF_CGROUP_INET4_GETSOCKNAME:	return "getsockname4";
 	case BPF_CGROUP_INET6_GETSOCKNAME:	return "getsockname6";
+	case BPF_CGROUP_UNIX_GETSOCKNAME:	return "getsocknameun";
 	case BPF_CGROUP_UDP4_SENDMSG:		return "sendmsg4";
 	case BPF_CGROUP_UDP6_SENDMSG:		return "sendmsg6";
+	case BPF_CGROUP_UNIX_SENDMSG:		return "sendmsgun";
 	case BPF_CGROUP_SYSCTL:			return "sysctl";
 	case BPF_CGROUP_UDP4_RECVMSG:		return "recvmsg4";
 	case BPF_CGROUP_UDP6_RECVMSG:		return "recvmsg6";
+	case BPF_CGROUP_UNIX_RECVMSG:		return "recvmsgun";
 	case BPF_CGROUP_GETSOCKOPT:		return "getsockopt";
 	case BPF_CGROUP_SETSOCKOPT:		return "setsockopt";
 	case BPF_TRACE_RAW_TP:			return "raw_tp";
-- 
2.40.0

