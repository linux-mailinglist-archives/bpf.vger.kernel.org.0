Return-Path: <bpf+bounces-43767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA799B9876
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 20:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967901F22CB2
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEE71D0943;
	Fri,  1 Nov 2024 19:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4PYSSpr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740351D0157;
	Fri,  1 Nov 2024 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489166; cv=none; b=WRgiO7JoEcrL5VdhLEuV6ROUlxiMS/DYRvB3mit647lSPHtaiC+2Ey+DmU77ta07xMveBsFkC1wEfb+2ppMWenD/r7pbDCQgKt+v42nJGHEGi1CdUNS10o9R6oR1KQhL7vdruX4mKe4NV9drN2b/7PLDggEie5gCKqFD82+M8qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489166; c=relaxed/simple;
	bh=93fuAkdAh04DS0vN/XfcotThP8263BQbKhwujn6g1hU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwOYNuykKsdsxJnKUXL5shOajTUNRHU4PlsPBNIjUPRbY/VjSFqP3UEY7OwiIAYg98OSA3JyPQRsdex5N+sq5VJRJbW+iASq/r93q/loH4KxN+vmHuio0pjRLGrc/MW1mmOZPLxmfFRZiBA6CzhjjMs7huaTvelhJE/jACqwvXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4PYSSpr; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c8c50fdd9so23195095ad.0;
        Fri, 01 Nov 2024 12:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730489164; x=1731093964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCPgpT38KR4cy3GZIQiyuqaH7tc3WIK5WLSyVhUIfVE=;
        b=D4PYSSprCILyHatqcOkmViyA9byu0D86d0iBiUaq1lbJsDIOuoxwkCih152WZUlrSH
         TgMHnCikIgi2sUYOMJlvKWOMZORp6zx8ez+aB16mfOCg+N9fBhVGf11LloWn/ePkUBBY
         Lx8j8fgQaAclxdHjWG5SbgZ2vR7ZZbZwzjK251Vw6R9MSPHF3E0LG0dQpWVOwuqS004j
         JHnIBn0necTiu1VzJtTQhXjZKK2vbMcTvu9tZmQEs4bR/6RTze0MKlyAfKO3XVr3Fv0d
         bPE1OeErMcPQ1pdDB5EzgSMlEy8CNvqGGKH6DgznZQFo2362e3aO3Seyk9Hr9FWFG9uh
         VozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730489164; x=1731093964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCPgpT38KR4cy3GZIQiyuqaH7tc3WIK5WLSyVhUIfVE=;
        b=N11V6icIuL5PXdCZdbH2b9Uax4+yTREIScLXpRFo1WdPGnAWA9uktomY/IMRywmNWL
         XZEvvY7uApLQ17fZhNEbD6ujVeMDVizHwqgBCODqsAIoE83k1/qLtR0CDdtLw4i5rpa/
         9XniiZ6yrlVMjUN0ooWJ4bjyHvNRNu9M8vTbHcXz8vax2QRmPjDgMk7eeIS1NtG7l/hr
         YAzJ1PC8NkUYegU6XqWPhBuuyk/zPdenSZKal0d6j/+Q4D5ij99xU71QWYkXCGjBalrk
         zFvsQL0vGIy0ZLcXEZzP1zvyorTlaC7IG/riUNH6+lZ9If7POesdeszf9brRywL3oAI/
         4VZg==
X-Forwarded-Encrypted: i=1; AJvYcCW4ywaosXnrOjJpIPLFBDnD+i6qRp04vsBzpykCp8onCwwK5/zEmuAp0bcrU3S4JIJALH3e7MlXh3pDGqDY@vger.kernel.org, AJvYcCWeEweYVxQxQdCv5PYxnhgHxqRYmCqLZeMxfl6CburF7jiTi8QTjZnO33YflOuZRyuuzgvRGIQ0@vger.kernel.org, AJvYcCX0/fLHvf1sp1VAj7YQEP97NpEUCXZs7uF8NBRJ2sm818ytXeviDd+x0h/R7ZEHtwBG5X0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/xgu3BToWTqKo2xABtpgXRFai42OGp8zMPdVMAeGwm8RLZcwG
	g8kePZa9jnYfJCWBoFy06BN5dMnXXgVnlH54uFCuzFoI3Cl2mSqgejJUEX08tfrWeSg1cZ066V7
	x61BTg84QRJR8MUy3rKqlJfKgkQ4=
