Return-Path: <bpf+bounces-10192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B627A2CB2
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 02:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4701C22529
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 00:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC0115AA;
	Sat, 16 Sep 2023 00:47:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE3036E;
	Sat, 16 Sep 2023 00:47:06 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB55A4215;
	Fri, 15 Sep 2023 17:43:08 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68fbbb953cfso2374729b3a.2;
        Fri, 15 Sep 2023 17:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694824738; x=1695429538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oLD25PkDucnrSNAyY6bLmFdlfMbVXirkQaLQA+P5Bg4=;
        b=Kt/vJ/MhrJVb8rBXUi8x6tyj3GXLD6JJfbaWRVpJ2rkyshYAld40+KmxQexNB0XnQ+
         txJOMFuZddxkIGBKgz02bmsk8Ut4r+tv4K29cWo4YTl3KQ1TWkZm0fcz+9gj5I27M8us
         ZWqBqlaK8i5SwBIwM+jcXc8cGu9MWpPGvCety9//Qrzltpb16Rwm9hmKgy+6AZLS5tD9
         ssjgDs5HRq+pzKh8/AhZHBoKx5JLDRyVeAQwMvtGsIieGPfciA5Jn7YMljwzaapJnwTV
         zLH5MubaVy4j1olcBQmXDXFm/3qNMhjsTafludIbMQobf33L5NNLaEkLeJa5xU3mmk2K
         kxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694824738; x=1695429538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLD25PkDucnrSNAyY6bLmFdlfMbVXirkQaLQA+P5Bg4=;
        b=IbAbH0gSRTQfyuMxQxM0oLRF+c/7JfBc6klKzZqOr2qKg4qYeiWj999DV/OpnZ83nL
         H510C9QSyh3PuEzVkSOOgwGXJMvXRMSZonLHM2/rjG6CcHi8JYR0iZGcHQJcMIxNJGbC
         sAI6sO4M+yCT2E5+oP5I4T9iGN7VK/Yp7QHyZTJw9QBNi4toEVRFdOBsYSHsYmcvio39
         X/dXqDc0LRkTS22iwxG4I3HlMdTmtVyg7BOpoKHzOG/TT2Np/4MKfi19AZyeGFNciiXQ
         pDKJmqxkGXsIwa4TstuZPTSubxsrKVRKIsR1iLXVLjhHy/eFqAXK2sUB2FsM+J+cAQ5J
         mBmw==
X-Gm-Message-State: AOJu0Yw3ih9Y1DigDOYlFXJk2v33eV2sfqzbULArbl41ygLZ1q0UgdyL
	BmajIy9Hnc4YgIrdU9iYNwY=
X-Google-Smtp-Source: AGHT+IHnK/TqBA+sZc7A73yvDiS57VraQEJGDTcm3aiGkOsjDXv6fshdxRNYnbwh+1UNQ0C4ejysrA==
X-Received: by 2002:a05:6a20:7d8c:b0:131:c760:2a0b with SMTP id v12-20020a056a207d8c00b00131c7602a0bmr4438104pzj.52.1694824738337;
        Fri, 15 Sep 2023 17:38:58 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::4:252e])
        by smtp.gmail.com with ESMTPSA id g21-20020a62e315000000b0068c670afe30sm3474140pfh.124.2023.09.15.17.38.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 Sep 2023 17:38:57 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	andrii@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: pull-request: bpf 2023-09-15
Date: Fri, 15 Sep 2023 17:38:55 -0700
Message-Id: <20230916003855.82646-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 21 non-merge commits during the last 8 day(s) which contain
a total of 21 files changed, 450 insertions(+), 36 deletions(-).

The main changes are:

1) Adjust bpf_mem_alloc buckets to match ksize(), from Hou Tao.

2) Check whether override is allowed in kprobe mult, from Jiri Olsa.

3) Fix btf_id symbol generation with ld.lld, from Jiri and Nick.

4) Fix potential deadlock when using queue and stack maps from NMI, from Toke Høiland-Jørgensen.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Alan Maguire, Biju Das, Björn Töpel, Dan Carpenter, Daniel Borkmann, 
Eduard Zingerman, Hsin-Wei Hung, Marcus Seyfarth, Nathan Chancellor, 
Satya Durga Srinivasu Prabhala, Song Liu, Stephen Rothwell

