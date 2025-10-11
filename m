Return-Path: <bpf+bounces-70777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABCCBCF59D
	for <lists+bpf@lfdr.de>; Sat, 11 Oct 2025 15:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20173189BFDB
	for <lists+bpf@lfdr.de>; Sat, 11 Oct 2025 13:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71970254855;
	Sat, 11 Oct 2025 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XMUogdy2"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FC9381AF
	for <bpf@vger.kernel.org>; Sat, 11 Oct 2025 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760188690; cv=none; b=nGN6A3P90UrsIsls+Dk5EeYg+x0rjPvzofQdnLVj5eY6VX4LDxd/efgs94kKWR8x+BnGOi61LM+eicPf2Bxu1ZEG6KuemUt4b5uYmXAVDVJt+idqKYHmhVOfMYE9sFKNep6lOOtG6+D4EoaCHTp1RshV8W5vDQUOSOoL+i/Mrgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760188690; c=relaxed/simple;
	bh=Ony5/Bpkn2oBoPDgSBbF67RL+Nu3ZIMShNT4v29e/Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2OV9e4PLYYtuAvePlLbfHVOEvvKfISX9dYfnvUzXdMCdg+Qw8pE9uwOkMqXKxv2l/+ou4n1rNZUULgNg49itx/n1XcQK5N9Rp45f2XRXlHNB5kkyhR5v7hxOpzdKJsl4mwvZLJmjUWFbnPBkPWPQ6iZGbFtySREYYlJRrFZ4vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XMUogdy2; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760188672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5u+nYW0O5RZTJkOhowOIKbnSOaMTa3H66LGagfABBEo=;
	b=XMUogdy2qYBTv7cdgdVhJEMKKthYjUkFkktP+ix0hWXAJSe+r5dWOmh4zlASNMSSH0TPc2
	/fhx6fgsDxZJV7YPZ3W2yxtigxpP2smFgbPkx9d4+WAqNmDa8nbTpejsPr/vci8nXLE2AG
	eP85TW4V3naGAKuZg+JGr3qo4i+6W+M=
From: Menglong Dong <menglong.dong@linux.dev>
To: Sahil Chandna <chandna.linuxkernel@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, david.hunter.linux@gmail.com,
 skhan@linuxfoundation.org, khalid@kernel.org, chandna.linuxkernel@gmail.com,
 syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Subject:
 Re: [PATCH v2] bpf: test_run: Use migrate_enable()/disable() universally
Date: Sat, 11 Oct 2025 21:17:24 +0800
Message-ID: <1935291.tdWV9SEqCh@7950hx>
In-Reply-To: <20251010075923.408195-1-chandna.linuxkernel@gmail.com>
References: <20251010075923.408195-1-chandna.linuxkernel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/10/10 15:59, Sahil Chandna wrote:
> The timer context can safely use migrate_disable()/migrate_enable()
> universally instead of conditional preemption or migration disabling.
> Previously, the timer was initialized in NO_PREEMPT mode by default,
> which disabled preemption and forced execution in atomic context.
> This caused issues on PREEMPT_RT configurations when invoking
> spin_lock_bh() =E2=80=94 a sleeping lock =E2=80=94 leading to the followi=
ng warning:
>=20
> BUG: sleeping function called from invalid context at kernel/locking/spin=
lock_rt.c:48
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6107, name: syz.0.=
17
> preempt_count: 1, expected: 0
> RCU nest depth: 1, expected: 1
> Preemption disabled at:
> [<ffffffff891fce58>] bpf_test_timer_enter+0xf8/0x140 net/bpf/test_run.c:42
>=20
> Reported-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D1f1fbecb9413cdbfbef8
> Tested-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
> Signed-off-by: Sahil Chandna <chandna.linuxkernel@gmail.com>
>=20
> ---
> Link to v1: https://lore.kernel.org/all/20251006054320.159321-1-chandna.l=
inuxkernel@gmail.com/
>=20
> Changes since v1:
> - Dropped `enum { NO_PREEMPT, NO_MIGRATE } mode` from `struct bpf_test_ti=
mer`.
> - Removed all conditional preempt/migrate disable logic.
> - Unified timer handling to use `migrate_disable()` / `migrate_enable()` =
universally.
>=20
> Testing:
> - Reproduced syzbot bug locally using the provided reproducer.
> - Observed `BUG: sleeping function called from invalid context` on v1.
> - Confirmed bug disappears after applying this patch.
> - Validated normal functionality of `bpf_prog_test_run_*` helpers with C
>   reproducer.
> ---
>  net/bpf/test_run.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>=20
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index dfb03ee0bb62..b23bc93e738e 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -29,7 +29,6 @@
>  #include <trace/events/bpf_test_run.h>
> =20
>  struct bpf_test_timer {
> -	enum { NO_PREEMPT, NO_MIGRATE } mode;
>  	u32 i;
>  	u64 time_start, time_spent;
>  };
> @@ -38,10 +37,7 @@ static void bpf_test_timer_enter(struct bpf_test_timer=
 *t)
