Return-Path: <bpf+bounces-10900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAFE7AF526
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 22:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 4D48C1C208C2
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 20:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087FB4BDBF;
	Tue, 26 Sep 2023 20:28:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562AF4B228;
	Tue, 26 Sep 2023 20:28:18 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE50B193;
	Tue, 26 Sep 2023 13:28:15 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c007d6159aso157427581fa.3;
        Tue, 26 Sep 2023 13:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695760094; x=1696364894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1T04acF0V6Ztt61Zmk4B2oicuSNJ6Rckk4haOquRPo=;
        b=TjAXc/n1RFqy73QNBZStLid/+ClV0Dr1odzR28QM43CjViyPuXotnKRGJASN5eF5+j
         jZbj+NGU0TMboIR6lUIKCNYx7cfYHEVmBsBHCpJWeExsBFNePCxX0AuywOCjRj4LQuuv
         jpSUqXRakY7cxWm5pYmI+pxbBAd+/nHhNfPaFg65nqCC0ok4OPQICb0r8joMxbUoEqQX
         1/d6yI9xtXAKW0K6BmG1nQD7xJg/mqgLo+1LP1xAw2ZZo2M8JMpIQ4R3nBjZHtRqsZtk
         Q47TIpg/7bgenDEN/NSDVD94EPZVsY+lgt8+igcILOh4OcEjETtgUlgMNwnXL0K8sukA
         xQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695760094; x=1696364894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1T04acF0V6Ztt61Zmk4B2oicuSNJ6Rckk4haOquRPo=;
        b=OfMoWU7+RU+M+wWEYIVQCZEsdLU9txzECMJR8WdEuyv/FmbOARhKS2sysah6EM9HxI
         C7H+alQAl0cLbfK+beYiMRKJ4l6jzenadtCe2ovfN8ge+FD1KVBfvhJnbgW6vQGvMRdB
         CQQstCLMkvg2NWbGzSm/agMinqTpcEQYxOnKmtotxE0vFwcKrB5K+kLlzTDBjURaHUUv
         Sk05b+73gl+qPymmDQyQZemy1ZZdq5e3dnBo5F0fLcK03ecDEu3WZMMDgFSH1YxXrdtn
         +WhS3CGIhIXW/zFLUamETafQgcBf6xYb5X8mGBzY+wTF2o6Tt5Qo65zY+uY0C5xeOhJY
         2M2A==
X-Gm-Message-State: AOJu0YwrLhzNbHQKcqeGwXhju4Z+UTIY+yc1M4IE6uaQkUvWqx6ArboZ
	qM9SExarL+pCLIeaU/Q19zjubys8yEyykuLv
X-Google-Smtp-Source: AGHT+IF6ErQmkbjZkrOCfFd9H+d7bNTuhvjwIhmbY+VgT16ftRsTNBQzSEXOEaAo51u0sExAmhMsBQ==
X-Received: by 2002:a2e:7214:0:b0:2bc:f39b:d1a8 with SMTP id n20-20020a2e7214000000b002bcf39bd1a8mr101400ljc.46.1695760093594;
        Tue, 26 Sep 2023 13:28:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id c19-20020a170906529300b00992e94bcfabsm8204664ejm.167.2023.09.26.13.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 13:28:13 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v6 6/9] bpftool: Add support for cgroup unix socket address hooks
Date: Tue, 26 Sep 2023 22:27:45 +0200
Message-ID: <20230926202753.1482200-7-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926202753.1482200-1-daan.j.demeyer@gmail.com>
References: <20230926202753.1482200-1-daan.j.demeyer@gmail.com>
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
index bd015ec9847b..a7e16f541273 100644
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
+		  **connectun** call to connect(2) for a unix socket (since 6.7);
 		  **sendmsg4** call to sendto(2), sendmsg(2), sendmmsg(2) for an
 		  unconnected udp4 socket (since 4.18);
 		  **sendmsg6** call to sendto(2), sendmsg(2), sendmmsg(2) for an
 		  unconnected udp6 socket (since 4.18);
+		  **sendmsgun** call to sendto(2), sendmsg(2), sendmmsg(2) for
+		  an unconnected unix socket (since 6.7);
 		  **recvmsg4** call to recvfrom(2), recvmsg(2), recvmmsg(2) for
 		  an unconnected udp4 socket (since 5.2);
 		  **recvmsg6** call to recvfrom(2), recvmsg(2), recvmmsg(2) for
 		  an unconnected udp6 socket (since 5.2);
+		  **recvmsgun** call to recvfrom(2), recvmsg(2), recvmmsg(2) for
+		  an unconnected unix socket (since 6.7);
 		  **sysctl** sysctl access (since 5.2);
 		  **getsockopt** call to getsockopt (since 5.3);
 		  **setsockopt** call to setsockopt (since 5.3);
 		  **getpeername4** call to getpeername(2) for an inet4 socket (since 5.8);
 		  **getpeername6** call to getpeername(2) for an inet6 socket (since 5.8);
+		  **getpeernameun** call to getpeername(2) for a unix socket (since 6.7);
 		  **getsockname4** call to getsockname(2) for an inet4 socket (since 5.8);
 		  **getsockname6** call to getsockname(2) for an inet6 socket (since 5.8).
+		  **getsocknameun** call to getsockname(2) for a unix socket (since 6.7);
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


