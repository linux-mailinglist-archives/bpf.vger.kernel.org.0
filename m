Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71867C89A7
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2019 15:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfJBNag (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Oct 2019 09:30:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727933AbfJBNaf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Oct 2019 09:30:35 -0400
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43D062BF7B
        for <bpf@vger.kernel.org>; Wed,  2 Oct 2019 13:30:35 +0000 (UTC)
Received: by mail-lj1-f199.google.com with SMTP id i18so1230015ljg.14
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2019 06:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Z3aw7R0clnfnDQPZcECbnXLHG6G+LnnHD4YWuHpSSVE=;
        b=DtxsQWPM9Qt7fV4WD/FWNmBoE7jeETv66VY/AWIFbFis207EMjtjMeFdWZGVXtnMuh
         mZ9kGX8IHnYNIIar9uFRUITMeCRTWRK+PGCnWyw3hBNwGDNucooitgNS7L6CpDPRbgj7
         BJMa4U3tFzHBkvGBnMMx1+6td1+IuHabvGBeXUHlTr/1d0zzEV+wtkLp4XsgsKjcgEcJ
         7KEoKkVF6zaArxbAKP+ahb0TezYFcfA1fNF9XDn1JBcxn8ZcN69pqKpMPeHQHbs5dkf1
         95RPaGdMsLKoelK2Rx2KxLrfu9aavnMEIWn98pYiZjJ0hnUbgqm8jnfB+16YdEsTyNhv
         CPSQ==
X-Gm-Message-State: APjAAAWCoynleYWkwKqu73ZJdpepEJaki1lhGQWNj0APvf9S/pVrM3bj
        iaDFWmF8VC4BkwWyDPfjTIcvK6zSUicW2u1xsJVdvBbNd7OEtKFAtzb/uEgNWpaKQ84HObxxj3g
        ajHZ3UcGgc1Cl
X-Received: by 2002:a2e:9006:: with SMTP id h6mr2573547ljg.42.1570023033807;
        Wed, 02 Oct 2019 06:30:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqykYZitPBp52SAOEI1k3J6U6u675MDEHLsa2zNAbHjI31o6qorB+plXloTHn1REs97Npunwdg==
X-Received: by 2002:a2e:9006:: with SMTP id h6mr2573536ljg.42.1570023033652;
        Wed, 02 Oct 2019 06:30:33 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id q24sm4523587lfa.94.2019.10.02.06.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 06:30:33 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2F4BC18063D; Wed,  2 Oct 2019 15:30:31 +0200 (CEST)
Subject: [PATCH bpf-next 6/9] tools/libbpf_probes: Add support for xdp_chain
 map type
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Date:   Wed, 02 Oct 2019 15:30:31 +0200
Message-ID: <157002303111.1302756.273260839640273673.stgit@alrua-x1>
In-Reply-To: <157002302448.1302756.5727756706334050763.stgit@alrua-x1>
References: <157002302448.1302756.5727756706334050763.stgit@alrua-x1>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

This adds support for the BPF_MAP_TYPE_XDP_CHAIN map type to
libbpf_probes.c.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf_probes.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 4b0b0364f5fc..266ae6e78f88 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -231,6 +231,10 @@ bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
 		if (btf_fd < 0)
 			return false;
 		break;
+	case BPF_MAP_TYPE_XDP_CHAIN:
+		key_size = sizeof(__u32);
+		value_size = sizeof(struct xdp_chain_acts);
+		break;
 	case BPF_MAP_TYPE_UNSPEC:
 	case BPF_MAP_TYPE_HASH:
 	case BPF_MAP_TYPE_ARRAY:

