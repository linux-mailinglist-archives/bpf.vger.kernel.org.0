Return-Path: <bpf+bounces-11525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1313C7BB295
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 09:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362B21C20C4E
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 07:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D824C111BD;
	Fri,  6 Oct 2023 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnFnUgkE"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA506749A;
	Fri,  6 Oct 2023 07:45:58 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39473EB;
	Fri,  6 Oct 2023 00:45:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5031ccf004cso2260737e87.2;
        Fri, 06 Oct 2023 00:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696578354; x=1697183154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOo9TydguJdU9EI/0Wd4N0A1MV15H9FmJHUdXa6nEsw=;
        b=fnFnUgkEKHFWdHOGTC2jbcZZwv6AqJ7SPgJmJHTH4PAH7j96pzVToCTK0HITxSir92
         PqXi8FPwe6ppXxJxqRLvocNP5KDlF1AHPT1uGABGImS27sUBd92W8LMLspbyuQb4jBbl
         l+SS8ahkIMDfuSSQRPOlA0yfF/h2WHMbOM/Fl3MM378e0z/ozCYdkA81FBhO3iUXzOFF
         nOOI2Ol3hXseJ8LysAHj0IccEZJqT4fcatHQLe6ur+ctFH/b8Ler/XqZvWDlQE3Gz8N/
         iMRKSm3cq3pKZOoGHXc3wJfK2l3JGyAcKeHJQoc6Q4DhQEImtg+0j0CdHg7nJFLSautC
         iLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696578354; x=1697183154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOo9TydguJdU9EI/0Wd4N0A1MV15H9FmJHUdXa6nEsw=;
        b=uw+QFNfG2bF/47OH1WdUDVay8vFF3E4n8RF8a08RcjLOaeZE3kDoHmlLvAxmevozJw
         ZJU5BC0wHhp6Xd2VQYoR1Cizv7V+E9VXLgUngJ0kB86xf9+2BYvgLuZLvnk4/1bVpahn
         NfoeD7deGpm1II4ZGUD/jF/r8V/MsC5npyrjuuN/5ZCUE96Yw1qCyBRvJ85Rw/AHtH1Y
         voXLsTtwc45L5QI3VW9oNTtr2tappbyePZeU8Egox6QBLujdPOVKpzOwDG/9jqmZAMDP
         Z6zF61HV5gkmtZ/r5YlUk825veA2qdGqRdA1dUL7kUwfi20D656TxdvuombmOFDfJF6w
         fY3Q==
X-Gm-Message-State: AOJu0Yyx3mKXB/jE/xIchulGik/cMfG26bqNZYTv2fM+dEos/uUqiZD2
	SmXmxJdMp421VkpoSdD/1phjWwKbqkxXe2vE
X-Google-Smtp-Source: AGHT+IGCzuKbZCZmrYJAaN0hv7m2TWvAqYwX44tAj7usgkVzW+VGcS63pYposDFsJ1RYnPlIIPqNQA==
X-Received: by 2002:a05:6512:2514:b0:503:90d:e0df with SMTP id be20-20020a056512251400b00503090de0dfmr6635988lfb.34.1696578353526;
        Fri, 06 Oct 2023 00:45:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id k22-20020a7bc416000000b00404719b05b5sm3126888wmi.27.2023.10.06.00.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 00:45:52 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org,
	Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v9 6/9] bpftool: Add support for cgroup unix socket address hooks
Date: Fri,  6 Oct 2023 09:45:00 +0200
Message-ID: <20231006074530.892825-7-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006074530.892825-1-daan.j.demeyer@gmail.com>
References: <20231006074530.892825-1-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add the necessary plumbing to hook up the new cgroup unix sockaddr
hooks into bpftool.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
Acked-by: Quentin Monnet <quentin@isovalent.com>
---
 .../bpf/bpftool/Documentation/bpftool-cgroup.rst | 16 +++++++++++++---
 tools/bpf/bpftool/Documentation/bpftool-prog.rst |  8 +++++---
 tools/bpf/bpftool/bash-completion/bpftool        | 14 +++++++-------
 tools/bpf/bpftool/cgroup.c                       | 16 +++++++++-------
 tools/bpf/bpftool/prog.c                         |  7 ++++---
 5 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
index bd015ec9847b..2ce900f66d6e 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
@@ -36,11 +36,14 @@ CGROUP COMMANDS
 |		**cgroup_device** | **cgroup_inet4_bind** | **cgroup_inet6_bind** |
 |		**cgroup_inet4_post_bind** | **cgroup_inet6_post_bind** |
 |		**cgroup_inet4_connect** | **cgroup_inet6_connect** |
-|		**cgroup_inet4_getpeername** | **cgroup_inet6_getpeername** |
+|		**cgroup_unix_connect** | **cgroup_inet4_getpeername** |
+|		**cgroup_inet6_getpeername** | **cgroup_unix_getpeername** |
 |		**cgroup_inet4_getsockname** | **cgroup_inet6_getsockname** |
