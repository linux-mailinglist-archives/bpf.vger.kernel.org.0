Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7F66528A3
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 23:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiLTWBu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 17:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLTWBt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 17:01:49 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C1D265B;
        Tue, 20 Dec 2022 14:01:48 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id m4so13663425pls.4;
        Tue, 20 Dec 2022 14:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GeQlTnnpn+N5vlDR0aEQP7sFxUyP4iUPfQQRONIzCc0=;
        b=ltFd0Nv8R6Bvp+g2bBtyFHboKO0TB6+C7ZrAQvM/jIW3/abbiVjrNG7iCTPNeXhI8k
         qWvBm/3jRESnhv+4qHS6D48BoOkY85BhhuUxTbRW5nUFaZm4WvkjN6VVT4AUWEOAgf4m
         FMXHE/T6nVXIlsxC9DDcXQVFcJ6kcQkF1Jc4WdXIbbu4ceZWde+29mtrGZmx0EIrsv+k
         RGIr11s5Ui8CLxK5aM3RiX0YcRVGp/7E92qSfdjNdVhIy3tmLbX1zH9oTh5nZ9HTyFCo
         YLpdkORq5m765b4f2cZKjCw6+rAb7xfBVulvqGk6X/rT101fGWjCZAEQ67k235tJySL5
         6IVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeQlTnnpn+N5vlDR0aEQP7sFxUyP4iUPfQQRONIzCc0=;
        b=nEgOgNDyTcPeKUhU77uGebqtFwj2PeDRydAulFbUoyNHcWqV7cs6yRiy/vWsfqpCYB
         jlNPFPq8EatX4cI4Djhfn6C/PZfQIMDUwASgrQg8o6isFJQTYCp7lh+HOHAzgN791O6B
         q/9DVPZrnb9YzXPPQwILSoRe6Rid2sa0jG/woj1lVOwdSceh8gR4y1K7VEBYRW9A54qZ
         h0PCtuHX+jD7prvFec/Aay6tbFbC0vFK4M3DLoWLyIrXN6+mevphlFDkRKs+1HFtccHN
         eMtuKnlL8SC8IRNKLfs9f5RXF8YwG8uUwO1tbAXcZJmruiApWekpbbYRSyYNPfRMp5QT
         c7zw==
X-Gm-Message-State: AFqh2kom92fU58SR2uFQ9CIyGiVLF1DSAdcTs9tG9UcUkbcaIWlrNdj2
        cxNL5vGEzBFHtA6h2CONdMo=
X-Google-Smtp-Source: AMrXdXsQ49/B6CvMTrrMm/E4bMGWe/t6ZOs8Hl0bdstHFNB7OMnVDpc66kgL03Vz4hP1uCp5ZUPNnQ==
X-Received: by 2002:a17:90a:d182:b0:223:b1e3:997f with SMTP id fu2-20020a17090ad18200b00223b1e3997fmr13020538pjb.48.1671573708285;
        Tue, 20 Dec 2022 14:01:48 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:68c4:de54:581a:ee2])
        by smtp.gmail.com with ESMTPSA id 2-20020a17090a174200b00217090ece49sm14374pjm.31.2022.12.20.14.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 14:01:47 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH bpf-next 0/2] bpf: Allow access to perf sample data (v2)
Date:   Tue, 20 Dec 2022 14:01:42 -0800
Message-Id: <20221220220144.4016213-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

I'm working on perf event sample filtering using BPF.  To do that BPF needs
to access perf sample data and return 0 or 1 to drop or keep the samples.

Changes in v2)
 - reuse perf_prepare_sample() instead of adding new bpf_prepare_sample()
 - drop bpf_perf_event_read_helper() and access ctx->data directly using
   bpf_cast_to_kern_ctx().

v1) https://lore.kernel.org/r/20221101052340.1210239-1-namhyung@kernel.org

Thanks to bpf_cast_to_kern_ctx() kfunc, it can easily access the sample data
now.  But the problem is that perf didn't populate the sample data at the time
it calls bpf_prog_run().  I changed the code to simply call perf_prepare_sample
function before calling the BPF program.

But it also checks if the BPF calls bpf_cast_to_kern_ctx() since calling
perf_prepare_sample() is unnecessary if the BPF doesn't access to the sample.
The perf_prepare_sample() was only called right before putting it to the perf
ring buffer.  I think I can add a little optimization not to fill already set
fields as it can be called twice now.  It can be a separate patch for perf.

Another issue is that perf sample data only has selected fields according to
the sample_type flags in the perf_event_attr.  Accessing other fields can
result in uninitialized read.  I'm not sure how much it's gonna be a problem
but it seems there's no way to prevent it completely.  So properly written
programs should check the sample_type flags first when reading the sample data.

The code is available at 'bpf/perf-sample-v2' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (2):
  bpf/perf: Call perf_prepare_sample() before bpf_prog_run()
  selftests/bpf: Add perf_event_read_sample test cases

 include/linux/bpf.h                           |   1 +
 kernel/bpf/verifier.c                         |   1 +
 kernel/events/core.c                          |   3 +
 .../selftests/bpf/prog_tests/perf_sample.c    | 167 ++++++++++++++++++
 .../selftests/bpf/progs/test_perf_sample.c    |  33 ++++
 5 files changed, 205 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_sample.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_perf_sample.c

-- 
2.39.0.314.g84b9a713c41-goog

