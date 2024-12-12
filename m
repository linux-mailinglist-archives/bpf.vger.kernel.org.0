Return-Path: <bpf+bounces-46760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFADD9F0023
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374CA16405D
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 23:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F59C1DF261;
	Thu, 12 Dec 2024 23:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NI6swt1K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF9C1DED67;
	Thu, 12 Dec 2024 23:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046047; cv=none; b=scVey70TjW8SmD4Y0kB34Sejxb+pySOH21qfaowjibnj0EiCzXbeTZe+YgYxoYjdvC0qCV97qdtzmQoSIb0thAGe911UdYieyFIuZzl7K4pTudyc14PFRNhrwCFdr5Q4+RZNc+CDBYEwfy8TPtTohjQNCHiR9p3il0rRe5QWJ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046047; c=relaxed/simple;
	bh=siMGMWAE8Yf88NqZHpeUacjij9uJS2w2C2rhJNA64JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1iRXMJ5owXf8Mk5phjpBOLs0jDAxjKrHCSuZknbMvy+wnczGZXFSoq94ALZDH6DqL5NfVhv61Kdri3Vv+IyIhs8FzL/+wI1ztjzYYWTnFLHGLN1PnXKXFCaIW2oA0anq+snqsg3CAeGNUHefbkWwLhbgY05PEV2HvEivFh3cGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NI6swt1K; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee786b3277so764444a91.1;
        Thu, 12 Dec 2024 15:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734046045; x=1734650845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wIxdZL8VA2ztTsjyWP0G/HNyQ8yWpTpN0liZa/AVYk=;
        b=NI6swt1KVK3xpX65lxtCU29K+KV3jK2c9ADUcURE0PjJ26YnDLBieuGf9UpnwNO7ga
         dy473ADerOTOEAaygWe3a3qcTOLEzEn6B2+etkpsbLkMIGDVw6JJ9IJkEqPnnIbOAnwO
         Rv4QrfVvezzIXuwRRtUDMLSeMvi9IP7RGeU3R5zkWbxBtd0pw6qNOnM21L4pbcAK+/ag
         U3hjns0A6L9EquWJIPJ0maK/iAVTwZGBy7DwOgshRWkhX7N4jgl5zxlS11DPDZlavO2x
         THRjcLZ4U05i1KKujE4LhYjjc5e1n5tKHTGeE4NacCyIbqPOY9Xm5aIyIoa04yvy8gb8
         hvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734046045; x=1734650845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wIxdZL8VA2ztTsjyWP0G/HNyQ8yWpTpN0liZa/AVYk=;
        b=qu4PfJ5p3uyqjnTxCtQWhxs+GDa+13JiJtStpSNBAaFrdJ1k8bwrmAEslYQeoEKroE
         JmfQlW1qR4CZ95z5Va/nQf8W/wBphPym3abbDlYsijNekIYip2m04+3XUaiDk3R35nqT
         uE3by6sNW/ueDph+vOfnVzdeIPdfm6Lu2obz3nOtW3db3oJTQcjNucTDeA+lzgrKYS+n
         2mSIyv34+XDMXjBAD/FGsRSUKYAxpeZQgNRuKamW9hoXQRPBV8hRvuYdX4XqHosA2n6R
         HJLkxstu/DUol6ZpRtf+GuT6NVm+i5UjQs74JL3LgJvsMqgh5tIOE9SfzBws5Jtxx0AO
         7Wig==
X-Forwarded-Encrypted: i=1; AJvYcCVlz0BafFbdT34e0sd32L1y/STsqF434Qr2fTl8XFC640qWouUxjcimojZU1Shb5q0NESY=@vger.kernel.org, AJvYcCWIbNQqEuyiBvmMvC2PaxqY0h04loCKAsNrHxm3ZC8Qfawai1f6tPNgJJIIyI/e4AY774Vf8PoM@vger.kernel.org, AJvYcCWSxiz3tspKTd4s7xqS2ZY8qj6jaKSUQEaYzbGmq8wYhF357dkrsnr5VQLoWrHk1CZwU3mRCvoBP+Y8pILD@vger.kernel.org
X-Gm-Message-State: AOJu0YxXhHeAKtCG1nOV7YUexS+M/jpPMc/ds2dJOFTevUvRlcAJnn0c
	56ipMQV0qnEng5Qwt3TLWRM28oVBKbddhEb0tOsLrkSKz0s99bSBGMQydRxHLa+EhziVNxHtHfe
	zQZcGC8vBRwTsA+FlepUct8RRQyLpcBfI
X-Gm-Gg: ASbGnctfjoCKBSZ9Tq6J2Qyp6t464hFPqNLVwQ+Anat4N3rI74HWsM5s9NOdEaS0qIU
	Fc4U4QF9tbeW5d46MItpglR7KtVinoEKnfxtJ+GviV5AqVEyvh9ikVg==
X-Google-Smtp-Source: AGHT+IEu8iZm+rKzmRx4CSwSfmZzDyUvwahx9BhW4CNesA7XsXp+wa9U3e8LZjZ3fy8UIZSod/hPcFSzkKj03f1H7Bc=
X-Received: by 2002:a17:90b:1647:b0:2ee:863e:9ffc with SMTP id
 98e67ed59e1d1-2f28fd6a55dmr751214a91.21.1734046045301; Thu, 12 Dec 2024
 15:27:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213-bpf-cond-ids-v1-1-881849997219@weissschuh.net>
