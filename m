Return-Path: <bpf+bounces-15183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1477EE3A3
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 16:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6781C20A8F
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 15:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815D4364BB;
	Thu, 16 Nov 2023 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="doLvgAm/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E3EAD
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 07:00:02 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1f03db0a410so426298fac.1
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 07:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700146801; x=1700751601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yEUgde+83Ie/CIdVOsUg/bpNgJ9RSPY4XMDhZVyzr4=;
        b=doLvgAm/DpQ91QvgrVUnAtUnTPqW2r2LjUpcqoZWaE2hygm87JVJQB7tHUlYkBw12l
         w6j04mNf9UBA7a3ELvSAE0NijAJoEgv1TgccF1r5Jm/F6gFd/p0BaSR6XLdge6nw2M1e
         7RsPJPJmourJznh2FiheKkAC9NqCgp+rQ0RywNilIgC9i7dt0Zf5kwkLjalbIXbbPv+2
         M2UeqSpO0UmvoirdrCehQQNcsNzDsXdRZZwfeqAevqYIouEpNX8LQMZYawpZQ211mP7Q
         8y6LEXU+UL9bc+psHeGRsiL30Gl+OEzsxW75fxD/AY+uUrYdV5DdUIglch1Tg1/29XkQ
         UUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146801; x=1700751601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yEUgde+83Ie/CIdVOsUg/bpNgJ9RSPY4XMDhZVyzr4=;
        b=Cbg7lawsiC2l2y72V5VDvsGHMq4kO+CIEMLEBxOnwG68Mkv6OIC6j8sVFrX4ax5pzc
         3fHIkpdFOgmfUKOXRMg1+XSeBv6kyLbFYW7o6NGokAvSQ86LJaSHusoxqZL/q3YkwbdQ
         Ed0pr8HJACmA2Und+0XNyn3o8fuObfUBxFaJalebdku7eAuY0+TdXcoAFCY0PWaZi17J
         p6zZELyzJhcNdETzCH7KpGMnSC7UJ2Q8kRCGfhKLD22/ne72Bzj4gwa20rA8KZ4TNea+
         LQFAYyo7mZScmPKFt2xUt/7Vg6jWOfVKtntdJfOA50VjZg0x0ugYlACQpKRecgI3fJho
         n7Ug==
X-Gm-Message-State: AOJu0YzBym3V9uYGuUpXpyIZPSX1IPzQm/sUIrKnxha86nequ3ZlZMYv
	ubiO2xo9ZJnnuTSUmzroX9dNCA==
X-Google-Smtp-Source: AGHT+IGv42MWmINDqiHfdrY603/s1/TR2Yx1Q5OV/ZKUA4tFYkGRH6GEkBkp9eGayYMcRqXKW7iCgw==
X-Received: by 2002:a05:6870:6c12:b0:1ea:e7e9:abc5 with SMTP id na18-20020a0568706c1200b001eae7e9abc5mr20738061oab.6.1700146801224;
        Thu, 16 Nov 2023 07:00:01 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1618w-grc-15-174-91-6-24.dsl.bell.ca. [174.91.6.24])
        by smtp.gmail.com with ESMTPSA id d21-20020a05620a241500b00774376e6475sm1059688qkn.6.2023.11.16.07.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 07:00:00 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
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
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com
Subject: [PATCH net-next v8 06/15] net: introduce rcu_replace_pointer_rtnl
Date: Thu, 16 Nov 2023 09:59:39 -0500
Message-Id: <20231116145948.203001-7-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116145948.203001-1-jhs@mojatatu.com>
References: <20231116145948.203001-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We use rcu_replace_pointer(rcu_ptr, ptr, lockdep_rtnl_is_held()) throughout
the P4TC infrastructure code.

It may be useful for other use cases, so we create a helper.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/linux/rtnetlink.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 3d6cf306c..971055e66 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -62,6 +62,18 @@ static inline bool lockdep_rtnl_is_held(void)
 #define rcu_dereference_rtnl(p)					\
 	rcu_dereference_check(p, lockdep_rtnl_is_held())
 
+/**
+ * rcu_replace_pointer_rtnl - replace an RCU pointer under rtnl_lock, returning
+ * its old value
+ * @rcu_ptr: RCU pointer, whose old value is returned
+ * @ptr: regular pointer
+ *
+ * Perform a replacement under rtnl_lock, where @rcu_ptr is an RCU-annotated
+ * pointer. The old value of @rcu_ptr is returned, and @rcu_ptr is set to @ptr
+ */
+#define rcu_replace_pointer_rtnl(rcu_ptr, ptr)			\
+	rcu_replace_pointer(rcu_ptr, ptr, lockdep_rtnl_is_held())
+
 /**
  * rtnl_dereference - fetch RCU pointer when updates are prevented by RTNL
  * @p: The pointer to read, prior to dereferencing
-- 
2.34.1


