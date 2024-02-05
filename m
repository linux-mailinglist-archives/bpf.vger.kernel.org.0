Return-Path: <bpf+bounces-21224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55020849B35
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 13:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C088280E96
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 12:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9812D047;
	Mon,  5 Feb 2024 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVQ8JuAr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8FD2D022
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137775; cv=none; b=EU4CH9GnIbCH5TGUPeDjp1jPv3sipMkCxykFZfqJbUcJ1c78tJno2P3rVYMQejDntjCJlEiOGj++HtuylPrjgR5weJpAzEVf6/uPvzU2YB6ul1Dt9ELHqDI6NZ8j+rMeHNuBf4Wo+6ICcJKkFpjubHxbsnRaE5BLtckyp7iHxxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137775; c=relaxed/simple;
	bh=4mmDbUgjaqjmq99AwXxJh7E78+7WVAUkFHPAyBDAyjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8jqmNMeCcGKRRA9BxFuPRUaPxD1E/U+8pQQ4H5kGAg16fOh0kmqhX9A3b3h+xQUc/fs4sAJnHzprXpX/kHbJEQaP0ff7mhazH/C3vg5H9pALdSFSrjA6TpNiywS9pdP4f9q/6z/WcUu8jU/bXMspSrtGOTFF4Xj8+wPoqInO8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVQ8JuAr; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42bf8f26673so18056871cf.2
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 04:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707137773; x=1707742573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcu1+a9rod/cPAA0Nzzsv61IU496Jt/rUq/7x6B4wO4=;
        b=AVQ8JuArFTEYNv62frs35r7Si8QZxdsszLS4I7OaTsn8JgNF63w7dHDVaFqinDA5dI
         Jr6ubaGSXzlmYlGWI98MR5oRy0AqfON/sdkq8UTJFKrDGJ3Is9wOFcvcO3VXOz8st8JV
         w2ltYwSaI4J2FWBHYkq2B2Hzx1BAePaaQFBh6zwnKkn4L3coJKzZ5q/O/EYvDsW+Cd0j
         NXC62dZWdw2F+hMtWs4wRtZPtbozjjAUp/4Id6WjnxDAO4FYSAqQ94jsDhAOF7p+FSXn
         3MzVckrY1cS680JJSrmtFB1t3VYbOgufCjN4s+QoO6frytg/gMS/v0EpH/xEPJ3n99JW
         ivxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137773; x=1707742573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcu1+a9rod/cPAA0Nzzsv61IU496Jt/rUq/7x6B4wO4=;
        b=Y6MV2JpfELQ2aFPDkikwuTcTpRUNZ1f0ASc3xvk+Xr3RLpyLs6wlNrQT7ty54wEtlY
         MAw/8n+35KPmViNQczFt99N2GB6pl4goJiqAwlJ5GU4HqdjL+0aeziJwRUnoaFI5mhAh
         G4bgYnjYKfsVxWCxSol+3B+qdogIRDlnREyJC7JpDUkmHxweMLJzx0FwcKO/qm3VZoM+
         uBtw9E2keaZNs93qa4bjwogb7huIquwo5QrbQys4H9VNGNQ0L2p5rx2c/tPy5yV5RpAy
         3Zs1Wj/TfVuFQa2J5dcczdAVE+esbztp6In2XpJ7OaUKiNcLzliSd/NtK9AfwpcwIBPj
         sIbw==
X-Gm-Message-State: AOJu0YzgWdPFhfYrITccy9yBAHp3KURViQ6qXH+29lhestIVrPgRvuLq
	x90yKEFsBQmpVzp8zgl5TCz3o+r4+J+TCh4WCd2xgugf9QOLAbGHX28+F44A5vBaIWkmtF/Gw/k
	8o6F6ibdkbj1K1Jq3Hqetvmv1V9E=
X-Google-Smtp-Source: AGHT+IFYKhLe2Q3ieh0LZgp8EDSjFmbmf+8FRWRcOEkZtPvC2wnyUDSFOWwWCUwZsnYDvOQp1FJkoF6oQIPTVlc3YoQ=
X-Received: by 2002:a0c:f294:0:b0:68c:8b5c:9d29 with SMTP id
 k20-20020a0cf294000000b0068c8b5c9d29mr5773955qvl.62.1707137772852; Mon, 05
 Feb 2024 04:56:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205055646.1112186-1-memxor@gmail.com> <20240205055646.1112186-3-memxor@gmail.com>
In-Reply-To: <20240205055646.1112186-3-memxor@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 5 Feb 2024 20:55:36 +0800
Message-ID: <CALOAHbBt4WDvLzQkevmsFwDDeMo8WGhLJF4wdvqtQog6JCnFag@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for RCU lock
 transfer between subprogs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 1:56=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> Add selftests covering the following cases:
