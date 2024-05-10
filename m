Return-Path: <bpf+bounces-29448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EABC8C2188
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 12:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12A51C20C67
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 10:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B21D165FA2;
	Fri, 10 May 2024 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4rr4N9q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7D04AEFA
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335386; cv=none; b=qRaOEH52CGZSAmc1u8xysF060KSoYeLJccevPS+WBSUhCHk7Q2Lt0FsV4AUsig7whtcOmisMFwF/MiPeXoOh3PqijSZjra1tHkRzCFVmV5Ik3H3RziucvmVJidxxslYNhGAyolWjIXHo6Lpotkj5BPos7PApBRkVB5CuPX0fzck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335386; c=relaxed/simple;
	bh=vuHgo1yvtJh1M4VkhFpsTiX1K7ghbdnypE/Dv6V62Q4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F6qND2UNkrvhZuHAEecuCYeyn/DT8Z0BalfTl/7G0TxTnelFoL+o01zwZwPbc3Z3uPZQom0shjt/AF50bo/Itx4HHioqBjYr+8JQl9sbVqR7Q7C0oVcIAn1apqIRc8P46AXTDQvBh/1fFcop63O3w1dfcn+O3xsatZ2YRYMEmMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4rr4N9q; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f44dc475f4so1558375b3a.2
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 03:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715335384; x=1715940184; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NF0NyWJzIYv5FSEOS0xM0W0/B46Ete1BO5jXjSJuDzM=;
        b=S4rr4N9qkE83VC0rN5xwEHsTCeoN1a9iKd9TCaPkra3XgMq30+FQ0FU2tKhyeCezHC
         yrloi+pu0eYmQH88mqAKO3Efxb5ZzdLBz9yMB2VFBIWjwHzgeN9PfcvExmWV+eKMF1Gk
         iSlvG7EE727rXe1een8AkyFrllLwmmipNYrnPVB3kLPTdf3O9X3qmZpO+njE9OWEQZgE
         s1mgg7jdQIiGY9dOSybSqSkhcH3y1s7mBiodiO+7I9CmalL1Xlm8z+1dKLW7Yt/w8VPw
         piJhORq9Z5FH5lPWXxlgLxMkHiJNoR5Xt3yUOkyvz/IpUgSfoVxidh4dlLAsGe6VNEbb
         ulmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715335384; x=1715940184;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NF0NyWJzIYv5FSEOS0xM0W0/B46Ete1BO5jXjSJuDzM=;
        b=h3KJJePlLkRXjF7BSx83H1dlhwUt7EAK664Rq/TL+ljs+E7T3WRg3+zYNbZG9+tRiZ
         Kvi+YrOvMolmjIK1D5BsUA3J6fQ5dtSpKS9uDF+TugbwTv2k6bbe+jLVJv5b4lyvNy1D
         Oc5QFXcpNh+763vyOIuLclZcraIoguYA+IrbjjJB+i4N9HcL47QrKhwFvW/7oA44st2Y
         wr34wY4vaA16oeU1M483Wfm4Fl9SbQXws96rtmSkJvAWJwTc0458Dji6qclRy1OPlouq
         9iwB4dpWWqUTmqICHUiP9I3l39cc+u50Qzjxo4nGqHdL2kZ1XdW1xjl8SpWkrO6DZTgj
         MnTg==
X-Forwarded-Encrypted: i=1; AJvYcCX7TYAFhPOZZdmyB+HMJ2b8Oy+sUvrY+cOB3umWevsF3FvMfiOoWPaLsFqtE5ZLbjrQbPV67LpPaK7g6iX/TA2/Ppip
X-Gm-Message-State: AOJu0YxtjHkGR6Q2GTkJA9NQgJk+Mx1MYXe7L73ETv7SjFd4OdrJ/+aG
	gEcIjUzLS18Se5Wvqmchb1A222FGlS/2ZxoXBAhiqITPTlWEPFhHkdg7Eg==
