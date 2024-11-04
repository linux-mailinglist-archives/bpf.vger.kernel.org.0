Return-Path: <bpf+bounces-43873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B602D9BAC62
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 07:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8EC71C20ECA
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 06:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2648B18C330;
	Mon,  4 Nov 2024 06:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HpYzSPCG"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADED6FC5;
	Mon,  4 Nov 2024 06:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730700769; cv=none; b=IS3kd1JJoivfhyuow+hCbFfDZLn0uH4e07iW8btQ51AQB64uptS15MF+FYO8MeeAJMfT1NpTgNMvmb5/SiIaLDZGHP0ZP/VlxZm2pPjPdPXpIAJUm115PV2uyw6JXe92sONScg6HilwmPhTzVQ+aauB2NI2O3yxbLnYoPBq3gH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730700769; c=relaxed/simple;
	bh=ki9vFG3nfLFbUqAXf6jzfsbvTSQlqjL9yWAin/0ah8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqQDAhT1I72Kvhpod/HWxfGR/6c9MOpTtj+hKEydT8UNz1FZ1h4B3VgJ95YYo9EWTs5xMnAng0GExT10/C+Lw/MQy/vy39RyH7cmVONvNhd4tHAYlcB+odhRqnMJ9IwT9NKKrfWdZ551r0/gw97mJW5ahFzlOoO79ojyPF5jXtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HpYzSPCG; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=paESjsr5A0A1ELZZUT9Rrg6vQ8i0QK8Ld0xxSWGQ1xY=;
	b=HpYzSPCGh50YAd9lmjiig+zFH7EvrjVB71Fdrw61xeSO9G6HxBdQBxiNX3v5VS
	PTW9s8LnnTrYSETLmwWfwc1HOCLyS827jFC+dxV+AZNxaCI56gnCY3Quz6xnhQsc
	mVNdCurcKVgiHBQsMXW/r/M4AHtz5BUrQJ5HlWnGEFylE=
Received: from iZ0xi1olgj2q723wq4k6skZ (unknown [47.252.33.72])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDXPybOZShnwx48Ag--.2216S2;
	Mon, 04 Nov 2024 14:12:34 +0800 (CST)
Date: Mon, 4 Nov 2024 14:12:29 +0800
From: Jiayuan Chen <mrpre@163.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@kernel.org
Subject: Re: [PATCH 1/2] bpf: Introduce cpu affinity for sockmap
Message-ID: <gbtlzrhme5yrbvlwkswlzz44lims7dymougc7376c5hugosqqh@qqrjg6wtmnan>
References: <20241101023832.32404-1-mrpre@163.com>
 <CAEf4BzbVqcCN1p8ydLN17LygK5R=gBYJV0A-cnycjtsUzrX34g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbVqcCN1p8ydLN17LygK5R=gBYJV0A-cnycjtsUzrX34g@mail.gmail.com>
X-CM-TRANSID:_____wDXPybOZShnwx48Ag--.2216S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GF4kWr4xGFyDWr4fKF13twb_yoW3KF4rpF
	Z5Ga1UCF4DJayUZw1aq3yUWr4avw48G3WjkFZxKa4Yyr9IgrykWF18KF1a9F1fur4kCr40
	vrW2gryjk3yUZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U7R67UUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiWwmNp2coXlurDQAAsU

