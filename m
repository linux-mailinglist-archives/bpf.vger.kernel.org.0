Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967D7394738
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 20:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhE1SrM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 May 2021 14:47:12 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:48410 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhE1Sqh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 May 2021 14:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622227501; x=1653763501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3JnF6l2PLa1hy2YhPne+rwznydAel8kHIfLwnsglFNc=;
  b=TY60yvp/wxZo6O4ljfQWfsd7YMkpVo9hrPJI3Pz9nfvNpu6l1wCaND/r
   475wdfVzkQJgIjByq0sRbizE2OmvFBsOqOp80rX4AJuXAWA/9GWFDArnk
   TXnOf/TBxh7dhoe/zKFOLGwApL5vTQP2ovezRmekH6CKoBLJBij0P2NVZ
   tm4JhsMovISePN8E6hUpT/ANd/dgQyOQS0TZvibKqqeaNmpiGJOHqm4wn
   62HCwomzq6nVfZacW6nqJYoKAdVRm6Y4TyGF1GaZC/wRQw/4phoyoieCO
   HhBD3rjGI2KccpbN+c+gWhQ8u6nYVwXUnAB9BfgO6ll4gOrPoOIMD7lPQ
   Q==;
IronPort-SDR: JC5CDH0cCyos98KszJHJwf9QXvDyvJhcrlg7Po0A3GLMy5SZAngXI5gVvnEfIK0OsET7Ovs6qF
 ydwZQFiBQnc6Mnfkujfa/haxvoZkNdefG4594Flj4MK718vRyET3L+RblGZbo2af+xLSIUEsvc
 MzxPuUTvUSOFplwd5YIUQIfJ8gsHoTCN0MoJ+8HgFgHGZUqLkBA+FXUMI9R25pA/pNSrO8D1NH
 nSqiQjjZ/a4Q27eTbiiCOINybCtN3V3WQTV0arpR64q4N0QmiiWlRHnDZYhRTuRrPbMFkxBQFF
 b+s=
X-IronPort-AV: E=Sophos;i="5.83,230,1616428800"; 
   d="scan'208";a="174577244"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2021 02:45:01 +0800
IronPort-SDR: w4dgIzm8lvZ60HYQsd3SaX3KfWgD+9xL5ig2/4X3ghZN+iFPrLbKZPgRsGR038JgLh4O4kU5Az
 ta8jPUDuAoTtxkdTlVMUd9IaXrrDScG+bUdegaA+Ixvx/1P2S1CPlfYWAXIC+i8wMnhGOUfvBh
 dR6aWwXDvdIZ9iSujAQ4jfYYuC0RJMt83MRM1S8Z6BKxvyuzsAJxn6jehCZQPS05dlTTHcliMc
 N3/4Pzc/I1evtSSyGbQAJ6MhSPaAyRlqj5FYAEanl1B93oP+PiK34o0hg9VvksBR2/SmlatUw8
 6RDJqc/6IU5a/FDfCCpeUINa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2021 11:24:24 -0700
IronPort-SDR: igzx8ssNtnkSffzQ27r/mJQLZnwcef0zQB3xgf3FLZy78ZTeiKOh1/eUZk/ZSkA69WGGECj+h6
 soHiShGGW/ZsPYwqnOW6i8dvgiUsxj6CBwBDa+2L7Zy/e1Cq5e8ZI8SzktfW5iUaF/R1CDiAii
 cjiCgot3xrrSgJfkLSjE2JUShGdgB+SuysaBylBxhTFcCw9HNGl1xliVkrhUgcOy1VhpD0bRE8
 wt9OoAHSJcb2Q/F2kpfUfgN50Qd79z5tRcYqXzuqHOznNCeXaDAzuIILZAuihxgO2mEWB1XlDv
 Um0=
WDCIronportException: Internal
Received: from unknown (HELO jedi-01.wdc.com) ([10.225.163.91])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 May 2021 11:44:57 -0700
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
Subject: [RFC v2 7/7] Documentation: riscv: Remove the old documentation
Date:   Fri, 28 May 2021 11:44:05 -0700
Message-Id: <20210528184405.1793783-8-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528184405.1793783-1-atish.patra@wdc.com>
References: <20210528184405.1793783-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The existing pmu documentation describes the limitation of perf infrastructure
in RISC-V ISA and limited feature set of perf in RISC-V.

However, SBI PMU extension and sscofpmf extension(ISA extension) allows to
implement most of the required features of perf. Remove the old documentation
which is not accurate anymore.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 Documentation/riscv/pmu.rst | 255 ------------------------------------
 1 file changed, 255 deletions(-)
 delete mode 100644 Documentation/riscv/pmu.rst

