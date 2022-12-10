Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CF2649070
	for <lists+bpf@lfdr.de>; Sat, 10 Dec 2022 20:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiLJTgm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Dec 2022 14:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiLJTgk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Dec 2022 14:36:40 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00A017050
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 11:36:39 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id f18so8298972wrj.5
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 11:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlLqVAIfKwkNNYEYIe5HuOjNd0Gyl2+PjlkcPCojwO8=;
        b=ozXSq0FRayA/ZtFciPqK9TY4aXq2dcWv561apod8FesBsE/SqEACFg2kUqiWFiA5hI
         IgngL8+2aevJ4aAye+N1a90PsVPRmwodPrnyF2s1F24dLcLvnJl2WJusix79ZuYLE0s2
         qj/HecV93zzl42hW6oFB4LbSW1ICM02vGnbMdl4+EjJkUtb4gUyQH7a/vggdfBySblwU
         pAGdabClatnsTVgYifD8OR0VnUGXmgOY8GniH2hx+lIkV7mlw0Ljs7681xCYYlEBXoXk
         lZr5dN8kzdq6dvJsJDZ6mG/ukbCJhrLA2HZP1Pk+FbD0QbegHUCJQv06SSS7aoZycSYC
         yg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlLqVAIfKwkNNYEYIe5HuOjNd0Gyl2+PjlkcPCojwO8=;
        b=0VjTZEZrc9PK48Vzl2pvlYEjMQ2XtP8HFRBQWKdZar5H2uv3z/nL8l21IPCEcCvQQV
         1jvLXcMwie9lCMKAsBHtElKfbv+l/OaGUe7G/wnCwk7hHkMumdWuXldZv4wI5xm3AMPM
         Br2PVNWN0qaLQjMDId0AbTmb0ifK7/kvFfu5KGj6g9rBZWsc/8nQ5+kTTq3TfUdxy6lg
         rcMddNRL1x2XrhkA+NWf+PX5ciX+njGJFXzu7QX4fnQ5I4sdAcnVxNgXdEH0EYUOX/Ih
         5iMiRyzoi4JOqQN02f8hLHxImzjiPhnMsfwAhWesQxH/y1s+lnj5WjkV8c9C4LEhPRqv
         EeyA==
X-Gm-Message-State: ANoB5pmmFuvTNvLW/ICRfCX++jXp99r/tVzgzmiAYgMKAth/OkU5/0IP
        btjb6MBup3hxsVK3Lzut1AOpX0NjqekRdw==
X-Google-Smtp-Source: AA0mqf4rasznjrlg6WhUJTvJlb6cDOPH1fCwQhrnLohjbPkViFkwCG3MiGmhZ4eJf9gURGreRThdcg==
X-Received: by 2002:a05:6000:156c:b0:241:fbef:29b5 with SMTP id 12-20020a056000156c00b00241fbef29b5mr12876442wrz.13.1670700997915;
        Sat, 10 Dec 2022 11:36:37 -0800 (PST)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::5:366e])
        by smtp.googlemail.com with ESMTPSA id az18-20020adfe192000000b002423a5d7cb1sm4584676wrb.113.2022.12.10.11.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 11:36:37 -0800 (PST)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>, martin.lau@linux.dev,
        kernel-team@meta.com
Subject: [PATCH bpf-next v2 7/9] bpftool: Add support for cgroup unix socket address hooks
Date:   Sat, 10 Dec 2022 20:35:57 +0100
Message-Id: <20221210193559.371515-8-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
References: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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
index b46a998d8f8d..3a57ca208a1c 100644
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
index c90b756945e3..94f48740fd2a 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -1065,19 +1065,25 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
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
2.38.1

