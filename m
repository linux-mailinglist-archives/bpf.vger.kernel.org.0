Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B521F7B5C
	for <lists+bpf@lfdr.de>; Fri, 12 Jun 2020 18:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgFLQCM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Jun 2020 12:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgFLQCC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Jun 2020 12:02:02 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CB0C03E96F
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2020 09:02:01 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l10so10244036wrr.10
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2020 09:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zQejEshYFNqUb7v3sioackX6D/pyfet7gpxzYUl52wE=;
        b=PBYbhxCMm9X+7/S47/3y+XNZktGaW42Z7fcfOreCztwwDU50QNAbPSjHdjzR+nZFit
         305TjsQRfWasNDoU/NywVe2HLHqNrWeS7kF/hLOrAeXpuypJ4icYBdiY3OxolNpJVbsC
         j2Bp60+NVG2kGFpa1PAj91qYQMPUEWyZsQQqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zQejEshYFNqUb7v3sioackX6D/pyfet7gpxzYUl52wE=;
        b=qHTjVELBuXMCkZhgZANfxLxHVknjVctgE8S3uGVCKvSg0CmUnzWvdKwDOE0yWJfROs
         mJ5w4G0Ryte0+u8TQNjq7e3gzdOFWhnMkWJwX42EluGFRpVj1XBdkaDUUHkgUH6foXOv
         rVRk+4F3RiDunZHjSP8x00d4wsFHHn6ZelGu/uWjutQeAPPSEmjaMDqgj8LxR+DpQogL
         xuK/d2r8GKItZUDSJ6WGP9Inx3eiiesu2fX52Kp4R1U4vmxo5vhTw6CVhspuOykl9d2Z
         AJELFeJ9m/P4IJ2ABwb3HMBIMdOdv1Jog1fgz3AlNxuuZdSb5SW5kBg+XIRwjIefqlAU
         O5iw==
X-Gm-Message-State: AOAM532ZFP14hxCYXaSjH10CD0+v0pmUwW11gyMfCkbMxBmOMjdf2/yb
        0ZyfW/VsjJ2poLbWxujblwNkDA==
X-Google-Smtp-Source: ABdhPJwmxuL4QdXOsFvU61egyGC88qJdz9nI+m0Pp8bmpgmWGAwH/RDq42CraRgRg31Tvv29fPJ3/g==
X-Received: by 2002:adf:e9cb:: with SMTP id l11mr15244107wrn.86.1591977720712;
        Fri, 12 Jun 2020 09:02:00 -0700 (PDT)
Received: from antares.lan (1.e.7.e.0.1.3.6.1.5.d.2.f.1.0.9.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:901f:2d51:6310:e7e1])
        by smtp.gmail.com with ESMTPSA id k16sm11169941wrp.66.2020.06.12.09.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 09:02:00 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf 2/2] bpf: sockmap: reject invalid attach_flags
Date:   Fri, 12 Jun 2020 17:01:41 +0100
Message-Id: <20200612160141.188370-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200612160141.188370-1-lmb@cloudflare.com>
References: <20200612160141.188370-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Using BPF_PROG_ATTACH on a sockmap program currently understands no
flags, but accepts any value. Return EINVAL if any flags are specified.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
---
 net/core/sock_map.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 00a26cf2cfe9..6f0894909138 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -70,6 +70,9 @@ int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog)
 	struct fd f;
 	int ret;
 
+	if (attr->attach_flags)
+		return -EINVAL;
+
 	f = fdget(ufd);
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
-- 
2.25.1

