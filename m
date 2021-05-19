Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12F33892EF
	for <lists+bpf@lfdr.de>; Wed, 19 May 2021 17:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhESPtK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 May 2021 11:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346171AbhESPtJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 May 2021 11:49:09 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BBDC061760
        for <bpf@vger.kernel.org>; Wed, 19 May 2021 08:47:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id f19-20020a05600c1553b02901794fafcfefso3094838wmg.2
        for <bpf@vger.kernel.org>; Wed, 19 May 2021 08:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wY0U3yml1FmuDrNFJkneaRlN73+pBj2uZ2euwBiv1Z8=;
        b=dJwug+GBOSQ4Jb9dCXIQ3v2tiBQVomPQCpAzKAkoC7BFwLVma39ktN3NYoZThfmCsj
         2YMaCzsh1ZACn9AxYa8FPB0UvmIiPVnMQ8quuiu0C5HWWLCHGRyj4ZFMRfUohz4Mls/b
         aEhvA4POXSQHanqgmbcSSjCfUN3jL83uOLr2dDPUb8/EyiphcbL1BBM9OF3N1eDZ2LF0
         G67EIOOciynbyJy8zwgKage02Aw0ztp0B4OGN3b2TIbFJ/Blrmrmn3z4pBzdurwokpFk
         l90biguz8ZCJ8/7Cp1HEhaBu4WJ+E8s3J0PbaIrKcFtYF2zxkfHZKDq8QOIWUpK6Ca3H
         RIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wY0U3yml1FmuDrNFJkneaRlN73+pBj2uZ2euwBiv1Z8=;
        b=qrDuhb331bc71l/1VnIAwCOjAgWWi6Exuk6wGTN/MUX43EL30QE3AKCE4y4Ta6hP7r
         7b1nSYQqY45zn9PIchFhXyGWXtpnAe/KHNnMjw3ae7RialOi7um8ChoyY2M2dfGlzZ4/
         ecgb8d5Ih1ZTUv1LHCXr042yWSCj1hE4erleAblHi039/4RzAhjm9p++WlIpUapFWtyo
         OMgtiJJ7NwbMZYvDdO39t2dAznfdu8hBIC89NXcL5P4jPKvBVcDdPUS7AcVya7lzIaVC
         FIKZ7nQ8HlcYdd1XV9sUxqySuHpnJuwfzxkiIR/w2AIFTQEJqVbrU+8EzldgOUFWERSa
         hjtg==
X-Gm-Message-State: AOAM532hjwnW8T9kjzD9FZ3oj7XDUdyS9jL6Bka7TUK+3A+qOZzzoo3a
        foao38LdqauaKncPOPPmx3NY6jxo/Pvp
X-Google-Smtp-Source: ABdhPJxrA9oNvYxUHlFtwEzFEGXcl9xXucdD4i7JVAHqSIudLLOhMcAqid6RtuaGOSIejspmOm7dNQ==
X-Received: by 2002:a05:600c:1551:: with SMTP id f17mr11973167wmg.124.1621439267295;
        Wed, 19 May 2021 08:47:47 -0700 (PDT)
Received: from balnab.. ([37.17.237.224])
        by smtp.gmail.com with ESMTPSA id y14sm6103722wmj.37.2021.05.19.08.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 08:47:46 -0700 (PDT)
From:   Jussi Maki <joamaki@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, andrii.nakryiko@gmail.com,
        Jussi Maki <joamaki@gmail.com>
Subject: [PATCH bpf v4 1/2] bpf: Set mac_len in bpf_skb_change_head
Date:   Wed, 19 May 2021 15:47:42 +0000
Message-Id: <20210519154743.2554771-2-joamaki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210519154743.2554771-1-joamaki@gmail.com>
References: <20210427135550.807355-1-joamaki@gmail.com>
 <20210519154743.2554771-1-joamaki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The skb_change_head() helper did not set "skb->mac_len", which is
problematic when it's used in combination with skb_redirect_peer().
Without it, redirecting a packet from a L3 device such as wireguard to
the veth peer device will cause skb->data to point to the middle of the
IP header on entry to tcp_v4_rcv() since the L2 header is not pulled
correctly due to mac_len=0.

Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
Signed-off-by: Jussi Maki <joamaki@gmail.com>
---
 net/core/filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index cae56d08a670..65ab4e21c087 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3784,6 +3784,7 @@ static inline int __bpf_skb_change_head(struct sk_buff *skb, u32 head_room,
 		__skb_push(skb, head_room);
 		memset(skb->data, 0, head_room);
 		skb_reset_mac_header(skb);
+		skb_reset_mac_len(skb);
 	}
 
 	return ret;
-- 
2.30.2

