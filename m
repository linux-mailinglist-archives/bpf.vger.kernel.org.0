Return-Path: <bpf+bounces-7218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B03F7737AA
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 05:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF991C20E0F
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 03:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F72DF6E;
	Tue,  8 Aug 2023 03:21:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D3D15AB
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 03:21:19 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A319121
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 20:21:12 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bba04b9df3so45869765ad.0
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 20:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691464872; x=1692069672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNrm/+UjyC6jP3361KhAbnju37DBvc3v6PBY22LsM1M=;
        b=khfL3k+d/CGznwaO5bu9+cRGuRQ6fYxlH9gn4KFfrTBbf9tNYQ6PkS2QLz2ndsXr7u
         ZZFyAYrq4pkWZ2egL0T8+F1oRE2BdqG2AchQKzk5rpmHiJn7brKTCQ8ATfQT7sFIWFge
         +wJcsLzJca4mkXRRBfJXZfKyNTBPlv+eL9czPa03R4sohsTcUYnfsQxbhSXxU25FemRt
         iejLrUhpyeo72CMnzwLsp9SuIrXP3m4KaE4DHI1lDQX6YY5lFuWPo3Vo9fSW3SuO+lAg
         gxB6SIK1coQKqnReEqyCG/Z1l38wetEMXmr5Avzcf+u4KBASxQT7KEpJWvcaZOhS10vC
         fb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691464872; x=1692069672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNrm/+UjyC6jP3361KhAbnju37DBvc3v6PBY22LsM1M=;
        b=QX15ux7hMJ3TO0bgIQ9UTXB5frYS/35EYQp2LMF5kWOV3Kseq59YcP0MAetBcaa7n8
         LudVHcBFYjmDA3frYFlyEq/ofLZCTjoFjqyoBJPwOem4yAY7O+rVJiF7GS2LXCI46Ca4
         FfK+92H3bDcJlXJBEzzLIkkoaKnC+f7m3Ag5OqXcfhRDuB6sVClJJHTnl6eZX4nR0D6o
         gw/KcuRG1myECi617vad1WI+3V4lcFY3OyVfNqzxlJ3wlDZYJjHMlKO/+qA2zDklRw8D
         iHyVIHMhfWDvzJ8EOTIbCPHahIm5iVegdDqAF5Hm7zje/XKF2cQIR0D5C+AyvYM0eFJq
         jHUw==
X-Gm-Message-State: AOJu0YxZj1QkJVXR0qH6p+UUgRsDxhlbpTquG4CLkmx2MgoYZT5Vz8w0
	3M44mHa2kAGIfHkFQZnU513inQ==
X-Google-Smtp-Source: AGHT+IEf+1UGY33nl/NwIi62HwrnmxDbqQr/9EwPpV2GjIISAPneNKJbTvSnXmVCy/syiT18tgdayw==
X-Received: by 2002:a17:902:6909:b0:1b8:9461:6729 with SMTP id j9-20020a170902690900b001b894616729mr10585584plk.2.1691464871774;
        Mon, 07 Aug 2023 20:21:11 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b001b896686c78sm7675800pli.66.2023.08.07.20.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 20:21:11 -0700 (PDT)
From: Albert Huang <huangjie.albert@bytedance.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Albert Huang <huangjie.albert@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Kees Cook <keescook@chromium.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: [RFC v3 Optimizing veth xsk performance 7/9] sk_buff: add destructor_arg_xsk_pool for zero copy
Date: Tue,  8 Aug 2023 11:19:11 +0800
Message-Id: <20230808031913.46965-8-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230808031913.46965-1-huangjie.albert@bytedance.com>
References: <20230808031913.46965-1-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

this member is add for dummy dev to suppot zero copy

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 include/linux/skbuff.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 16a49ba534e4..db999056022e 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -592,6 +592,8 @@ struct skb_shared_info {
 	/* Intermediate layers must ensure that destructor_arg
 	 * remains valid until skb destructor */
 	void *		destructor_arg;
+	/* just for dummy device xsk zero copy */
+	void		*destructor_arg_xsk_pool;
 
 	/* must be last field, see pskb_expand_head() */
 	skb_frag_t	frags[MAX_SKB_FRAGS];
-- 
2.20.1


