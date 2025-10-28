Return-Path: <bpf+bounces-72646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2A8C1740B
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 23:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6954818908B9
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 22:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4599236A5EF;
	Tue, 28 Oct 2025 22:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vHf856Dz"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DE0368F2A
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 22:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761692209; cv=none; b=u877nPE8jpt3CIGkgJmNS6HgQoYtn48xvESN7MfsCN9AK47wfovsHVmLtkTxMhwnQgtS9UuOLjVdbXMsXEP0RdLRZ+8ts+Bp74ijiOZ+0cKVsL3194Wdo7AeojbT6ewWncrCRJzYx5YvPlCva1qZxE3aF7EBCzzT4p0X0L2YsFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761692209; c=relaxed/simple;
	bh=LHuNMp3ygs4wAWcJX9L5X8OUX9i8atgduXpB4oSRaAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=amPWB4wpBTw5PcIZDN52fA11bPQq6DMmYN9Gw2s47s75mAAXzHIIFGWq6MsAEKNznDH0uAH9m1l/QgJlPSZDY5CdRWz5MNVAQjakCmz2yvTCLfOuu8RTDetbZtyYGLwqLpq2rsqNhHjHF4gRV6iVpHqN6wl1sSk+rL+IQcgfZxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vHf856Dz; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761692204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwaUvexePBwfrsbH+nJJUtqPW0LdmYLCiCJf8UFiuNk=;
	b=vHf856DzcGN+UnRI9J2dzE5swYcbXFIgs5SNJVh5KGnNlOnFBV2EsLDOIUQ4wt9lYXug6G
	upel1lImczqvWo5Vah95pKZinCl1gj2VbUsHPEcWKn+qAZghAIfG3HSOnrvS6wLrRNAgpb
	Z1CW8zaIFPaMlqP+ZbHDJqGFXmvDuTU=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  LKML
 <linux-kernel@vger.kernel.org>,  Alexei Starovoitov <ast@kernel.org>,
  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko
 <mhocko@kernel.org>,  Shakeel Butt <shakeel.butt@linux.dev>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Andrii Nakryiko <andrii@kernel.org>,  JP
 Kobryn <inwardvessel@gmail.com>,  linux-mm <linux-mm@kvack.org>,  "open
 list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,  bpf
 <bpf@vger.kernel.org>,  Martin KaFai Lau <martin.lau@kernel.org>,  Song
 Liu <song@kernel.org>,  Kumar Kartikeya Dwivedi <memxor@gmail.com>,  Tejun
 Heo <tj@kernel.org>
