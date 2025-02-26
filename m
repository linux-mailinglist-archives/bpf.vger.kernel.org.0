Return-Path: <bpf+bounces-52674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800FBA4684D
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 18:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 278E87A3F9F
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 17:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5648225408;
	Wed, 26 Feb 2025 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJtRG5K5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DA021CC6A;
	Wed, 26 Feb 2025 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740591747; cv=none; b=GrG7mYKzb+Aplqqn4B7QR1Fxhpzl7a714j2acHs2eH2Edxu5pNuQGpj9qkjQzMDxdFp1j/I8c2GpkNrmv5cQgvrbqJ0gCYiTgOudmE03jX48Ung+MVScR9cBGoh4eVvR4LpaQV9I8nBY/6YKUdZCpzVLYepIDItc6ljTLelP3Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740591747; c=relaxed/simple;
	bh=ids+q8yuoCUoITZzkHwCFqezTLqWL9xDF1fa3noQ4ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/et55VD7fE/gI/YXlKwjHbrt7k3IWgIATwpVdfX1zEb97UsmIe50WYIJv8lUy2ncpR/VUNRwz1chhalQFNBn2PuDukyy0oqAM8h9D50OJH1g8mHHTalV9x0oPDCp+5go9AMewL9a7rR85VXj2cWVo+GUx9uBXYTwp3lBmgQN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJtRG5K5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECD7C4CED6;
	Wed, 26 Feb 2025 17:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740591746;
	bh=ids+q8yuoCUoITZzkHwCFqezTLqWL9xDF1fa3noQ4ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qJtRG5K5rya4ElwvSDPPTfiN0ZW85QnjkU7L3cvGWGGOHWklON8me9gmLaqb9NpEv
	 zuxS6uRtg0ZYH+hAkvP9E/UdjJ0Ni8FP3kyJDg3PLv8Q8GKQrI1hhA2sy5zARTBnSp
	 clmPYyliRXQ1KSI/MgRWFp4YbnITnqpvvIpcAcfhF8ZiQhC5+wTXobvJykTpvep5h5
	 dLofq/edUywHLSGRczYaG8gc3H2vyUhK89ReNxzkYpniK1qaQjdVtKCGSLOFhmcUYM
	 y077SuXYWVpE5K01xJb3nmAXE0MuIQXxQkMZhV3+ShuS9Z5dDMcJEHHe0YKSbaw3RZ
	 KCM1ilqUj2/xw==
Date: Wed, 26 Feb 2025 09:42:24 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: Chun-Tse Shao <ctshao@google.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, nick.forrington@arm.com,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v7 4/4] perf lock: Report owner stack in usermode
Message-ID: <Z79SgFChhckow6Jf@google.com>
References: <20250224184742.4144931-1-ctshao@google.com>
 <20250224184742.4144931-5-ctshao@google.com>
 <838FC998-5E85-4511-BA65-B32ADD1B817C@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <838FC998-5E85-4511-BA65-B32ADD1B817C@linux.ibm.com>

Hello,

