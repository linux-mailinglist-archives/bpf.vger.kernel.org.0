Return-Path: <bpf+bounces-46765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1552C9F0042
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2FB287DD1
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 23:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07E01DEFDA;
	Thu, 12 Dec 2024 23:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="VWg9PaCn"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09A81DE8AA;
	Thu, 12 Dec 2024 23:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046669; cv=none; b=en870kJJ3SYwhHzOGGIpaIORQ5uywMgOTwgILzwaQthDzfkp7GnhrNz3lCSbBPG1wRWXlg8qKmAFCykJNG1LKADmeK82BwR7s9rP/KSr9Rd1juveem9cWwaD3im8FtBJLFHMSbZ8f9GC7ecgnj+jMrHaGHDV65r8HeXWe4gC/3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046669; c=relaxed/simple;
	bh=YTgEMDc0ikMsMdmEEB/QR41m3JqAvO/1aSO2jbjFmKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ip0wTG4t4/GUBNapKTd8a9w2psaphWk9hm4zsLaXE2VDekT7KK3BAmlKO0aCfkmqS/7mB/QBl04IoBZ7deoXABp6xKi96xM54gAPn/EhFnqFc654P/eBxMe6qHWF0HrmLDPRSkZn9bXlwh4I1YCV96HkakXPpUTUnxPr8eifw7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=VWg9PaCn; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734046664;
	bh=YTgEMDc0ikMsMdmEEB/QR41m3JqAvO/1aSO2jbjFmKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VWg9PaCnY4j0AOXd7bHrJi6VU59uMT+B1hkIr46eoGwwJSzXHsesuaIzQnH+6zqRZ
	 l7JhpsEBSppDLM7lugrv9FpVAFJ16V7+dHMIuxPnskyGYUoulc0eE9LyatIiRyUfhc
	 HkDSHsyZPfy8fkG+39skJUHnXurVfOQc1GitlGGI=
Date: Fri, 13 Dec 2024 00:37:44 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: fix configuration-dependent BTF function
 references
Message-ID: <a19b5fb2-9a82-42f2-81dd-17d96bb6ec9e@t-8ch.de>
References: <20241213-bpf-cond-ids-v1-1-881849997219@weissschuh.net>
 <CAEf4BzYTYDcf7J0jhJP3cW5489jWXdfJcw-f-8yuTHcNmQ0cbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYTYDcf7J0jhJP3cW5489jWXdfJcw-f-8yuTHcNmQ0cbw@mail.gmail.com>

