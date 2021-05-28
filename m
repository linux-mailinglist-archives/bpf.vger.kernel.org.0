Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC6C394721
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 20:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhE1SqA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 May 2021 14:46:00 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:48386 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhE1Sp7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 May 2021 14:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622227464; x=1653763464;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YRFcB3Ij8slOZSzscA4hGt4gAmSSrJb4B7MzBb4wlnI=;
  b=dxPZNN7rLlo7CkpsPv43OraTNLGICiFvcVaNCYN4LU5nuRMB2KWqONG1
   AtkZybjZn7fh1gdU/6MKl1/GqoekYAMBXDzJFD/xoE+grZbbGpk1x19bO
   6CDDQjCVRWdC+FmGKP4MdiavFQaqWS6GF0G6MnHiH1iD0L+c7xc0Yu/gI
   cnvyxHB1QNpGCx0iKA6nKbE4odpMil6SCI4W+H+dZNRzqpV1QgqEqgdPc
   ATvZUPsXNW+IvrpjewxnYPrzyjURMpN3ABCnM1SCho+xPl8WZXX2Kgjgr
   pvQRQ6lDJDP3r1byCq6FqKR2qCiA9qYZcGFLUN+lOEgIzECSk3WsYIXXA
   A==;
IronPort-SDR: AUs4YQZZgsY6JWczDaCqDEGi27UA2JuTXaCvwkfR4/qCWsofCphGN+EyUfnZKxmAMfucZiRAij
 e36zoMWGkc+PIAQXnAxBoh+1DI9Mx2KWEBFzl1K/VM37dO2XOfVVlDxmRI0WYSFNjg/Uwwl/3h
 0ng3wgClslkqZMkjN2aNiGp0x2BFk+b56ZN4eO9ogAgfjQ+SqMbiVLhbSyFTUO3Ij0OteQD3ca
 NnFBsKjljLAuKlCXiyMxVTgty+YumVxuZvHZFrGSnn90hoYX9OXcl4fx7P6WW/2quZYdM8FqlC
 FAE=
X-IronPort-AV: E=Sophos;i="5.83,230,1616428800"; 
   d="scan'208";a="174577163"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2021 02:44:24 +0800
IronPort-SDR: tlvp2iQELHDArBON81tyPcXnqnIsFo+ZxvD5793jOJsRa3q9W5X/4gyhNGdFIihR0Coa0+jYVi
 S5dP9hMfIUn3nee7sUVXg9fHidvDSI6oki3nviMPX/JEppl3zMuCqoUFJ0NAaOJF/stlo1NouZ
 sB3QFkwXV5LfpnmDaAiwnn1JWyMj2H18GLFe/n9MZes9S2HLMWKugpoja/Ouw2slRYeRAqs5Gh
 992PEHb9YSrqz/f425HMzvm8FzunCMk30WsUS+qiast++Os8r/qRD1mJNyMQawsSiyeJ5haAJX
 VCFsyLekCDGLqrBEadW8N7si
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2021 11:23:47 -0700
IronPort-SDR: FwKkID0ZyCmK4yldsD9bwlpL7YKTj+dqrsIMrw8blAmx7w/E+zaal8/Z9fwFDVreYWz1Zw5xAj
 dNv/yCesVUBhLzSeTOIqpaNOfaagRIyl1d63bJBP/ePXQICOeqrBJf5NqenQQ20vVDYw+1Btlv
 eBHyQ4U5szKVvPpLJy8+F9pXQ3r3vi5tpDdVjPDB2FwEafE5SjXuFJ7f14Q0T5JJAn8KgZfp8W
 1+52WvFzs8eWA/5kFc51FOaKND3DPqIroVgnXbGqgHX7Yzz9jJHrdFO5TBamt5k0YdcLtFpU8x
 pF8=
WDCIronportException: Internal
Received: from unknown (HELO jedi-01.wdc.com) ([10.225.163.91])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 May 2021 11:44:20 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
        bpf@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alan Kao <alankao@andestech.com>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [RFC v2 0/7] Improve RISC-V Perf support using SBI PMU extension
Date:   Fri, 28 May 2021 11:43:58 -0700
Message-Id: <20210528184405.1793783-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series adds improved perf support for RISC-V based system using
SBI PMU extension[1]. It is based on a platform driver instead of a existing
arch specific implementation. The new perf implementation has adopted a modular
approach where most of the generic event handling is done in the core library
while individual PMUs need to only implement necessary features specific to
the PMU. This is easily extensible and any future RISC-V PMU implementation
can leverage this. Currently, SBI PMU driver & legacy PMU driver are implemented
as a part of this series.