On Fri, Nov 01, 2024 at 12:25:51PM -0700, Andrii Nakryiko wrote:
> On Thu, Oct 31, 2024 at 7:40 PM mrpre <mrpre@163.com> wrote:
> >
> > Why we need cpu affinity:
> > Mainstream data planes, like Nginx and HAProxy, utilize CPU affinity
> > by binding user processes to specific CPUs. This avoids interference
> > between processes and prevents impact from other processes.
> >
> > Sockmap, as an optimization to accelerate such proxy programs,
> > currently lacks the ability to specify CPU affinity. The current
> > implementation of sockmap handling backlog is based on workqueue,
> > which operates by calling 'schedule_delayed_work()'. It's current
> > implementation prefers to schedule on the local CPU, i.e., the CPU
> > that handled the packet under softirq.
> >
> > For extremely high traffic with large numbers of packets,
> > 'sk_psock_backlog' becomes a large loop.
> >
> > For multi-threaded programs with only one map, we expect different
> > sockets to run on different CPUs. It is important to note that this
> > feature is not a general performance optimization. Instead, it
> > provides users with the ability to bind to specific CPU, allowing
> > them to enhance overall operating system utilization based on their
> > own system environments.
> >
> > Implementation:
> > 1.When updating the sockmap, support passing a CPU parameter and
> > save it to the psock.
> > 2.When scheduling psock, determine which CPU to run on using the
> > psock's CPU information.
> > 3.For thoes sockmap without CPU affinity, keep original logic by using
> > 'schedule_delayed_work()'.
> >
> > Performance Testing:
> > 'client <-> sockmap proxy <-> server'
> >
> > Using 'iperf3' tests, with the iperf server bound to CPU5 and the iperf
> > client bound to CPU6, performance without using CPU affinity is
> > around 34 Gbits/s, and CPU usage is concentrated on CPU5 and CPU6.
> > '''
> > [  5] local 127.0.0.1 port 57144 connected to 127.0.0.1 port 10000
> > [ ID] Interval           Transfer     Bitrate
> > [  5]   0.00-1.00   sec  3.95 GBytes  33.9 Gbits/sec
> > [  5]   1.00-2.00   sec  3.95 GBytes  34.0 Gbits/sec
> > ......
> > '''
> >
> > With using CPU affinity, the performnce is close to direct connection
> > (without any proxy).
> > '''
> > [  5] local 127.0.0.1 port 56518 connected to 127.0.0.1 port 10000
> > [ ID] Interval           Transfer     Bitrate
> > [  5]   0.00-1.00   sec  7.76 GBytes  66.6 Gbits/sec
> > [  5]   1.00-2.00   sec  7.76 GBytes  66.7 Gbits/sec
> > ......
> > '''
> >
> > Signed-off-by: Jiayuan Chen <mrpre@163.com>
> > ---
> >  include/linux/bpf.h      |  3 ++-
> >  include/linux/skmsg.h    |  8 ++++++++
> >  include/uapi/linux/bpf.h |  4 ++++
> >  kernel/bpf/syscall.c     | 23 +++++++++++++++++------
> >  net/core/skmsg.c         | 11 +++++++----
> >  net/core/sock_map.c      | 12 +++++++-----
> >  6 files changed, 45 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index c3ba4d475174..a56028c389e7 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -3080,7 +3080,8 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
> >
> >  int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog);
> >  int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype);
> > -int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value, u64 flags);
> > +int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value, u64 flags,
> > +                            s32 target_cpu);
> >  int sock_map_bpf_prog_query(const union bpf_attr *attr,
> >                             union bpf_attr __user *uattr);
> >  int sock_map_link_create(const union bpf_attr *attr, struct bpf_prog *prog);
> > diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> > index d9b03e0746e7..919425a92adf 100644
> > --- a/include/linux/skmsg.h
> > +++ b/include/linux/skmsg.h
> > @@ -117,6 +117,7 @@ struct sk_psock {
> >         struct delayed_work             work;
> >         struct sock                     *sk_pair;
> >         struct rcu_work                 rwork;
> > +       s32                             target_cpu;
> >  };
> >
> >  int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
> > @@ -514,6 +515,13 @@ static inline bool sk_psock_strp_enabled(struct sk_psock *psock)
> >         return !!psock->saved_data_ready;
> >  }
> >
> > +static inline int sk_psock_strp_get_cpu(struct sk_psock *psock)
> > +{
> > +       if (psock->target_cpu != -1)
> > +               return psock->target_cpu;
> > +       return WORK_CPU_UNBOUND;
> > +}
> > +
> >  #if IS_ENABLED(CONFIG_NET_SOCK_MSG)
> >
> >  #define BPF_F_STRPARSER        (1UL << 1)
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index f28b6527e815..2019a87b5d4a 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1509,6 +1509,10 @@ union bpf_attr {
> >                         __aligned_u64 next_key;
> >                 };
> >                 __u64           flags;
> > +               union {
> > +                       /* specify the CPU where the sockmap job run on */
> > +                       __aligned_u64 target_cpu;
> 
> I have no opinion on the feature itself, I'll leave this to others.
> But from UAPI perspective:
> 
> a) why is this a u64 and not, say, int?
> b) maybe we should just specify this as flags and not have to update
> all the UAPIs (including libbpf-side)? Just add a new
> BPF_F_SOCKNMAP_TARGET_CPU flag or something, and specify that highest
> 32 bits specify the CPU itself?
> 
> We have similar schema for some other helpers, so not *that* unusual.
> 
Thank you for your response. I think I should clarify my thoughts:

