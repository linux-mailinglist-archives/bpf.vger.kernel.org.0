Return-Path: <bpf+bounces-49699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8154AA1BC69
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 19:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38E23AFCF0
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 18:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DEF225A4D;
	Fri, 24 Jan 2025 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI8pZCg1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0175224B13;
	Fri, 24 Jan 2025 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737744528; cv=none; b=pe9Oj9rGXMG4JD0zfzI3dMLWlx2P8xHXCJXtWT5ebZhQxEBze+j/fANQSzuvnBFY4Dd/J0bOak4QfV9UqWi+2fP0GF9OFUXtoOBoSywrycbt6bya1LCOBNsjAfdsiLkL6/3aWwYsHbwrr75yGP7YB2xh8roACpCurHtCedn8av0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737744528; c=relaxed/simple;
	bh=t2jrwV2qaA/hR5Vbjel1mOsq6EI9Abj9i7LxzFFa3Tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skVFW/h1FUT7ntW+IAA85NFiMHiId7IVWUmL8qSBryEy6+0PRsurZaPmyaLzjzKXQZmZf95Ga5Q3hLDxEptoEORy5t9V5mq/2Vsu5v4k9FmA4BaXPLbFyAbIcetGQOGI/KW6PQ6O3jLByO5Il/vHRLuCzXxn8mBk9jy2YJ8NMRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lI8pZCg1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-219f8263ae0so46533985ad.0;
        Fri, 24 Jan 2025 10:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737744526; x=1738349326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDlkGyStUjhVyeXWIuO9MQx9bEB9H6t9IAYUl9OLKnM=;
        b=lI8pZCg1qqZ5st2qbZH84WgdnE24xOQfZCGUj6IleD/xfdBrO9DbKOh93e2DxUQOjS
         f8zkqzgS2tlWH0BCsxaqKBa4knLYZlqWw6CyzkSv+wsZBd94LRE0OQNRGc04NmVrWg32
         rvlzsh7v79lZMZycavPW1LPioHmtSxErh6yWAeWZTbVL7+J3FSPD0wpcpRaZ5+TIR3Jd
         p45v+0+zxW/3T8pGihgn8K6eYLpZo8pjXUuMdNE/1y5KNSK4yIsonHhiJRRvG6vdgS0u
         EwqLr4eitBF6bNQfVN6TeOS20plg53F6TnjOozIcLxrAuyijZJErMyktJcgl/zOVurl2
         VwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737744526; x=1738349326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDlkGyStUjhVyeXWIuO9MQx9bEB9H6t9IAYUl9OLKnM=;
        b=nayfIPHhrKHtfstKVAvJ4Ret3pCdE5KMa2fNmSfB3GfIv/ts7zEtc4fdaeEYnzYvuL
         +9UjJdjLfhyZFtp8FgHJczs0YZQLrvzlyo16qnbJtij6UXmRC6vr7HSLg5DIzy3InJih
         FTEpzh50p13eWP027p4eZUiE04gi7IZE9Xikin2Eep91MRZrj7q1c/i2vl+iefeLLsuC
         MJkNz2B21n/ewgN5MF/3/QIAldn5j3TE/GftdNbN1ZSUYBr7d4G8USGfVsIroShrPq0N
         /IoBB3TQRWfGk3dcHUJSr8kunpjnrzDKbXGXQVrL7vTCbic/9Lo7w6uRB3SS+CXZjMwR
         7iuA==
X-Forwarded-Encrypted: i=1; AJvYcCXRo8O9yR6YoFzptQx1FYVM2d2rTWpNHI3PdJggFYMDGmAMzOmRcRIXblyCG5t2kcTNtM2QwvcjPPkv/+o4@vger.kernel.org, AJvYcCXfZZvtVZnmrZlvb0blGzMDLVWK+au6jt7q9ZaWAVhdk4Qcdml290OhGDtL5Xi0oPUp3lw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3mCk8ElXlxJHcyxIOCtO6UslFWD5VunBqFGjQrxAjpMM4Nqay
	O+jGyM1JNNJtSh1w5J7jgan7Oh/Th5TLAKg3rSW1iP1/oxr6WLnIbk2gcJvv9nWL6oXCs3phZD/
	U2dmYgFjdMpE7zpM7d/gCTqAl2ek=