----------------------------------------------------------------

The following changes since commit ac28b1ec6135649b5d78b028e47264cb3ebca5ea:

  net: ipv4: fix one memleak in __inet_del_ifa() (2023-09-08 08:02:17 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 

for you to fetch changes up to c0bb9fb0e52a64601d38b3739b729d9138d4c8a1:

  bpf: Fix BTF_ID symbol generation collision in tools/ (2023-09-15 12:08:27 -0700)

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'fix-the-unmatched-unit_size-of-bpf_mem_cache'

Andrii Nakryiko (1):
      selftests/bpf: ensure all CI arches set CONFIG_BPF_KPROBE_OVERRIDE=y

Artem Savkov (1):
      selftests/bpf: fix unpriv_disabled check in test_verifier

Christophe JAILLET (1):
      bpf: Fix a erroneous check after snprintf()

Eduard Zingerman (2):
      bpf: Avoid dummy bpf_offload_netdev in __bpf_prog_dev_bound_init
      selftests/bpf: Offloaded prog after non-offloaded should not cause BUG

Hou Tao (5):
      bpf: Adjust size_index according to the value of KMALLOC_MIN_SIZE
      bpf: Don't prefill for unused bpf_mem_cache
      bpf: Ensure unit_size is matched with slab cache object size
      selftests/bpf: Test all valid alloc sizes for bpf mem allocator
      bpf: Skip unit_size checking for global per-cpu allocator

Ilya Leoshkevich (1):
      netfilter, bpf: Adjust timeouts of non-confirmed CTs in bpf_ct_insert_entry()

Jiri Olsa (5):
      bpf: Add override check to kprobe multi link attach
      selftests/bpf: Add kprobe_multi override test
      selftests/bpf: Fix kprobe_multi_test/attach_override test
      bpf: Fix uprobe_multi get_pid_task error path
      bpf: Fix BTF_ID symbol generation collision

Martin KaFai Lau (1):
      Merge branch 'Avoid dummy bpf_offload_netdev in __bpf_prog_dev_bound_init'

Nick Desaulniers (1):
      bpf: Fix BTF_ID symbol generation collision in tools/

Randy Dunlap (1):
      bpf, cgroup: fix multiple kernel-doc warnings

Stanislav Fomichev (2):
      bpf: Clarify error expectations from bpf_clone_redirect
      selftests/bpf: Update bpf_clone_redirect expected return code

Toke Høiland-Jørgensen (1):
      bpf: Avoid deadlock when using queue and stack maps from NMI

 include/linux/btf_ids.h                            |   2 +-
 include/uapi/linux/bpf.h                           |   4 +-
 kernel/bpf/btf.c                                   |   2 +-
 kernel/bpf/cgroup.c                                |  13 ++-
 kernel/bpf/memalloc.c                              |  94 +++++++++++++++-
 kernel/bpf/offload.c                               |  12 +-
 kernel/bpf/queue_stack_maps.c                      |  21 +++-
 kernel/trace/bpf_trace.c                           |  20 +++-
 net/netfilter/nf_conntrack_bpf.c                   |   2 +
 tools/include/linux/btf_ids.h                      |   2 +-
 tools/include/uapi/linux/bpf.h                     |   4 +-
 tools/testing/selftests/bpf/DENYLIST.aarch64       |  10 +-
 tools/testing/selftests/bpf/config                 |   1 +
 tools/testing/selftests/bpf/config.x86_64          |   1 -
 tools/testing/selftests/bpf/prog_tests/empty_skb.c |  12 +-
 .../selftests/bpf/prog_tests/kprobe_multi_test.c   |  37 +++++++
 .../testing/selftests/bpf/prog_tests/test_bpf_ma.c |  50 +++++++++
 .../selftests/bpf/prog_tests/xdp_dev_bound_only.c  |  61 ++++++++++
 .../selftests/bpf/progs/kprobe_multi_override.c    |  13 +++
 tools/testing/selftests/bpf/progs/test_bpf_ma.c    | 123 +++++++++++++++++++++
 tools/testing/selftests/bpf/test_verifier.c        |   2 +-
 21 files changed, 450 insertions(+), 36 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_ma.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_override.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bpf_ma.c

