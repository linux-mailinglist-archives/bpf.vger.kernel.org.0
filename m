Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B5363958A
	for <lists+bpf@lfdr.de>; Sat, 26 Nov 2022 11:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKZKyE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 26 Nov 2022 05:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiKZKyD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 26 Nov 2022 05:54:03 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFCC19284
        for <bpf@vger.kernel.org>; Sat, 26 Nov 2022 02:54:03 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o5-20020a17090a678500b00218cd5a21c9so6191976pjj.4
        for <bpf@vger.kernel.org>; Sat, 26 Nov 2022 02:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YSYDlKL3Z1/BGWaIJQOht5oxOtXn/1L0eMJQR1ocH+c=;
        b=EifM15TcBTfVY8sEc5KLPETlc1+jDyCY7bqPd1/NdOXcKEqfYx6uTaiEtwDAhcDt/L
         77KJ/cWF9UXYQ9aBReyu82AfffTChgi1w3g3NopLt3SS930lidXzCFh3zm+oFuBiphzD
         kb3qxygTwxe6pRIprkwqceyslRJRPCfP2nsOZj3AhIrw/2ZZLy3EKiMNC8FBbsQAfNxK
         MDzkAhvjS4T19PZFRBjfPgLxpjBBwlX/TuT4p+A7Fb2pzZSI00OqAJB75TDLzx8IUtUh
         ItpiCRso8vPmBIspQ5KDWrQTNbYtU1qGpiFq+l0tL1RuOWH4U++ik0QFaQkhpCtxZ474
         b0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSYDlKL3Z1/BGWaIJQOht5oxOtXn/1L0eMJQR1ocH+c=;
        b=ixyA7iQcnvWZdWEhXBYGEeRhC4qu/V3mmNsnWvhU25AThgDMX2qMalnyLuhOlBSMRU
         9JcUTlNZMB9CLyFU2m2YISTLNZZ0QU91xHwAS54NJtzwpJeZqObpadETnhpp3X0I9vT8
         QUuoJeJG9YdErRg5ZW0Q0zO7KDUJGSXT+j2TT/4E+nFOwu3DFt8jeicXV1YxG+1Zq7tP
         M1WcOsS8SQAK6NUL+HEYT6KECsS235Jaq2+Tu7WxFMtidZ2Lo4Rb2KL5+3QbYei+RcRN
         V6gukhqHzMRW1pf+reyOBF2+QQO+g9ZwsuikumR68pJKeUShNWLpljpQ1mzI1LT+G5tF
         +jMQ==
X-Gm-Message-State: ANoB5pk6K/NBPrpZhFWCKXKDMbdSFsJSPERSOdkYWd8QlVYKWqTYaekz
        JH/lD7rYyLeSBMBNPgsXmAj4dSZvleI=
X-Google-Smtp-Source: AA0mqf6K0q4GUKePBr5knLRdDX8xzxaw2irUgh9NcBvV+sle0LgGD0PKzDo3qsqXdac13ensimJf4Q==
X-Received: by 2002:a17:90a:9f03:b0:211:59c6:6133 with SMTP id n3-20020a17090a9f0300b0021159c66133mr45171533pjp.238.1669460042637;
        Sat, 26 Nov 2022 02:54:02 -0800 (PST)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id z14-20020a1709027e8e00b00188fdae6e0esm5079904pla.44.2022.11.26.02.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 02:54:02 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com, toke@redhat.com,
        hengqi.chen@gmail.com
Subject: [PATCH bpf 0/2] Check timer_off for map_in_map only when map value has timer
Date:   Sat, 26 Nov 2022 18:53:49 +0800
Message-Id: <20221126105351.2578782-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The timer_off value could be -EINVAL or -ENOENT when map value of
inner map is struct and contains no bpf_timer.

The EINVAL case happens when the map is created without BTF key/value
info, map->timer_off is set to -EINVAL in map_create(). For example:

    map_fd = bpf_map_create(BPF_MAP_TYPE_LRU_HASH, NULL, 4, 4, 1, NULL);

The ENOENT case happens when the map is created with BTF key/value
info (e.g. from BPF skeleton), map->timer_off is set to -ENOENT as
what btf_find_timer() returns. For example, map created from BPF skeleton:

    struct inner_key {
    	__u32 x;
    };

    struct inner_value {
    	__u32 y;
    };

    struct inner {
    	__uint(type, BPF_MAP_TYPE_LRU_HASH);
    	__uint(max_entries, 1);
    	__type(key, struct inner_key);
    	__type(value, struct inner_value);
    } inner SEC(".maps");

    struct {
    	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
    	__uint(max_entries, 1);
    	__type(key, __u32);
    	__array(values, struct inner);
    } outer SEC(".maps");

Since timer_off is different, the map_in_map outer in the above case
can NOT be updated using map_fd in the first case. This patch tries
to fix such restriction.

Hengqi Chen (2):
  bpf: Check timer_off for map_in_map only when map value have timer
  selftests/bpf: Update map_in_map using map without BTF key/value info

 kernel/bpf/map_in_map.c                       |  9 ++++++-
 .../selftests/bpf/prog_tests/btf_map_in_map.c | 27 +++++++++++++++++++
 .../selftests/bpf/progs/test_btf_map_in_map.c | 22 +++++++++++++++
 3 files changed, 57 insertions(+), 1 deletion(-)

--
2.34.1
