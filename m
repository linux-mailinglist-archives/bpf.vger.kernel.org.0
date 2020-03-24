Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECF321918AD
	for <lists+bpf@lfdr.de>; Tue, 24 Mar 2020 19:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgCXSNA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Mar 2020 14:13:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:37404 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727611AbgCXSNA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Mar 2020 14:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585073578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tSq0g3BWcscqwecq9OzTA1nIWwl388abRfl7XMKFSlI=;
        b=WczF8mfMJvFs4IxXJwssO/34NHR4Fo5+9mOrpvHQgt5XLBcLbVxqah9plUKabmdg4TiYju
        wDC9Tld9PhnVlrwhRjFDFXg2cWvsSpQ3YUErRKU1B7n54zp0IAHb0JR1ObUh96krUbnp65
        4JDpVQF2V1YCUYosHhXVJgIancgRtk4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-P0SZjNf2OV6ZN2cEVa0rFw-1; Tue, 24 Mar 2020 14:12:57 -0400
X-MC-Unique: P0SZjNf2OV6ZN2cEVa0rFw-1
Received: by mail-wr1-f70.google.com with SMTP id h17so9614244wru.16
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2020 11:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=tSq0g3BWcscqwecq9OzTA1nIWwl388abRfl7XMKFSlI=;
        b=c8HtBdWzJJcrtGpcgG6q+BP2PSeISvMqMvmO3f2pZQg+7CbdRkfySA/kXLD2SQoonc
         CxtCc4t4wKVTVeuG8anO3TI/u9p4Z02M8AxZdJ/GbnmG9av6czhej40KNN1VRpv8wjHS
         43km6AzCPupl8VUYgtGGENBnl2LVBRovNTyhYJtputIGQmLM6mwP3IpXQDrauEHzyYNW
         pee4Wnxdf5p1wLCHTUblnjyFCXI9J/Dp8mPO9vGODMe2aC9pjvENuxcDh6M2TOGGtXoQ
         EB4CFftYYPZMslnS/hfxrooE9RWLm62HGGpUKGQffpMm6wz/vVmm09YyLYkj10qiOH46
         R6pQ==
X-Gm-Message-State: ANhLgQ2kHX8kZbII0MPBAeKzPscPGjfmT6xYjtZTNWtcxjDfR05WiDJI
        uDKfYKNTbAdON0qKqijvzBE7fFFqM3qaRx6SRvW+3WNUaNpwyBUw23u/4MWyQUzMUB7oz299bWx
        MvgPoc/INDdAx
X-Received: by 2002:a05:600c:da:: with SMTP id u26mr7434908wmm.117.1585073575829;
        Tue, 24 Mar 2020 11:12:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtE2snWQd3U9Jm0nj2e7Xx4XiNovziigWM+YrFQhUJ7b6xuztOVXe52JbbBukTeNQtkOKfgkA==
X-Received: by 2002:a05:600c:da:: with SMTP id u26mr7434876wmm.117.1585073575644;
        Tue, 24 Mar 2020 11:12:55 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id p22sm5281840wmg.37.2020.03.24.11.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:12:54 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4002018158B; Tue, 24 Mar 2020 19:12:54 +0100 (CET)
Subject: [PATCH bpf-next v3 2/4] tools: Add EXPECTED_ID-related definitions in
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
Date:   Tue, 24 Mar 2020 19:12:54 +0100
Message-ID: <158507357420.6925.493303763242155249.stgit@toke.dk>
In-Reply-To: <158507357205.6925.17804771242752938867.stgit@toke.dk>
References: <158507357205.6925.17804771242752938867.stgit@toke.dk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

This adds the IFLA_XDP_EXPECTED_ID netlink attribute definition and the
XDP_FLAGS_EXPECT_ID flag to if_link.h in tools/include.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/include/uapi/linux/if_link.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 024af2d1d0af..a6c14ae083e3 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -960,11 +960,12 @@ enum {
 #define XDP_FLAGS_SKB_MODE		(1U << 1)
 #define XDP_FLAGS_DRV_MODE		(1U << 2)
 #define XDP_FLAGS_HW_MODE		(1U << 3)
+#define XDP_FLAGS_EXPECT_ID		(1U << 4)
 #define XDP_FLAGS_MODES			(XDP_FLAGS_SKB_MODE | \
 					 XDP_FLAGS_DRV_MODE | \
 					 XDP_FLAGS_HW_MODE)
 #define XDP_FLAGS_MASK			(XDP_FLAGS_UPDATE_IF_NOEXIST | \
-					 XDP_FLAGS_MODES)
+					 XDP_FLAGS_MODES | XDP_FLAGS_EXPECT_ID)
 
 /* These are stored into IFLA_XDP_ATTACHED on dump. */
 enum {
@@ -984,6 +985,7 @@ enum {
 	IFLA_XDP_DRV_PROG_ID,
 	IFLA_XDP_SKB_PROG_ID,
 	IFLA_XDP_HW_PROG_ID,
+	IFLA_XDP_EXPECTED_ID,
 	__IFLA_XDP_MAX,
 };
 

