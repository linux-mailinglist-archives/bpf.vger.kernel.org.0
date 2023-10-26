Return-Path: <bpf+bounces-13306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E7F7D7FD9
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 11:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A04E1C20F62
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 09:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D8C2942E;
	Thu, 26 Oct 2023 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Tk/kBd/Q"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D391286AC
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 09:42:31 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05F0194
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 02:42:29 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40859dee28cso5732675e9.0
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 02:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1698313348; x=1698918148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HArSpqZPnriBVqM6a+6khhT78r6G789Qs/4LaODD6I=;
        b=Tk/kBd/QIT3j6eXkXjxi6EvBo6Vnt4/YzXIAoSBkUT1n7eG9Kq6ditkvnQ03wce9S8
         QYhKVuQWJlM8Cu6PqVXq9JBk9XkyvHZU6WvqpSez5XJ3ZfXxxAfzordGk6sFQWMwcsEx
         fgYkvgImC9WEZQN5RUZd9NTmCHUQxSYYPm3162CR8SweMuqEhy25qGNDf4N4Lr+uPenW
         6yVUO98P6QELu74QwVdJJnSlEk/jYFL5lSUiFbEux9TNP3tn5TIwrguaAUl7K5NPRUv5
         3ofj/lR49F7cYP+Sm70cMMyXZESrqnY5TK3FTVPXJZYvliCNpANxCO7x9hERBxGEGy4t
         MYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698313348; x=1698918148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HArSpqZPnriBVqM6a+6khhT78r6G789Qs/4LaODD6I=;
        b=PStKZfxhU7shaGqhhM4jhdhRJUwnO5fyiN1rsP5VeXzZvpDzHua9nrzDhmR3stqdjc
         CNvjggEDYSUuGtnzSX23587UfSmZKQS8Lxztk9e/n5yXzWrpzNDaJMc2YTSaJcunPExm
         sE3DrBF7P0SuTsnQXu04bKGlrqgZ8aR/lrze4yLwRYYC8fLzeeMmly3dV5qrRuiNcRUA
         ELIlp1gQ+cPrH7eOyc3f5cvjJ6T6gEP3emIDLT6mmGUtkmj8EcA9gygb/By1G0gowQMp
         8pO1yuSvd6FnTJQU75GZ+g+3Jf/nYrd55G19XPDySo80DCNoGBM31W0y1bDBbL0vJ8qi
         1x3w==
X-Gm-Message-State: AOJu0YwlpLh5wa916eYhfLPGo+n5BjoZIbGG0c+/8fZ6cghw/odJZ4Ho
	Kv7we2Mjiv34oAD7xiccPo2fZXMe9xcof7ncJdrP0A==
X-Google-Smtp-Source: AGHT+IHA81hBBfFfihm+XPx+M9w6XCIHfa7NHg4Dr8s3r5hCxN2yfIsGFDpSflbONcfMlJ0pNOzekA==
X-Received: by 2002:a05:600c:5252:b0:407:8e68:4a5b with SMTP id fc18-20020a05600c525200b004078e684a5bmr15058391wmb.38.1698313347694;
        Thu, 26 Oct 2023 02:42:27 -0700 (PDT)
Received: from dev.. (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c470d00b00407460234f9sm2082121wmo.21.2023.10.26.02.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 02:42:26 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: bpf@vger.kernel.org
Cc: jiri@resnulli.us,
	netdev@vger.kernel.org,
	martin.lau@linux.dev,
	ast@kernel.org,
	andrii@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	andrew@lunn.ch,
	toke@kernel.org,
	toke@redhat.com,
	sdf@google.com,
	daniel@iogearbox.net,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH bpf-next 1/2] netkit: remove explicit active/peer ptr initialization
Date: Thu, 26 Oct 2023 12:41:05 +0300
Message-Id: <20231026094106.1505892-2-razor@blackwall.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231026094106.1505892-1-razor@blackwall.org>
References: <20231026094106.1505892-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the explicit NULLing of active/peer pointers and rely on the
implicit one done at net device allocation.

Suggested-by: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/netkit.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 7e484f9fd3ae..5a0f86f38f09 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -371,8 +371,6 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 	nk->policy = default_peer;
 	nk->mode = mode;
 	bpf_mprog_bundle_init(&nk->bundle);
-	RCU_INIT_POINTER(nk->active, NULL);
-	RCU_INIT_POINTER(nk->peer, NULL);
 
 	err = register_netdevice(peer);
 	put_net(net);
@@ -398,8 +396,6 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 	nk->policy = default_prim;
 	nk->mode = mode;
 	bpf_mprog_bundle_init(&nk->bundle);
-	RCU_INIT_POINTER(nk->active, NULL);
-	RCU_INIT_POINTER(nk->peer, NULL);
 
 	err = register_netdevice(dev);
 	if (err < 0)
-- 
2.38.1


