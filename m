Return-Path: <bpf+bounces-52628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F55A45AF3
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 10:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798843ADC35
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 09:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1870F224259;
	Wed, 26 Feb 2025 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fgfQXxxz"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC58214A62A;
	Wed, 26 Feb 2025 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563907; cv=none; b=Ks6YUbgyg+2WOyRM3rnDQXsjvhMnNmR1QEBUCDBghA9H56pC6iJ0R1bbRCLTyh+CLmzGIQhPo5kiw5yHgRVVoEe0qjp+OjOuW9JUPV1ZZ/WapTnoKipmbKOPc+o9jRvKYhcNs+/Gf4QMcrmjLllFBpVIao0gLOjBq5LEcolO2/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563907; c=relaxed/simple;
	bh=pelp1+XSqRKET/05oAH3CW5f4P+LEHKPmjLWJnZmLnw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZSD37N+YEFUtggzY6OeK1yYY3/5bqslNCSnCFGm5E1qVEvv2eBjBR6MedQONQMHUtVd0gsr3uFZRTm7nTxN6/autQyXjzZ3SlML7vWEJ2OXrngyiBhy5JAkfqErMhmgSLMIvFU5J3cgtdJ+50OprGAn1PS78f8l4OcT8U02mqeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fgfQXxxz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q5Onsp022241;
	Wed, 26 Feb 2025 09:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=12/hKo
	CVLdkTZvGJx68dPfBMPZ7LcGIk1Zs2DLmBcQk=; b=fgfQXxxz+CQUBpsQ84gEmX
	7PwlwN++ykLHUNL6QGVU2qTW39FjJDlv8knIRlXuckKp1k7jSiMhM1VYffh9Qpf/
	sqJA/ml1oYB2qPhmBTmxn7noNBnEkAXuYCTsKikSTiqKuIUffojWNvofLov3Kmjq
	LFndCw073jKbHNdaDOLDzd4e1J3qe2AN0T/OZBZDoPYz0F9+SyPC0gC0mpfAikZn
	JKV90GecfjlCi9S0idSUaKrMAEcOjeF6KXecMBnDbs1701k2cHcoXPAjGwkWQvYy
	2oWhHTYiTdsYLruyLoxw4el6tKtezPYFArUsN2nKyiszt090LFK+oSAuDNvyJVoQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451vs8151r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 09:58:05 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51Q9w52t028602;
	Wed, 26 Feb 2025 09:58:05 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451vs8151m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 09:58:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q7pu0f026285;
	Wed, 26 Feb 2025 09:58:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44yswnhyjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 09:58:03 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51Q9w1Yn38142334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 09:58:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A06B620043;
	Wed, 26 Feb 2025 09:58:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 993C32004D;
	Wed, 26 Feb 2025 09:57:55 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.247.223])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Feb 2025 09:57:55 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v7 4/4] perf lock: Report owner stack in usermode
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20250224184742.4144931-5-ctshao@google.com>
Date: Wed, 26 Feb 2025 15:27:41 +0530
Cc: "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, nick.forrington@arm.com,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
        bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <838FC998-5E85-4511-BA65-B32ADD1B817C@linux.ibm.com>
References: <20250224184742.4144931-1-ctshao@google.com>
 <20250224184742.4144931-5-ctshao@google.com>
To: Chun-Tse Shao <ctshao@google.com>, Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fUOIy-6ZBN1vwmGUS3EE07q9bshL04Vh
X-Proofpoint-GUID: x5wIdyrXLBpUw3kh5Fl6NQzjl9129KZC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_01,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260075



