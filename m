Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3893D649071
	for <lists+bpf@lfdr.de>; Sat, 10 Dec 2022 20:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiLJTgm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Dec 2022 14:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiLJTgl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Dec 2022 14:36:41 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74BF1740B
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 11:36:38 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n7so2201779wms.3
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 11:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9guGLAv71C+0I5Ij6Uvknh/h+f0s2xjehD6bVfW1DY0=;
        b=md7+xDdmPfGtprC9V33fheVA1Cn5xtZgRGvn6ggz7zYTD9CpL26ggSS4KTEnBmPSWf
         sYmxMjgOeTBRQ4aTMgOeC3UDcmx2z51XrEhfLpEqnpK6cA7afWTRRnJfDs1FMaMQ/Q0O
         KDOZflRLFMGUwIHQ5pAtp3YDxYEE6PNKMzxEse8hSgI+X43vdv3wMb1vbN2H7hdmHon1
         uFo+rC8FYL+3MvG3zxKqhNXtp2+vRjiRi07S0WBMhEWR0sFdfVTo2G88h9N//We9DVkD
         2jBjv2eRdSo269yJA9/7A2/H5652gEf1ZruL5l/l71yBXzvS8QBhjVApEqSvt2VtFSF0
         OA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9guGLAv71C+0I5Ij6Uvknh/h+f0s2xjehD6bVfW1DY0=;
        b=RDrOsVsibm6YrDDv5S7ZglXQ52AHuKQqNGdKvDkm7Clrw1QMY6HI8fgFNC/i6PDrag
         xwnGgfTc7IYHkqcLeHE8YWg8+ZXnOHntmndbRxl7i/v6K9kyOCw+lYST+trFX8YKM1+X
         gQTOYhLWOCPNmTWzm3TUZbCcX67VV9u88ri1rOC494jC8/BwurUYdAGVmKXHWI1t/KN0
         igoCxbbZmRk1c7WvHKlZqoGa366EIDgIt9hjcfJemzeoXOj1w6wHOpkULGcNdCSWDd+w
         rkNaYIGzpBewSygPpG5cIpdwb3WDPZjfhWiAiIc+tBK55JZ8DG5vYZneyjXT3RDsCaZM
         p1eA==
X-Gm-Message-State: ANoB5pl1Ypkslv68LUEbcxDl7rlf/SdtWMW9n0dy56bqD700vNQV8BWv
        qLTPKaz8TLgceQhtTnnxoig2kMHqwUU08w==
X-Google-Smtp-Source: AA0mqf55EMUXB4C5+Egl8fzAqDA07joFSd6C9JIoksHZ/PhYcil4lsbffSTPLGLnFgmZu+io6VA07g==
X-Received: by 2002:a7b:c053:0:b0:3cf:7385:677f with SMTP id u19-20020a7bc053000000b003cf7385677fmr8519343wmc.35.1670700996837;
        Sat, 10 Dec 2022 11:36:36 -0800 (PST)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::5:366e])
        by smtp.googlemail.com with ESMTPSA id az18-20020adfe192000000b002423a5d7cb1sm4584676wrb.113.2022.12.10.11.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 11:36:36 -0800 (PST)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>, martin.lau@linux.dev,
        kernel-team@meta.com
Subject: [PATCH bpf-next v2 6/9] libbpf: Add support for cgroup unix socket address hooks
Date:   Sat, 10 Dec 2022 20:35:56 +0100
Message-Id: <20221210193559.371515-7-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
References: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

---
 tools/lib/bpf/libbpf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2a82f49ce16f..8924404b9185 100644
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
@@ -8590,16 +8596,22 @@ static const struct bpf_sec_def section_defs[] = {
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
2.38.1

