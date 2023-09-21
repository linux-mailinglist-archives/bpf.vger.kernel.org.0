Return-Path: <bpf+bounces-10535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 887ED7A98D0
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15843B20E79
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 17:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B8D3CCE9;
	Thu, 21 Sep 2023 17:22:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCBC18C3D;
	Thu, 21 Sep 2023 17:22:34 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966654BBD1;
	Thu, 21 Sep 2023 10:16:29 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9338e4695so20405721fa.2;
        Thu, 21 Sep 2023 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316588; x=1695921388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwZeEcQe5Ghk+y4eWbTxAfyAVnodMDMxpvZEaBs+Ays=;
        b=HJlhrOa9+D16vu33mxWDJfEF4m4thM0yvblNI9XXKBY/z3bzeBtNsYpbBiOs3eoHqE
         a+UtNUOyLJmD2H4zGK3H779vQurcJJfDyD++nwhKvIKxnvanvrhoklV3U8sG1zotvSdB
         EOpmHfDBSuHoZanF91LWLJH8QzPvAo8x8GTkJ6BSoOCzw2rIKuQj3ztNEqbbRterFfkB
         mCVYo10jufix3SOEZp/e/kkyJP0KGqoet+0gNGo+8uraIAW0t7FalBzjympILMTV4mBS
         vLqwAMS05VO3vNQJJhTEq1bZAv8TB9H7sR+nupCa+gxuQb0diDODUz68QwCdh91rqPZ5
         Kd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316588; x=1695921388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwZeEcQe5Ghk+y4eWbTxAfyAVnodMDMxpvZEaBs+Ays=;
        b=hqb92bBOIQmLTO6HjLWETFkpZZem7XUckU9FsgyDvsr7sBIFtCsgWrzk/ZVqNrDjSK
         RHZddogZ7cdSMlCQ9+LJtQeyHRKl7atVuj/stGEBZd8I7yPRZp7Tk0N7YlxOMvCPld+C
         S6Qpm3UrbsKDv/nl9y3JIBpIilvtL3J7wqWY716Mbwl0njPMuIzhT7CwcpnwdLy0DLuT
         wRrxy0PTUEVg87lH31x9q3FVNqBGQ5XI3wEUE7477+tLs6o+CfhaNDcPW/+BqdY8PkWX
         TJgUH7NQcQfENMKFtrzY7BpQvsJw7h5Rr789dN9RH1hI9+ukwOkc0Hx1mtRJ/zC7d4Nf
         pFeA==
X-Gm-Message-State: AOJu0YwaH5E7rj8Ak0xnq5wPtAz8DDKce/NeW17h8uIJGEJQBZGL/8C+
	9gDdgQ0OET07y7MFvTIZRwEbnkvNVXjPf73hGSM=
X-Google-Smtp-Source: AGHT+IGmJuCGZnPWCCq4h8WIL2/2EgXo9+3Sy7jRkQ8Tol4UQZLKbWTto5COZixVGc31fKuhI+z3fA==
X-Received: by 2002:a2e:7a0f:0:b0:2c0:298d:32d0 with SMTP id v15-20020a2e7a0f000000b002c0298d32d0mr4820556ljc.43.1695298175190;
        Thu, 21 Sep 2023 05:09:35 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::4:2a59])
        by smtp.googlemail.com with ESMTPSA id gx10-20020a170906f1ca00b0099cb349d570sm952258ejb.185.2023.09.21.05.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 05:09:34 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v5 6/9] bpftool: Add support for cgroup unix socket address hooks
Date: Thu, 21 Sep 2023 14:09:08 +0200
Message-ID: <20230921120913.566702-7-daan.j.demeyer@gmail.com>
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

Add the necessary plumbing to hook up the new cgroup unix sockaddr
hooks into bpftool.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 .../bpf/bpftool/Documentation/bpftool-cgroup.rst | 16 +++++++++++++---
 tools/bpf/bpftool/Documentation/bpftool-prog.rst |  8 +++++---
 tools/bpf/bpftool/bash-completion/bpftool        | 14 +++++++-------
 tools/bpf/bpftool/cgroup.c                       | 16 +++++++++-------
 tools/bpf/bpftool/prog.c                         |  7 ++++---
 5 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
index bd015ec9847b..3e4f5ff24208 100644
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
index dcae81bd27ed..e067b2fbb866 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -47,9 +47,11 @@ PROG COMMANDS
 |		**cgroup/sock** | **cgroup/dev** | **lwt_in** | **lwt_out** | **lwt_xmit** |
 |		**lwt_seg6local** | **sockops** | **sk_skb** | **sk_msg** | **lirc_mode2** |
 |		**cgroup/bind4** | **cgroup/bind6** | **cgroup/post_bind4** | **cgroup/post_bind6** |
-|		**cgroup/connect4** | **cgroup/connect6** | **cgroup/getpeername4** | **cgroup/getpeername6** |
-|               **cgroup/getsockname4** | **cgroup/getsockname6** | **cgroup/sendmsg4** | **cgroup/sendmsg6** |
-|		**cgroup/recvmsg4** | **cgroup/recvmsg6** | **cgroup/sysctl** |
+|		**cgroup/connect4** | **cgroup/connect6** | **cgroup/connectun** |
+|		**cgroup/getpeername4** | **cgroup/getpeername6** | **cgroup/getpeernameun** |
+|		**cgroup/getsockname4** | **cgroup/getsockname6** | **cgroup/getsocknameun** |
+|		**cgroup/sendmsg4** | **cgroup/sendmsg6** | **cgroup/sendmsgun** |
+|		**cgroup/recvmsg4** | **cgroup/recvmsg6** | **cgroup/recvmsgun** | **cgroup/sysctl** |
 |		**cgroup/getsockopt** | **cgroup/setsockopt** | **cgroup/sock_release** |
 |		**struct_ops** | **fentry** | **fexit** | **freplace** | **sk_lookup**
 |	}
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 085bf18f3659..8565da81cfaf 100644
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
+                                cgroup/connect4 cgroup/connect6 cgroup/connectun \
+                                cgroup/getpeername4 cgroup/getpeername6 cgroup/getpeernameun \
+                                cgroup/getsockname4 cgroup/getsockname6 cgroup/getsocknameun \
+                                cgroup/sendmsg4 cgroup/sendmsg6 cgroup/sendmsgun \
+                                cgroup/recvmsg4 cgroup/recvmsg6 cgroup/recvmsgun \
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
index 8443a149dd17..64f80717b5c5 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2475,9 +2475,10 @@ static int do_help(int argc, char **argv)
 		"                 sk_reuseport | flow_dissector | cgroup/sysctl |\n"
 		"                 cgroup/bind4 | cgroup/bind6 | cgroup/post_bind4 |\n"
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


