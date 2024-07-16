Return-Path: <bpf+bounces-34873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ECC931E85
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 03:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E3A1C21FCA
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 01:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FB64405;
	Tue, 16 Jul 2024 01:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrnHvoCD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1D517C2
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 01:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721093729; cv=none; b=pX58CKl7QJnsH+mDFxx8hFA+wQYFR13WLiVh94cXBMIUFLQugSJLAPcpIGyGG9zSVz+eDaQEHUbzlVzkMbUj1lIhdU4AaotEWsJ+kYjqXwLlVNI04Z3IKw7++N67x2TDiAzq+bc1o9YN7cALTNaisDGlpXcRblv8wO4GR+7wp3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721093729; c=relaxed/simple;
	bh=70TJWkxUHtxTLcpDsOOIQNPnBAwoYGPZJmh/NcsXeqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bH5uEkbhjC0I//l1gJpV65aZcUf7kZla64z9umnwCgykMLbrbE3llIQp1o36YeMpcGtlY+4iVqCPy6kJodJ1ty+34JGecux/KTSZtDp/VcE7bMdzpepVtnbBEPzg6X5Rh3WVniXBLyweTF1H3Oex0iouh29ERXt3yOVPqWJs+EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrnHvoCD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4267345e746so33282955e9.0
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 18:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721093726; x=1721698526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ez23dOR7Pg1KJX/YiwW/ckrYpKg0Kv78orNtvahx4dg=;
        b=CrnHvoCD1WHD1nwkBKwwHqZZNkQ2Fo21rfetGouhKDcnoCinOt14LxbmsJNQ4gbaxy
         xobvEHOX0BA4jE5IwS2n+sVGhi1jMHXDwLMfe60MBi3gaL79YU3FMAkmJ7cwXP6fQYsj
         XoLW02RVSspWcu7dAH8Pws6WhEwsFOuliiEMtZ2ewzRL9tt9cX4qGY6WKmRies2fvGrr
         hp//aLn2hJ5QwO2PJwLA3dWYnRbQm3HXlOywJJb9o4xMg7Ys0IEnzW28yuZhjYSCVpNm
         pwdWudwpbIfkDFM9cCPzWZnlacUPFdsMXJwOWuZ8xO+M3YaZNk0ihuHE2ylc2g0x/1kf
         uhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721093726; x=1721698526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ez23dOR7Pg1KJX/YiwW/ckrYpKg0Kv78orNtvahx4dg=;
        b=RJZvvL96fKO5n7L1to6+axJlEavtzUZLFcNIVIxzOINLz0gA22bYCQuMEcW26fxlxP
         +QmWiKlXMH5BqLTGw2vwXODeZ47D5EadUirzEzvvkq9r42NOHpJLL73ZQDApa5EfTkAA
         9lmMe6ZZ+o+WSY6jBC2j+rGv8PgQlZ1X1APKxGWl58IU30WUs5gTKlekxGSSd1Tm63t8
         jglVdWm4OJvtKpcNXt6O3KNh8E2iEcWKFaV3X4ejdbimpR1d+cmpFJhTNu7Ia4jWc6qp
         /VHhNeoE7a/GQPHw8M0yq9lTRlj6aDv8nnH0hByW241/gg5UtdWfZvkJ750okaymGvhi
         0D2A==
X-Gm-Message-State: AOJu0YyoXNgYNKSizzpHINcqvhMs6LmpsBy3i10XPYBWqdfBvvug7+ed
	2oR6YupA7fhDhW9eabcWVSfZQehwiSJYwshk9j3qGbGVnb98Mlay2Q314+Rxckdb6lSgD0dAziJ
	gODpkwwLIIYxfJR0sPZQpgtMw0S8=
X-Google-Smtp-Source: AGHT+IGPiKC4JBAQyvaHlKdg1Dv+4eqkBb7B2pHNMVrnxeXRHIsbNbOpKaRXJjIVWY4QcR+6wY66oUifkdKxRAKMJhM=
X-Received: by 2002:a05:600c:4444:b0:426:6e8b:3dc5 with SMTP id
 5b1f17b1804b1-427ba7212damr3410625e9.32.1721093725512; Mon, 15 Jul 2024
 18:35:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716011647.811746-1-yonghong.song@linux.dev> <20240716011652.811985-1-yonghong.song@linux.dev>
In-Reply-To: <20240716011652.811985-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Jul 2024 18:35:14 -0700
Message-ID: <CAADnVQ+t0zEXwtrw9oCZN0bxOLTbNVkgz5u8yU+kqaTB3TL6bA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] [no_merge] selftests/bpf: Benchmark
 runtime performance with private stack
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 6:17=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> With 4096 loop ierations per program run, I got
>   $ perf record -- ./bench -w3 -d10 -a --nr-batch-iters=3D4096 no-private=
-stack
>     27.89%  bench    [kernel.vmlinux]                  [k] htab_map_hash
>     21.55%  bench    [kernel.vmlinux]                  [k] _raw_spin_lock
>     11.51%  bench    [kernel.vmlinux]                  [k] htab_map_delet=
e_elem
>     10.26%  bench    [kernel.vmlinux]                  [k] htab_map_updat=
e_elem
>      4.85%  bench    [kernel.vmlinux]                  [k] __pcpu_freelis=
t_push
>      4.34%  bench    [kernel.vmlinux]                  [k] alloc_htab_ele=
m
>      3.50%  bench    [kernel.vmlinux]                  [k] memcpy_orig
>      3.22%  bench    [kernel.vmlinux]                  [k] __pcpu_freelis=
t_pop
>      2.68%  bench    [kernel.vmlinux]                  [k] bcmp
>      2.52%  bench    [kernel.vmlinux]                  [k] __htab_map_loo=
kup_elem


so the prog itself is not even in the top 10 which means
that the test doesn't measure anything meaningful about the private
stack itself.
It just benchmarks hash map and overhead of extra push/pop is invisible.

> +SEC("tp/syscalls/sys_enter_getpgid")
> +int stack0(void *ctx)
> +{
> +       struct data_t key =3D {}, value =3D {};
> +       struct data_t *pvalue;
> +       int i;
> +
> +       hits++;
> +       key.d[10] =3D 5;
> +       value.d[8] =3D 10;
> +
> +       for (i =3D 0; i < batch_iters; i++) {
> +               pvalue =3D bpf_map_lookup_elem(&htab, &key);
> +               if (!pvalue)
> +                       bpf_map_update_elem(&htab, &key, &value, 0);
> +               bpf_map_delete_elem(&htab, &key);
> +       }

Instead of calling helpers that do a lot of work the test should
call global subprograms or noinline static functions that are nops.
Only then we might see the overhead of push/pop r9.

Once you do that you'll see that
+SEC("tp/syscalls/sys_enter_getpgid")
approach has too much overhead.
(you don't see right now since hashmap dominates).
Pls use an approach I mentioned earlier by fentry-ing into
a helper and another prog calling that helper in for() loop.

pw-bot: cr

