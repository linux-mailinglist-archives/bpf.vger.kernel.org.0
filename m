Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18224179737
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 18:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgCDRxQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 12:53:16 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20030 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727804AbgCDRxQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Mar 2020 12:53:16 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024HiFI1026677
        for <bpf@vger.kernel.org>; Wed, 4 Mar 2020 09:53:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=Leff6EBwDZsW4WXwtdvF7icBVvTeHeXJQYMruPJwuw8=;
 b=qViD7w+igSwD6fxzntuEKx+HiVlJ0FuPv53argoSa5meeDsOx2/GoWholoyhnr267/bg
 zms/RtALrZrykSqXHe3kigbLHrsfW9Ye3ss4QPzWgLoGBRQPcH5wb0hwmhMR7SHKv7Nr
 q4I2Q+ILlBKFIHtSbKtMU4xBwf1CQYLAYto= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yht6473c9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 09:53:15 -0800
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 4 Mar 2020 09:53:13 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 7CA723701184; Wed,  4 Mar 2020 09:53:10 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf v2 1/2] bpf: Fix deadlock with rq_lock in bpf_send_signal()
Date:   Wed, 4 Mar 2020 09:53:10 -0800
Message-ID: <20200304175310.2389917-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304175310.2389842-1-yhs@fb.com>
References: <20200304175310.2389842-1-yhs@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_07:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 suspectscore=43 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040123
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When experimenting with bpf_send_signal() helper in our production
environment (5.2 based), we experienced a deadlock in NMI mode:
   #5 [ffffc9002219f770] queued_spin_lock_slowpath at ffffffff8110be24
   #6 [ffffc9002219f770] _raw_spin_lock_irqsave at ffffffff81a43012
   #7 [ffffc9002219f780] try_to_wake_up at ffffffff810e7ecd
   #8 [ffffc9002219f7e0] signal_wake_up_state at ffffffff810c7b55
   #9 [ffffc9002219f7f0] __send_signal at ffffffff810c8602
  #10 [ffffc9002219f830] do_send_sig_info at ffffffff810ca31a
  #11 [ffffc9002219f868] bpf_send_signal at ffffffff8119d227
  #12 [ffffc9002219f988] bpf_overflow_handler at ffffffff811d4140
  #13 [ffffc9002219f9e0] __perf_event_overflow at ffffffff811d68cf
  #14 [ffffc9002219fa10] perf_swevent_overflow at ffffffff811d6a09
  #15 [ffffc9002219fa38] ___perf_sw_event at ffffffff811e0f47
  #16 [ffffc9002219fc30] __schedule at ffffffff81a3e04d
  #17 [ffffc9002219fc90] schedule at ffffffff81a3e219
  #18 [ffffc9002219fca0] futex_wait_queue_me at ffffffff8113d1b9
  #19 [ffffc9002219fcd8] futex_wait at ffffffff8113e529
  #20 [ffffc9002219fdf0] do_futex at ffffffff8113ffbc
  #21 [ffffc9002219fec0] __x64_sys_futex at ffffffff81140d1c
  #22 [ffffc9002219ff38] do_syscall_64 at ffffffff81002602
  #23 [ffffc9002219ff50] entry_SYSCALL_64_after_hwframe at ffffffff81c00068