X-Google-Smtp-Source: AGHT+IGggV4OrGWOT3MKs1dg20msu3keLfkcXsTD1TxWPE0meAC4dwVe4JpgPUl3TCR6ToesaYj4PA==
X-Received: by 2002:a05:6a20:3945:b0:1af:6a37:3b8a with SMTP id adf61e73a8af0-1afde0e20demr2922966637.16.1715335384399;
        Fri, 10 May 2024 03:03:04 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a449e0esm2685183a12.13.2024.05.10.03.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 03:03:04 -0700 (PDT)
Message-ID: <d8f2fa21a9af5bfcb2acb1addecea435285c40e6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 7/9] selftests/bpf: Test kptr arrays and
 kptrs in nested struct fields.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org,  martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com
Date: Fri, 10 May 2024 03:03:02 -0700
In-Reply-To: <20240510011312.1488046-8-thinker.li@gmail.com>
References: <20240510011312.1488046-1-thinker.li@gmail.com>
	 <20240510011312.1488046-8-thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-05-09 at 18:13 -0700, Kui-Feng Lee wrote:
> Make sure that BPF programs can declare global kptr arrays and kptr field=
s
> in struct types that is the type of a global variable or the type of a
> nested descendant field in a global variable.
>=20
> An array with only one element is special case, that it treats the elemen=
t
> like a non-array kptr field. Nested arrays are also tested to ensure they
> are handled properly.
>=20
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/cpumask.c        |   5 +
>  .../selftests/bpf/progs/cpumask_success.c     | 133 ++++++++++++++++++
>  2 files changed, 138 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c b/tools/tes=
ting/selftests/bpf/prog_tests/cpumask.c
> index ecf89df78109..2570bd4b0cb2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cpumask.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
> @@ -18,6 +18,11 @@ static const char * const cpumask_success_testcases[] =
=3D {
>  	"test_insert_leave",
>  	"test_insert_remove_release",
>  	"test_global_mask_rcu",
> +	"test_global_mask_array_one_rcu",
> +	"test_global_mask_array_rcu",
> +	"test_global_mask_array_l2_rcu",
> +	"test_global_mask_nested_rcu",
> +	"test_global_mask_nested_deep_rcu",
>  	"test_cpumask_weight",
>  };
> =20
> diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/=
testing/selftests/bpf/progs/cpumask_success.c
> index 7a1e64c6c065..0b6383fa9958 100644
> --- a/tools/testing/selftests/bpf/progs/cpumask_success.c
> +++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
> @@ -12,6 +12,25 @@ char _license[] SEC("license") =3D "GPL";
> =20
>  int pid, nr_cpus;
> =20
> +struct kptr_nested {
> +	struct bpf_cpumask __kptr * mask;
> +};
> +
> +struct kptr_nested_mid {
> +	int dummy;
> +	struct kptr_nested m;
> +};
> +
> +struct kptr_nested_deep {
> +	struct kptr_nested_mid ptrs[2];
> +};

For the sake of completeness, would it be possible to create a test
case where there are several struct arrays following each other?
E.g. as below:

struct foo {
  ... __kptr *a;
  ... __kptr *b;
}

struct bar {
  ... __kptr *c;
}

struct {
  struct foo foos[3];
  struct bar bars[2];
}

Just to check that offset is propagated correctly.

Also, in the tests below you check that a pointer to some object could
be put into an array at different indexes. Tbh, I find it not very
interesting if we want to check that offsets are correct.
Would it be possible to create an array of object kptrs,
put specific references at specific indexes and somehow check which
object ended up where? (not necessarily 'bpf_cpumask').

