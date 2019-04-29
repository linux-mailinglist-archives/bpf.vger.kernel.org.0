Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88B1ADFDB
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2019 11:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfD2Jww (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Apr 2019 05:52:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36211 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbfD2Jws (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Apr 2019 05:52:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id o4so3126844wra.3
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2019 02:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vV5IIF8H0WuMd2J5w6doIbRMaPgBbSK0Xirjfj1X1Pk=;
        b=my8m0mReTHmyo4fn7jJxDhUQY8e9Zh0juPFuK5oJ3YBpDjT+aHHIUh1MN5f9s/wBVW
         kZ9Plw7/IcLth6gsmtyPY5j06Bnzgw4zclqFSZuYmqX2oduf5t4z4YyDDAAeiinJUB4c
         KOCznbPSE+qXrkOT93ry2+vAIlzghZC2S0QQoEQD0MjIVp/WQZJHUoB8/5XsCGRm4s+p
         4eOFJgIS32CA/+Y5N/7ZKODhG5SJxtM0yfr6BYgZI4mN4F9S+paa4641o7bx3coFoe4U
         OHL4Vuf/gZNVmP1yUCG1ikmPFrIus4uyURVCAc+g4J7IyxPNJN8g/FtaIDGh1/FHmrD8
         20ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vV5IIF8H0WuMd2J5w6doIbRMaPgBbSK0Xirjfj1X1Pk=;
        b=FgYMp0yxquyTqDvgVwTSwlkXC68Kv1kh8vvQhav+Dm0WVpwmJAkwT/UrpP54VK6nqA
         sZ69q7+WB0Ay/L7ipq8PXskSXYQ3f3CIK8XftNs3rpmBM5eKRvzYLWY4eQ96f7blcnWy
         +e9A5lA4MKORJLGAKdEdbKku7RaKrP9cgukdU/9zzT5onjUL6FmCNd/5W8Zvv5S2Fci8
         rVG+40MEaqDNBM4gtapIImzQFvPJk043/swunV8wzxuUpjV1GLQgNYj0KiqzxD0UTYnM
         dwzWI/fJKcdx2iKZgMVS7yKz7kcH/Lp+6ZrBFJ++3vkY/GbWc106O98VPtWyiOSKfGcg
         9RsQ==
X-Gm-Message-State: APjAAAVBZhIs49cmtet1c6QyLC6Cd3ODPiOu/uvJcAGFZg6wZVqqajXs
        FVhGrDkISrJErDVd2nwESWUV6Z0ALC3bkQ==
X-Google-Smtp-Source: APXvYqxNm30s9yu5w5vYvnLkD72BT9dAUzdeQCF48MFULg0qUGNGBSa+x3YtI3bN2qKu0/ZcPt3YFw==
X-Received: by 2002:a5d:6a03:: with SMTP id m3mr13081906wru.135.1556531566508;
        Mon, 29 Apr 2019 02:52:46 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id x20sm11241535wrg.29.2019.04.29.02.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 02:52:45 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next 5/6] tools: bpf: report latest changes from BPF UAPI header to tools
Date:   Mon, 29 Apr 2019 10:52:26 +0100
Message-Id: <20190429095227.9745-6-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190429095227.9745-1-quentin.monnet@netronome.com>
References: <20190429095227.9745-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF verifier log level flags were moved from an internal header to the
UAPI header file. Report the changes accordingly.

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 tools/include/uapi/linux/bpf.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 72336bac7573..f8e3e764aff4 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -335,6 +335,11 @@ struct bpf_stack_build_id {
 	};
 };
 
+/* verifier log_level values for loading programs, can be combined */
+#define BPF_LOG_LEVEL1	1
+#define BPF_LOG_LEVEL2	2
+#define BPF_LOG_STATS	4
+
 union bpf_attr {
 	struct { /* anonymous struct used by BPF_MAP_CREATE command */
 		__u32	map_type;	/* one of enum bpf_map_type */
-- 
2.17.1

