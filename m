Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10765F52D0
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 12:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJEKqm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 06:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJEKql (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 06:46:41 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161E223392;
        Wed,  5 Oct 2022 03:46:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u10so25225950wrq.2;
        Wed, 05 Oct 2022 03:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MpRxnTo+J9HRDwstfFFVv8LiNgrWMYl/Xh706svFrps=;
        b=ogeXfendzYiUhDE4pMZ0+1FgHmMRvx5tZOu7G84hS2izLreCBNixYbrxY9hVZmcN9q
         oIeQoaJfy0wnAAb3X80OXVpkw6XE5ijLRcgilXtpE+rpGe7yGVdi6097j6U+MCdZ90Zq
         sWcyI24S/QNUVZDpOIY1E6j2/p+HbV1ySO01RwT73Pg4dvifElsxIZw7jmT0u7qskXFD
         KmIU/wbo4pG2njKvN4pAWt5ly64GY2bwt02D3bcitandREXMbVrhGHAfTL3my9/uuvO3
         k/tIYWeW9Qz90UDXlIMrCs5yAL6VskZyM7W07nrnIQlw2rT1c0WedyUNrHK+VD/DGKXr
         gGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MpRxnTo+J9HRDwstfFFVv8LiNgrWMYl/Xh706svFrps=;
        b=2jb/x7r7thi/PaQHI1EhQe4aJ7ioTCWf7SftSM51QqAh74BrINpgx/WLUtxlAMlgz2
         mX+FlrlsqgvQRfUg3Su6Yhy+y0/2OQuoploOC1DpVF0jspaHC6OEJ1EHkAbXdOT83VvQ
         YcCZuPH07336FaYCV9jfQKjcvVknedD6VCYSRKt26MdBfpFvdBAOAVt3+PJR0oX/9DGr
         omrpDRT5BN/R/5qW9KMRLUcF92QjaIy00kxT/mlT9Cp1e8brLy61TUZ3rOcbrqmrRIU/
         95zIOEXYTxBd8lgaCH0akuhyIgyuBCWzeqvD3ozAFjK6YFHdAHtnOE3WJM0Y8YTLTh00
         dcAQ==
X-Gm-Message-State: ACrzQf3pQ+8qMj+o0UU/LqNcXAiTrfxq6/piykAruqEcLZs2ob9gCQYJ
        zUvhgh+CDyvSULATiRrKcVpepuSwxKbAzQ==
X-Google-Smtp-Source: AMsMyM55C/pv3EKPMlpHhPDkU1D6o0YR7IPhMseMsctVANEuYZuMWsi9/+It90uovX0nl9uz3SWl5w==
X-Received: by 2002:adf:fb88:0:b0:22a:f742:af59 with SMTP id a8-20020adffb88000000b0022af742af59mr19206624wrr.230.1664966798188;
        Wed, 05 Oct 2022 03:46:38 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b4e1:6c12:775b:a638])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c474a00b003a5f54e3bbbsm1580959wmo.38.2022.10.05.03.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 03:46:37 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     dave@dtucker.co.uk, Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v6 0/1] Document BPF_MAP_TYPE_ARRAY
Date:   Wed,  5 Oct 2022 11:46:33 +0100
Message-Id: <20221005104634.66406-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add documentation for BPF_MAP_TYPE_ARRAY and BPF_MAP_TYPE_PERCPU_ARRAY
variant, including kernel version introduced, usage and examples.

v5->v6:
- Rework sample code into individual snippets
- Grammar mods suggested by Bagas Sanjaja

v4->v5:
- Use formatting consistent with *_TYPE_HASH docs
- Dropped cgroup doc patch from this set
- Fix grammar and typos reported by Bagas Sanjaya
- Fix typo and version reported by Donald Hunter
- Update examples to be libbpf v1 compatible

v3->v4:
- fix doctest failure due to missing newline

v2->v3:
- wrap text to 80 chars and add newline at end of file

v1->v2:
- point to selftests for functional examples
- update examples to follow kernel style
- add docs for BPF_F_MMAPABLE


Dave Tucker (1):
  bpf, docs: document BPF_MAP_TYPE_ARRAY

 Documentation/bpf/map_array.rst | 231 ++++++++++++++++++++++++++++++++
 1 file changed, 231 insertions(+)
 create mode 100644 Documentation/bpf/map_array.rst

-- 
2.35.1

