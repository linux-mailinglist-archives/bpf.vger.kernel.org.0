Return-Path: <bpf+bounces-8904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E5A78C242
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 12:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B84F1C209CE
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 10:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC8D1549A;
	Tue, 29 Aug 2023 10:19:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3BF14F72
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 10:19:29 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE382CDC
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 03:19:20 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4ff8f2630e3so6530718e87.1
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 03:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693304358; x=1693909158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gjtu24o7Nu3qyAwAJAI81HRCZwxMSVKlzaLplpEWBs=;
        b=lJ3LiAO1ugwf6fbtbffRiHSa1Ak3N+7KqmBXfSIhDj6loifIQlxPVS2UdAGVYlx8z7
         kmC88cbed89DYENLyNJNiJzB3HDTN8DXg8TzXOGNJ3Sy2bVRW0cVmNJz2+veGjzreo3c
         qwxel9Jv5gLvjnnWBidD/T/ptFtrrY3BzllyPFVhtlcYM66E3h9j4uLo4R874BMwxodD
         qV0QuPBDwiSRWk0i+sr+ZwQaerYtfKnavs1+L9AbGc9JWqaBAwyO8UA40KPEoNrHmL1r
         Q2Jc95ehOWkCvTWAgHtL+ntpW5F1OQHeRUiFQgrP0A24LTe5jrqjcIpTkwDGNGJ5WqzH
         0Y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693304358; x=1693909158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gjtu24o7Nu3qyAwAJAI81HRCZwxMSVKlzaLplpEWBs=;
        b=ITJcOOlg4D7uO2AV8BBb3UrD4IyWqufKtHzOiKF0Ibca3gLAruPvoZfcZAzEq+o3k6
         4W2jcrbgD8O4LtIrWLGfep1+XX6mraYWB3jPd6E/KZBEq9EhMlFJmL8UXb857LPV7UPJ
         g0BUthFDlly08CEB6Cj69jiNA0Dz8bFCDCB6VZMUQaWMK8l7Lt3v9/iuRHazpFbDLQCf
         cPKdxYsg+xxXadZ9EFFEChX+WIj1g1p2UXDDHTzjUHhxcGiJI1MK5yeVUdg5ehNmBqL2
         sNAJ62B3UFBTsHIeTa310vQ33RbN2x9l/efbq13SQt/ELzuRAaQF9M+mUPA0mnUVZGCa
         kKzg==
X-Gm-Message-State: AOJu0YxgByWoVWkeg9uBOAcCj+EJF8zZU3UTUIO9EfREoeGZse6Tfho3
	HmdkZfwihKdscvwvVuhRMbeZnDeImPuJjzQ0FRY=
X-Google-Smtp-Source: AGHT+IG7iksFjjsIl9PS+kDQX331VAmNTcJzb1JgaLbUz1JSR6Gzcrls+bKzHEyC8/bGo5lYPu7fiQ==
X-Received: by 2002:a19:385e:0:b0:4fb:bef0:948e with SMTP id d30-20020a19385e000000b004fbbef0948emr15984553lfj.5.1693304358523;
        Tue, 29 Aug 2023 03:19:18 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com (2001-1c05-3310-3500-67a4-023c-67c4-b186.cable.dynamic.v6.ziggo.nl. [2001:1c05:3310:3500:67a4:23c:67c4:b186])
        by smtp.googlemail.com with ESMTPSA id f15-20020a50ee8f000000b0051e2670d599sm5545606edr.4.2023.08.29.03.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 03:19:17 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 6/9] bpftool: Add support for cgroup unix socket address hooks
Date: Tue, 29 Aug 2023 12:18:30 +0200
Message-ID: <20230829101838.851350-7-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829101838.851350-1-daan.j.demeyer@gmail.com>
References: <20230829101838.851350-1-daan.j.demeyer@gmail.com>
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

Add the necessary plumbing to hook up the new cgroup unix sockaddr
hooks into bpftool.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 .../bpftool/Documentation/bpftool-cgroup.rst  | 21 ++++++++++++++-----
 .../bpftool/Documentation/bpftool-prog.rst    | 10 +++++----
 tools/bpf/bpftool/bash-completion/bpftool     | 14 ++++++-------
 tools/bpf/bpftool/cgroup.c                    | 17 ++++++++-------
 tools/bpf/bpftool/prog.c                      |  9 ++++----
 5 files changed, 44 insertions(+), 27 deletions(-)

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
diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index dcae81bd27ed..886529dd60f0 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -46,10 +46,12 @@ PROG COMMANDS
 |		**tracepoint** | **raw_tracepoint** | **xdp** | **perf_event** | **cgroup/skb** |
 |		**cgroup/sock** | **cgroup/dev** | **lwt_in** | **lwt_out** | **lwt_xmit** |
 |		**lwt_seg6local** | **sockops** | **sk_skb** | **sk_msg** | **lirc_mode2** |
