Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3667253B6AE
	for <lists+bpf@lfdr.de>; Thu,  2 Jun 2022 12:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiFBKMF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jun 2022 06:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiFBKME (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jun 2022 06:12:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75137210FBF
        for <bpf@vger.kernel.org>; Thu,  2 Jun 2022 03:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654164722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=8sGWDx8tIdBvhPO/h0ylxwLNV3dOuqabLVsz3GUUy20=;
        b=S3p0PO0aftBa801tWfZkhA3WXXQWtrB8AHDNHA9fQZ74GQyhTxqW+1UBGv4ymoV2IzIJse
        j4AXu4IenFrXjHu5F9ZZf2P3N/RYln4NJG8REBuwobWjR+4Iz1GlnCuJ7cKU3EkOl3lgdw
        pUlwzwwTfUEjQnmrYK6AS8SLUVLHyjQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-F9VFEzAmNJyCeuHprWzn1g-1; Thu, 02 Jun 2022 06:12:01 -0400
X-MC-Unique: F9VFEzAmNJyCeuHprWzn1g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27802185A79C
        for <bpf@vger.kernel.org>; Thu,  2 Jun 2022 10:12:01 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.39.195.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 67E34492C3B;
        Thu,  2 Jun 2022 10:12:00 +0000 (UTC)
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>
Subject: bpf_jit_blinding_enabled capabilities
Date:   Thu, 02 Jun 2022 13:11:58 +0300
Message-ID: <xuny1qw7xtld.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

I'm wodering about the cap check against CAP_SYS_ADMIN:

static inline bool bpf_jit_blinding_enabled(struct bpf_prog *prog)
{
        /* These are the prerequisites, should someone ever have the
         * idea to call blinding outside of them, we make sure to
         * bail out.
         */
        if (!bpf_jit_is_ebpf())
                return false;
        if (!prog->jit_requested)
                return false;
        if (!bpf_jit_harden)
                return false;
        if (bpf_jit_harden == 1 && capable(CAP_SYS_ADMIN))
                return false;

        return true;
}

Is it intentional to provide more security or oversight in commit
2c78ee898d8f ("bpf: Implement CAP_BPF")
(and should be bpf_capable())?


-- 
WBR,
Yauheni Kaliuta

