Return-Path: <bpf+bounces-21049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253D8846FCB
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 13:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D23DB222A7
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 12:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ACA13EFEC;
	Fri,  2 Feb 2024 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="vad83jPk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2429C13E211
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875706; cv=none; b=cEEqTGHJ98oczt9RuBJHZhCJzvkJJ37m4j5bcbzYgdQJnDdbO6Kf+pmxv/ScyepL+7UqVdayO0Apn3dQTq3VUmkGkKfJQ6NP4p5IFLHIB8qzwHnTyedk9+8YP2ipRwX8jYO98HOq7zcRqkW0h601kUVKfMAyk0dM5NlPSp+ldRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875706; c=relaxed/simple;
	bh=kTnykM5RVtFH2Sl5tQfconU8iUoltS4WWZgRjqpNeFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bIvPtuIHeETUBM119PVlypRY8uI5K5WkRXR0t/V68Jo766vYmAIiZ+AUcsJQDcxly9X/wcdFQp7DNxClfFjoPL0PADeDMJmTAl2dJ8W93td2Gvi1Kx0gk6sWdcRSLhc/qtBZlE7Z2444E2PNXLq0olgKa1k23P0mi5LQ7FC0h4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=vad83jPk; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6d54def6fso1794726276.3
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 04:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706875704; x=1707480504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbUHI8hXSl0417ZmZn93pMUO7YG1xwRNmnX/Oh+gVXw=;
        b=vad83jPkEjBM9bL7R3cy5L7sOfwEE/FCSxgj3gvNxxtWEo3vWyHKAuM3yQvpxYnBBQ
         VmGwDCtouvkGCgFhg+aJKNK6k/relJ7OIkuFm4IGU9B1Bcr9zH3YyI82y5Rs8v3pV7ZC
         UZq2a0jOTz5f5C7Ku0nUuHRBmfQRtIiDdZPte5P7/2dwUHtu04A/KNLw53QSUQnsRXkW
         /lGqU/26AexCImDOgPmmTRp3ymyzziAzFeK1+e7uMsqRnoHJWN7+NWTWi8aobJOX9gBq
         gSTDmQB/vew3/0OgNCw+DEjFeSE9bQYfK2efQ+DSlfL6+LTCs3kwpIHQaVP1SkOoXFLY
         VImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706875704; x=1707480504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbUHI8hXSl0417ZmZn93pMUO7YG1xwRNmnX/Oh+gVXw=;
        b=UCsjN0TDS/Ts4dttew8WvhvYipZmYzZesTPYBF/FKS1soT4S3FgFhphISe2XlQht3G
         Uu7jg124dFqkapiiUePytUUitMMXGjSWICOHLbpB2MIR19XfCWSnScRnxj4NGL0GYAxh
         AJ1FRtuHbuAiM1jbvlurZncGsnqHeumUZBB2l3RyXxabwPhxio1bEHt2N/KnRHCgmhYj
         B/jiYYAUB8akyuNTqCV47o1kFPkHbPcSaCi8tL/I6whAsPgyYCs4qFz5Lv4KcOuvLtsK
         8kWm4rof5HdRnGyiy5b3W7Uevxm4g2UAhZx8YbehAiPNr4E5H4JWEQxxmItDFeNYTWrG
         Iszw==
X-Gm-Message-State: AOJu0YzxgUibmDKSpRDqn74m4FPZQ/eC9NU0IZGJm8QP4Z5gDYpmbIlS
	5l/ZUoJpuR/F0gkkt1w7rlKK+GYnTY5VlRJM3TQzNq5lb65Rt0C/OvAclITxRPDXYb0nDALvOYE
	exw7mTWrF8i/sKlCAFwHlsT9NcgU+WLboNDFG
X-Google-Smtp-Source: AGHT+IEjjtQ/DhGAXm7hLk1+I7JJDKeMEgJ/8DH8etGoQz3Y/c+zY06bh/klIto8q9wn+v1N2uLHjxeleIKOIY6i6m0=
X-Received: by 2002:a25:2d16:0:b0:dc2:66d4:1544 with SMTP id
 t22-20020a252d16000000b00dc266d41544mr5634193ybt.55.1706875703633; Fri, 02
 Feb 2024 04:08:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201130943.19536-1-mkoutny@suse.com>
In-Reply-To: <20240201130943.19536-1-mkoutny@suse.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 2 Feb 2024 07:08:12 -0500
Message-ID: <CAM0EoMmE1agDZoY_0UZPiWG-LLkRBT9qj+oy1ODH2w0GoktPdg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] net/sched: Load modules via alias
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	cake@lists.bufferbloat.net, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	Simon Horman <horms@kernel.org>, Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 8:09=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
>
> These modules may be loaded lazily without user's awareness and
> control. Add respective aliases to modules and request them under these
> aliases so that modprobe's blacklisting mechanism (through aliases)
> works for them. (The same pattern exists e.g. for filesystem
> modules.)
>
> For example (before the change):
>   $ tc filter add dev lo parent 10: protocol ip prio 10 handle 1: cgroup
>   # cls_cgroup module is loaded despite a `blacklist cls_cgroup` entry
>   # in /etc/modprobe.d/*.conf
>
> After the change:
>   $ tc filter add dev lo parent 10: protocol ip prio 10 handle 1: cgroup
>   Error: TC classifier not found.
>   We have an error talking to the kernel
>   # explicit/acknowledged (privileged) action is needed
>   $ modprobe cls_cgroup
>   # blacklist entry won't apply to this direct modprobe, module is
>   # loaded with awareness
>
> A considered alternative was invoking `modprobe -b` always from
> request_module(), however, dismissed as too intrusive and slightly
> confusing in favor of the precedented aliases (the commit 7f78e0351394
> ("fs: Limit sys_mount to only request filesystem modules.").
>
> User experience suffers in both alternatives. Its improvement is
> orthogonal to blacklist honoring.
>

Thanks Michal. We still didnt hear from Stephen, but i think looks
solid now. So for the patchset:

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

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
> Changes from v4 (https://lore.kernel.org/r/20240123135242.11430-1-mkoutny=
@suse.com)
> - update example in cover letter to existing module (cls_tcindex->cls_cgr=
oup)
>   - tested that ':-)
> - remove __stringify in alias macro, net-cls-cgroup instead of net-cls-"c=
group"
> - pass correct argument to request_module() (Simon)
> - rebased on netdev-next/main
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
> base-commit: 644c64318de0df5f4ea9f00e4b8cc262b343a93f
> --
> 2.43.0
>

