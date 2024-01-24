Return-Path: <bpf+bounces-20226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 118BE83A975
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 13:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D91282CF3
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 12:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DA763110;
	Wed, 24 Jan 2024 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="EeyuUl53"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4C4FC09
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706098661; cv=none; b=FgkVlZaudsfBkwBwU6Xh1mp06DAl0qisXBIOSQtDwpMpnIdgJXxUhQOMWL3r3IchYUqkz1oiooJ8CE3aevcmOww5In0e2LC6VuZD1UaHoZ8NoFTayFkFyjI/Mc2NwaFhCZLBkRr1YYxxTQNND2BpX6v1YrEUUQqjPvZnqvvGi9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706098661; c=relaxed/simple;
	bh=4wAsqiXtqLWKVqj2fG/asHpB71yeF4SIWaebwZLRE/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKeTF5HwWKuiWL0b3tdhnp3dju/BcYGm6+6rKpk32cVnVGKklI/+OIIka6ypLGfyRex3nqwwkXAHN6tzoQF1m0GscwLzv7gvchP/rK8zwNXGorBtpu76QgkqcKpPztNCVVBC30fAwA1WQ2amgIH/HCrHhclZ1WQvLtxtPQAAle0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=EeyuUl53; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc2308fe275so4575754276.1
        for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 04:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706098658; x=1706703458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N40ZEELDdKAG+PltYHXUqIJnRZg2htUPF9zZfWdekds=;
        b=EeyuUl531izO/zR9hh1JZTFuEh+b7ysIzkXISnSp9/9oRhAF+ZafJOz9793fqgbXMN
         IiulBQ64otHMwQhkfmDvZd6oJgBt3K09MAFj69vt6AxOdqKobEDllPkjNfUKt9YRKOuW
         68vBKK1XQnAH5foPJL+dP0c0DpMIZOWT7Gi5p6QDa6+0ooa94oXT3XhxFTRYbFfim5vT
         esTsBYXYOzaMmhoa0aqcknJtYtIvc47ufL1C9uAt8GNFYyuIYuP2YqRaDOBsk5iMPltY
         ciR0v9TLJzleIFQttlrJf8qn/lVII7i4Zg5WmYK0MZG2RV0jCLqRn5bq17sqcMnsmv0z
         jbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706098658; x=1706703458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N40ZEELDdKAG+PltYHXUqIJnRZg2htUPF9zZfWdekds=;
        b=rcOwak4QXAMok6ryMLxY0FYSJM3apOLSSWF1egYZ4rWyQbRB6sHO0zOOOWo8FgPxS4
         CSw74q+8KLVw9mnU3JLt0rpTv9Rlpy3ECSEy3uCf8bMoUDmxYhTrdr5dpSad5YDZz+G9
         46S/TQpCH8hiP+l3AkrivWISqg1eLeit9OxbE1cq2hsV23SN4n2Jv6GDnZNTVdJ5vJR9
         WtG19ax3TeDqwxint64bY7zufFnPSKGSCXzaW3swL85L78l+X9sI3dOzHqsZEPVFdk56
         mCh2o65vdGoXUqv7HLhH174k6/COehTHN5zAMXBsnaYM5LGg4DlGZ2Djzm1pMd3gzu26
         u2ug==
X-Gm-Message-State: AOJu0YyE0ovbrBx1a+spqBIjB56Yn89rgYxFv6phgMKNh5Cnail+/6sY
	oW4IZ2tkzal7N2CKDW7nFm4pBGQBSwoNtf/w4EIi0Oj1tAoTpxIvFxOemAiZafiLBx5VCawT6zf
	wnFU63O9vXYWwAqPoYXn2f7uwCOVcuSU1H/qy
X-Google-Smtp-Source: AGHT+IFwzXVb4RY9kn5qPmYvPGQUlYLETaeLn/PuqSP06R4dtdLY3ViYyP66gP8R/osYf0FPE0DXk7hFGVI9sCWzIaI=
X-Received: by 2002:a25:81d0:0:b0:dc2:8282:a590 with SMTP id
 n16-20020a2581d0000000b00dc28282a590mr448139ybm.125.1706098658502; Wed, 24
 Jan 2024 04:17:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123135242.11430-1-mkoutny@suse.com>
In-Reply-To: <20240123135242.11430-1-mkoutny@suse.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 24 Jan 2024 07:17:27 -0500
Message-ID: <CAM0EoMkA1Hp61mp2n06P8aMdnteJZD5tvJPDOuAKi_PNrb+T9A@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] net/sched: Load modules via alias
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	cake@lists.bufferbloat.net, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	Petr Pavlu <ppavlu@suse.cz>, Michal Kubecek <mkubecek@suse.cz>, Martin Wilck <mwilck@suse.com>, 
	Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Tue, Jan 23, 2024 at 8:52=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> These modules may be loaded lazily without user's awareness and
> control. Add respective aliases to modules and request them under these
> aliases so that modprobe's blacklisting mechanism (through aliases)
> works for them. (The same pattern exists e.g. for filesystem
> modules.)
>
> For example (before the change):
>   $ tc filter add dev lo parent 1: protocol ip prio 1 handle 10 tcindex .=
..
>   # cls_tcindex module is loaded despite a `blacklist cls_tcindex` entry
>   # in /etc/modprobe.d/*.conf
>
> After the change:
>   $ tc filter add dev lo parent 1: protocol ip prio 1 handle 10 tcindex .=
..
>   Unknown filter "tcindex", hence option "..." is unparsable
>   # explicit/acknowledged (privileged) action is needed
>   $ modprobe cls_tcindex
>   # blacklist entry won't apply to this direct modprobe, module is
>   # loaded with awareness
>

