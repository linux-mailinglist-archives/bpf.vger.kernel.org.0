Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058DA3C9544
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 02:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhGOA5P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 20:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhGOA5P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Jul 2021 20:57:15 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF5AC06175F;
        Wed, 14 Jul 2021 17:54:22 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 17so3556739pfz.4;
        Wed, 14 Jul 2021 17:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dC30QMGnyJNEUErUQ3fhsRUftOMNwLRariFNG7fHxac=;
        b=D0cuuO0Hq7pu6ZXCFqwmL+nZzaNy9wSAHCjiOcmFAOZo1HVqD6TZlB7uIPRHKez0s2
         q7cec1+M7nguZ266UxHa5/+bTNsDgCVM8Zt74dADiu2zKVUUXiMR5Dkof24BL1bFwmjf
         h2/fR+z2uzLP/c3XkMWJhwPs6fzWGgPAr4zKkyWHpGSdhT7g9dZg7Ud+HqgZQ76NhHXv
         NyvmqU9b6Dr8CSM7Bm1wr1ZGQjHXGXmY+stQuJHLt1x5O6c6GtH09N8VA5HdTJLeZhjj
         voHvywkrzt5Zx93HeJihJl9jpp1QQpFyahGFuBQdXABj0F3iDSOYFaYGwDx8xxa8rN3R
         08kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dC30QMGnyJNEUErUQ3fhsRUftOMNwLRariFNG7fHxac=;
        b=jbBRfzc3hIEMfuRi/6YrtVlpV2r3HWT+4NdBbwoH9I6f7iBCWPnUPFmqqwltzctaPI
         zugcKeSRlxNbvUsmvC68LGm1lGrxZSRUOKarApOry8HgLubJ+2CZUsXrXOloMYp035rb
         nvlI+s1rhzosSLAA8HdLtafzpxwYy79Rd9Mau8FEVallLO+wxO26/9C1+3a05WdbnnR6
         xiv2LbNXQHWH28t1outj1C6JEzAj3h64iIsk19nfuMaJfsSZyqCaROA17yiVaTdXWHV1
         intiUMgtrHp72d4uxU3osBhCRhtlmGrpEm94zRm2QpNBDNARSKCLnwPalBXvM11R3H+e
         jMJg==
X-Gm-Message-State: AOAM531q9QfSQIcXpLxZhjS4S3GSw9LsfnZWoWocXu2uM4rMbmJU1IDZ
        5tzcjgp1+/fg/WR/k7nAayrD1O25RBg=
X-Google-Smtp-Source: ABdhPJzCMWlqSH6RK/Plrqjpdo48HfBM+cIQqd5RJrKxwjZdn42BVOId4Eo2rQIb+ZodTVi4v221nQ==
X-Received: by 2002:a62:4e97:0:b029:312:7b4c:55b7 with SMTP id c145-20020a624e970000b02903127b4c55b7mr665357pfb.47.1626310461386;
        Wed, 14 Jul 2021 17:54:21 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:120c])
        by smtp.gmail.com with ESMTPSA id nl2sm3439011pjb.10.2021.07.14.17.54.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jul 2021 17:54:20 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 bpf-next 00/11] bpf: Introduce BPF timers.
Date:   Wed, 14 Jul 2021 17:54:06 -0700
Message-Id: <20210715005417.78572-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

The first request to support timers in bpf was made in 2013 before sys_bpf syscall
was added. That use case was periodic sampling. It was address with attaching
bpf programs to perf_events. Then during XDP development the timers were requested
to do garbage collection and health checks. They were worked around by implementing
timers in user space and triggering progs with BPF_PROG_RUN command.
The user space timers and perf_event+bpf timers are not armed by the bpf program.
They're done asynchronously vs program execution. The XDP program cannot send a
packet and arm the timer at the same time. The tracing prog cannot record an
event and arm the timer right away. This large class of use cases remained
unaddressed. The jiffy based and hrtimer based timers are essential part of the
kernel development and with this patch set the hrtimer based timers will be
available to bpf programs.

TLDR: bpf timers is a wrapper of hrtimers with all the extra safety added
to make sure bpf progs cannot crash the kernel.

