Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9FA635540
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 10:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbiKWJQo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 04:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237385AbiKWJQ0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 04:16:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81EA107E7C
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 01:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669194926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h6NJyF3Bl1ww0vZedtGm4Ad4YUGZ4BuTkP8+fScUfRc=;
        b=TfbDOVeMnnJAiOt+ue5ym+YGu9mSluf/ZyBTu1fZjAEJalpiWOaKygie7PzWibIsYI10+6
        +bsmP9l4nhPp11av9CPhvGOoQJcMYKhmcWvEH1fNmOrDOtfPMj8tnqoPhgshGBoluRY0Qw
        9BkYPCx/JjR21tphxuM8Vuk8YGWRsto=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-336-bmph8bfJNG6OTUWnaXrlHQ-1; Wed, 23 Nov 2022 04:15:25 -0500
X-MC-Unique: bmph8bfJNG6OTUWnaXrlHQ-1
Received: by mail-wm1-f72.google.com with SMTP id q12-20020a1ce90c000000b003d00f3fe1e7so587740wmc.4
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 01:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6NJyF3Bl1ww0vZedtGm4Ad4YUGZ4BuTkP8+fScUfRc=;
        b=pS276QYXwiYtm1NLrDP00QVeTW2oT8NsH+TXreQ6wsaaXJ38c0Eb4r0DRU6zGuGmLA
         86imYl6wCVCqx1yXP6lhi6U6JdiWLAbu2v0cf/QYl4npjPBHWihQO2itrkQkyiz/87tf
         MQQw4B4EhgPXf4/Mtt3mZNcEVWgXyNAaIUyncFgFQ3DOW2/D8gOMUtLZTfUrxrsS9QwQ
         0uaJo0Xh8s4e601oKbcIC85w3dHzo5dth4zuWUvDqLs7wPdFdBO3M7pcQ3c8DZV1vQj5
         p82xkMGrkxAM5zFm4zeA556endD4uuaGqMA+35B2TeHO70E1BH/T5vTmVNg9m8cwkadz
         AHFA==
X-Gm-Message-State: ANoB5pk8c33Ogh7yK1U+yhECn7dOgYXyi3BX9j6tw0QlWr+S1G9f96dv
        bhWbLIKWN83qm/SlWPgZ++nCe2GSrKU+dDkkwT5VTyVwpA9oGomOVbqUsi/Gg3Vniq9mj4oW6nM
        t7904fHznDyqbd0ZLw+OozjnpEPG3S9Ts7Cr07u73Sb4x9GPnkIKyhkFkh72ZWyA=
X-Received: by 2002:a5d:4c4a:0:b0:236:6101:7b7d with SMTP id n10-20020a5d4c4a000000b0023661017b7dmr4672361wrt.484.1669194923767;
        Wed, 23 Nov 2022 01:15:23 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6QPf1nPs6W7zu8niMDm16iyzzSzi57V7EXYzZvtdjT0PP39ZgWJWa6VITHau28j9DSP5CL3w==
X-Received: by 2002:a5d:4c4a:0:b0:236:6101:7b7d with SMTP id n10-20020a5d4c4a000000b0023661017b7dmr4672343wrt.484.1669194923491;
        Wed, 23 Nov 2022 01:15:23 -0800 (PST)
Received: from localhost.localdomain ([78.19.107.254])
        by smtp.gmail.com with ESMTPSA id r13-20020a056000014d00b0024165454262sm16008369wrx.11.2022.11.23.01.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 01:15:22 -0800 (PST)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com,
        akiyks@gmail.com, Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH bpf-next v2 0/2] docs: fix sphinx warnings for cpu+dev maps
Date:   Wed, 23 Nov 2022 09:15:18 +0000
Message-Id: <20221123091520.87289-1-mtahhan@redhat.com>
X-Mailer: git-send-email 2.34.1
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

Sphinx version >=3.3 warns about duplicate function declarations in the
CPUMAP and DEVMAP documentation. This is because the function name is the
same for Kernel and User space BPF progs but the parameters and return types
they take is what differs. This patch moves from using the ``c:function::``
directive to using the ``code-block:: c`` directive. The patches also fix
the indentation for the text associated with the "new" code block delcarations.
---
v2:
- Fix references to user space.

---
Maryam Tahhan (2):
  docs: fix sphinx warnings for cpumap
  docs: fix sphinx warnings for devmap

 Documentation/bpf/map_cpumap.rst | 56 +++++++++++++++-----------
 Documentation/bpf/map_devmap.rst | 68 ++++++++++++++++++++------------
 2 files changed, 76 insertions(+), 48 deletions(-)

--
2.34.1