> - A static or global subprog called from within a RCU read section works
> - A static subprog taking an RCU read lock which is released in caller wo=
rks
> - A static subprog releasing the caller's RCU read lock works
>
> Global subprogs that leave the lock in an imbalanced state will not
> work, as they are verified separately, so ensure those cases fail as
> well.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-and-Tested-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  .../selftests/bpf/prog_tests/rcu_read_lock.c  |   6 +
>  .../selftests/bpf/progs/rcu_read_lock.c       | 120 ++++++++++++++++++
>  2 files changed, 126 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c b/too=
ls/testing/selftests/bpf/prog_tests/rcu_read_lock.c
> index 3f1f58d3a729..a1f7e7378a64 100644
> --- a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
> +++ b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
> @@ -29,6 +29,10 @@ static void test_success(void)
>         bpf_program__set_autoload(skel->progs.non_sleepable_1, true);
>         bpf_program__set_autoload(skel->progs.non_sleepable_2, true);
>         bpf_program__set_autoload(skel->progs.task_trusted_non_rcuptr, tr=
ue);
> +       bpf_program__set_autoload(skel->progs.rcu_read_lock_subprog, true=
);
> +       bpf_program__set_autoload(skel->progs.rcu_read_lock_global_subpro=
g, true);
> +       bpf_program__set_autoload(skel->progs.rcu_read_lock_subprog_lock,=
 true);
> +       bpf_program__set_autoload(skel->progs.rcu_read_lock_subprog_unloc=
k, true);
>         err =3D rcu_read_lock__load(skel);
>         if (!ASSERT_OK(err, "skel_load"))
>                 goto out;
> @@ -75,6 +79,8 @@ static const char * const inproper_region_tests[] =3D {
>         "inproper_sleepable_helper",
>         "inproper_sleepable_kfunc",
>         "nested_rcu_region",
> +       "rcu_read_lock_global_subprog_lock",
> +       "rcu_read_lock_global_subprog_unlock",
>  };
>
>  static void test_inproper_region(void)
> diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/te=
sting/selftests/bpf/progs/rcu_read_lock.c
> index 14fb01437fb8..ab3a532b7dd6 100644
> --- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
> +++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
> @@ -319,3 +319,123 @@ int cross_rcu_region(void *ctx)
>         bpf_rcu_read_unlock();
>         return 0;
>  }
> +
> +__noinline
> +static int static_subprog(void *ctx)
> +{
> +       volatile int ret =3D 0;
> +
> +       if (bpf_get_prandom_u32())
> +               return ret + 42;
> +       return ret + bpf_get_prandom_u32();
> +}
> +
> +__noinline
> +int global_subprog(u64 a)
> +{
> +       volatile int ret =3D a;
> +
> +       return ret + static_subprog(NULL);
> +}
> +
> +__noinline
> +static int static_subprog_lock(void *ctx)
> +{
> +       volatile int ret =3D 0;
> +
> +       bpf_rcu_read_lock();
> +       if (bpf_get_prandom_u32())
> +               return ret + 42;
> +       return ret + bpf_get_prandom_u32();
> +}
> +
> +__noinline
> +int global_subprog_lock(u64 a)
> +{
> +       volatile int ret =3D a;
> +
> +       return ret + static_subprog_lock(NULL);
> +}
> +
> +__noinline
> +static int static_subprog_unlock(void *ctx)
> +{
> +       volatile int ret =3D 0;
> +
> +       bpf_rcu_read_unlock();
> +       if (bpf_get_prandom_u32())
> +               return ret + 42;
> +       return ret + bpf_get_prandom_u32();
> +}
> +
> +__noinline
> +int global_subprog_unlock(u64 a)
> +{
> +       volatile int ret =3D a;
> +
> +       return ret + static_subprog_unlock(NULL);
> +}
> +
> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> +int rcu_read_lock_subprog(void *ctx)
> +{
> +       volatile int ret =3D 0;
> +
> +       bpf_rcu_read_lock();
> +       if (bpf_get_prandom_u32())
> +               ret +=3D static_subprog(ctx);
> +       bpf_rcu_read_unlock();
> +       return 0;
> +}
> +
> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> +int rcu_read_lock_global_subprog(void *ctx)
> +{
> +       volatile int ret =3D 0;
> +
> +       bpf_rcu_read_lock();
> +       if (bpf_get_prandom_u32())
> +               ret +=3D global_subprog(ret);
> +       bpf_rcu_read_unlock();
> +       return 0;
> +}
> +
> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> +int rcu_read_lock_subprog_lock(void *ctx)
> +{
> +       volatile int ret =3D 0;
> +
> +       ret +=3D static_subprog_lock(ctx);
> +       bpf_rcu_read_unlock();
> +       return 0;
> +}
> +
> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> +int rcu_read_lock_global_subprog_lock(void *ctx)
> +{
> +       volatile int ret =3D 0;
> +
> +       ret +=3D global_subprog_lock(ret);
> +       bpf_rcu_read_unlock();
> +       return 0;
> +}
> +
> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> +int rcu_read_lock_subprog_unlock(void *ctx)
> +{
> +       volatile int ret =3D 0;
> +
> +       bpf_rcu_read_lock();
> +       ret +=3D static_subprog_unlock(ctx);
> +       return 0;
> +}
> +
> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> +int rcu_read_lock_global_subprog_unlock(void *ctx)
> +{
> +       volatile int ret =3D 0;
> +
> +       bpf_rcu_read_lock();
> +       ret +=3D global_subprog_unlock(ret);
> +       return 0;
> +}
> --
> 2.40.1
>


--=20
Regards
Yafang

