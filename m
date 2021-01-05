Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163992EAAA4
	for <lists+bpf@lfdr.de>; Tue,  5 Jan 2021 13:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbhAEMZ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Jan 2021 07:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbhAEMZz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Jan 2021 07:25:55 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A052DC06179E
        for <bpf@vger.kernel.org>; Tue,  5 Jan 2021 04:24:33 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id i9so35990880wrc.4
        for <bpf@vger.kernel.org>; Tue, 05 Jan 2021 04:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RENS1yiCoqDoLkKN/GRTnjThUIFO+qOBX6TnsDEXMJ4=;
        b=Rsjc+UbI6l1AKroxhh3v0TqyRX6k81MRpq+7OB6mC3k6sYU270+X7iDmnPcUJwrq4H
         QB9Go38farUyWX6zlc1p2fQCfYdkXNd/NVwmFAxjZj30JF5wv/1987mxINy3Vl3ySTjl
         ArjkurbUGoZGDnC4NKIImUw8OBGE1O796zl91v3MgCWXUyb/XY60ZHTqlaNuwhnrH6Y+
         PCC8FtYIt1sOuS1sR5Kyzo4RdPZoiW8SUnXpqT2voCdoqGrMqI1dSRX1j04Tt2ScerCi
         nWCywRHrCIVN3UlXN1eB9d/uliwbj94xC5PgNvjNHwNXT3/VEG+IaIQHlxx8W+M1LMHb
         aFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RENS1yiCoqDoLkKN/GRTnjThUIFO+qOBX6TnsDEXMJ4=;
        b=BLfNDNwEFz4xTAZcLdf4iGnZekBQ/E2DOKCcqwiIGqyr2I2eR9MQwtGUopEyFX06uU
         QqG2hg+iqlAdWI6sbW9Lik8k/EafP4wqY+ffTD8pJhSf5WEEe6wi3hGrMEwtDNrimjDE
         sxStpwGJmetIqvbjz5YtgDQ5XrQbUL244K5Z1iJyiCuCHWxz9L7YyFiEk6sNoA8sf8SL
         j0OtxFo3h/fwcnZNxnPHU5N9x4d7JnsItnaR94XLQQnKykNXe+TMFYbBVR3GzO84M3DU
         cuWN+PWPl8F5Y1LOCtki49FcBh9jeck5x3FNhMtSfvc8HypwMCLBVZmr8OgoMQmFkIkV
         g+Sg==
X-Gm-Message-State: AOAM532qYMO51SBWxcuF5ACbdn/aL4HUxNh0WztnnffcWUX1ap+2Ecxf
        5Wjt9qKFoTG1r4CpvcWEwaGy7g==
X-Google-Smtp-Source: ABdhPJwUKO0ye0ZNgsk1g3yOggrEXv0KCoEdblfRWwUU30iRrMbnsJIJGtAgBYucbZzegbuNHb95LA==
X-Received: by 2002:adf:94c7:: with SMTP id 65mr82268745wrr.423.1609849472424;
        Tue, 05 Jan 2021 04:24:32 -0800 (PST)
Received: from f2.redhat.com (bzq-79-183-72-147.red.bezeqint.net. [79.183.72.147])
        by smtp.gmail.com with ESMTPSA id 138sm4242281wma.41.2021.01.05.04.24.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jan 2021 04:24:31 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     yan@daynix.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [RFC PATCH 3/7] tun: allow use of BPF_PROG_TYPE_SCHED_CLS program type
Date:   Tue,  5 Jan 2021 14:24:12 +0200
Message-Id: <20210105122416.16492-4-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105122416.16492-1-yuri.benditovich@daynix.com>
References: <20210105122416.16492-1-yuri.benditovich@daynix.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This program type can set skb hash value. It will be useful
when the tun will support hash reporting feature if virtio-net.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 drivers/net/tun.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 7959b5c2d11f..455f7afc1f36 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2981,6 +2981,8 @@ static int tun_set_ebpf(struct tun_struct *tun, struct tun_prog __rcu **prog_p,
 		prog = NULL;
 	} else {
 		prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_SOCKET_FILTER);
+		if (IS_ERR(prog))
+			prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_SCHED_CLS);
 		if (IS_ERR(prog))
 			return PTR_ERR(prog);
 	}
-- 
2.17.1

