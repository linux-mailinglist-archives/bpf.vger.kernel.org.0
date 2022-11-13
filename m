Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F916626EC7
	for <lists+bpf@lfdr.de>; Sun, 13 Nov 2022 10:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbiKMJkU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Nov 2022 04:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMJkT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 04:40:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BE4DE83
        for <bpf@vger.kernel.org>; Sun, 13 Nov 2022 01:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668332361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7aQcfARlP8kkqYFBPkiKIdeI1nmjJ0+x3xBdw4YF//Q=;
        b=CWjLkuutvefh94nzrYBZU5/Y//oVqwVkuBGiqF4opty8TVAp5mdN62NkIuIc+C3rQr0jrL
        CszSJpP+A7UBHKy87KQtKrrGplUCPjqec1yEkxsZBLJGxicS1hXkpcn78rmt8QDGngjfAF
        0phv1VWC/DdUdsiUx46Li3kLzCo9P8g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-62-vH0sYuLFPOmIeQB_BvKxfA-1; Sun, 13 Nov 2022 04:39:20 -0500
X-MC-Unique: vH0sYuLFPOmIeQB_BvKxfA-1
Received: by mail-qk1-f198.google.com with SMTP id h13-20020a05620a244d00b006fb713618b8so611052qkn.0
        for <bpf@vger.kernel.org>; Sun, 13 Nov 2022 01:39:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aQcfARlP8kkqYFBPkiKIdeI1nmjJ0+x3xBdw4YF//Q=;
        b=HSeHCHuBCQLMaBBY/GjZu/OIOdBRQxAZjEzV+Fv0QmXASBFVGYmVGTF8jeIwShVyWL
         0iJ2BneS8U52r8v0Uo6ETIe0hBNAcb8pKlvGmVcM50VvF3XbS2l4nDNkToV5zfaRGBAH
         lDWv4nlXrTjyRro4onrFAWBTqE2jPmvby6lYvTrf+/ZTzIFTRk5JThA88hmjm/UAU58C
         jhZZhjohXw+9cgq8Z13+hZu/3jRi+df3lrHszuO/szDmlzTWJWlSwZZIKephm6PxpyYv
         Pmv+fmKwNnx0LvfLFeWffIpOUc150iw3jOns7YhCw+/vIiccpUhSKrlYhhuB0Q6Foc3T
         fUQg==
X-Gm-Message-State: ANoB5pkEw57RV9Xx8+optAPqYDHWJpP57rSNiyWa1QoCebTmSHvF+Lxv
        DmdFZKMJp6rOmCgCIqnzR45P+7Qc1KbE8qs9Jzllh+RE/HEK+VvwPZUtz9+hbQvXexZPixyu8p9
        gun/Z09epbq9S+KVVg0O5R0Z556sYHJu+RDZdLcaZVbk2suZLiV4Eb/liIS4gVeE=
X-Received: by 2002:ac8:44a4:0:b0:3a5:3ae2:ff14 with SMTP id a4-20020ac844a4000000b003a53ae2ff14mr8114032qto.594.1668332360133;
        Sun, 13 Nov 2022 01:39:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4mMWgdRfQp+cXFnydxZrFlcpnHUuculWEqy7HZTQQ6S5CgdeY2JZ/iT2pPwdU0Wqi7a0BWug==
X-Received: by 2002:ac8:44a4:0:b0:3a5:3ae2:ff14 with SMTP id a4-20020ac844a4000000b003a53ae2ff14mr8114019qto.594.1668332359884;
        Sun, 13 Nov 2022 01:39:19 -0800 (PST)
Received: from nfvsdn-06.redhat.com (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id v65-20020a379344000000b006e54251993esm4462884qkd.97.2022.11.13.01.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 01:39:19 -0800 (PST)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com,
        akiyks@gmail.com, Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH bpf-next v1 1/1] docs: fixup cpumap sphinx >= 3.1 warning
Date:   Sun, 13 Nov 2022 05:33:27 -0500
Message-Id: <20221113103327.3287482-1-mtahhan@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Maryam Tahhan <mtahhan@redhat.com>

Fixup bpf_map_update_elem() declaration to use a single line.

Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
Reported-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/bpf/map_cpumap.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/bpf/map_cpumap.rst b/Documentation/bpf/map_cpumap.rst
index eaf57b38cafd..61a797a86342 100644
--- a/Documentation/bpf/map_cpumap.rst
+++ b/Documentation/bpf/map_cpumap.rst
@@ -48,8 +48,7 @@ Userspace
     program will result in the program failing to load and a verifier warning.
 
 .. c:function::
-    int bpf_map_update_elem(int fd, const void *key, const void *value,
-                   __u64 flags);
+    int bpf_map_update_elem(int fd, const void *key, const void *value, __u64 flags);
 
  CPU entries can be added or updated using the ``bpf_map_update_elem()``
  helper. This helper replaces existing elements atomically. The ``value`` parameter
-- 
2.35.3

