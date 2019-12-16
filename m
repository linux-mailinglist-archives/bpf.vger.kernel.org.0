Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97AAF11FEAC
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2019 08:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfLPHBB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Dec 2019 02:01:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:60617 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfLPHBB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Dec 2019 02:01:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Dec 2019 23:01:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,320,1571727600"; 
   d="scan'208";a="227022520"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 15 Dec 2019 23:00:59 -0800
Received: from [10.251.95.214] (abudanko-mobl.ccr.corp.intel.com [10.251.95.214])
        by linux.intel.com (Postfix) with ESMTP id EB57B5802C9;
        Sun, 15 Dec 2019 23:00:50 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v2 0/7] Introduce CAP_SYS_PERFMON to secure system performance
 monitoring and observability
To:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        Alexei Starovoitov <ast@kernel.org>,
        james.bottomley@hansenpartnership.com, benh@kernel.crashing.org,
        Casey Schaufler <casey@schaufler-ca.com>, serge@hallyn.com,
        James Morris <jmorris@namei.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org, bgregg@netflix.com,
        Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Organization: Intel Corp.
Message-ID: <26101427-c0a3-db9f-39e9-9e5f4ddd009c@linux.intel.com>
Date:   Mon, 16 Dec 2019 10:00:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Currently access to perf_events, i915_perf and other performance monitoring and
observability subsystems of the kernel is open for a privileged process [1] with
CAP_SYS_ADMIN capability enabled in the process effective set [2].

This patch set introduces CAP_SYS_PERFMON capability devoted to secure system
performance monitoring and observability operations so that CAP_SYS_PERFMON would
assist CAP_SYS_ADMIN capability in its governing role for perf_events, i915_perf
and other performance monitoring and observability subsystems of the kernel.

CAP_SYS_PERFMON intends to meet the demand to secure system performance monitoring
and observability operations in security sensitive, restricted, production
environments (e.g. HPC clusters, cloud and virtual compute environments) where root
or CAP_SYS_ADMIN credentials are not available to mass users of a system because
of security considerations.

CAP_SYS_PERFMON intends to harden system security and integrity during system
performance monitoring and observability operations by decreasing attack surface
that is available to CAP_SYS_ADMIN privileged processes [2].

CAP_SYS_PERFMON intends to take over CAP_SYS_ADMIN credentials related to system
performance monitoring and observability operations and balance amount of
CAP_SYS_ADMIN credentials following the recommendations in the capabilities man
page [2] for CAP_SYS_ADMIN: "Note: this capability is overloaded; see Notes to
kernel developers, below."

For backward compatibility reasons access to system performance monitoring and
observability subsystems of the kernel remains open for CAP_SYS_ADMIN privileged
processes but CAP_SYS_ADMIN capability usage for secure system performance monitoring
and observability operations is discouraged with respect to the introduced
CAP_SYS_PERFMON capability.

The patch set is for tip perf/core repository:
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip perf/core
sha1: ceb9e77324fa661b1001a0ae66f061b5fcb4e4e6

---
Changes in v2:
- made perf_events trace points available to CAP_SYS_PERFMON privileged processes
- made perf_event_paranoid_check() treat CAP_SYS_PERFMON equally to CAP_SYS_ADMIN
- applied CAP_SYS_PERFMON to i915_perf, bpf_trace, powerpc and parisc system
  performance monitoring and observability related subsystems

---
Alexey Budankov (7):
  capabilities: introduce CAP_SYS_PERFMON to kernel and user space
  perf/core: open access for CAP_SYS_PERFMON privileged process
  perf tool: extend Perf tool with CAP_SYS_PERFMON capability support
  drm/i915/perf: open access for CAP_SYS_PERFMON privileged process
  trace/bpf_trace: open access for CAP_SYS_PERFMON privileged process
  powerpc/perf: open access for CAP_SYS_PERFMON privileged process
  parisc/perf: open access for CAP_SYS_PERFMON privileged process

 arch/parisc/kernel/perf.c           |  2 +-
 arch/powerpc/perf/imc-pmu.c         |  4 ++--
 drivers/gpu/drm/i915/i915_perf.c    | 13 +++++++------
 include/linux/perf_event.h          |  9 ++++++---
 include/uapi/linux/capability.h     |  8 +++++++-
 kernel/trace/bpf_trace.c            |  2 +-
 security/selinux/include/classmap.h |  4 ++--
 tools/perf/design.txt               |  3 ++-
 tools/perf/util/cap.h               |  4 ++++
 tools/perf/util/evsel.c             | 10 +++++-----
 tools/perf/util/util.c              |  1 +
 11 files changed, 38 insertions(+), 22 deletions(-)

---
Testing and validation (Intel Skylake, 8 cores, Fedora 29, 5.4.0-rc8+, x86_64):

libcap library [3], [4] and Perf tool can be used to apply CAP_SYS_PERFMON 
capability for secure system performance monitoring and observability beyond the
scope permitted by the system wide perf_event_paranoid kernel setting [5] and
below are the steps for evaluation:

  - patch, build and boot the kernel
  - patch, build Perf tool e.g. to /home/user/perf
  ...
  # git clone git://git.kernel.org/pub/scm/libs/libcap/libcap.git libcap
  # pushd libcap
  # patch libcap/include/uapi/linux/capabilities.h with [PATCH 1]
  # make
  # pushd progs
  # ./setcap "cap_sys_perfmon,cap_sys_ptrace,cap_syslog=ep" /home/user/perf
  # ./setcap -v "cap_sys_perfmon,cap_sys_ptrace,cap_syslog=ep" /home/user/perf
  /home/user/perf: OK
  # ./getcap /home/user/perf
  /home/user/perf = cap_sys_ptrace,cap_syslog,cap_sys_perfmon+ep
  # echo 2 > /proc/sys/kernel/perf_event_paranoid
  # cat /proc/sys/kernel/perf_event_paranoid 
  2
  ...
  $ /home/user/perf top
    ... works as expected ...
  $ cat /proc/`pidof perf`/status
  Name:	perf
  Umask:	0002
  State:	S (sleeping)
  Tgid:	2958
  Ngid:	0
  Pid:	2958
  PPid:	9847
  TracerPid:	0
  Uid:	500	500	500	500
  Gid:	500	500	500	500
  FDSize:	256
  ...
  CapInh:	0000000000000000
  CapPrm:	0000004400080000
  CapEff:	0000004400080000 => 01000100 00000000 00001000 00000000 00000000
                                     cap_sys_perfmon,cap_sys_ptrace,cap_syslog
  CapBnd:	0000007fffffffff
  CapAmb:	0000000000000000
  NoNewPrivs:	0
  Seccomp:	0
  Speculation_Store_Bypass:	thread vulnerable
  Cpus_allowed:	ff
  Cpus_allowed_list:	0-7
  ...

Usage of cap_sys_perfmon effectively avoids unused credentials excess:

- with cap_sys_admin:
  CapEff:	0000007fffffffff => 01111111 11111111 11111111 11111111 11111111

- with cap_sys_perfmon:
  CapEff:	0000004400080000 => 01000100 00000000 00001000 00000000 00000000
                                    38   34               19
                           sys_perfmon   syslog           sys_ptrace

---

[1] https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
[2] http://man7.org/linux/man-pages/man7/capabilities.7.html
[3] http://man7.org/linux/man-pages/man8/setcap.8.html
[4] https://git.kernel.org/pub/scm/libs/libcap/libcap.git
[5] http://man7.org/linux/man-pages/man2/perf_event_open.2.html
[6] https://sites.google.com/site/fullycapable/, posix_1003.1e-990310.pdf

-- 
2.20.1