v6->v7:
- address Andrii's comments and add his Acks.

v5->v6:
- address code review feedback from Martin and add his Acks.
- add usercnt > 0 check to bpf_timer_init and remove timers_cancel_and_free
second loop in map_free callbacks.
- add cond_resched_rcu.

v4->v5:
- Martin noticed the following issues:
. prog could be reallocated bpf_patch_insn_data().
Fixed by passing 'aux' into bpf_timer_set_callback, since 'aux' is stable
during insn patching.
. Added missing rcu_read_lock.
. Removed redundant record_map.
- Discovered few bugs with stress testing:
. One cpu does htab_free_prealloced_timers->bpf_timer_cancel_and_free->hrtimer_cancel
while another is trying to do something with the timer like bpf_timer_start/set_callback.
Those ops try to acquire bpf_spin_lock that is already taken by bpf_timer_cancel_and_free,
so both cpus spin forever. The same problem existed in bpf_timer_cancel().
One bpf prog on one cpu might call bpf_timer_cancel and wait, while another cpu is in
the timer callback that tries to do bpf_timer_*() helper on the same timer.
The fix is to do drop_prog_refcnt() and unlock. And only then hrtimer_cancel.
Because of this had to add callback_fn != NULL check to bpf_timer_cb().
Also removed redundant bpf_prog_inc/put from bpf_timer_cb() and replaced
with rcu_dereference_check similar to recent rcu_read_lock-removal from drivers.
bpf_timer_cb is in softirq.
. Managed to hit refcnt==0 while doing bpf_prog_put from bpf_timer_cancel_and_free().
That exposed the issue that bpf_prog_put wasn't ready to be called from irq context.
Fixed similar to bpf_map_put which is irq ready.
- Refactored BPF_CALL_1(bpf_spin_lock) into __bpf_spin_lock_irqsave() to
make the main logic more clear, since Martin and Yonghong brought up this concern.

v3->v4:
1.
Split callback_fn from bpf_timer_start into bpf_timer_set_callback as
suggested by Martin. That makes bpf timer api match one to one to
kernel hrtimer api and provides greater flexibility.
2.
Martin also discovered the following issue with uref approach:
bpftool prog load xdp_timer.o /sys/fs/bpf/xdp_timer type xdp
bpftool net attach xdpgeneric pinned /sys/fs/bpf/xdp_timer dev lo
rm /sys/fs/bpf/xdp_timer
nc -6 ::1 8888
bpftool net detach xdpgeneric dev lo
The timer callback stays active in the kernel though the prog was detached
and map usercnt == 0.
It happened because 'bpftool prog load' pinned the prog only.
The map usercnt went to zero. Subsequent attach and runs didn't
affect map usercnt. The timer was able to start and bpf_prog_inc itself.
When the prog was detached the prog stayed active.
To address this issue added
if (!atomic64_read(&(t->map->usercnt))) return -EPERM;
to the first patch.
Which means that timers are allowed only in the maps that are held
by user space with open file descriptor or maps pinned in bpffs.
3.
Discovered that timers in inner maps were broken.
The inner map pointers are dynamic. Therefore changed bpf_timer_init()
to accept explicit map pointer supplied by the program instead
of hidden map pointer supplied by the verifier.
To make sure that pointer to a timer actually belongs to that map
added the verifier check in patch 3.
4.
Addressed Yonghong's feedback. Improved comments and added
dynamic in_nmi() check.
Added Acks.

Acked-by: Toke Høiland-Jørgensen <toke@redhat.com> # for the feature

v2->v3:
The v2 approach attempted to bump bpf_prog refcnt when bpf_timer_start is
called to make sure callback code doesn't disappear when timer is active and
drop refcnt when timer cb is done. That led to a ton of race conditions between
callback running and concurrent bpf_timer_init/start/cancel on another cpu,
and concurrent bpf_map_update/delete_elem, and map destroy.