> +
> +private(MASK) static struct bpf_cpumask __kptr * global_mask_array[2];
> +private(MASK) static struct bpf_cpumask __kptr * global_mask_array_l2[2]=
[1];
> +private(MASK) static struct bpf_cpumask __kptr * global_mask_array_one[1=
];
> +private(MASK) static struct kptr_nested global_mask_nested[2];
> +private(MASK) static struct kptr_nested_deep global_mask_nested_deep;
> +
>  static bool is_test_task(void)
>  {
>  	int cur_pid =3D bpf_get_current_pid_tgid() >> 32;
> @@ -460,6 +479,120 @@ int BPF_PROG(test_global_mask_rcu, struct task_stru=
ct *task, u64 clone_flags)
>  	return 0;
>  }
> =20
> +SEC("tp_btf/task_newtask")
> +int BPF_PROG(test_global_mask_array_one_rcu, struct task_struct *task, u=
64 clone_flags)
> +{
> +	struct bpf_cpumask *local, *prev;
> +
> +	if (!is_test_task())
> +		return 0;
> +
> +	/* Kptr arrays with one element are special cased, being treated
> +	 * just like a single pointer.
> +	 */
> +
> +	local =3D create_cpumask();
> +	if (!local)
> +		return 0;
> +
> +	prev =3D bpf_kptr_xchg(&global_mask_array_one[0], local);
> +	if (prev) {
> +		bpf_cpumask_release(prev);
> +		err =3D 3;
> +		return 0;
> +	}
> +
> +	bpf_rcu_read_lock();
> +	local =3D global_mask_array_one[0];
> +	if (!local) {
> +		err =3D 4;
> +		bpf_rcu_read_unlock();
> +		return 0;
> +	}
> +
> +	bpf_rcu_read_unlock();
> +
> +	return 0;
> +}
> +
> +static int _global_mask_array_rcu(struct bpf_cpumask **mask0,
> +				  struct bpf_cpumask **mask1)
> +{
> +	struct bpf_cpumask *local;
> +
> +	if (!is_test_task())
> +		return 0;
> +
> +	/* Check if two kptrs in the array work and independently */
> +
> +	local =3D create_cpumask();
> +	if (!local)
> +		return 0;
> +
> +	bpf_rcu_read_lock();
> +
> +	local =3D bpf_kptr_xchg(mask0, local);
> +	if (local) {
> +		err =3D 1;
> +		goto err_exit;
> +	}
> +
> +	/* [<mask 0>, NULL] */
> +	if (!*mask0 || *mask1) {
> +		err =3D 2;
> +		goto err_exit;
> +	}
> +
> +	local =3D create_cpumask();
> +	if (!local) {
> +		err =3D 9;
> +		goto err_exit;
> +	}
> +
> +	local =3D bpf_kptr_xchg(mask1, local);
> +	if (local) {
> +		err =3D 10;
> +		goto err_exit;
> +	}
> +
> +	/* [<mask 0>, <mask 1>] */
> +	if (!*mask0 || !*mask1 || *mask0 =3D=3D *mask1) {
> +		err =3D 11;
> +		goto err_exit;
> +	}
> +
> +err_exit:
> +	if (local)
> +		bpf_cpumask_release(local);
> +	bpf_rcu_read_unlock();
> +	return 0;
> +}
> +
> +SEC("tp_btf/task_newtask")
> +int BPF_PROG(test_global_mask_array_rcu, struct task_struct *task, u64 c=
lone_flags)
> +{
> +	return _global_mask_array_rcu(&global_mask_array[0], &global_mask_array=
[1]);
> +}
> +
> +SEC("tp_btf/task_newtask")
> +int BPF_PROG(test_global_mask_array_l2_rcu, struct task_struct *task, u6=
4 clone_flags)
> +{
> +	return _global_mask_array_rcu(&global_mask_array_l2[0][0], &global_mask=
_array_l2[1][0]);
> +}
> +
> +SEC("tp_btf/task_newtask")
> +int BPF_PROG(test_global_mask_nested_rcu, struct task_struct *task, u64 =
clone_flags)
> +{
> +	return _global_mask_array_rcu(&global_mask_nested[0].mask, &global_mask=
_nested[1].mask);
> +}
> +
> +SEC("tp_btf/task_newtask")
> +int BPF_PROG(test_global_mask_nested_deep_rcu, struct task_struct *task,=
 u64 clone_flags)
> +{
> +	return _global_mask_array_rcu(&global_mask_nested_deep.ptrs[0].m.mask,
> +				      &global_mask_nested_deep.ptrs[1].m.mask);
> +}
> +
>  SEC("tp_btf/task_newtask")
>  int BPF_PROG(test_cpumask_weight, struct task_struct *task, u64 clone_fl=
ags)
>  {


