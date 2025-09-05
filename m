Return-Path: <bpf+bounces-67574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A38B45C57
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 17:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFDB83B3E0E
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 15:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7523E1C6B4;
	Fri,  5 Sep 2025 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knY1CHOD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F4331B803
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085521; cv=none; b=ZAWl6rHX4erIuc8ypEwPBiPsJ9aR3Kg8JIBTsywXjSsJ2atxr3ea1mS/Ls7B/SGwAIvOvwru4SU/qyvMGSJKLxLv60CglmP2gYb0EbiNEGH2TZsI74NXEUao4PZFTGi6n6L98lSuwtSh/7GPcHtQkBJzwVcpuDS7Vq6t9ZbrOX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085521; c=relaxed/simple;
	bh=ZlAmV3vT9hz4ZRs2sWIT1XiFg7+A0oFlqruUQGduf3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpL15ZvdqmNZhA4cARSub7WIXI7yZiEu7jZsLq/iS9uROQ9FTqgLFg030cekP67ebciL0tzIg5gad27vV812MFQCEL63G0QahfQSUitQYFRMqH8Q9Jr/Hx9Dp6iSgLb7bzWsWx0Wk8ULrl4yopx8zOMCqSVQiBYYme6zmDLE06Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knY1CHOD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so13795395e9.1
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 08:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757085517; x=1757690317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Q1ehjfubWNlKqKQa/3mVMqSdND4LP1ovQqoFNQteSA=;
        b=knY1CHODAH7rSaFXuEjIZSQuZoa5CRotqEedbWtiau1/2qPLc8D2TjxrKyHyzuHbJ3
         BMepPlN67cUzpy2r8ro6CoqPED5AGe5/BTCrbShfGV67UjQuCiQNGkDaVNWcyKB1QEqi
         Co18O8I8XVN39TFhRXYt4X0brRGVm4ocobAGGzcuQHpyFLPgNPS2DFYJ94kUd2hE/CZQ
         Myxd+QcGwEvF9Xbmn4M5+eRt+LqKKZ5KfLk5sJ1phQ0Uk4ZzSojrFc6Z0zyDJoIKcNEB
         pHunmI1y8xrOWzMHxrTWmgbCvV+BCAbpDTk3VIwXWAcuJh9O05bHOKT/GrnPO2/N0sJA
         8CVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757085517; x=1757690317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Q1ehjfubWNlKqKQa/3mVMqSdND4LP1ovQqoFNQteSA=;
        b=gWgduCW4342d8PGQ1QiugsM+Nl9YS8VTd7b7drlr6hlHrRuFKnxqHN5CS9ecHITdqE
         J/+FcbK+PpREnN/wIpWZcdd0qOcZCItAWQtvrPcFUYYeruuxUgYFuZbh6QDGSJnuRUSK
         BDLh1khIoRWRBZUNwJcesd11Q5fbkG8r9YjKzJihSwCYqELuMLR2jYD29xheD4pbYOja
         /HnUS4Cc3eddiOek/5fpam62Zd+6wfopLkd+nBA0NUCCm9v2xyX/Lxq53Qys2omwBBB4
         nuum345Ae0cQRabvH31E8DIQuphkstix2PEJXBq45oDEsSa9PCnLmfSComrloJi1JO2z
         wjOw==
X-Gm-Message-State: AOJu0Yy331t/xXN+1HCVUg/tamMC0DyypI+cOfQLOd5N80i1qT2qVqk9
	9oyNP5vnB2DEWmHttUV3Mp7qXeigKHRv3VtXIT6K94GUXOL98loRTSV+t52AyM3x94W+B6zWAJh
	RDX1ZcrmaQdi8cryTjqV2w0ml5ztbdcA=
X-Gm-Gg: ASbGncuWcnkXxsCh0Wbodlk/GVll1JhYcAEBf/p2f3htpQz4SuptHVpWXu+RuupIEHz
	+awdiHTGoFNxsRLQaeavmJE5WqQ9LhWK/4V/YwS80/4deOr1E/w3a4ETWQ1TTIsSmYDTn/0MzGV
	L0Zevxcvp1fAW5f50FtAX3vTMWMA418wCDaM4ghPS5rBsYtAaCqRwDeF6RSo6/GLNZ4p1NpORjU
	DsdU6u0qCEMZBDV3ymvlbK5+7nDiAeFNNdu