The SBI based driver provides more advanced features such as event configure
start/stop. This version does not implement counter overflow
& filtering yet. That will implemented in the future on top of this series
using "Sscofpmf" extension. 

The legacy driver tries to reimplement the existing minimal perf under a new
config to maintain backward compatibility. This implementation only allows
monitoring of always running cycle/instruction counters. Moreover, they can
not be started or stopped. In general, this is very limited and not very useful.
That's why, I am not very keen to carry the support into the new driver.
However, I don't want to break perf for any existing hardware platforms.
If nobody really uses perf currently, I will be happy to drop PATCH 4.

This series has been tested in Qemu on RV64 only. Qemu[2] & OpenSBI [3] patches
are required to test it. Qemu changes are not backward compatible. That means,
you can not use perf anymore on older Qemu versions with latest OpenSBI
and/or Kernel. However, newer kernel will just use legacy pmu driver if
old OpenSBI is detected or hardware doesn't implement mcountinhibit.

Here is an output of perf stat while running hackbench.

[root@fedora-riscv riscv]# perf stat -e r8000000000000007 -e r8000000000000006 \
-e r0000000000000002 -e r0000000000000004 -e branch-misses -e cache-misses \
-e cycles -e instructions ./hackbench -pipe 15 process 15

Running with 15*40 (== 600) tasks.
Time: 1.548

 Performance counter stats for './hackbench -pipe 15 process 15':

             7,103      r8000000000000007     (62.56%) --> SBI_PMU_FW_IPI_RECVD
             7,767      r8000000000000006     (12.19%) --> SBI_PMU_FW_IPI_SENT
                 0      r0000000000000002     (24.79%) --> a custom raw event described in DT
     <not counted>      r0000000000000004     (0.00%)  --> non-supported raw event described in DT
                 0      branch-misses         (12.65%) 
                 0      cache-misses          (25.36%)
    27,978,868,702      cycles                (38.12%)
    27,849,527,556      instructions          # 1.00  insn per cycle  (50.46%)

       2.431195184 seconds time elapsed

       1.553153000 seconds user
      13.615924000 seconds sys

The patches can also be found in the github[4].

[1] https://lists.riscv.org/g/tech-unixplatformspec/message/950
[2] https://github.com/atishp04/qemu/tree/riscv_pmu_v1
[3] https://github.com/atishp04/opensbi/tree/riscv_pmu_v2
[4] https://github.com/atishp04/linux/tree/riscv_pmu_v2

Changes from v1->v2
1. Implemented the latest SBI PMU extension specification.
2. The core platform driver was changed to operate as a library while only
   sbi based PMU is built as a driver. The legacy one is just a fallback if
   SBI PMU extension is not available.

Atish Patra (7):
RISC-V: Remove the current perf implementation
RISC-V: Add CSR encodings for all HPMCOUNTERS
RISC-V: Add a perf core library for pmu drivers
RISC-V: Add a simple platform driver for RISC-V legacy perf
RISC-V: Add RISC-V SBI PMU extension definitions
RISC-V: Add perf platform driver based on SBI PMU extension
Documentation: riscv: Remove the old documentation

Documentation/riscv/pmu.rst         | 255 -------------
arch/riscv/Kconfig                  |  13 -
arch/riscv/include/asm/csr.h        |  58 +++
arch/riscv/include/asm/perf_event.h |  72 ----
arch/riscv/include/asm/sbi.h        |  94 +++++
arch/riscv/kernel/Makefile          |   1 -
arch/riscv/kernel/perf_event.c      | 485 -------------------------
drivers/perf/Kconfig                |  25 ++
drivers/perf/Makefile               |   5 +
drivers/perf/riscv_pmu.c            | 328 +++++++++++++++++
drivers/perf/riscv_pmu_legacy.c     |  92 +++++
drivers/perf/riscv_pmu_sbi.c        | 537 ++++++++++++++++++++++++++++
include/linux/cpuhotplug.h          |   1 +
include/linux/perf/riscv_pmu.h      |  61 ++++
14 files changed, 1201 insertions(+), 826 deletions(-)
delete mode 100644 Documentation/riscv/pmu.rst
delete mode 100644 arch/riscv/kernel/perf_event.c
create mode 100644 drivers/perf/riscv_pmu.c
create mode 100644 drivers/perf/riscv_pmu_legacy.c
create mode 100644 drivers/perf/riscv_pmu_sbi.c
create mode 100644 include/linux/perf/riscv_pmu.h

--
2.25.1

