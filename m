Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDD5E192F19
	for <lists+bpf@lfdr.de>; Wed, 25 Mar 2020 18:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgCYRXg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Mar 2020 13:23:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:33463 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727749AbgCYRXf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 25 Mar 2020 13:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585157014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TlIK1duIZ7CYV2AfLDt7G96gJTgpzGhibeBunBKnLEI=;
        b=G+VVA3UO1mfaxO6Hgpdy2ufbG1ZOi2UQuYseK6qEpvwQzZHXnyB/Q26tVCOBhJ/NL78vfx
        qkCuOYv2x54y/ddfkk1JhQBs1g6WiwmGasIrpUPuG7w0ZjQy1+uG9mMTIcRODJiUjNLyT/
        ZgXAwllovFOoC3JkicsVKfJt5kM1Vto=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-jYyLmRevO1a-rsc33WVQ4w-1; Wed, 25 Mar 2020 13:23:30 -0400
X-MC-Unique: jYyLmRevO1a-rsc33WVQ4w-1
Received: by mail-lf1-f69.google.com with SMTP id q4so1104916lff.4
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2020 10:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=TlIK1duIZ7CYV2AfLDt7G96gJTgpzGhibeBunBKnLEI=;
        b=ar6LqCmUFVs892XLqFRheLrJtHDWBPdKH2cb32A+Yk5p2v0B+ED9eB79G0wENfHPjJ
         9mefsNKP8XpjTGc+ETPe9FO5yeoen9uDNd1of4C7rfSKl9HoxgKlCXR87WVfexzsbJe4
         1GZq2GFiAo4mEGHyEpW2HtIieraUvslL86drS8+sVmR3nyN3Futg9SnEYS2IKIwtqVWT
         rofASMCOY5pb+JJces49oyqVDIdF0jUA2wYLhg/zlmXP183cRtc1JP/VhdIBNBoSeKug
         HkmT3lQx0WzmR12FLoBSsBFd+j9a7q5X5wDuzH9GIbm/E8W1vW3DRTU7+2r2LPcPsWDy
         mLNg==
X-Gm-Message-State: ANhLgQ3WqNCIZunQi6erhkH4kxdCCsBSc5bLklpmDDNZIARDZzLoh93b
        WmWs5QV7B1EuxwNk5zzd3/JYkXxkNfqtK7rsi/eH6SSNon81l0cyualBlBicpjcIR558oNkjcN4
        Op0b7KPsCF3Z+
X-Received: by 2002:ac2:4191:: with SMTP id z17mr2949498lfh.73.1585157008962;
        Wed, 25 Mar 2020 10:23:28 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtU/I5xdrBBmAGhgc7MLv/GeIi0iKmzDAYbK+bUgcCbZzQoZ5CS8YyG/sPMh+D1mu96844NTg==
X-Received: by 2002:ac2:4191:: with SMTP id z17mr2949479lfh.73.1585157008760;
        Wed, 25 Mar 2020 10:23:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id f26sm6601752lja.102.2020.03.25.10.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 10:23:28 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8AEC818158B; Wed, 25 Mar 2020 18:23:27 +0100 (CET)
Subject: [PATCH bpf-next v4 2/4] tools: Add EXPECTED_FD-related definitions in
 if_link.h
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, Andrey Ignatov <rdna@fb.com>
Date:   Wed, 25 Mar 2020 18:23:27 +0100
Message-ID: <158515700747.92963.8615391897417388586.stgit@toke.dk>
In-Reply-To: <158515700529.92963.17609642163080084530.stgit@toke.dk>
References: <158515700529.92963.17609642163080084530.stgit@toke.dk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

This adds the IFLA_XDP_EXPECTED_FD netlink attribute definition and the
XDP_FLAGS_REPLACE flag to if_link.h in tools/include.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/include/uapi/linux/if_link.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 024af2d1d0af..b1ec7c949e6a 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -960,11 +960,12 @@ enum {
 #define XDP_FLAGS_SKB_MODE		(1U << 1)
 #define XDP_FLAGS_DRV_MODE		(1U << 2)
 #define XDP_FLAGS_HW_MODE		(1U << 3)
+#define XDP_FLAGS_REPLACE		(1U << 4)
 #define XDP_FLAGS_MODES			(XDP_FLAGS_SKB_MODE | \
 					 XDP_FLAGS_DRV_MODE | \
 					 XDP_FLAGS_HW_MODE)
 #define XDP_FLAGS_MASK			(XDP_FLAGS_UPDATE_IF_NOEXIST | \
-					 XDP_FLAGS_MODES)
+					 XDP_FLAGS_MODES | XDP_FLAGS_REPLACE)
 
 /* These are stored into IFLA_XDP_ATTACHED on dump. */
 enum {
@@ -984,6 +985,7 @@ enum {
 	IFLA_XDP_DRV_PROG_ID,
 	IFLA_XDP_SKB_PROG_ID,
 	IFLA_XDP_HW_PROG_ID,
+	IFLA_XDP_EXPECTED_FD,
 	__IFLA_XDP_MAX,
 };
 

