Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026A149E8E4
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 18:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbiA0RYx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 12:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiA0RYx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jan 2022 12:24:53 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D54C061714
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 09:24:52 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id c23so6091377wrb.5
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 09:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4OSnApzs5/dDYr7P92s+LuaWCqvDMi+S9AX1oUrs0vM=;
        b=RP5892c78EVoktgEsHSpYsIIxek1kSg6BAuAOkqlPIjeFN4Hke/6UgjJcuElKoGQro
         rEyR6H/9mi+lWFYwrMAVjP2SOscHXAeJ9QWyxzTZMTXThfoRxqIrJt+KMoSFgkEE9Bo4
         trDshLbdFpQaJdVZNQPAM9T7bORJDYKkG19m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4OSnApzs5/dDYr7P92s+LuaWCqvDMi+S9AX1oUrs0vM=;
        b=e5a4ZKsltCH1CWqlcORG01Ks5eomwNV2ytQDBjy9uJtr4SYJR3sL3eFtVHWSpaFqo6
         hoXs0Cb3EqWZHv+theXuuUPOSZNN3TSkjSedfJ2IHPMUfW/1Z5GEeIT1pemLddFwMCCS
         XlFSj9/Ta1MdvyIcUutVV66UviUjVFhsFrsztPuDWywwzZiqY2vAMKkxjuho4poe0Q7o
         kQWQconmFDUrUfSpXkHptHDvnKafu2uhgKjuZ+wny6RRXpHoZSa40/QViQLbsLUSP9RX
         wDTJk5sFZ53cUo7FbffY+XnR/MbP4sNRvnGruD+jiEyb3G3gHP7S4wEVkx6qFwbtny5I
         mdsA==
X-Gm-Message-State: AOAM531u8WQ29F2zxgdiiU/fYZd+lHoxnZ8A8tfOjxLl7jNuf40Glx2s
        kr00GsUmysBx0h95+KVTyApONPgGMXUoZg==
X-Google-Smtp-Source: ABdhPJz2YtgCt08zK7860NiSbkhG3MAIfhq1ATrD6sxfcP/kdwwwciS3paoWT14BIFRhEKSB9Pjzyg==
X-Received: by 2002:adf:e54e:: with SMTP id z14mr3924419wrm.490.1643304291093;
        Thu, 27 Jan 2022 09:24:51 -0800 (PST)
Received: from cloudflare.com ([2a01:110f:4809:d800::e00])
        by smtp.gmail.com with ESMTPSA id j3sm2538616wrb.57.2022.01.27.09.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:24:50 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Menglong Dong <imagedong@tencent.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next 1/2] bpf: Make dst_port field in struct bpf_sock 16-bit wide
Date:   Thu, 27 Jan 2022 18:24:47 +0100
Message-Id: <20220127172448.155686-2-jakub@cloudflare.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127172448.155686-1-jakub@cloudflare.com>
References: <20220127172448.155686-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Menglong Dong reports that the documentation for the dst_port field in
struct bpf_sock is inaccurate and confusing. From the BPF program PoV, the
field is a zero-padded 16-bit integer in network byte order. The value
appears to the BPF user as if laid out in memory as so:

  offsetof(struct bpf_sock, dst_port) + 0  <port MSB>
                                      + 8  <port LSB>
                                      +16  0x00
                                      +24  0x00

32-, 16-, and 8-bit wide loads from the field are all allowed, but only if
the offset into the field is 0.

32-bit wide loads from dst_port are especially confusing. The loaded value,
after converting to host byte order with bpf_ntohl(dst_port), contains the
port number in the upper 16-bits.

Remove the confusion by splitting the field into two 16-bit fields. For
backward compatibility, allow 32-bit wide loads from offsetof(struct
bpf_sock, dst_port).

While at it, allow loads 8-bit loads at offset [0] and [1] from dst_port.

Reported-by: Menglong Dong <imagedong@tencent.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/uapi/linux/bpf.h | 3 ++-
 net/core/filter.c        | 9 ++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4a2f7041ebae..027e84b18b51 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5574,7 +5574,8 @@ struct bpf_sock {
 	__u32 src_ip4;
 	__u32 src_ip6[4];
 	__u32 src_port;		/* host byte order */
-	__u32 dst_port;		/* network byte order */
+	__be16 dst_port;	/* network byte order */
+	__u16 zero_padding;
 	__u32 dst_ip4;
 	__u32 dst_ip6[4];
 	__u32 state;
diff --git a/net/core/filter.c b/net/core/filter.c
index a06931c27eeb..ef8473163696 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8265,6 +8265,7 @@ bool bpf_sock_is_valid_access(int off, int size, enum bpf_access_type type,
 			      struct bpf_insn_access_aux *info)
 {
 	const int size_default = sizeof(__u32);
+	int field_size;
 
 	if (off < 0 || off >= sizeof(struct bpf_sock))
 		return false;
@@ -8276,7 +8277,6 @@ bool bpf_sock_is_valid_access(int off, int size, enum bpf_access_type type,
 	case offsetof(struct bpf_sock, family):
 	case offsetof(struct bpf_sock, type):
 	case offsetof(struct bpf_sock, protocol):
-	case offsetof(struct bpf_sock, dst_port):
 	case offsetof(struct bpf_sock, src_port):
 	case offsetof(struct bpf_sock, rx_queue_mapping):
 	case bpf_ctx_range(struct bpf_sock, src_ip4):
@@ -8285,6 +8285,13 @@ bool bpf_sock_is_valid_access(int off, int size, enum bpf_access_type type,
 	case bpf_ctx_range_till(struct bpf_sock, dst_ip6[0], dst_ip6[3]):
 		bpf_ctx_record_field_size(info, size_default);
 		return bpf_ctx_narrow_access_ok(off, size, size_default);
+	case bpf_ctx_range(struct bpf_sock, dst_port):
+		field_size = size == size_default ?
+			size_default : sizeof_field(struct bpf_sock, dst_port);
+		bpf_ctx_record_field_size(info, field_size);
+		return bpf_ctx_narrow_access_ok(off, size, field_size);
+	case bpf_ctx_range(struct bpf_sock, zero_padding):
+		return false;
 	}
 
 	return size == size_default;
-- 
2.31.1