Then v2.5 approach skipped prog refcnt altogether. Instead it remembered all
timers that bpf prog armed in a link list and canceled them when prog refcnt
went to zero. The race conditions disappeared, but timers in map-in-map could
not be supported cleanly, since timers in inner maps have inner map's life time
and don't match prog's life time.

This v3 approach makes timers to be owned by maps. It allows timers in inner
maps to be supported from the start. This apporach relies on "user refcnt"
scheme used in prog_array that stores bpf programs for bpf_tail_call. The
bpf_timer_start() increments prog refcnt, but unlike 1st approach the timer
callback does decrement the refcnt. The ops->map_release_uref is
responsible for cancelling the timers and dropping prog refcnt when user space
reference to a map is dropped. That addressed all the races and simplified
locking.

Andrii presented a use case where specifying callback_fn in bpf_timer_init()
is inconvenient vs specifying in bpf_timer_start(). The bpf_timer_init()
typically is called outside for timer callback, while bpf_timer_start() most
likely will be called from the callback. 
timer_cb() { ... bpf_timer_start(timer_cb); ...} looks like recursion and as
infinite loop to the verifier. The verifier had to be made smarter to recognize
such async callbacks. Patches 7,8,9 addressed that.

Patch 1 and 2 refactoring.
Patch 3 implements bpf timer helpers and locking.
Patch 4 implements map side of bpf timer support.
Patch 5 prevent pointer mismatch in bpf_timer_init.
Patch 6 adds support for BTF in inner maps.
Patch 7 teaches check_cfg() pass to understand async callbacks.
Patch 8 teaches do_check() pass to understand async callbacks.
Patch 9 teaches check_max_stack_depth() pass to understand async callbacks.
Patches 10 and 11 are the tests.

v1->v2:
- Addressed great feedback from Andrii and Toke.
- Fixed race between parallel bpf_timer_*() ops.
- Fixed deadlock between timer callback and LRU eviction or bpf_map_delete/update.
- Disallowed mmap and global timers.
- Allow spin_lock and bpf_timer in an element.
- Fixed memory leaks due to map destruction and LRU eviction.
- A ton more tests.

Alexei Starovoitov (11):
  bpf: Prepare bpf_prog_put() to be called from irq context.
  bpf: Factor out bpf_spin_lock into helpers.
  bpf: Introduce bpf timers.
  bpf: Add map side support for bpf timers.
  bpf: Prevent pointer mismatch in bpf_timer_init.
  bpf: Remember BTF of inner maps.
  bpf: Relax verifier recursion check.
  bpf: Implement verifier support for validation of async callbacks.
  bpf: Teach stack depth check about async callbacks.
  selftests/bpf: Add bpf_timer test.
  selftests/bpf: Add a test with bpf_timer in inner map.

 include/linux/bpf.h                           |  47 ++-
 include/linux/bpf_verifier.h                  |  19 +-
 include/linux/btf.h                           |   1 +
 include/uapi/linux/bpf.h                      |  73 ++++
 kernel/bpf/arraymap.c                         |  21 ++
 kernel/bpf/btf.c                              |  77 +++-
 kernel/bpf/hashtab.c                          | 105 +++++-
 kernel/bpf/helpers.c                          | 340 +++++++++++++++++-
 kernel/bpf/local_storage.c                    |   4 +-
 kernel/bpf/map_in_map.c                       |   8 +
 kernel/bpf/syscall.c                          |  53 ++-
 kernel/bpf/verifier.c                         | 307 +++++++++++++++-
 kernel/trace/bpf_trace.c                      |   2 +-
 scripts/bpf_doc.py                            |   2 +
 tools/include/uapi/linux/bpf.h                |  73 ++++
 .../testing/selftests/bpf/prog_tests/timer.c  |  55 +++
 .../selftests/bpf/prog_tests/timer_mim.c      |  69 ++++
 tools/testing/selftests/bpf/progs/timer.c     | 297 +++++++++++++++
 tools/testing/selftests/bpf/progs/timer_mim.c |  88 +++++
 .../selftests/bpf/progs/timer_mim_reject.c    |  74 ++++
 20 files changed, 1651 insertions(+), 64 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_mim.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_mim.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_mim_reject.c

-- 
2.30.2

