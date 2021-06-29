Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1ADE3B7816
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 20:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbhF2S6x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 14:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbhF2S6v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Jun 2021 14:58:51 -0400
Received: from mail-qk1-x763.google.com (mail-qk1-x763.google.com [IPv6:2607:f8b0:4864:20::763])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4D5C061760
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 11:56:23 -0700 (PDT)
Received: by mail-qk1-x763.google.com with SMTP id q190so32097862qkd.2
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 11:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:dkim-signature:from:to:cc:subject:date
         :message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jwwj2sVJQ/nHOck0EqkMSQZ5jVBxyXXyL+ZZTxT8jCw=;
        b=WmX1zj02dO7rMSrw2ItjBb3iU6TRPrjIAKc6JusI1Yz9BXgGSGDAug8+kA8VH14nB6
         x/2NdM4MDbpCPqO6ZwMwk7iENfNhasEIdbXolkaDbZvMaphgHkZvdGghLHSUDsJ3iPJw
         mJ15Oz7N74cWcKcDWkVRUCaxaNM7vQgEpA56RdjrWZDIkOCZArqtVf2nyKCKcCLhFpCW
         U2KUIENM0b9IYBU671PVD9d9J22rScDqMWd//604lirKHaVw8AhiILNpafSuRINBV5Es
         wfW5XBWyXi9eje/TE2vsP9j4l7ECQ2yIdut4Og5gXoYmAIp98LyFDm55FYQcddF4+t8F
         GLUg==
X-Gm-Message-State: AOAM531O6hONmWh/132fWniiYnhZwaWKCBI9brNgdyfnH789QJRhnw/a
        1KUxvsL88TdaY4Qu/UXfTGWBuufixMWej1T/TrmcPYO747A/MA==
X-Google-Smtp-Source: ABdhPJz7Msr7PPzXF+2J6obL1RZWMjXp+V69koc8HenuTfI1p2k5oFpjwRC2KSJxx/Vv1e/ZsLLBG/WOx1Cl
X-Received: by 2002:a37:2e83:: with SMTP id u125mr33261063qkh.168.1624992983018;
        Tue, 29 Jun 2021 11:56:23 -0700 (PDT)
Received: from restore.menlosecurity.com ([13.56.32.60])
        by smtp-relay.gmail.com with ESMTPS id x12sm140628qki.6.2021.06.29.11.56.22
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jun 2021 11:56:22 -0700 (PDT)
X-Relaying-Domain: menlosecurity.com
Received: from safemail-prod-02790022cr-re.menlosecurity.com (13.56.32.61)
    by restore.menlosecurity.com (13.56.32.60)
    with SMTP id b254ed70-d90b-11eb-8cb0-a58ebe8ab229;
    Tue, 29 Jun 2021 18:56:22 GMT
Received: from mail-pj1-f70.google.com (209.85.216.70)
    by safemail-prod-02790022cr-re.menlosecurity.com (13.56.32.61)
    with SMTP id b254ed70-d90b-11eb-8cb0-a58ebe8ab229;
    Tue, 29 Jun 2021 18:56:22 GMT
Received: by mail-pj1-f70.google.com with SMTP id g19-20020a17090adb13b029016f4a877b4fso2376288pjv.8
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 11:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=menlosecurity.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jwwj2sVJQ/nHOck0EqkMSQZ5jVBxyXXyL+ZZTxT8jCw=;
        b=N1HkAdtmOLV2bK+tvbZcehVW6y1m/lKVx1aqP+fYkVk0YoMi2j1wR+KPXaaAA4XS9P
         v1qGhbTUGbmgAVLZ5KhjKHo5VvwyXJeDlIQW4IJUdpFpZr8xWWfsQyLTpB8FCD9XOFCw
         FQOEQwnklNktBqAcypqIS0zB7o4KfHRouZXRM=
X-Received: by 2002:a17:90b:4b04:: with SMTP id lx4mr335199pjb.54.1624992981736;
        Tue, 29 Jun 2021 11:56:21 -0700 (PDT)
