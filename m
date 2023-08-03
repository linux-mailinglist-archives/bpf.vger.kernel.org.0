Return-Path: <bpf+bounces-6865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B805C76EBEC
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 16:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A86280D32
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 14:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C491921D4A;
	Thu,  3 Aug 2023 14:06:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96879200C4
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 14:06:46 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9104F4228
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 07:06:44 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8ad8383faso8912175ad.0
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 07:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691071604; x=1691676404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLnjc8jPq2PoD5M5aiFgUeVBrc9aIeJJlwbo6fwSV28=;
        b=PniuI4mhE+9Hr5kVvw8WodCwDYHCknlrSoi4oY/F/4MMl9qgwDvgyPHh76hzQ6TSjH
         Vd0kAhHQsPBcV7x4jj/bvR4YBGspwCSImxmOJnMrRL7xOC6KwcEj9UDlYCeE9sLTaJh5
         a8SJArDhjkzS9FNXvbI3C6V+aHuAWEdph5x0qqqWF352VlalvDF0dWL3rqWtUR1xQ0yu
         7kasjrpqgsxNGpDDdDWhB2qbQGwLM4HYCXkVaBmBqQm4ke9nl12IufmKSnFbwO+bgZWO
         UEWrwVu6BztJAvACi1qE0AXwr+3xmtO4RtI/OJr2LdfmbI53BnQ9b9o8HUYub4rpIsjD
         Ex7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071604; x=1691676404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLnjc8jPq2PoD5M5aiFgUeVBrc9aIeJJlwbo6fwSV28=;
        b=X+fsiy0cSdgzIaCFbjksA7pAPTGlGxgoWLKMWkZgdSZ9id9/NMBi2nm7uW98Rq7qQ2
         iAh0A5ChDs0izgPjNqDhqg0RN56LvXBYib4KISSwun9IcN8yyE/aI2jdn2gnS5cWj2JM
         xA0SpsZMlz4jTTAh1MJwLGCV5tuh+AsDhPGXuIorD/L6Rkc5tnrKkJFxcQu7AcqjvBI0
         4Mh3Y2aeuFIxDIWwGSddzt1iuA9exYlYwRmQsvAbaP7R490X8h44ai49W4X6vv+Ocybe
         l6vPhtNDpZh8ugqb3wuWLJs3ULRwPtSkIAvg3TnjEFK72OYpihP6Ci6TqUb/ChxyT3Hn
         WVYg==
X-Gm-Message-State: ABy/qLaGod3623fmyvSAfrTPjxqIy0PIcjS/VlCakjNYsN0yzFqXXgbm
	Gkug6dHYiHSxxv0mciG73Lq0ag==
X-Google-Smtp-Source: APBJJlGBfvMWrRFHnBIykTOaed0DaYtu47ZrmnPZAuDr9AgMye0iCQDRpN4u3trjXrWFZSDvLs74ig==
X-Received: by 2002:a17:903:22c8:b0:1bb:b91b:2b40 with SMTP id y8-20020a17090322c800b001bbb91b2b40mr22927532plg.60.1691071603910;
        Thu, 03 Aug 2023 07:06:43 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2001:c10:ff04:0:1000::8])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b001b8a897cd26sm14367485plb.195.2023.08.03.07.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:06:43 -0700 (PDT)
From: "huangjie.albert" <huangjie.albert@bytedance.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: "huangjie.albert" <huangjie.albert@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>,
	Richard Gobert <richardbgobert@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path))
Subject: [RFC Optimizing veth xsk performance 08/10] xdp: add xdp_mem_type MEM_TYPE_XSK_BUFF_POOL_TX
Date: Thu,  3 Aug 2023 22:04:34 +0800
Message-Id: <20230803140441.53596-9-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230803140441.53596-1-huangjie.albert@bytedance.com>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

this type of xdp mem will be used for zero copy in
later patch

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 include/net/xdp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index d1c5381fc95f..cb1621b5a0c9 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -42,6 +42,7 @@ enum xdp_mem_type {
 	MEM_TYPE_PAGE_ORDER0,     /* Orig XDP full page model */
 	MEM_TYPE_PAGE_POOL,
 	MEM_TYPE_XSK_BUFF_POOL,
+	MEM_TYPE_XSK_BUFF_POOL_TX,
 	MEM_TYPE_MAX,
 };
 
-- 
2.20.1