On Wed, Feb 26, 2025 at 03:27:41PM +0530, Athira Rajeev wrote:
> 
> 
> > On 25 Feb 2025, at 12:12 AM, Chun-Tse Shao <ctshao@google.com> wrote:
> > 
> > This patch parses `owner_lock_stat` into a RB tree, enabling ordered
> > reporting of owner lock statistics with stack traces. It also updates
> > the documentation for the `-o` option in contention mode, decouples `-o`
> > from `-t`, and issues a warning to inform users about the new behavior
> > of `-ov`.
> > 
> > Example output:
> >  $ sudo ~/linux/tools/perf/perf lock con -abvo -Y mutex-spin -E3 perf bench sched pipe
> >  ...
> >   contended   total wait     max wait     avg wait         type   caller
> > 
> >         171      1.55 ms     20.26 us      9.06 us        mutex   pipe_read+0x57
> >                          0xffffffffac6318e7  pipe_read+0x57
> >                          0xffffffffac623862  vfs_read+0x332
> >                          0xffffffffac62434b  ksys_read+0xbb
> >                          0xfffffffface604b2  do_syscall_64+0x82
> >                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
> >          36    193.71 us     15.27 us      5.38 us        mutex   pipe_write+0x50
> >                          0xffffffffac631ee0  pipe_write+0x50
> >                          0xffffffffac6241db  vfs_write+0x3bb
> >                          0xffffffffac6244ab  ksys_write+0xbb
> >                          0xfffffffface604b2  do_syscall_64+0x82
> >                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
> >           4     51.22 us     16.47 us     12.80 us        mutex   do_epoll_wait+0x24d
> >                          0xffffffffac691f0d  do_epoll_wait+0x24d
> >                          0xffffffffac69249b  do_epoll_pwait.part.0+0xb
> >                          0xffffffffac693ba5  __x64_sys_epoll_pwait+0x95
> >                          0xfffffffface604b2  do_syscall_64+0x82
> >                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
> > 
> >  === owner stack trace ===
> > 
> >           3     31.24 us     15.27 us     10.41 us        mutex   pipe_read+0x348
> >                          0xffffffffac631bd8  pipe_read+0x348
> >                          0xffffffffac623862  vfs_read+0x332
> >                          0xffffffffac62434b  ksys_read+0xbb
> >                          0xfffffffface604b2  do_syscall_64+0x82
> >                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
> >  ...
> > 
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> > tools/perf/Documentation/perf-lock.txt |  5 ++-
> > tools/perf/builtin-lock.c              | 22 +++++++++-
> > tools/perf/util/bpf_lock_contention.c  | 57 ++++++++++++++++++++++++++
> > tools/perf/util/lock-contention.h      |  7 ++++
> > 4 files changed, 87 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
> > index d3793054f7d3..859dc11a7372 100644
> > --- a/tools/perf/Documentation/perf-lock.txt
> > +++ b/tools/perf/Documentation/perf-lock.txt
> > @@ -179,8 +179,9 @@ CONTENTION OPTIONS
> > 
> > -o::
> > --lock-owner::
> > - Show lock contention stat by owners.  Implies --threads and
> > - requires --use-bpf.
> > + Show lock contention stat by owners. This option can be combined with -t,
> > + which shows owner's per thread lock stats, or -v, which shows owner's
> > + stacktrace. Requires --use-bpf.
> > 
> > -Y::
> > --type-filter=<value>::
> > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > index 9bebc186286f..05e7bc30488a 100644
> > --- a/tools/perf/builtin-lock.c
> > +++ b/tools/perf/builtin-lock.c
> > @@ -1817,6 +1817,22 @@ static void print_contention_result(struct lock_contention *con)
> > break;
> > }
> > 
> > + if (con->owner && con->save_callstack && verbose > 0) {
> > + struct rb_root root = RB_ROOT;
> > +
> > + if (symbol_conf.field_sep)
> > + fprintf(lock_output, "# owner stack trace:\n");
> > + else
> > + fprintf(lock_output, "\n=== owner stack trace ===\n\n");
> > + while ((st = pop_owner_stack_trace(con)))
> > + insert_to(&root, st, compare);
> > +
> > + while ((st = pop_from(&root))) {
> > + print_lock_stat(con, st);
> > + free(st);
> > + }
> > + }
> > +
> > if (print_nr_entries) {
> > /* update the total/bad stats */
> > while ((st = pop_from_result())) {
> > @@ -1962,8 +1978,10 @@ static int check_lock_contention_options(const struct option *options,
> > }
> > }
> > 
> > - if (show_lock_owner)
> > - show_thread_stats = true;
> > + if (show_lock_owner && !show_thread_stats) {
> > + pr_warning("Now -o try to show owner's callstack instead of pid and comm.\n");
> > + pr_warning("Please use -t option too to keep the old behavior.\n");
> > + }
> > 
> > return 0;
> > }
> > diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> > index 76542b86e83f..16f4deba69ec 100644
> > --- a/tools/perf/util/bpf_lock_contention.c
> > +++ b/tools/perf/util/bpf_lock_contention.c
> > @@ -549,6 +549,63 @@ static const char *lock_contention_get_name(struct lock_contention *con,
> > return name_buf;
> > }
> > 
> > +struct lock_stat *pop_owner_stack_trace(struct lock_contention *con)
> > +{
> > + int stacks_fd, stat_fd;
> > + u64 *stack_trace = NULL;
> > + s32 stack_id;
> > + struct contention_key ckey = {};
> > + struct contention_data cdata = {};
> > + size_t stack_size = con->max_stack * sizeof(*stack_trace);
> > + struct lock_stat *st = NULL;
> > +
> > + stacks_fd = bpf_map__fd(skel->maps.owner_stacks);
> > + stat_fd = bpf_map__fd(skel->maps.owner_stat);
> > + if (!stacks_fd || !stat_fd)
> > + goto out_err;
> > +
> > + stack_trace = zalloc(stack_size);
> > + if (stack_trace == NULL)
> > + goto out_err;
> > +
> > + if (bpf_map_get_next_key(stacks_fd, NULL, stack_trace))
> > + goto out_err;
> > +
> > + bpf_map_lookup_elem(stacks_fd, stack_trace, &stack_id);
> > + ckey.stack_id = stack_id;
> > + bpf_map_lookup_elem(stat_fd, &ckey, &cdata);
> > +
> > + st = zalloc(sizeof(struct lock_stat));
> > + if (!st)
> > + goto out_err;
> > +
> > + st->name = strdup(stack_trace[0] ? lock_contention_get_name(con, NULL, stack_trace, 0) :
> > +   "unknown");
> 
> Hi,
> 
> I am hitting a compilation issue with this change. Sorry for responding late. I tried with change from tmp.perf-tools-next and hit below issue:
> 
> 
>   CC      util/bpf_lock_contention.o
> util/bpf_lock_contention.c: In function ‘lock_contention_get_name’:
> cc1: error: function may return address of local variable [-Werror=return-local-addr]
> util/bpf_lock_contention.c:470:45: note: declared here
>   470 |                 struct contention_task_data task;
>       |                                             ^~~~
> cc1: all warnings being treated as errors
> make[4]: *** [/root/perf-tools-next/tools/build/Makefile.build:85: util/bpf_lock_contention.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
>   LD      perf-in.o
> make[3]: *** [/root/perf-tools-next/tools/build/Makefile.build:138: util] Error 2
> make[2]: *** [Makefile.perf:822: perf-util-in.o] Error 2
> make[1]: *** [Makefile.perf:321: sub-make] Error 2
> make: *** [Makefile:76: all] Error 2

Thanks for the report.  I've noticed that and also found this error:

  In file included from util/lock-contention.c:4:0:                               
  util/lock-contention.h:192:19: error: no previous prototype for 'pop_owner_stack_trace' [-Werror=missing-prototypes]
   struct lock_stat *pop_owner_stack_trace(struct lock_contention *con)           
                     ^~~~~~~~~~~~~~~~~~~~~                                        
  util/lock-contention.h: In function 'pop_owner_stack_trace':                    
  util/lock-contention.h:192:65: error: unused parameter 'con' [-Werror=unused-parameter]
   struct lock_stat *pop_owner_stack_trace(struct lock_contention *con)           
                                                                   ^~~

Removed this series from tmp.perf-tools-next.

Thanks,
Namhyung

> 
> 
> Code snippet:
> 
> if (con->aggr_mode == LOCK_AGGR_TASK) {
>                 struct contention_task_data task;
>                 int pid = key->pid;
>                 int task_fd = bpf_map__fd(skel->maps.task_data);
> 
>                 /* do not update idle comm which contains CPU number */
>                 if (pid) {
>                         struct thread *t = machine__findnew_thread(machine, /*pid=*/-1, pid);
> 
>                         if (t == NULL)
>                                 return name;
>                         if (!bpf_map_lookup_elem(task_fd, &pid, &task) &&
>                             thread__set_comm(t, task.comm, /*timestamp=*/0))
>                                 name = task.comm;
>                 }
>                 return name;
>         }
> 
> 
> We are calling lock_contention_get_name with second argument as NULL .
> Though error above points to “contention_task_data”, I think the local variable here is for “name” ?
> 
> 
> Thanks
> Athira
> 
> > + if (!st->name)
> > + goto out_err;
> > +
> > + st->flags = cdata.flags;
> > + st->nr_contended = cdata.count;
> > + st->wait_time_total = cdata.total_time;
> > + st->wait_time_max = cdata.max_time;
> > + st->wait_time_min = cdata.min_time;
> > + st->callstack = stack_trace;
> > +
> > + if (cdata.count)
> > + st->avg_wait_time = cdata.total_time / cdata.count;
> > +
> > + bpf_map_delete_elem(stacks_fd, stack_trace);
> > + bpf_map_delete_elem(stat_fd, &ckey);
> > +
> > + return st;
> > +
> > +out_err:
> > + free(stack_trace);
> > + free(st);
> > +
> > + return NULL;
> > +}
> > +
> > int lock_contention_read(struct lock_contention *con)
> > {
> > int fd, stack, err = 0;
> > diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
> > index a09f7fe877df..97fd33c57f17 100644
> > --- a/tools/perf/util/lock-contention.h
> > +++ b/tools/perf/util/lock-contention.h
> > @@ -168,6 +168,8 @@ int lock_contention_stop(void);
> > int lock_contention_read(struct lock_contention *con);
> > int lock_contention_finish(struct lock_contention *con);
> > 
> > +struct lock_stat *pop_owner_stack_trace(struct lock_contention *con);
> > +
> > #else  /* !HAVE_BPF_SKEL */
> > 
> > static inline int lock_contention_prepare(struct lock_contention *con __maybe_unused)
> > @@ -187,6 +189,11 @@ static inline int lock_contention_read(struct lock_contention *con __maybe_unuse
> > return 0;
> > }
> > 
> > +struct lock_stat *pop_owner_stack_trace(struct lock_contention *con)
> > +{
> > + return NULL;
> > +}
> > +
> > #endif  /* HAVE_BPF_SKEL */
> > 
> > #endif  /* PERF_LOCK_CONTENTION_H */
> > -- 
> > 2.48.1.658.g4767266eb4-goog
> > 
> > 
> 