X-Received: by 2002:a17:90b:4b04:: with SMTP id lx4mr335186pjb.54.1624992981555;
        Tue, 29 Jun 2021 11:56:21 -0700 (PDT)
Received: from localhost.localdomain ([12.219.129.130])
        by smtp.googlemail.com with ESMTPSA id t14sm19641260pfe.45.2021.06.29.11.56.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jun 2021 11:56:21 -0700 (PDT)
From:   Rumen Telbizov <rumen.telbizov@menlosecurity.com>
To:     bpf@vger.kernel.org
Cc:     dsahern@gmail.com, David Ahern <dsahern@kernel.org>,
        Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Subject: [PATCH 1/3] bpf: Add support for mark with bpf_fib_lookup
Date:   Tue, 29 Jun 2021 11:55:35 -0700
Message-Id: <20210629185537.78008-2-rumen.telbizov@menlosecurity.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210629185537.78008-1-rumen.telbizov@menlosecurity.com>
References: <20210629185537.78008-1-rumen.telbizov@menlosecurity.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: David Ahern <dsahern@kernel.org>

Add support for policy routing via marks to the bpf_fib_lookup
helper. The bpf_fib_lookup struct is constrained to 64B for
performance. Since the smac and dmac entries are used only for
output, put them in an anonymous struct and then add a union
around a second struct that contains the mark to use in the FIB
lookup.

Signed-off-by: Rumen Telbizov <rumen.telbizov@menlosecurity.com>
---
 include/uapi/linux/bpf.h | 16 ++++++++++++++--
 net/core/filter.c        |  4 ++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ec6d85a81744..6c78cc9c3c75 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5925,8 +5925,20 @@ struct bpf_fib_lookup {
 	/* output */
 	__be16	h_vlan_proto;
 	__be16	h_vlan_TCI;
-	__u8	smac[6];     /* ETH_ALEN */
-	__u8	dmac[6];     /* ETH_ALEN */
+
+	union {
+		/* input */
+		struct {
+			__u32	mark;   /* fwmark for policy routing */
+			/* 2 4-byte holes for input */
+		};
+
+		/* output: source and dest mac */
+		struct {
+			__u8	smac[6];	/* ETH_ALEN */
+			__u8	dmac[6];	/* ETH_ALEN */
+		};
+	};
 };
 
 struct bpf_redir_neigh {
diff --git a/net/core/filter.c b/net/core/filter.c
index 65ab4e21c087..2ea997cacf4d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5299,6 +5299,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	fl4.saddr = params->ipv4_src;
 	fl4.fl4_sport = params->sport;
 	fl4.fl4_dport = params->dport;
+	fl4.flowi4_mark = params->mark;
 	fl4.flowi4_multipath_hash = 0;
 
 	if (flags & BPF_FIB_LOOKUP_DIRECT) {
@@ -5311,7 +5312,6 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 
 		err = fib_table_lookup(tb, &fl4, &res, FIB_LOOKUP_NOREF);
 	} else {
-		fl4.flowi4_mark = 0;
 		fl4.flowi4_secid = 0;
 		fl4.flowi4_tun_key.tun_id = 0;
 		fl4.flowi4_uid = sock_net_uid(net, NULL);
@@ -5425,6 +5425,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	fl6.saddr = *src;
 	fl6.fl6_sport = params->sport;
 	fl6.fl6_dport = params->dport;
+	fl6.flowi6_mark = params->mark;
 
 	if (flags & BPF_FIB_LOOKUP_DIRECT) {
 		u32 tbid = l3mdev_fib_table_rcu(dev) ? : RT_TABLE_MAIN;
@@ -5437,7 +5438,6 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		err = ipv6_stub->fib6_table_lookup(net, tb, oif, &fl6, &res,
 						   strict);
 	} else {
-		fl6.flowi6_mark = 0;
 		fl6.flowi6_secid = 0;
 		fl6.flowi6_tun_key.tun_id = 0;
 		fl6.flowi6_uid = sock_net_uid(net, NULL);
-- 
2.30.1 (Apple Git-130)

