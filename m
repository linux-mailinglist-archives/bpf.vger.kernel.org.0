Return-Path: <bpf+bounces-13353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 023477D89B3
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 22:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251751C20F74
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 20:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2241C3D3A5;
	Thu, 26 Oct 2023 20:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgQ9ZCFI"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450F73D39F
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 20:31:24 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5ED191
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 13:31:21 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so218933766b.3
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 13:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698352280; x=1698957080; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M4u2RN6yVjB7NMIu08qT8DFavijYaX5GAOUrwnke4kA=;
        b=jgQ9ZCFIB2NA21GVQUlyHNzgvgWAAoI1/aHgAX87wkwW8A3bFACH0aPjeVDLPMLdYy
         XdB2PYNQEuKccontlJdAaWvj6gsZx1WtJg+TeYMd+vC1nLw9V82fjpC29hNTaqwuQsdf
         CHEcH5Moio54GFQQwo82sm9MjtIz7odoviXZ/Y+X050d7jbJorIZnYF1pfjgL+AlhVgN
         XL4+YnDrEL7+acc0vHFXD/pMQpce1klwvlc1F6wqR5Su/iXuovpG1OKVFaCG08ZSI+eQ
         Vziox2BLaulWATcYuZg8CIXTmCX1o/FgKGUDnV77uGUtk3XRKZidT78P1kxzVxFWurSX
         sSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698352280; x=1698957080;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M4u2RN6yVjB7NMIu08qT8DFavijYaX5GAOUrwnke4kA=;
        b=w0/PcIEri6Je5icWPxrnsi8F6/hnNThNLDEAxxgcaQ5TNzj0LY2ZnPgtPDlgcV5fO0
         eaVCjz63bcw49QUQX+7I7IT0k9+xzj6WmBoIan33NxZkVjXqzHLWAspB9WrSebMOv/LO
         npK1VPndT4dkaHMbXla/26Q9b8cx6pbB4wYGvRPyZNzmYTNkg0LYRU9YNHuuekFAX9A3
         wZ4APV3nWkoXwtd2M5nMgddPQnizD462RgsvEL8l37Xp4ePIAIkbVKchzdz48IDkf6Xk
         ydt57Cc74MrqlJwCIjzJzfQ+Uop7C43i3Zfeq0vz7+q24G3gEpVZVAFIMHLf9k1Eru4y
         bKcQ==
X-Gm-Message-State: AOJu0YzDGHdq4DCcv3JzHxFFH48Xz2mvIw+5m0vXj7AyTDQHKRKlAvLv
	UixJveWZ3YhNfCJzo7tGEC0=
X-Google-Smtp-Source: AGHT+IEMmDBDIidLrE+wYtlLUFj7ykB5c3C6R7D0lYGHz6Dqwu4PSq4s9W9+e5EsUUgEax68A/pN9w==
X-Received: by 2002:a17:906:7308:b0:9ae:6a51:87c3 with SMTP id di8-20020a170906730800b009ae6a5187c3mr587270ejc.9.1698352279571;
        Thu, 26 Oct 2023 13:31:19 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z13-20020a1709060acd00b009b947aacb4bsm113449ejf.191.2023.10.26.13.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 13:31:18 -0700 (PDT)
Message-ID: <abd76cd234ab2a1185bb9557fa54013264df6a50.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 10/10] selftests/bpf: test case for
 register_bpf_struct_ops().
From: Eduard Zingerman <eddyz87@gmail.com>
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org, 
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org,  drosen@google.com
Cc: sinquersw@gmail.com, kuifeng@meta.com
Date: Thu, 26 Oct 2023 23:31:12 +0300
In-Reply-To: <20231022050335.2579051-11-thinker.li@gmail.com>
References: <20231022050335.2579051-1-thinker.li@gmail.com>
	 <20231022050335.2579051-11-thinker.li@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-10-21 at 22:03 -0700, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
>=20
> Create a new struct_ops type called bpf_testmod_ops within the bpf_testmo=
d
> module. When a struct_ops object is registered, the bpf_testmod module wi=
ll
> invoke test_2 from the module.
>=20
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>

Hello,

Sorry for the late response, was moving through the patch-set very slowly.
Please note that CI currently fails for this series [0], reported error is:

testing_helpers.c:13:10: fatal error: 'rcu_tasks_trace_gp.skel.h' file not =
found
   13 | #include "rcu_tasks_trace_gp.skel.h"
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~

I get the same error when try to run tests locally (after full clean).
On the other hand it looks like `kern_sync_rcu_tasks_trace` changes
are not really necessary, when I undo these changes but keep changes in:

- .../selftests/bpf/bpf_testmod/bpf_testmod.c
- .../selftests/bpf/bpf_testmod/bpf_testmod.h
- .../bpf/prog_tests/test_struct_ops_module.c
- .../selftests/bpf/progs/struct_ops_module.c

struct_ops_module/regular_load test still passes.

Regarding assertion:

> +	ASSERT_EQ(skel->bss->test_2_result, 7, "test_2_result");

Could you please leave a comment explaining why the value is 7?
I don't understand what invokes 'test_2' but changing it to 8
forces test to fail, so something does call 'test_2' :)

Also, when running test_maps I get the following error:

libbpf: bpf_map_create_opts has non-zero extra bytes
map_create_opts(317):FAIL:bpf_map_create() error:Invalid argument (name=3Dh=
ash_of_maps)

[0] https://patchwork.kernel.org/project/netdevbpf/patch/20231022050335.257=
9051-11-thinker.li@gmail.com/
    (look for 'Logs for x86_64-gcc / build / build for x86_64 with gcc ')

> ---
>  tools/testing/selftests/bpf/Makefile          |  2 +
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 59 +++++++++++++++++++
>  .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  5 ++
>  .../bpf/prog_tests/test_struct_ops_module.c   | 38 ++++++++++++
>  .../selftests/bpf/progs/struct_ops_module.c   | 30 ++++++++++
>  tools/testing/selftests/bpf/testing_helpers.c | 35 +++++++++++
>  6 files changed, 169 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_op=
s_module.c
>  create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_module.c
>=20
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index caede9b574cb..dd7ff14e1fdf 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -706,6 +706,8 @@ $(OUTPUT)/uprobe_multi: uprobe_multi.c
>  	$(call msg,BINARY,,$@)
>  	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
> =20
> +$(OUTPUT)/testing_helpers.o: $(OUTPUT)/rcu_tasks_trace_gp.skel.h
> +
>  EXTRA_CLEAN :=3D $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)=
	\