The above call stack is actually very similar to an issue
reported by Commit eac9153f2b58 ("bpf/stackmap: Fix deadlock with
rq_lock in bpf_get_stack()") by Song Liu. The only difference is
bpf_send_signal() helper instead of bpf_get_stack() helper.

The above deadlock is triggered with a perf_sw_event.
Similar to Commit eac9153f2b58, the above reproducer used tracepoint
point sched/sched_switch so the issue can be easily catched.
  /* stress_test.c */
  #include <stdio.h>
  #include <stdlib.h>
  #include <sys/mman.h>
  #include <pthread.h>
  #include <sys/types.h>
  #include <sys/stat.h>
  #include <fcntl.h>

  #define THREAD_COUNT 1000
  char *filename;
  void *worker(void *p)
  {
        void *ptr;
        int fd;
        char *pptr;

        fd = open(filename, O_RDONLY);
        if (fd < 0)
                return NULL;
        while (1) {
                struct timespec ts = {0, 1000 + rand() % 2000};

                ptr = mmap(NULL, 4096 * 64, PROT_READ, MAP_PRIVATE, fd, 0);
                usleep(1);
                if (ptr == MAP_FAILED) {
                        printf("failed to mmap\n");
                        break;
                }
                munmap(ptr, 4096 * 64);
                usleep(1);
                pptr = malloc(1);
                usleep(1);
                pptr[0] = 1;
                usleep(1);
                free(pptr);
                usleep(1);
                nanosleep(&ts, NULL);
        }
        close(fd);
        return NULL;
  }

  int main(int argc, char *argv[])
  {
        void *ptr;
        int i;
        pthread_t threads[THREAD_COUNT];

        if (argc < 2)
                return 0;

        filename = argv[1];

        for (i = 0; i < THREAD_COUNT; i++) {
                if (pthread_create(threads + i, NULL, worker, NULL)) {
                        fprintf(stderr, "Error creating thread\n");
                        return 0;
                }
        }

        for (i = 0; i < THREAD_COUNT; i++)
                pthread_join(threads[i], NULL);
        return 0;
  }
and the following command:
  1. run `stress_test /bin/ls` in one windown
  2. hack bcc trace.py with the following change:
     --- a/tools/trace.py
     +++ b/tools/trace.py
     @@ -513,6 +513,7 @@ BPF_PERF_OUTPUT(%s);
              __data.tgid = __tgid;
              __data.pid = __pid;
              bpf_get_current_comm(&__data.comm, sizeof(__data.comm));
     +        bpf_send_signal(10);
      %s
      %s
              %s.perf_submit(%s, &__data, sizeof(__data));
  3. in a different window run
     ./trace.py -p $(pidof stress_test) t:sched:sched_switch

The deadlock can be reproduced.

Similar to Song's fix, the fix is to delay sending signal if
irqs is disabled to avoid deadlocks involving with rq_lock.
With this change, my above stress-test in our production system
won't cause deadlock any more.

I also implemented a scale-down version of reproducer in the
selftest (a subsequent commit). With latest bpf-next,
it complains for the following deadlock.
  [   32.832450] -> #1 (&p->pi_lock){-.-.}:
  [   32.833100]        _raw_spin_lock_irqsave+0x44/0x80
  [   32.833696]        task_rq_lock+0x2c/0xa0
  [   32.834182]        task_sched_runtime+0x59/0xd0
  [   32.834721]        thread_group_cputime+0x250/0x270
  [   32.835304]        thread_group_cputime_adjusted+0x2e/0x70
  [   32.835959]        do_task_stat+0x8a7/0xb80
  [   32.836461]        proc_single_show+0x51/0xb0
  ...
  [   32.839512] -> #0 (&(&sighand->siglock)->rlock){....}:
  [   32.840275]        __lock_acquire+0x1358/0x1a20
  [   32.840826]        lock_acquire+0xc7/0x1d0
  [   32.841309]        _raw_spin_lock_irqsave+0x44/0x80
  [   32.841916]        __lock_task_sighand+0x79/0x160
  [   32.842465]        do_send_sig_info+0x35/0x90
  [   32.842977]        bpf_send_signal+0xa/0x10
  [   32.843464]        bpf_prog_bc13ed9e4d3163e3_send_signal_tp_sched+0x465/0x1000
  [   32.844301]        trace_call_bpf+0x115/0x270
  [   32.844809]        perf_trace_run_bpf_submit+0x4a/0xc0
  [   32.845411]        perf_trace_sched_switch+0x10f/0x180
  [   32.846014]        __schedule+0x45d/0x880
  [   32.846483]        schedule+0x5f/0xd0
  ...

  [   32.853148] Chain exists of:
  [   32.853148]   &(&sighand->siglock)->rlock --> &p->pi_lock --> &rq->lock
  [   32.853148]
  [   32.854451]  Possible unsafe locking scenario:
  [   32.854451]
  [   32.855173]        CPU0                    CPU1
  [   32.855745]        ----                    ----
  [   32.856278]   lock(&rq->lock);
  [   32.856671]                                lock(&p->pi_lock);
  [   32.857332]                                lock(&rq->lock);
  [   32.857999]   lock(&(&sighand->siglock)->rlock);

  Deadlock happens on CPU0 when it tries to acquire &sighand->siglock
  but it has been held by CPU1 and CPU1 tries to grab &rq->lock
  and cannot get it.

  This is not exactly the callstack in our production environment,
  but sympotom is similar and both locks are using spin_lock_irqsave()
  to acquire the lock, and both involves rq_lock. The fix to delay
  sending signal when irq is disabled also fixed this issue.

Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/trace/bpf_trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 07764c761073..43ccfdbacb03 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -730,7 +730,10 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type)
 	if (unlikely(!nmi_uaccess_okay()))
 		return -EPERM;
 
-	if (in_nmi()) {
+	/* Delay sending signal if irq is disabled. Otherwise,
+	 * we risk deadlock with rq_lock.
+	 */
+	if (irqs_disabled()) {
 		/* Do an early check on signal validity. Otherwise,
 		 * the error is lost in deferred irq_work.
 		 */
-- 
2.17.1