> On 25 Feb 2025, at 12:12=E2=80=AFAM, Chun-Tse Shao <ctshao@google.com> =
wrote:
>=20
> This patch parses `owner_lock_stat` into a RB tree, enabling ordered
> reporting of owner lock statistics with stack traces. It also updates
> the documentation for the `-o` option in contention mode, decouples =
`-o`
> from `-t`, and issues a warning to inform users about the new behavior
> of `-ov`.
>=20
> Example output:
>  $ sudo ~/linux/tools/perf/perf lock con -abvo -Y mutex-spin -E3 perf =
bench sched pipe
>  ...
>   contended   total wait     max wait     avg wait         type   =
caller
>=20
>         171      1.55 ms     20.26 us      9.06 us        mutex   =
pipe_read+0x57
>                          0xffffffffac6318e7  pipe_read+0x57
>                          0xffffffffac623862  vfs_read+0x332
>                          0xffffffffac62434b  ksys_read+0xbb
>                          0xfffffffface604b2  do_syscall_64+0x82
>                          0xffffffffad00012f  =
entry_SYSCALL_64_after_hwframe+0x76
>          36    193.71 us     15.27 us      5.38 us        mutex   =
pipe_write+0x50
>                          0xffffffffac631ee0  pipe_write+0x50
>                          0xffffffffac6241db  vfs_write+0x3bb
>                          0xffffffffac6244ab  ksys_write+0xbb
>                          0xfffffffface604b2  do_syscall_64+0x82
>                          0xffffffffad00012f  =
entry_SYSCALL_64_after_hwframe+0x76
>           4     51.22 us     16.47 us     12.80 us        mutex   =
do_epoll_wait+0x24d
>                          0xffffffffac691f0d  do_epoll_wait+0x24d
>                          0xffffffffac69249b  do_epoll_pwait.part.0+0xb
>                          0xffffffffac693ba5  =
__x64_sys_epoll_pwait+0x95
>                          0xfffffffface604b2  do_syscall_64+0x82
>                          0xffffffffad00012f  =
entry_SYSCALL_64_after_hwframe+0x76
>=20
>  =3D=3D=3D owner stack trace =3D=3D=3D
>=20
>           3     31.24 us     15.27 us     10.41 us        mutex   =
pipe_read+0x348
>                          0xffffffffac631bd8  pipe_read+0x348
>                          0xffffffffac623862  vfs_read+0x332
>                          0xffffffffac62434b  ksys_read+0xbb
>                          0xfffffffface604b2  do_syscall_64+0x82
>                          0xffffffffad00012f  =
entry_SYSCALL_64_after_hwframe+0x76
>  ...
>=20
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
> tools/perf/Documentation/perf-lock.txt |  5 ++-
> tools/perf/builtin-lock.c              | 22 +++++++++-
> tools/perf/util/bpf_lock_contention.c  | 57 ++++++++++++++++++++++++++
> tools/perf/util/lock-contention.h      |  7 ++++
> 4 files changed, 87 insertions(+), 4 deletions(-)
>=20
> diff --git a/tools/perf/Documentation/perf-lock.txt =
b/tools/perf/Documentation/perf-lock.txt
> index d3793054f7d3..859dc11a7372 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -179,8 +179,9 @@ CONTENTION OPTIONS
>=20
> -o::
> --lock-owner::
> - Show lock contention stat by owners.  Implies --threads and
> - requires --use-bpf.
> + Show lock contention stat by owners. This option can be combined =
with -t,
> + which shows owner's per thread lock stats, or -v, which shows =
owner's
> + stacktrace. Requires --use-bpf.
>=20
> -Y::
> --type-filter=3D<value>::
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 9bebc186286f..05e7bc30488a 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1817,6 +1817,22 @@ static void print_contention_result(struct =
lock_contention *con)
> break;
> }
>=20
> + if (con->owner && con->save_callstack && verbose > 0) {
> + struct rb_root root =3D RB_ROOT;
> +
> + if (symbol_conf.field_sep)
> + fprintf(lock_output, "# owner stack trace:\n");
> + else
> + fprintf(lock_output, "\n=3D=3D=3D owner stack trace =3D=3D=3D\n\n");
> + while ((st =3D pop_owner_stack_trace(con)))
> + insert_to(&root, st, compare);
> +
> + while ((st =3D pop_from(&root))) {
> + print_lock_stat(con, st);
> + free(st);
> + }
> + }
> +
> if (print_nr_entries) {
> /* update the total/bad stats */
> while ((st =3D pop_from_result())) {
> @@ -1962,8 +1978,10 @@ static int check_lock_contention_options(const =
struct option *options,
> }
> }
>=20
> - if (show_lock_owner)
> - show_thread_stats =3D true;
> + if (show_lock_owner && !show_thread_stats) {
> + pr_warning("Now -o try to show owner's callstack instead of pid and =
comm.\n");
> + pr_warning("Please use -t option too to keep the old behavior.\n");
> + }
>=20
> return 0;
> }
> diff --git a/tools/perf/util/bpf_lock_contention.c =
b/tools/perf/util/bpf_lock_contention.c
> index 76542b86e83f..16f4deba69ec 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -549,6 +549,63 @@ static const char =
*lock_contention_get_name(struct lock_contention *con,
> return name_buf;
> }
>=20
> +struct lock_stat *pop_owner_stack_trace(struct lock_contention *con)
> +{
> + int stacks_fd, stat_fd;
> + u64 *stack_trace =3D NULL;
> + s32 stack_id;
> + struct contention_key ckey =3D {};
> + struct contention_data cdata =3D {};
> + size_t stack_size =3D con->max_stack * sizeof(*stack_trace);
> + struct lock_stat *st =3D NULL;
> +
> + stacks_fd =3D bpf_map__fd(skel->maps.owner_stacks);
> + stat_fd =3D bpf_map__fd(skel->maps.owner_stat);
> + if (!stacks_fd || !stat_fd)
> + goto out_err;
> +
> + stack_trace =3D zalloc(stack_size);
> + if (stack_trace =3D=3D NULL)
> + goto out_err;
> +
> + if (bpf_map_get_next_key(stacks_fd, NULL, stack_trace))
> + goto out_err;
> +
> + bpf_map_lookup_elem(stacks_fd, stack_trace, &stack_id);
> + ckey.stack_id =3D stack_id;
> + bpf_map_lookup_elem(stat_fd, &ckey, &cdata);
> +
> + st =3D zalloc(sizeof(struct lock_stat));
> + if (!st)
> + goto out_err;
> +
> + st->name =3D strdup(stack_trace[0] ? lock_contention_get_name(con, =
NULL, stack_trace, 0) :
> +   "unknown");

Hi,

I am hitting a compilation issue with this change. Sorry for responding =
late. I tried with change from tmp.perf-tools-next and hit below issue:


  CC      util/bpf_lock_contention.o
util/bpf_lock_contention.c: In function =E2=80=98lock_contention_get_name=E2=
=80=99:
cc1: error: function may return address of local variable =
[-Werror=3Dreturn-local-addr]
util/bpf_lock_contention.c:470:45: note: declared here
  470 |                 struct contention_task_data task;
      |                                             ^~~~
cc1: all warnings being treated as errors
make[4]: *** [/root/perf-tools-next/tools/build/Makefile.build:85: =
util/bpf_lock_contention.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  LD      perf-in.o
make[3]: *** [/root/perf-tools-next/tools/build/Makefile.build:138: =
util] Error 2
make[2]: *** [Makefile.perf:822: perf-util-in.o] Error 2
make[1]: *** [Makefile.perf:321: sub-make] Error 2
make: *** [Makefile:76: all] Error 2


Code snippet:

if (con->aggr_mode =3D=3D LOCK_AGGR_TASK) {
                struct contention_task_data task;
                int pid =3D key->pid;
                int task_fd =3D bpf_map__fd(skel->maps.task_data);

                /* do not update idle comm which contains CPU number */
                if (pid) {
                        struct thread *t =3D =
machine__findnew_thread(machine, /*pid=3D*/-1, pid);

                        if (t =3D=3D NULL)
                                return name;
                        if (!bpf_map_lookup_elem(task_fd, &pid, &task) =
&&
                            thread__set_comm(t, task.comm, =
/*timestamp=3D*/0))
                                name =3D task.comm;
                }
                return name;
        }


We are calling lock_contention_get_name with second argument as NULL .
Though error above points to =E2=80=9Ccontention_task_data=E2=80=9D, I =
think the local variable here is for =E2=80=9Cname=E2=80=9D ?


Thanks
Athira

> + if (!st->name)
> + goto out_err;
> +
> + st->flags =3D cdata.flags;
> + st->nr_contended =3D cdata.count;
> + st->wait_time_total =3D cdata.total_time;
> + st->wait_time_max =3D cdata.max_time;
> + st->wait_time_min =3D cdata.min_time;
> + st->callstack =3D stack_trace;
> +
> + if (cdata.count)
> + st->avg_wait_time =3D cdata.total_time / cdata.count;
> +
> + bpf_map_delete_elem(stacks_fd, stack_trace);
> + bpf_map_delete_elem(stat_fd, &ckey);
> +
> + return st;
> +
> +out_err:
> + free(stack_trace);
> + free(st);
> +
> + return NULL;
> +}
> +
> int lock_contention_read(struct lock_contention *con)
> {
> int fd, stack, err =3D 0;
> diff --git a/tools/perf/util/lock-contention.h =
b/tools/perf/util/lock-contention.h
> index a09f7fe877df..97fd33c57f17 100644
> --- a/tools/perf/util/lock-contention.h
> +++ b/tools/perf/util/lock-contention.h
> @@ -168,6 +168,8 @@ int lock_contention_stop(void);
> int lock_contention_read(struct lock_contention *con);
> int lock_contention_finish(struct lock_contention *con);
>=20
> +struct lock_stat *pop_owner_stack_trace(struct lock_contention *con);
> +
> #else  /* !HAVE_BPF_SKEL */
>=20
> static inline int lock_contention_prepare(struct lock_contention *con =
__maybe_unused)
> @@ -187,6 +189,11 @@ static inline int lock_contention_read(struct =
lock_contention *con __maybe_unuse
> return 0;
> }
>=20
> +struct lock_stat *pop_owner_stack_trace(struct lock_contention *con)
> +{
> + return NULL;
> +}
> +
> #endif  /* HAVE_BPF_SKEL */
>=20
> #endif  /* PERF_LOCK_CONTENTION_H */
> --=20
> 2.48.1.658.g4767266eb4-goog
>=20
>=20


