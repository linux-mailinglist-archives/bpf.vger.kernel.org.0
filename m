Return-Path: <bpf+bounces-52474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DC4A43256
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 02:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0DC172EF2
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 01:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712E81804A;
	Tue, 25 Feb 2025 01:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRksLa+W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BF04A1E;
	Tue, 25 Feb 2025 01:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740446164; cv=none; b=fdg0JgPx268OMmQVAO2JI1doiewUWssrux7zGd5K3InNJLagRV7S3ua8HgMQ8wYqUFNs1RAmdRsgqTALV1O4Mc5n56alAd5wCv0ZhZN88DsoG6FfkD/3Ig0kobkaOAjYOW3qcZyr/f878JIpYcD5bngwJoNSIEe9cZf4XNuzAYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740446164; c=relaxed/simple;
	bh=t1gnET2A70hG6HJyhk/vsVyvwX980CN9jnI6Y+3zPbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQ+N6q2aTLp7RY05sSYCeU3JUpyzuFgbPuic+HF19MprQ+drYCy+ou/0txdZCwCQ+F5CrPx9mzxTfLGxWg6GqbEu5WQ/40ww0IdEKR+e9O9Ah72ZK70C7dOUKsO5hnD0rf1zG1Np+64oh4aEBbhWPBbc+sfyvsvr8VvrXMcQlb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRksLa+W; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fbfa8c73a6so10071866a91.2;
        Mon, 24 Feb 2025 17:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740446161; x=1741050961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsk/eTDm0zjPW47QD1ZOKd0EGJEhmrE9B/Doyx3diaA=;
        b=kRksLa+WsaZ+AO/l42+ZTqrR2fGiok1kG8GqOWHvw4nYjBF93OeJ7XoeJyMvUKG4RL
         XfzNNuydu2QT54i1t6e52+VU6PJGIuBoOH8eUmaWG/G0tZ+3RgD0BnDGfNPNhh803/X+
         KpXTCcE5JSYfDnUvGRvmYiX78pp4qG8XIq7rd3+NFXp1XkjBz6nYW0HmazCp8oyd0Cl+
         IDftu+gTlBTIFcGbPze6El7oSElBTOSvmLV+OnDioYb1KWDA4j3GBfUc9ItTy2JhviuZ
         F/J5IzQn+m3Cpjehsu4jASIoplhU/CBAf8f0uQxYz3ibo1puReauT6fWXXZ2QAj5HxCz
         8Z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740446161; x=1741050961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsk/eTDm0zjPW47QD1ZOKd0EGJEhmrE9B/Doyx3diaA=;
        b=odup/h2+LJXDAnuPrWptBEKHr2iv3VwFUttpn6YjfPyuYpORtPFVCz72rZ47pQWggt
         f2pXSGuH3PjsyV3SyZwI/nRd4yUsQANiuqm8D806FW+QLcQGWg2gQVhHUq3zIWtKr0NK
         UFihGD+eDBtRqHPgrjGT7LL9gRCTBSUsCX4tumSyJbJPjJcshJA4jyOHXc9p4OWm6VQo
         51up4nfQO2WPbPgf/I62Z9VSnJOrGPPu8TNdRZOSYlLtojV5EpjMXVY91ahczqd/QuAp
         2unjX1HsALoV7AyN6x9obBoSEuVW1YG8/YFmpcxSlXIoa+fEev3UH6Hs3MJOB5BiImxG
         YPZA==
X-Forwarded-Encrypted: i=1; AJvYcCXPiQXsR74SC7J1rrO+Yu8OArVDx3BhezO+ZqHr6aiDrAS+ECm7MAyNrMTjAetYCy3j9Hk=@vger.kernel.org, AJvYcCXyYNnX3Lx+FNi1hIeH0xfT8KaYB1VZ87PbyjfgoBtb747jQ1gRtM+khddfl/rKfnmPAU1Bffozt4GUhMDa@vger.kernel.org
X-Gm-Message-State: AOJu0YyjkpJ+m+vwNEyPAQB63dHBW5bhKHyGBQoz34lVp5vtZIsv1WMT
	2nUtWjBs5v4Mr8k594KPAx4HSWF/vgT2LHJoTfvrJrMN6j/l4yXTMzUmX/llmR4/jayr5Ah4BZz
	zsTh2W+oTxb4Ns3OFkVi8FohQcYc=
