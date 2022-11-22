Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10728633A5A
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 11:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiKVKoW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 05:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiKVKnx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 05:43:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FAD2715B
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 02:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669113464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XmUKDHdVGsNkfncddihI4gbw7w+v9jTt1/8A8XS8FPQ=;
        b=iMSezm/DxoIwvScyiD/zDL/0Ambrje9s4EJnGSA5ksIOX0Msy9j0a3VgAR61tz09UifWXM
        lxlhd6k1oqFTwwfTlyUL+2K/QZxpwgHjCqhHVYsn2KL5FZg4xpO57HjK/sUpzppj/9Vvz9
        SZ71CVPuKmTYVAXQJDZC11WBFY9Hyc8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-222-9m9UsILwMmqj3517fdYTpw-1; Tue, 22 Nov 2022 05:37:42 -0500
X-MC-Unique: 9m9UsILwMmqj3517fdYTpw-1
Received: by mail-wr1-f71.google.com with SMTP id t12-20020adfa2cc000000b0022adcbb248bso4059296wra.1
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 02:37:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XmUKDHdVGsNkfncddihI4gbw7w+v9jTt1/8A8XS8FPQ=;
        b=qiI8t8cJI3G4dYPz+IAzgjf4zP/Zppbo9HjPs1a05Gp/okXJ4FeZn2Gpq5RVpkJFzx
         qATXR4hBg0Z89TXLqGovMlWqzco/nTk1BQW3jF69fmrkBdqwdCY6m8Kq9b+OOv+duNIM
         uSCLAel1jQ2qKYBxUY+TNH9q1CQfDuw4a0KoJNnh6MAz0MZPAU9fGtnCYokn8a68CtqV
         Xaabpos2Gb4RnkWrOhF1WfVvH67UZaqSuJGwKYcDqCtZ6bqyiGECSo8EF/8+dC9p6yrW
         yDRg5fv+r41RrZtUMoWW8q9zhUfg0sLxsRbUQlmJz/e2HTIxxOJuNb3jvV25MjYTvfEb
         6vfA==
X-Gm-Message-State: ANoB5pk0EXOmB2ZhBgtu1uumAS6pcpN3Y/uyCIdp90Cha7SU+ewo2vpR
        8+aXpGCRLbvQOGvHRCJT/U1oJ5rbuwk8Brb7r47toDGgSyz84+v71gPcBAQ9u2HiwOcv3fmj2wU
        bfFWGfsppnZxk6WYatl8W9Nt4zMBCaDssTPPevF4kZYppEP2vKRIzRZ2vRSA8HlU=
X-Received: by 2002:adf:dccf:0:b0:236:5a0:9fd9 with SMTP id x15-20020adfdccf000000b0023605a09fd9mr14579124wrm.610.1669113461471;
        Tue, 22 Nov 2022 02:37:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5t/8Qnev5VOIU05eTBGUHJU3RL4CcoDOwFhHxwXxrMq8Gdu0R+CCUZtFQBYrm78WGJTEaXVQ==
X-Received: by 2002:adf:dccf:0:b0:236:5a0:9fd9 with SMTP id x15-20020adfdccf000000b0023605a09fd9mr14579105wrm.610.1669113461213;
        Tue, 22 Nov 2022 02:37:41 -0800 (PST)
Received: from teaching-eagle.redhat.com ([78.19.107.254])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c468b00b003c65c9a36dfsm18674438wmo.48.2022.11.22.02.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 02:37:40 -0800 (PST)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com,
        akiyks@gmail.com, Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH bpf-next v1 0/2] docs: fix sphinx warnings for cpu+dev maps
Date:   Tue, 22 Nov 2022 10:37:36 +0000
Message-Id: <20221122103738.65980-1-mtahhan@redhat.com>
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

Sphinx version >=3.3 warns about duplicate function delcarations in the
CPUMAP and DEVMAP documentation. This is because the function name is the
same for Kernel and Userspace BPF progs but the parameters and return types
they take is what differs. This patch moves from using the ``c:function::``
directive to using the ``code-block:: c`` directive. The patches also fix
the indentation for the text associated with the "new" code block delcarations.

Maryam Tahhan (2):
  docs: fix sphinx warnings for cpumap
  docs: fix sphinx warnings for devmap

 Documentation/bpf/map_cpumap.rst | 41 +++++++++++++-----------
 Documentation/bpf/map_devmap.rst | 54 +++++++++++++++++---------------
 2 files changed, 52 insertions(+), 43 deletions(-)

--
2.34.1