In-Reply-To: <20241213-bpf-cond-ids-v1-1-881849997219@weissschuh.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Dec 2024 15:27:12 -0800
Message-ID: <CAEf4BzYTYDcf7J0jhJP3cW5489jWXdfJcw-f-8yuTHcNmQ0cbw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix configuration-dependent BTF function references
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 3:00=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> These BTF functions are not available unconditionally,
> only reference them when they are available.
>
> Avoid the following build warnings:
>
>   BTF     .tmp_vmlinux1.btf.o
> btf_encoder__tag_kfunc: failed to find kfunc 'bpf_send_signal_task' in BT=
F
> btf_encoder__tag_kfuncs: failed to tag kfunc 'bpf_send_signal_task'
>   NM      .tmp_vmlinux1.syms
>   KSYMS   .tmp_vmlinux1.kallsyms.S
>   AS      .tmp_vmlinux1.kallsyms.o
>   LD      .tmp_vmlinux2
>   NM      .tmp_vmlinux2.syms
>   KSYMS   .tmp_vmlinux2.kallsyms.S
>   AS      .tmp_vmlinux2.kallsyms.o
>   LD      vmlinux
>   BTFIDS  vmlinux
> WARN: resolve_btfids: unresolved symbol prog_test_ref_kfunc
> WARN: resolve_btfids: unresolved symbol bpf_crypto_ctx
> WARN: resolve_btfids: unresolved symbol bpf_send_signal_task
> WARN: resolve_btfids: unresolved symbol bpf_modify_return_test_tp
> WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_xdp
> WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_skb
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  kernel/bpf/helpers.c  | 4 ++++
>  kernel/bpf/verifier.c | 8 ++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 751c150f9e1cd7f56e6a2b68a7ebb4ae89a30d2d..5edf5436a7804816b7dcf1bbe=
f2624d71a985f20 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3089,7 +3089,9 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE=
 | KF_RCU | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_task_from_vpid, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_throw)
> +#ifdef CONFIG_BPF_EVENTS
>  BTF_ID_FLAGS(func, bpf_send_signal_task, KF_TRUSTED_ARGS)
> +#endif
>  BTF_KFUNCS_END(generic_btf_ids)
>
>  static const struct btf_kfunc_id_set generic_kfunc_set =3D {
> @@ -3135,7 +3137,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>  BTF_ID_FLAGS(func, bpf_dynptr_size)
>  BTF_ID_FLAGS(func, bpf_dynptr_clone)
> +#ifdef CONFIG_NET
>  BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
> +#endif

It makes little sense to have bpf_prog_test_run_tracing() and
bpf_modify_return_test_tp() depend on CONFIG_NET... It's just
historically where BPF_PROG_TEST_RUN functionality was implemented,
but it seems like we need to move bpf_prog_test_run_tracing() and
other tracing-related testing stuff into kernel/trace/bpf_trace.c or
somewhere under kernel/bpf/ (core.c? helpers.c?)

>  BTF_ID_FLAGS(func, bpf_wq_init)
>  BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
>  BTF_ID_FLAGS(func, bpf_wq_start)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5e541339b2f6d1870561033fd55cca7144db14bc..77bbf58418fee7533bce539c8=
e005d2342ee1a48 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5526,7 +5526,9 @@ static bool in_rcu_cs(struct bpf_verifier_env *env)
>
>  /* Once GCC supports btf_type_tag the following mechanism will be replac=
ed with tag check */
>  BTF_SET_START(rcu_protected_types)
> +#ifdef CONFIG_NET
>  BTF_ID(struct, prog_test_ref_kfunc)
> +#endif
>  #ifdef CONFIG_CGROUPS
>  BTF_ID(struct, cgroup)
>  #endif
> @@ -5534,7 +5536,9 @@ BTF_ID(struct, cgroup)
>  BTF_ID(struct, bpf_cpumask)
>  #endif
>  BTF_ID(struct, task_struct)
> +#ifdef CONFIG_CRYPTO
>  BTF_ID(struct, bpf_crypto_ctx)
> +#endif
>  BTF_SET_END(rcu_protected_types)
>
>  static bool rcu_protected_object(const struct btf *btf, u32 btf_id)
> @@ -11529,8 +11533,10 @@ BTF_ID(func, bpf_rdonly_cast)
>  BTF_ID(func, bpf_rbtree_remove)
>  BTF_ID(func, bpf_rbtree_add_impl)
>  BTF_ID(func, bpf_rbtree_first)
> +#ifdef CONFIG_NET
>  BTF_ID(func, bpf_dynptr_from_skb)
>  BTF_ID(func, bpf_dynptr_from_xdp)
> +#endif
>  BTF_ID(func, bpf_dynptr_slice)
>  BTF_ID(func, bpf_dynptr_slice_rdwr)
>  BTF_ID(func, bpf_dynptr_clone)
> @@ -11558,8 +11564,10 @@ BTF_ID(func, bpf_rcu_read_unlock)
>  BTF_ID(func, bpf_rbtree_remove)
>  BTF_ID(func, bpf_rbtree_add_impl)
>  BTF_ID(func, bpf_rbtree_first)
> +#ifdef CONFIG_NET
>  BTF_ID(func, bpf_dynptr_from_skb)
>  BTF_ID(func, bpf_dynptr_from_xdp)
> +#endif
>  BTF_ID(func, bpf_dynptr_slice)
>  BTF_ID(func, bpf_dynptr_slice_rdwr)
>  BTF_ID(func, bpf_dynptr_clone)
>
> ---
> base-commit: 5d287a7de3c95b78946e71d17d15ec9c87fffe7f
> change-id: 20241212-bpf-cond-ids-9bfbc64dd77b
>
> Best regards,
> --
> Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>