On 2024-12-12 15:27:12-0800, Andrii Nakryiko wrote:
> On Thu, Dec 12, 2024 at 3:00 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
> >
> > These BTF functions are not available unconditionally,
> > only reference them when they are available.
> >
> > Avoid the following build warnings:
> >
> >   BTF     .tmp_vmlinux1.btf.o
> > btf_encoder__tag_kfunc: failed to find kfunc 'bpf_send_signal_task' in BTF
> > btf_encoder__tag_kfuncs: failed to tag kfunc 'bpf_send_signal_task'
> >   NM      .tmp_vmlinux1.syms
> >   KSYMS   .tmp_vmlinux1.kallsyms.S
> >   AS      .tmp_vmlinux1.kallsyms.o
> >   LD      .tmp_vmlinux2
> >   NM      .tmp_vmlinux2.syms
> >   KSYMS   .tmp_vmlinux2.kallsyms.S
> >   AS      .tmp_vmlinux2.kallsyms.o
> >   LD      vmlinux
> >   BTFIDS  vmlinux
> > WARN: resolve_btfids: unresolved symbol prog_test_ref_kfunc
> > WARN: resolve_btfids: unresolved symbol bpf_crypto_ctx
> > WARN: resolve_btfids: unresolved symbol bpf_send_signal_task
> > WARN: resolve_btfids: unresolved symbol bpf_modify_return_test_tp
> > WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_xdp
> > WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_skb
> >
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  kernel/bpf/helpers.c  | 4 ++++
> >  kernel/bpf/verifier.c | 8 ++++++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 751c150f9e1cd7f56e6a2b68a7ebb4ae89a30d2d..5edf5436a7804816b7dcf1bbef2624d71a985f20 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -3089,7 +3089,9 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_task_from_vpid, KF_ACQUIRE | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_throw)
> > +#ifdef CONFIG_BPF_EVENTS
> >  BTF_ID_FLAGS(func, bpf_send_signal_task, KF_TRUSTED_ARGS)
> > +#endif
> >  BTF_KFUNCS_END(generic_btf_ids)
> >
> >  static const struct btf_kfunc_id_set generic_kfunc_set = {
> > @@ -3135,7 +3137,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
> >  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> >  BTF_ID_FLAGS(func, bpf_dynptr_size)
> >  BTF_ID_FLAGS(func, bpf_dynptr_clone)
> > +#ifdef CONFIG_NET
> >  BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
> > +#endif
> 
> It makes little sense to have bpf_prog_test_run_tracing() and
> bpf_modify_return_test_tp() depend on CONFIG_NET... It's just
> historically where BPF_PROG_TEST_RUN functionality was implemented,
> but it seems like we need to move bpf_prog_test_run_tracing() and
> other tracing-related testing stuff into kernel/trace/bpf_trace.c or
> somewhere under kernel/bpf/ (core.c? helpers.c?)

I agree. But today these are the config values which are in effect.
When the functions get moved, the config values can be adapted.
With my commit "kbuild/btf: Propagate CONFIG_WERROR to resolve_btfids"
in bpf-next the warnings can actually become errors.
So I'd propose to apply this fix to avoid issues in the near future and
then do a proper move without any urgency.

> >  BTF_ID_FLAGS(func, bpf_wq_init)
> >  BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
> >  BTF_ID_FLAGS(func, bpf_wq_start)
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 5e541339b2f6d1870561033fd55cca7144db14bc..77bbf58418fee7533bce539c8e005d2342ee1a48 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5526,7 +5526,9 @@ static bool in_rcu_cs(struct bpf_verifier_env *env)
> >
> >  /* Once GCC supports btf_type_tag the following mechanism will be replaced with tag check */
> >  BTF_SET_START(rcu_protected_types)
> > +#ifdef CONFIG_NET
> >  BTF_ID(struct, prog_test_ref_kfunc)
> > +#endif
> >  #ifdef CONFIG_CGROUPS
> >  BTF_ID(struct, cgroup)
> >  #endif
> > @@ -5534,7 +5536,9 @@ BTF_ID(struct, cgroup)
> >  BTF_ID(struct, bpf_cpumask)
> >  #endif
> >  BTF_ID(struct, task_struct)
> > +#ifdef CONFIG_CRYPTO
> >  BTF_ID(struct, bpf_crypto_ctx)
> > +#endif
> >  BTF_SET_END(rcu_protected_types)
> >
> >  static bool rcu_protected_object(const struct btf *btf, u32 btf_id)
> > @@ -11529,8 +11533,10 @@ BTF_ID(func, bpf_rdonly_cast)
> >  BTF_ID(func, bpf_rbtree_remove)
> >  BTF_ID(func, bpf_rbtree_add_impl)
> >  BTF_ID(func, bpf_rbtree_first)
> > +#ifdef CONFIG_NET
> >  BTF_ID(func, bpf_dynptr_from_skb)
> >  BTF_ID(func, bpf_dynptr_from_xdp)
> > +#endif
> >  BTF_ID(func, bpf_dynptr_slice)
> >  BTF_ID(func, bpf_dynptr_slice_rdwr)
> >  BTF_ID(func, bpf_dynptr_clone)
> > @@ -11558,8 +11564,10 @@ BTF_ID(func, bpf_rcu_read_unlock)
> >  BTF_ID(func, bpf_rbtree_remove)
> >  BTF_ID(func, bpf_rbtree_add_impl)
> >  BTF_ID(func, bpf_rbtree_first)
> > +#ifdef CONFIG_NET
> >  BTF_ID(func, bpf_dynptr_from_skb)
> >  BTF_ID(func, bpf_dynptr_from_xdp)
> > +#endif
> >  BTF_ID(func, bpf_dynptr_slice)
> >  BTF_ID(func, bpf_dynptr_slice_rdwr)
> >  BTF_ID(func, bpf_dynptr_clone)
> >
> > ---
> > base-commit: 5d287a7de3c95b78946e71d17d15ec9c87fffe7f
> > change-id: 20241212-bpf-cond-ids-9bfbc64dd77b
> >
> > Best regards,
> > --
> > Thomas Weißschuh <linux@weissschuh.net>
> >

