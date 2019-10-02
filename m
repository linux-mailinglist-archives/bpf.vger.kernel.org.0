Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBE4C89A6
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2019 15:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfJBNae (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Oct 2019 09:30:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbfJBNae (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Oct 2019 09:30:34 -0400
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 97DF96B
        for <bpf@vger.kernel.org>; Wed,  2 Oct 2019 13:30:33 +0000 (UTC)
Received: by mail-lj1-f198.google.com with SMTP id 205so4852914ljf.13
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2019 06:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=m4Sgqjpq9WV+RhLcG+8KSrXV2gMjNXZLDdtwQU6v3z4=;
        b=BWpLWfFayRtN6P4nzJPwkA06xPzesmGPc93Wa9dvQdGaqYrUdobS1Dvtx1+hkRScqN
         orLlpaLJalYozb3Kyqq3Wqdbwjdg2h2nNufwFH33jC4TB8+zs6PGGgToyigAR45MO//U
         r4NHoX9l+FI6V9XzekGhoPD3FjAoyRxc/tIj4Cguwe0tD+LXxrzKsQb8ihWODQt3zUh2
         hsc9hiiSJ974uOLWdhNNQJSLiVkznCxQ0f1tub5rOmvkuw05crieUDi9Y3iCoNwPkUJR
         D6WhY8mL0FkbBQoc2Ug2eFVKCT2AHwBRjFCZl4ihjM45sWfX+BYxmsIQmXOIbteY54X0
         bK0w==
X-Gm-Message-State: APjAAAUkbyTllwp06DFrlleFC9P/wc3XdlEZEUgJbLQBs//uLDphTyLA
        YQKVZHgolO9uGS5axPN+S0qtgxGKWmRJLBdVlcV6L7+67MxQ3i1vYANb42MKjrxKX1rbUHxsjkU
        IKNPc/W+vOdca
X-Received: by 2002:a2e:5d98:: with SMTP id v24mr2651135lje.56.1570023032150;
        Wed, 02 Oct 2019 06:30:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw8cCkbNqL5TPDLmGDHggFEX6DkEsYyT6fJtdlXaqWq9FMXWMaNejYh7ICfgXbSYzvKA+MfaA==
X-Received: by 2002:a2e:5d98:: with SMTP id v24mr2651117lje.56.1570023032001;
        Wed, 02 Oct 2019 06:30:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id y204sm4601049lfa.64.2019.10.02.06.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 06:30:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1A9D6180642; Wed,  2 Oct 2019 15:30:30 +0200 (CEST)
Subject: [PATCH bpf-next 5/9] tools/include/uapi: Add XDP chain map
 definitions
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
Date:   Wed, 02 Oct 2019 15:30:30 +0200
Message-ID: <157002303003.1302756.7196736864367141657.stgit@alrua-x1>
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

This syncs the XDP chain-map related UAPI definitions into
tools/include/uapi.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/include/uapi/linux/bpf.h     |   12 ++++++++++++
 tools/include/uapi/linux/if_link.h |    2 ++
 2 files changed, 14 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 77c6be96d676..8b336fb68880 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -136,6 +136,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_STACK,
 	BPF_MAP_TYPE_SK_STORAGE,
 	BPF_MAP_TYPE_DEVMAP_HASH,
+	BPF_MAP_TYPE_XDP_CHAIN,
 };
 
 /* Note that tracing related programs such as
@@ -3153,6 +3154,17 @@ enum xdp_action {
 	XDP_PASS,
 	XDP_TX,
 	XDP_REDIRECT,
+
+	__XDP_ACT_MAX /* leave at end */
+};
+#define XDP_ACT_MAX	(__XDP_ACT_MAX - 1)
+
+struct xdp_chain_acts {
+	__u32 wildcard_act;
+	__u32 drop_act;
+	__u32 pass_act;
+	__u32 tx_act;
+	__u32 redirect_act;
 };
 
 /* user accessible metadata for XDP packet hook
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 4a8c02cafa9a..7387d2371489 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -974,6 +974,8 @@ enum {
 	IFLA_XDP_DRV_PROG_ID,
 	IFLA_XDP_SKB_PROG_ID,
 	IFLA_XDP_HW_PROG_ID,
+	IFLA_XDP_CHAIN_MAP_FD,
+	IFLA_XDP_CHAIN_MAP_ID,
 	__IFLA_XDP_MAX,
 };
 

