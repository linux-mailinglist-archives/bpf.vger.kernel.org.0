Return-Path: <bpf+bounces-49627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA66A1ADF5
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 01:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0631676E4
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 00:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651FE1CAA72;
	Fri, 24 Jan 2025 00:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRVu5ru2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4218801;
	Fri, 24 Jan 2025 00:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737678853; cv=none; b=PUAfYfsAjekaBA54OVYOgi+8A4fPzT5VdnhwRdhIDnhv9v0tGiX5LKAyMYJI9egsyvRJHZBDKjgaEWvYNjz5aX//5HMIEnamTN7EY65sax2LxlB/CbXdJvPZEaTImnQoa5S24YSg83MNjhZeT03vhNCZf4LWLIhzb4Xi7rpDfN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737678853; c=relaxed/simple;
	bh=9VWTmvq3QlHTWqQ+OTp1jRGPekftLYudUZgbD3rwLNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ik66i2xEvrhM94/dfjIaINRaFDj/8ICJc99HYUXQLL/lFZ2C+CReeXMW5ZlHzQYW8zRXu1s9B6fZ7Vt9YMrg0TkScGHSuClXUx6ZQoygfch9/EAgj0ZQMBP02M1QS8SzwGrHPyty3r01iXhlBcyoE6a7LS36gxrVsZuc84lf9h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRVu5ru2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5B0C4CED3;
	Fri, 24 Jan 2025 00:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737678852;
	bh=9VWTmvq3QlHTWqQ+OTp1jRGPekftLYudUZgbD3rwLNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DRVu5ru26eqowxO3TojhWHqOIWEjqDvRcsSyx06GWLBMTe52qZgMXLw9tTvgYbJzz
	 H4oIsGLQLclXlT7DOIthlP6QPdWXY4RoOQiVHvmnJ17MoYbzpoopv+vUlV6B4ScrhG
	 CPDrfS1aIFyv1H4hajb+YgaCGutYTao5yBqjOcDQKN1NrKFL3T+BB2GUF/XCDfCHxw
	 iQrr+8B10rwsT9zrnnuOHGF09zF1bsw9pIGwg7bZfd0Sx9MUZ111HPsrg+LLtqI+V5
	 bv8L/XOKenJK3UZYaM3r1GjJ8qC2LPr4PRUNmpq5/wGJloN3HMjfPnewwDlucTbWsT
	 A5mBP9l36FvfA==
Date: Thu, 23 Jan 2025 16:34:10 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/4] perf lock: Add bpf maps for owner stack tracing
Message-ID: <Z5LgAq7tOuU-ULBw@google.com>
References: <20250113052220.2105645-1-ctshao@google.com>
 <20250113052220.2105645-2-ctshao@google.com>
 <Z4XUfjdaooYNpkFt@google.com>
 <CAJpZYjXMd4+UbaO8y-HGkPor4M1L7W1iMWYe+ak1EYSOxwqXiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJpZYjXMd4+UbaO8y-HGkPor4M1L7W1iMWYe+ak1EYSOxwqXiw@mail.gmail.com>

