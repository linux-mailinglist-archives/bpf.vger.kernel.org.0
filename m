Return-Path: <bpf+bounces-5281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E35C7595F4
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 14:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2321C20F85
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 12:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297DE14AB4;
	Wed, 19 Jul 2023 12:53:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E471614AA3;
	Wed, 19 Jul 2023 12:53:06 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECC91711;
	Wed, 19 Jul 2023 05:53:05 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-66869feb7d1so4636518b3a.3;
        Wed, 19 Jul 2023 05:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689771184; x=1690375984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/fyEQro42W9/vnF1W1U2M036ZnpKcRcNmVYZzD6x00=;
        b=PhxY4OnfjVmITv5WDZL1Jno7Qo60HvLZgFzy43D8wjBzKE3m/ajiJ/daixNL8+QZ5V
         Nr35Rcs/DQ0w9KEMTLh0NF14M4F3LBJxRdjidpVk2kVe2VYDcVNbTNzxj5HtjguyrV14
         LrGti1UuY7fGlGP9bXQY9VnxdZHctyF7UjlIrZq12BzOuJ1Sd+7fRZOcTuaSgyYlnek2
         Sq927Nmo7SUpuNiCIVDe1230ALkleCcDs45f5mOjE981tOL4r4X1njrERVzJUWwMpsvD
         cOh0emZ5UnHO3H+5Vv/+alUU6ta4LWEDJdRjuoefwCu4L97gspNZx9V5KrhbYXIEwwNR
         3LRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689771184; x=1690375984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/fyEQro42W9/vnF1W1U2M036ZnpKcRcNmVYZzD6x00=;
        b=diW9TgO0cfoRYSNjw0k37uHm8tRNFdW2x0M4iWoIPU+3cDUlQC3ymbVU55+rJe1sKG
         az7xXXnS5f481JvTPaWxSjfyYVX0mWxX1vCs2b0zk73PnqPtlmLGArP2LIMhgfqyOk6/
         Y4wtIvKdBk8eidVz60/6i75LK3bkuihLAm6A4RMc92tqjmB5bMWCBdyPRNvWg4tmPboH
         XZWh2bIK4nlBXk4pCV6XtUCYmoMt6QZsCYJID//UYJN5n0T1baTQucJeC146Walx+unv
         PFFTp+War9/yVpR+OWuq8kNK3sy2Ts16p2Yih1z9pHbNJn1t0MfCuUKVmLlpp1puKnpz
         EmjA==
X-Gm-Message-State: ABy/qLYUoxnfbDdUoFYm5HZfFEVi+LPaPL+4JcnUUOVj7y7GChkD6Jbg
	6Va05EKcjba3ybp8kamL0gk=
X-Google-Smtp-Source: APBJJlHxfRi7rH7QakBWvMMMSxzspOsiUYbuqZMpQZ+0eqUhb721X/KThVbk6weyzPIxX+8qGeP8bQ==
X-Received: by 2002:a17:90a:6548:b0:259:3e2a:b6d8 with SMTP id f8-20020a17090a654800b002593e2ab6d8mr15545272pjs.17.1689771184605;
        Wed, 19 Jul 2023 05:53:04 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id lc14-20020a17090b158e00b002612150d958sm1146191pjb.16.2023.07.19.05.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 05:53:04 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hawk@kernel.org,
	hffilwlqm@gmail.com,
	tangyeechou@gmail.com,
	kernel-patches-bot@fb.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v3 1/2] bpf, xdp: Add tracepoint to xdp attaching failure
Date: Wed, 19 Jul 2023 20:52:31 +0800
Message-ID: <20230719125232.92607-2-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719125232.92607-1-hffilwlqm@gmail.com>
References: <20230719125232.92607-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When error happens in dev_xdp_attach(), it should have a way to tell
users the error message like the netlink approach.

To avoid breaking uapi, adding a tracepoint in bpf_xdp_link_attach() is
an appropriate way to notify users the error message.

Hence, bpf libraries are able to retrieve the error message by this
tracepoint, and then report the error message to users.

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 include/trace/events/xdp.h | 17 +++++++++++++++++
 net/core/dev.c             |  5 ++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/xdp.h b/include/trace/events/xdp.h
index c40fc97f94171..35712ecfe9203 100644
--- a/include/trace/events/xdp.h
+++ b/include/trace/events/xdp.h
@@ -404,6 +404,23 @@ TRACE_EVENT(mem_return_failed,
 	)
 );
 
+TRACE_EVENT(bpf_xdp_link_attach_failed,
+
+	TP_PROTO(const char *msg),
+
+	TP_ARGS(msg),
+
+	TP_STRUCT__entry(
+		__string(msg,	msg)
+	),
+
+	TP_fast_assign(
+		__assign_str(msg, msg);
+	),
+
+	TP_printk("errmsg=%s", __get_str(msg))
+);
+
 #endif /* _TRACE_XDP_H */
 
 #include <trace/define_trace.h>
diff --git a/net/core/dev.c b/net/core/dev.c
index d6e1b786c5c52..062bbbb736f80 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -132,6 +132,7 @@
 #include <trace/events/net.h>
 #include <trace/events/skb.h>
 #include <trace/events/qdisc.h>
+#include <trace/events/xdp.h>
 #include <linux/inetdevice.h>
 #include <linux/cpu_rmap.h>
 #include <linux/static_key.h>
@@ -9411,6 +9412,7 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	struct bpf_link_primer link_primer;
 	struct bpf_xdp_link *link;
 	struct net_device *dev;
+	struct netlink_ext_ack extack;
 	int err, fd;
 
 	rtnl_lock();
@@ -9436,12 +9438,13 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 		goto unlock;
 	}
 
-	err = dev_xdp_attach_link(dev, NULL, link);
+	err = dev_xdp_attach_link(dev, &extack, link);
 	rtnl_unlock();
 
 	if (err) {
 		link->dev = NULL;
 		bpf_link_cleanup(&link_primer);
+		trace_bpf_xdp_link_attach_failed(extack._msg);
 		goto out_put_dev;
 	}
 
-- 
2.41.0