Subject: Re: [PATCH v2 06/23] mm: introduce BPF struct ops for OOM handling
In-Reply-To: <CAADnVQ+iEcMaJ68LNt2XxOeJtdZkCzJwDk9ueovQbASrX7WMdg@mail.gmail.com>
	(Alexei Starovoitov's message of "Tue, 28 Oct 2025 15:07:49 -0700")
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
	<20251027231727.472628-7-roman.gushchin@linux.dev>
	<CAADnVQKWskY1ijJtSX=N0QczW_-gtg-X_SpK_GuiYBYQodn5wQ@mail.gmail.com>
	<87qzumq358.fsf@linux.dev>
	<CAADnVQ+iEcMaJ68LNt2XxOeJtdZkCzJwDk9ueovQbASrX7WMdg@mail.gmail.com>
Date: Tue, 28 Oct 2025 15:56:31 -0700
Message-ID: <87frb2octc.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Oct 28, 2025 at 11:42=E2=80=AFAM Roman Gushchin
> <roman.gushchin@linux.dev> wrote:
>>
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>> > On Mon, Oct 27, 2025 at 4:18=E2=80=AFPM Roman Gushchin <roman.gushchin=
@linux.dev> wrote:
>> >>
>> >> +bool bpf_handle_oom(struct oom_control *oc)
>> >> +{
>> >> +       struct bpf_oom_ops *bpf_oom_ops =3D NULL;
>> >> +       struct mem_cgroup __maybe_unused *memcg;
>> >> +       int idx, ret =3D 0;
>> >> +
>> >> +       /* All bpf_oom_ops structures are protected using bpf_oom_src=
u */
>> >> +       idx =3D srcu_read_lock(&bpf_oom_srcu);
>> >> +
>> >> +#ifdef CONFIG_MEMCG
>> >> +       /* Find the nearest bpf_oom_ops traversing the cgroup tree up=
wards */
>> >> +       for (memcg =3D oc->memcg; memcg; memcg =3D parent_mem_cgroup(=
memcg)) {
>> >> +               bpf_oom_ops =3D READ_ONCE(memcg->bpf_oom);
>> >> +               if (!bpf_oom_ops)
>> >> +                       continue;
>> >> +
>> >> +               /* Call BPF OOM handler */
>> >> +               ret =3D bpf_ops_handle_oom(bpf_oom_ops, memcg, oc);
>> >> +               if (ret && oc->bpf_memory_freed)
>> >> +                       goto exit;
>> >> +       }
>> >> +#endif /* CONFIG_MEMCG */
>> >> +
>> >> +       /*
>> >> +        * System-wide OOM or per-memcg BPF OOM handler wasn't succes=
sful?
>> >> +        * Try system_bpf_oom.
>> >> +        */
>> >> +       bpf_oom_ops =3D READ_ONCE(system_bpf_oom);
>> >> +       if (!bpf_oom_ops)
>> >> +               goto exit;
>> >> +
>> >> +       /* Call BPF OOM handler */
>> >> +       ret =3D bpf_ops_handle_oom(bpf_oom_ops, NULL, oc);
>> >> +exit:
>> >> +       srcu_read_unlock(&bpf_oom_srcu, idx);
>> >> +       return ret && oc->bpf_memory_freed;
>> >> +}
>> >
>> > ...
>> >
>> >> +static int bpf_oom_ops_reg(void *kdata, struct bpf_link *link)
>> >> +{
>> >> +       struct bpf_struct_ops_link *ops_link =3D container_of(link, s=
truct bpf_struct_ops_link, link);
>> >> +       struct bpf_oom_ops **bpf_oom_ops_ptr =3D NULL;
>> >> +       struct bpf_oom_ops *bpf_oom_ops =3D kdata;
>> >> +       struct mem_cgroup *memcg =3D NULL;
>> >> +       int err =3D 0;
>> >> +
>> >> +       if (IS_ENABLED(CONFIG_MEMCG) && ops_link->cgroup_id) {
>> >> +               /* Attach to a memory cgroup? */
>> >> +               memcg =3D mem_cgroup_get_from_ino(ops_link->cgroup_id=
);
>> >> +               if (IS_ERR_OR_NULL(memcg))
>> >> +                       return PTR_ERR(memcg);
>> >> +               bpf_oom_ops_ptr =3D bpf_oom_memcg_ops_ptr(memcg);
>> >> +       } else {
>> >> +               /* System-wide OOM handler */
>> >> +               bpf_oom_ops_ptr =3D &system_bpf_oom;
>> >> +       }
>> >
>> > I don't like the fallback and special case of cgroup_id =3D=3D 0.
>> > imo it would be cleaner to require CONFIG_MEMCG for this feature
>> > and only allow attach to a cgroup.
>> > There is always a root cgroup that can be attached to and that
>> > handler will be acting as "system wide" oom handler.
>>
>> I thought about it, but then it can't be used on !CONFIG_MEMCG
>> configurations and also before cgroupfs is mounted, root cgroup
>> is created etc.
>
> before that bpf isn't viable either, and oom is certainly not an issue.
>
>> This is why system-wide things are often handled in a
>> special way, e.g. in by PSI (grep system_group_pcpu).
>>
>> I think supporting !CONFIG_MEMCG configurations might be useful for
>> some very stripped down VM's, for example.
>
> I thought I wouldn't need to convince the guy who converted bpf maps
> to memcg and it made it pretty much mandatory for the bpf subsystem :)
> I think the following is long overdue:
> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index eb3de35734f0..af60be6d3d41 100644
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig
> @@ -34,6 +34,7 @@ config BPF_SYSCALL
>         select NET_SOCK_MSG if NET
>         select NET_XGRESS if NET
>         select PAGE_POOL if NET
> +       depends on MEMCG
>         default n
>
> With this we can cleanup a ton of code.
> Let's not add more hacks just because some weird thing
> still wants !MEMCG. If they do, they will survive without bpf.

Ok, this is bold, but why not?
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Are you going to land it separately, I guess?

