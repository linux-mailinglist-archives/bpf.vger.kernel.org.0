Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574685ACE7C
	for <lists+bpf@lfdr.de>; Mon,  5 Sep 2022 11:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbiIEJCB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Sep 2022 05:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbiIEJB7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Sep 2022 05:01:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086A527DFD
        for <bpf@vger.kernel.org>; Mon,  5 Sep 2022 02:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662368518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dLeCohLxvR1IgW/HiZ/lfOMApbQew6zDCrcm46gfzsg=;
        b=DB27CEMqUt0TwQCFnHebzDMCiLsiXVdVqvymltr3xMqbG5B6wxFLMsB9VkTlP6AN5xydsk
        UBUczgRgSwwjMGWCp0BpkbV0UulmZw/VnN0azNmteNZSOd8ysHIz92dDSIkwEpuVoDicu8
        WA4AnS/d77oHBGSe5oU7PDzIbWyMp8Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-Q4bg3dFPMgaGe3WH0qWvcw-1; Mon, 05 Sep 2022 05:01:54 -0400
X-MC-Unique: Q4bg3dFPMgaGe3WH0qWvcw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7A3A382ECC1;
        Mon,  5 Sep 2022 09:01:53 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.39.192.175])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FCB4492C3B;
        Mon,  5 Sep 2022 09:01:51 +0000 (UTC)
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, alexei.starovoitov@gmail.com, jbenc@redhat.com,
        daniel@iogearbox.net, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        Yauheni Kaliuta <ykaliuta@redhat.com>
Subject: [PATCH bpf-next] bpf: use bpf_capable() instead of CAP_SYS_ADMIN for blinding decision
Date:   Mon,  5 Sep 2022 12:01:49 +0300
Message-Id: <20220905090149.61221-1-ykaliuta@redhat.com>
In-Reply-To: <20220831090655.156434-1-ykaliuta@redhat.com>
References: <20220831090655.156434-1-ykaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The full CAP_SYS_ADMIN requirement for blining looks too strict
nowadays. These days given unpriv eBPF is disabled by default, the
main users for constant blinding coming from unpriv in particular
via cBPF -> eBPF migration (e.g. old-style socket filters).

Discussion: https://lore.kernel.org/bpf/20220831090655.156434-1-ykaliuta@redhat.com/

Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>
---
 Documentation/admin-guide/sysctl/net.rst | 3 +++
 include/linux/filter.h                   | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 805f2281e000..ff1e5b5acd28 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -101,6 +101,9 @@ Values:
 	- 1 - enable JIT hardening for unprivileged users only
 	- 2 - enable JIT hardening for all users
 
+where "privileged user" in this context means a process having
+CAP_BPF or CAP_SYS_ADMIN in the root user name space.
+
 bpf_jit_kallsyms
 ----------------
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 527ae1d64e27..75335432fcbc 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1099,7 +1099,7 @@ static inline bool bpf_jit_blinding_enabled(struct bpf_prog *prog)
 		return false;
 	if (!bpf_jit_harden)
 		return false;
-	if (bpf_jit_harden == 1 && capable(CAP_SYS_ADMIN))
+	if (bpf_jit_harden == 1 && bpf_capable())
 		return false;
 
 	return true;
-- 
2.34.1

