Return-Path: <bpf+bounces-61168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E061DAE1C4D
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 15:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26AB188E673
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 13:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209B728A1F8;
	Fri, 20 Jun 2025 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSzT1qYB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE06E21C17D
	for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750426461; cv=none; b=E74Jdhcmv/de4kDhEme0txvXgngtLZr8kVmj8GUtK8py3FUxurEAqgjeTd1zztFdKzki1sg3NkRN2UnRuJ7FADdqi2rfJBSJwchziznic/qtvKhFc5bBqsLcrRLELnqZbrr6a3El+8T4LD5uPcS2Rh1P3kSYY6JnjVef4G4isx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750426461; c=relaxed/simple;
	bh=JoEQ+RxpiIsiSBSntjitQvPAr/6AkFTad9FmE4O/cd8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmcCJycP7AcBg8v7QxOA0B0Ok7WYHveHJ13121DpGseJof1sisIVOZCYrKibsqIDDWKcKP9ZJCDo/RUtwk5Jw3O7u6GgK71tVcJ41xya3ZYPJNzoNgf5+K6WkavCjGoH2AAI7cKHCfagXBxahWrVDok185br3UXY/n+VEdHnMHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSzT1qYB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso3622582a12.1
        for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 06:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750426457; x=1751031257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f1kFNlt1U1DzldcbQCX1kauyifm6nTsePebgqRZCyws=;
        b=FSzT1qYB2HN10rYoXSOjIoqaa88gcs3aVlB10MQGImEhKg9B3+6ax7VWtS8hZvny9o
         kFkhIGviv19nrayZLVHJp2WGZAQwvN/OZ1aNfQbS6GnAbYJ5F6QvV2cs/LAixbe8We3z
         QG3mLjNk4eCIpxFjlEkihC6bSTq9jo/BWLTPjcbSfV9QThFqeIV7ajj5kytKh0leFPCL
         dvHLzVtNFKUx/8PKIGsSWZx6LJu9zQIaCfbBIYhXhnQfwKoh3uVOIHIl/wPcbib7nO9+
         ju94NrElcV5cIoqYMNaQFbUVhOVbeuNTjN7n/exdVCRTcWkPmjtcVk3EUJSbbhyyNgOg
         Xvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750426457; x=1751031257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1kFNlt1U1DzldcbQCX1kauyifm6nTsePebgqRZCyws=;
        b=ZEaEfR3QydAmooAH3HbRjWe/S78+mTEtmhzmLiF6Sq5Jb6QHYiZBX3pxrz7NNtw7ce
         yITfzpb066fYUUbT6iWJ4+21MU17Axl66n0Qi9NfpJN8XELwjC00eAcwNQmUtskt3d3e
         nc2QVTDsct4lSiT1OxaBfHA1Huq1OXr7fsFQqoJ1PUWGJhHdpsO+yIvc9rjnDVRY0cl4
         PBGgBxd01UyRaKdlHNsB1J3Qt0ZE2CCBATpQscypVsfq4LoTiH4taGLey+t95C/qyZOF
         BavS/JBt5YwIBm0P+qvcBfX/+yHmDie3GVrBJlwcrGB+Gcm4oUnTE1ChV+ID7qzw1++n
         5JFA==
X-Forwarded-Encrypted: i=1; AJvYcCX3tXMgPCb5hmHi4ULbAA7JDz+D8B570R/3LvcVcyKjDMwh545ErcmEym4kS7u4qJ2lQFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYABHJwfZUdBpn8I9tCFNod9vX2o5NeT6XL0ajqayiXUAFsxtm
	LAZHmxudKtGh5KICn3PkfFzD9sz8hD8gJc5wfkz8KRXYTsby4JzFEl0/3mtPemqz
X-Gm-Gg: ASbGncvKcqaeuwQLi2o/Vm3zkxLCcdpMLEd3irxGFztMQmDi9pJJQnTbPoMKjcVGaI/
	ZlpIfWe5AKEIA6ZExYhJESHp2wCklEyrjXI5yTZjA+UYNvP+emCFZxbYof4HBbIrvnot+zcrcSI
	oCx4bV2OnaGmrk+Uea0+DWb0IBNNih5gMZ7Jorgc2K+S804zEES5mgdC2jnEqCCjkkyYk9Kk2yO
	Noa8vXugG3gh8ueDpTRMSnEXCmXwPnwopvh4i88lo+mvMHY1g6tNEX7EPdfdqhB/2dd5Bs0NJ7q
	fMlSgbtX8js8FsteIL5OIFGolqf+PPw1RcIg2X4n0AjUr9ygqg==
