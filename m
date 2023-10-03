Return-Path: <bpf+bounces-11262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 637C87B6589
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 11:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D3C54281841
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 09:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827961DA21;
	Tue,  3 Oct 2023 09:30:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4621101C5;
	Tue,  3 Oct 2023 09:30:47 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C214AB4;
	Tue,  3 Oct 2023 02:30:45 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9b275afb6abso900964766b.1;
        Tue, 03 Oct 2023 02:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696325444; x=1696930244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOo9TydguJdU9EI/0Wd4N0A1MV15H9FmJHUdXa6nEsw=;
        b=ksTofwMfDuWYxdZ0UER+qoYHWa6fzMmboaWWyNGG15j9BAd8CXAYkl/VwifE8m3MZN
         RKu/NVpD5BwiRhUrrLMNt2SJHMjTv97CQWLpvQ0NV+Jn0kSuEoYpW7ieldi41kykk3Wm
         CH+gtHalIDhBOBj4ya6Wth1AEizSoa5X+F1zN3/KdZlP4YyuRu8oqbr65+7F3KJVCZp7
         dhBhdSO610g5+A2a6LNBTXEUCjcH0TJ7Wm8+VMEIqnHNSjmK0X4qz750WsZpsIusWCBf
         GqU4tPbuTZ3sVNG4kpuOsP9JEdZIV36mTDeDPfe7SN5JCPw5qLmaV/pqXQdHyKd4ODvF
         ow1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696325444; x=1696930244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOo9TydguJdU9EI/0Wd4N0A1MV15H9FmJHUdXa6nEsw=;
        b=YFFtJjAEkaQ4hVOSoqHM9O3swHp+0rmZYu+r3Zgy2i6bvAfv+trMEL0uf0BDRbvXHU
         U952+ZyUWkAIWIPRBlXZ6xevHT7qxGRbzfYSFaQJ/dSSyFAtoab+RNA1dRvmIuHQWgkB
         VQxuOEiW/3QCIUjyeN432cLDkxF0WLHcLcPRrcxQ6EWZAfPW1vtXEfzsn5c4mpAlfRX7
         6k4WPBTRfqR6K3LPh0WFe6tKDVKd6oFm0SBLLKTBnitzZaabscWpi9FbvIFk2EXBa9qh
         RisfSDwnmN3g7MVganr22pnqT9Bnptp2CidnklGqW7RL98P/Yq3sU5nJoz5r3SJYjRFV
         imdQ==
X-Gm-Message-State: AOJu0YyuxUu4OwQI6rtN7hXOCOsvsQZl7N8zvOSZOFXYFb1vzXjgzoup
	0HmzCOX2Sh5G89cmkpXXYPVPAPeTbZI5nNPB
X-Google-Smtp-Source: AGHT+IFYkrlUe5PGD+eP2JNPljONAxRUE69MVtK5WUfbSntxAaZ9g4bgY+uwpmXkgVgbypbjbapkyQ==
X-Received: by 2002:a17:907:3e12:b0:9a5:7dec:fab9 with SMTP id hp18-20020a1709073e1200b009a57decfab9mr1917557ejc.9.1696325443830;
        Tue, 03 Oct 2023 02:30:43 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com (2001-1c05-3310-3500-15f4-3ba0-176b-cb00.cable.dynamic.v6.ziggo.nl. [2001:1c05:3310:3500:15f4:3ba0:176b:cb00])
        by smtp.googlemail.com with ESMTPSA id g5-20020a170906594500b0098f33157e7dsm749851ejr.82.2023.10.03.02.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 02:30:43 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org,
	Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v7 6/9] bpftool: Add support for cgroup unix socket address hooks
Date: Tue,  3 Oct 2023 11:30:20 +0200
Message-ID: <20231003093025.475450-7-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003093025.475450-1-daan.j.demeyer@gmail.com>
References: <20231003093025.475450-1-daan.j.demeyer@gmail.com>
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


