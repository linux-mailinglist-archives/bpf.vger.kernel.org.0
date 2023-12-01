Return-Path: <bpf+bounces-16418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35BA8012AE
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 19:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 640F5B2141E
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 18:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4287C54BDC;
	Fri,  1 Dec 2023 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="q5Vql7nv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBB6129
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 10:29:17 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-67a3e0fb11aso13308386d6.2
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 10:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701455356; x=1702060156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXDAaty5RvW7sna2sinn3YdzfOivIeDvoqLW5kj1+Sw=;
        b=q5Vql7nvBqtaEFq0Qybbrl1DM1khCLe6VCoKxes1PysozeVSdNFXNrtMoKVnC86V1X
         MdBJOp5gWh3GC+HOH8yOfOXDz54zmFvrt8iwm4mCwIZ6F0ayukj08vsLV31exkxVoTX5
         pR5J+T3zMg/SsCVlIMozdnGi48gtkPPiebUIit8TpO6cr+DPYxj1CrKXNq6cwnkA+L+T
         c85dxHKdaV3ITzc3nPrtvSQPogbEkmgbieI+q+whM03UQE749Hf/ToIieFn9ekw/jh8g
         CIsruGMpqVfsqff5y3trbED0Hv/kwh0mUxshbz5ispU7viEjHj0yN3YiP/PhGmDPRI2e
         dF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455356; x=1702060156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXDAaty5RvW7sna2sinn3YdzfOivIeDvoqLW5kj1+Sw=;
        b=fT+60QY2lvfNm75BWhO+Hg+LNZkpLy/H0em00Vz7ezlam7yo6PGG5OA6AfVgT6YbCU
         7DOouQ5sWpAyH9svp9ntX8SUpiCx1gY6pyIqWj/Cc6izkvrffbdWOzKDvGQLD4QNaz6w
         /auT5+SRujAKj7UKpmXXL4S2qzS8dtYhHtxvjqVTvtYA8F2hWGyR0l2XP0oIfe4BisCV
         EjawmJLFIQVCbqJZNT0K/V2zm+ucRyvGamqwxHVxydvdtvrTn3z9UrDiHeOTCrGl16Vv
         2Cm2+m1RtBuofKWxwQuzD1Y02TxvmvI8Yz4HaOrlkKrqqRZsXE2++9GQLfZKN06Fy2+s
         WOiw==
X-Gm-Message-State: AOJu0YzKkziZ/sUV03fPUCo0XNR0Uwj0u/mt18ewZicLJynVunTe916q
	CUu0sM+3Gzx+EgIfvBBdw3OO3A==
X-Google-Smtp-Source: AGHT+IF02JfTNKSARhCPX0BtP56SP2odh8C3TRc/IEjI11PQAtz4DVyGmUZbiqIBsWtDeFXttaAxQg==
X-Received: by 2002:ad4:48c4:0:b0:67a:3834:10a4 with SMTP id v4-20020ad448c4000000b0067a383410a4mr18047250qvx.14.1701455356608;
        Fri, 01 Dec 2023 10:29:16 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1618w-grc-15-174-91-6-24.dsl.bell.ca. [174.91.6.24])
        by smtp.gmail.com with ESMTPSA id s28-20020a0cb31c000000b0067a364eea86sm1702536qve.142.2023.12.01.10.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:29:16 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH net-next v9 07/15] rtnl: add helper to check if group has listeners
Date: Fri,  1 Dec 2023 13:28:56 -0500
Message-Id: <20231201182904.532825-8-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201182904.532825-1-jhs@mojatatu.com>
References: <20231201182904.532825-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of today, rtnl code creates a new skb and unconditionally fills and
broadcasts it to the relevant group. For most operations this is okay
and doesn't waste resources in general.

For P4TC, it's interesting to know if the TC group has any listeners
when adding/updating/deleting table entries as we can optimize for the
most likely case it contains none. This not only improves our processing
speed, it also reduces pressure on the system memory as we completely
avoid the broadcast skb allocation.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/linux/rtnetlink.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 971055e66..487e45f8a 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -142,4 +142,11 @@ extern int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 
 extern void rtnl_offload_xstats_notify(struct net_device *dev);
 
+static inline int rtnl_has_listeners(const struct net *net, u32 group)
+{
+	struct sock *rtnl = net->rtnl;
+
+	return netlink_has_listeners(rtnl, group);
+}
+
 #endif	/* __LINUX_RTNETLINK_H */
-- 
2.34.1