X-Google-Smtp-Source: AGHT+IE9i+mS2ia8Jv9x5eDYlhRgWf2JI4yG5V2EeJ3lkLBmQPmwY+urNQkPBMd5Et5kd8Cw2V3B69gxCWB9VPK9uVI=
X-Received: by 2002:a05:6000:1888:b0:3ce:a06e:f24e with SMTP id
 ffacd0b85a97d-3d1e05b6b69mr15834765f8f.52.1757085516311; Fri, 05 Sep 2025
 08:18:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905061919.439648-1-yepeilin@google.com>
In-Reply-To: <20250905061919.439648-1-yepeilin@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 5 Sep 2025 08:18:25 -0700
X-Gm-Features: Ac12FXysx-vp5eBzbNX00RomcK4ABuEwPtb-GCFWqgecj-_twKwPMjzq2S5BthE
Message-ID: <CAADnVQKAd-jubdQ9ja=xhTqahs+2bk2a+8VUTj1bnLpueow0Lg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf/helpers: Skip memcg accounting in __bpf_async_init()
To: Peilin Ye <yepeilin@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Josh Don <joshdon@google.com>, 
	Barret Rhoden <brho@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 11:20=E2=80=AFPM Peilin Ye <yepeilin@google.com> wro=
te:
>
> Calling bpf_map_kmalloc_node() from __bpf_async_init() can cause various
> locking issues; see the following stack trace (edited for style) as one
> example:
>
> ...
>  [10.011566]  do_raw_spin_lock.cold
>  [10.011570]  try_to_wake_up             (5) double-acquiring the same
>  [10.011575]  kick_pool                      rq_lock, causing a hardlocku=
p
>  [10.011579]  __queue_work
>  [10.011582]  queue_work_on
>  [10.011585]  kernfs_notify
>  [10.011589]  cgroup_file_notify
>  [10.011593]  try_charge_memcg           (4) memcg accounting raises an
>  [10.011597]  obj_cgroup_charge_pages        MEMCG_MAX event
>  [10.011599]  obj_cgroup_charge_account
>  [10.011600]  __memcg_slab_post_alloc_hook
>  [10.011603]  __kmalloc_node_noprof
> ...
>  [10.011611]  bpf_map_kmalloc_node
>  [10.011612]  __bpf_async_init
>  [10.011615]  bpf_timer_init             (3) BPF calls bpf_timer_init()
>  [10.011617]  bpf_prog_xxxxxxxxxxxxxxxx_fcg_runnable
>  [10.011619]  bpf__sched_ext_ops_runnable
>  [10.011620]  enqueue_task_scx           (2) BPF runs with rq_lock held
>  [10.011622]  enqueue_task
>  [10.011626]  ttwu_do_activate
>  [10.011629]  sched_ttwu_pending         (1) grabs rq_lock
> ...
>
> The above was reproduced on bpf-next (b338cf849ec8) by modifying
> ./tools/sched_ext/scx_flatcg.bpf.c to call bpf_timer_init() during
> ops.runnable(), and hacking [1] the memcg accounting code a bit to make
> it (much more likely to) raise an MEMCG_MAX event from a
> bpf_timer_init() call.
>
> We have also run into other similar variants both internally (without
> applying the [1] hack) and on bpf-next, including:
>
>  * run_timer_softirq() -> cgroup_file_notify()
>    (grabs cgroup_file_kn_lock) -> try_to_wake_up() ->
>    BPF calls bpf_timer_init() -> bpf_map_kmalloc_node() ->
>    try_charge_memcg() raises MEMCG_MAX ->
>    cgroup_file_notify() (tries to grab cgroup_file_kn_lock again)
>
>  * __queue_work() (grabs worker_pool::lock) -> try_to_wake_up() ->
>    BPF calls bpf_timer_init() -> bpf_map_kmalloc_node() ->
>    try_charge_memcg() raises MEMCG_MAX -> m() ->
>    __queue_work() (tries to grab the same worker_pool::lock)
>  ...
>
> As pointed out by Kumar, we can use bpf_mem_alloc() and friends for
> bpf_hrtimer and bpf_work, to skip memcg accounting.

This is a short term workaround that we shouldn't take.
Long term bpf_mem_alloc() will use kmalloc_nolock() and
memcg accounting that was already made to work from any context
except that the path of memcg_memory_event() wasn't converted.

Shakeel,

Any suggestions how memcg_memory_event()->cgroup_file_notify()
can be fixed?
Can we just trylock and skip the event?

