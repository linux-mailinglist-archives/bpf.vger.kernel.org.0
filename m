Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66EA818B4DC
	for <lists+bpf@lfdr.de>; Thu, 19 Mar 2020 14:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgCSNNV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Mar 2020 09:13:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:48527 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729134AbgCSNNU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Mar 2020 09:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584623599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uWJEiu/Z2FQlJcrWSPoV5kXif2wXXa5HAsBAGFtr6yE=;
        b=YE4a3W58KTnWwulu6K7NJZc0Q9av+ENxcGJxQgkmEBs1JRAZTlAL2EeHYS3NGp7j2/RhXp
        +XRuTHVUgNdqUDk8w2iOa8bqscp8jnh/PXUV7e6MDuwdskQqcE2ekPv3YrSP3BuhNFCOLz
        ug68m5Qw3u1H6vcVirvNf2Zpw8he/j8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-QbE37opIPEu5xhvp8Yse1A-1; Thu, 19 Mar 2020 09:13:17 -0400
X-MC-Unique: QbE37opIPEu5xhvp8Yse1A-1
Received: by mail-wm1-f72.google.com with SMTP id m4so945197wme.0
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2020 06:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=uWJEiu/Z2FQlJcrWSPoV5kXif2wXXa5HAsBAGFtr6yE=;
        b=E7iNEAxukYoLgPby9CipJUULVHSSV7GIec9p4dU9uFYw5jr+w+ZnSc6FD1EY0/OgjQ
         wh8dYYx1Jnf/yOnTGFej5htPHJ/QYDIAMbNBAhjHZuCj5yUXtc62zubN0+Y9ORII5UI2
         n/sX64E71C/XaCoxL8PQ7L9ooOV5IKCH6ciGERXdbtteHk4o8C+C3cQeoGR4piSxuOS5
         WCcdbQ0QCFIy7K4Y8pc2HN4JWElypP+QXT/0E23uQV1uPD4MCxHxWt3LTcQh9xWMOCXV
         hcW3tnyb1Pda7O+t8oBeVEQ6ySc1SqY6zuU5x9GdNqUHKoCA5od0Kp2sUfcnys51j4o2
         lAoA==
X-Gm-Message-State: ANhLgQ0r1E2qE9eWZMPjuSySQGM29SMjdkfulsXgXXRQQJiss5qjGtGT
        SZxeoR95HuAwzTai2cfMqi8WaWWgRtxfjBovSVuODbmePYuDkTDVgRnt1Bg1Ds0DuYeJiEXtOPG
        TcE58HPoYrnLJ
X-Received: by 2002:a1c:6385:: with SMTP id x127mr3647785wmb.141.1584623596258;
        Thu, 19 Mar 2020 06:13:16 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt+Z7JUM/KQLOWds3rAEs1ALcIo+ruqq8ub+P9UEsTFzaY1gCY2UKTJFwmi0Sx1Eeh22JidQg==
X-Received: by 2002:a1c:6385:: with SMTP id x127mr3647765wmb.141.1584623596070;
        Thu, 19 Mar 2020 06:13:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id p10sm3563491wrx.81.2020.03.19.06.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 06:13:14 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 493B9180371; Thu, 19 Mar 2020 14:13:14 +0100 (CET)
Subject: [PATCH bpf-next 2/4] tools: Add EXPECTED_FD-related definitions in
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
Date:   Thu, 19 Mar 2020 14:13:14 +0100
Message-ID: <158462359425.164779.4804283164480162318.stgit@toke.dk>
In-Reply-To: <158462359206.164779.15902346296781033076.stgit@toke.dk>
References: <158462359206.164779.15902346296781033076.stgit@toke.dk>
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
 

