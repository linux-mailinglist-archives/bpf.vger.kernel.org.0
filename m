Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BBC5A8124
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 17:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiHaPYX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 11:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiHaPYW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 11:24:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85CCD8E08
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661959461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rps/yJBAwXB89WpAJeggNdBtdGS1yl5U+irzY4lHG4M=;
        b=LW3EpAfFTfb0S4FJRQp4yaGZQph22z9WCcdAhzXC2Oq3RGyR8SXfiep4MIhNXhTOzYpPqm
        3d3PpVH4Jzy0d30cBmE36/beGK3j/HYWxPDS1zbpxYYrM6dGSrgkA5/XdHfMXBEZcoHbMc
        y6iuKmoMGHNhB55eOyct7axj3pdM2rQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-cgakyn-RMqiyAdH_ON0bTQ-1; Wed, 31 Aug 2022 11:24:17 -0400
X-MC-Unique: cgakyn-RMqiyAdH_ON0bTQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37BE4294EDCA;
        Wed, 31 Aug 2022 15:24:17 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.39.192.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08062909FF;
        Wed, 31 Aug 2022 15:24:15 +0000 (UTC)
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, alexei.starovoitov@gmail.com, jbenc@redhat.com,
        linux-security-module@vger.kernel.org,
        Yauheni Kaliuta <ykaliuta@redhat.com>
Subject: [RFC PATCH v2] bpf: use bpf_capable() instead of CAP_SYS_ADMIN for blinding decision
Date:   Wed, 31 Aug 2022 18:24:14 +0300
Message-Id: <20220831152414.171484-1-ykaliuta@redhat.com>
In-Reply-To: <20220831090655.156434-1-ykaliuta@redhat.com>
References: <20220831090655.156434-1-ykaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The capability check can cause SELinux denial.

For example, in ptp4l, setsockopt() with the SO_ATTACH_FILTER option
raises sk_attach_filter() to run a bpf program. SELinux hooks into
capable() calls and performs an additional check if the task's
SELinux domain has permission to "use" the given capability. ptp4l_t
already has CAP_BPF granted by SELinux, so if the function used
bpf_capable() as most BPF code does, there would be no change needed
in selinux-policy.

Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>
---

v2: put the reasoning in the commit message

---
 include/linux/filter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index a5f21dc3c432..3de96b1a736b 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1100,7 +1100,7 @@ static inline bool bpf_jit_blinding_enabled(struct bpf_prog *prog)
 		return false;
 	if (!bpf_jit_harden)
 		return false;
-	if (bpf_jit_harden == 1 && capable(CAP_SYS_ADMIN))
+	if (bpf_jit_harden == 1 && bpf_capable())
 		return false;
 
 	return true;
-- 
2.34.1