X-Gm-Gg: ASbGncvBmwbxZaNgvSQ9mDEbe2tOlWu4I3tlEU+M433gYYlCdW+D3zbDjma47abimKM
	IruI1Ob/GXFvLm4tltIBZuc47V3k6eoPcJL1erZEFq0ntJEGkzDDmG1bmx7OA47FV1KzQ3sFMHj
	qybLfmihXze/XIREWy82jyk80=
X-Google-Smtp-Source: AGHT+IGkvEX45NcU/iLlBhLRsn0JRY38pe0rcs5WES3Ja/anotIZiWbYyndug96gHNjRvK+oO6RIAtD7n5lqt5rQw5A=
X-Received: by 2002:a17:90b:5148:b0:2fa:17dd:6afa with SMTP id
 98e67ed59e1d1-2fce86cdeddmr29021934a91.17.1740446161357; Mon, 24 Feb 2025
 17:16:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224165912.599068-1-chen.dylane@linux.dev> <20250224165912.599068-4-chen.dylane@linux.dev>
In-Reply-To: <20250224165912.599068-4-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Feb 2025 17:15:49 -0800
X-Gm-Features: AQ5f1JqnJhx4LSlsXgXIiqxNaQklUHwpi_k1rD2vZFpCXjLYWGm44svhHrFDo3U
Message-ID: <CAEf4BzYr9WzYbmyq8=nVETDqYvmYmObhD6x+_TQYpSUWxxGLLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 3/5] libbpf: Add libbpf_probe_bpf_kfunc API
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chen.dylane@gmail.com, 
	Tao Chen <dylane.chen@didiglobal.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 9:02=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> Similarly to libbpf_probe_bpf_helper, the libbpf_probe_bpf_kfunc
> used to test the availability of the different eBPF kfuncs on the
> current system.
>
> Cc: Tao Chen <dylane.chen@didiglobal.com>
> Reviewed-by: Jiri Olsa <jolsa@kernel.org>
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  tools/lib/bpf/libbpf.h        | 19 ++++++++++++-
>  tools/lib/bpf/libbpf.map      |  1 +
>  tools/lib/bpf/libbpf_probes.c | 51 +++++++++++++++++++++++++++++++++++
>  3 files changed, 70 insertions(+), 1 deletion(-)
>

[...]

> +       buf[0] =3D '\0';
> +       ret =3D probe_prog_load(prog_type, insns, insn_cnt, btf_fd >=3D 0=
 ? fd_array : NULL,
> +                             buf, sizeof(buf));
> +       if (ret < 0)
> +               return libbpf_err(ret);
> +
> +       if (ret > 0)
> +               return 1; /* assume supported */
> +
> +       /* If BPF verifier recognizes BPF kfunc but it's not supported fo=
r
> +        * given BPF program type, it will emit "calling kernel function
> +        * <name> is not allowed". If the kfunc id is invalid,
> +        * it will emit "kernel btf_id <id> is not a function". If BTF fd
> +        * invalid in module BTF, it will emit "invalid module BTF fd spe=
cified" or
> +        * "negative offset disallowed for kernel module function call". =
If
> +        * kfunc prog not dev buound, it will emit "metadata kfuncs requi=
re
> +        * device-bound program".
> +        */
> +       if (strstr(buf, "not allowed") || strstr(buf, "not a function") |=
|
> +          strstr(buf, "invalid module BTF fd") ||

why is invalid module BTF FD not an error (negative return)?

> +          strstr(buf, "negative offset disallowed") ||
> +          strstr(buf, "device-bound program"))
> +               return 0;
> +
> +       return 1;
> +}
> +
>  int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_=
id helper_id,
>                             const void *opts)
>  {
> --
> 2.43.0
>

