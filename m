Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E75F18D511
	for <lists+bpf@lfdr.de>; Fri, 20 Mar 2020 17:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgCTQ4Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Mar 2020 12:56:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31238 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727613AbgCTQ4P (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 20 Mar 2020 12:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584723374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uWJEiu/Z2FQlJcrWSPoV5kXif2wXXa5HAsBAGFtr6yE=;
        b=XMojtfyCiZ5ka5JPZxMKwNs1jKq8q2Tf4DWUVZeV7AyV8Pq+nSTdT7xo6dEqh9X1naXy2n
        Aj5OxtOGbygmJIc85nLGvTte01eof4tmQaX9ZuWDjBt+rNwAr743did09y9fom5f0B47Uh
        IGEA+TEy4y3srPrmnhX4tQWItHIJYEw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-zNs06LrENY2wADCULAwRQw-1; Fri, 20 Mar 2020 12:56:13 -0400
X-MC-Unique: zNs06LrENY2wADCULAwRQw-1
Received: by mail-wr1-f72.google.com with SMTP id o9so2906604wrw.14
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2020 09:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=uWJEiu/Z2FQlJcrWSPoV5kXif2wXXa5HAsBAGFtr6yE=;
        b=SlncS2mZyNUkB9NrBhptJ49dYb3u5SDhqHEp+J96YrV7gV6iH8/vfigr9XbihMdAUA
         qxNUq0DjV3Dwxc2m16dZuCWAtXsTEB5twe8xOMsX3wkyEtoxTinx909WndyoZR1fe181
         9u0yF2fYxYWMJtUht/9ZL71wo/r9A+Jsxuo1JMQxH3hL609XJ2FAZ2AazLG9bEqA/cVi
         RyMnnk4s2rv8U7/gNemoMnwYdDmmqwbdIhJ1KX/hVu3F75tRIHqXXkYvoSPJLE9WayIg
         wTPdK4+qn0Z3ew91LOK0NfhqhjKCqaUdw2nWlhXo7zxGEXoSXTChou3/LtOOO3c5avZp
         AIKA==
X-Gm-Message-State: ANhLgQ2mNT8yb/01qiTkfLIbhoKNLvNPOF67ETdGuTbktcf/no4of/FR
        /klEZk4mp4/DaECnyZdliFsuZmQgo7LSP3DVpKPGxwNyaDkFhhPISOLI/iCeW+suqJMoCHReu1J
        HuKIwub17pgPP
X-Received: by 2002:adf:e611:: with SMTP id p17mr12092539wrm.212.1584723371686;
        Fri, 20 Mar 2020 09:56:11 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt5dnElraEJukrxRAzOrRHyD+59sIcO9ulFVjI/M6bi9ifQambJe+0n3+1b74F6Lzxu/qzP6A==
X-Received: by 2002:adf:e611:: with SMTP id p17mr12092512wrm.212.1584723371442;
        Fri, 20 Mar 2020 09:56:11 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 9sm8345504wmo.38.2020.03.20.09.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 09:56:10 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BC07C180371; Fri, 20 Mar 2020 17:56:09 +0100 (CET)
Subject: [PATCH bpf-next v2 2/4] tools: Add EXPECTED_FD-related definitions in
 if_link.h
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Andrey Ignatov <rdna@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Fri, 20 Mar 2020 17:56:09 +0100
Message-ID: <158472336968.296548.5222057372093911700.stgit@toke.dk>
In-Reply-To: <158472336748.296548.5028326196275429565.stgit@toke.dk>
References: <158472336748.296548.5028326196275429565.stgit@toke.dk>
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
XDP_FLAGS_EXPECT_FD flag to if_link.h in tools/include.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/include/uapi/linux/if_link.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 024af2d1d0af..e5eced1c28f4 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -960,11 +960,12 @@ enum {
 #define XDP_FLAGS_SKB_MODE		(1U << 1)
 #define XDP_FLAGS_DRV_MODE		(1U << 2)
 #define XDP_FLAGS_HW_MODE		(1U << 3)
+#define XDP_FLAGS_EXPECT_FD		(1U << 4)
 #define XDP_FLAGS_MODES			(XDP_FLAGS_SKB_MODE | \
 					 XDP_FLAGS_DRV_MODE | \
 					 XDP_FLAGS_HW_MODE)
 #define XDP_FLAGS_MASK			(XDP_FLAGS_UPDATE_IF_NOEXIST | \
-					 XDP_FLAGS_MODES)
+					 XDP_FLAGS_MODES | XDP_FLAGS_EXPECT_FD)
 
 /* These are stored into IFLA_XDP_ATTACHED on dump. */
 enum {
@@ -984,6 +985,7 @@ enum {
 	IFLA_XDP_DRV_PROG_ID,
 	IFLA_XDP_SKB_PROG_ID,
 	IFLA_XDP_HW_PROG_ID,
+	IFLA_XDP_EXPECTED_FD,
 	__IFLA_XDP_MAX,
 };
 