On Tue, Jan 21, 2025 at 02:02:57PM -0800, Chun-Tse Shao wrote:
> Hi Namhyung, thanks for your reply!
> 
> On Mon, Jan 13, 2025 at 7:05 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > On Sun, Jan 12, 2025 at 09:20:14PM -0800, Chun-Tse Shao wrote:
> > > Add few bpf maps in order to tracing owner stack.
> >
> > If you want to split this code as a separate commit, I think you'd
> > better explain what these maps do and why you need them.
> >
> > >
> > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > > ---
> > >  tools/perf/util/bpf_lock_contention.c         | 17 ++++++--
> > >  .../perf/util/bpf_skel/lock_contention.bpf.c  | 40 +++++++++++++++++--
> > >  tools/perf/util/bpf_skel/lock_data.h          |  6 +++
> > >  3 files changed, 56 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> > > index 41a1ad087895..c9c58f243ceb 100644
> > > --- a/tools/perf/util/bpf_lock_contention.c
> > > +++ b/tools/perf/util/bpf_lock_contention.c
> > > @@ -41,9 +41,20 @@ int lock_contention_prepare(struct lock_contention *con)
> > >       else
> > >               bpf_map__set_max_entries(skel->maps.task_data, 1);
> > >
> > > -     if (con->save_callstack)
> > > -             bpf_map__set_max_entries(skel->maps.stacks, con->map_nr_entries);
> > > -     else
> > > +     if (con->save_callstack) {
> > > +             bpf_map__set_max_entries(skel->maps.stacks,
> > > +                                      con->map_nr_entries);
> > > +             if (con->owner) {
> > > +                     bpf_map__set_value_size(skel->maps.owner_stacks_entries,
> > > +                                             con->max_stack * sizeof(u64));
> > > +                     bpf_map__set_value_size(
> > > +                             skel->maps.contention_owner_stacks,
> > > +                             con->max_stack * sizeof(u64));
> > > +                     bpf_map__set_key_size(skel->maps.owner_lock_stat,
> > > +                                             con->max_stack * sizeof(u64));
> > > +                     skel->rodata->max_stack = con->max_stack;
> > > +             }
> > > +     } else
> > >               bpf_map__set_max_entries(skel->maps.stacks, 1);
> > >
> > >       if (target__has_cpu(target)) {
> > > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > > index 1069bda5d733..05da19fdab23 100644
> > > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > > @@ -19,13 +19,37 @@
> > >  #define LCB_F_PERCPU (1U << 4)
> > >  #define LCB_F_MUTEX  (1U << 5)
> > >
> >
> > Can we rename these shorter and save some typings?
> 
> I tend to use longer variable names with full descriptions with some
> easy to understand abbreviations. Would a shorter name be preferable
> in Linux kernel?

Well, I think it's a matter of preference.  I don't know how others
think but I prefer shorter names.

> 
> >
> > > -/* callstack storage  */
> > > + /* tmp buffer for owner callstack */
> > >  struct {
> > > -     __uint(type, BPF_MAP_TYPE_STACK_TRACE);
> > > +     __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> > >       __uint(key_size, sizeof(__u32));
> > >       __uint(value_size, sizeof(__u64));
> > > +     __uint(max_entries, 1);
> > > +} owner_stacks_entries SEC(".maps");
> >
> > I think this can be 'stack_buf'.
> >
> > > +
> > > +/* a map for tracing lock address to owner data */
> > > +struct {
> > > +     __uint(type, BPF_MAP_TYPE_HASH);
> > > +     __uint(key_size, sizeof(__u64)); // lock address
> > > +     __uint(value_size, sizeof(cotd));
> > >       __uint(max_entries, MAX_ENTRIES);
> > > -} stacks SEC(".maps");
> > > +} contention_owner_tracing SEC(".maps");
> >
> > owner_data.
> >
> > > +
> > > +/* a map for tracing lock address to owner stacktrace */
> > > +struct {
> > > +     __uint(type, BPF_MAP_TYPE_HASH);
> > > +     __uint(key_size, sizeof(__u64)); // lock address
> > > +     __uint(value_size, sizeof(__u64)); // straktrace
> >
> > Typo.
> >
> > > +     __uint(max_entries, MAX_ENTRIES);
> > > +} contention_owner_stacks SEC(".maps");
> >
> > owner_stack.
> >
> > > +
> > > +/* owner callstack to contention data storage */
> > > +struct {
> > > +     __uint(type, BPF_MAP_TYPE_HASH);
> > > +     __uint(key_size, sizeof(__u64));
> > > +     __uint(value_size, sizeof(struct contention_data));
> > > +     __uint(max_entries, MAX_ENTRIES);
> > > +} owner_lock_stat SEC(".maps");
> >
> > owner_stat.  What do you think?
> >
> > By the way, I got an idea to implement stackid map in BPF using hash
> > map.  For owner stack, you can use the stacktrace as a key and make a
> > value an unique integer.  Then the return value can be used as a stack
> > id (like from bpf_get_stackid) for the owner_data and owner_stat.
> >
> > Something like:
> >
> >   s32 get_stack_id(struct owner_stack *owner_stack, u64 stacktrace[])
> >   {
> >         s32 *id, new_id;
> >         static s32 id_gen = 1;
> >
> >         id = bpf_map_lookup_elem(owner_stack, stacktrace);
> >         if (id)
> >                 return *id;
> >
> >         new_id = __sync_fetch_and_add(&id_gen, 1);
> >         bpf_map_update_elem(owner_stack, stacktrace, &new_id, BPF_NOEXIST);
> >
> >         id = bpf_map_lookup_elem(owner_stack, stacktrace);
> >         if (id)
> >                 return *id;
> >
> >         return -1;
> >   }
> >
> > Later, in user space, you can traverse the owner_stack map to build
> > reverse mapping from id to stacktrace.
> 
> I wonder if stack_id is necessary here. So far I have three bpf maps.
> 2 bpf maps for tracing owner stack on given lock address in bpf program:
>   key: lock_address, value: a struct for tracing owner pid, count of
> waiters and contention begin timestamp.
>   key: lock_address, value: owner stack, which is variable length so I
> have to put it in a separate bpf map.
> 
> 1 bpf map for reporting owner stack in user mode:
>   key: owner stack, value: struct lock_stat.
> 
> With stackid I think there will still be 3 bpf maps, one for
> lock_address to owner's info with stackid, one for stackid to stack,
> and one for contention_key (has stackid inside) to lock_stat. I think
> it is just another way to implement and does not simplify the
> implementation. WDYT?

