Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6CC5C47B
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2019 22:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfGAUsg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jul 2019 16:48:36 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:46109 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfGAUsf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jul 2019 16:48:35 -0400
Received: by mail-vk1-f202.google.com with SMTP id p64so3920347vkp.13
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2019 13:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pVikEg8jjnvM0Q28LM7sWpY08h9CumZd8qGejdWCdLY=;
        b=MFTt/l0Ktxh+G4sjegR1dnw1FepmgMdcBQHxO0sDejqpeapdfhyli2EUq/r7ytQsO3
         do0x39FK1WqmbJDhz+tudp3ca4VHnghWvAIi4SBNyou9howUW/TGdeKlH2Q+ZZDncOL1
         u09WOJj08Bw7LMUNgG/AXIXpFrC8mz5xPJN0h3CE1KQimh4jw2O9oN4uwiYWI/4y70l2
         CtCUA8heNY3Lnldkadw+/nReVaFk/mTto21TBiDj/VkhWRYxfS8mh/3IWf2R2wbfwp81
         i4adZKj2LI9NX5NXjT0PJ1/uYc+VuxNRikUQF6AC1mnn7ShvckEwVRNgemU2P5kl5b9j
         I+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pVikEg8jjnvM0Q28LM7sWpY08h9CumZd8qGejdWCdLY=;
        b=VvEu3QNVKDZBpbeSGV9ZvjU6esRn0lLcL12WlMR5rWE15buD10nrD5zdHsa8zLD3ED
         zs3ZbcWOFU6bHIV4ZhfLTOwSxIiouFcVaNw825cOW8xpycaeMvULwcCH1h1RgIIxe4tM
         xPxLdvb8Fl4sxK6um3bG9tTgVFfo41LU1OewWUPwRWBzZ6boLp6i7QgdO8CCMNQ3ivbn
         soKX2k+s/jaweRm0lqoinEaTT7M3Dp0V4M0qcEnlieWQrlA/aCLQuIonl8duR1jNkhJS
         mbWctH4vXbDRIC4yyF/duvIgpWy2fz0qbj+CkArdkZPrRs3y35Srt5C+kRjuwynTAv8/
         nvNA==
X-Gm-Message-State: APjAAAWslzPQdjnCW3BrpvUtcHe2nEtkLaEuoX/o6I06mMreAgsT/rfw
        Zkww62XvSF5aNYUVgiQWhkwgyM4=
X-Google-Smtp-Source: APXvYqxRizHEqb38RLLpSnKtke5tWnEtl1FdzxTuJoLYKxThF94TMRPyjJRCUG91ip2fTjwmCV7AKv4=
X-Received: by 2002:a1f:200b:: with SMTP id g11mr9069177vkg.26.1562014114519;
 Mon, 01 Jul 2019 13:48:34 -0700 (PDT)
Date:   Mon,  1 Jul 2019 13:48:17 -0700
In-Reply-To: <20190701204821.44230-1-sdf@google.com>
Message-Id: <20190701204821.44230-5-sdf@google.com>
Mime-Version: 1.0
References: <20190701204821.44230-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next 4/8] bpf: add icsk_retransmits to bpf_tcp_sock
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Priyaranjan Jha <priyarjha@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add some inet_connection_sock fields to bpf_tcp_sock that might be useful
for debugging congestion control issues.

Cc: Eric Dumazet <edumazet@google.com>
Cc: Priyaranjan Jha <priyarjha@google.com>
Cc: Yuchung Cheng <ycheng@google.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/uapi/linux/bpf.h |  1 +
 net/core/filter.c        | 20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index bfb0b1a76684..ead27aebf491 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3078,6 +3078,7 @@ struct bpf_tcp_sock {
 				 */
 	__u32 delivered;	/* Total data packets delivered incl. rexmits */
 	__u32 delivered_ce;	/* Like the above but only ECE marked packets */
+	__u32 icsk_retransmits;	/* Number of unrecovered [RTO] timeouts */
 };
 
 struct bpf_sock_tuple {
diff --git a/net/core/filter.c b/net/core/filter.c
index 3da4b6c38b46..089aaea0ccc6 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5544,7 +5544,8 @@ static const struct bpf_func_proto bpf_sock_addr_sk_lookup_udp_proto = {
 bool bpf_tcp_sock_is_valid_access(int off, int size, enum bpf_access_type type,
 				  struct bpf_insn_access_aux *info)
 {
-	if (off < 0 || off >= offsetofend(struct bpf_tcp_sock, delivered_ce))
+	if (off < 0 || off >= offsetofend(struct bpf_tcp_sock,
+					  icsk_retransmits))
 		return false;
 
 	if (off % size != 0)
@@ -5575,6 +5576,20 @@ u32 bpf_tcp_sock_convert_ctx_access(enum bpf_access_type type,
 				      offsetof(struct tcp_sock, FIELD)); \
 	} while (0)
 
+#define BPF_INET_SOCK_GET_COMMON(FIELD)					\
+	do {								\
+		BUILD_BUG_ON(FIELD_SIZEOF(struct inet_connection_sock,	\
+					  FIELD) >			\
+			     FIELD_SIZEOF(struct bpf_tcp_sock, FIELD));	\
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(			\
+					struct inet_connection_sock,	\
+					FIELD),				\
+				      si->dst_reg, si->src_reg,		\
+				      offsetof(				\
+					struct inet_connection_sock,	\
+					FIELD));			\
+	} while (0)
+
 	if (insn > insn_buf)
 		return insn - insn_buf;
 
@@ -5661,6 +5676,9 @@ u32 bpf_tcp_sock_convert_ctx_access(enum bpf_access_type type,
 	case offsetof(struct bpf_tcp_sock, delivered_ce):
 		BPF_TCP_SOCK_GET_COMMON(delivered_ce);
 		break;
+	case offsetof(struct bpf_tcp_sock, icsk_retransmits):
+		BPF_INET_SOCK_GET_COMMON(icsk_retransmits);
+		break;
 	}
 
 	return insn - insn_buf;
-- 
2.22.0.410.gd8fdbe21b5-goog

