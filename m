Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A062F3AE8
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 20:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436811AbhALTnl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 14:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436805AbhALTnk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 14:43:40 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1D1C0617BA
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 11:42:05 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a12so3736858wrv.8
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 11:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RENS1yiCoqDoLkKN/GRTnjThUIFO+qOBX6TnsDEXMJ4=;
        b=M/GX6JJ7p2H2eTx80N54RrcrNovJmEJksJOoBQDaMLSzid6cmcZm7fhz67QqX1fL5P
         IdT39n+3quPjJon55Yrm52XJi48JC4N264PIWrap0CYeK86yDZZ+zEJcTwiKudRaOcu3
         wXoQ+xjsPaLtUxHrXSVu9o7ZzQRgJuokj+6KBtBcm0Zx+B7h8aZiYqFXJ3KjMQQyb1JP
         VOmGW/qJxnsFSZUkpX//QYy9P3sHgwODGlbccFdfwVkGYWPx3MNPz+nieZ4tlIyY6yLl
         osKVjKeNCMT8VtZGL5mmwM64fXLfHfr+b+cGMxg0fdz/BywiQ1W/2QgZOf6jp8KNqTTi
         Chyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RENS1yiCoqDoLkKN/GRTnjThUIFO+qOBX6TnsDEXMJ4=;
        b=qBzTC4aMwsyBKBMpf+gyM+QL3LmqcHQlgWt2fZM0p1XSjIUV2UbKB23OSzA7LWLcgZ
         S3FDydqjVAEBxLe4G4pfw4DYYQv0DZmLMrJp9lL7DtnukOvBzCscG1BqQlZB2YHusQVO
         8/fFB/Nz3561zkd4VdtU4y8exxP+E4HC/Q4w61SgjDTcq3baHJA7Eoy3yFB2JAjSKLBB
         xK6Dz/i73Ud7fVanO25vl+EulWub6EvBE3FlIUWLzHTlUdsiBmHp/6jvx7QS28+gO4Tu
         dKve89UpIuxQ69VkcpO64Q6Btz2ELp3v0mVDSkx/ttq56zRrqez4sZ9+Ca55FyIcVKDF
         iTVg==
X-Gm-Message-State: AOAM533sWEk45mSKFVM3bhd3M+fYT5X0CvALKWW5YSGeQ7jJB78OPYGj
        dYjXM0Pu3xq0Si1ghyRseiQyww==
X-Google-Smtp-Source: ABdhPJy88KkYeCfk/twqMv7qxLAVLrtcCRDSJ2F4RxIb3LJRD8cqoUZ55scrlMHcmG48qxh7J7CDhQ==
X-Received: by 2002:a5d:604b:: with SMTP id j11mr437008wrt.406.1610480524252;
        Tue, 12 Jan 2021 11:42:04 -0800 (PST)
Received: from f2.redhat.com (bzq-79-183-72-147.red.bezeqint.net. [79.183.72.147])
        by smtp.gmail.com with ESMTPSA id z63sm4885315wme.8.2021.01.12.11.42.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jan 2021 11:42:03 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     davem@davemloft.net, kuba@kernel.org, mst@redhat.com,
        jasowang@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        rdunlap@infradead.org, willemb@google.com, gustavoars@kernel.org,
        herbert@gondor.apana.org.au, steffen.klassert@secunet.com,
        nogikh@google.com, pablo@netfilter.org, decui@microsoft.com,
        cai@lca.pw, jakub@cloudflare.com, elver@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Cc:     yan@daynix.com
Subject: [RFC PATCH 3/7] tun: allow use of BPF_PROG_TYPE_SCHED_CLS program type
Date:   Tue, 12 Jan 2021 21:41:39 +0200
Message-Id: <20210112194143.1494-4-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210112194143.1494-1-yuri.benditovich@daynix.com>
References: <20210112194143.1494-1-yuri.benditovich@daynix.com>
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

