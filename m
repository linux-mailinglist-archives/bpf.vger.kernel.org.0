Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318E7556F75
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 02:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbiFWAch (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 20:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiFWAcg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 20:32:36 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCB241639
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 17:32:35 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r66so11642972pgr.2
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 17:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0OlBtbHx2pJ20jGrnc2KSnXpq7kmRYHkUCtKtQop8ug=;
        b=led+H5AtWo5wFkwszCJHc/G09wwQw7viWLV5cmgHGOJAib/s4kQ/1cjjU0XnWaUA/i
         Qd21F3nc+p5WeSjlTNrO3h9Rq+Hz1LgVcUzF8jKWgVqDNSPd4omS5NIzzfZXCnC0nM96
         TOxiFwUI2oetqbBJUhOcBImR1/7RHEw18s/p7qxf2mXm+zy2+Bm/gGGU9zhdf2vDH/VH
         tjt/32spKPaytkQbQjLajE9zvhKweBW+mJWF5Vb5QGRttLyrKr8XYWOWVbLgTlClf2vl
         pU6wNAo/kV+EOgfeHhbWy6NiwDuj5y89OC1JCNt5A2P0XkrE18K989lnPkxKOnH0jn9b
         HGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0OlBtbHx2pJ20jGrnc2KSnXpq7kmRYHkUCtKtQop8ug=;
        b=N92rCRGheLjuBzeMH6Boghjp9KMgYP3LfULr8BFCb0D6ku1iFfBwgGQvZCK8RIpFe1
         +HCfVUii2LEbXCD/nK0df/DoGgq7FQ+7C7DHvGI/MZFpZ2vwQqhlESW29d4qUYmzSSnd
         731Z0QozqWiJMdWyEjaQiTfkn0vyPaQFC87TfU5ovL138P2PUjSe0kouNJiUO4kDWUb1
         8txerE8aSffd1sdYj8Yd+0ExFqIoFbW8TKfiGXKLOheYo8MewjjJHCWlwHD4VO/A7P2w
         7wImIvHKmumlMsyHCVeBLdtrwCFQfSQWQgG07VuX1UKLVE/vdxj6DH/rj0Bt23ZwjbeL
         Y6vA==
X-Gm-Message-State: AJIora+sdmsVkvemNMiy3QdhUgFlzy3V8shDTnR5AqiH1yqKLf13krd2
        Mhhq7dFQCzCr7iUObkSDJYI=
X-Google-Smtp-Source: AGRyM1sqCAP7EEZZYBHbnA2w0H920/VjFgybOsBBnNd6Z2DN0tjyf9EfSYCMMzpRCSSUPx84vRFS1g==
X-Received: by 2002:a65:464a:0:b0:408:b022:877a with SMTP id k10-20020a65464a000000b00408b022877amr5116333pgr.78.1655944354769;
        Wed, 22 Jun 2022 17:32:34 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:29cb])
        by smtp.gmail.com with ESMTPSA id ay21-20020a056a00301500b005251ec8bb5bsm7975101pfb.199.2022.06.22.17.32.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Jun 2022 17:32:34 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        kafai@fb.com, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
Date:   Wed, 22 Jun 2022 17:32:25 -0700
Message-Id: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Introduce any context BPF specific memory allocator.

Tracing BPF programs can attach to kprobe and fentry. Hence they
run in unknown context where calling plain kmalloc() might not be safe.
Front-end kmalloc() with per-cpu per-bucket cache of free elements.
Refill this cache asynchronously from irq_work.

There is a lot more work ahead, but this set is useful base.
Future work:
- get rid of call_rcu in hash map
- get rid of atomic_inc/dec in hash map
- tune watermarks per allocation size
- adopt this approach alloc_percpu_gfp
- expose bpf_mem_alloc as uapi FD to be used in dynptr_alloc, kptr_alloc
- add sysctl to force bpf_mem_alloc in hash map when safe even if pre-alloc
  requested to reduce memory consumption
- convert lru map to bpf_mem_alloc

Alexei Starovoitov (5):
  bpf: Introduce any context BPF specific memory allocator.
  bpf: Convert hash map to bpf_mem_alloc.
  selftests/bpf: Improve test coverage of test_maps
  samples/bpf: Reduce syscall overhead in map_perf_test.
  bpf: Relax the requirement to use preallocated hash maps in tracing
    progs.

 include/linux/bpf_mem_alloc.h           |  26 ++
 kernel/bpf/Makefile                     |   2 +-
 kernel/bpf/hashtab.c                    |  16 +-
 kernel/bpf/memalloc.c                   | 512 ++++++++++++++++++++++++
 kernel/bpf/verifier.c                   |  31 +-
 samples/bpf/map_perf_test_kern.c        |  22 +-
 tools/testing/selftests/bpf/test_maps.c |  38 +-
 7 files changed, 610 insertions(+), 37 deletions(-)
 create mode 100644 include/linux/bpf_mem_alloc.h
 create mode 100644 kernel/bpf/memalloc.c

-- 
2.30.2