X-Google-Smtp-Source: AGHT+IHZuG6zGKHRlZ2FakWlwDQrIloEF08BZQYE0Md5SE5e2Phyczd+eXVSPw2He8RMGdy8Zcm13A==
X-Received: by 2002:a17:907:3f8d:b0:add:fa4e:8a61 with SMTP id a640c23a62f3a-ae057b929d9mr290023566b.38.1750426456680;
        Fri, 20 Jun 2025 06:34:16 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae05420a31dsm164499666b.170.2025.06.20.06.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 06:34:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 20 Jun 2025 15:34:14 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: add btf dedup test covering
 module BTF dedup
Message-ID: <aFVjVoafmmPeUqiz@krava>
References: <20250430134249.2451066-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430134249.2451066-1-alan.maguire@oracle.com>

On Wed, Apr 30, 2025 at 02:42:49PM +0100, Alan Maguire wrote:
> Recently issues were observed with module BTF deduplication failures
> [1].  Add a dedup selftest that ensures that core kernel types are
> referenced from split BTF as base BTF types.  To do this use bpf_testmod
> functions which utilize core kernel types, specifically
> 
> ssize_t
> bpf_testmod_test_write(struct file *file, struct kobject *kobj,
>                        struct bin_attribute *bin_attr,
>                        char *buf, loff_t off, size_t len);
> 
> __bpf_kfunc struct sock *bpf_kfunc_call_test3(struct sock *sk);
> 
> __bpf_kfunc void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb);
> 
> For each of these ensure that the types they reference -
> struct file, struct kobject, struct bin_attr etc - are in base BTF.
> Note that because bpf_testmod.ko is built with distilled base BTF
> the associated reference types - i.e. the PTR that points at a
> "struct file" - will be in split BTF.  As a result the test resolves
> typedef and pointer references and verifies the pointed-at or
> typedef'ed type is in base BTF.  Because we use BTF from
> /sys/kernel/btf/bpf_testmod relocation has occurred for the
> referenced types and they will be base - not distilled base - types.
> 
> For large-scale dedup issues, we see such types appear in split BTF and
> as a result this test fails.  Hence it is proposed as a test which will
> fail when large-scale dedup issues have occurred.
> 
> [1] https://lore.kernel.org/dwarves/CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com/
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

hi Alan,
this one started to fail in my tests.. it's likely some screw up in
my environment, but I haven't found the cause yet, I'm using the
pahole 1.30 .. just cheking if it's known issue already ;-)

thanks,
jirka


test_split_module:PASS:vmlinux_btf 0 nsec
test_split_module:PASS:nr_base_types 0 nsec
test_split_module:PASS:split_btf 0 nsec
test_split_module:PASS:func_id 0 nsec
test_split_module:PASS:func_id_type 0 nsec
test_split_module:PASS:func_proto_id_type 0 nsec
test_split_module:PASS:is_func_proto 0 nsec
test_split_module:PASS:param_ref_type 0 nsec
test_split_module:PASS:param_ref_type 0 nsec
test_split_module:FAIL:verify_base_type unexpected verify_base_type: actual 183322 >= expected 183225
#33/5    btf_dedup_split/split_module:FAIL
#33      btf_dedup_split:FAIL


