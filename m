Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72765A79B9
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 11:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiHaJHF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 05:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiHaJHE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 05:07:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E814AB43E
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 02:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661936821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cMNfIgRTVmZqKAiwpQKkEBgXh25nieGSRIjhYl0Ufu8=;
        b=gnilemmSIRIDtxenExVvJttfgfi4CtTLAi7v/ejbwzoFYgkxHiwV8G8HKISPDcmN1KSmxi
        U9rtCgMMJ3enctBt6V7Vskab5Y/ZZDY43Aw2uLgjKxwS54TV+r28V14dNG4oF96qmNPxtw
        BbYjynwRvRO6q89liKc7FALsk+R2Esc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-lCFGhxHsPFSsbx6gktO6Mg-1; Wed, 31 Aug 2022 05:07:00 -0400
X-MC-Unique: lCFGhxHsPFSsbx6gktO6Mg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA24085A589;
        Wed, 31 Aug 2022 09:06:59 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.39.193.173])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B48F1415117;
        Wed, 31 Aug 2022 09:06:58 +0000 (UTC)
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     alexei.starovoitov@gmail.com, jbenc@redhat.com,
        Yauheni Kaliuta <ykaliuta@redhat.com>
Subject: [RFC PATCH] bpf: use bpf_capable() instead of CAP_SYS_ADMIN for blinding decision
Date:   Wed, 31 Aug 2022 12:06:55 +0300
Message-Id: <20220831090655.156434-1-ykaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'm wodering about the cap check against CAP_SYS_ADMIN. Is it
intentional to provide more security or oversight in commit
2c78ee898d8f ("bpf: Implement CAP_BPF")?

Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>
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

