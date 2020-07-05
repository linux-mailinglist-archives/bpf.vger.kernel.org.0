Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E6F214BA7
	for <lists+bpf@lfdr.de>; Sun,  5 Jul 2020 11:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgGEJyJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Jul 2020 05:54:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgGEJyJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Jul 2020 05:54:09 -0400
Received: from localhost.localdomain (unknown [151.48.133.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A89B20772;
        Sun,  5 Jul 2020 09:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593942848;
        bh=81WpLXidD6ONomtmKLZiV+w5eflnNn+ad/wyc69Ml3I=;
        h=From:To:Cc:Subject:Date:From;
        b=hJGYIVyKWRgIvH/UIwtrJ6nVo83YjX1FdFeylSLQNF230Erh8Coe2zQUOUOJC6NWl
         3FsQQnwr3l8HNC8EJBdAQM0/WTx0COBM+qDgmo2Ot/+1RWbqCWxgzmhpyiMu65crSq
         M4L1Abc/Y6+iWozkbeBXpK+qiElGVi7LpqSoro6M=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, brouer@redhat.com,
        daniel@iogearbox.net, toke@redhat.com, lorenzo.bianconi@redhat.com,
        dsahern@kernel.org, andrii.nakryiko@gmail.com
Subject: [PATCH v6 bpf-next 0/9] introduce support for XDP programs in CPUMAP
Date:   Sun,  5 Jul 2020 11:53:51 +0200
Message-Id: <cover.1593941895.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similar to what David Ahern proposed in [1] for DEVMAPs, introduce the
capability to attach and run a XDP program to CPUMAP entries.
The idea behind this feature is to add the possibility to define on which CPU
run the eBPF program if the underlying hw does not support RSS.
I respin patch 1/6 from a previous series sent by David [2].
The functionality has been tested on Marvell Espressobin, i40e and mlx5.
Detailed tests results can be found here:
https://github.com/xdp-project/xdp-project/blob/master/areas/cpumap/cpumap04-map-xdp-prog.org

Changes since v5:
- move bpf_prog_put() in put_cpu_map_entry()
- remove READ_ONCE(rcpu->prog) in cpu_map_bpf_prog_run_xdp
- rely on bpf_prog_get_type() instead of bpf_prog_get_type_dev() in
  __cpu_map_load_bpf_program()

Changes since v4:
- move xdp_clear_return_frame_no_direct inside rcu section
- update David Ahern's email address

Changes since v3:
- fix typo in commit message
- fix access to ctx->ingress_ifindex in cpumap bpf selftest

Changes since v2:
- improved comments
- fix return value in xdp_convert_buff_to_frame
- added patch 1/9: "cpumap: use non-locked version __ptr_ring_consume_batched"
- do not run kmem_cache_alloc_bulk if all frames have been consumed by the XDP
  program attached to the CPUMAP entry
- removed bpf_trace_printk in kselftest

Changes since v1:
- added performance test results
- added kselftest support
- fixed memory accounting with page_pool
- extended xdp_redirect_cpu_user.c to load an external program to perform
  redirect
- reported ifindex to attached eBPF program
- moved bpf_cpumap_val definition to include/uapi/linux/bpf.h

[1] https://patchwork.ozlabs.org/project/netdev/cover/20200529220716.75383-1-dsahern@kernel.org/
[2] https://patchwork.ozlabs.org/project/netdev/patch/20200513014607.40418-2-dsahern@kernel.org/

David Ahern (1):
  net: refactor xdp_convert_buff_to_frame

Jesper Dangaard Brouer (1):
  cpumap: use non-locked version __ptr_ring_consume_batched

Lorenzo Bianconi (7):
  samples/bpf: xdp_redirect_cpu_user: do not update bpf maps in option
    loop
  cpumap: formalize map value as a named struct
  bpf: cpumap: add the possibility to attach an eBPF program to cpumap
  bpf: cpumap: implement XDP_REDIRECT for eBPF programs attached to map
    entries
  libbpf: add SEC name for xdp programs attached to CPUMAP
  samples/bpf: xdp_redirect_cpu: load a eBPF program on cpumap
  selftest: add tests for XDP programs in CPUMAP entries

 include/linux/bpf.h                           |   6 +
 include/net/xdp.h                             |  41 ++--
 include/trace/events/xdp.h                    |  16 +-
 include/uapi/linux/bpf.h                      |  14 ++
 kernel/bpf/cpumap.c                           | 159 ++++++++++---
 net/core/dev.c                                |   9 +
 samples/bpf/xdp_redirect_cpu_kern.c           |  25 ++-
 samples/bpf/xdp_redirect_cpu_user.c           | 209 ++++++++++++++++--
 tools/include/uapi/linux/bpf.h                |  14 ++
 tools/lib/bpf/libbpf.c                        |   2 +
 .../bpf/prog_tests/xdp_cpumap_attach.c        |  70 ++++++
 .../bpf/progs/test_xdp_with_cpumap_helpers.c  |  36 +++
 12 files changed, 529 insertions(+), 72 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c

-- 
2.26.2

