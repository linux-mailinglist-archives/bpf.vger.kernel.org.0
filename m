Return-Path: <bpf+bounces-2430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 437C972CC5D
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 19:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23092811AD
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CA82106A;
	Mon, 12 Jun 2023 17:23:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386D21F931
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 17:23:14 +0000 (UTC)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97A610DC
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 10:23:12 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b3b3c69969so18458255ad.0
        for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686590592; x=1689182592;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=urWJm7reT2IarzSkE9tEiPm+OWYgjit92cM3b8fi47A=;
        b=StfmV5glCZgD5D5jo9VaRcx/yBvLgF4KheIO0x6k12Ul0fg3XF86kgkGHqp0qefrkK
         LZDa5zR6RY+o8+tbdNA3oO8QmrS6/sVgdsLgC3zcX2MoTTqD2KHfIjfH/kqmYMJE0kiz
         q2R45wMVbOK2H0wDfapQPyy+NPIHKJrDAtxPfb9u1q+Q/pg5nuiOzrtBr/n90ZUIPeeP
         mD2Sh9PfOXxsZBWB/OW2eawiDApto5dHYvSdnKEi8Hwbgrd+V+Tap+o5eXnIgSEgyEgg
         lULHAL5mip0nX0lW3T66zLJ1fCY2xk70M3V74jJ6GczBSB7s9BdP24ar1q6B1bH2TKHd
         /bhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686590592; x=1689182592;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=urWJm7reT2IarzSkE9tEiPm+OWYgjit92cM3b8fi47A=;
        b=AwLwqbiZ8jY3c2EBdi4K6ld44YPbFCkC/3NlVDNOFPCiDPDc4l64on7/GyO8LHJw2j
         W1+bRiOs4jaZ/7zgDrKMd2VApHi2t9MP5JctO7Z1spiNufcM0Hj8S0KZhZoV92+vpLn+
         Mp38/04P6ZfD13dNtiIDD7mz2VzdIVyHRMd3M1kp956tXzu7ItREdgXbCJzTk95+XpAC
         5wb1n25XbQVxAxgqKucD+BvByd5bz4NIUx4sIXVI6pAAgeMB7cHGNG28B9gx3avAlBjX
         RE3KTlAzP6hCIK7LL1/C4ST/N+wmtF/yotgcBGqDqiT/+lhP4M1odGsJpLggw3Rhmb6U
         xmOA==
X-Gm-Message-State: AC+VfDyTMg8cOFY6dzEwmxXLFvN0Gg9OLiWF8vGoy0bf3dX0rJLavc/x
	xl/lyXkbh+ZAKgXES8Yff0mN1u6F/KGp/l+LcdTMKw0S7ZLnxguamj7kmp4Kw26eXGraCY3Q0QP
	ctVvGW94Mp8XIyc5ALHshP+sgaB8G7VgQNDANuhJo6B4jbbjQhw==
X-Google-Smtp-Source: ACHHUZ5Z1OS46iO1QCtf08JRymmg3unv8Ntbh6VT8DSLR3zYyv7jOGK1qE8xfw6aCKVFuNCFoPxm9XY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:728f:b0:1b3:c0aa:2453 with SMTP id
 d15-20020a170902728f00b001b3c0aa2453mr943690pll.6.1686590592079; Mon, 12 Jun
 2023 10:23:12 -0700 (PDT)
Date: Mon, 12 Jun 2023 10:23:02 -0700
In-Reply-To: <20230612172307.3923165-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230612172307.3923165-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230612172307.3923165-3-sdf@google.com>
Subject: [RFC bpf-next 2/7] bpf: resolve single typedef when walking structs
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

It is impossible to use skb_frag_t in the tracing program. So let's
resolve a single typedef when walking the struct.

Cc: netdev@vger.kernel.org
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/btf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index bd2cac057928..9bdaa1225e8a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6140,6 +6140,8 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 	*flag = 0;
 again:
 	tname = __btf_name_by_offset(btf, t->name_off);
+	if (btf_type_is_typedef(t))
+		t = btf_type_by_id(btf, t->type);
 	if (!btf_type_is_struct(t)) {
 		bpf_log(log, "Type '%s' is not a struct\n", tname);
 		return -EINVAL;
-- 
2.41.0.162.gfafddb0af9-goog


