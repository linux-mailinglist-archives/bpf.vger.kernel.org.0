Return-Path: <bpf+bounces-70851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75143BD6D77
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 02:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 398954F7B44
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 00:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0801C7261C;
	Tue, 14 Oct 2025 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFfTQus/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1130C3398A
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 00:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400656; cv=none; b=L78X+qeQFgSpqYa1uqetJCbFjrcqQglyHA4s50xU4PnG1nUIMbbR8THNch22uuF66a1t5oesU9/R+tU4FcUvAQXUjEhflamzriYQ+MlamR6HBf8KLRaf1av+R4LzNpXwGjGnU6ZjTxkbEBOYYta6HB8fpjXKbj225u18f2DQfxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400656; c=relaxed/simple;
	bh=8ru111iLduW/SQbvH1cBCdiF2qH6GRIYQ5yNIJbh204=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gy5WKCoNT/XHQBjYqKB0ZxxkN3EfsWAEOIOsrK0mqFjfsTALYkcnFx+hR5BlgjDBQlakSOkN4OvaxCKkipQPlXZ9dQKUr4bsZszi7frLzK9yyruyQLfakXmF1JhH7o9TDyzKHD1887l1wnrCMd7XN9yLx1e7tq1UpFqWZcU2vMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFfTQus/; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32ee4817c43so3791761a91.0
        for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 17:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760400654; x=1761005454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbcpRCJDEHo//qzyYOyiFq5QvBec4rDUzd8LJzXJAJA=;
        b=FFfTQus/T4vTnjK789ouEcL+NMu35HXXRqOzIkDClTX7sdQouWtUkc/WYcS/kJ+8Zq
         S2cqkCIMfhje38OkwYXGArNSd04tnDDKTyXg3nu8kDQCHST4aNCg/w3NC0+z9wyvcFIU
         l4Sq3lp7eJw+xfdb7zSyUd2Qu002AskN/T+ZZKmAZuDHrkKznBnihfz5YiAHrLPzITt0
         GDGiNR/zw8ZlW8Kv2mZXbAcNKa91tAsxy/KJwWKg1WcIBlG5DHuGoK2gWd45FtNdRyhh
         CroYC73ypL40AGj74MEKL59YPcWzEKvvIdn8UcTXbameCTjmHSopXy5kx1zQsIKOID1y
         n2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760400654; x=1761005454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbcpRCJDEHo//qzyYOyiFq5QvBec4rDUzd8LJzXJAJA=;
        b=PQbK9/13LgqHeN1XiK9qMZO+p16cMAH3ZCK9aOJajZgQ53lAFiG4atYAfR299NS19e
         TknoPDsM+nD7jaUB0sheKplxCuyNnuRx1NiPTIMHSy47ve21787rGPNO5KZYma4jQNzc
         fztBT36XeL+ia1HA1QkYHyfRG7xMrnGMewqgQnpQ1tULcFwhbpx8DgUaaxcp71peIE6Y
         Yv6+uEfcl5tTOEkLDA8BrbdjH+OX+8E9cLBir4WpfAp1au2AMs+0vLV8lM5YRKLHJUO0
         WFI1szs8qAlzi2RCn2LMTUWAlDLDmx5s7CWyvVIAc3wz1/HPwYt41bi+oYdm+tovEBr5
         kpuA==
X-Gm-Message-State: AOJu0YzadKN5eGVQWPxox3OSxkuOYc0qm7DbQ1bOGFaZUXE/FdwdplZP
	i5JKCNlNdp4JO4aTkaniXLVbZjU6Iqwszhm2OqRI+WZpfh+XHMySJWJjtVxns6rECoh/Xcu3c7B
	uFYSpOM5BbD6YdWUvZ8lh8kFWED2StIY=
X-Gm-Gg: ASbGnctDn2o2GOkv1PTMNXcrFpIe6iwHbSgW1BkXk5L7X3hb8agjOCo6IwRH2mX+3ZO
	Y/gblkOFYeHryPis0VLd7iDvLYDMcWB9wmofu1atq3Ua9p5IaXrxLHtC8F2tgNltewBeMCiyLMp
	FsbxQ4uGpF2Mt1Cr1cpy6701HejcDu8AthbhzlxiHoepN7Uc8GOWsppsr96+kYh20NevE28aEoy
	k5ZoM4+tl4qv1E8m6Y7vYN8MtcvTQMKSHkfRaz4gWs+L4D+RxKZ