>  	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
>  	feature bpftool							\
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index cefc5dd72573..f1a20669d884 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2020 Facebook */
> +#include <linux/bpf.h>
>  #include <linux/btf.h>
>  #include <linux/btf_ids.h>
>  #include <linux/error-injection.h>
> @@ -517,11 +518,66 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unuse=
d_arg)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
>  BTF_SET8_END(bpf_testmod_check_kfunc_ids)
> =20
> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> +
> +DEFINE_STRUCT_OPS_VALUE_TYPE(bpf_testmod_ops);
> +
> +static int bpf_testmod_ops_init(struct btf *btf)
> +{
> +	return 0;
> +}
> +
> +static bool bpf_testmod_ops_is_valid_access(int off, int size,
> +					    enum bpf_access_type type,
> +					    const struct bpf_prog *prog,
> +					    struct bpf_insn_access_aux *info)
> +{
> +	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
> +}
> +
> +static int bpf_testmod_ops_init_member(const struct btf_type *t,
> +				       const struct btf_member *member,
> +				       void *kdata, const void *udata)
> +{
> +	return 0;
> +}
> +
>  static const struct btf_kfunc_id_set bpf_testmod_kfunc_set =3D {
>  	.owner =3D THIS_MODULE,
>  	.set   =3D &bpf_testmod_check_kfunc_ids,
>  };
> =20
> +static const struct bpf_verifier_ops bpf_testmod_verifier_ops =3D {
> +	.is_valid_access =3D bpf_testmod_ops_is_valid_access,
> +};
> +
> +static int bpf_dummy_reg(void *kdata)
> +{
> +	struct bpf_testmod_ops *ops =3D kdata;
> +	int r;
> +
> +	BTF_STRUCT_OPS_TYPE_EMIT(bpf_testmod_ops);
> +	r =3D ops->test_2(4, 3);
> +
> +	return 0;
> +}
> +
> +static void bpf_dummy_unreg(void *kdata)
> +{
> +}
> +
> +struct bpf_struct_ops bpf_bpf_testmod_ops =3D {
> +	.verifier_ops =3D &bpf_testmod_verifier_ops,
> +	.init =3D bpf_testmod_ops_init,
> +	.init_member =3D bpf_testmod_ops_init_member,
> +	.reg =3D bpf_dummy_reg,
> +	.unreg =3D bpf_dummy_unreg,
> +	.name =3D "bpf_testmod_ops",
> +	.owner =3D THIS_MODULE,
> +};
> +
> +#endif /* CONFIG_DEBUG_INFO_BTF_MODULES */
> +
>  extern int bpf_fentry_test1(int a);
> =20
>  static int bpf_testmod_init(void)
> @@ -532,6 +588,9 @@ static int bpf_testmod_init(void)
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_=
testmod_kfunc_set);
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_te=
stmod_kfunc_set);
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_te=
stmod_kfunc_set);
> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> +	ret =3D ret ?: register_bpf_struct_ops(&bpf_bpf_testmod_ops);
> +#endif
>  	if (ret < 0)
>  		return ret;
>  	if (bpf_fentry_test1(0) < 0)
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
> index f32793efe095..ca5435751c79 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
> @@ -28,4 +28,9 @@ struct bpf_iter_testmod_seq {
>  	int cnt;
>  };
> =20
> +struct bpf_testmod_ops {
> +	int (*test_1)(void);
> +	int (*test_2)(int a, int b);
> +};
> +
>  #endif /* _BPF_TESTMOD_H */
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_modul=
e.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> new file mode 100644
> index 000000000000..7261fc6c377a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +#include <time.h>
> +
> +#include "rcu_tasks_trace_gp.skel.h"
> +#include "struct_ops_module.skel.h"
> +
> +static void test_regular_load(void)
> +{
> +	struct struct_ops_module *skel;
> +	struct bpf_link *link;
> +	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
> +	int err;
> +
> +	skel =3D struct_ops_module__open_opts(&opts);
> +	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
> +		return;
> +	err =3D struct_ops_module__load(skel);
> +	if (!ASSERT_OK(err, "struct_ops_module_load"))
> +		return;
> +
> +	link =3D bpf_map__attach_struct_ops(skel->maps.testmod_1);
> +	ASSERT_OK_PTR(link, "attach_test_mod_1");
> +
> +	ASSERT_EQ(skel->bss->test_2_result, 7, "test_2_result");
> +
> +	bpf_link__destroy(link);
> +
> +	struct_ops_module__destroy(skel);
> +}
> +
> +void serial_test_struct_ops_module(void)
> +{
> +	if (test__start_subtest("regular_load"))
> +		test_regular_load();
> +}
> +
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tool=
s/testing/selftests/bpf/progs/struct_ops_module.c
> new file mode 100644
> index 000000000000..cb305d04342f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "../bpf_testmod/bpf_testmod.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +int test_2_result =3D 0;
> +
> +SEC("struct_ops/test_1")
> +int BPF_PROG(test_1)
> +{
> +	return 0xdeadbeef;
> +}
> +
> +SEC("struct_ops/test_2")
> +int BPF_PROG(test_2, int a, int b)
> +{
> +	test_2_result =3D a + b;
> +	return a + b;
> +}
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops testmod_1 =3D {
> +	.test_1 =3D (void *)test_1,
> +	.test_2 =3D (void *)test_2,
> +};
> +
> diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testin=
g/selftests/bpf/testing_helpers.c
> index 8d994884c7b4..05870cd62458 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.c
> +++ b/tools/testing/selftests/bpf/testing_helpers.c
> @@ -10,6 +10,7 @@
>  #include "test_progs.h"
>  #include "testing_helpers.h"
>  #include <linux/membarrier.h>
> +#include "rcu_tasks_trace_gp.skel.h"
> =20
>  int parse_num_list(const char *s, bool **num_set, int *num_set_len)
>  {
> @@ -380,10 +381,44 @@ int load_bpf_testmod(bool verbose)
>  	return 0;
>  }
> =20
> +/* This function will trigger call_rcu_tasks_trace() in the kernel */
> +static int kern_sync_rcu_tasks_trace(void)
> +{
> +	struct rcu_tasks_trace_gp *rcu;
> +	time_t start;
> +	long gp_seq;
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +
> +	rcu =3D rcu_tasks_trace_gp__open_and_load();
> +	if (IS_ERR(rcu))
> +		return -EFAULT;
> +	if (rcu_tasks_trace_gp__attach(rcu))
> +		return -EFAULT;
> +
> +	gp_seq =3D READ_ONCE(rcu->bss->gp_seq);
> +
> +	if (bpf_prog_test_run_opts(bpf_program__fd(rcu->progs.do_call_rcu_tasks=
_trace),
> +				   &opts))
> +		return -EFAULT;
> +	if (opts.retval !=3D 0)
> +		return -EFAULT;
> +
> +	start =3D time(NULL);
> +	while ((start + 2) > time(NULL) &&
> +	       gp_seq =3D=3D READ_ONCE(rcu->bss->gp_seq))
> +		sched_yield();
> +
> +	rcu_tasks_trace_gp__destroy(rcu);
> +
> +	return 0;
> +}
> +
>  /*
>   * Trigger synchronize_rcu() in kernel.
>   */
>  int kern_sync_rcu(void)
>  {
> +	if (kern_sync_rcu_tasks_trace())
> +		return -EFAULT;
>  	return syscall(__NR_membarrier, MEMBARRIER_CMD_SHARED, 0, 0);
>  }