With stackid, I think we can have these 3 maps:
* key: stack-trace, value: stack-id
* key: lock-addr, value: owner-pid, counter, timestamp, stack-id
* key: stack-id, value: struct lock_stat

Then at least you can save some space for the key in the 3rd map (and
simplify the comparison of the key).

> 
> >
> > >
> > >  /* maintain timestamp at the beginning of contention */
> > >  struct {
> > > @@ -43,6 +67,14 @@ struct {
> > >       __uint(max_entries, 1);
> > >  } tstamp_cpu SEC(".maps");
> > >
> > > +/* callstack storage  */
> > > +struct {
> > > +     __uint(type, BPF_MAP_TYPE_STACK_TRACE);
> > > +     __uint(key_size, sizeof(__u32));
> > > +     __uint(value_size, sizeof(__u64));
> > > +     __uint(max_entries, MAX_ENTRIES);
> > > +} stacks SEC(".maps");
> > > +
> > >  /* actual lock contention statistics */
> > >  struct {
> > >       __uint(type, BPF_MAP_TYPE_HASH);
> > > @@ -126,6 +158,7 @@ const volatile int needs_callstack;
> > >  const volatile int stack_skip;
> > >  const volatile int lock_owner;
> > >  const volatile int use_cgroup_v2;
> > > +const volatile int max_stack;
> > >
> > >  /* determine the key of lock stat */
> > >  const volatile int aggr_mode;
> > > @@ -436,7 +469,6 @@ int contention_end(u64 *ctx)
> > >                       return 0;
> > >               need_delete = true;
> > >       }
> > > -
> > >       duration = bpf_ktime_get_ns() - pelem->timestamp;
> > >       if ((__s64)duration < 0) {
> > >               __sync_fetch_and_add(&time_fail, 1);
> > > diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
> > > index de12892f992f..1ef0bca9860e 100644
> > > --- a/tools/perf/util/bpf_skel/lock_data.h
> > > +++ b/tools/perf/util/bpf_skel/lock_data.h
> > > @@ -3,6 +3,12 @@
> > >  #ifndef UTIL_BPF_SKEL_LOCK_DATA_H
> > >  #define UTIL_BPF_SKEL_LOCK_DATA_H
> > >
> > > +typedef struct contention_owner_tracing_data {
> > > +     u32 pid; // Who has the lock.
> > > +     u64 timestamp; // The time while the owner acquires lock and contention is going on.
> > > +     u32 count; // How many waiters for this lock.
> >
> > Switching the order of timestamp and count would remove padding.
> 
> Thanks for the nit!

No problem. :)

Thanks,
Namhyung

> 
> >
> > > +} cotd;
> >
> > Usually we don't use typedef to remove the struct tag.
> >
> > Thanks,
> > Namhyung
> >
> > > +
> > >  struct tstamp_data {
> > >       u64 timestamp;
> > >       u64 lock;
> > > --
> > > 2.47.1.688.g23fc6f90ad-goog
> > >