X-Gm-Gg: ASbGncuxx6cW8ptniWxCBMgOUzN3oSoiFIXfi9oCAiKr5LBZP6GZ498zlpI6OAehJPD
	djHuVsPvz5NxZzd1WmzCQCMlSC3J6HnodwJwRfQXX+HDghcNTblstb1CcTrPUGUEij9ZlBG09/J
	Kdhw==
X-Google-Smtp-Source: AGHT+IFYmdwSBrcklWMhdypGKXu531/qxmbqvUZ9wV3IqX4AJzeLLfy0ioWz9h9T4ixIv+MNCWK5IbB5HfW3QZUtIuc=
X-Received: by 2002:a05:6a00:ad8d:b0:72a:ae66:3050 with SMTP id
 d2e1a72fcca58-72daf931cd0mr41377084b3a.1.1737744525941; Fri, 24 Jan 2025
 10:48:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124144411.13468-1-chen.dylane@gmail.com> <20250124144411.13468-4-chen.dylane@gmail.com>
In-Reply-To: <20250124144411.13468-4-chen.dylane@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 24 Jan 2025 10:48:34 -0800
X-Gm-Features: AWEUYZnKSre_EaufkLBv1maStwAhi_iAdLwTLh9CTEr-Zq9Z0wqnIjBblfoTKBE
Message-ID: <CAEf4BzYP_xPUzFEbntzAA8JH1RQtiwdJHFUtNro04=jNAh9bvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: Add libbpf_probe_bpf_kfunc
 API selftests
To: Tao Chen <chen.dylane@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 6:44=E2=80=AFAM Tao Chen <chen.dylane@gmail.com> wr=
ote:
>
> Add selftests for prog_kfunc feature probing.
>  ./test_progs -t libbpf_probe_kfuncs
>  #153     libbpf_probe_kfuncs:OK
>  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/libbpf_probes.c  | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/too=
ls/testing/selftests/bpf/prog_tests/libbpf_probes.c
> index 4ed46ed58a7b..d9d69941f694 100644
> --- a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
> +++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
> @@ -126,3 +126,38 @@ void test_libbpf_probe_helpers(void)
>                 ASSERT_EQ(res, d->supported, buf);
>         }
>  }
> +
> +void test_libbpf_probe_kfuncs(void)
> +{
> +       int ret, kfunc_id;
> +       char *kfunc =3D "bpf_cpumask_create";
> +       struct btf *btf;
> +
> +       btf =3D btf__parse("/sys/kernel/btf/vmlinux", NULL);
> +       if (!ASSERT_OK_PTR(btf, "btf_parse"))
> +               return;
> +
> +       kfunc_id =3D btf__find_by_name_kind(btf, kfunc, BTF_KIND_FUNC);
> +       if (!ASSERT_GT(kfunc_id, 0, kfunc))
> +               goto cleanup;
> +
> +       /* prog BPF_PROG_TYPE_SYSCALL supports kfunc bpf_cpumask_create *=
/
> +       ret =3D libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_SYSCALL, kfunc_id, 0=
, NULL);
> +       ASSERT_EQ(ret, 1, kfunc);
> +
> +       /* prog BPF_PROG_TYPE_KPROBE does not support kfunc bpf_cpumask_c=
reate */
> +       ret =3D libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_KPROBE, kfunc_id, 0,=
 NULL);
> +       ASSERT_EQ(ret, 0, kfunc);
> +
> +       /* invalid kfunc id */
> +       ret =3D libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_KPROBE, -1, 0, NULL)=
;
> +       ASSERT_EQ(ret, 0, "invalid kfunc id:-1");
> +
> +       /* invalid prog type */
> +       ret =3D libbpf_probe_bpf_kfunc(100000, kfunc_id, 0, NULL);
> +       if (!ASSERT_LE(ret, 0, "invalid prog type:100000"))

we have ASSERT_ERR(), wouldn't it work here?


let's also add a test for kfunc in module (we have bpf_testmod, we
should be able to test something out of there)

> +               goto cleanup;
> +
> +cleanup:
> +       btf__free(btf);
> +}
> --
> 2.43.0
>

