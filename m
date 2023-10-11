Return-Path: <bpf+bounces-11954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 611317C5D08
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 20:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D77282943
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 18:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B952A12E75;
	Wed, 11 Oct 2023 18:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJL+POID"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F8D41204;
	Wed, 11 Oct 2023 18:51:35 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58FCE6;
	Wed, 11 Oct 2023 11:51:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3296b3f03e5so133485f8f.2;
        Wed, 11 Oct 2023 11:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697050291; x=1697655091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOo9TydguJdU9EI/0Wd4N0A1MV15H9FmJHUdXa6nEsw=;
        b=VJL+POIDI8fj26GMEUu4v5qYsL6kGTO4Yu3RnzxlRC7LdjIvk9krFUhGB65vfZjMt0
         L7/WsPgAF+Y6CWULVMHMx8YJdNAWnTUZJGXJYlRdQyCNq3YEwVf8t9p65wf7HFcnobDE
         kyD3gwvbnX3ByY/GK1jq5/WPXnUf1YyJwcaUvvUL+oPDUB0yLR944wf+UrBdalCxQvki
         vWis1wVLjArbw6tt3fNaKoCY/9YK97GS12FAjVDd3dGmi1j34HFz/z89EyUo55ZtWlZ0
         LqASnSeWwyr7LX2262Lnc1XK4sWsX+2SwWt1RgTrkcDujzN6CQ+cShn4jE7uFKoxqM0k
         zqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050291; x=1697655091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOo9TydguJdU9EI/0Wd4N0A1MV15H9FmJHUdXa6nEsw=;
        b=VxbOrotOnerXpbpqJbWzsnxSR1NXKzaqRGDvoO+3xQXKbzCFpdzSyi+OhwQewbLzEr
         HWAiQbmU2Vmh/PTGtEaysiNEThmZ9JAw8MXaX5VmC4Lc6uRzEI9XdnLUrrpzoX+Ep92L
         otu+VNHO8N6erRUifQKxbv8Hlmpb9jrnKy9CflryFoLCzOgSH4E4yIu3s6x5sop1IrQU
         I5Cuhy7ZFje+NzmXRWivaIMblJNd1RKl00S9yuOVMm3NH76alSpBSQ5Zot6yqPq2OW1h
         XMiz3nlw5rLSJTdJWRJXtbQ91EfSiakIQW4GbUUSwWU+3jgsUcGLioiQ8bruyk6/LRUg
         NFEQ==
X-Gm-Message-State: AOJu0YxWLHdEUjT8+khKYpOyTkmYrtcf09AG/DI+7qL3sfyTd2fBt2Nn
	6rQef1HEI/ceNvEmao9bewp3sOREHMTpOPIl
X-Google-Smtp-Source: AGHT+IGFH0JsyUllWiQILCm7xg3h45QNa4q3Y9L7pg+gQpeF6f2R5jXQ0HeSbb+VAyzYrD37+NucKg==
X-Received: by 2002:a05:6000:3c1:b0:329:6bdc:5a60 with SMTP id b1-20020a05600003c100b003296bdc5a60mr14361886wrg.12.1697050290924;
        Wed, 11 Oct 2023 11:51:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id h9-20020a5d6889000000b0031c52e81490sm16424484wru.72.2023.10.11.11.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 11:51:30 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org,
	Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v11 6/9] bpftool: Add support for cgroup unix socket address hooks
Date: Wed, 11 Oct 2023 20:51:08 +0200
Message-ID: <20231011185113.140426-7-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011185113.140426-1-daan.j.demeyer@gmail.com>
References: <20231011185113.140426-1-daan.j.demeyer@gmail.com>
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


