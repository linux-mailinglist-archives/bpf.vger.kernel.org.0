Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4D52D43B3
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 15:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732677AbgLIN7Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 08:59:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732684AbgLIN7P (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Dec 2020 08:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607522269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=paX/7UAlKmbp58QFD0gyJzQyU0HAfzMzkzakh+VAmUM=;
        b=a6TvPym+S4ED5pl/R4Wa19G+pEJmVZga0JguHuMq4PRN88ZMkul+nt0TcnjhCO49wB7hTu
        xfGlPvegP7eX/9ze856yXkgHEYxNg2lWX6bRZK1LreQ6uLSuW8VvXMiBhX/phVjpOE4YHx
        sysTJhy4wbwyy3D+HlvexqLZEkWVzeU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-AoF0Ynl3Pm2mo_h-pll8TA-1; Wed, 09 Dec 2020 08:57:47 -0500
X-MC-Unique: AoF0Ynl3Pm2mo_h-pll8TA-1
Received: by mail-wr1-f70.google.com with SMTP id w8so683135wrv.18
        for <bpf@vger.kernel.org>; Wed, 09 Dec 2020 05:57:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=paX/7UAlKmbp58QFD0gyJzQyU0HAfzMzkzakh+VAmUM=;
        b=g9scPR52SRZZnmMnTI5bOf3mxZZDIeeeJPmwhNV6vRbXg4U7fCGr5MCR7KjRlwiByQ
         ZY7yH4PSFMe+m8TqUDZB6ACQE8sg5xtXQUPGarMKY1mCIW60EUkvm83kjKTvsqFRnNAO
         q5EVLVAu/wnFBXzVnoClriqz0zInrjEzryirrXUmoUMxMg6JwB4ebwGy4T3oWB3LZ6Mq
         g0SXQzgAJJgAiHwQKEVhPvQ9TvpOc4wn7Qi8d4kdtQ7PJjmEYmAvriCFWBbr9nkFCtR9
         s1z0HnFmWbJpTt0cdcYMPCb4pWwuXP3ymDWhYjCFic6siLAIogjYdDwh3umFkMN19MBT
         ip3A==
X-Gm-Message-State: AOAM53180AzwD+8LgeQKn8NJSiTaEdKQiI0A7yPK+mko1XfkddpFmon1
        tuVJxFvo/2uvxF10TY6ba8JUbcyuDyN5jwj1yNhDxqMzGFZejEKPh6iK80RP1wX2LhMbE++lJWg
        jyt2PI6uDEeOY
X-Received: by 2002:a1c:e907:: with SMTP id q7mr2927964wmc.161.1607522266291;
        Wed, 09 Dec 2020 05:57:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxMeLNQaq9yaRXBam9XgBs+viGUtUlgrPP48Wufhnb5c2AlzIDR1iKOI7IAmIAGlK5oE215tg==
X-Received: by 2002:a1c:e907:: with SMTP id q7mr2927929wmc.161.1607522265964;
        Wed, 09 Dec 2020 05:57:45 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a21sm3422897wmb.38.2020.12.09.05.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 05:57:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D5841180003; Wed,  9 Dec 2020 14:57:42 +0100 (CET)
Subject: [PATCH bpf v4 6/7] selftests/bpf/test_offload.py: reset ethtool
 features after failed setting
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Simon Horman <simon.horman@netronome.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Jiri Benc <jbenc@redhat.com>, oss-drivers@netronome.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Wed, 09 Dec 2020 14:57:42 +0100
Message-ID: <160752226280.110217.10696241563705667871.stgit@toke.dk>
In-Reply-To: <160752225643.110217.4104692937165406635.stgit@toke.dk>
References: <160752225643.110217.4104692937165406635.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

When setting the ethtool feature flag fails (as expected for the test), the
kernel now tracks that the feature was requested to be 'off' and refuses to
subsequently disable it again. So reset it back to 'on' so a subsequent
disable (that's not supposed to fail) can succeed.

Fixes: 417ec26477a5 ("selftests/bpf: add offload test based on netdevsim")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/test_offload.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
index 51a5e4d939cc..2128fbd8414b 100755
--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -946,6 +946,7 @@ try:
     start_test("Test disabling TC offloads is rejected while filters installed...")
     ret, _ = sim.set_ethtool_tc_offloads(False, fail=False)
     fail(ret == 0, "Driver should refuse to disable TC offloads with filters installed...")
+    sim.set_ethtool_tc_offloads(True)
 
     start_test("Test qdisc removal frees things...")
     sim.tc_flush_filters()