My idea is to pass a user-space pointer, with the pointer being null
to indicate that the user has not provided anything.For example, when
users use the old interface 'bpf_map_update_elem' and pass in u64 of
0, it means that the user hasn't specified a CPU. If a u32 or another
type of value is passed in, when it is 0, it's ambiguous whether this
indicates target CPU 0 or that the user hasn't provided a value. So
my design involves passing a user-space pointer.

I also considered using the highest 32 bits of the flag as target_cpu, but
this approach still encounters the ambiguity mentioned above. Of course
for programs using libbpf, I can naturally init all the higher 32 bits
default to 1 to indicate the user hasn't specified a CPU, but this is
incompatible with programs not using libbpf. Another approach could be
that a value of 1 for the higher 32 bits indicates CPU 0, and 2 indicates
CPU 1..., but this seems odd and would require a helper to assist users
in passing arguments.

There is another method, like providing an extra 'attr', to replace the
passed 'target_cpu', which maintains the general nature of 
'map_update_elem' interface, like:
'''
+struct extra_bpf_attr {
+    u32 target_cpu;
+};
struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
    __u32   map_fd;
    __aligned_u64 key;
    union {
        __aligned_u64 value;
        __aligned_u64 next_key;
    };
    __u64   flags;
    +struct extra_bpf_attr extra;
};

static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
-                               void *key, void *value, __u64 flags)
+                               void *key, void *value, __u64 flags, struct bpf_attr_extra *extra);
'''

> > +               };
> >         };
> >
> >         struct { /* struct used by BPF_MAP_*_BATCH commands */
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 8254b2973157..95f719b9c3f3 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -239,10 +239,9 @@ static int bpf_obj_pin_uptrs(struct btf_record *rec, void *obj)
> >  }
> >
> >  static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
> > -                               void *key, void *value, __u64 flags)
> > +                               void *key, void *value, __u64 flags, s32 target_cpu)
> 
> yeah, this is what I'm talking about. Think how ridiculous it is for a
> generic "BPF map update" operation to accept the "target_cpu"
> parameter.
> 
> pw-bot: cr
> 
> >  {
> >         int err;
> > -
> 
> why? don't break whitespace formatting
> 
> >         /* Need to create a kthread, thus must support schedule */
> >         if (bpf_map_is_offloaded(map)) {
> >                 return bpf_map_offload_update_elem(map, key, value, flags);
> > @@ -252,7 +251,7 @@ static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
> >                 return map->ops->map_update_elem(map, key, value, flags);
> >         } else if (map->map_type == BPF_MAP_TYPE_SOCKHASH ||
> >                    map->map_type == BPF_MAP_TYPE_SOCKMAP) {
> > -               return sock_map_update_elem_sys(map, key, value, flags);
> > +               return sock_map_update_elem_sys(map, key, value, flags, target_cpu);
> >         } else if (IS_FD_PROG_ARRAY(map)) {
> >                 return bpf_fd_array_map_update_elem(map, map_file, key, value,
> >                                                     flags);
> 
> [...]


