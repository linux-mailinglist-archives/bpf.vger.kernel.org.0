Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D579A58F16A
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 19:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbiHJRSB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 13:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiHJRR6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 13:17:58 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BF1F5A880;
        Wed, 10 Aug 2022 10:17:57 -0700 (PDT)
Received: from pwmachine.numericable.fr (85-170-37-153.rev.numericable.fr [85.170.37.153])
        by linux.microsoft.com (Postfix) with ESMTPSA id C2DC8210CB09;
        Wed, 10 Aug 2022 10:17:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2DC8210CB09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1660151877;
        bh=4aPs3i1QoObt5JaQKhi+7wDPlNlhQH3nxRns9sDPclE=;
        h=From:To:Cc:Subject:Date:From;
        b=liJRcl7xWeFchZ8sIUDxlFeZ7UQlO1C7I4pc0X5kkg+xYzqWc38lxIXyXW/zQa9Wc
         v998V3pqStIkcBVk7LRKneCNLtYX5pVCO5m0DRNrsW6AOZKqG6E/vgAgDcKnzR8nSo
         oEKxD5XxiIbRh2id+BzwbB7A08+30ErrLFXmbkq4=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Geliang Tang <geliang.tang@suse.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [RFC PATCH v1 0/3] Make BPF ring buffer over writable
Date:   Wed, 10 Aug 2022 19:16:51 +0200
Message-Id: <20220810171702.74932-1-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi.


First, I hope you are fine and the same for your relatives.

Normally, when BPF ring buffer are full, producers cannot write anymore and
need to wait for consumer to get some data.
As a consequence, calling bpf_ringbuf_reserve() from eBPF code returns NULL.

This contribution adds a new flag to make BPF ring buffer over writable.
When the buffer is full, the producer will over write the oldest data.
So, calling bpf_ringbuf_reserve() on an over writable BPF ring buffer never
returns NULL but consumer will loose some data.
This flag can be used to monitor lots of events, like all the syscalls done on
a given machine.

I tested it within a VM with the fourth patch which creates a "toy" eBPF
program:
you@home$ cd /path/to/iovisor/bcc
you@home$ git apply 0001-for-test-purpose-only-Add-toy-to-play-with-BPF-ring-.patch
you@home$ cd /path/to/linux/tools/lib/bpf
you@home$ make -j$(nproc)
you@home$ cp libbpf.a /path/to/iovisor/bcc/libbpf-tools/.output
you@home$ cd /path/to/iovisor/bcc/libbpf-tools/
you@home$ make -j toy
# Start your VM and copy toy executable inside it.
you@vm# ./share/toy
Press any key to begin consuming!
^Z
you@vm# for i in {1..16}; do true; done
you@vm# fg # Please press any key

8
9
10
11
12
13
14
15
16

^Z
you@vm# true && true
you@vm# fg
17
18

As you can see, the first eight events are overwritten.

If you any way to improve this contribution, feel free to share.

Francis Laniel (3):
  bpf: Make ring buffer overwritable.
  do not merge: Temporary fix for is_power_of_2.
  libbpf: Make bpf ring buffer overwritable.

 include/uapi/linux/bpf.h       |  3 ++
 kernel/bpf/ringbuf.c           | 51 ++++++++++++++++++++++++++--------
 tools/include/uapi/linux/bpf.h |  3 ++
 tools/lib/bpf/libbpf.c         |  2 +-
 tools/lib/bpf/ringbuf.c        | 35 ++++++++++++++++++++++-
 5 files changed, 81 insertions(+), 13 deletions(-)


Best regards and thank you in advance.
--
2.25.1