diff --git a/Documentation/riscv/pmu.rst b/Documentation/riscv/pmu.rst
deleted file mode 100644
index acb216b99c26..000000000000
--- a/Documentation/riscv/pmu.rst
+++ /dev/null
@@ -1,255 +0,0 @@
-===================================
-Supporting PMUs on RISC-V platforms
-===================================
-
-Alan Kao <alankao@andestech.com>, Mar 2018
-
-Introduction
-------------
-
-As of this writing, perf_event-related features mentioned in The RISC-V ISA
-Privileged Version 1.10 are as follows:
-(please check the manual for more details)
-
-* [m|s]counteren
-* mcycle[h], cycle[h]
-* minstret[h], instret[h]
-* mhpeventx, mhpcounterx[h]
-
-With such function set only, porting perf would require a lot of work, due to
-the lack of the following general architectural performance monitoring features:
-
-* Enabling/Disabling counters
-  Counters are just free-running all the time in our case.
-* Interrupt caused by counter overflow
-  No such feature in the spec.
-* Interrupt indicator
-  It is not possible to have many interrupt ports for all counters, so an
-  interrupt indicator is required for software to tell which counter has
-  just overflowed.
-* Writing to counters
-  There will be an SBI to support this since the kernel cannot modify the
-  counters [1].  Alternatively, some vendor considers to implement
-  hardware-extension for M-S-U model machines to write counters directly.
-
-This document aims to provide developers a quick guide on supporting their
-PMUs in the kernel.  The following sections briefly explain perf' mechanism
-and todos.
-
-You may check previous discussions here [1][2].  Also, it might be helpful
-to check the appendix for related kernel structures.
-
-
-1. Initialization
------------------
-
-*riscv_pmu* is a global pointer of type *struct riscv_pmu*, which contains
-various methods according to perf's internal convention and PMU-specific
-parameters.  One should declare such instance to represent the PMU.  By default,
-*riscv_pmu* points to a constant structure *riscv_base_pmu*, which has very
-basic support to a baseline QEMU model.
-
-Then he/she can either assign the instance's pointer to *riscv_pmu* so that
-the minimal and already-implemented logic can be leveraged, or invent his/her
-own *riscv_init_platform_pmu* implementation.
-
-In other words, existing sources of *riscv_base_pmu* merely provide a
-reference implementation.  Developers can flexibly decide how many parts they
-can leverage, and in the most extreme case, they can customize every function
-according to their needs.
-
-
-2. Event Initialization
------------------------
-
-When a user launches a perf command to monitor some events, it is first
-interpreted by the userspace perf tool into multiple *perf_event_open*
-system calls, and then each of them calls to the body of *event_init*
-member function that was assigned in the previous step.  In *riscv_base_pmu*'s
-case, it is *riscv_event_init*.
-
-The main purpose of this function is to translate the event provided by user
-into bitmap, so that HW-related control registers or counters can directly be
-manipulated.  The translation is based on the mappings and methods provided in
-*riscv_pmu*.
-
-Note that some features can be done in this stage as well:
-
-(1) interrupt setting, which is stated in the next section;
-(2) privilege level setting (user space only, kernel space only, both);
-(3) destructor setting.  Normally it is sufficient to apply *riscv_destroy_event*;
-(4) tweaks for non-sampling events, which will be utilized by functions such as
-    *perf_adjust_period*, usually something like the follows::
-
-      if (!is_sampling_event(event)) {
-              hwc->sample_period = x86_pmu.max_period;
-              hwc->last_period = hwc->sample_period;
-              local64_set(&hwc->period_left, hwc->sample_period);
-      }
-
-In the case of *riscv_base_pmu*, only (3) is provided for now.
-
-
-3. Interrupt
-------------
-
-3.1. Interrupt Initialization
-
-This often occurs at the beginning of the *event_init* method. In common
-practice, this should be a code segment like::
-
-  int x86_reserve_hardware(void)
-  {
-        int err = 0;
-
-        if (!atomic_inc_not_zero(&pmc_refcount)) {
-                mutex_lock(&pmc_reserve_mutex);
-                if (atomic_read(&pmc_refcount) == 0) {
-                        if (!reserve_pmc_hardware())
-                                err = -EBUSY;
-                        else
-                                reserve_ds_buffers();
-                }
-                if (!err)
-                        atomic_inc(&pmc_refcount);
-                mutex_unlock(&pmc_reserve_mutex);
-        }
-
-        return err;
-  }
-
-And the magic is in *reserve_pmc_hardware*, which usually does atomic
-operations to make implemented IRQ accessible from some global function pointer.
-*release_pmc_hardware* serves the opposite purpose, and it is used in event
-destructors mentioned in previous section.
-
-(Note: From the implementations in all the architectures, the *reserve/release*
-pair are always IRQ settings, so the *pmc_hardware* seems somehow misleading.
-It does NOT deal with the binding between an event and a physical counter,
-which will be introduced in the next section.)
-
-3.2. IRQ Structure
-
-Basically, a IRQ runs the following pseudo code::
-
-  for each hardware counter that triggered this overflow
-
-      get the event of this counter
-
-      // following two steps are defined as *read()*,
-      // check the section Reading/Writing Counters for details.
-      count the delta value since previous interrupt
-      update the event->count (# event occurs) by adding delta, and
-                 event->hw.period_left by subtracting delta
-
-      if the event overflows
-          sample data
-          set the counter appropriately for the next overflow
-
-          if the event overflows again
-              too frequently, throttle this event
-          fi
-      fi
-
-  end for
-
-However as of this writing, none of the RISC-V implementations have designed an
-interrupt for perf, so the details are to be completed in the future.
-
-4. Reading/Writing Counters
----------------------------
-
-They seem symmetric but perf treats them quite differently.  For reading, there
-is a *read* interface in *struct pmu*, but it serves more than just reading.
-According to the context, the *read* function not only reads the content of the
-counter (event->count), but also updates the left period to the next interrupt
-(event->hw.period_left).
-
-But the core of perf does not need direct write to counters.  Writing counters
-is hidden behind the abstraction of 1) *pmu->start*, literally start counting so one
-has to set the counter to a good value for the next interrupt; 2) inside the IRQ
-it should set the counter to the same resonable value.
-
-Reading is not a problem in RISC-V but writing would need some effort, since
-counters are not allowed to be written by S-mode.
-
-
-5. add()/del()/start()/stop()
------------------------------
-
-Basic idea: add()/del() adds/deletes events to/from a PMU, and start()/stop()
-starts/stop the counter of some event in the PMU.  All of them take the same
-arguments: *struct perf_event *event* and *int flag*.
-
-Consider perf as a state machine, then you will find that these functions serve
-as the state transition process between those states.
-Three states (event->hw.state) are defined:
-
-* PERF_HES_STOPPED:	the counter is stopped
-* PERF_HES_UPTODATE:	the event->count is up-to-date
-* PERF_HES_ARCH:	arch-dependent usage ... we don't need this for now
-
-A normal flow of these state transitions are as follows:
-
-* A user launches a perf event, resulting in calling to *event_init*.
-* When being context-switched in, *add* is called by the perf core, with a flag
-  PERF_EF_START, which means that the event should be started after it is added.
-  At this stage, a general event is bound to a physical counter, if any.
-  The state changes to PERF_HES_STOPPED and PERF_HES_UPTODATE, because it is now
-  stopped, and the (software) event count does not need updating.
-
-  - *start* is then called, and the counter is enabled.
-    With flag PERF_EF_RELOAD, it writes an appropriate value to the counter (check
-    previous section for detail).
-    Nothing is written if the flag does not contain PERF_EF_RELOAD.
-    The state now is reset to none, because it is neither stopped nor updated
-    (the counting already started)
-
-* When being context-switched out, *del* is called.  It then checks out all the
-  events in the PMU and calls *stop* to update their counts.
-
-  - *stop* is called by *del*
-    and the perf core with flag PERF_EF_UPDATE, and it often shares the same
-    subroutine as *read* with the same logic.
-    The state changes to PERF_HES_STOPPED and PERF_HES_UPTODATE, again.
-
-  - Life cycle of these two pairs: *add* and *del* are called repeatedly as
-    tasks switch in-and-out; *start* and *stop* is also called when the perf core
-    needs a quick stop-and-start, for instance, when the interrupt period is being
-    adjusted.
-
-Current implementation is sufficient for now and can be easily extended to
-features in the future.
-
-A. Related Structures
----------------------
-
-* struct pmu: include/linux/perf_event.h
-* struct riscv_pmu: arch/riscv/include/asm/perf_event.h
-
-  Both structures are designed to be read-only.
-
-  *struct pmu* defines some function pointer interfaces, and most of them take
-  *struct perf_event* as a main argument, dealing with perf events according to
-  perf's internal state machine (check kernel/events/core.c for details).
-
-  *struct riscv_pmu* defines PMU-specific parameters.  The naming follows the
-  convention of all other architectures.
-
-* struct perf_event: include/linux/perf_event.h
-* struct hw_perf_event
-
-  The generic structure that represents perf events, and the hardware-related
-  details.
-
-* struct riscv_hw_events: arch/riscv/include/asm/perf_event.h
-
-  The structure that holds the status of events, has two fixed members:
-  the number of events and the array of the events.
-
-References
-----------
-
-[1] https://github.com/riscv/riscv-linux/pull/124
-
-[2] https://groups.google.com/a/groups.riscv.org/forum/#!topic/sw-dev/f19TmCNP6yA
-- 
2.25.1

