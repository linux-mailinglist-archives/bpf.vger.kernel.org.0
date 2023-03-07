Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9706ADE46
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 13:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjCGME4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 07:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjCGMEu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 07:04:50 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE7232510
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 04:04:49 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id j19-20020a05600c1c1300b003e9b564fae9so10246233wms.2
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 04:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678190688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CCNs2VyZQC/M/WIt8ft/4vfITmxvA5DpqIO7OzUg/pw=;
        b=bvtOrFddLQuwG6hjmc2hf0dZNnNip0UWrfqqDEpcb1yUw+bS7hwUR1eZd8Wmt0xUib
         sf4wFdvjgQN2/iD2SZhh4ZZHz33H9DkZ2qBpp2jTPztztVwo0jishTeHDqST5zytv/bA
         CiZA5UuSGf0hcYXEGcMFewQE8SqMe4W0dvI3JO5Li7mcJu40NXYhMrXV4ylzgLN8j17u
         LN9RzrzNEOTmXY7uXU0/Ds70NVLf2zr1NSkx7IAgYLtzsyH53zSJGkjsc6wkDZVqynka
         wBhDooiCiq+8EXvD5hlCS3+9G+oqyXVrpLZGPxVvj3+RVY9OIJ+SrQA4NvyZb6SGcs6E
         66yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678190688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CCNs2VyZQC/M/WIt8ft/4vfITmxvA5DpqIO7OzUg/pw=;
        b=ez608sKvS3/R5vmH9Fm5O+Q6JNfPjzVtCKy4YLbI6/wsN0G4u+BnuZCjRSF3/dr6d6
         nnlAUukzoJGKdQuj8gQRe8gbL5NG1Qq2/jZsvp8PnmwEistJdXq+/ieHC5L8hT3tFgj4
         R9W1KB+34wr328eJBihAHde3jEDunVuQyCXnT5PY46uuKIENVhKRlaPMopxnCh4A6DDo
         Qv+Nqe2NWsk/noQjgKFh5RHhhDCvjYyxmhxKMeqMGYgkqDHZD7fQcu4QPXLB9n4CW67u
         O8PNDtzpRX8I0Jjhfj87ufoxY7sKPxJSA7NQKr/BWYHBEyu74+RwttZN/+dcI3qtsX+4
         bC4w==
X-Gm-Message-State: AO0yUKUQ8/ZUZs0Z7lLEA2CDeF0gk8DXuIwnCtUoh/i5rOF7CGc8Zqtt
        ZsjfsnGof+5z1upL6PibBoU=
X-Google-Smtp-Source: AK7set+WlcFmdrjNXlPw24ts5aZ5EeWBcgGNRYfKL7SgZmFFarh91Y1ze2dZMsnpfmD+461oWVuSgg==
X-Received: by 2002:a05:600c:4e8f:b0:3eb:2da4:f32d with SMTP id f15-20020a05600c4e8f00b003eb2da4f32dmr12871778wmq.26.1678190687762;
        Tue, 07 Mar 2023 04:04:47 -0800 (PST)
Received: from ip-172-31-2-215.eu-west-1.compute.internal (ec2-34-255-118-91.eu-west-1.compute.amazonaws.com. [34.255.118.91])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003e209b45f6bsm18522081wmq.29.2023.03.07.04.04.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Mar 2023 04:04:47 -0800 (PST)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        bpf@vger.kernel.org, memxor@gmail.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v3 0/2] libbpf: usdt arm arg parsing support
Date:   Tue,  7 Mar 2023 12:04:38 +0000
Message-Id: <20230307120440.25941-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series add the support of the ARM architecture to libbpf USDT. This
involves implementing the parse_usdt_arg() function for ARM.

It was seen that the last part of parse_usdt_arg() is repeated for all architectures,
so, the first patch in this series refactors these functions and moved the post
processing to parse_usdt_spec()

Changes in V2[1] to V3:

- Use a tabular approach to find register offsets.
- Add the patch for refactoring parse_usdt_arg()

Puranjay Mohan (2):
  libbpf: refactor parse_usdt_arg() to re-use code
  libbpf: usdt arm arg parsing support

 tools/lib/bpf/usdt.c | 195 ++++++++++++++++++++++++++-----------------
 1 file changed, 118 insertions(+), 77 deletions(-)

-- 
2.39.1

