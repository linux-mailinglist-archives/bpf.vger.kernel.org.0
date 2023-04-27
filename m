Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D55D6EFE46
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 02:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241255AbjD0AP3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 20:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbjD0AP3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 20:15:29 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ADC423B
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 17:15:05 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b4960b015so6213801b3a.3
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 17:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682554468; x=1685146468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=p8BN/hBbk0htTx4l5wW37bdKE5WA++7cRBEsp5y709I=;
        b=kcZf9aGo52SKcqF+yzW+B69V7jT9UqBZetR2vNhMy2HUm67EJ2LLzCmgcRipZ85/K4
         Zk3Ecua+n/Ah7dY5PU0qjwjgSyWJNpvm+QbeFmO2eo6FRmg+ZK3qmbX1NGP5OIQ5G2Hr
         zA+iiJAQbV6bfzeNpZyHzzCx9cMxbOEVacOt4tVhkpQAhNuaqbMGucbjaKk3YVW4yvvO
         Fg08S234h4EpVGiXg+VqhxtTAGbxu4KF8jC7kYjBV6ZqDh0RQ5XBE9datVkJmKDBLLEu
         DxCYyMOS7WXLcd/Sj0j/2vzTneXCoJCyEKQN5+aFRa04ZpQmXY1ZEcKJ4c5a7jQdTloE
         00gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682554468; x=1685146468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8BN/hBbk0htTx4l5wW37bdKE5WA++7cRBEsp5y709I=;
        b=FKl69xoWw++zp4EZ2Hc7wTRvFjQjK4kWfRHmX9wuGCQn/g45zwKOHAx+81Ecq1kKlD
         hBUnK/fsnD2SB3uqD6KWM0pqy0Cr2rPaJRFzNs0A7Vl9eFtILUI+nd4RjFpvf82cC7UY
         v45mzLV/qLgVqc5+GNxjgDRju7QBDYNpox0os7homYJCv/Yid3kC2Usr0sgecLJ3hDtO
         bmcDh7HLZHmDgMMbF/fCtNwA1bMhD+U/HwqtGkIooAn4HW7tOX1+fJyfVOIGKL3tv6BY
         nOIRKIb1VI/uA08gMWOjwicWVXG7rg6XXz18IeVsBY631R72B2Ts8Xf56Prymf9/EdyZ
         4xWg==
X-Gm-Message-State: AAQBX9ebpV7EvOJkc7L1vBxXBp6PVY8ak2BbEkm6MjAWo3k7GZt5cSD3
        NDQvH4G54JsetI6hsSix42M=
X-Google-Smtp-Source: AKy350ZZlHzh17iwXAjS+seR1mykgnZZTLMS7ceSNhJQDaIlpcDMGCKJYlNKTW/299/02mK4DabQhg==
X-Received: by 2002:a05:6a20:3c8a:b0:f3:1c8b:ce62 with SMTP id b10-20020a056a203c8a00b000f31c8bce62mr19034055pzj.47.1682554467719;
        Wed, 26 Apr 2023 17:14:27 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6700:7f00:b6d1:ca86:3852:86d1])
        by smtp.gmail.com with ESMTPSA id p37-20020a056a000a2500b0063d37a45829sm11900349pfh.63.2023.04.26.17.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 17:14:27 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Song Liu <song@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>
Subject: [HELP] failed to resolve CO-RE relocation
Date:   Wed, 26 Apr 2023 17:14:25 -0700
Message-ID: <20230427001425.563232-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

I'm having a problem of loading perf lock contention BPF program [1]
on old kernels.  It has collect_lock_syms() to get the address of each
CPU's run-queue lock.  The kernel 5.14 changed the name of the field
so there's bpf_core_field_exists to check the name like below.

	if (bpf_core_field_exists(rq_new->__lock))
		lock_addr = (__u64)&rq_new->__lock;
	else
		lock_addr = (__u64)&rq_old->lock;

Note that I've applied a patch [2] to fix an issue with this code.

It works fine on my machine (with a newer kernel), but failed on the
old kernels.  I guess it'd go to the else part without a problem but
it didn't for some reason.

Then I change the code to check the rq_old first.  It works well on
the old kernels but fails on newer kernels.. :(

    libbpf: prog 'collect_lock_syms': BPF program load failed: Invalid argument
    libbpf: prog 'collect_lock_syms': -- BEGIN PROG LOAD LOG --
    reg type unsupported for arg#0 function collect_lock_syms#380
    0: R1=ctx(off=0,imm=0) R10=fp0
    ; int BPF_PROG(collect_lock_syms)
    0: (b7) r6 = 0                        ; R6_w=0
    1: (b7) r7 = 0                        ; R7_w=0
    2: (b7) r9 = 1                        ; R9_w=1
    3: <invalid CO-RE relocation>
    failed to resolve CO-RE relocation <byte_off> [381] struct rq___old.lock (0:0 @ offset 0)
    processed 4 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0

I'm curious what went wrong with this.  I guess it's supposed to work
on any kernel verions by definition.  Not sure the compiler generated
a wrong reloc or something.  Maybe I just made silly mistakes..

Do you see anything wrong?  Any hints to debug this issue?

Thanks,
Namhyung


[1] file://linux/tools/perf/util/bpf_skel/lock_contention.bpf.c
[2] https://lore.kernel.org/lkml/20230423215650.287812-1-namhyung@kernel.org/