X-Google-Smtp-Source: AGHT+IEWbZtzHpoOcDBxrMHzaXNIhPzZNIw2yHDxV7R5XpEk+lJFsx8p21+/tNZb5/tfUldRmHEAWgO0+Qhj5baRUWo=
X-Received: by 2002:a17:90b:3e83:b0:32e:23c9:6f41 with SMTP id
 98e67ed59e1d1-33b51676ef2mr30394459a91.5.1760400654171; Mon, 13 Oct 2025
 17:10:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010174953.2884682-1-ameryhung@gmail.com> <20251010174953.2884682-5-ameryhung@gmail.com>
In-Reply-To: <20251010174953.2884682-5-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 13 Oct 2025 17:10:37 -0700
X-Gm-Features: AS18NWBtihG1LV8irrv6A-cAtlchD8NblynvmTc5wUG5LCWQ3EPmJitiC7xs4Rw
Message-ID: <CAEf4BzYVn=TQnF-Wfum=eQG0PsKwzySow+WFjon8D_1624ZnDA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 bpf-next 4/4] selftests/bpf: Test
 BPF_STRUCT_OPS_ASSOCIATE_PROG command
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 10:50=E2=80=AFAM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> Test BPF_STRUCT_OPS_ASSOCIATE_PROG command that associates a BPF program
> with a struct_ops. The test follows the same logic in commit
> ba7000f1c360 ("selftests/bpf: Test multi_st_ops and calling kfuncs from
> different programs"), but instead of using map id to identify a specific
> struct_ops this test uses the new BPF command to associate a struct_ops
> with a program.
>
> The test consists of two set of almost identical struct_ops maps and BPF
> programs associated with the map. Their only difference is a unique value
> returned by bpf_testmod_multi_st_ops::test_1().
>
> The test first loads the programs and associates them with struct_ops
> maps. Then, the test exercises the BPF programs. They will in turn call
> kfunc bpf_kfunc_multi_st_ops_test_1_prog_arg() to trigger test_1()
> of the associated struct_ops map, and then check if the right unique
> value is returned.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  .../bpf/prog_tests/test_struct_ops_assoc.c    |  76 +++++++++++++
>  .../selftests/bpf/progs/struct_ops_assoc.c    | 105 ++++++++++++++++++
>  .../selftests/bpf/test_kmods/bpf_testmod.c    |  17 +++
>  .../bpf/test_kmods/bpf_testmod_kfunc.h        |   1 +
>  4 files changed, 199 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_op=
s_assoc.c
>  create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc.c
>

[...]

> +/* Call test_1() of the associated struct_ops map */
> +int bpf_kfunc_multi_st_ops_test_1_prog_arg(struct st_ops_args *args, voi=
d *aux__prog)
> +{
> +       struct bpf_prog_aux *prog_aux =3D (struct bpf_prog_aux *)aux__pro=
g;
> +       struct bpf_testmod_multi_st_ops *st_ops;
> +       int ret =3D -1;
> +
> +       st_ops =3D (struct bpf_testmod_multi_st_ops *)prog_aux->st_ops_as=
soc;

let's have internal helper API to fetch struct_ops association, this
will give us a bit more freedom in handling various edge cases (like
the poisoning I mentioned)


> +       if (st_ops)
> +               ret =3D st_ops->test_1(args);
> +
> +       return ret;
> +}
> +
>  static int multi_st_ops_reg(void *kdata, struct bpf_link *link)
>  {
>         struct bpf_testmod_multi_st_ops *st_ops =3D
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> index 4df6fa6a92cb..d40f4cddbd1e 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> @@ -162,5 +162,6 @@ struct task_struct *bpf_kfunc_ret_rcu_test(void) __ks=
ym;
>  int *bpf_kfunc_ret_rcu_test_nostruct(int rdonly_buf_size) __ksym;
>
>  int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id) __ks=
ym;
> +int bpf_kfunc_multi_st_ops_test_1_prog_arg(struct st_ops_args *args, voi=
d *aux__prog) __ksym;
>
>  #endif /* _BPF_TESTMOD_KFUNC_H */
> --
> 2.47.3
>