-|		**cgroup/bind4** | **cgroup/bind6** | **cgroup/post_bind4** | **cgroup/post_bind6** |
-|		**cgroup/connect4** | **cgroup/connect6** | **cgroup/getpeername4** | **cgroup/getpeername6** |
-|               **cgroup/getsockname4** | **cgroup/getsockname6** | **cgroup/sendmsg4** | **cgroup/sendmsg6** |
-|		**cgroup/recvmsg4** | **cgroup/recvmsg6** | **cgroup/sysctl** |
+|		**cgroup/bind4** | **cgroup/bind6** | **cgroup/bindun** | **cgroup/post_bind4** |
+|		**cgroup/post_bind6** | **cgroup/connect4** | **cgroup/connect6** | **cgroup/connectun** |
+|		**cgroup/getpeername4** | **cgroup/getpeername6** | **cgroup/getpeernameun** |
+|		**cgroup/getsockname4** | **cgroup/getsockname6** | **cgroup/getsocknameun** |
+|		**cgroup/sendmsg4** | **cgroup/sendmsg6** | **cgroup/sendmsgun** |
+|		**cgroup/recvmsg4** | **cgroup/recvmsg6** | **cgroup/recvmsgun** | **cgroup/sysctl** |
 |		**cgroup/getsockopt** | **cgroup/setsockopt** | **cgroup/sock_release** |
 |		**struct_ops** | **fentry** | **fexit** | **freplace** | **sk_lookup**
 |	}
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 085bf18f3659..2946749e65bb 100644
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
+                                cgroup/bind4 cgroup/bind6 cgroup/bindun \
+                                cgroup/connect4 cgroup/connect6 cgroup/connectun \
+                                cgroup/getpeername4 cgroup/getpeername6 cgroup/getpeernameun \
+                                cgroup/getsockname4 cgroup/getsockname6 cgroup/getsocknameun \
+                                cgroup/sendmsg4 cgroup/sendmsg6 cgroup/sendmsgun \
+                                cgroup/recvmsg4 cgroup/recvmsg6 cgroup/recvmsgun \
                                 cgroup/post_bind4 cgroup/post_bind6 \
                                 cgroup/sysctl cgroup/getsockopt \
                                 cgroup/setsockopt cgroup/sock_release struct_ops \
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
 
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 8443a149dd17..8bfd839cee7a 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2473,11 +2473,12 @@ static int do_help(int argc, char **argv)
 		"                 cgroup/sock | cgroup/dev | lwt_in | lwt_out | lwt_xmit |\n"
 		"                 lwt_seg6local | sockops | sk_skb | sk_msg | lirc_mode2 |\n"
 		"                 sk_reuseport | flow_dissector | cgroup/sysctl |\n"
-		"                 cgroup/bind4 | cgroup/bind6 | cgroup/post_bind4 |\n"
+		"                 cgroup/bind4 | cgroup/bind6 | cgroup/bindun | cgroup/post_bind4 |\n"
 		"                 cgroup/post_bind6 | cgroup/connect4 | cgroup/connect6 |\n"
-		"                 cgroup/getpeername4 | cgroup/getpeername6 |\n"
-		"                 cgroup/getsockname4 | cgroup/getsockname6 | cgroup/sendmsg4 |\n"
-		"                 cgroup/sendmsg6 | cgroup/recvmsg4 | cgroup/recvmsg6 |\n"
+		"                 cgroup/connectun | cgroup/getpeername4 | cgroup/getpeername6 |\n"
+		"                 cgroup/getpeernameun | cgroup/getsockname4 | cgroup/getsockname6 |\n"
+		"                 cgroup/getsocknameun | cgroup/sendmsg4 | cgroup/sendmsg6 |\n"
+		"                 cgroup/sendmsgun | cgroup/recvmsg4 | cgroup/recvmsg6 | cgroup/recvmsgun |\n"
 		"                 cgroup/getsockopt | cgroup/setsockopt | cgroup/sock_release |\n"
 		"                 struct_ops | fentry | fexit | freplace | sk_lookup }\n"
 		"       ATTACH_TYPE := { sk_msg_verdict | sk_skb_verdict | sk_skb_stream_verdict |\n"
-- 
2.41.0