A small nit seeing Simon's comment which will have you respin.
cls_tcindex is no longer in the kernel. Can you use another example?
Also Stephen had some comments last time, not sure if you addressed
those (nothing on the logs says you did and i didnt see him say
anything).

cheers,
jamal

> A considered alternative was invoking `modprobe -b` always from
> request_module(), however, dismissed as too intrusive and slightly
> confusing in favor of the precedented aliases (the commit 7f78e0351394
> ("fs: Limit sys_mount to only request filesystem modules.").
>
> User experience suffers in both alternatives. It's improvement is
> orthogonal to blacklist honoring.
>
> Changes from v1 (https://lore.kernel.org/r/20231121175640.9981-1-mkoutny@=
suse.com)
> - Treat sch_ and act_ modules analogously to cls_
>
> Changes from v2 (https://lore.kernel.org/r/20231206192752.18989-1-mkoutny=
@suse.com)
> - reorganized commits (one generated commit + manual pre-/post- work)
> - used alias names more fitting the existing net- aliases
> - more info in commit messages and cover letter
> - rebased on current master
>
> Changes from v3 (https://lore.kernel.org/r/20240112180646.13232-1-mkoutny=
@suse.com)
> - rebase on netdev/net-next/main
> - correct aliases in cls_* modules (wrong sed)
> - replace repeated prefix strings with a macro
> - patch also request_module call in qdisc_set_default()
>
> Michal Koutn=C3=BD (4):
>   net/sched: Add helper macros with module names
>   net/sched: Add module aliases for cls_,sch_,act_ modules
>   net/sched: Load modules via their alias
>   net/sched: Remove alias of sch_clsact
>
>  include/net/act_api.h      | 2 ++
>  include/net/pkt_cls.h      | 2 ++
>  include/net/pkt_sched.h    | 2 ++
>  net/sched/act_api.c        | 2 +-
>  net/sched/act_bpf.c        | 1 +
>  net/sched/act_connmark.c   | 1 +
>  net/sched/act_csum.c       | 1 +
>  net/sched/act_ct.c         | 1 +
>  net/sched/act_ctinfo.c     | 1 +
>  net/sched/act_gact.c       | 1 +
>  net/sched/act_gate.c       | 1 +
>  net/sched/act_ife.c        | 1 +
>  net/sched/act_mirred.c     | 1 +
>  net/sched/act_mpls.c       | 1 +
>  net/sched/act_nat.c        | 1 +
>  net/sched/act_pedit.c      | 1 +
>  net/sched/act_police.c     | 1 +
>  net/sched/act_sample.c     | 1 +
>  net/sched/act_simple.c     | 1 +
>  net/sched/act_skbedit.c    | 1 +
>  net/sched/act_skbmod.c     | 1 +
>  net/sched/act_tunnel_key.c | 1 +
>  net/sched/act_vlan.c       | 1 +
>  net/sched/cls_api.c        | 2 +-
>  net/sched/cls_basic.c      | 1 +
>  net/sched/cls_bpf.c        | 1 +
>  net/sched/cls_cgroup.c     | 1 +
>  net/sched/cls_flow.c       | 1 +
>  net/sched/cls_flower.c     | 1 +
>  net/sched/cls_fw.c         | 1 +
>  net/sched/cls_matchall.c   | 1 +
>  net/sched/cls_route.c      | 1 +
>  net/sched/cls_u32.c        | 1 +
>  net/sched/sch_api.c        | 4 ++--
>  net/sched/sch_cake.c       | 1 +
>  net/sched/sch_cbs.c        | 1 +
>  net/sched/sch_choke.c      | 1 +
>  net/sched/sch_codel.c      | 1 +
>  net/sched/sch_drr.c        | 1 +
>  net/sched/sch_etf.c        | 1 +
>  net/sched/sch_ets.c        | 1 +
>  net/sched/sch_fq.c         | 1 +
>  net/sched/sch_fq_codel.c   | 1 +
>  net/sched/sch_gred.c       | 1 +
>  net/sched/sch_hfsc.c       | 1 +
>  net/sched/sch_hhf.c        | 1 +
>  net/sched/sch_htb.c        | 1 +
>  net/sched/sch_ingress.c    | 3 ++-
>  net/sched/sch_mqprio.c     | 1 +
>  net/sched/sch_multiq.c     | 1 +
>  net/sched/sch_netem.c      | 1 +
>  net/sched/sch_pie.c        | 1 +
>  net/sched/sch_plug.c       | 1 +
>  net/sched/sch_prio.c       | 1 +
>  net/sched/sch_qfq.c        | 1 +
>  net/sched/sch_red.c        | 1 +
>  net/sched/sch_sfb.c        | 1 +
>  net/sched/sch_sfq.c        | 1 +
>  net/sched/sch_skbprio.c    | 1 +
>  net/sched/sch_taprio.c     | 1 +
>  net/sched/sch_tbf.c        | 1 +
>  61 files changed, 66 insertions(+), 5 deletions(-)
>
>
> base-commit: 736b5545d39ca59d4332a60e56cc8a1a5e264a8e
> --
> 2.43.0
>

