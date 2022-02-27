Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8116B4C5E92
	for <lists+bpf@lfdr.de>; Sun, 27 Feb 2022 21:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiB0U2i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Feb 2022 15:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiB0U2h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Feb 2022 15:28:37 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3223842EC5
        for <bpf@vger.kernel.org>; Sun, 27 Feb 2022 12:28:00 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id w27so18094201lfa.5
        for <bpf@vger.kernel.org>; Sun, 27 Feb 2022 12:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B29fexB9ZTCKi7CISL13JlGHaQZbWyBbVpInY3I/6NY=;
        b=n2rDCDUhGA35dCXCp8qHKaMdSSUe2zvsERiPeW4R9DiGwFSaDGFbnuwd9ekhMpnjNP
         AF03weEkGiJ/MHjtpiFRl6/I2i20jBGTZCpzxHDU8fUBnfOMwbB+/mr+QQ8m0ff41dwV
         rmrDiw1gGFNPRzLDZmJhoPlktQMBlkP6i+Zjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B29fexB9ZTCKi7CISL13JlGHaQZbWyBbVpInY3I/6NY=;
        b=ZQYNf2BOwElR3LN4JSFXV6xmmCycesk3eFJu3dcm+uEvCK+ckT7jP/ncQmNWiIm5xY
         2/KOwRNs/cA0OT9oSn6GCHnWdE5aTmENdUyKU9XMQ729BsGSXptUX059lxPoTqVwUema
         7n2eb/5klS1NC96b2hj4MVUVokDUKwLhMBzv+dUOTOcm3F6PCXRWTB0V0kYbnOcF5aQu
         /9a9DElnU/WtJuuKw7f8gNRVRDA5xS6PqT3L6gmR2Kqq2trIxydqkbEFSN0jQT67p3Vx
         rPSAP8AlizkORSOfgKrWEWql6nCcY5ohcx9UWuDiuXxHKZJfPxrHTTQyfCpm4W9k+LP8
         /5kQ==
X-Gm-Message-State: AOAM531Vt9BV9mWlDgn68fTJUj4yjIxOaYfhZgQ4+Y4LXwMRHupzzXiI
        12VXPNBpxeh9HmYlLAs9BMatvNo4xLJa7w==
X-Google-Smtp-Source: ABdhPJxlN4WNaX+29tnCm2jCGZTJgPE6bCkxzfBp4SamcnaKzfaofey1Y+xHU7XF1oX06uMaRm83Pg==
X-Received: by 2002:ac2:4c1c:0:b0:443:5db3:4748 with SMTP id t28-20020ac24c1c000000b004435db34748mr10696549lfq.643.1645993678329;
        Sun, 27 Feb 2022 12:27:58 -0800 (PST)
Received: from cloudflare.com (2a01-110f-4809-d800-0000-0000-0000-0f9c.aa.ipv6.supernova.orange.pl. [2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id f8-20020a2e3808000000b002468b8ca6d1sm216008lja.27.2022.02.27.12.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 12:27:58 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@cloudflare.com, Martin KaFai Lau <kafai@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 0/3] Fixes for sock_fields selftests
Date:   Sun, 27 Feb 2022 21:27:54 +0100
Message-Id: <20220227202757.519015-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a respin of a fix for error reporting in sock_fields test.

Fixing the error reporting has uncovered bugs in the recently added test for
sk->dst_port access. Series now includes patches that address the broken test.

The series has been tested on x86_64 and s390.

v1 -> v2:
- Limit read_sk_dst_port only to client traffic (patch 2)
- Make read_sk_dst_port pass on litte- and big-endian (patch 3)

v1: https://lore.kernel.org/bpf/20220225184130.483208-1-jakub@cloudflare.com/

Jakub Sitnicki (3):
  selftests/bpf: Fix error reporting from sock_fields programs
  selftests/bpf: Check dst_port only on the client socket
  selftests/bpf: Fix test for 4-byte load from dst_port on big-endian

 .../selftests/bpf/progs/test_sock_fields.c    | 30 ++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

-- 
2.35.1