>  	__acquires(rcu)
>  {
>  	rcu_read_lock();
> -	if (t->mode =3D=3D NO_PREEMPT)
> -		preempt_disable();
> -	else
> -		migrate_disable();
> +	migrate_disable();

Maybe we can use rcu_read_lock_dont_migrate/rcu_read_unlock_migrate
here instead, which has better performance :)

Thanks!
Menglong Dong

> =20
>  	t->time_start =3D ktime_get_ns();
>  }
> @@ -50,11 +46,7 @@ static void bpf_test_timer_leave(struct bpf_test_timer=
 *t)
>  	__releases(rcu)
>  {
>  	t->time_start =3D 0;
> -
> -	if (t->mode =3D=3D NO_PREEMPT)
> -		preempt_enable();
> -	else
> -		migrate_enable();
> +	migrate_enable();
>  	rcu_read_unlock();
>  }
> =20
> @@ -374,7 +366,7 @@ static int bpf_test_run_xdp_live(struct bpf_prog *pro=
g, struct xdp_buff *ctx,
> =20
>  {
>  	struct xdp_test_data xdp =3D { .batch_size =3D batch_size };
> -	struct bpf_test_timer t =3D { .mode =3D NO_MIGRATE };
> +	struct bpf_test_timer t;
>  	int ret;
> =20
>  	if (!repeat)
> @@ -404,7 +396,7 @@ static int bpf_test_run(struct bpf_prog *prog, void *=
ctx, u32 repeat,
>  	struct bpf_prog_array_item item =3D {.prog =3D prog};
>  	struct bpf_run_ctx *old_ctx;
>  	struct bpf_cg_run_ctx run_ctx;
> -	struct bpf_test_timer t =3D { NO_MIGRATE };
> +	struct bpf_test_timer t;
>  	enum bpf_cgroup_storage_type stype;
>  	int ret;
> =20
> @@ -1377,7 +1369,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_pro=
g *prog,
>  				     const union bpf_attr *kattr,
>  				     union bpf_attr __user *uattr)
>  {
> -	struct bpf_test_timer t =3D { NO_PREEMPT };
> +	struct bpf_test_timer t;
>  	u32 size =3D kattr->test.data_size_in;
>  	struct bpf_flow_dissector ctx =3D {};
>  	u32 repeat =3D kattr->test.repeat;
> @@ -1445,7 +1437,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_pro=
g *prog,
>  int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_a=
ttr *kattr,
>  				union bpf_attr __user *uattr)
>  {
> -	struct bpf_test_timer t =3D { NO_PREEMPT };
> +	struct bpf_test_timer t;
>  	struct bpf_prog_array *progs =3D NULL;
>  	struct bpf_sk_lookup_kern ctx =3D {};
>  	u32 repeat =3D kattr->test.repeat;
>=20





