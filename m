Return-Path: <bpf+bounces-2440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C44D72CF37
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 21:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1700228106C
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 19:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2AF8F41;
	Mon, 12 Jun 2023 19:16:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878698BF6
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 19:16:53 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33B219A7
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 12:16:51 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b160f3f384so2706797a34.3
        for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 12:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686597411; x=1689189411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfoNa8eyMesOZ+mrp6LfyUtPQmepCFaBCzuRxQH71aM=;
        b=eqmRo5UiKPNdNsGaDvv8oqy5zD6x6hsI9gZHwBv8VYoL5Qrj9s0avFTX/CH92HTu/y
         YV+/DMckb22z/Wta8QDYqNYKnOEFcn8hCt11EhglxxB8MRvadRv2eVQs7zMn6dys7jI5
         WkNt9IJw9wLHuTIqWLLlS3yE206q1YziX0bRC9pLMEcUOrO5fZZJn62ceQH16MjYhDHr
         ukt/el37HKLZb78WYIUO/W4ui4uHJu9kJZAdUBL9dqqtKuSp+pv/x49K+rOuraJASlJZ
         lT+wIx6LLpbGmVShs6h4dWUfBtCF2VqAoloBTi5daaq3PbBhiExez8HWi6J+3Ce6lE48
         umrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686597411; x=1689189411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfoNa8eyMesOZ+mrp6LfyUtPQmepCFaBCzuRxQH71aM=;
        b=WHsSC8sEi7zDs1ZJLa5RaJVnfGXCih4bhVOIM2Dbfg+kQoKqd08mGyxOMuA1PBt4HR
         4+sgMM3ltwj+CgdJWwh32rJim/DZqWIf3txMzTFYgUOjBCb28Uom/yc5KTVMcj0zEWVk
         6CBQMeWrRnyJPnqbt0NpMlW1lOxrHp2AXTALAZ+/SOPU2cZ/3eSuTAhmXmLpJJI98zYX
         sbOjtMwB/jIrIHfT0oQR8z/jYGDhd3jh/agXA83KzEHdXRBYGgSgpI4QXOCmxjrAButv
         IfGSU2QI1W9Kk9iZa9Zn9Fs8kPQlT+m1LPJIMlQyAK7lBmYKqU9Amym3HvqYbn/V9mgT
         RFNg==
X-Gm-Message-State: AC+VfDxmRXqFp9+Mff+a0PmIRftbNLsLCWIWsIFv6FQhyTnfIULQk/nJ
	ZQOP+Jm+ySQs3RnD3xv72+xoIhnRE+s=
X-Google-Smtp-Source: ACHHUZ50abIrFR66zYp7732Lfna7/CrHHCBE9+OjY+QkLZPa6ErJ83zldeNxgI7EPIVuCLk42B6VqQ==
X-Received: by 2002:a05:6359:29a:b0:129:c3a3:5efd with SMTP id ek26-20020a056359029a00b00129c3a35efdmr4450193rwb.24.1686597410693;
        Mon, 12 Jun 2023 12:16:50 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:df5d:2d08:1aa:9ce3])
        by smtp.gmail.com with ESMTPSA id y14-20020a25ad0e000000b00bc6a712c523sm1292607ybi.64.2023.06.12.12.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 12:16:50 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
X-Google-Original-From: Kui-Feng Lee <kuifeng@meta.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	daniel@iogearbox.net
Cc: Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next 1/2] net: bpf: Always call BPF cgroup filters for egress.
Date: Mon, 12 Jun 2023 12:16:40 -0700
Message-Id: <20230612191641.441774-2-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612191641.441774-1-kuifeng@meta.com>
References: <20230612191641.441774-1-kuifeng@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Always call BPF filters if CGROUP BPF is enabled for EGRESS without
checking skb->sk against sk.

The filters were called only if sk_buff is owned by the sock that the
sk_buff is sent out through.  In another words, sk_buff::sk should point to
the sock that it is sending through its egress.  However, the filters would
miss SYNACK sk_buffs that they are owned by a request_sock but sent through
the listening sock, that is the socket listening incoming connections.
This is an unnecessary restrict.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 include/linux/bpf-cgroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 57e9e109257e..e656da531f9f 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -199,7 +199,7 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 #define BPF_CGROUP_RUN_PROG_INET_EGRESS(sk, skb)			       \
 ({									       \
 	int __ret = 0;							       \
-	if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk && sk == skb->sk) { \
+	if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk) {		       \
 		typeof(sk) __sk = sk_to_full_sk(sk);			       \
 		if (sk_fullsock(__sk) &&				       \
 		    cgroup_bpf_sock_enabled(__sk, CGROUP_INET_EGRESS))	       \
-- 
2.34.1