-|		**cgroup_udp4_sendmsg** | **cgroup_udp6_sendmsg** |
+|		**cgroup_unix_getsockname** | **cgroup_udp4_sendmsg** |
+|		**cgroup_udp6_sendmsg** | **cgroup_unix_sendmsg** |
 |		**cgroup_udp4_recvmsg** | **cgroup_udp6_recvmsg** |
-|		**cgroup_sysctl** | **cgroup_getsockopt** | **cgroup_setsockopt** |
+|		**cgroup_unix_recvmsg** | **cgroup_sysctl** |
+|		**cgroup_getsockopt** | **cgroup_setsockopt** |
 |		**cgroup_inet_sock_release** }
 |	*ATTACH_FLAGS* := { **multi** | **override** }
 
@@ -102,21 +105,28 @@ DESCRIPTION
 		  **post_bind6** return from bind(2) for an inet6 socket (since 4.17);
 		  **connect4** call to connect(2) for an inet4 socket (since 4.17);
 		  **connect6** call to connect(2) for an inet6 socket (since 4.17);
+		  **connect_unix** call to connect(2) for a unix socket (since 6.7);
 		  **sendmsg4** call to sendto(2), sendmsg(2), sendmmsg(2) for an
 		  unconnected udp4 socket (since 4.18);
 		  **sendmsg6** call to sendto(2), sendmsg(2), sendmmsg(2) for an
 		  unconnected udp6 socket (since 4.18);
+		  **sendmsg_unix** call to sendto(2), sendmsg(2), sendmmsg(2) for
+		  an unconnected unix socket (since 6.7);
 		  **recvmsg4** call to recvfrom(2), recvmsg(2), recvmmsg(2) for
 		  an unconnected udp4 socket (since 5.2);
 		  **recvmsg6** call to recvfrom(2), recvmsg(2), recvmmsg(2) for
 		  an unconnected udp6 socket (since 5.2);
+		  **recvmsg_unix** call to recvfrom(2), recvmsg(2), recvmmsg(2) for
+		  an unconnected unix socket (since 6.7);
 		  **sysctl** sysctl access (since 5.2);
 		  **getsockopt** call to getsockopt (since 5.3);
 		  **setsockopt** call to setsockopt (since 5.3);
 		  **getpeername4** call to getpeername(2) for an inet4 socket (since 5.8);
 		  **getpeername6** call to getpeername(2) for an inet6 socket (since 5.8);
+		  **getpeername_unix** call to getpeername(2) for a unix socket (since 6.7);
 		  **getsockname4** call to getsockname(2) for an inet4 socket (since 5.8);
 		  **getsockname6** call to getsockname(2) for an inet6 socket (since 5.8).
+		  **getsockname_unix** call to getsockname(2) for a unix socket (since 6.7);
 		  **sock_release** closing an userspace inet socket (since 5.9).
 
 	**bpftool cgroup detach** *CGROUP* *ATTACH_TYPE* *PROG*
diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index dcae81bd27ed..58e6a5b10ef7 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -47,9 +47,11 @@ PROG COMMANDS
 |		**cgroup/sock** | **cgroup/dev** | **lwt_in** | **lwt_out** | **lwt_xmit** |
 |		**lwt_seg6local** | **sockops** | **sk_skb** | **sk_msg** | **lirc_mode2** |
 |		**cgroup/bind4** | **cgroup/bind6** | **cgroup/post_bind4** | **cgroup/post_bind6** |
-|		**cgroup/connect4** | **cgroup/connect6** | **cgroup/getpeername4** | **cgroup/getpeername6** |
-|               **cgroup/getsockname4** | **cgroup/getsockname6** | **cgroup/sendmsg4** | **cgroup/sendmsg6** |
-|		**cgroup/recvmsg4** | **cgroup/recvmsg6** | **cgroup/sysctl** |
+|		**cgroup/connect4** | **cgroup/connect6** | **cgroup/connect_unix** |
+|		**cgroup/getpeername4** | **cgroup/getpeername6** | **cgroup/getpeername_unix** |
+|		**cgroup/getsockname4** | **cgroup/getsockname6** | **cgroup/getsockname_unix** |
+|		**cgroup/sendmsg4** | **cgroup/sendmsg6** | **cgroup/sendmsg_unix** |
+|		**cgroup/recvmsg4** | **cgroup/recvmsg6** | **cgroup/recvmsg_unix** | **cgroup/sysctl** |
 |		**cgroup/getsockopt** | **cgroup/setsockopt** | **cgroup/sock_release** |
 |		**struct_ops** | **fentry** | **fexit** | **freplace** | **sk_lookup**
 |	}
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 085bf18f3659..6e4f7ce6bc01 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -480,13 +480,13 @@ _bpftool()
                                 action tracepoint raw_tracepoint \
                                 xdp perf_event cgroup/skb cgroup/sock \
                                 cgroup/dev lwt_in lwt_out lwt_xmit \