> ---
>  .../bpf/prog_tests/btf_dedup_split.c          | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
> index d9024c7a892a..5bc15bb6b7ce 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
> @@ -440,6 +440,105 @@ static void test_split_dup_struct_in_cu()
>  	btf__free(btf1);
>  }
>  
> +/* Ensure module split BTF dedup worked correctly; when dedup fails badly
> + * core kernel types are in split BTF also, so ensure that references to
> + * such types point at base - not split - BTF.
> + *
> + * bpf_testmod_test_write() has multiple core kernel type parameters;
> + *
> + * ssize_t
> + * bpf_testmod_test_write(struct file *file, struct kobject *kobj,
> + *                        struct bin_attribute *bin_attr,
> + *                        char *buf, loff_t off, size_t len);
> + *
> + * Ensure each of the FUNC_PROTO params is a core kernel type.
> + *
> + * Do the same for
> + *
> + * __bpf_kfunc struct sock *bpf_kfunc_call_test3(struct sock *sk);
> + *
> + * ...and
> + *
> + * __bpf_kfunc void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb);
> + *
> + */
> +const char *mod_funcs[] = {
> +	"bpf_testmod_test_write",
> +	"bpf_kfunc_call_test3",
> +	"bpf_kfunc_call_test_pass_ctx"
> +};
> +
> +static void test_split_module(void)
> +{
> +	struct btf *vmlinux_btf, *btf1 = NULL;
> +	int i, nr_base_types;
> +
> +	vmlinux_btf = btf__load_vmlinux_btf();
> +	if (!ASSERT_OK_PTR(vmlinux_btf, "vmlinux_btf"))
> +		return;
> +	nr_base_types = btf__type_cnt(vmlinux_btf);
> +	if (!ASSERT_GT(nr_base_types, 0, "nr_base_types"))
> +		goto cleanup;
> +
> +	btf1 = btf__parse_split("/sys/kernel/btf/bpf_testmod", vmlinux_btf);
> +	if (!ASSERT_OK_PTR(btf1, "split_btf"))
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(mod_funcs); i++) {
> +		const struct btf_param *p;
> +		const struct btf_type *t;
> +		__u16 vlen;
> +		__u32 id;
> +		int j;
> +
> +		id = btf__find_by_name_kind(btf1, mod_funcs[i], BTF_KIND_FUNC);
> +		if (!ASSERT_GE(id, nr_base_types, "func_id"))
> +			goto cleanup;
> +		t = btf__type_by_id(btf1, id);
> +		if (!ASSERT_OK_PTR(t, "func_id_type"))
> +			goto cleanup;
> +		t = btf__type_by_id(btf1, t->type);
> +		if (!ASSERT_OK_PTR(t, "func_proto_id_type"))
> +			goto cleanup;
> +		if (!ASSERT_EQ(btf_is_func_proto(t), true, "is_func_proto"))
> +			goto cleanup;
> +		vlen = btf_vlen(t);
> +
> +		for (j = 0, p = btf_params(t); j < vlen; j++, p++) {
> +			/* bpf_testmod uses resilient split BTF, so any
> +			 * reference types will be added to split BTF and their
> +			 * associated targets will be base BTF types; for example
> +			 * for a "struct sock *" the PTR will be in split BTF
> +			 * while the "struct sock" will be in base.
> +			 *
> +			 * In some cases like loff_t we have to resolve
> +			 * multiple typedefs hence the while() loop below.
> +			 *
> +			 * Note that resilient split BTF generation depends
> +			 * on pahole version, so we do not assert that
> +			 * reference types are in split BTF, as if pahole
> +			 * does not support resilient split BTF they will
> +			 * also be base BTF types.
> +			 */
> +			id = p->type;
> +			do {
> +				t = btf__type_by_id(btf1, id);
> +				if (!ASSERT_OK_PTR(t, "param_ref_type"))
> +					goto cleanup;
> +				if (!btf_is_mod(t) && !btf_is_ptr(t) && !btf_is_typedef(t))
> +					break;
> +				id = t->type;
> +			} while (true);
> +
> +			if (!ASSERT_LT(id, nr_base_types, "verify_base_type"))
> +				goto cleanup;
> +		}
> +	}
> +cleanup:
> +	btf__free(btf1);
> +	btf__free(vmlinux_btf);
> +}
> +
>  void test_btf_dedup_split()
>  {
>  	if (test__start_subtest("split_simple"))
> @@ -450,4 +549,6 @@ void test_btf_dedup_split()
>  		test_split_fwd_resolve();
>  	if (test__start_subtest("split_dup_struct_in_cu"))
>  		test_split_dup_struct_in_cu();
> +	if (test__start_subtest("split_module"))
> +		test_split_module();
>  }
> -- 
> 2.39.3
> 