X-Google-Smtp-Source: AGHT+IHnWC6PrXRTE7ygehj1Uf2eZLH5SVrVg0QCZdXH/D8Hbiw8iKq6+RV7G6AB8oNuM8iEO5a/WRyp2nA6abNRFXM=
X-Received: by 2002:a17:90b:3147:b0:2e2:b94a:b6a9 with SMTP id
 98e67ed59e1d1-2e94b7c6439mr7805237a91.0.1730489163631; Fri, 01 Nov 2024
 12:26:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101023832.32404-1-mrpre@163.com>
In-Reply-To: <20241101023832.32404-1-mrpre@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Nov 2024 12:25:51 -0700
Message-ID: <CAEf4BzbVqcCN1p8ydLN17LygK5R=gBYJV0A-cnycjtsUzrX34g@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: Introduce cpu affinity for sockmap
To: mrpre <mrpre@163.com>
Cc: yonghong.song@linux.dev, john.fastabend@gmail.com, martin.lau@kernel.org, 
	edumazet@google.com, jakub@cloudflare.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 7:40=E2=80=AFPM mrpre <mrpre@163.com> wrote:
>
> Why we need cpu affinity:
> Mainstream data planes, like Nginx and HAProxy, utilize CPU affinity
> by binding user processes to specific CPUs. This avoids interference
> between processes and prevents impact from other processes.
>
> Sockmap, as an optimization to accelerate such proxy programs,
> currently lacks the ability to specify CPU affinity. The current
> implementation of sockmap handling backlog is based on workqueue,
> which operates by calling 'schedule_delayed_work()'. It's current
> implementation prefers to schedule on the local CPU, i.e., the CPU
> that handled the packet under softirq.
>
> For extremely high traffic with large numbers of packets,
> 'sk_psock_backlog' becomes a large loop.
>
> For multi-threaded programs with only one map, we expect different
> sockets to run on different CPUs. It is important to note that this
> feature is not a general performance optimization. Instead, it
> provides users with the ability to bind to specific CPU, allowing
> them to enhance overall operating system utilization based on their
> own system environments.
>
> Implementation:
> 1.When updating the sockmap, support passing a CPU parameter and
> save it to the psock.
> 2.When scheduling psock, determine which CPU to run on using the
> psock's CPU information.
> 3.For thoes sockmap without CPU affinity, keep original logic by using
> 'schedule_delayed_work()'.
>
> Performance Testing:
> 'client <-> sockmap proxy <-> server'
>
> Using 'iperf3' tests, with the iperf server bound to CPU5 and the iperf
> client bound to CPU6, performance without using CPU affinity is
> around 34 Gbits/s, and CPU usage is concentrated on CPU5 and CPU6.
> '''
> [  5] local 127.0.0.1 port 57144 connected to 127.0.0.1 port 10000
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec  3.95 GBytes  33.9 Gbits/sec
> [  5]   1.00-2.00   sec  3.95 GBytes  34.0 Gbits/sec
> ......
> '''
>
> With using CPU affinity, the performnce is close to direct connection
> (without any proxy).
> '''
> [  5] local 127.0.0.1 port 56518 connected to 127.0.0.1 port 10000
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec  7.76 GBytes  66.6 Gbits/sec
> [  5]   1.00-2.00   sec  7.76 GBytes  66.7 Gbits/sec
> ......
> '''
>
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---
>  include/linux/bpf.h      |  3 ++-
>  include/linux/skmsg.h    |  8 ++++++++
>  include/uapi/linux/bpf.h |  4 ++++
>  kernel/bpf/syscall.c     | 23 +++++++++++++++++------
>  net/core/skmsg.c         | 11 +++++++----
>  net/core/sock_map.c      | 12 +++++++-----
>  6 files changed, 45 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index c3ba4d475174..a56028c389e7 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3080,7 +3080,8 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog=
,
>
>  int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *pr=
og);
>  int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type =
ptype);
> -int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value=
, u64 flags);
> +int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value=
, u64 flags,
> +                            s32 target_cpu);
>  int sock_map_bpf_prog_query(const union bpf_attr *attr,
>                             union bpf_attr __user *uattr);
>  int sock_map_link_create(const union bpf_attr *attr, struct bpf_prog *pr=
og);
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index d9b03e0746e7..919425a92adf 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -117,6 +117,7 @@ struct sk_psock {
>         struct delayed_work             work;
>         struct sock                     *sk_pair;
>         struct rcu_work                 rwork;
> +       s32                             target_cpu;
>  };
>
>  int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
> @@ -514,6 +515,13 @@ static inline bool sk_psock_strp_enabled(struct sk_p=
sock *psock)
>         return !!psock->saved_data_ready;
>  }
>
> +static inline int sk_psock_strp_get_cpu(struct sk_psock *psock)
> +{
> +       if (psock->target_cpu !=3D -1)
> +               return psock->target_cpu;
> +       return WORK_CPU_UNBOUND;
> +}
> +
>  #if IS_ENABLED(CONFIG_NET_SOCK_MSG)
>
>  #define BPF_F_STRPARSER        (1UL << 1)
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index f28b6527e815..2019a87b5d4a 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1509,6 +1509,10 @@ union bpf_attr {
>                         __aligned_u64 next_key;
>                 };
>                 __u64           flags;
> +               union {
> +                       /* specify the CPU where the sockmap job run on *=
/
> +                       __aligned_u64 target_cpu;

I have no opinion on the feature itself, I'll leave this to others.
But from UAPI perspective:

a) why is this a u64 and not, say, int?
b) maybe we should just specify this as flags and not have to update
all the UAPIs (including libbpf-side)? Just add a new
BPF_F_SOCKNMAP_TARGET_CPU flag or something, and specify that highest
32 bits specify the CPU itself?

We have similar schema for some other helpers, so not *that* unusual.

> +               };
>         };
>
>         struct { /* struct used by BPF_MAP_*_BATCH commands */
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 8254b2973157..95f719b9c3f3 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -239,10 +239,9 @@ static int bpf_obj_pin_uptrs(struct btf_record *rec,=
 void *obj)
>  }
>
>  static int bpf_map_update_value(struct bpf_map *map, struct file *map_fi=
le,
> -                               void *key, void *value, __u64 flags)
> +                               void *key, void *value, __u64 flags, s32 =
target_cpu)

yeah, this is what I'm talking about. Think how ridiculous it is for a
generic "BPF map update" operation to accept the "target_cpu"
parameter.

pw-bot: cr

>  {
>         int err;
> -

why? don't break whitespace formatting

>         /* Need to create a kthread, thus must support schedule */
>         if (bpf_map_is_offloaded(map)) {
>                 return bpf_map_offload_update_elem(map, key, value, flags=
);
> @@ -252,7 +251,7 @@ static int bpf_map_update_value(struct bpf_map *map, =
struct file *map_file,
>                 return map->ops->map_update_elem(map, key, value, flags);
>         } else if (map->map_type =3D=3D BPF_MAP_TYPE_SOCKHASH ||
>                    map->map_type =3D=3D BPF_MAP_TYPE_SOCKMAP) {
> -               return sock_map_update_elem_sys(map, key, value, flags);
> +               return sock_map_update_elem_sys(map, key, value, flags, t=
arget_cpu);
>         } else if (IS_FD_PROG_ARRAY(map)) {
>                 return bpf_fd_array_map_update_elem(map, map_file, key, v=
alue,
>                                                     flags);

[...]

