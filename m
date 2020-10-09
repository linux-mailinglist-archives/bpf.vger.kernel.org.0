Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C6228819D
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 07:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgJIFJW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 01:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgJIFJW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 01:09:22 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80DDC0613D4
        for <bpf@vger.kernel.org>; Thu,  8 Oct 2020 22:09:21 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id l4so7904488ota.7
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2020 22:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tehnerd-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vjO1y5e0L8se8ZedRLXM2SIg3QSKBrPn3iirYWr5Tqc=;
        b=XOcFA2lJvqhBOl941BM2a01Kmv2JK02t1eExX9D2eqVXySKvi4DRIDf2mLHkqZCV7Y
         FZMBiyuDaP1ZCCH4de1P0PoSLgaSWAWaM2PaiMZGIpyAseWKjSwYscU0HKn3mY16L0rz
         vfQUEyn3IzTKhAT8yKutdRxnuFbaRGE1f5YdK3NKIFr2O5gO6CJYPjHhw3mgbDLlyBBy
         1/G5DfaA0u/pJD1QfVcTWaYxuDeUHtUlkAo5Mcvc5UuUQv34+V1GEoO/Agz0Ao4tUdt/
         /pCMukRxoMG6/nWqp1mhac7uYLCG9hQwJXvhBwwQL0rStip0SZDrB4QmE9Rbg5H3sccQ
         /Zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vjO1y5e0L8se8ZedRLXM2SIg3QSKBrPn3iirYWr5Tqc=;
        b=fXvZMAD+2Kpg8PINIUkkSIanCO5jdutNFXPegZ0TQhJbEwncUSw2bDVx6P0KzTPETq
         uzmVQTsbNiCZkDk6xTYTD4jubVeU55oF8QxHLb0vFVwXuD33t1GFsSfAaHMpPY05AIUs
         byAydGM/UDGTzZLCotLMLx74guTmrV53aW0q/sUhsf0olpu03T4fGPyDkS4xKBbL3YtB
         5sSaQ+Y7GM5fr/q4GC7Qw0mzqG7+HSvx19I/HX7ZvTlkSoboOHyitpVblywGWYMRkXF9
         Qcx3LwfFrz7LrMHjir1oNxjb3RuocNWSRXDRmurQ5l0aPa699wXdD5P3J9AoRZ4snw9m
         9blA==
X-Gm-Message-State: AOAM532qYeuS0VammiAlPpnRfFx/X2F5or8iu9nWOi+s8BojPrDOqfL8
        StwOC/gFNhmpTGpuaryAemv/byJPyP1FVuCW
X-Google-Smtp-Source: ABdhPJzOWsR9WHavzmMqSGDcUrLOTnsw/pOuiWMICX3jGQhK6acz4bWAKMV3EjWtmA5pJNTjVlz7mQ==
X-Received: by 2002:a9d:a24:: with SMTP id 33mr6850682otg.305.1602220160802;
        Thu, 08 Oct 2020 22:09:20 -0700 (PDT)
Received: from nuke.localdomain (adsl-99-73-38-187.dsl.okcyok.sbcglobal.net. [99.73.38.187])
        by smtp.gmail.com with ESMTPSA id p8sm6350783oip.29.2020.10.08.22.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 22:09:20 -0700 (PDT)
From:   "Nikita V. Shirokov" <tehnerd@tehnerd.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org,
        "Nikita V. Shirokov" <tehnerd@tehnerd.com>
Subject: [PATCH bpf-next] bpf: add tcp_notsent_lowat bpf setsockopt
Date:   Fri,  9 Oct 2020 05:08:39 +0000
Message-Id: <20201009050839.222847-1-tehnerd@tehnerd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding support for TCP_NOTSENT_LOWAT sockoption
(https://lwn.net/Articles/560082/) in tcpbpf

Signed-off-by: Nikita V. Shirokov <tehnerd@tehnerd.com>
---
 include/uapi/linux/bpf.h                          |  2 +-
 net/core/filter.c                                 |  4 ++++
 tools/testing/selftests/bpf/progs/connect4_prog.c | 15 +++++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d83561e8cd2c..42d2df799397 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1698,7 +1698,7 @@ union bpf_attr {
  * 		  **TCP_CONGESTION**, **TCP_BPF_IW**,
  * 		  **TCP_BPF_SNDCWND_CLAMP**, **TCP_SAVE_SYN**,
  * 		  **TCP_KEEPIDLE**, **TCP_KEEPINTVL**, **TCP_KEEPCNT**,
- * 		  **TCP_SYNCNT**, **TCP_USER_TIMEOUT**.
+ *		  **TCP_SYNCNT**, **TCP_USER_TIMEOUT**, **TCP_NOTSENT_LOWAT**.
  * 		* **IPPROTO_IP**, which supports *optname* **IP_TOS**.
  * 		* **IPPROTO_IPV6**, which supports *optname* **IPV6_TCLASS**.
  * 	Return
diff --git a/net/core/filter.c b/net/core/filter.c
index 05df73780dd3..5da44b11e1ec 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4827,6 +4827,10 @@ static int _bpf_setsockopt(struct sock *sk, int level, int optname,
 				else
 					icsk->icsk_user_timeout = val;
 				break;
+			case TCP_NOTSENT_LOWAT:
+				tp->notsent_lowat = val;
+				sk->sk_write_space(sk);
+				break;
 			default:
 				ret = -EINVAL;
 			}
diff --git a/tools/testing/selftests/bpf/progs/connect4_prog.c b/tools/testing/selftests/bpf/progs/connect4_prog.c
index b1b2773c0b9d..b10e7fbace7b 100644
--- a/tools/testing/selftests/bpf/progs/connect4_prog.c
+++ b/tools/testing/selftests/bpf/progs/connect4_prog.c
@@ -128,6 +128,18 @@ static __inline int set_keepalive(struct bpf_sock_addr *ctx)
 	return 0;
 }
 
+static __inline int set_notsent_lowat(struct bpf_sock_addr *ctx)
+{
+	int lowat = 65535;
+
+	if (ctx->type == SOCK_STREAM) {
+		if (bpf_setsockopt(ctx, SOL_TCP, TCP_NOTSENT_LOWAT, &lowat, sizeof(lowat)))
+			return 1;
+	}
+
+	return 0;
+}
+
 SEC("cgroup/connect4")
 int connect_v4_prog(struct bpf_sock_addr *ctx)
 {
@@ -148,6 +160,9 @@ int connect_v4_prog(struct bpf_sock_addr *ctx)
 	if (set_keepalive(ctx))
 		return 0;
 
+	if (set_notsent_lowat(ctx))
+		return 0;
+
 	if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
 		return 0;
 	else if (ctx->type == SOCK_STREAM)
-- 
2.25.1

