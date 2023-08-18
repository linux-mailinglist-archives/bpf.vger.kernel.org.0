Return-Path: <bpf+bounces-8048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D627807B1
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 11:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E088C1C21378
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 09:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D630F17AD4;
	Fri, 18 Aug 2023 09:01:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A22D3D7F;
	Fri, 18 Aug 2023 09:01:44 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11284220;
	Fri, 18 Aug 2023 02:01:26 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf3a2f44f0so2684935ad.2;
        Fri, 18 Aug 2023 02:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692349286; x=1692954086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zJoz3PtBj0tgsgAYmTm9m0ONju3KodXFSb4TAk7iyHc=;
        b=nsAqb23x9LvRAM/Qsc0FGms30df3zUQzVyHSLlVMVDwfwezaKI+NLfNbJB78NckTW8
         pw3StMxfi4CqUWfGR5oQNcfMfDDzCOaSIsdW8jwAyZS0UPnoMuz9k0gs45qtMrmuOLf2
         Se/nY3tW00jmucvsoKE61880Tw502aks0L9gNVcbc/hP+B/ypYqmQ9WXM8aydaLtGqK4
         hnAfFsuzpT7FIoddeUTh57CXqcslgkbQP/gWjoiC+EckGokToGHiF+9YUIbh8rq0obzV
         9OtY6LoQP1L0Fuw42cK8FsiqgwU1h4YXWsEiSPtWhAfOCgnDVgbUKONptdkW+UxYc5c+
         MsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692349286; x=1692954086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJoz3PtBj0tgsgAYmTm9m0ONju3KodXFSb4TAk7iyHc=;
        b=IDSiJIqo6hTsN6QDO6Fnxd2Rq6sFCwkMxIxAlO3RATpQr1r6O90H3oYW9oyk/eNDEs
         ISwN35cASIyCOAxSahymg7rdHXPfkyF8igIGs854bxOzJeEHv3MYcmcc88NOBu1IHEWN
         WlG4z8WThW1hRrAKsYQF1GyTRRajIm+3kYr34C3zGcgrZaMqDcExQ8LBsbNPhkLf490b
         TMB1p+WVZqFHoDW8yfrAYbqN+TIdGtmV2+Q+83RZ+ZPIxXWbP+Auvg4IZQbGkzGO1DyE
         5Lo2zeZ7T3heqwwbj1/CsHsAv66pyMa2vQMamTnsLlQl0BGOnmbdD+ChRRHLY2PvLP9G
         3yZw==
X-Gm-Message-State: AOJu0YwbdZo5VQb8QsoW1NJppNzTR+ucZN0NadM+rrX8APT6MFYwEqMT
	qBy70XhzZhXmXghBZzvHKQ==
X-Google-Smtp-Source: AGHT+IFI7YMTorhw2aWPWsZPZEK0MELc8EUmxWAzBjBvpFrfTpLV1rVy97AzS+4uAsyn8uLp37aqrQ==
X-Received: by 2002:a17:903:2306:b0:1b8:a720:f513 with SMTP id d6-20020a170903230600b001b8a720f513mr2417383plh.30.1692349285593;
        Fri, 18 Aug 2023 02:01:25 -0700 (PDT)
Received: from dell-sscc.. ([114.71.48.94])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b001b89045ff03sm1217130plb.233.2023.08.18.02.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 02:01:25 -0700 (PDT)
From: "Daniel T. Lee" <danieltimlee@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [bpf-next 0/9] samples/bpf: make BPF programs more libbpf aware
Date: Fri, 18 Aug 2023 18:01:10 +0900
Message-Id: <20230818090119.477441-1-danieltimlee@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The existing tracing programs have been developed for a considerable
period of time and, as a result, do not properly incorporate the
features of the current libbpf, such as CO-RE. This is evident in
frequent usage of functions like PT_REGS* and the persistence of "hack"
methods using underscore-style bpf_probe_read_kernel from the past. 
These programs are far behind the current level of libbpf and can
potentially confuse users.

The kernel has undergone significant changes, and some of these changes
have broken these programs, but on the other hand, more robust APIs have
been developed for increased stableness.

