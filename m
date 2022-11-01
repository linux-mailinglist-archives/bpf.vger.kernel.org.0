Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A716361442C
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 06:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKAFXt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 01:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiKAFXo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 01:23:44 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F99B02;
        Mon, 31 Oct 2022 22:23:44 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o7so9036304pjj.1;
        Mon, 31 Oct 2022 22:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Rp3fd65nzOHH/UKQRRA0QHWan+ndr83fFCTGqjP1WxA=;
        b=e2i7PnDD5BlFpD3CVoE9dzVzHj8/8ElaJEJEkekAMAhr0PeLEvx8Nkeca/iGwARLku
         ZMBlL5qUGeGUdhROF58J9JvAlMjW8weum5pd04QmLtOdLZQpVanJXpICVbNrleBx0DbR
         jcMo0TqD5yKpsAky8QtSfMkMv7UjrnazSSCKxUWpaMXkUnk8Pb5PxnZ6tia0hc/5zyEf
         zJgDRGOc+UhMJzqXI7of+Ncs0iS6WP1LVIPjHyvY+a947n3edYB8a9LN7fslW7BCpOwm
         jfvRm2YZHTyL9Vpf1Ijv2BZAEcHjT+TuloYSM4772vDVZ3huAsandGJscGtHzURKhQTE
         l+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rp3fd65nzOHH/UKQRRA0QHWan+ndr83fFCTGqjP1WxA=;
        b=vcGnkmIVT5piLNgi7iRE2CiojwpfERPpVYchECqULILHUPvzE7jbztAJEm7dcX0YEs
         w8pSCs15Kvzc7RzXGYGXugBen+H5V9REoGNkHAQnxWuc59/NIYyDqw7BNLRWgMIZ+4hc
         k8tRh4FodGWFe0mO9YUcblCNpV/N9Yr0GQiw2HBrpWvqZ0oN50S/lC3QPAMEbzbU5ycd
         S2SOo6IlASGakYsmXFjgQjOaEXrtuIJRZXG0Oijkv1i1oQIGuMnuqWQ4E6bLIJKNyef9
         h7qrOhR4JTrtIPBAxxP80NACem3952U3Kw1cHRjB8H4pGDiVwPhIXq6vOcOs5DBYkrrj
         WXag==
X-Gm-Message-State: ACrzQf0uog1Rwx7qGqtUCKvxPb5WUylRO22E5muOyKHHnOhHFYW+GvQV
        RPvaLs/gN5dQGrPXmE4PET0=
X-Google-Smtp-Source: AMsMyM48/cZIkxyjNEHjJkr1DsIrUu5N0LafBdTd7gj1N847b9k7gAIM8vbc8YOiy9ZKBI4EPK1Elw==
X-Received: by 2002:a17:902:aa02:b0:186:9395:4e82 with SMTP id be2-20020a170902aa0200b0018693954e82mr18210629plb.5.1667280223695;
        Mon, 31 Oct 2022 22:23:43 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:7e9:8a64:69f2:c3c7])
        by smtp.gmail.com with ESMTPSA id i4-20020a056a00004400b00561b53512b0sm5532254pfk.195.2022.10.31.22.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 22:23:43 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH bpf-next 0/3] bpf: Add bpf_perf_event_read_sample() helper (v1)
Date:   Mon, 31 Oct 2022 22:23:37 -0700
Message-Id: <20221101052340.1210239-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
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

I'd like to add bpf_perf_event_read_sample() helper to get the sample data
of an perf_event from BPF programs.  This enables more sophistigated filtering
for the perf samples.  Initially I'm thinking of code and data address based
filtering.

The original discussion can be seen here:
  https://lore.kernel.org/r/20220823210354.1407473-1-namhyung@kernel.org

The bpf_perf_event_read_sample() will take a buffer and size to save the data
as well as a flag to specify perf sample type.  The flag argument should have
a single value in the enum perf_event_sample_format like PERF_SAMPLE_IP.  If
the buffer is NULL, it will return the size of data instead.  This is to
support variable length data in the future.

The first patch adds bpf_prepare_sample() to setup necessary perf sample data
before calling the bpf overflow handler for the perf event.  The existing
logic for callchain moved to the function and it sets IP and ADDR data if
they are not set already.

The second patch actually adds the bpf_perf_event_read_sample() helper and
supports IP and ADDR data.  The last patch adds a test code for this.

The code is available at 'bpf/perf-sample-v1' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung

Namhyung Kim (3):
  perf/core: Prepare sample data before calling BPF
  bpf: Add bpf_perf_event_read_sample() helper
  bpf: Add perf_event_read_sample test cases

 include/uapi/linux/bpf.h                      |  23 +++
 kernel/events/core.c                          |  40 +++-
 kernel/trace/bpf_trace.c                      |  49 +++++
 tools/include/uapi/linux/bpf.h                |  23 +++
 .../selftests/bpf/prog_tests/perf_sample.c    | 172 ++++++++++++++++++
 .../selftests/bpf/progs/test_perf_sample.c    |  28 +++
 6 files changed, 326 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_sample.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_perf_sample.c


base-commit: e39e739ab57399f46167d453bbdb8ef8d57c6488
-- 
2.38.1.273.g43a17bfeac-goog