-                                lwt_seg6local sockops sk_skb sk_msg \
-                                lirc_mode2 cgroup/bind4 cgroup/bind6 \
-                                cgroup/connect4 cgroup/connect6 \
-                                cgroup/getpeername4 cgroup/getpeername6 \
-                                cgroup/getsockname4 cgroup/getsockname6 \
-                                cgroup/sendmsg4 cgroup/sendmsg6 \
-                                cgroup/recvmsg4 cgroup/recvmsg6 \
+                                lwt_seg6local sockops sk_skb sk_msg lirc_mode2 \
+                                cgroup/bind4 cgroup/bind6 \
+                                cgroup/connect4 cgroup/connect6 cgroup/connect_unix \
+                                cgroup/getpeername4 cgroup/getpeername6 cgroup/getpeername_unix \
+                                cgroup/getsockname4 cgroup/getsockname6 cgroup/getsockname_unix \
+                                cgroup/sendmsg4 cgroup/sendmsg6 cgroup/sendmsg_unix \
+                                cgroup/recvmsg4 cgroup/recvmsg6 cgroup/recvmsg_unix \
                                 cgroup/post_bind4 cgroup/post_bind6 \
                                 cgroup/sysctl cgroup/getsockopt \
                                 cgroup/setsockopt cgroup/sock_release struct_ops \
diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index ac846b0805b4..af6898c0f388 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -28,13 +28,15 @@
 	"                        cgroup_device | cgroup_inet4_bind |\n" \
 	"                        cgroup_inet6_bind | cgroup_inet4_post_bind |\n" \
 	"                        cgroup_inet6_post_bind | cgroup_inet4_connect |\n" \
-	"                        cgroup_inet6_connect | cgroup_inet4_getpeername |\n" \
-	"                        cgroup_inet6_getpeername | cgroup_inet4_getsockname |\n" \
-	"                        cgroup_inet6_getsockname | cgroup_udp4_sendmsg |\n" \
-	"                        cgroup_udp6_sendmsg | cgroup_udp4_recvmsg |\n" \
-	"                        cgroup_udp6_recvmsg | cgroup_sysctl |\n" \
-	"                        cgroup_getsockopt | cgroup_setsockopt |\n" \
-	"                        cgroup_inet_sock_release }"
+	"                        cgroup_inet6_connect | cgroup_unix_connect |\n" \
+	"                        cgroup_inet4_getpeername | cgroup_inet6_getpeername |\n" \
+	"                        cgroup_unix_getpeername | cgroup_inet4_getsockname |\n" \
+	"                        cgroup_inet6_getsockname | cgroup_unix_getsockname |\n" \
+	"                        cgroup_udp4_sendmsg | cgroup_udp6_sendmsg |\n" \
+	"                        cgroup_unix_sendmsg | cgroup_udp4_recvmsg |\n" \
+	"                        cgroup_udp6_recvmsg | cgroup_unix_recvmsg |\n" \
+	"                        cgroup_sysctl | cgroup_getsockopt |\n" \
+	"                        cgroup_setsockopt | cgroup_inet_sock_release }"
 
 static unsigned int query_flags;
 static struct btf *btf_vmlinux;
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 8443a149dd17..7ec4f5671e7a 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2475,9 +2475,10 @@ static int do_help(int argc, char **argv)
 		"                 sk_reuseport | flow_dissector | cgroup/sysctl |\n"
 		"                 cgroup/bind4 | cgroup/bind6 | cgroup/post_bind4 |\n"
 		"                 cgroup/post_bind6 | cgroup/connect4 | cgroup/connect6 |\n"
-		"                 cgroup/getpeername4 | cgroup/getpeername6 |\n"
-		"                 cgroup/getsockname4 | cgroup/getsockname6 | cgroup/sendmsg4 |\n"
-		"                 cgroup/sendmsg6 | cgroup/recvmsg4 | cgroup/recvmsg6 |\n"
+		"                 cgroup/connect_unix | cgroup/getpeername4 | cgroup/getpeername6 |\n"
+		"                 cgroup/getpeername_unix | cgroup/getsockname4 | cgroup/getsockname6 |\n"
+		"                 cgroup/getsockname_unix | cgroup/sendmsg4 | cgroup/sendmsg6 |\n"
+		"                 cgroup/sendmsg°unix | cgroup/recvmsg4 | cgroup/recvmsg6 | cgroup/recvmsg_unix |\n"
 		"                 cgroup/getsockopt | cgroup/setsockopt | cgroup/sock_release |\n"
 		"                 struct_ops | fentry | fexit | freplace | sk_lookup }\n"
 		"       ATTACH_TYPE := { sk_msg_verdict | sk_skb_verdict | sk_skb_stream_verdict |\n"
-- 
2.41.0