To list some of the kernel changes that this patch set is focusing on,
- symbol mismatch occurs due to compiler optimization [1]
- inline of blk_account_io* breaks BPF kprobe program [2]
- new tracepoints for the block_io_start/done are introduced [3]
- map lookup probes can't be triggered (bpf_disable_instrumentation)[4]
- BPF_KSYSCALL has been introduced to simplify argument fetching [5]
- convert to vmlinux.h and use tp argument structure within it
- make tracing programs to be more CO-RE centric

In this regard, this patch set aims not only to integrate the latest
features of libbpf into BPF programs but also to reduce confusion and
clarify the BPF programs. This will help with the potential confusion
among users and make the programs more intutitive.

[1]: https://github.com/iovisor/bcc/issues/1754
[2]: https://github.com/iovisor/bcc/issues/4261
[3]: commit 5a80bd075f3b ("block: introduce block_io_start/block_io_done tracepoints")
[4]: commit 7c4cd051add3 ("bpf: Fix syscall's stackmap lookup potential deadlock")
[5]: commit 6f5d467d55f0 ("libbpf: improve BPF_KPROBE_SYSCALL macro and rename it to BPF_KSYSCALL")

Daniel T. Lee (9):
  samples/bpf: fix warning with ignored-attributes
  samples/bpf: convert to vmlinux.h with tracing programs
  samples/bpf: unify bpf program suffix to .bpf with tracing programs
  samples/bpf: fix symbol mismatch by compiler optimization
  samples/bpf: make tracing programs to be more CO-RE centric
  samples/bpf: fix bio latency check with tracepoint
  samples/bpf: fix broken map lookup probe
  samples/bpf: refactor syscall tracing programs using BPF_KSYSCALL
    macro
  samples/bpf: simplify spintest with kprobe.multi

 samples/bpf/Makefile                          | 20 +++++-----
 samples/bpf/net_shared.h                      |  2 +
 .../{offwaketime_kern.c => offwaketime.bpf.c} | 39 +++++-------------
 samples/bpf/offwaketime_user.c                |  2 +-
 .../bpf/{spintest_kern.c => spintest.bpf.c}   | 27 +++++--------
 samples/bpf/spintest_user.c                   | 24 ++++-------
 samples/bpf/test_map_in_map.bpf.c             | 10 ++---
 samples/bpf/test_overhead_kprobe.bpf.c        | 20 ++++------
 samples/bpf/test_overhead_tp.bpf.c            | 29 +-------------
 samples/bpf/{tracex1_kern.c => tracex1.bpf.c} | 25 +++++-------
 samples/bpf/tracex1_user.c                    |  2 +-
 samples/bpf/{tracex3_kern.c => tracex3.bpf.c} | 40 ++++++++++++-------
 samples/bpf/tracex3_user.c                    |  2 +-
 samples/bpf/{tracex4_kern.c => tracex4.bpf.c} |  3 +-
 samples/bpf/tracex4_user.c                    |  2 +-
 samples/bpf/{tracex5_kern.c => tracex5.bpf.c} | 12 +++---
 samples/bpf/tracex5_user.c                    |  2 +-
 samples/bpf/{tracex6_kern.c => tracex6.bpf.c} | 20 ++++++++--
 samples/bpf/tracex6_user.c                    |  2 +-
 samples/bpf/{tracex7_kern.c => tracex7.bpf.c} |  3 +-
 samples/bpf/tracex7_user.c                    |  2 +-
 21 files changed, 117 insertions(+), 171 deletions(-)
 rename samples/bpf/{offwaketime_kern.c => offwaketime.bpf.c} (76%)
 rename samples/bpf/{spintest_kern.c => spintest.bpf.c} (67%)
 rename samples/bpf/{tracex1_kern.c => tracex1.bpf.c} (60%)
 rename samples/bpf/{tracex3_kern.c => tracex3.bpf.c} (70%)
 rename samples/bpf/{tracex4_kern.c => tracex4.bpf.c} (95%)
 rename samples/bpf/{tracex5_kern.c => tracex5.bpf.c} (90%)
 rename samples/bpf/{tracex6_kern.c => tracex6.bpf.c} (71%)
 rename samples/bpf/{tracex7_kern.c => tracex7.bpf.c} (82%)

-- 
2.34.1


